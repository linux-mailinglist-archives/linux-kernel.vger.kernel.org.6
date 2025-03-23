Return-Path: <linux-kernel+bounces-572801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921FBA6CEDA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA837189B17A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A3320408D;
	Sun, 23 Mar 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XLrm65kI"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C76204098
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726466; cv=none; b=tQSUDUM8/vrM0XG80MnsBg10ZtYgefEeLgqh7XyFHB3jdG3v4Cxl6vtDQXIe2rdiLp7lQYr4Z5BXS1cRHJKsHW/CxIX2wWjja/O7lLcfdc4Rds64Nw+wvzcu8N2b+RxomIUldubKVgvko5wCO+SdMMgJQZTqD3nVcUou/SwDXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726466; c=relaxed/simple;
	bh=Ob9LdZ+c/ncKnBCYJr3bZneLXu21lTpwxmVSLf562kk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hruSlRNEHuVBBIzXgP2V8r1+PHFnUI0FTZq+u4SIfiMp2iMijm7KZxdMJSJnNbJ5xHeiKaMU8CFf/lKFozaZI4p4yzFPwT2/LwzEktGWWbPidA9GWAbXxboRy/Utle+1AR19SJIFuAHz0iHIGmmzn4FxTkOzeZgkUgHRQrNPpk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XLrm65kI; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726457; x=1742985657;
	bh=vie9Ixb/ra8lAdi/iaoHsc8QAERGKQHc1chJN+YSfQ4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XLrm65kIs6EmXAQaumeTNXrNER5ALAoJS8Tw28fyEGaSy92SFQZQDyjQaq33OKlVF
	 bfzn9Lcff6p8chFQQhJW58GCViS31o8nLHsrQQjbX1L3hNStm0MfPRHZgBxjAOz9O8
	 LjzsaP6uf0ryZ8ObI2XZE8l7LHkzRjvrQyXL9Mr+5eEQ5/FkQkcKSRM+EWSKd7jfBE
	 9FAHLGeMHNx6weKSNeVIjKCZbws0ltNq73fKna+9UWBx7nnBwDGWHcb56fXCPuKu5A
	 9vq+gHU4cwMpBf00URL603/VOlO6+DBNjHMIwx9VKv1IKeXQB/A/9rAZaOG1BmgfNk
	 +PBHYh2LudUlg==
Date: Sun, 23 Mar 2025 10:40:50 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 15/17] rust: fs: file: refactor to use `&raw [const|mut]`
Message-ID: <D8NKYSZ8QHFB.WKE3JD6CVDG9@proton.me>
In-Reply-To: <20250320020740.1631171-16-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-16-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0dd335f6b9ba7dff36cce721fc3d5200bf385ca2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of!(place)` with
> `&raw const place`.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const` is similar to `&` making
> it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/fs/file.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


