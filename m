Return-Path: <linux-kernel+bounces-224444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A1B91227B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669131C232F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD73F16D33A;
	Fri, 21 Jun 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HbQ9PieP"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221574416
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966062; cv=none; b=e3JBIY7NA450mUMs+0E/uNi8ING4yKa620TebZAqaTtLqZpjhgBvbwa91mRzlGQeHFQ1A4oxaNEvxTeni4/SpTL7bOgbw85IPtkeNDdJmmsnxxAf4GZrKmeOGBk3IS3N4zgi76d0jKyQcFR15fZFAlG7BNLty9GopLjf4RSNXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966062; c=relaxed/simple;
	bh=KTDze4UhK+Qdt8yDIqVr+68kui2rsKo2uZ2LpKfsXZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sz28wu6HKmTNcFpoEmyQ+nLwXVNVmHT5g29nzF6wNRneGUC3Dzm24qi5rren4yWeUFiS8P011f4n4sqXNNVqjL23bjZ3cYKMdkyxVnD/JPHqVWQvHDfx+EbhBW25vY6I/PvD/0ENa8PE7z1s75B36aQ/Wmn8tnStqLK1pI3Tw4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HbQ9PieP; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25c95299166so973059fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718966059; x=1719570859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiEIJ+aB3LoELXi0g19POXyK7Fvva+QATDGmieXdJiU=;
        b=HbQ9PiePGP/K51PkFFmxyY7Rcpr8t+skWon4ZEvYbJPVirkHwE6bF4kxTs8qJCY6B5
         B5howHbC8JHyKWfSAEjvBq8Bn0r04HQ7zwmi949k4TTLTCN7yUrT1U9d0FISgPWjphq9
         KZrR2wKYPeE7CaqjA8m6MkZ+0brhFKTmlUn8P4rjcKLRw8hACwFOJClwrsY+Z45Um/40
         Yt7A//OnaRhwBfcV/fE3NDKkFBsMjf/8coP35/DuLShdDeZiTiJYpcjoskC2rDxWhAzD
         33507KUz2FqwSTdWyF5gI4k6At+GszXssNxoRkPWCqzzI+GUxREd/oFYus9wMmkHUJHi
         GBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718966059; x=1719570859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiEIJ+aB3LoELXi0g19POXyK7Fvva+QATDGmieXdJiU=;
        b=Hq9dB8oB/U93o9VbMBwjEzMLosVsPCTSnnTIf/Hk8UmSCScg4AObTHynsAYuwzSJDF
         JbqdGgI8DtLi4sANNxR9c8P2fpMtneUV/zYwyQat5vI1ErHKCb1cuZ9d0E2d+H/ugwlc
         ZJWt9XH0FZ6Xr1HT21A23UcWvTWg0KGYaYWgigvgyQMQ4RLqnPfr/Fz+hD69RRH1tzXH
         pBSmZ/c77e3ND8XYZmdOXnsF1Mwi9oxl6wx34eeaDUmN8oB9p1t95qssaN7cGBoPhGvY
         eQdHcE17AKIrK6T6CEJhksXvY/ROF4TiAR6ASmJ5ro0X5kH9dFq7rk+M6696q1mMrAQx
         jEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Nfherq3/WYPccDzk9zAVOGEg12bpHFp8VA8jhna4yC/Dyeor9O387UcmSAPWqwxMp7VSwIFZTLeQsrB6VouTMLi939yOUAtBoJz4
X-Gm-Message-State: AOJu0YytIgQ3bD3kK3+9ufxhyZ0D/qRz3TOEJmPoUpLFRpr2Gx32RRdN
	4SThWv5BhgGagyxjhZAxfQueqFDFRK3GxKUWy6igIGyXCvE3qMDT7AdZc+H3Er9iQiT6onk75m6
	h+dSvJNwUN7bGVPivcqA3zCivG0148yvgJAiprQ==
X-Google-Smtp-Source: AGHT+IFl6dpz/wOwOogwSSMMm3/tdCg8DTplBhqHoRnvMWb06zdb/xiwjF6rv5JWL8TKTe41hMECUKSqGMX19Tn1ZxQ=
X-Received: by 2002:a05:6870:41cf:b0:24c:4fcc:9011 with SMTP id
 586e51a60fabf-25c949a7793mr8938055fac.19.1718966059436; Fri, 21 Jun 2024
 03:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618114653.12485-1-cuiyunhui@bytedance.com>
 <2BA519C8-D258-4D98-AD49-AC7D30D8B0D2@jrtc27.com> <3c20c9f15cd7a9fb1f2e88560c1b089ac8032898.camel@icenowy.me>
 <CAEEQ3w=HZptMOgXp2Rtuz-VtzPabN=h5N3=3wS4AMk3Lo7E7FQ@mail.gmail.com> <8fac6e0f11ab5f5fc28be6e73f196b38e99f8c39.camel@icenowy.me>
In-Reply-To: <8fac6e0f11ab5f5fc28be6e73f196b38e99f8c39.camel@icenowy.me>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 21 Jun 2024 18:34:08 +0800
Message-ID: <CAEEQ3wmX9r=Xv=Ue9HOwEvBAHV2=CM5dTiHgd=hzgHBMn27sbw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: Provide the frequency of mtime via hwprobe
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Jessica Clarke <jrtc27@jrtc27.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Evan Green <evan@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, costa.shul@redhat.com, 
	Andy Chiu <andy.chiu@sifive.com>, samitolvanen@google.com, linux-doc@vger.kernel.org, 
	linux-riscv <linux-riscv@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Icenowy,

On Fri, Jun 21, 2024 at 1:18=E2=80=AFPM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> =E5=9C=A8 2024-06-21=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 11:01 +0800=EF=
=BC=8Cyunhui cui=E5=86=99=E9=81=93=EF=BC=9A
> > Hi Icenowy,
> >
> > On Wed, Jun 19, 2024 at 7:51=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> =
wrote:
> > >
> > > =E5=9C=A8 2024-06-18=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 18:11 +0100=
=EF=BC=8CJessica Clarke=E5=86=99=E9=81=93=EF=BC=9A
> > > > On 18 Jun 2024, at 12:46, Yunhui Cui <cuiyunhui@bytedance.com>
> > > > wrote:
> > > > >
> > > > > From: Palmer Dabbelt <palmer@rivosinc.com>
> > > > >
> > > > > A handful of user-visible behavior is based on the frequency of
> > > > > the
> > > > > machine-mode time.
> > > > >
> > > > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > >
> > > > I would suggest referring to the user-mode CSR instead, i.e.
> > > > =E2=80=9Ctime=E2=80=9D
> > > > rather than =E2=80=9Cmtime=E2=80=9D throughout in names and descrip=
tions, since
> > > > that=E2=80=99s
> > > > the thing that user-mode software is actually reading from.
> > >
> > > Agree. MTIME isn't even a thing defined in RISC-V ISA -- it's part
> > > of
> > > the ACLINT timer spec, but before ACLINT gets widely accepted, it's
> > > just some SiFive thing that got copied by many other vendors (and
> > > vendors such as T-Head even provides CLINT w/o MTIME register (well
> > > because these T-Head cores have reference source code available,
> > > this
> > > is because of their CPU design uses an external counter fed as TIME
> > > register)).
> >
> > Okay, Thanks for your suggestions,  I think this modification is more
> > appropriate:
> >
> > RISC-V: Provide the frequency of time counter via hwprobe
>
> Sure, or you could just say time CSR, which is a defined CSR in the
> user ISA document, and allow to be read from userspace.
>
Okay, I will update it on v2.

> >
> > A handful of user-visible behavior is based on the frequency of the
> > time counter.
> >
> > What do you think ?
> >
> > >
> > > >
> > > > Jess
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> >
> > Thanks,
> > Yunhui
>

Thanks,
Yunhui

