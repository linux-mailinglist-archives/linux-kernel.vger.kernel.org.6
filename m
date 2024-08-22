Return-Path: <linux-kernel+bounces-297108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF495B334
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AD9281540
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C6183CA5;
	Thu, 22 Aug 2024 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXmWw3U5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2E14A4F1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323877; cv=none; b=tJmnsDDottHLeIWoOiV6CIhALxyNRQHgmN1fo52zHftIOSvZKVtT/BKn6hynT2NLHT6p/5JaACJGMabtBIvPwnUNDLoVBYTFqKJdWCRXtqySUoOEwhzn/7Dzm9eIp3kfXcSVxKFHgSZdhcuR2ZR0HHN4iwefwKhK01JhCKLYhMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323877; c=relaxed/simple;
	bh=ecMzVaOwhR9FjQmtpKL6utEHTecaxON39x7PmDmLmcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plP9BP1CUdtHm3lKT+AIp7eNrr1RVtm58w52NjhjG0bZ2rqb4Je9RG2GNAp8capkI54eeokT4Bp2TDTXPYdbQZh+jzFRBcW7tObBy/xOJaMmsgBteDyyh2aqokFlRxB2uzp6GfIb7X2u5/B2CR9w2AWVNs0pTHaNtzzmQXC+HRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXmWw3U5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724323875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h7ZCy1kJf6AIoz/obF45zUM8hMhISbyTBa2ni74eFA=;
	b=KXmWw3U5FjQ+peWc9pm1IKCv80mnBBuvhlukf+N2cfEuAQDdTgMHdIPhlGuy/MzXHpxy8B
	UaZaJcY3q0WedVG+A+tZV09tVHsjCjero2hHMSeTsubiZ0x2pVFBH6La8wQ9wCx43p2Hug
	a9evGo/1Vugl+trQhr0gUt8QqBvdmBA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-Q4IaNXt-PKSX1zWfolAvfw-1; Thu, 22 Aug 2024 06:51:13 -0400
X-MC-Unique: Q4IaNXt-PKSX1zWfolAvfw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6bf7a4ff102so11612666d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724323873; x=1724928673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h7ZCy1kJf6AIoz/obF45zUM8hMhISbyTBa2ni74eFA=;
        b=W1OZIzDRQew1tmQdKE80kaSpEJaZ0ykcFWKCux+qwIrNefPFeuO3KXcVmsrQhQdpzy
         EYWuZuWUWC8MHnHw8W2xx2K877P2EUGgZC4JeJDwQ3vbDGUcjhV1Ni7hb7iP5U6H8USo
         XzIrM4QKT+ZlCh+aTZbKO2HRkqQ5zuBLtC3aZKKU2qHvsPfjDb/r54dtagJOJuqCZgW8
         F4DNtu0Zx/8k9nH7euqEYn0x7M4c8g44CgBYbgjbIEZEC5IypF7EJglERbukqayFfRK+
         2CDoNayOkzqkOQ6u71M4KgmylAlSJYPH5y4y6wuvy2bbUPQFb2vln7IoGBeTD0gJTls4
         C56w==
X-Forwarded-Encrypted: i=1; AJvYcCXP/x8SV4EyhksFuNRNDWeKz1cfZ/YU+MsnZPlalzyLtYaH/sgLW1YZQE6/N3ahshTpnqVM7hcBc3feekg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPurcXDBBV8nWxSAhGwgTeURSUMSpXoxdvSx0ZEps133Gvo9FR
	ZJiFjzzT+sxQHMlH9PxHniXhBTJy+TwLRcm9NooLiyxSNaUU3/WK9D8wExa1wu46uGlO3ysvs05
	V2TSKQ6RNk1t9Z5HQdfYqR5YTyXWQTD/baTop5Hqfp2YF6c43zghtQcYaD93U+wxH/4sK5Zjet6
	ntXiYqov4Ywz4CrgkLqLWDCoPm1Lb2k38HUef1
X-Received: by 2002:a05:6214:2b93:b0:6bf:60b8:d4d7 with SMTP id 6a1803df08f44-6c160c71354mr52700046d6.15.1724323873272;
        Thu, 22 Aug 2024 03:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECMvQR0VuHDPsLwc5r72CFhDMHvpNdsHZf14OCwK5hSOzEtc0/+0yf9mhnIndqwf2K8TJ897vRjSe7tccXEhQ=
X-Received: by 2002:a05:6214:2b93:b0:6bf:60b8:d4d7 with SMTP id
 6a1803df08f44-6c160c71354mr52699796d6.15.1724323872973; Thu, 22 Aug 2024
 03:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com> <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
In-Reply-To: <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 22 Aug 2024 18:51:02 +0800
Message-ID: <CAF+s44TCvG3knnqyRbw=reaCRfh0_J76HO=ykF+J=ZFyoYZOCA@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Dave Young <dyoung@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 2:17=E2=80=AFPM Dave Young <dyoung@redhat.com> wrot=
e:
>
> On Thu, 22 Aug 2024 at 13:42, Pingfan Liu <piliu@redhat.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 10:27=E2=80=AFPM Lennart Poettering
> > <mzxreary@0pointer.de> wrote:
> > >
> > > On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
> > >
> > > > *** Background ***
> > > >
> > > > As more PE format kernel images are introduced, it post challenge t=
o kexec to
> > > > cope with the new format.
> > > >
> > > > In my attempt to add support for arm64 zboot image in the kernel [1=
],
> > > > Ard suggested using an emulator to tackle this issue.  Last year, w=
hen
> > > > Jan tried to introduce UKI support in the kernel [2], Ard mentioned=
 the
> > > > emulator approach again [3]
> > >
> > > Hmm, systemd's systemd-stub code tries to load certain "side-car"
> > > files placed next to the UKI, via the UEFI file system APIs. What's
> > > your intention with the UEFI emulator regarding that? The sidecars ar=
e
> > > somewhat important, because that's how we parameterize otherwise
> > > strictly sealed, immutable UKIs.
> > >
> > IIUC, you are referring to UKI addons.
> >
> > > Hence, what's the story there? implement some form of fs driver (for
> > > what fs precisely?) in the emulator too?
> > >
> > As for addon, that is a missing part in this series. I have overlooked
> > this issue. Originally, I thought that there was no need to implement
> > a disk driver and vfat file system, just preload them into memory, and
> > finally present them through the uefi API. I will take a closer look
> > at it and chew on it.
> >
>
> Hi Pingfan,
>
> If more and more stuff needs coming in,  not only the limited boot
> services then it will be way too complicated and hard to maintain and
> debug,  also the two kexec code paths are duplicated somehow. It is
> really bad..
>
OK, I will try to keep things easier. And what do you mean about " two
kexec code paths"?

> I forgot why we can not just extract the kernel from UKI and then load
> it directly,  if the embedded kernel is also signed it should be good?
>

I think the main concern is about the signature.

Thanks,

Pingfan


