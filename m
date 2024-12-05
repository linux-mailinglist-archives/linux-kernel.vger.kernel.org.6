Return-Path: <linux-kernel+bounces-433286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D49E5604
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A94316922E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C1E218E81;
	Thu,  5 Dec 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6Ry8HFv"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809421C17F;
	Thu,  5 Dec 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403425; cv=none; b=i54MBIB2IPflXIZTpyBm5bMw+3qN0MfBXVV2l2HICgi7CV9TdCH2HrESwNxTA+/pcdbbYDeCTRxsShNeQk35c69prO/eGMGFFSxGFZl7bjmk+msObJgjHNRCZ0cIIL9tFTmrj5EIzw5KB0DE//S6kTkDiYcrSaDZihJNsctaXbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403425; c=relaxed/simple;
	bh=OtPrGa+PVQIZGrgCnFNkqiicK+CaSZ6EhRzRRw3n8jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGGrPPA+QWsv+zAsh7AZv1R9ICW4rC/DmF4RefmVNJw7HIiD3NgoXHxK9hFe4jbLeVssFkouozHV72GQ2HYBA9VQQ8fvdNy89KwcLZbROJLeHzrIS7hBvsxBpQcwctyqCwHisvzIVncAEz0JrsBulGunKZa69JydnGDUhuL4QaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6Ry8HFv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21145812538so6732845ad.0;
        Thu, 05 Dec 2024 04:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733403423; x=1734008223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s138TWZohM7aBFnKWh224iNyNVqKx1gsNG+V3SXG76s=;
        b=k6Ry8HFvzVrmtLnE+u1jMfNkiM3CvZRLhEu3jFr9WbjzIerYJel1TsiLtvx4Fxlshc
         D9postHi9FbtESt7RPKTV/81eWPkXkYzr/wr8tzkXOlepLfDJBRVrVQdXK/eBHIY03RT
         BlejBzAgEnIS5ihU86s4OJhtXtCKQcW5MoifEVQ0l9LzuqJ2BxMW5TM1a0Q1qiVDmJT9
         dMe2pyiAjbxsHAsMFvYuCCFHQVp1CxDgAlFEpgC3oaDW8v8IZ7gkK74PipfrDjPsLjYy
         5nFYbzpf0lszP6Bo/3l2BPBTJlCjemLPmRPwKtOTuGwH1VmwfepxdAoymMO2Crq5PBgx
         s35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733403423; x=1734008223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s138TWZohM7aBFnKWh224iNyNVqKx1gsNG+V3SXG76s=;
        b=QQecGwKSKX9Hw4xwhMZVy/Q2i3VqPrilEiGuO+sBQ0SB0zzaxIbSBY5M4MUR/nvdx2
         bBiQNilYnw8yjJzGvT/TLRE3CFgD+GXFMp8vGL9RGXIDRR3vh/H2cExkLqv2aNxRCkF8
         7naTZiHkzsDYZjOUxM4gp+jo0lxqizype31QW1TbuaCQaCMNJRH4kUfXVGJpQsdkJW6V
         mrVwQitthsJbkDCIfUxzqGBBkdnKrchpbW58NLtpdqvfONgcRK9hmoc7QD6plr+ZPvy4
         Lqscz4pC6zVHx9Bn6pULsoUUvtIos9h+WkPgj5hXNaE+87PKWNBovF2u7QytuFjut4A0
         JSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Uoehqdrvu1fvPbN8/7RxNoJT34Ou40Q+bkJWjOPprgz0dA0EeR0f6k6LJm6n2dDjthLLbInd3rtYrEE=@vger.kernel.org, AJvYcCUBqxT35qL0LAsGERkL5nx8jemSCRWC5pqmYOsf5dqwwyXn6HdQoUt5CfX5tqLr3z0FR2fSZGrLaSY0wx7qBuXHC7fraA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlZyrk4B8qmyzuFYCuJGERBHOjxnLcZGRviX8YbQGrUEPnl5W
	LOXp1rWyGOylL5UJULU7ZcgkQxhNM83V4bEig9ti5SmT8BUpSccaJ/I7jTao
X-Gm-Gg: ASbGnctZpkrx4YAkoYbyhaHKVXkxQ51ReavSMIEJr2FsIEW3mAVAQyQMMo1lLPhj+lX
	cMMQ8qP6Oo5mlI5erxCytS2yc+L0A8WWy1VjP+Zsv0vHRc6yBTnwZTpDiTypUrMWSBe0uUh395Q
	EA3YTl6HL1Kqeaq7ZXwAuq8V9VE25kjqRWXztqFYiy/c1zRsSppmIkSsxGNURpqMJox4cS/PnL2
	sV+3lqyDrtimh/oMqccZEsZQScyFyg1bZUWDjGJ8OFf69KQTh4TXykKA61bM4OoIXd2M45IiQq4
	5EAJyNEC
X-Google-Smtp-Source: AGHT+IFC+OqOoly7EPc/qR068t8AvdPk1wIwrI6PEuA857jAQ5MpyygG8V2v9XDRIpimMyc8ekdG3Q==
X-Received: by 2002:a17:903:234d:b0:215:8af7:efe0 with SMTP id d9443c01a7336-215bd12339amr128706825ad.30.1733403423103;
        Thu, 05 Dec 2024 04:57:03 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f63772sm11601415ad.281.2024.12.05.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:57:02 -0800 (PST)
Date: Thu, 5 Dec 2024 09:56:59 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, platform-driver-x86@vger.kernel.org, 
	w_armin@gmx.de
Subject: Re: [RFC PATCH 17/21] alienware-wmi: Drop thermal methods dependency
 on quirks
Message-ID: <tprks7flnquxt2zqu5zavdpgmsrgh6gmvfrexeom25jbm6fjmi@2fnholyv2c35>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
 <20241205004609.2186681-2-kuurtb@gmail.com>
 <ba1ed892-01e3-20fd-85ce-fae9ad10e96f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba1ed892-01e3-20fd-85ce-fae9ad10e96f@linux.intel.com>

On Thu, Dec 05, 2024 at 01:14:43PM +0200, Ilpo Järvinen wrote:
> On Wed, 4 Dec 2024, Kurt Borja wrote:
> 
> > Make the `gmode` condition on AWCC WMI devices part of the device's
> > state container, and refactor "platform_profile" methods accordingly.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  drivers/platform/x86/dell/alienware-wmi.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index fa21a50d66bd..7137995d5983 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -407,6 +407,7 @@ struct awcc_priv {
> >  	struct wmi_device *wdev;
> >  	struct platform_profile_handler pp_handler;
> >  	enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
> > +	bool has_gmode;
> >  };
> >  
> >  struct alienfx_priv {
> > @@ -1044,7 +1045,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
> >  
> >  	priv = container_of(pprof, struct awcc_priv, pp_handler);
> >  
> > -	if (quirks->gmode) {
> > +	if (priv->has_gmode) {
> >  		u32 gmode_status;
> >  		int ret;
> >  
> > @@ -1070,7 +1071,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
> >  				    priv->supported_thermal_profiles[profile]);
> >  }
> >  
> > -static int create_thermal_profile(struct wmi_device *wdev)
> > +static int create_thermal_profile(struct wmi_device *wdev, bool has_gmode)
> >  {
> >  	struct awcc_priv *priv;
> >  	u32 out_data;
> > @@ -1115,7 +1116,8 @@ static int create_thermal_profile(struct wmi_device *wdev)
> >  	if (bitmap_empty(priv->pp_handler.choices, PLATFORM_PROFILE_LAST))
> >  		return -ENODEV;
> >  
> > -	if (quirks->gmode) {
> > +	if (has_gmode) {
> > +		priv->has_gmode = true;
> >  		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
> >  			WMAX_THERMAL_MODE_GMODE;
> >  
> > @@ -1130,8 +1132,7 @@ static int create_thermal_profile(struct wmi_device *wdev)
> >  
> >  static void remove_thermal_profile(void)
> >  {
> > -	if (quirks->thermal)
> > -		platform_profile_remove();
> > +	platform_profile_remove();
> 
> Did you intend to make this change in this patch?
> 
> I'm unable to confirm why the if () could now be removed and how it is 
> related to other parts of this patch.

This is indeed should not be part of this patch.

In patch 08/21 wmax_wmi_remove() checks for quirks->thermal before
calling remove_thermal_profile() so the this check is safe to drop.

> 
> >  }
> >  
> >  /*
> > @@ -1339,7 +1340,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
> >  	};
> >  
> >  	if (quirks->thermal)
> > -		ret = create_thermal_profile(wdev);
> > +		ret = create_thermal_profile(wdev, quirks->gmode);
> >  	else if (quirks->num_zones > 0)
> >  		ret = alienfx_wmi_init(&pdata);
> >  
> > 
> 
> -- 
>  i.
> 

