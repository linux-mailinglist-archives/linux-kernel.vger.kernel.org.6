Return-Path: <linux-kernel+bounces-433305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A359E563A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706CD1882D24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE93218840;
	Thu,  5 Dec 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPtIcWO2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49264E56C;
	Thu,  5 Dec 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404238; cv=none; b=VCuOk3nGGds3az60ealjkutNtxbK3KCGGO+3BpONMPjWJWR0s7HOt0/5esY4M4rWxIL1Yz2ljFbWmBozSBIzPnLNhdSKFIPE8/FDhFVuYqtuo2Z9qdlKWjJEq6iviqGkMslpZfjcmYHqDW01kxqmcx8X6UDy4yQ5K/IIQXqgqrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404238; c=relaxed/simple;
	bh=1638mbU9R6xgtYtmJ+A/2LpcuIKCMKbVT25qvNZ73XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiwoN58WVXVhxhtNO8qve2uisYMBMM/yy1zoI7EK6uKlULdzZ7yA4+UcCsGo4x4m7hgDyKqIxzntrSJFHaITOv3hFJPXxPsRFKi6YvPEBGXQ66SdKeR0YKQeFiE9O3M1jZtcJcPATBVtua45tuIYJn/82cndOeH0uhGitNALDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPtIcWO2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7259d6ae0c8so864757b3a.0;
        Thu, 05 Dec 2024 05:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733404236; x=1734009036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wz+0QCGLg46FI7gWeB3HyVLLNLxQznsw+U7PUCkbBRM=;
        b=EPtIcWO2K7/VevD/qI0fWruGb4XyGITqotTmUth76PwdGGYrEoakbSosJw6YyPnH0r
         bQBtBF8mlw28Ml7tbBWiyI7yAESpA8bs/UIM6SkRrGEaahwbo7IknBJ6Irf52o5/WRdX
         zO4ufJGcqdXM3eOuYbcRVbMBd7vVjvFc1rER6P9MdICLI/WznqUF1GOwLluwhCDCfVJU
         8T5Cvqb1o0ClJ0mNJJECW20XL3Xe7w3l0zmLH9AlAWk1D1zawkdS0/qxunY1klIR8dQo
         v/JW1ThRxLPU+aIt3tCdzGQMWvjIda/r5wg0ThHXAKh23p07Tld4HBmQuIu9PAlE4LZ/
         iFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733404236; x=1734009036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wz+0QCGLg46FI7gWeB3HyVLLNLxQznsw+U7PUCkbBRM=;
        b=ieRZU1LW36HKpvAtREiTC7SD8iDElnJOvOHYlJpqtadEmgwi8ZCgFM3E/pkyq+Rezu
         UGUAmZPeOVJ2ZQZ5Ly9I0s/56ywbh+87S7Bm1OBzWNtr31Xk7Dm/yADYgvr0GMh/LObX
         AS5wa4eFmZdlS9V2OVnjDKQa+QRm4H8C8Ixuuj30fuiktDe1Ko1MJaRS0tRm/bT8305I
         iQpyrs8ypFLSP+GxO1xBm32zCnXEjs5KLj/IIR6ednegVTZFIJqZH1zDr4wEZClc59wb
         g/IMOqOFNnm9e3w0SYSpWJUotxUOSpkAft2mY23kvF169CKwJmQmRrk99MNf9bvT68Qk
         yH8g==
X-Forwarded-Encrypted: i=1; AJvYcCU5/ak+8s0Y6Nn6k63ZQLVPsMm+Y4f0GLpkI9NpyM4g1YyS8Br8L6+y7bhB/WJP3sRd02tVbaxQGSttM2Q=@vger.kernel.org, AJvYcCXreBVNJzahgBVSOfWXFIzujnYHLVXyW+plUU4VUWyGzR8kGhLmBO53PNctEiii2luxCXs0GWhjpJ+/NdZbg/EqtKIK1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+brlc05RRIj3VnfxOzBhx8XlusbIFwS0qeyKi/OBWSL+6RJa
	H6Gz80cMIkhsCVpAfVgExOwIQh9kIg7juMpCFpKm4NMTYF3ePMB9
X-Gm-Gg: ASbGncttngf+tYNQIVkMysNWN6JgkYbdlVffDt707nZGdHjzxSTE6DMnnBAggJm/Ic4
	j+ZOsPuizIXM202UjFR3e3NLs61wcW8ET3xkN2BySg79S0mVqsG/UhtQ1bARg0F6Hq2eiCWnywn
	KYXRA6t3GpISJeAOVvhGanG0dd8zn2OqVqCQkl/zjh65bAo1PrAUlglTUiUTcaK0VkWWKicv1QI
	N7g4lGdiYGRWwI0HpUtbYbVgcwjMiwxQu2E2tPQKZBn/lLOSOX+84jYWWgiKUcvnhY7b6qVev8Y
	gV+goXoj
X-Google-Smtp-Source: AGHT+IG2w/s2evCb0Z5kY7Z0R6nUnE0q9pJrztdyHTHSLNqfpyRJuLw3NeCmCqT9oRFXABa9C33mlA==
X-Received: by 2002:a05:6a00:4b51:b0:725:1951:79fd with SMTP id d2e1a72fcca58-7257fcdf8admr14287089b3a.26.1733404236439;
        Thu, 05 Dec 2024 05:10:36 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157b1306sm1240870a12.60.2024.12.05.05.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:10:36 -0800 (PST)
Date: Thu, 5 Dec 2024 10:10:32 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, platform-driver-x86@vger.kernel.org, 
	w_armin@gmx.de
Subject: Re: [RFC PATCH 16/21] alienware-wmi: Make running control state part
 of platdata
Message-ID: <foiw2np7nj2qefgdw7t43zuz5kujdgnsllutjqjdoq7i5tkrdy@zfu2pk43crzx>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
 <20241205004534.2186539-2-kuurtb@gmail.com>
 <d0828df1-4a46-2cd3-f15a-b08e5d011bba@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0828df1-4a46-2cd3-f15a-b08e5d011bba@linux.intel.com>

On Thu, Dec 05, 2024 at 01:32:46PM +0200, Ilpo Järvinen wrote:
> On Wed, 4 Dec 2024, Kurt Borja wrote:
> 
> > Both WMI devices have a different "RUNNING" control state code. Make the
> > WMI drivers decide which code to use, and refactor sysfs methods
> > accordingly.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  drivers/platform/x86/dell/alienware-wmi.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index 25e0139ed78c..fa21a50d66bd 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -431,6 +431,7 @@ struct alienfx_platdata {
> >  	bool hdmi_mux;
> >  	bool amplifier;
> >  	bool deepslp;
> > +	u8 running_code;
> >  };
> >  
> >  static u8 interface;
> > @@ -576,18 +577,18 @@ static ssize_t lighting_control_state_store(struct device *dev,
> >  					    const char *buf, size_t count)
> >  {
> >  	struct alienfx_priv *priv;
> > +	struct alienfx_platdata *pdata;
> >  	u8 val;
> >  
> >  	priv = dev_get_drvdata(dev);
> > +	pdata = dev_get_platdata(dev);
> >  
> >  	if (strcmp(buf, "booting\n") == 0)
> >  		val = LEGACY_BOOTING;
> >  	else if (strcmp(buf, "suspend\n") == 0)
> >  		val = LEGACY_SUSPEND;
> > -	else if (interface == LEGACY)
> > -		val = LEGACY_RUNNING;
> >  	else
> > -		val = WMAX_RUNNING;
> > +		val = pdata->running_code;
> >  
> >  	priv->lighting_control_state = val;
> >  	pr_debug("alienware-wmi: updated control state to %d\n",
> > @@ -1249,6 +1250,7 @@ static int legacy_wmi_probe(struct wmi_device *wdev, const void *context)
> >  		.hdmi_mux = quirks->hdmi_mux,
> >  		.amplifier = quirks->amplifier,
> >  		.deepslp = quirks->deepslp,
> > +		.running_code = LEGACY_RUNNING,
> >  	};
> >  
> >  	if (quirks->num_zones > 0)
> > @@ -1333,6 +1335,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
> >  		.hdmi_mux = quirks->hdmi_mux,
> >  		.amplifier = quirks->amplifier,
> >  		.deepslp = quirks->deepslp,
> > +		.running_code = WMAX_RUNNING,
> >  	};
> >  
> >  	if (quirks->thermal)
> > 
> 
> I've not taken extensive look at interdependent changes in the series but 
> while reviewing patch 20/21 I noticed that alienfx_probe() changed there
> from:
> 
> -       if (interface == WMAX)
> -               priv->lighting_control_state = WMAX_RUNNING;
> -       else if (interface == LEGACY)
> -               priv->lighting_control_state = LEGACY_RUNNING;
> 
> to:
> 
> +       priv->lighting_control_state = pdata->running_code;

This was a workaround. I forgot to add this change in this patch. Also I'll
move this earlier in the series.

> 
> Somehow, it felt odd and then looking this patch 16, it felt even odder. 

The reason behind this is that I don't want AlienFX related methods
depending on global variables like `interface` so I can split the file
cleanly.

> Perhaps there's a good reason my review that didn't go deep enough failed 
> to uncover but please check if this is an indication that something is a 
> miss in the series.
> 
> -- 
>  i.

Thank you so much for commenting on the series!

Also, what do you think about the general approach? I was a bit unsure
about the whole "platdata" stuff, as not many drivers use it in this
subsystem.

> 

