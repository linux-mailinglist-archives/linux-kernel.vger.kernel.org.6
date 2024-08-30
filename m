Return-Path: <linux-kernel+bounces-308774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B41496619A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E6F285069
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FB31AF4C9;
	Fri, 30 Aug 2024 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkmLrCdU"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B1199951
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020738; cv=none; b=jB/jyOnkCt4OSqaOr0PUgUozsdq2n9Ij+5Acl1KjOQ4CAqzxTxO8wqeqVzX51xeVSlWObeHk8CoNKMNdjOTC9HRKs3vHktz3oVEoD/cKQ9vFhYK23w0Ae2nbWLrMB0ti9XJRBMvgRJ9cFardXQ6t214lWh60NZRvBmQqNFzKem0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020738; c=relaxed/simple;
	bh=ZJIoVMrN5tVfBU8IiNUdDELSsGNEPIxY9OghGj9phH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1JRrTGOlDqNyISL1ZcPX6GlUX/5iH7H98Z8fp7Q297dLnbEuOSTYdPRcFgbajfdllD1m3wqdNkMLAMgVOo7SSIu0vkLeVhkILAOiEFeM6oJFJt9DaICj/su4s39w5lKPEgE/28ZH47PSt0gcg/dXergY3kP3/+Wp7jwxT0IZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OkmLrCdU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201d5af11a4so15999095ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725020736; x=1725625536; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tvr2SUWpmWtOp9UmogzHV9P0BvUVUcD5qSF6lHdZQB8=;
        b=OkmLrCdUzfdMGNZe2/WgL1u7q039o7DXsRiF+MpU5ePdTDXZzg4PCtaLRwtl+lxNAk
         npjRA3wDGR3hnT3RPwfZh0SgGWhxr0QbMoHGuEn5z0I1UIf5AMZLd/YgfxF1TaiTS2UP
         tOC01GnnCmdVxuhSFQ/KapSeC88B8nvNKfj+8h7LKUmaPGLa/xqedxK/ERRN9ydt+8rV
         BjSXpiVpgphxdPZx3hlS31ntJNkSsRHzn+fsYSvtqqnqGPgrHjSnuT9AYiEpAMiEhJo9
         jaEoftu3A1lNIBhWp7W1QVyLjDS323twWVQ1ZAgzzQFmtBXLNnbdVSdsvku1ftvvfwQu
         GJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725020736; x=1725625536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tvr2SUWpmWtOp9UmogzHV9P0BvUVUcD5qSF6lHdZQB8=;
        b=HQ29KvLBvEQJayGcu5USJ9sBzaEiKnF5cEkjnYIxrV1iBJUfYYQTIoSc+l98rrpwZh
         vTX7IDRo55J8CKDYlud8/lCRE72epphaquEBVaqAJ6jKWQdnbhaOXwN4lTQyCrtfWUfh
         +NpDUW1NHiv60xPjMkzQjoXl+rcrbEvsAYZocDAny8C+xIoTHMdtciesRSUttOLJInOu
         rsyiCcdHPKX3HoekH12sdY/rTZ3VeSNIqMu6/PdMot1cGxTCm01Clj9o9dOstsj9OwC7
         SZa0M7cmmqGhm7xqThAkeg9h8F4UGTWYgoO4a8q5bCZwPJxbf3+P6LDOkp7qoFJVuvNh
         j3kg==
X-Forwarded-Encrypted: i=1; AJvYcCXkRTpvblTFfltHy1/QHVZZ6Qyn2jji/qfm9xglM2gTe5JHK28EyQF+wvrojNsh7OIxtqhTDJXMQF3uY9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVB+v2scVO0gidv1WKQ2j0p0AkxgSaZRSQVNIiCmGWfOFf1JKs
	pciv7TndHEb7A7gHaK5Ij1Zu+GBIXSZjLKnZWD/xuOoGOJVBtMojRJHfN2uttAeLHha7+uOk1ys
	=
X-Google-Smtp-Source: AGHT+IHLe9KO8QuO+A1TTfdJl2QU4JSom//0uSpdDP64Y03ex+rqWZCqhG3zsGqpapOUxoW7qTxcqg==
X-Received: by 2002:a17:902:e882:b0:202:51ca:9823 with SMTP id d9443c01a7336-2050c4526e7mr63604495ad.46.1725020736332;
        Fri, 30 Aug 2024 05:25:36 -0700 (PDT)
Received: from thinkpad ([117.193.213.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155564dfsm25797685ad.266.2024.08.30.05.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 05:25:35 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:55:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Benjamin Bara <bbara93@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH v2 1/2] media: i2c: imx290: Check for availability in
 probe()
Message-ID: <20240830122529.6dcqamcxk6crfpvb@thinkpad>
References: <20240828-imx290-avail-v2-0-bd320ac8e8fa@skidata.com>
 <20240828-imx290-avail-v2-1-bd320ac8e8fa@skidata.com>
 <20240829131909.GD12951@pendragon.ideasonboard.com>
 <20240829163247.ovsst5ipecthtc6u@thinkpad>
 <20240829164843.GA15799@pendragon.ideasonboard.com>
 <20240830083107.4h5ryhcq6e6e5dw3@thinkpad>
 <20240830092526.GE25163@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830092526.GE25163@pendragon.ideasonboard.com>

On Fri, Aug 30, 2024 at 12:25:26PM +0300, Laurent Pinchart wrote:
> On Fri, Aug 30, 2024 at 02:01:07PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Aug 29, 2024 at 07:48:43PM +0300, Laurent Pinchart wrote:
> > > On Thu, Aug 29, 2024 at 10:02:47PM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Aug 29, 2024 at 04:19:09PM +0300, Laurent Pinchart wrote:
> > > > 
> > > > Hi Laurent,
> > > > 
> > > > [...]
> > > > 
> > > > > > +		dev_err(dev, "Sensor is not in standby mode\n");
> > > > > > +		ret = -ENODEV;
> > > > > > +		goto err_pm;
> > > > > > +	}
> > > > > > +
> > > > > 
> > > > > My last concern is about accessing hardware at probe time. There are
> > > > > known cases where this is problematic. They can be split in two
> > > > > categories, systems that exhibit unwanted side effects when powering the
> > > > > sensor up, and systems where the sensor can't be accessed at probe time.
> > > > > 
> > > > > The two issues I can think of in the first category is devices that have
> > > > > a camera privacy light that could cause worries among users if it
> > > > > flashes at boot time, and devices that agressively optimize boot time.
> > > > > 
> > > > > In the second category, I know that some people use camera serdes
> > > > > (FPD-Link, GMSL, ...) that are controlled by userspace. As they should
> > > > > instead use kernel drivers for those components, upstream may not care
> > > > > too much about this use case. Another issue I was told about was a
> > > > > device booting in temperatures that were too low for the camera to
> > > > > operate, which then needed half an hour to heat the device enclosure
> > > > > before the sensor and serdes could be accessed. That's a bit extreme,
> > > > > but it sounds like a valid use case to me.
> > > > > 
> > > > > What do we do with those cases ? Detecting devices at probe time does
> > > > > have value, so I think it should be a policy decision. We may want to
> > > > > convey some of that information through DT properties (I'm not sure what
> > > > > would be acceptable there though). In any case, that's quite a bit of
> > > > > yak shaving, so I'm inclined to accept this series (or rather its next
> > > > > version), given that quite a few other camera sensor drivers detect the
> > > > > device at probe time. I would however like feedback on the problem to
> > > > > try and find a good solution.
> > > > 
> > > > Most of the issues you mentioned applies to other hardware peripherals also IMO.
> > > > And it is common for the drivers to read registers and make sure the device is
> > > > detected on the bus during probe().
> > > 
> > > That's true. I think the problem affects different device types
> > > differently though, and this may (or may not) call for different
> > > solutions.
> > > 
> > > > If an usecase doesn't want to read the
> > > > registers during probe time, then they _should_not_ build the driver as built-in
> > > > rather make it as a loadable module and load it whenever necessary. This applies
> > > > to boot time optimization as well.
> > > 
> > > For most of the use cases I listed I agree with you. One exception is
> > > the privacy light issue. Regardless of when the camera sensor driver is
> > > loaded, powering the device at probe time will flash the privacy light.
> > > Doing so later than boot time would probably make the issue even worse,
> > > I would worry more if I saw my webcam privacy light flashing at a random
> > > point after boot time.
> > 
> > I'm not familiar with the privacy light feature in camera sensors, but is there
> > no way to prevent it from enabling by default? If that's not possible, it makes
> > sense to disable it using a DT property as it is a hardware feature.
> 
> The whole point of the privacy light is that it shouldn't be possible to
> disable it by software. Otherwise malicious software could try to work
> around it. On many devices it is hardwired to one of the camera sensor's
> power supplies.
> 

Ah okay, please forgive my ignorance here. But still I'm not sure about the DT
usage. Maybe it is best to send out a bindings patch and see what the
maintainers have to say?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

