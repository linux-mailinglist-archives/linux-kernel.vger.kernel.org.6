Return-Path: <linux-kernel+bounces-574346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBC0A6E43F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902DF3B53EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBAF1DD9AC;
	Mon, 24 Mar 2025 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eGN9sYHe"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9251CDFAC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847749; cv=none; b=kwGFvL28RB/idT/+odRuDxX9GEdf0BkMyiXTKHnd25HER3yup6o/zzue01q34teyMRb08vK8YBH6yQXRvcTnJq15+ieVuIESzhQjQdsqayVNNGs1qnSPd0qgvoIpTHpy2GO/qD+by3hjhYSYn34WKBy0A5dyEjrU+21I4RI92H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847749; c=relaxed/simple;
	bh=qCCekKi+RpiTvTSUEDHAhSz2dIi8KIRY0LLAUwkHIdU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxPoBzwDGHnlBB0JCwnUZcBj7ygnAQHkqu4SqFJpZ4p3XBEu9SqyPvRiYscXQt70AKDocW65A1YZ8SIlAWkke7MwK7H3oGUgrHVsHZI3Ymh9ZcLtkB6xckW4v1TVHPUcXUcFMg4i7ro021jH5qyqGKNGi9/8/Vjx+YKWFaEnQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eGN9sYHe; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742847744; x=1743106944;
	bh=vf70c5tOfKHHC/BHZEA6asmxjvC7HiIGPQLTOZOZaWw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=eGN9sYHedaDbr80DjvrasOB+loXQ+JpB6blmIU+KMI14/UypDrsrEtbL5qfmoYfb1
	 aFf5JfmYsYUIr2VI4E+qAk1jNPugIahoq4rnsDJ9Evz/KEyaaDcFtRYyZSTXfgs/ZZ
	 epaCm6z8v1NXZx1RVPXM/yg/8ge1523P/bCg7qPUV3jhD8KcqF7hfNIHX0NDgeZG8S
	 dmtZYZNgh/oDNBGBTzOTMgrGQuMBWyv8T9TChxXqoEMChbxS7p1YY28FuQH5Xmtdmb
	 yKiPdW+0FOC6SIgViq/UwMBDTnOktsyzEYjtcADp8zXmkKKNL6nRTDF+qMOOdAvvno
	 1CbY/jurC/ozg==
Date: Mon, 24 Mar 2025 20:22:20 +0000
To: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Sumit Semwal <sumit.semwal@linaro.org>, =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 2/2] rust: drm: Add GPUVM abstraction
Message-ID: <D8ORYL7ZZG8R.1LEAYI5807G9H@proton.me>
In-Reply-To: <509EADD7-607B-4DED-ADAC-152D7338EB50@collabora.com>
References: <20250324-gpuvm-v1-0-7f8213eebb56@collabora.com> <20250324-gpuvm-v1-2-7f8213eebb56@collabora.com> <CANiq72mQ3zuYmsq1PD-49kKLNji8OJwuvxK5QWkNaBMuC-PHQg@mail.gmail.com> <509EADD7-607B-4DED-ADAC-152D7338EB50@collabora.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b9d8d4ae2ff8425c2b69e06a7ab40a7407bb0645
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 24, 2025 at 8:25 PM CET, Daniel Almeida wrote:
>> On 24 Mar 2025, at 14:36, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>=
 wrote:
>>=20
>> Hi Daniel,
>>=20
>> A few quick notes for future versions on style/docs to try to keep
>> things consistent upstream -- not an actual review.
>>=20
>> On Mon, Mar 24, 2025 at 4:14=E2=80=AFPM Daniel Almeida
>> <daniel.almeida@collabora.com> wrote:
>>>=20
>>> +#[allow(type_alias_bounds)]
>>=20
>> The documentation says this is highly discouraged -- it may be good to
>> mention why it is OK in this instance in a comment or similar.
>
> Someone correct me here, but I see no issue with this warning. That=
=E2=80=99s
> because we need the bound to make `<T::Driver as drv::Driver>` work in th=
e
> first place. Otherwise, we=E2=80=99d get a compiler error saying that the=
re=E2=80=99s
> no `Driver` associated type (assuming the case where a random T gets
> passed in)
>
> So, for this to be a problem, we would need to mix this up with something=
 that
> also has a `Driver` associated type, and this associated type would also =
need a
> drv::Driver bound.
>
> In other words, we would need a lot of things to align for this to actual=
ly
> have a chance of being misused. When you consider that this is then only =
used
> in a few places, the balance tips heavily in favor of the convenience of =
having
> the type alias IMHO.
>
> In fact, the docs point to the exact thing I am trying to do, i.e.:
>
>>  these bounds may have secondary effects such as enabling the use of =
=E2=80=9Cshorthand=E2=80=9D associated type paths
>
>>  I.e., paths of the form T::Assoc where T is a type parameter bounded by=
 trait Trait which defines an associated type called Assoc as opposed to a =
fully qualified path of the form <T as Trait>::Assoc.=20

You can avoid the allow by using:

    type DriverObject<T> =3D <<T as DriverGpuVm>::Driver as drv::Driver>::O=
bject;

That is more wordy, but avoids the allow (it still errors when you put
in something that doesn't implement `DriverGpuVm`).

---
Cheers,
Benno


