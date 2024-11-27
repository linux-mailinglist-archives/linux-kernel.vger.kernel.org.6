Return-Path: <linux-kernel+bounces-423943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D4A9DAE93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0BF161F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC341202F99;
	Wed, 27 Nov 2024 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="etCSLXZV"
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45C14AD29;
	Wed, 27 Nov 2024 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732739944; cv=none; b=F1R56WVFvLzL4ucczJtVrTYOkNMfyBW3hr5sXL7Im0a5n1zChyA0qpr1slFzob3yLamKqw4rZ+9BDyoNewuwbmRr/k4yo7xJ2Hn0HxdNk9V9qgIqLYhaaziuUf51ojBCMLeNQbopsZNavc/3FM8sGZ414AfRSL1WuqbID80C0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732739944; c=relaxed/simple;
	bh=s27P/8glGyqvC9Z46lGh13QRNKPymyQXSPRZd0cgBlA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=at8xZE2lBt9jWPASTjrlg4ootOpAgJw5O8Wmbzp+uVDGzusTjd1AtjECpLwppWJjyRxjvkwBUKiVD4U/ecud94lwNDFJ6SZiP8VaULR5yL32uK75e2SBc/Snw4uRpIL+VmyNIwZDqOPPiOYAFjW7X6on6XEoq8y2CZ7KugBgj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io; spf=pass smtp.mailfrom=tuta.io; dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b=etCSLXZV; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id A5E393F52D54;
	Wed, 27 Nov 2024 21:39:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732739940;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=s27P/8glGyqvC9Z46lGh13QRNKPymyQXSPRZd0cgBlA=;
	b=etCSLXZVOBd/q3FoE7sfOE7Hnedy3fNLzNVUWau6a6nZ+9oX6oRiC+R/xY8qRpcc
	IEQLojdm0l4UMzEze8sSI9hggbVkMrCFT6ge4n4wtfr0a6j8m6uHRMWS3GGtUj8cUqn
	UVaabHR5jpbTfhT7V2oJn9yk0mIzvy/Cbd2I8P5TyXL6djX9yjoYwM5FS6Lf6cazOdj
	6opWYej5A4wKUpRUR43k/z7Awsc0DO0S34FW6/OTxJmJzBx1usmKVIuo6vAwzfgfdvA
	E15MXtLHiNtl/tZLCz5/juhx8LYcsyS9YIJ8uqL8DbUBa6iq2RqaG7wkm5495KVcXpr
	iyyfj2GnuQ==
Date: Wed, 27 Nov 2024 21:39:00 +0100 (CET)
From: jens.korinth@tuta.io
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rust For Linux <rust-for-linux@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <OCjLJ1h--F-9@tuta.io>
In-Reply-To: <CANiq72m-dY0b7UiBiWOg8g1SFPqLxuhkDdWwNh8g8OBk-Tjz=w@mail.gmail.com>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io> <20241126-pr_once_macros-v4-3-410b8ca9643e@tuta.io> <CANiq72m-dY0b7UiBiWOg8g1SFPqLxuhkDdWwNh8g8OBk-Tjz=w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rust: error: Replace pr_warn by pr_warn_once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> I would mention here the merits between `pr_warn_once` vs. `WARN_ONCE`
> and why the former was picked in this patch (especially since the
> `TODO` suggests the latter).

Tbh, I am not 100% whether this should be here at all. The bug is not here, it's
at the call site. It should probably be a `try_from` instead, to raise the error
there?

Jens

