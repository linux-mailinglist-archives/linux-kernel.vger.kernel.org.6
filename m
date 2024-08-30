Return-Path: <linux-kernel+bounces-308326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA96965A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 929F0B216FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E513C16D4E6;
	Fri, 30 Aug 2024 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DT4Fb4hV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89D165EED
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006677; cv=none; b=ZU35T2ejTruaWi71w4FTIXEdlalHSACmOPnwhFcXXI/V7a6Gkgs4yT8fKsJ8GnvmJIn7BLHvUVLutHnn/iU37uxIve5dpUpLKG6ey2oBr8xB+Y68ABhS8SMy1tStMYKYspHorCgONz+gVToZUc4/n/fZgz7hmAx7pjQ3S0dQzy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006677; c=relaxed/simple;
	bh=W4okSxmdibTCn4ziAba4VGtgI7xYbgEeikC4yFQw8CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqRGOk0jRZVfc9vguTcmt9K7mKHjAiGQ9Qtbdh25udu7WyasT2eL82yFMVFOoZhnPeK3URCOv28fz7OJ4IaT8ZzYcpQW0kC2sAsQGylucV2pRcCKl8gbingNVVojMr4M80NQTLX9+cH+viwucShYxdy+WWupYHQ13x1a0uBvCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DT4Fb4hV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20202df1c2fso18178765ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725006675; x=1725611475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=71rVnXw0i65nBGRwE4R/+KzqRSoKmH4Qt/FxgbttMc8=;
        b=DT4Fb4hVH+BY7wLSIg6B1gJ0VgZ0wEJXZbeymx+LdZGM4xopYR3+NLR/ozBGtFQGsV
         11/viWBGLzBCYafXWwCS7N2xMvHz0wTR+1JwEyQb7OQ/vcVx6NymvkXGq7jtrzOb2wU0
         m6SilvOp5kzs0KnATYXscG10bKHuLX7fgPaxQSAT3GoFiroksQKmwGFgobSBENqA+L2I
         5oVr4GMQhZIdB3WtHEVatLNLZoYJwXlWuqvOOo9RRtG2XlWtz2r+unMvmL99ui9bINs3
         oDhjGjyPprcKJw11SISJNKDyN66Cwg/EoxJoIgkX7zKhjoDuoAyeBIoFiq6mugI4Qmg+
         5tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006675; x=1725611475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71rVnXw0i65nBGRwE4R/+KzqRSoKmH4Qt/FxgbttMc8=;
        b=QS5KL63U3vQzHHyR7l3RoFmc0l4Nr8RapGXTuwL4n4+CHm6/FpAV1dz9TA3GR/CyxJ
         rBxRnw8Mv9tzqxxWomq5TuXSllRXil8bL5J88NSDaRT5ZTure622dTnrBtxv2q24gWhq
         rWjC42DokW8WbI+kolRnE+hGGHyO57La25LXrfyyaiCawmfe2FvbmTp0k5Jvm6viV51j
         g7gpn6WiUY5g1ekx+1f0n4A+uxwhtc6b8I5srm3+UsfW5btSSBfst5OF97syFXkIRZaF
         Yuw3X0vS4El3KMGDD/JZ3SbSU4ldRappLzxKPY74N0XFQ2o0x4drh1FN7rtlaLWr7OEQ
         rCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnQa2cgs/Xaoya0FKehvNmP7ohhFIxWoUxgjrJpB6SI0G8380PC1xtwLWTLsldBk3ZuiUvO/Fxvlp4PAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz550qE1nI3xdf18Ur5g8n01zX1fm9cTLHu98RILjuJbRpjiSbI
	m+eNFQoXyHN6qYkZzPCWe6iK80WJQnaYpj9gT1ZTjxQEJRB+HXGztj5UuTZmYA==
X-Google-Smtp-Source: AGHT+IGs0iZhk5gbNHCq9v3dOuBh9ghvFXrEwtCBFsFu89+XnsnXwVtuLJqucrsOrTkycWidun15HA==
X-Received: by 2002:a17:902:e546:b0:1fb:9cbf:b4e3 with SMTP id d9443c01a7336-205286b87a6mr26698865ad.22.1725006674696;
        Fri, 30 Aug 2024 01:31:14 -0700 (PDT)
Received: from thinkpad ([117.193.213.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051554cbf1sm22384655ad.240.2024.08.30.01.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:31:14 -0700 (PDT)
Date: Fri, 30 Aug 2024 14:01:07 +0530
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
Message-ID: <20240830083107.4h5ryhcq6e6e5dw3@thinkpad>
References: <20240828-imx290-avail-v2-0-bd320ac8e8fa@skidata.com>
 <20240828-imx290-avail-v2-1-bd320ac8e8fa@skidata.com>
 <20240829131909.GD12951@pendragon.ideasonboard.com>
 <20240829163247.ovsst5ipecthtc6u@thinkpad>
 <20240829164843.GA15799@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829164843.GA15799@pendragon.ideasonboard.com>

On Thu, Aug 29, 2024 at 07:48:43PM +0300, Laurent Pinchart wrote:
> Hi Manivannan,
> 
> On Thu, Aug 29, 2024 at 10:02:47PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Aug 29, 2024 at 04:19:09PM +0300, Laurent Pinchart wrote:
> > 
> > Hi Laurent,
> > 
> > [...]
> > 
> > > > +		dev_err(dev, "Sensor is not in standby mode\n");
> > > > +		ret = -ENODEV;
> > > > +		goto err_pm;
> > > > +	}
> > > > +
> > > 
> > > My last concern is about accessing hardware at probe time. There are
> > > known cases where this is problematic. They can be split in two
> > > categories, systems that exhibit unwanted side effects when powering the
> > > sensor up, and systems where the sensor can't be accessed at probe time.
> > > 
> > > The two issues I can think of in the first category is devices that have
> > > a camera privacy light that could cause worries among users if it
> > > flashes at boot time, and devices that agressively optimize boot time.
> > > 
> > > In the second category, I know that some people use camera serdes
> > > (FPD-Link, GMSL, ...) that are controlled by userspace. As they should
> > > instead use kernel drivers for those components, upstream may not care
> > > too much about this use case. Another issue I was told about was a
> > > device booting in temperatures that were too low for the camera to
> > > operate, which then needed half an hour to heat the device enclosure
> > > before the sensor and serdes could be accessed. That's a bit extreme,
> > > but it sounds like a valid use case to me.
> > > 
> > > What do we do with those cases ? Detecting devices at probe time does
> > > have value, so I think it should be a policy decision. We may want to
> > > convey some of that information through DT properties (I'm not sure what
> > > would be acceptable there though). In any case, that's quite a bit of
> > > yak shaving, so I'm inclined to accept this series (or rather its next
> > > version), given that quite a few other camera sensor drivers detect the
> > > device at probe time. I would however like feedback on the problem to
> > > try and find a good solution.
> > 
> > Most of the issues you mentioned applies to other hardware peripherals also IMO.
> > And it is common for the drivers to read registers and make sure the device is
> > detected on the bus during probe().
> 
> That's true. I think the problem affects different device types
> differently though, and this may (or may not) call for different
> solutions.
> 
> > If an usecase doesn't want to read the
> > registers during probe time, then they _should_not_ build the driver as built-in
> > rather make it as a loadable module and load it whenever necessary. This applies
> > to boot time optimization as well.
> 
> For most of the use cases I listed I agree with you. One exception is
> the privacy light issue. Regardless of when the camera sensor driver is
> loaded, powering the device at probe time will flash the privacy light.
> Doing so later than boot time would probably make the issue even worse,
> I would worry more if I saw my webcam privacy light flashing at a random
> point after boot time.
> 

I'm not familiar with the privacy light feature in camera sensors, but is there
no way to prevent it from enabling by default? If that's not possible, it makes
sense to disable it using a DT property as it is a hardware feature.

> > A DT property wouldn't be feasible as DT is supposed to describe the hardware,
> > not the usecase.
> 
> I think that rule is typically slightly relaxed, by allowing in DT
> system descriptions, not just hardware descriptions. Otherwise we
> wouldn't allow things like reserved memory ranges. Describing that a
> camera sensor has a privacy light, in a way that would allow drivers to
> avoid powering up the device at probe time without requiring much
> duplicated code in all drivers, would in my opinion be an acceptable DT
> usage.
> 

Well, I agree with you. As I said above, privacy light is a hardware feature, so
we can enable/disable it using a DT property. My comment about the DT property
applies only to detecting the devices during probe time, which is a
driver/usecase dependent feature.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

