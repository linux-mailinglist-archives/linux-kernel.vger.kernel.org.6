Return-Path: <linux-kernel+bounces-370210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D7E9A296C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063571C26E78
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226341DFE27;
	Thu, 17 Oct 2024 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1tOFOFfg"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5C42AB4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183531; cv=none; b=THVghbUqJ36LJC14uayIoyzpdWBh/GQLBJCYM+X3I+nPYZxTYO4GjGtuBy8Br3L94MmBU97C2QIwBT3iVyfPDPX4FnoY52gaIaVGsEj0eRkspOeTuk/gbxrCsP+Slo+gCxTbACao81W9Fz9LGnhVdpr4PlMB/ISvZj3cEr+H5cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183531; c=relaxed/simple;
	bh=5dtmDLd3dalHwVEgcR+tiAH42FjFSBJ+JMILFC1R808=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dB27NQqP79hv5BITsueuIXhlGuBD55Ur4wTjBlJofh1owSwurxBBzV+3wYgxTJgs+3FuibCUZLTPpoQ3TZF3sEJ7ukYFjtec7QapHc/LHPo1alBmhPbuDzS2FwPSybmDudqI0Yu0Y0GmqyKM7n4lZ+NzJBVmARzzH+idmmcNOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1tOFOFfg; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3bd664ebaso4280035ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729183525; x=1729788325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/+hKz9Utv8LPO0aGsn01ZA038qHbKiaHK+Sj+rHiIo=;
        b=1tOFOFfgiAbHGzHpposiiM2BS5nFxpMxDFB3iQsglSCzVnkEwsUh0YVV/qG+w7iGrC
         C25YZpxO3Ax/g9HtT/LXLOI6YULerp0L7ioqLYN26tk55c/2Wdvf3B6TuWEpbSRMnPtn
         hnRRyeQiPf3HsKq0/T01HzRj0aeeoV6lBtvQj4c3b6M2SgNpthbLb7qTJ1gBPwxMowY0
         0TkMre4PIXOd2e/r63AZs6JLH/iamdmi4HMY7JS3rmztogijmyuw3lM/M+z95+z45BOb
         f+4V1lomq++085mimq1IzijjMNzgQC4b1Nmx8DTqUwrqvobSSHpztXvDmlpstOaVLvdI
         UvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729183525; x=1729788325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/+hKz9Utv8LPO0aGsn01ZA038qHbKiaHK+Sj+rHiIo=;
        b=KejOoEjF8WWf/wM74v0Q6HluRFvWjzX609WXzz2FILtG4xIlkK3OZmmSUmv4npE/gB
         +R/HJnY4jj5EvhT54Hj5xzNwzLnooRx+ck02FA2dZj4nLn0L0fL05jyUtmfb/aeaMdIA
         uFzecGvK8gl7nCCOUdnYvOLN7yclEAMu9pNrsTevPRkFlANDHnDLITFy3QWB6wZRqLAv
         PUT0orFufBHFAeJMQq5ax+MEm3pQfWf83gY7zAJuuKi9DNgBVC38Fhcc7EygD14XLENB
         7Ixyu4urC1u8vORhIA5uVIMVFpakr3BgyA63nznF/nmid5KxYBesUx/wYZYpKUVjdnwV
         iXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1vFDugZUF+EswspIuAqrZPKvXje8zdPE/4cieA6fdhX81ofg5KHJihTDD2ZcVRBQi86930x/1pDovr+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBmRH/LsMQ9QHOCpburo/YpTf89Yv8xjX3it07tKbFLHCB5Xm
	pZDOU8ta3wV2rG4Kx+yDauSu90dN7Y7B+HPU/wC4GQ8HRIdW/BQpmUOpbyCIhpCxQOoE5EkjC7k
	VmYArbQsolPLu7ZIJlXeQfyFs43II1B/Fd2bUlg==
X-Google-Smtp-Source: AGHT+IEyjFo+SIWSJWyVZBGV5zs/J+99C1GHNHOGAoKVR2hwF/wgFiuTrcZJ9nhmSqqLjMiUKewGgdAueOpzvhLZuL0=
X-Received: by 2002:a05:6e02:1786:b0:3a0:7687:8c2d with SMTP id
 e9e14a558f8ab-3a3dc5030b3mr70463775ab.26.1729183525560; Thu, 17 Oct 2024
 09:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728579958.git.tjeznach@rivosinc.com> <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>
 <lagj6ljulmfjogrzhfd3jrf5fnngev63q2g3bmvftwfzc3s6mb@gw6oz4yriyjf>
In-Reply-To: <lagj6ljulmfjogrzhfd3jrf5fnngev63q2g3bmvftwfzc3s6mb@gw6oz4yriyjf>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Thu, 17 Oct 2024 09:45:14 -0700
Message-ID: <CAH2o1u4BYyHhi3dVcBrB8T2JpXdxStsfYodmOT-6a8KMHAot8w@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] iommu/riscv: Add RISC-V IOMMU platform device driver
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Uwe,

On Wed, Oct 16, 2024 at 2:35=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Thu, Oct 10, 2024 at 12:48:05PM -0700, Tomasz Jeznach wrote:
> > +static const struct of_device_id riscv_iommu_of_match[] =3D {
> > +     {.compatible =3D "riscv,iommu",},
>
> nitpick: Unusual indention:
>
> uwe@taurus:~/gsrc/linux$ git grep -l '{.compatible =3D' | wc -l
> 192
> uwe@taurus:~/gsrc/linux$ git grep -l '{ .compatible =3D' | wc -l
> 4197
>
> (Hu, I expected the difference to be bigger than a factor of ~20.)
>
> I'd go for a space before ".compatible" and one after the trailing
> comma.
>
> > +     {},
> > +};
> > +
> > +static struct platform_driver riscv_iommu_platform_driver =3D {
> > +     .probe =3D riscv_iommu_platform_probe,
> > +     .remove_new =3D riscv_iommu_platform_remove,
> > +     .driver =3D {
> > +             .name =3D "riscv,iommu",
> > +             .of_match_table =3D riscv_iommu_of_match,
> > +             .suppress_bind_attrs =3D true,
> > +     },
> > +};
>
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers. Please just drop "_new".
>

Thank you for those comments, they look reasonable.
Can we postpone those changes after v10 is merged into the iommu subsystem =
tree?

> Best regards
> Uwe

Best regards,
- Tomasz

