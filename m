Return-Path: <linux-kernel+bounces-269626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394CC94350C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51071F22F01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30725757;
	Wed, 31 Jul 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0K0noJ4"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692C4409
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447124; cv=none; b=YbYkwj/ILuQpGJJfm+a7QqXUkuShhi9ZqnsoHW/LunQB8/5VhP22kHGWAEZL981Y/aN+N+hmdiEfJsqEVCD7FOv/3C2mljfPXeFdecSyPhwM1FiTtgvi/kZt9tSIfdh3mYP/rkTYxi4pwSGcw96anUuqNpcMks/+msXT0wH0fPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447124; c=relaxed/simple;
	bh=lzL5/ONmwu0hnlqGzyHq1S5uNFkmveyAUv8TJ2y/iy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEzZ+gyRVfEX/HwOuM3UBr0IyR0sCeC0ifEWJ9awAEODNY6j6U1xSqztSQO61+ZOjjdO4FKJKd6ujLWZdjynG1YmLm6RnNs/4gVuDVL1sKfiuJwLKb/pSEjNbSipiD+1EdUt7EAmygf2hGdFpB2SCevyZRAnZzfX7xxnOfnWNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0K0noJ4; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6678a45eaa3so48640137b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722447122; x=1723051922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5yEPEFi0771LNvWvwfF5uf7i2xAcrMIY+6UjeN6hRQ=;
        b=m0K0noJ4/Z5S9PZdec5mZM0ge32FTVooBujEIDxxDUXa51KNvNMC6DEzDfNffIk1ub
         Xo1eLsBZDIWfh4Ulx1zL5A1vAobZT4o1lUqD5cyJHt7vXI6Xm7hqMQroejugO6UKCwG5
         m3aHR9YTvipfq/QvlacG9fDw9xH63BwjaXsmXysTcXx3EbRbIIdEf5DHPBlzYye0Y08a
         T3Bku15hHV2aJLtNVZInA+UnC62420xNDt48Th3bQhT+aXJuE5+vOQBl2gALe/MptzQe
         lbNKeyZ6w84v1iBPtNVnItAUikjzI4pNRqId4b58SdP6ZKspyhI3tJUXxyuuX6McS9HO
         hpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722447122; x=1723051922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5yEPEFi0771LNvWvwfF5uf7i2xAcrMIY+6UjeN6hRQ=;
        b=GFA3wOs5auwtMIQJD3c5AKm6WpBI06WQRPjLpHED9i33wDjuKcmLI/mGyQRs0zQCoF
         /a6Ff+U7H8YdXKSMhFyal6tbWxH/tTZq6EOPiPnFWcEJx2tl1/qqPXzE3+EImMmG6sgi
         WMv10kMQ0jEGLo+3uk5n/pEpA9szGhHmpvHu0mvaBzsR7v9oVxGaKFPWjpy1+U5O7uqw
         GBx2g4Cfzx9ofosM+BB3EK37gc6lU/Jr3zLWc307syzZr/0ux+W4zhpJRAnKEMVaD2tr
         ibOCYAqOU09Qo950JRd81LiXefLwS0ArSwuOSX5eb/KcLu4CCxcCPSehD4oGnJDxcH3b
         SG6g==
X-Forwarded-Encrypted: i=1; AJvYcCUIQ+C+BJYWUE+ICWfCm7cmLcamiIy6fWYE2bcAh5crRjC5RMC/lTmAP/xdbtmhwtbkpTySdxp7ygUR9/G/Pgb7PVXYnSui8WM3eh2o
X-Gm-Message-State: AOJu0Yzadnb5v4z20UwkTbsSAKsLgSo9fWZUr70wbxnZ7Nal9vbmElvS
	gnjHsuyKx/aWtHmkSRNSpJ5IO/2i8b89HHvNybfIGSjTKTtNfykJHMJ+WzctNox6EAZJmJTqkRq
	hTcfhiF90MsaskuhVuxe06ehmB6WU3btx
X-Google-Smtp-Source: AGHT+IHREKEBLETzlSSNNUjWa05uR1EOp3Lh5JtkMmDDyFsY+27U15bTMNBGSGZx4dmyeGsFt62jaaL9uQJjqGL2/D0=
X-Received: by 2002:a81:c30c:0:b0:649:8f00:5254 with SMTP id
 00721157ae682-67a055ca39emr184757507b3.1.1722447122438; Wed, 31 Jul 2024
 10:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726185825.142733-1-computersforpeace@gmail.com>
 <D32OADQF733D.3CVS3ZRPEBL2O@kernel.org> <454deacb-88cc-4ab0-80b4-006d863a56d2@linaro.org>
 <CAN8TOE8-9=P7p8Tkc+5kG5Sqan+RAWAc7k2VH-p5W9hR-bb_Xg@mail.gmail.com>
 <0685ef1b-b0e1-4c53-94dc-4d5de5be8e94@linaro.org> <D33LRTJ8BE0T.2EQJ1MGLG2NUS@kernel.org>
In-Reply-To: <D33LRTJ8BE0T.2EQJ1MGLG2NUS@kernel.org>
From: Brian Norris <computersforpeace@gmail.com>
Date: Wed, 31 Jul 2024 10:31:50 -0700
Message-ID: <CAN8TOE--TYg8r8qCd_HAZ_w2+wRSPF6RUAuK3g-Po5QPVXdRLQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: micron-st: Add n25q064a WP support
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, linux-mtd@lists.infradead.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:05=E2=80=AFAM Michael Walle <mwalle@kernel.org> w=
rote:
> We really need some kind of dump the relevant registers here. I have
> some very old patch, which dumps the status register, but is has
> it's own quirks. But IMHO we should (maybe additional to the
> functional tests) look at the locking bits in the corresponding
> registers. I.e.
>  flash_lock foobar
>  <verify the status register>
>  flash_unlock foobar
>  <verify the status register>
>  flash_lock barfoo
>  <verify the status register>
>  etc.

I don't actually think that would be a very good test. It would be
testing the implementation more than the functionality. What do you
"verify" in the status register? Would the test just re-implement the
swp.c protection-range logic? And notably, this omits *all* checks
that the protection register actually protects from anything (write,
erase).

Or maybe I'm misinterpreting what you mean.

> Just inferring the correctness from behavior (exercised by writing
> to the flash and verifying it) will lead to errors as it is hard to
> catch all the corner cases.

Why would that lead to errors? It should be relatively easy to:

1. enumerate the supported protection ranges (MEMLOCK / MEMUNLOCK
ioctls on known-likely ranges, looking for EINVAL return codes)
2. iterate through all such ranges; for a given range:
2(a). erase the whole flash
2(b). write the whole flash with a known pattern
2(c). read the whole flash
2(d). ensure that the expected-protected range remains 0xff
2(e). ensure that the expected-unprotected range contains the known pattern

I suppose step #1 can be tough, because the full slate of possible
protection ranges is technically ... enormous. But "likely" ranges are
much fewer, with a few power-of-2 patterns, top/bottom, and maybe some
"both top and bottom" ranges on some flashes? Anyway, like I said in
my other reply, this should take on the order of 60 minutes on some
flashes, which is expensive but not prohibitive.

> From what I remember, flashrom has it's own drivers in userspace,
> no?

Yes, and that's all rather ugly. But it also has a linux_mtd backend
since a few years back:

https://review.coreboot.org/plugins/gitiles/flashrom/+/HEAD/linux_mtd.c

Brian

