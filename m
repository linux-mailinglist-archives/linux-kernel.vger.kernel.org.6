Return-Path: <linux-kernel+bounces-552643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CC2A57C2D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C77169C56
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6231E51F9;
	Sat,  8 Mar 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="lZ+/Olul"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88FDDC5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452980; cv=none; b=BL4uVyNcxc1RGE4b53pD+OW4ynz3pxsZjiB/ovKm+lP709QGIYrkibQeMOet8wheooKE+JD3v4pscGv5tb5QCsTnU1jJYvoMaj6T/BL9URFAujthOBOo62u1BHJpmayh6IpYBTrzoonSjLa8rPBtwKRmcvA81MwdxXaZpCdxWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452980; c=relaxed/simple;
	bh=eSuxg2xuBFkjSqo6vPYUms50Awq/A17AtOYbqoQmGbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BDSutylq5ERQfZjLdVhv2IAT2eDrzD7fg/sDWjHnMP8tw16a1BQn+pFxZIA+wyfQSn8zDU3XpVTn4m/Hp5RMKtl3eOqeX21h2C9pI8xo6Y0E0b6r4UnpHiQ926AQHZuWO5ZkpxitnhEJmObsKfXpgmUp/sPGHw1J4vHVx389Zxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=lZ+/Olul; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B76AA240027
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 17:56:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1741452976; bh=eSuxg2xuBFkjSqo6vPYUms50Awq/A17AtOYbqoQmGbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=lZ+/OlulyCasYzJ6uzRMxf6Et3b/eucrxXcqwD9H+QGtn1l9SRnIEOnCrGmfc7xTk
	 bpn7pdL30glloIo3OYa31fV4pSWzvUp7nExa/mcZRphs5YByFYh09fFifQH7Kx9r+J
	 8SyOgMFrqgvNptiw+Rn7HIh4qXq6SUPfliCnG7zLfS9LjZJlbydwdRBsOBFReIvYYw
	 jFfZJvpHzGr+8Bi2StZsajdmIbQDSKZqHaepzwt5gwrx3wJAtd74s79jHAaRy+9tzc
	 LfzT6OWpwhHYcCexwBJanpVj6q3OvnwrxDEhbo/hCV+VJTb5QxtLCmMOGyEiZh+net
	 SwNaGv3kPOZ3A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z98SG4tMZz6tw2;
	Sat,  8 Mar 2025 17:56:14 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Panagiotis Foliadis <pfoliadis@posteo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Christian Brauner <brauner@kernel.org>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: task: fix `SAFETY` comment for Task::wake_up
In-Reply-To: <20250308-comment-fix-v1-1-4bba709fd36d@posteo.net>
References: <20250308-comment-fix-v1-1-4bba709fd36d@posteo.net>
Date: Sat, 08 Mar 2025 16:56:13 +0000
Message-ID: <m27c4zfolu.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Panagiotis Foliadis <pfoliadis@posteo.net> writes:

> The `SAFETY` comment inside the `wake_up` function references
> erroneously the `signal_pending` function instead of the
> `wake_up_process` which is actually called. Fix the comment
> to reference the correct function.
>
> Fixes: fe95f58320e6 ("rust: task: adjust safety comments in Task methods")
> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
> ---
>  rust/kernel/task.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You can add,
Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>

--
C. Mitrodimas

