Return-Path: <linux-kernel+bounces-206547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D28F900B41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C381F22EA8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5B319AA61;
	Fri,  7 Jun 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="IEhWmlGB"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03F1C33
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781407; cv=none; b=RGk/R4yNQT53mPsbc+q21veBb1lQgnPdPkbGxVuUNzepnwiswtURdRMgpn9Ic2Y+gewRmcMgBnqhxzxlbfzMq+LsNH04QBgxYKc8umrYRBZpJK9/TAbBN3EFlih+WM0JhGqa61olWPZB3QOXdklAyKzb9Dvce+eKed4C74P09QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781407; c=relaxed/simple;
	bh=e0AY1UZVACJQd1xtViB6DdfImOxuE/XRpLuic76lORg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5l3G6CH3LT9R44TyqJ13WVhmkDf8PmjWKh+oriz9DwwxbTZIVdXWWtEpmQ3PSzAEFHf+lNPbaGcxWMAOFlD++B0qIX12i5kd40O6QxVckhNnBMILEjxgnU0ip1Rit9QcxCQsLt6oZuw17/dndyq3dblUqXDLLz85lM3n21z3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=IEhWmlGB; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfaff6bee06so732435276.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1717781405; x=1718386205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nfgbbC++t7lQwnyAlEgbOEhZ3OHimWGA3FY8Pt1QloU=;
        b=IEhWmlGBeHl1TIJrNTfFfoy5Bb+iflHJf9jEhuYg5J4ChbMU99fETVxjUO3SEJGeYI
         DHApk1oCdMH3xlDSrjyzFii7tkCxZxjsTpRkcR/PbClR2g7/8dQ0kTfCPJCw0h8BdC9G
         9LAzaEnkkgRj7a0JLoSk3Y7XFRupUYMeim4Z7ZevnO/WDR1ygy/N908lf8NfKho9I0xp
         zBvFvxLkQIWs1xXoQ8eeLyChdJeFJvBSa8ttbuT2qrGBss1puA5YFYfJegrfPZVeyNHW
         ao0ALa8mj1J2bgc9AsVqvgwLN4Ye8vN1xjempHEdSPRrpYE31Aouj4TpHpYd8zSEVOH9
         lVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781405; x=1718386205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfgbbC++t7lQwnyAlEgbOEhZ3OHimWGA3FY8Pt1QloU=;
        b=gmLiUcKqleboY1/xYYlaV3LsoBmb2cJvHXfwFR+dpsuILHPKO0++np2OgwyNz+juok
         alGlS02WbgSpWBVyi/ysydpQdSmnQhDz5pYpmWXJF0tCUAFw7MLuSLKWxDVUuecnfLjY
         Juty8pbKKn8LC9KZuRS1yQ2+MwkHBJn2lycTdCXm453u8gQuB8jpy5sigIYELftWacSw
         1tFDLaF3lLY6tSrMSQnKRBxY/M/yqHBWw0kYFTJ5c688IZdnENHPsVjgqANV+mIqaUc/
         PYAOMsNY5pz9BigBYKqICO1ovNYv6ztsnXK19v7XNvtGqXHHF0k6AeWWd2PfWCw0xcqK
         PFGA==
X-Forwarded-Encrypted: i=1; AJvYcCUbnCKFPKriTSrHI+B7a8eySIyVnaPrnsZt90Gfh4Ge1S5qOFEYy/FTeTEdulxcaHTLnYQ/ysR18x61aTSNqmuylAaGkSle3QrhNd6A
X-Gm-Message-State: AOJu0YzIrZiuPu6PZs0nIau/qawNHq5hLQ7RAnTUGQG6UIVpM2dphlbo
	zoNiz4tFc3Jd6j4MiSI5uE9JAwfVGkCXaVDWztCESOYiktM9811w/DgwaCO1DOi/eFO0RtIC1kb
	UI8QeR/3SM+aDD3x6dA3bgliHf5vjBaYyOua81Q==
X-Google-Smtp-Source: AGHT+IFROFUKI0sxohaL1XWzrCoSNjL5yAeFP8N4BKV2FeWOpDa9kAY7vqeiyaLF0Gf0qs98IHaiGlLSKSLX4TB58WE=
X-Received: by 2002:a25:848d:0:b0:deb:a5bd:b5e9 with SMTP id
 3f1490d57ef6-dfaf65c62aemr2844352276.64.1717781405009; Fri, 07 Jun 2024
 10:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607-trimmer-pummel-b452ed15e103@spud> <20240607155704.GB1242@pendragon.ideasonboard.com>
In-Reply-To: <20240607155704.GB1242@pendragon.ideasonboard.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 7 Jun 2024 18:29:49 +0100
Message-ID: <CAPY8ntBNNOFR1nn05g4Y-SOv_tN0YJv9wygO=+S80-zA1oq7mg@mail.gmail.com>
Subject: Re: [PATCH v1] media: i2c: imx219: fix msr access command sequence
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Conor Dooley <conor@kernel.org>, linux-media@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Adam Ford <aford173@gmail.com>, 
	Andrey Konovalov <andrey.konovalov@linaro.org>, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

Hi Conor and Laurent

On Fri, 7 Jun 2024 at 16:57, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Conor,
>
> Thank you for the patch.
>
> On Fri, Jun 07, 2024 at 04:50:23PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > It was reported to me that the imx219 didn't work on one of our
> > development kits partly because the access sequence is incorrect.
> > The datasheet I could find [1] for this camera has the access sequence:
> > Seq. No. Address (Hex) data
> > 1        30EB          05
> > 2        30EB          0C
> > 3        300A          FF
> > 4        300B          FF
> > 5        30EB          05
> > 6        30EB          09
> >
> > but the driver swaps the first two elements. Laurent pointed out on IRC
> > that the original code used the correct sequence for 1920x1080 but the
> > current sequence for 3280x2464 and 1640x1232. During refactoring of the
> > init sequence the current order was used for all formats.
> >
> > Switch to using the documented sequence.
> >
> > Link: https://www.opensourceinstruments.com/Electronics/Data/IMX219PQ.pdf [1]
> > Fixes: 8508455961d5 ("media: i2c: imx219: Split common registers from mode tables")
> > Fixes: 1283b3b8f82b ("media: i2c: Add driver for Sony IMX219 sensor")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>
> This looks reasonable, based on the above link.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Dave, could you check the impact on the Raspberry Pi kernel ? It seems
> to be shipping the incorrect sequence unconditionally.

I've compared the values against the old firmware driver. There we
have the cropped 1080p and VGA high framerate modes had 0x05 0x0c, and
the full res 3280x2464 and 2x2 binned 1640x1232 modes had 0x0c 0x05,
so the same as the original kernel driver. Not totally unsurprising as
the kernel driver register sets were copied from the firmware.
So the Pi has used imx219 in this manner since launch of the sensor in
2014! Whether that was a transcription typo or an error in the
register sets from Sony I couldn't say (Naush may still have the
original register set information).

I don't have an imx219 to hand right now to test with, but will check
it out on Monday. I'll agree that the patch looks valid based on the
datasheet.

> Any information about what the 12 undocumented MSRs that are programmed
> by the driver do would be appreciated too ;-)

Sadly I have no extra information on those.

> > ---
> > I got the report of this third hand, I don't have a device and can't
> > test this. I do wonder why the RPis get away with the sequence that
> > seemingly doesn't work for the guy that reported this to me. My theory
> > is either that they noticed the sequence was wrong while adding some
> > other MSR access that is needed on this board while either cross
> > checking the values written or because the other MSR accesses didn't
> > take effect.

Did the change fix it for the reporter? We're using the driver with no
changes to the register settings cf mainline.
Why it works on the Pi but not on a Microchip board is likely to be
something quite subtle.

  Dave

> > CC: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > CC: Sakari Ailus <sakari.ailus@linux.intel.com>
> > CC: Mauro Carvalho Chehab <mchehab@kernel.org>
> > CC: Adam Ford <aford173@gmail.com>
> > CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > CC: Andrey Konovalov <andrey.konovalov@linaro.org>
> > CC: linux-media@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  drivers/media/i2c/imx219.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> > index 51ebf5453fce..e78a80b2bb2e 100644
> > --- a/drivers/media/i2c/imx219.c
> > +++ b/drivers/media/i2c/imx219.c
> > @@ -162,8 +162,8 @@ static const struct cci_reg_sequence imx219_common_regs[] = {
> >       { IMX219_REG_MODE_SELECT, 0x00 },       /* Mode Select */
> >
> >       /* To Access Addresses 3000-5fff, send the following commands */
> > -     { CCI_REG8(0x30eb), 0x0c },
> >       { CCI_REG8(0x30eb), 0x05 },
> > +     { CCI_REG8(0x30eb), 0x0c },
> >       { CCI_REG8(0x300a), 0xff },
> >       { CCI_REG8(0x300b), 0xff },
> >       { CCI_REG8(0x30eb), 0x05 },
>
> --
> Regards,
>
> Laurent Pinchart

