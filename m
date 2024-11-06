Return-Path: <linux-kernel+bounces-397531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3386B9BDD12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7E12836AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7851917FD;
	Wed,  6 Nov 2024 02:31:57 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECD4207F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730860316; cv=none; b=jA3McLRwW3gINz+mvD0m1TNgCSBr2ddha3xzQaQ/7H3u8eQFwQFTJYfBdTFva6cQB4hMffDiOx0LXX15Vj77y5GPaSamtJcDedZPCrcaEDOQOLaLjkley0q0PIKei1k0Q2pudQHCDsNJrKdAK5TSLwY4bXtNMkHCeqyu4EODdr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730860316; c=relaxed/simple;
	bh=tVfMiN/1G4bL7S20Au2tc2qwX+CMUgs+LUTAdwJcbZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Oo4op4GDsqxvK77LhrZfdJwe536V8gaNmT9b88kvG1OFLUIemSzhL0WuCml8ZZO7/req9le27GWAZZOD9nwkaZcocTevphQZ2LKCs+9PGs8LAmO7fAFq/GDoxeqk0nuvjXK0s+xIC4gMtmBPpXqyZqUsZfdTDH4u7g8Wzyhej/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so6177094e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730860311; x=1731465111;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVfMiN/1G4bL7S20Au2tc2qwX+CMUgs+LUTAdwJcbZw=;
        b=lrE3RG7OFrHHTClAM/q8MHnloSRr5pxTW4D1i27qkYkM93PM3t41VrJBAvCoXDOs/0
         7bt53FT3imvUpkHjQ1rU/ldSvV/mDJIWuplFbG/kivktc1Zgj+1ktEr5MWlDF1lYiRXF
         x2n5mEjt/ceGvMpHnSkCj8ZY+aqg7rpRGE6TDVCBzZdPV7vyoUA2xOWUKqfwqUMhos4g
         g23ps59tnwzZ+y+dW0ClIl/1LqcbhchCWPVk52QFOCEUHkpuKfEX/zD6IJ0j9O6Tipt8
         dBIAzY4BL2tIt/p07nLbZeIsBvQ7qGlGxf6GzS6ne2lA8DEadoxmMvtwAWe6UaLp0NMV
         DswQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTt1qgGOQ6EHUPuduIFhCvw5FQ/Qgdsda3z1hCRIFvPR5S4nx26Mcoz+WxRy4fXYr45CkRIdtQwrbpaqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxowLgFa30ZFE6h+HR3IEKoc/STEEH7OiO0a5bBqybEVJIN/kb8
	ixD4V/Uhmb0GIknuOsgRB+0DojDCKPMD2It6wtX8OWouufZH+4WOOcxl/D/i
X-Google-Smtp-Source: AGHT+IG5xO53PxcHvwda+W2ChJPdb6M1m5igiOl6L7WmB1bs6jcmhIej9GTUnMRPu+3nAsntAUc6tg==
X-Received: by 2002:a05:6512:1584:b0:539:f26f:d280 with SMTP id 2adb3069b0e04-53b348c38c7mr21697734e87.5.1730860310847;
        Tue, 05 Nov 2024 18:31:50 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcbe17sm2335963e87.197.2024.11.05.18.31.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 18:31:50 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so54691691fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:31:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXi6JGp7JsHS6XCwPhyECw2A0CGbl6mJ5i013q3sCXhG/gDFMkqEPi0twx3Kb0TYoCoPbFlrjdqsdtNJiU=@vger.kernel.org
X-Received: by 2002:a2e:be21:0:b0:2f4:3de7:ac4c with SMTP id
 38308e7fff4ca-2fcbdf68626mr221087231fa.8.1730860309696; Tue, 05 Nov 2024
 18:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
 <20240908214718.36316-2-andrej.skvortzov@gmail.com> <CAGb2v65Laka+YaPyAecwxEhMkoodrXnDPn+UTwZUS_wsSBMzyg@mail.gmail.com>
 <ZuazIgLz5PP_Z8Cn@skv.local> <CAGb2v66-saec9RcQsCTNOz_Tz4+BSFPdDd6CEA+RrGcF6kCY=A@mail.gmail.com>
 <Zyp3N9pGWhLqmtq1@skv.local>
In-Reply-To: <Zyp3N9pGWhLqmtq1@skv.local>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 6 Nov 2024 10:31:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v66DgOmfm0U_dm-+=3nEXaZWUMZiajCdkqVJ6vUPvGC8tQ@mail.gmail.com>
Message-ID: <CAGb2v66DgOmfm0U_dm-+=3nEXaZWUMZiajCdkqVJ6vUPvGC8tQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i-a64-pinephone: Add AF8133J to PinePhone
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Shoji Keita <awaittrot@shjk.jp>, 
	Icenowy Zheng <icenowy@aosc.io>, Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:51=E2=80=AFAM Andrey Skvortsov
<andrej.skvortzov@gmail.com> wrote:
>
> Hi Chen-Yu Tsai,
>
> On 24-10-19 10:04, Chen-Yu Tsai wrote:
> > On Sun, Sep 15, 2024 at 6:12=E2=80=AFPM Andrey Skvortsov
> > <andrej.skvortzov@gmail.com> wrote:
> > >
> > > Hi Chen-Yu Tsai,
> > >
> > > On 24-09-09 16:08, Chen-Yu Tsai wrote:
> > > > On Mon, Sep 9, 2024 at 5:48=E2=80=AFAM Andrey Skvortsov
> > > > <andrej.skvortzov@gmail.com> wrote:
> > > > >
> > > > > From: Icenowy Zheng <icenowy@aosc.io>
> > > > >
> > > > > New batches of PinePhones switched the magnetometer to AF8133J fr=
om
> > > > > LIS3MDL because lack of ST components.
> > > > >
> > > > > Both chips use the same PB1 pin, but in different modes.
> > > > > LIS3MDL uses it as an gpio input to handle interrupt.
> > > > > AF8133J uses it as an gpio output as a reset signal.
> > > > >
> > > > > It wasn't possible at runtime to enable both device tree nodes an=
d
> > > > > detect supported sensor at probe time, because both drivers try t=
o
> > > > > acquire the same gpio in different modes.
> > > > >
> > > > > Device tree fixup will be done in firmware without introducing ne=
w board
> > > > > revision and new dts.
> > > >
> > > > FYI I've been working on an in-kernel prober [1] for such alternati=
ve
> > > > components. This does not require firmware support.
> > > >
> > > > [1] https://lore.kernel.org/all/20240904090016.2841572-1-wenst@chro=
mium.org/
> > >
> > > Thank you for the information.
> > >
> > > I've tried to use in-kernel prober from your v7 patchset [1] on top o=
f
> > > -next and it worked without any changes to firmware.
> > >
> > > Since there is still on-going review of your patches it looks like
> > > it's to early to submit my changes for review. But I'm ready to test
> > > your new patches.
> >
> > FYI I'm open to either approach. If the firmware can do it, that is als=
o
> > fine. I don't know if it makes sense to have both disabled by default
> > though? That would break existing users, but so would the in-kernel
> > prober approach, which requires both components be marked as
> > "fail-needs-probe", and also requires that the kernel driver be enabled=
.
> > In other words, I think the firmware approach is friendlier for existin=
g
> > users that have the original batches.
>
> Current patches leave original magnetometer enabled as before. So only
> the new alternative magnetometer is disabled. Firmware prober will set
> the correct status. So you are right firmware approach is a bit nicer
> for existing users, nothing will change for them with any combination
> of kernel and firmware. Let's go with a firmware approach with current
> patches then, if nobody

If?

I'll wait a day before applying this patch then.

ChenYu

> But I like your in-kernel approach as well.
> JFYI I've applied your v10 patches [1] on top of next-20241105 and retest=
ed
> it with patches for magnetometer. It's available here [2].
>
> 1. https://lore.kernel.org/lkml/20241030072229.1013235-1-wenst@chromium.o=
rg/#t
> 2. https://github.com/AndreySV/linux-stable/commits/in-kernel-hwprober-ma=
gnetometer/
>
> --
> Best regards,
> Andrey Skvortsov

