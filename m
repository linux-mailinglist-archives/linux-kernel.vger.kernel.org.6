Return-Path: <linux-kernel+bounces-568749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB7FA69A14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A73189F7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24702214200;
	Wed, 19 Mar 2025 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt9iWFZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796881B0F20;
	Wed, 19 Mar 2025 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415400; cv=none; b=p2bZjghhz1fZUZtgY0QV9gQSsYIecdTF475MnxdsnlWTzsgfqVN8/VWu/Ma2+c0xwWfMnqj/wMYq0DOcDPUqfYbctOLtVab35lYIZDEq8UZyWH11XL9vZt9Ui4NLT0v2QD9pu31ztemN1NLQOlnYXVaV8S/MVrdSRml0FAne398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415400; c=relaxed/simple;
	bh=nz5Sorhb4ps7kptLjC/ZGul4mOFCsLRQTWZ0j3Yv2IE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ESWtYV/qywjt18pJPXZYc3rAHuMROje/+s7UFkXRcXWywnzfFVSZr242QD9bfgYt+oKWIKZeSTcBRFwNN1RCbNMWiMxA7FExpFKH/C7xlQkxLUHQ51Ci7l9IPB1sfYxQfEJKwqMAE5E5dkoKLoBRvsbp1XsFSS59XKIWxyOdUZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt9iWFZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F28C4CEE4;
	Wed, 19 Mar 2025 20:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742415399;
	bh=nz5Sorhb4ps7kptLjC/ZGul4mOFCsLRQTWZ0j3Yv2IE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Kt9iWFZkWXaex7mWHax18ZZ53kp9CUm7trX4T4TuDW7phABDZtkEJUwJ0lv/gutRh
	 mp4bQTPEZVhTZaPRc0IvZscB2J8UQeP2TCeDPiBWqQvit4Dsnu81Q9whty1HwQhrPK
	 rGBbJo/FtCYkDx1w0w9d162UACDAiunTq+0BABjC3NUPsyCQM5oxaSVqPG8sifUcvc
	 T2DYTOX/yYRtssK5Wv4TEFT0tGssVZ7rtzuumbFI39ZPCOKxz1AT0rMPQL87mTcSW0
	 KqKb5wSdRuA5rUcXifcybXj7/Ij4MgQ49mzVz7FHUadxdwxW99axCDZKa03JCOpA0c
	 3eV4DvE5vdk1w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Alexander Viro"
 <viro@zeniv.linux.org.uk>,  "Arnd Bergmann" <arnd@arndb.de>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Benno Lossin" <benno.lossin@proton.me>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Danilo Krummrich" <dakr@kernel.org>,  "Matthew
 Maurer" <mmaurer@google.com>,  "Lee Jones" <lee@kernel.org>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 5/5] samples: rust_misc_device: Expand the sample to
 support read()ing from userspace
In-Reply-To: <20250311-iov-iter-v1-5-f6c9134ea824@google.com> (Alice Ryhl's
	message of "Tue, 11 Mar 2025 14:25:16 +0000")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<Tfm4k4u95E5X-U3bEYcGAPbGrFqPmDV3F-MsJkvz9QST_luT89M_m27RzR2UG7ajOcfH83xsMIG6KxRWtk4Bwg==@protonmail.internalid>
	<20250311-iov-iter-v1-5-f6c9134ea824@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 21:11:16 +0100
Message-ID: <87bjtwg4rf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> From: Lee Jones <lee@kernel.org>
>
> A userland application can now operate on the char device with read() in
> order to consume a locally held buffer.  Memory for the buffer is to be
> provisioned and the buffer populated in its subsequently provided
> write() counterpart.
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



