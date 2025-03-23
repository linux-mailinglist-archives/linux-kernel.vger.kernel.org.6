Return-Path: <linux-kernel+bounces-572975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE1A6D107
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 21:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8260A3AFA18
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207FC1A23A4;
	Sun, 23 Mar 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMUj9nxe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3DD145B3E;
	Sun, 23 Mar 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742761196; cv=none; b=D7zs2JjzIdgA5pjqhVrt9TwQCNf4lU4xfOmicpQXuRfGvHPR11zX8rz4SThv1mwiUE8/RPuZbcwxdGGWw3XP0p3j1UaSxQUdEnRgB1eaI2Mh//UQamCknqUDXRh9IaBsOu4CpgHjhbp6TFtqJ7xf3QFBq1EtPzcuo7l32Y/CJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742761196; c=relaxed/simple;
	bh=xhUPi/g2/yskLtrdaoNGXPYU+I4iMKmTmti4et33U90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wnrn9/Zjc5BLb9AtEAWC0iRCUGeDbM2Dlqp0AeC4AlPwXChGBpkwGsNRLzlIhe/ZJVIr/mz/ivp+oJ3VBR1KbzW8bz+0TPbdW+MbcZcifOADAI5a3qWbI4eD99lKKx1DfMqFxp8Ru8F0ZESAhVY4io/uYCDMdPnj/6H1xv+JpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMUj9nxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69B1C4CEE2;
	Sun, 23 Mar 2025 20:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742761195;
	bh=xhUPi/g2/yskLtrdaoNGXPYU+I4iMKmTmti4et33U90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KMUj9nxe9JACll85SbGAzE37bk7VdMn07IuNFJndd4YeoP0e89dy4uat2AMtLoRW4
	 IiqjqsVW9RenL8s0IBeOnyMhEsIzA5xGanuHzZ/QEg4rPYltWrbC0O/A2CuetrBUge
	 1RHPYG2EtDSKT9u0P0xJb5oYS298D7QGcisUDQf0IuYWQpadhwN3jbO7oC1UjDf/iK
	 ijw7NlLnQWVtNPwHFmAFcfBLLssVOVPPX99GmDGZ9zKRK9MlGEy8hKWHvsowAn6ktz
	 zXM3hqPsadJgYcqI+SvdHWzPAheX+4RPdiALSYsqVVEYPgXhn8bGRwLaJVbwrMIYms
	 CtbfczImv4QmA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Asahi Lina" <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/4] New trait OwnableRefCounted for ARef<->Owned
 conversion.
In-Reply-To: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me> (Oliver Mangold's
	message of "Thu, 13 Mar 2025 06:59:57 +0000")
References: <GwULoA3hxsCsNdxJ4lw7WqNC5bhCMacx5xMre9hZV2GWDdYmQx9rYVzHadna4KGiko3Glypv-AeXUsoECQB-EA==@protonmail.internalid>
	<20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sun, 23 Mar 2025 21:19:35 +0100
Message-ID: <87sen37b54.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Oliver,

Thanks for sending this!

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> This allows to convert between ARef<T> and Owned<T> by
> implementing the new trait OwnedRefCounted.
>
> This way we will have a shared/unique reference counting scheme
> for types with built-in refcounts in analogy to Arc/UniqueArc.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>

[...]

> ---
> base-commit: 4b2ee22fe32ea9b255926effbb6f26450607c391
> change-id: 20250305-unique-ref-29fcd675f9e9

I think you based the diff on a commit in one of my trees. It does not
apply cleanly to upstream. Could you rebase this on something like
v6.14-rc7?


Best regards,
Andreas Hindborg




