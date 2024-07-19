Return-Path: <linux-kernel+bounces-257591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0400937C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A832831C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90031474AF;
	Fri, 19 Jul 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gzIMMxkD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834443687;
	Fri, 19 Jul 2024 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413121; cv=none; b=pv4KJFxu1caa4P7U8BA2kZGKJKHaSCt57R3zNOnuJXnpJKolanQokvLa1iWcXgvGQSbFdE97+ybIqaB/+xXhvlPprCnRUHugjg1RKNGxwH/LKrJeQ0W8CnihFexmOcYnXVGx+F0RPxQ+jxxuMYg/DdhgQFdlqt5rc54sAN28CiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413121; c=relaxed/simple;
	bh=NuntwRnFK4qxv0FrY0nz+e0LCgk0f08Q52/SSiCgUxY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Thfp243qHM9wKLHuO9+vJECcn0xfrI7ihMq4C/0DWUhdeTuVx+MNEGsOax2lsDko6+ax6jHdESOzS3ZeT+GLZ0dQC7x+bJJyUPyHaQ8NZpBGhXowsMcOdG6Ptm060GurtwpOLkfXCvF+dFcGHZ4+ip3brz8jC5j19d3TMUv5lhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gzIMMxkD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721413118;
	bh=NuntwRnFK4qxv0FrY0nz+e0LCgk0f08Q52/SSiCgUxY=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=gzIMMxkDq7ZBqaa5uMCHZ977i09rKPsHcaQ5r6yftyC7Vjd3aqrXO3jzyCtH39PI2
	 GjoGslYg4e2ikUjtAlSrJ7jAyGGKCy7VZOqFDTsAeP7mv18A/RU3zVS+MhDHAkKHJt
	 iy6nLkxFa30xRIsaARqH7HJAd+HrrEbuzeBmGxIgtoemP6GeKUef+SkPJ4XWClXOmJ
	 Q3K/f8O+BOfFO1dkf+WMHQTyUVWIguOJU8Jt4CvVPcXoY3ad06bGUgbqsJ/62B5Whr
	 XCvorh2eiW8Pr0+vzsOD0rL5uZ7fzwnmIRThydi8FXIB4QTocF/WTvl2Nshau6+BaR
	 Ygb/vumiyAgdQ==
Received: from smtpclient.apple (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 439143780029;
	Fri, 19 Jul 2024 18:18:33 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CANiq72k3xoA8R6HKdH3f6YjcvrBGWi2kME1zK3kgV6YQ6zLFow@mail.gmail.com>
Date: Fri, 19 Jul 2024 15:18:20 -0300
Cc: Benno Lossin <benno.lossin@proton.me>,
 Jonathan Corbet <corbet@lwn.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD29DF8F-7FF3-466F-9724-BC92C14A68BD@collabora.com>
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me>
 <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
 <CANiq72k3xoA8R6HKdH3f6YjcvrBGWi2kME1zK3kgV6YQ6zLFow@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)



> On 19 Jul 2024, at 14:28, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> On Fri, Jul 19, 2024 at 6:24=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>> A new clippy lint would make sense here, since we already have clippy =
support
>> in the kernel anyways.
>=20
> There is one already, which we want to enable.
>=20
> Here is a quick patch (untested!) of how it could look like, in case
> one wants to fill the TODOs, or we can just merge it as-is and clean
> it up later to avoid adding new ones.
>=20
> Cheers,
> Miguel
> <0001-rust-enable-clippy-undocumented_unsafe_blocks.patch>


IMHO, merging after testing makes sense, otherwise new ones will creep =
up as you said.


=E2=80=94 Daniel=

