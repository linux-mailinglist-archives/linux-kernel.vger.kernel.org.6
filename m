Return-Path: <linux-kernel+bounces-323233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5939739D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A8F2837A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599721946DF;
	Tue, 10 Sep 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="L0ownQDG"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415818FDBD;
	Tue, 10 Sep 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978484; cv=none; b=ePwIQPB8bRc6uoeJHHoh+CMgCUW5hKEFOlcbtwYoDNSQAUu7EZgYEoSEn9XYsdDz1fHVu4ItMOPcU25bVxyVUJ6xFTQwbLSie+rhVCejGziEIbgDdXulgHXQlTapB2D2e4vtwrNAYhyVCaUrGmvmUGL71Rf7FJq1hGM1tnE2Ess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978484; c=relaxed/simple;
	bh=qHkpMV3mLwk0oKfwpkYJ7InrvxkPQlAZpvhOXxJwTko=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAYdF8SEV3ZMbIH99BKHDNSpJLBL3yFxjoOqx1OoreF5SyKLbEP1tr0auOuxKEvPsnokoPDxnQ0hexrndJZjRSkT6kPcxW/QpaheyFY6AKO2WuWWYe0bEq/0x4xWXwuU0vxxqaPSKCeKgtiVkWhS9b5KhjJlJvyZUWvNAGlJU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=L0ownQDG; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=kpc4lnod5vhgfipuedzauo6rx4.protonmail; t=1725978479; x=1726237679;
	bh=qHkpMV3mLwk0oKfwpkYJ7InrvxkPQlAZpvhOXxJwTko=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=L0ownQDG9vwUTrlXtMaaLGKMyi99WfTN8kd6kFo7PaXe0i+L2ED9urXmCvtKr2/i1
	 LvCtHIz864httSus4+wLrQNoYsFTIy8Ch+xM6B6D0fG7uZE1s7V+BvqTa1t4s2knJa
	 XPPNn9MXkpGHFypJU8FsFdxCcix7+XYw1/bGwDKsoj/4TigTH+wh4/G7ls+twZGs8N
	 MdrgY9FHWoSEx2ZJK7ngQ1luAZyonxU368/1B/QP0VmY2gAHcyhYpAJXYScRiUolv8
	 vtynzgdmhMTu167iZY08AkYPv/aYjrUtJ/vJxHRvpMVjJ6GOe5BYlSYBMvcpCwhZXP
	 BECdI6b01+GXQ==
Date: Tue, 10 Sep 2024 14:27:52 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 26/26] MAINTAINERS: add entry for the Rust `alloc` module
Message-ID: <3b2f4a89-4a41-4bd5-b07c-733b70241686@proton.me>
In-Reply-To: <ZuBMuHk-_DmGRQad@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-27-dakr@kernel.org> <20240831135712.0d7366b6.gary@garyguo.net> <Ztb6_XW3ccnHQDmw@pollux> <CAH5fLgjbnGstjzsudjavzt5+UwK_r8n8X3LPdw29QSkBzaygxQ@mail.gmail.com> <f99d8d3a-5b56-4555-a1fc-bd7685dcea40@proton.me> <CANiq72=MD8jmWb9EGA8yW6eMT6Prj8fYEiJM81-HTq3p4dKmGg@mail.gmail.com> <05abcf53-4997-4bdc-953b-30bbb5118639@proton.me> <ZuBMuHk-_DmGRQad@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 65bc68060d4607b3c0e640286473b7551089d2c8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.09.24 15:42, Danilo Krummrich wrote:
> On Tue, Sep 10, 2024 at 01:26:34PM +0000, Benno Lossin wrote:
>> On 04.09.24 14:57, Miguel Ojeda wrote:
>>> On Wed, Sep 4, 2024 at 2:51=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>>>
>>>> I forgot the reason for not using it, does anyone remember?
>>>
>>> One of the reasons argued was that `mod.rs` is the same name
>>> everywhere, and thus it is hard to notice the difference in some
>>> editors and may be harder to "jump into" in history/tabs/etc.
>>
>> I don't usually open more than 2-4 files anyways, so it's not an issue
>> for me. But of course people's workflow is different, does anyone have a
>> problem with switching to `mod.rs`?
>=20
> I'm also not against it. I'd appreciate if a potential change doesn't int=
erfere
> with this series too much though. :-)

Sure, we can do it after the series.

---
Cheers,
Benno


