Return-Path: <linux-kernel+bounces-380180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5569E9AE9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879291C24EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367661E883B;
	Thu, 24 Oct 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GBWE69oS"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8A1E571C;
	Thu, 24 Oct 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782541; cv=pass; b=GGl+3Ya3BAHyAQqBHoBUFJdNHbrD7s0yie6XEDJr/E99KM4ajeNN5it1LAhdcwuk2/twFjV/0V+6mFzyc5+ZHqdXttAhvAgUnq9DObj8wcPKQTwsCoOL1qkkC5w4HUS01t5xrCOx0ewxiFDuY8mYhg1iUisCgqNjtrl+iG+ZArY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782541; c=relaxed/simple;
	bh=xa1LtoAqJFTO7vrCqWRiLQ66QpcziqNwdsC01+w0pL8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VWtB2eIYC3+IVjDzwBAndGnBTBGpwOPi44LTSd+jMmmswikSCiA20n3TI/UxLHMrDRpBgRSkeyZfRoMDDeaoqnFBIZHT16hPqrQfYOBpo1FLna4zkq/911T1ptJnor9zpQ2EsHX6Kh4taHu4rZ12n1MSdubCFjLlgMTh03ptej0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GBWE69oS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729782517; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ESmEgKh2Yocn5/AKBpPKm+XFZqDq2VLRRm9h4defjWikTjDeIdxr6zqcSTzJ/6fTTOjIOMH2AvCzUHFRCSXfrTskjqklTlI1aaMgC9hd6EvJeD+sfLhEiXEEGByGZfDwMc7OJ6m18jTBbT5g2rYwqQhZRNgQdNYIM6yAj1r5pK0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729782517; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1cTT2JYj3LwnZ+FoymHAjk9GBazW666dYq/Sk34dsRU=; 
	b=dK9hmaZD4YCHFeO6/Z5Hj3/R8wlYlQYwjpJ/ms3KJqyxkzPT7i628BNndX84gNChVQB2Lc3qdcq2QumTSIENzUoNCMtqRxmrvZe/iFGac5f9vhUOMm9MX2jUuMwAnKNAWl3nahCO6s3ZPRV5TDo8RJEL1JY5HIV2SyQFEzJ6MmE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729782517;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=1cTT2JYj3LwnZ+FoymHAjk9GBazW666dYq/Sk34dsRU=;
	b=GBWE69oSeemYhLf8u8sVQ3L3x+v0paMycGSdqnnWqV9/KPaYjrR9S7n9OIuIUD1J
	g50Kfx9i5JXa8yhzaNy+SSAkjIIkARu5RRqE+LUhUhJTX50jUlBuAnFaw3R1KkqdRYQ
	2NbNiA6R/Gyjf8GZ9NOguTfKZOcfCvtMsGaLTlOA=
Received: by mx.zohomail.com with SMTPS id 1729782517033178.29242145646106;
	Thu, 24 Oct 2024 08:08:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] rust: irq: add support for request_irq()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CANiq72=tywaM4n-6isLmpu5fC3uj5H7g4QfiaksXcaPH_Pfxaw@mail.gmail.com>
Date: Thu, 24 Oct 2024 12:08:22 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF671774-94A4-43B2-B959-3ACFBE8F3FCE@collabora.com>
References: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>
 <CANiq72=tywaM4n-6isLmpu5fC3uj5H7g4QfiaksXcaPH_Pfxaw@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-ZohoMailClient: External

Hi Miguel, yes, my bad.

> On 24 Oct 2024, at 12:05, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> Hi Daniel,
>=20
> A couple procedural things on your latest patches (no need to send new
> versions right away).
>=20
> On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>> Both regular and threaded versions are supported.
>=20
> I am not sure if the commit message was truncated, but it should
> explain why the change is done and what is being changed. For
> instance, it should mention who will need this upstream. Please see
> other similar patches/series we have, e.g. one of the latest ones in =
Lore:
>=20
>    =
https://lore.kernel.org/rust-for-linux/20241022213221.2383-1-dakr@kernel.o=
rg/
>=20
>> base-commit: 33c255312660653cf54f8019896b5dca28e3c580
>=20
> Please try this one on top of `rust-next` -- you will get new Clippy
> warnings about missing safety sections & comments.
>=20
> Thanks!
>=20
> Cheers,
> Miguel

=E2=80=94 Daniel=

