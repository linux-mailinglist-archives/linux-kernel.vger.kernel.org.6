Return-Path: <linux-kernel+bounces-261431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FAA93B740
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84A61F22433
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409B16C692;
	Wed, 24 Jul 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IM4WzLF6"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C0161915
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848406; cv=none; b=GhoVtsjbjyo6tbzpf4/1V1TTwHJepxsghFo2iX6ILqbr4Sp6PAMzIW1WnUKSG/Mw+x/s3VGQxLlLT5ABWMK9EZPEkaMtrrWP739ELGke6LLI9GtwU+8Bd5V+y7QO1ikhpeSvW0v8+hYtnGFzhcCNlp7ogdTnQ68cM9pAYptRvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848406; c=relaxed/simple;
	bh=wODsILdydAWyTmURycOlaz/DUnsABuavn1/8cgcYgtI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4Qs52mCSqhQwq2xNr7wffgBM5gnnkb1H0kboQfk+yfg2sCR6YBg4hINQUUFx/gzMN7RgGcL2i3DxFjgXyp440hTWMphQnC0JxnJ+luxUUd0C2WVaJ0ci4JUp7M/O9hNZMzgE1loh+SzyrJQZiyZt1PX61M1fqXRDaCuh78dOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IM4WzLF6; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721848396; x=1722107596;
	bh=yROuNhhOiZXiesuXRINKmwCmOfQ2t0VJpy13JCepD18=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IM4WzLF6B5uE3dxiAPg8LKmkGf2baCHAvm6m3zLJ8FDEQjWEMrn8FyzKvcmmjfJ6f
	 pJzUxNUCpG0PgnDiONtHHe1h4ZB275jV/Z+ly7xl57jNmIE4+sjyYlFNmQZBUkjauV
	 Vsq+33aempb0fKxeoAwa2Sus/Cn6OlXL9n9qApq+1oa2L9Pm+vurtz1ciAV7uhqojQ
	 eySUNtC7upXmnvwDYwzxYlQo6FoTOKLxaLmtVAk4wcToaGV0ld5EDlgX5gPQ9iGN6T
	 kJWZ/kyung+cuAd6fiOYC6NTDAOVoY2uvfy9TjYqI5+r0WW3BjHX1akZ6pKoaPU6MQ
	 ynKsgqmA3407w==
Date: Wed, 24 Jul 2024 19:13:08 +0000
To: Greg KH <greg@kroah.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
Message-ID: <59ebc5f2-7d58-49f5-83f1-c954705f3953@proton.me>
In-Reply-To: <2024071845-neuron-figure-2e26@gregkh>
References: <20240717221133.459589-1-benno.lossin@proton.me> <20240717221133.459589-2-benno.lossin@proton.me> <2024071845-neuron-figure-2e26@gregkh>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: be907ebcc070349e238c381528938ba589d3fe6b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.07.24 06:45, Greg KH wrote:
> On Wed, Jul 17, 2024 at 10:12:29PM +0000, Benno Lossin wrote:
>> +Because unsoundness issues have the potential for allowing safe code to=
 experience UB, they are
>> +treated similarly to actual bugs with UB. Their fixes should also be in=
cluded in the  stable tree.
>=20
> Odd extra space before "stable".
>=20
> Also, link to the stable kernel rules here when you reference "stable
> tree"?  That will explain what you mean here.

Sure will add it, do you mean Documentation/process/stable-kernel-rules.rst=
?
Or a different file?

---
Cheers,
Benno


