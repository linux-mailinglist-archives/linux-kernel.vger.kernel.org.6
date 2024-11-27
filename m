Return-Path: <linux-kernel+bounces-423590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0294C9DAA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C03B20F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6D1FF7B9;
	Wed, 27 Nov 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Jpd+arMY"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3B61FF7AF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718641; cv=none; b=ca59fsESzzEURZqU8TYZZL+x56hkl9yqlsAVXwgWFociZ22YzCa0zgjNSo0jf2udK4DWLqjwzpBqxNtAMW2pZzSDWCDO0e6m6OjUpWOAJU3NV0dp8di3qwVHwxOIaHz7irC8i9Yd+ZhJDW5XIbSyU2kSavkvIV6dwpk/OWhe1rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718641; c=relaxed/simple;
	bh=BKyo3SJUCENow7hT34xLm3QSUwMBEZLnMnf1c6fFVlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irQmUPLp1Ko1VDtunkWNK1y3VDPlTbYM6b2orHgacHBiLIeJr2VMHe14RjtXVVsTri3Tg74uYTar+6uYPgd5qrl31z5UMQaZ/XJVOhauBKAXrtJo/ODVb0MVk7aGL45m5+EckJ28wX0CkI+eblYWDfEFtcVANoV+myuVzTyXrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Jpd+arMY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffd796ba0aso7034131fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732718638; x=1733323438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9YVIFse3ZChPt5rxLEsxZQnkg/jV/uGoXgcbdEaGy7I=;
        b=Jpd+arMYwsjdH3sCAJUdTTqlG829VAi/SjdCVQdEh5+XbjHO1ex1HT0Q4zFJqxo2pX
         tTqEY8hFvvNpZzT1wDFXgQxg2FfERbi1hNzpHAL0ZCaB7HTwcvzEnhhi9rsMj2rbKBWP
         XI2ccb5dEBe5hiRsNRxCvpdxrqGlJsuRvIiTWDxmmnxpR93P3k4BQcKnroDDqcAdFXMW
         m75WAf2br4SdQKQ+a3mJbmUgipQ+XwIMBPB0l8lERGO+VQwwKlZVjnbkim3jUk7uTxRo
         4wGtw4Li2wNoDt/24O2Ti3RJBdwRmAFoM902qpa55Zu4R/8t4Qt2G1qcg/gWCVJRyrIj
         zIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732718638; x=1733323438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YVIFse3ZChPt5rxLEsxZQnkg/jV/uGoXgcbdEaGy7I=;
        b=AHsEjLNxpwWmjGcagKQ9/yqccWjuthtLXkqYqgjj7dh2gbwRyxDYyUEcsanrsyOMCL
         MHSYxSequkxJx5Vewwy2NBAHy3wrEK23ewSqRuikAc8SOlYgSFsBmrNAOQHTuEUIPtk2
         R8cBpNaDfRYBUyZGOeE9tHsGt6z79VA2OX4mIv+Vunq2W/VlgPovs7Q1uw4d3tQB6R80
         HsDF+90FbHCrg6a+o30+VF1rr4lpYz7wZ2GVT0+QrB7j3Q+9FYBBSQuLQtAd1Y/dkuzB
         Q7fzc7dj82rtltu/tn/HHLkR3nvz0ed7Gixiv4Y9qV2VuYZ9Dg4uHF/FzDpRjtfXq3oC
         8MPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTS7nUXJZBJI3vUQNwi9tLeMTXYVJOhHq0mGUbRV+J3MzuuwBRcaYs+CzgGyBi8flM1kLPs/i50E77vt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxX/wqSBmMVrLc/Gfm2Ps1+6jEs8uvUEvjkplVC9INsWSCHz2S
	t5zlAp47CAdT1sCigFVq8w1K0SMSVynxRUJ9MAovQKavf6uPNw+5AhOrLI2k9gsksKOUPHIIGNS
	qYMSywG40w6A6Xg8ORLNlHpN6zT7StEFnubMbUQ==
X-Gm-Gg: ASbGncs7I9UzqOGU2bex8FK+BTwTRushUd6xSCRhSfL6KAWx4DgZleQs8hQLtqqY+jf
	yAuiOdXJidjge3i8w5wqUV8Y06FchmhM=
X-Google-Smtp-Source: AGHT+IGRc+pnEqrVmcTeiSgm588KNdJoqDkUIBr6k6jJMRMMQfn38OBTZLWXgC+yJZqrBBmbWXdkKEpuJmNNp8+huYY=
X-Received: by 2002:a2e:b8c9:0:b0:2ff:8a1b:547f with SMTP id
 38308e7fff4ca-2ffd60201f0mr16551901fa.14.1732718637613; Wed, 27 Nov 2024
 06:43:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
 <CAPY8ntBM=34pTiQ=t-CjtYEE5Ax6D=EtiY-sLT1keUkUMXuLeA@mail.gmail.com>
 <20241122-orthodox-mantis-of-reading-2dcdcf@houat> <13cfb66b-f904-4720-8829-a6d9db85aaa5@broadcom.com>
In-Reply-To: <13cfb66b-f904-4720-8829-a6d9db85aaa5@broadcom.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 27 Nov 2024 14:43:38 +0000
Message-ID: <CAPY8ntD7tf6+PXKdWe8_KjCiPoemR0RQDiaHHndtjutOLGbR1w@mail.gmail.com>
Subject: Re: [PATCH 00/37] drm/vc4: Add support for BCM2712 / Pi5 display hardware
To: Florian Fainelli <florian.fainelli@broadcom.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 17:00, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
>
>
> On 11/22/2024 12:06 AM, Maxime Ripard wrote:
> > On Thu, Nov 21, 2024 at 03:37:00PM +0000, Dave Stevenson wrote:
> >> On Wed, 23 Oct 2024 at 17:50, Dave Stevenson
> >> <dave.stevenson@raspberrypi.com> wrote:
> >>>
> >>> This series adds the required DRM, clock, and DT changes
> >>> required to support the display hardware on Pi5.
> >>> There are a couple of minor fixes first before the main patches.
> >>>
> >>> Many of the patches were authored by Maxime whilst working
> >>> for us, however there have been a number of fixes squashed
> >>> into his original patches as issues have been found. I also
> >>> reworked the way UBM allocations are done to avoid double
> >>> buffering of the handles as they are quite a limited resource.
> >>>
> >>> There are 2 variants of the IP. Most Pi5's released to date
> >>> have used the C1 step of the SoC, whilst the 2GB Pi5 released
> >>> in August is using the D0 step, as will other boards in future.
> >>>
> >>> Due to various reasons the register map got reworked between
> >>> the steps, so there is extra code to handle the differences.
> >>> Which step is in use is read out of the hardware, so they
> >>> share a compatible string.
> >>
> >> A gentle ping on the patches for clk-raspberrypi (patches 29-33) and
> >> Broadcom DT (patches 34-36).
> >>
> >> All the DRM and dtbinding ones are reviewed or acked (thank you!).
> >
> > If the bindings and DRM patches are all merged, you can merge these at
> > least.
>
> I will be taking in the DTS patche shortly. Thanks!

Thank you Florian and Stephen.

I messed up and pinged the v1 cover note :( V2 is
https://lore.kernel.org/linux-arm-kernel/20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com/
Thank you Florian for grabbing the correct version anyway, although
there weren't any changes to the DT side anyway.

V2 includes fixing Maxime's comment on "[PATCH 31/37] clk: bcm: rpi:
Allow cpufreq driver to also adjust gpu clocks" that Stephen also
commented on.

Stephen: Sorry, maintaining newbie, particularly for clocks. I see in
linux-clk patchwork they are marked as "Awaiting Upstream". What, if
anything, do I need to do on those?

I've pushed the v2 DRM patches with dtbindings, so the clock changes
are the only ones left.

Thanks again.
  Dave

> --
> Florian
>

