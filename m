Return-Path: <linux-kernel+bounces-173543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1A18C01FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA3B21843
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB48ECC;
	Wed,  8 May 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="d999NY9F"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7C633
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185921; cv=none; b=drvPlspMfb9/BeMk+QNVo7pUJormKNbmhwUQ1RlqwX/78Oc3fmQlXZ05MUdpV7zrirF/IP58RvsO1k2mNgTrH5MxZPcFrvvgM316HETt4SvCsUJDLbpF3gCWwRfKRMNKIWPjE2oCz6VOqohljUPWCXW7Xtt2sJt8r2Z5sdC8SGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185921; c=relaxed/simple;
	bh=HyI7CfR13ETlHE8vYoaiB6VcQcpejXw10JAvJm1BG8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZESGQ5NYrVmmND8/U7n7a4pkZjOVvWwdSlYHtUxouNFnD5bn+0h6e9ArGZQRZ9Vu3JmqQfNpwl9cc2dLRNmxnXqdSadJJLzKZMwqzOfZKBP/oIlBt8JodCHrPpqcnaZFl6C/sO6fdUQ/N3D6bCq8jn/9opqobUS2g3YSFHTLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=d999NY9F; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-deb99fa47c3so3028351276.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1715185918; x=1715790718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IpqvT/s3hJi/m2NA6vxsDVwPdDU6A01/xZePHqulLGs=;
        b=d999NY9FedIIIfmjQe7VOeVqo4FZn5382/nd66m1q1iSE5u/tRSawUSkSDCtoAGQuX
         S6nDtwPsZLMOsGpGshhCWJsS+ceUt6MTOPlsAKTA0vwtXmHTEQqaZa5j5h6w4UgW3DRY
         HGGPkwVGLyYCt17z7fVMgeOmTiSKRcdauRAVi/tOuvT+fMk6fCwH0Iurg/HQX9T0IXyv
         DzBnLjW1oyGJhpPSqiyj7txetNy1otSbNGuNLTgIaMQvaO0Qn5WeYkfi/ecFysB98HYt
         cvaS6xQhW1XRCaCpcli8T7bmxCiC1i5oxArZALaDjKtyByeGQz/NdCM/UtpXMFuvUQMy
         xmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715185918; x=1715790718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpqvT/s3hJi/m2NA6vxsDVwPdDU6A01/xZePHqulLGs=;
        b=Oz3iMLe03PYbv61vNJ5pblIaop6k1Lhd1/wLFSH8Z3KLrTvOnft3Po+Z9W5giQV7zK
         u7NOmw53UsN1LDMlxjLeWnY0ghbiOqatfRpHqsqzMfMQpCtMRnTnHqoHHrBa1EnjoFaW
         BWyc0cOyk08jZYvFGN6r4DCs+jZad6VwCi7irVYFOAmMrE2y+HPCy7htY4t7Wo4HZkNJ
         5ZBcdJvUwb2xtcBW4XscwTf5iIUd1F2K5x8psaWdAp1dqDDuBwIcbt4vDUsbHCSHx7Gj
         l4ycQXACi5jcPA0uFoKFLkhQ22ekoGlf1s7ir8RYF4rWqyx3hhswdvmdcxNLyuT090I+
         HJrw==
X-Forwarded-Encrypted: i=1; AJvYcCXhPwR6BGFFFAYbezwxgdmzooMIYQL27RrA/RRZynlksfI+03ni/EDtodCFoKwBJmWgFeBBmLVknajPdEjBL1kL0XRwY5QGqnPdJ1N2
X-Gm-Message-State: AOJu0YxCPHDKDPA7EzffpG3PYKqJzBvSUmHVQWCVPD7QHcKd2UznC4r5
	T/BYTTSGr4wQqfBYD9MPsA1zozcdK2GP7yIbgZVzblyZTP2QQHRdqy4LOgpUZfiP+oSZVzG+9Yj
	2wAQpUJamV5F5OrAVJufyGoH+90pSw5qbAm0CcQ==
X-Google-Smtp-Source: AGHT+IH/MU4b0lEqMztmXKc3H0f61MliNMwFr4dmluuoJ6iRqo65l2GtQDlm9o8wIkIkn7RbcEzlRSKc//Wn7bWSkeI=
X-Received: by 2002:a25:b184:0:b0:de5:8816:2d1c with SMTP id
 3f1490d57ef6-debb9e53cebmr3094653276.65.1715185918279; Wed, 08 May 2024
 09:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-linux-next-camss-x13s-mmsol-integration-in-test-imx577-fix-v2-1-2e665f072f8f@linaro.org>
 <dvyed4grpazqk7a3tz6dqwpkd76ghtrt4euinxt3kycdeh63ez@ljgfjsfhypix>
 <20a0300a-ac16-456c-840a-e272f49050a8@linaro.org> <bppn2qglcya3xbfy7uey5cgybyanxthhweqv7foojwi5rvqwmk@temzdedvecfe>
In-Reply-To: <bppn2qglcya3xbfy7uey5cgybyanxthhweqv7foojwi5rvqwmk@temzdedvecfe>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 8 May 2024 17:31:39 +0100
Message-ID: <CAPY8ntAJJu8RM66xFr4dGWtZJVhsjjXEecT5=YKBVr+0hVL9+w@mail.gmail.com>
Subject: Re: [PATCH v2] media: i2c: Fix imx412 exposure control
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Paul J. Murphy" <paul.j.murphy@intel.com>, 
	Martina Krasteva <quic_mkrastev@quicinc.com>, 
	Daniele Alessandrelli <daniele.alessandrelli@intel.com>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jacopo and Bryan

On Wed, 8 May 2024 at 13:43, Jacopo Mondi <jacopo.mondi@ideasonboard.com> wrote:
>
> Hi Bryan
>
> On Wed, May 08, 2024 at 01:30:31PM GMT, Bryan O'Donoghue wrote:
> > On 08/05/2024 09:02, Jacopo Mondi wrote:
> > > Hi Bryan
> > >
> > > On Mon, May 06, 2024 at 11:38:26PM GMT, Bryan O'Donoghue wrote:
> > > > Currently we have the following algorithm to calculate what value should be
> > > > written to the exposure control of imx412.
> > > >
> > > > lpfr = imx412->vblank + imx412->cur_mode->height;
> > > > shutter = lpfr - exposure;
> > > >
> > > > The 'shutter' value is given to IMX412_REG_EXPOSURE_CIT however, the above
> > > > algorithm will result in the value given to IMX412_REG_EXPOSURE_CIT
> > > > decreasing as the requested exposure value from user-space goes up.
> > > >
> > > > e.g.
> > > > [ 2255.713989] imx412 20-001a: Received exp 1608, analog gain 0
> > > > [ 2255.714002] imx412 20-001a: Set exp 1608, analog gain 0, shutter 1938, lpfr 3546
> > > > [ 2256.302770] imx412 20-001a: Received exp 2586, analog gain 100
> > > > [ 2256.302800] imx412 20-001a: Set exp 2586, analog gain 100, shutter 960, lpfr 3546
> > > > [ 2256.753755] imx412 20-001a: Received exp 3524, analog gain 110
> > > > [ 2256.753772] imx412 20-001a: Set exp 3524, analog gain 110, shutter 22, lpfr 3546
> > > >
> > > > This behaviour results in the image having less exposure as the requested
> > > > exposure value from user-space increases.
> > > >
> > > > Other sensor drivers such as ov5675, imx218, hid556 and others take the
> > > > requested exposure value and directly.
> > >
> > > has the phrase been truncated or is it me reading it wrong ?
> >
> > Sod's law says no matter how many times you send yourself a patch before
> > sending it to LKML you'll find a typo ~ 2 seconds after reading your patch
> > on LKML.
> >
>
> Sounds familiar enough
>
> >
> > > > Looking at the range of imx sensors, it appears this particular error has
> > > > been replicated a number of times but, I haven't so far really drilled into
> > > > each sensor.
> > >
> > > Ouch, what other driver have the same issue ?
> >
> > So without data sheet or sensor its hard to say if these are correct or
> > incorrect, it's the same basic calculation though.
> >
> > drivers/media/i2c/imx334.c::imx334_update_exp_gain()
> >
> >         lpfr = imx334->vblank + imx334->cur_mode->height;
> >         shutter = lpfr - exposure;
> >
> >         ret = imx334_write_reg(imx334, IMX334_REG_SHUTTER, 3, shutter);
> >
> >
> > drivers/media/i2c/imx335.c::imx335_update_exp_gain()
> >
> >         lpfr = imx335->vblank + imx335->cur_mode->height;
> >         shutter = lpfr - exposure;
> >
> >         ret = imx335_write_reg(imx335, IMX334_REG_SHUTTER, 3, shutter);
> >
> >
> > Looking again I'm inclined to believe the imx334/imx335 stuff is probably
> > correct for those sensors, got copied to imx412/imx577 and misapplied to the
> > EXPOSURE control in imx412.
> >
>
> Without datasheet/devices it really is hard to tell. Cargo cult at
> play most probably.

For reference certainly imx327/290/462 which are all siblings in the
Sony Starvis family do calculate exposure as
exposure = 1 frame period - (SHS1 + 1) * (1H period)
So 0 = max exposure and bigger values are shorter exposure time.

I'm not saying that the imx412 driver is right in doing this as well,
but it seems there is a trend with the Sony Starvis family to program
exposure in this different manner. Don't discount it as wrong for all
drivers!

  Dave

> >
> > > > - ret = imx412_write_reg(imx412, IMX412_REG_EXPOSURE_CIT, 2, shutter);
> > > > + ret = imx412_write_reg(imx412, IMX412_REG_EXPOSURE_CIT, 2, exposure);
> > >
> > > No datasheet here, can you confirm the IMX412_REG_EXPOSURE_CIT
> > > register is actually in lines ?
> >
> >
> > Looks like.
> >
> > From downstream "coarseIntgTimeAddr"
> >
> > imx577_sensor.xml
> >     <coarseIntgTimeAddr>0x0202</coarseIntgTimeAddr>
> >
> > imx586/imx586_sensor.cpp
> > pRegSettingsInfo->regSetting[regCount].registerAddr  =
> > pExposureData->pRegInfo->coarseIntgTimeAddr + 1;
> >
> > pRegSettingsInfo->regSetting[regCount].registerData  = (lineCount & 0xFF);
> >
> > > Apart from that, as the CID_EXPOSURE control limit are correctly
> > > updated when a new VBLANK is set by taking into account the exposure
> > > margins, I think writing the control value to the register is the
> > > right thing to do (if the register is in lines of course)
> > >
> > > Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > >
> > > Thanks
> > >    j
> > >
> >
> > If that's good enough I'll fix the typo and apply your RB.
>
> Sure
>
> Thanks
>   j
>
> >
> > ---
> > bod
> >
>

