Return-Path: <linux-kernel+bounces-542321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5BBA4C87E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8793A188B497
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEFD2343C7;
	Mon,  3 Mar 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="drSCFxB2"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7E233D87
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019650; cv=none; b=oJqJUFLksFlhRDSYw6YNS5YuqMwGPMH8z6ksLx//2gDNJLR6Zkn0kJgo8edImujK9apJOUCTpzxB0L2Ey/109lBmcmWH7VgkLawVZal6mQlQiUFYhHHmRyp+nXp2oxLXFgwjBK0kNxNyW+6vCzg3Hqc/VLwz2MvS24cE4y4Mj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019650; c=relaxed/simple;
	bh=TxFXzhsCXG0uQIgmK+6/Wr/GwZRnOhLDI/uMTiTpLSI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfLsc+UMIHgJKo7xeBxq3dghcK+NbuUGS+WaosJl+AMehXB6DRczQMMUcOqMf6120eGRJRNGzhW5Cn4RPtreekrk4KXiNsQEuuNVgaPy6AhOxGgfBujvfJaW9IATtHawOBlzswElPDLC54u7wa58jUvZpyvtqZwa5EX/0/yYhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=drSCFxB2; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741019641; x=1741278841;
	bh=TxFXzhsCXG0uQIgmK+6/Wr/GwZRnOhLDI/uMTiTpLSI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=drSCFxB2ZDqHJRh1F9vUGLaESw9pQ+PUFb+T3Jr6o8i61EUCWTTBiZQckCB3ixRMv
	 swpOX8bwwydQfuRuuheypSfKDQOYJEeUGJbMUfsbMiyRrRwxdSeRMFc1IyfdSbrOTI
	 NR5pO0T5Vm6WmBQaC5Y4c0DsF6YQxAEZraQFCU+UIpcNbTFHy0huSgP7rLQyvWy/Gj
	 96obXM5yyD3jCfcPd9sHy4BaCNPJsCX0D5aPQu8xC/+j0yt3fp8Enp4GdtntxwzRJX
	 qC2V/9/rHZiorvWllXnkty3Nh4wyA1Z9bDIQ26GflSvlUHqo0JMdvpU8qXFFEteeYm
	 hQFDcc8J5sqbQ==
Date: Mon, 03 Mar 2025 16:33:56 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8XZ8EFEXM-kYelX@laptop>
In-Reply-To: <87o6yijirw.fsf@kernel.org>
References: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid> <MFrukGViddXfhKeURDySTWCDW6Pk8Oo5keozdVg9hehiS3P4FVHKv4d-Fwn87yprBUeyTHcY6T1k9htIhPzc9Q==@protonmail.internalid> <Z8H6EUy1HqLrzytE@laptop> <87frjxncsx.fsf@kernel.org> <R-XaKS9h55NHdh6RYNYWTGw7oDyauYJhAY72W8DAgJJ73VskOhGPlSZP5DC4teo0EdhbDDtLV0Lnd9MMd-jCBg==@protonmail.internalid> <Z8Wuud2UQX6Yukyr@mango> <87o6yijirw.fsf@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 33cf7609a55a21449a800aa97e7cd0b3e026495f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250303 1522, Andreas Hindborg wrote:
>=20
> This part:
>=20
> Goes immedieatly after the cut like so:
>
Hi Andreas,

sorry, again. I misunderstood what 'after the marker' means.
But as I now tried all orderings, I should get it right from now on :)

> Again, I'll recommend the use of b4 [1].
>

Might make sense. I will look into it,

Oliver


