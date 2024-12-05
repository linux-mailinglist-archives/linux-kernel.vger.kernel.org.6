Return-Path: <linux-kernel+bounces-433353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B09E5754
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665391884E7C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDEE218EA4;
	Thu,  5 Dec 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0EtsQai"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE62185AC;
	Thu,  5 Dec 2024 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405701; cv=none; b=LJbb8GHMvz73U9Z8MdN5g0mjaIoWAc0WiutDiiKOGLcm1MWmR6YcyahniqXuZvUMDKv8F3nTTpxPJfgH+F8H9beUJh78Kan5g67iIOmJiIspZACbi4F/BllwdD6h4fkGZpYIKqnZrP9CXgUyHbUtpq+0DWt5CUvxmiUJp/0DTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405701; c=relaxed/simple;
	bh=MbJGCoYqcCq5hCwG5sy5ZqPkTBw9NO6IV8jhsPWs8dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuCOKjdgvv+QNdqX+Amp/KUxPhQq42qf/L63mquiD1y0TxrgtClLXciIYIl2fO8NaVkP4yahYMZBHMNsxvrW6WRxQhi0mGzKiEcqlWcwWjMhR1WvQU+qTGZfkSXclOV74VRwFZz+pm5UCfxFam2sgGF27Y4d1q4TXlPIP/W/lP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0EtsQai; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7252b7326f4so781582b3a.2;
        Thu, 05 Dec 2024 05:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733405699; x=1734010499; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lmaMe+macmiP2X/9Fl+r7HIK5Cma8viDkEYR2H3Mp/U=;
        b=E0EtsQai+aWlzwlYLck1UqPW8pkCfYT+XOys6XZHniuq1dAEElHVp+T4xIi6kJeTs5
         OtGIert/az3VOp6Fk/lXmnjGdvxz8xv2wOznV/S6RlQSBsKqZGnMSlIuLhhjpWTTeGX2
         SSVZcZhHQo0Y4g5v6CtiN8MssiE1X7SWm6BfrQ7cjkTG91BvOm3L9b8ER4GbtgZRwzVJ
         vq1rKhZ3Kwh73AQp+MVOSDep7iBW/Z7lYHWuVWP1Q8JjbC7NnefBpWXIdXGNJic/5Kiu
         GIJNMEBI14rW79QY38Kq7eKuh2KJlD9u2MjLXTtVyI8uJkjzV1qO+GajGPafbqjROyo5
         x1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733405699; x=1734010499;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmaMe+macmiP2X/9Fl+r7HIK5Cma8viDkEYR2H3Mp/U=;
        b=gxbi5qWt1zxOADS+tTi63u3+2krvrc9s+7bKzzHIO3GLT3FI0EJ2SQMQGdl4DZ/LF7
         eYEWO2ZrhU6IKXBEF1fr37ljDnY8o+1+tOGCPfKDpGytJ+30ftrLqPYhikVpEo5EAtB9
         fnhk2j1ajgIHm2DtyJ8kQHuyenj7lJ644VIZaqL/FX/3owNA2ybHh/viCwfQXDEKacUZ
         LKS3oIr9fL+D7yQsJ9bfqZbroz1YZYWT10gWccUc23mAoubzhcTJoQQibHQ2xHcXZOTe
         qyIgb2xvl3WQWUNtjZgdx2BvErI8vRqkGNeMy45endpkXSOiNAR8/9TumJKXELmRqRfY
         IIOA==
X-Forwarded-Encrypted: i=1; AJvYcCUTRLTJIo/t76Gs7eDF+ZHL9rYqJutxzbyXY2ADACD1etAklc/xhbXejzZ0TpANYVDM/SUkePsr5V/Th6hF8pMdUjZ8Dg==@vger.kernel.org, AJvYcCVq4wut3ZQeLPO0qSplkRPYYwjoCW0qPnftDgmJTbUPtRn5a6b+S4MbgnlYIlahya8K6AdYFPZs+lcGd6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxKglioZbkBVBvgblFCKvO4AHIbQAYQTMRBVXbPpfeyiqmBaeH
	EbWlgcTHQOgCm55XkFUMkY3RxklHOoz5usmKu6WfxZd/0mkur5sb
X-Gm-Gg: ASbGncvDobwzV9V2Yc3izcNxxn2QlV9ZJydbOnSo/zxEZhNhC+jeK8Xsfv+BDDmvCxJ
	raIh8k3QGltP/0qnuzEB4FX2MZ4hFPHrhZJv0fJ21mRXnKJbbsSrjAiXEd0rMoJxSC2QOG+2TuI
	UL5C/BSX78D7o7ieE+tYGJO4fVSh1le1WQBhYUetQYYzi71CnKsD5KUbUjzz5XUXB/FCtAQwEMJ
	BLjvFr42i5g8K+2tTbqJ8mbEJM/XWuoIkukbCk22pBqM6V83M3PG7W3gH/7q1JBVIIc8dd8577T
	GwJxu7kk
X-Google-Smtp-Source: AGHT+IGNa+EIsm5xVIkM3wmX5wX5zPoM7Lus9YIDldrGf4LGEHJGPWbbLwLrKv7iB2IX6jaK/w+tvQ==
X-Received: by 2002:a05:6a00:1782:b0:724:5aac:1687 with SMTP id d2e1a72fcca58-7257fcb029fmr13652653b3a.20.1733405699044;
        Thu, 05 Dec 2024 05:34:59 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156c4373sm1133507a12.21.2024.12.05.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:34:58 -0800 (PST)
Date: Thu, 5 Dec 2024 10:34:54 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, platform-driver-x86@vger.kernel.org, 
	w_armin@gmx.de
Subject: Re: [RFC PATCH 05/21] alienware-wmi: Refactor rgb-zones sysfs group
 creation
Message-ID: <nsx7vz5qtbxo5vq3ukzhfopkyrsi2bnhhelfpvxolqqdiokg25@6bgy5nclgftc>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
 <20241205004005.2184945-2-kuurtb@gmail.com>
 <5d0ebcc9-062d-7252-956a-2ad8294d7077@linux.intel.com>
 <fme54i5psnvamh6u7u7o7wlnyzpstiuus6jk73tkjfkoulg2m6@kxicd7efw2rx>
 <b051f580-a6e0-bd32-a6ad-2d172de3aecc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b051f580-a6e0-bd32-a6ad-2d172de3aecc@linux.intel.com>

On Thu, Dec 05, 2024 at 03:18:20PM +0200, Ilpo Järvinen wrote:
> On Thu, 5 Dec 2024, Kurt Borja wrote:
> 
> > On Thu, Dec 05, 2024 at 12:17:01PM +0200, Ilpo Järvinen wrote:
> > > On Wed, 4 Dec 2024, Kurt Borja wrote:
> > > 
> > > > Define zone_attrs statically with the use of helper macros and
> > > > initialize the zone_attribute_group with driver's .dev_groups.
> > > > 
> > > > This makes match_zone() no longer needed, so drop it.
> > > > 
> > > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> 
> > > >  	zone_data =
> > > >  	    kcalloc(quirks->num_zones, sizeof(struct platform_zone),
> > > >  		    GFP_KERNEL);
> 
> You kcalloc() zone_data here for quirks->num_zones entries....

Totally missed this, thanks. 

> 
> > > > -	for (zone = 0; zone < quirks->num_zones; zone++) {
> > > > -		name = kasprintf(GFP_KERNEL, "zone%02hhX", zone);
> > > > -		if (name == NULL)
> > > > -			return 1;
> > > > -		sysfs_attr_init(&zone_dev_attrs[zone].attr);
> > > > -		zone_dev_attrs[zone].attr.name = name;
> > > > -		zone_dev_attrs[zone].attr.mode = 0644;
> > > > -		zone_dev_attrs[zone].show = zone_show;
> > > > -		zone_dev_attrs[zone].store = zone_set;
> > > > +	for (zone = 0; zone < 4; zone++)
> > > >  		zone_data[zone].location = zone;
> > > 
> > > You allocate quirks->num_zones entries to zone_data above but use a 
> > > literal here?
> > 
> > I did this because quirks->num_zones controlls only visibility now.
> 
> This kind of information would be useful to put into the commit message!
> 
> It does not control only visibility, see the kcalloc() code above. Did you 
> mean to alter the alloc too but forgot?

Yes I did not pay much attention when modifying this function. I'll fix
it.

> 
> > I didn't feel comfortable leaving an out of bounds access on zone_show()
> > and zone_set() when they do `zone_data[location]`.
> > 
> > Still those out of bounds accesses are hidden from user-space (right?) and
> > alienware_wmi_init() is getting dropped anyway so I should just leave it
> > as zone < quirks->num_zones.
> 
> The assignment within this loop will write out of bounds if 
> quirks->num_zones is less than 4.
> 
> -- 
>  i.


