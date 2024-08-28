Return-Path: <linux-kernel+bounces-304951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2595096273F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899EAB233AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA0616BE11;
	Wed, 28 Aug 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XN4kpI2l"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597B16C865
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848622; cv=none; b=hI+em33Dkj1/yRJmnBRj/7SmgWaCYMKEMWP5DqVr5sXzJ4IVjsO/eRIzxYlebaZylkCuES/mEY1iRftjPXc8UbOuUqPq+MZGvDq4FPv2Y7EuBxdC4S9nK6j96Qu+GBD7DXaRQ74AGCfT2sQuuf611PozqmcOAMFXWQf1NW3+Txk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848622; c=relaxed/simple;
	bh=ICMSOAVwMAVKex/XavRco8vPwAxVobbZqAKviKrCmic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwJnH4Yt1ck9IlE32/xdhT+mzavnJl7l5gBd7YTgIyTk9zwbCsCenwrGtVELrPnhAFZ1eAeZm6BOEpCQIlkZ1/O4XGKMjxyZ2WMDn4RvvPakUZhQ6MhlWPsHWqRLBRzrrrNExCC/5FUzvnsR1gWjLSk8ExkpZn7YPtYDpDuoun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XN4kpI2l; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533462b9428so11287498e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724848618; x=1725453418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU8gBC7gh9KYhQpTD3UR8Co3PXakCVXINF1/hXa3PLE=;
        b=XN4kpI2lUPgARX1mjJ1a2gRFDz7etStKCmLF4r1llzMp9L+rqbRle8M6VzqfwK5DQ/
         qSX8+j7qUoHlre2FokpuwpeNG/Rtu7lRh4Yp/EITT9aDjmrhwv41cR8MH3LLykHWgWps
         MSPDeDAx6cXmw2mrokv3hVyNMl29K3KIP1rh3IGBBzElgTbmHmFj19eRdT80Y/G609Qc
         84L7cANVsRnaj+KYau91YbAhxUtGeZ8f0Q3p48MrjhTpX+52ZQ8Q73JT/WiJyjDx6CyZ
         bf8U4PB97hL3zCa7BHqBkVayQHqNP0YTJZCvMZsjH3vDmFlGCLf/noJO9DjXbGdDuUPr
         h8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724848618; x=1725453418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LU8gBC7gh9KYhQpTD3UR8Co3PXakCVXINF1/hXa3PLE=;
        b=v1a8HGTG8r7kiln8DoCYigC7JZf2zheuTyAeUeYCrklXeI9BYJUXWD68QK7KWnKNNG
         ao6HaW4cAshYHCZvmC1AAUZTAmHo7gVr8PM4Yu7AGKQT4O3Eq6QkgjWpq5sVl3amysLz
         sG4pcfNsRHVjgrjt7JXnRf5Cbyc7svS5uE/NxBgWgioPI195K/DYgFB736VmgjgDujJY
         tzoU2nclb3tC7CqDTSlTlEAz0jqtuHNlUrm0+JiTtm5VP0GHznG3I21ehZJ86YGDfCQ3
         viMR+IiirKjzDZM9wXmezQKZPmovilGQtD5PlizLGa+/j27OAz6YiGQJBHpzmKQrv3CJ
         WukQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/JQQY92I5ZydiUxutxlz1AbrtTIkTdyf54yfj5YGdgMyZtZKEhIoIrGAgMVcSLxqOuxUXQFiQBAYsnak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqj+ucQfQTIkAJ5q0i43cxKESyxGmFBtl7+hbSVwzP6tj+WjMB
	3gJcy6UeJzyHjVvUjSm3IQslnSnVuvWEI3ZklHLRVH8gbnoMoJecdnSL67tr9Uf8T1mAEK1hTkE
	KR18RS5wb/rZxqQv7mo5N5bePevD5DJFsI6GntMavHDgmjlx4
X-Google-Smtp-Source: AGHT+IHpFO6yuQVGJZrGD/WbDSfSLGOtjuiyomFUN7Es+C+tU0dva1fGE6E/R+1C2A5roG4H821o08EF26dNGZYQhvI=
X-Received: by 2002:a05:6512:23a3:b0:52e:d0f8:2d43 with SMTP id
 2adb3069b0e04-53438846f57mr13164571e87.17.1724848617111; Wed, 28 Aug 2024
 05:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826165210.124696-1-alexghiti@rivosinc.com> <20240827125335.GD4772@willie-the-truck>
In-Reply-To: <20240827125335.GD4772@willie-the-truck>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 28 Aug 2024 14:36:46 +0200
Message-ID: <CAHVXubiwHe+5nD0kftRwnNdqAhP1ofSoaUzk4vhDKPrYXVz88g@mail.gmail.com>
Subject: Re: [PATCH -fixes] drivers: perf: Fix smp_processor_id() use in
 preemptible code
To: Will Deacon <will@kernel.org>
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Tue, Aug 27, 2024 at 2:53=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Aug 26, 2024 at 06:52:10PM +0200, Alexandre Ghiti wrote:
> > As reported in [1], the use of smp_processor_id() in
> > pmu_sbi_device_probe() must be protected by disabling the preemption, s=
o
> > simple use get_cpu()/put_cpu() instead.
> >
> > Reported-by: Nam Cao <namcao@linutronix.de>
> > Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@lin=
utronix.de/ [1]
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 31a17a56eb3b..25b1b699b3e2 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -1373,11 +1373,15 @@ static int pmu_sbi_device_probe(struct platform=
_device *pdev)
> >
> >       /* SBI PMU Snapsphot is only available in SBI v2.0 */
> >       if (sbi_v2_available) {
> > +             int cpu;
> > +
> >               ret =3D pmu_sbi_snapshot_alloc(pmu);
> >               if (ret)
> >                       goto out_unregister;
> >
> > -             ret =3D pmu_sbi_snapshot_setup(pmu, smp_processor_id());
> > +             cpu =3D get_cpu();
> > +
> > +             ret =3D pmu_sbi_snapshot_setup(pmu, cpu);
> >               if (ret) {
> >                       /* Snapshot is an optional feature. Continue if n=
ot available */
> >                       pmu_sbi_snapshot_free(pmu);
> > @@ -1391,6 +1395,7 @@ static int pmu_sbi_device_probe(struct platform_d=
evice *pdev)
> >                        */
> >                       static_branch_enable(&sbi_pmu_snapshot_available)=
;
> >               }
> > +             put_cpu();
>
> Are you sure it's safe to enable the static key with preemption disabled?
> I thought that could block on a mutex.

Yep, it seems you're right, thanks for jumping in.

I'm discussing with Atish how to fix that differently, I'll be back
with another version very soon.

Thanks again,

Alex

>
> Will

