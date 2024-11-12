Return-Path: <linux-kernel+bounces-405700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284BC9C55FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEC31F2570E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5021E109;
	Tue, 12 Nov 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI9dYNl+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB22144DD;
	Tue, 12 Nov 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408592; cv=none; b=n7sVMa97aONK75kbszA/bO8UD0l1AhlfBdPn/L6enjf+h6rX9oMgFVgIgCtBOufarRMyAFZs/tAba1bjGHQGlwjWHlYVQDaCs4Fx3lmyackxzsJGeCFfYAhJCTjd62FftFntmKp5Enyk/IO2+U5xiS8JujJTLVImVlox/eW41GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408592; c=relaxed/simple;
	bh=AtPXSJPOS66+Z5FHOSHA1nto8ZK/kyNSpsSHLrWs5/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fr2F/PwD0VCvAHlvaHMfqtEGOupdn3uBZnBnqYaDV5pcVZ4e9buycYgAM428znyLlQTi8XHio3Gx6lsb512uAjXRKe3uSO9Algp7dZmWEF4DmGAjNN8evrchB5OQkPUTwWqPI/KOCSi+W3ctoilj9Uf/9VZGj99EPfSXzMYPD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI9dYNl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A38C4CECD;
	Tue, 12 Nov 2024 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731408592;
	bh=AtPXSJPOS66+Z5FHOSHA1nto8ZK/kyNSpsSHLrWs5/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jI9dYNl+802YiW4J0l1PW1syhvy0C6CqZQaqDv5cf+Y1uPv2SM9/YA3SYrCP+PJ1Z
	 UjWJm5JMkK1vHp+r/LD+gYTV7PcQU52+qZkDQhe+j0rpzsn8p6wmYtLwAynTPd677c
	 8zQhHjIO6GraT6ocD85fIMUMhHk3p80PPa6bx10j1l0PEhzzd/xuYDmgX4KP+pVcdN
	 n6otmQkWWC8SqddI8N26WpIXsgoNOtXvNoBe/eaFrsUgzA/fgKMcInl6DrGbitheFU
	 CjMTAKTcqWTSVUF0EaW9GcOS5zqGEPFkz91iZLylJ7faMNuNKhdJRTQcj+PABX8jBz
	 4XY61Hy3AMAHg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] rust: arc: split unsafe block, add missing comment
In-Reply-To: <20241110-borrow-mut-v4-3-053976068215@gmail.com> (Tamir
	Duberstein's message of "Sun, 10 Nov 2024 09:14:04 -0500")
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
	<GyQMlmsMJztS8VRmtonRm9SXHamrxnnho2wrVDFQ0D1DBpZPHYlXktSItEjQko7-4annfwtJXhbXWeMtQaFz4w==@protonmail.internalid>
	<20241110-borrow-mut-v4-3-053976068215@gmail.com>
Date: Tue, 12 Nov 2024 11:09:49 +0100
Message-ID: <871pzgsqz6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> The new SAFETY comment style is taken from existing comments in `deref`
> and `drop.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



