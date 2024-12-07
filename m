Return-Path: <linux-kernel+bounces-435861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063EE9E7E02
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CF118877FD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507C17C7C;
	Sat,  7 Dec 2024 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSwV6gW1"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30713323D;
	Sat,  7 Dec 2024 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537439; cv=none; b=b7OXiKebskEslH5uAjbpg3ccznbJ/a6XjMpGk6PDCLOdDn228KehU2vLlQ7o0W14+ZkKb1zt7iGb86530L4bLVVNkM3l3ZjPbSkdIz4rzL5GYspBWfzuhBgzp9Ue2tEaUGSnho89d2qArVxo9Kj7YeOO/LR0pXlN2COACidfauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537439; c=relaxed/simple;
	bh=s0Oq9Lh1YTUOKSkCtTlhPCcTo7WgWmAFvr1RKaWI7yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvGuX1zicMhWHaXQ8lHzn7nNysGU096YDqN/4lRyZyjO6/3UsrkIrDi51kQE+uz39E46kvqcy0dOVZgzL2FRVJs2TEKRBRWNbshIlKj5FOjTrnmctb8jO4Rqxa2XsDogUAPKl5Bfo5o+U2pyC2eKWZ15hfwbg1lVzD6tJRXU/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSwV6gW1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215bebfba73so26157135ad.1;
        Fri, 06 Dec 2024 18:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733537437; x=1734142237; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=phsanf5BfVhVLiPeJCq0AKZ3yHarN8vyCxT66eDeunw=;
        b=dSwV6gW1HZp4912mMflBktyLvjhQRFTD4Jk0kHu1P/9J8Fwk1s2wUuQ/2O50ziquQX
         XGLvcUv56Uit9761ILq0qIVjtn5SB+MzYkjgwR/Gg0Ug97OqmE+xHpYCEwmn9/D8/s3V
         N3BkOuNvk+QzPgsbuvvisu8u7LQ5TFk9MqYPgGgTSKEY89ILba7IlJ7RIWIxFFDZGah6
         rVhKQef4stouO85sxIiQn7CLM4Yz7p2YmS1WbCX9tkwyvu+0mw9DeIUUKTcmcw852UIy
         HMO8qVxCIOW75DIIzuhTgjsbvQOBgpnjI+CgvRVKhQL7Z8nwgUJG+TFJVeoJql7HyT5j
         Qj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733537437; x=1734142237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phsanf5BfVhVLiPeJCq0AKZ3yHarN8vyCxT66eDeunw=;
        b=feNvM0z2T9JY8EHkP51kdjgLuoytdwwpHrYBUA1Oi975PPjsyny2sk8zRDf7Z/rtHv
         jgw40EnQ+UK1YHcopQKOJgAU4gFTGm3bQxglCDsXgECT6qOKX5T+zE5YrhgBBQBc+EjG
         zxwAc3W+pPEIvP10K5pMOtLLqAqxtINd2RmC+6jfJ6fxOuq6GSG02HEWf8Lb1dHC7MJS
         UGay4PAvIXmzc5BhPg4xIYcmc1I0uFjTxlO59QU0BAfhD5vTVjUejMtltZ5eVk7DYfll
         ufq751cgUZKn4YVzyhqtBZ6F42DnQsJjBI5Y1H4w7olpA8HXCiEIsbYCaHqXSJvcGSXj
         zGDA==
X-Forwarded-Encrypted: i=1; AJvYcCUMvlLpXCKzKVEUCMeeVwiTnYmWgyMCr2z1l48JlZf2/Pu6c5ynrkCdxLGWr4pLRBaomlGALyiCx+4+r8k=@vger.kernel.org, AJvYcCV30pwQfMMd0ZrzIUuzzcCOK46nav6S31Y4G3wJVkL26WT3c7+3HwGG2SStZaKMOssScQRsE3Fm8THCADH3Jr9niBhV9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhlEbGRqFWl1DMBi7rWiW9YVDaM6zQ0FL8Pk824v/Zzv3tsVv
	n5K0HLwSpL72yG87rnJBVHZ1DG0mpZiZbsjuhRELsu10zTxV0pKm
X-Gm-Gg: ASbGncsWUpHPUfyh2LonmnvosRZgiWnK+LTR1YGz1jqo9ENHzF2dMNpTG/+YELQYOn0
	hrPGdvqu72yZIxHXrx2meRuya9blGrfvu/zs33Y89GU79W9CGTIndlbiIZIysLBHOQnk1El6DdY
	cEb5Si+U2d5dqD14WCs/Vzm/3Mr7FCMeLjBrYflwrpqgiS6wO90s6SGM14ds/cHBR0OZyc/nWQ3
	7vtYf87ARAt5HxABMggH8ShDgdaZbzmiljafwxAjCCOlJA/U7HR3SiBvddNTC3bXM/f8vmTpK7I
	bh2FbvsB
X-Google-Smtp-Source: AGHT+IFcxA1iyHtrWnXW6wXTf3e5iqB7hq9elMI3DJrS1+TcZBWQSd+AY5nQefyuB2Maodx8PcIPzg==
X-Received: by 2002:a17:903:120d:b0:215:7cd0:758d with SMTP id d9443c01a7336-21614dc51e4mr76282305ad.36.1733537437371;
        Fri, 06 Dec 2024 18:10:37 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efc410sm35038565ad.169.2024.12.06.18.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 18:10:37 -0800 (PST)
Date: Fri, 6 Dec 2024 23:10:33 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, platform-driver-x86@vger.kernel.org, 
	w_armin@gmx.de
Subject: Re: [RFC PATCH 16/21] alienware-wmi: Make running control state part
 of platdata
Message-ID: <36iviudta4xzkktc2pamsh5oiq6kfz3rx2rj65kjsnkmj6eouz@3jwssui5xb4l>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
 <20241205004534.2186539-2-kuurtb@gmail.com>
 <d0828df1-4a46-2cd3-f15a-b08e5d011bba@linux.intel.com>
 <foiw2np7nj2qefgdw7t43zuz5kujdgnsllutjqjdoq7i5tkrdy@zfu2pk43crzx>
 <c0af93e4-f2a6-bf2e-787d-7a360286ac8a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0af93e4-f2a6-bf2e-787d-7a360286ac8a@linux.intel.com>

On Thu, Dec 05, 2024 at 04:06:23PM +0200, Ilpo Järvinen wrote:
> On Thu, 5 Dec 2024, Kurt Borja wrote:
> 
> > On Thu, Dec 05, 2024 at 01:32:46PM +0200, Ilpo Järvinen wrote:
> > > On Wed, 4 Dec 2024, Kurt Borja wrote:
> > > 
> > > > Both WMI devices have a different "RUNNING" control state code. Make the
> > > > WMI drivers decide which code to use, and refactor sysfs methods
> > > > accordingly.
> > > > 
> > > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > > ---
> > > >  drivers/platform/x86/dell/alienware-wmi.c | 9 ++++++---
> > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > > > index 25e0139ed78c..fa21a50d66bd 100644
> > > > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > > > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > > > @@ -431,6 +431,7 @@ struct alienfx_platdata {
> > > >  	bool hdmi_mux;
> > > >  	bool amplifier;
> > > >  	bool deepslp;
> > > > +	u8 running_code;
> > > >  };
> > > >  
> > > >  static u8 interface;
> > > > @@ -576,18 +577,18 @@ static ssize_t lighting_control_state_store(struct device *dev,
> > > >  					    const char *buf, size_t count)
> > > >  {
> > > >  	struct alienfx_priv *priv;
> > > > +	struct alienfx_platdata *pdata;
> > > >  	u8 val;
> > > >  
> > > >  	priv = dev_get_drvdata(dev);
> > > > +	pdata = dev_get_platdata(dev);
> > > >  
> > > >  	if (strcmp(buf, "booting\n") == 0)
> > > >  		val = LEGACY_BOOTING;
> > > >  	else if (strcmp(buf, "suspend\n") == 0)
> > > >  		val = LEGACY_SUSPEND;
> > > > -	else if (interface == LEGACY)
> > > > -		val = LEGACY_RUNNING;
> > > >  	else
> > > > -		val = WMAX_RUNNING;
> > > > +		val = pdata->running_code;
> > > >  
> > > >  	priv->lighting_control_state = val;
> > > >  	pr_debug("alienware-wmi: updated control state to %d\n",
> > > > @@ -1249,6 +1250,7 @@ static int legacy_wmi_probe(struct wmi_device *wdev, const void *context)
> > > >  		.hdmi_mux = quirks->hdmi_mux,
> > > >  		.amplifier = quirks->amplifier,
> > > >  		.deepslp = quirks->deepslp,
> > > > +		.running_code = LEGACY_RUNNING,
> > > >  	};
> > > >  
> > > >  	if (quirks->num_zones > 0)
> > > > @@ -1333,6 +1335,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
> > > >  		.hdmi_mux = quirks->hdmi_mux,
> > > >  		.amplifier = quirks->amplifier,
> > > >  		.deepslp = quirks->deepslp,
> > > > +		.running_code = WMAX_RUNNING,
> > > >  	};
> > > >  
> > > >  	if (quirks->thermal)
> > > > 
> > > 
> > > I've not taken extensive look at interdependent changes in the series but 
> > > while reviewing patch 20/21 I noticed that alienfx_probe() changed there
> > > from:
> > > 
> > > -       if (interface == WMAX)
> > > -               priv->lighting_control_state = WMAX_RUNNING;
> > > -       else if (interface == LEGACY)
> > > -               priv->lighting_control_state = LEGACY_RUNNING;
> > > 
> > > to:
> > > 
> > > +       priv->lighting_control_state = pdata->running_code;
> > 
> > This was a workaround. I forgot to add this change in this patch. Also I'll
> > move this earlier in the series.
> > 
> > > 
> > > Somehow, it felt odd and then looking this patch 16, it felt even odder. 
> > 
> > The reason behind this is that I don't want AlienFX related methods
> > depending on global variables like `interface` so I can split the file
> > cleanly.
> 
> Just to make sure we don't talk past each other, I didn't mean the code 
> itself felt odd, just the patch it was changed in. So if your plan was to 
> have it in this patch to begin with but you noticed the problem while 
> doing the other change and put it "temporarily" there and forgot to move 
> it into correct place, no oddity problem then. :-)

No worries, I explained my intention just in case it was confusing.
Thank you for clarifying :)

> 
> > > Perhaps there's a good reason my review that didn't go deep enough failed 
> > > to uncover but please check if this is an indication that something is a 
> > > miss in the series.
> > > 
> > 
> > Thank you so much for commenting on the series!
> > 
> > Also, what do you think about the general approach? I was a bit unsure
> > about the whole "platdata" stuff, as not many drivers use it in this
> > subsystem.
> 
> I'm sorry but I've not come across it much so I'm not sure if my opinion 
> is that valuable.
> 
> What I can say for sure though is that the wide-spread use of global-level 
> variables in pdx86 drivers is definitely not setting a good example.

In that case I'll stick with it for now!

~ Kurt

> 
> -- 
>  i.


