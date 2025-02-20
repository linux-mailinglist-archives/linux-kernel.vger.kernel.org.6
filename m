Return-Path: <linux-kernel+bounces-524022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBEEA3DE1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A16817D76A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EAC1FDA7B;
	Thu, 20 Feb 2025 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="EL7gZJKj"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26221CCEF0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064555; cv=none; b=rmRj6uV/57ZIQdid91nMxL5nGchJUXCCLomxUy/sORr1Ieo2r1WZIDcXKiF0K8RR74FMY3Azh7c9VIxTfct0mNBwTKL1bVOyrWzVFbI6U7WI+YmuVmNjWYEDQvJdCGjm3Ue8viFcMBBKG3W5mWEgPesh8q/jCspV96Mh79k3HoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064555; c=relaxed/simple;
	bh=6sQJqtGxtWT9sjnEMH34o2BTX7/zF9LR/I05y8AF02I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSfEURVJSboByfS58pFhSKfFE2rq/zaCtMOrpRqXt3j1/hEUbwqt0pcTLES/NJoYPVhA4eto4vnixqr8AFOCyBakgcw8wrZZnXZJQWf2OS0w5lvuo89DBqX2hAooRbPpP5bqpoKU0pwrGPAlbDfCNIzQjm6cmFN+BmN6bfx/6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=EL7gZJKj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e65be7d86fso19948116d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1740064551; x=1740669351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvqFq3zx/4+DAuES2CFEh+pSNqSinjMtQE5PNQIzM+Q=;
        b=EL7gZJKj8uXPqTxl1gu0531BQyZOcL99Ps4myteKhKlEPRq5uHLb7/yiMqBMzB/B9V
         2KbCRLXNrZGDPURTPxJMJ6eFgc8TWy+HSyxqEv7ezpI1bADUiAesxr4d541g4SqKIqOp
         2GiVti6IOoS/Pv9t1uU11SI2+bdYebz8m373arOZHhN9PoRMUAg64ztFN7NBvUP+p/mQ
         zlSUDnJ431HRtkCV0eq2IHvvtq/4irIC8WKVavxBtEXbgHx1XO0fzCWXT/fS05tgvCC3
         Nr0CnxxE9M9ayoSbeHyRCquq9zQNi8yrKYSyb8yyvRPiOsJTJhe2TBwnjQiNgjsMwrqt
         ntuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064551; x=1740669351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvqFq3zx/4+DAuES2CFEh+pSNqSinjMtQE5PNQIzM+Q=;
        b=WTCfPaKAj7xfLkrNfaxSEdMy8CrKA4tD4vrMBlX9sqD9UHPWT/Wk78i1PxBnd7uXy1
         c7nK49ApTzdUYBvSI7O53LHibqt2HbT3DXd+47Vp0vlujb7MPvWJzeNfCqwBkFx5DI7T
         zT37xuck8iwddaq7a69r0El4+4wAK09sJLzEvRLbN93aSQD/uxn9+Axdj/VYpY1mLgc/
         oBXxMLvfy542l9bS6mGWr/QA5g30/eVFot0sSC5P1FR7uQTw2Q+v1jzuTu4znTwCzalq
         O6uueJr0Whqml7J0nfKhd5NnswwjVw6OCs8y0M/Qa/99IMS5NKXSy4gWcf6vOkJmhynH
         6+eA==
X-Forwarded-Encrypted: i=1; AJvYcCUKu1OGCz6sJKR5I/evkWfTvWscX5HAq8l0O4Qa3u3RznEhBoI/kk5luseaZjjH2IrgSmSNPp5TABG08xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18/FQhGCaW+vZtkh7bute3XsElCwMWr+VGJz/1xbLLo36QgQ3
	jf7iCLWN+quLHSmaUY6WfWyejR0LHubnnWU0PURjyKgTZJ7gwaz1OFbm8pRNCA==
X-Gm-Gg: ASbGncucryVW7ILnTgTqSpOGGFePGiG4pd/YtbcsWLOYgE62foucQ9W3RSQaw2ZpCn/
	y42fqLuf25SON8sOSL1VFLSOUQgYQiKarbO8itZLE3hOrQUmzuQOLPiA6G637UvBn5BwPeeoOim
	LUEujYMhYO9e+6U+kgz3O8np0NX8EN8HJ4IHbRAYUb8cZ44Avg85gExWv/uHmYc/IglJGHmHMSs
	2dnWFWN49L2eWIW2uT4AK6X2mYtbx7tiKC23bahGoHwNyD9UNkrTzC0bzH/hCq0Q3gEYnFamXQl
	Ucj/hKSSvIGkqeD5Wx66lX7OfsD5NxS88g==
X-Google-Smtp-Source: AGHT+IGzataFJehJ6PAd52xp9ykatInv/wr7HUaBcWDAFr+Lvw/Ge0lRdVHOsA5Cj+JsXo3B+tn96Q==
X-Received: by 2002:a05:6214:d8a:b0:6e2:485d:fddd with SMTP id 6a1803df08f44-6e6a259ac8emr50329426d6.1.1740064550761;
        Thu, 20 Feb 2025 07:15:50 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785c09sm86690676d6.36.2025.02.20.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:15:50 -0800 (PST)
Date: Thu, 20 Feb 2025 10:15:47 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: Increase the limit of USB_GADGET_VBUS_DRAW
 to 900mA
Message-ID: <628ea5a8-8ef0-452f-b2b5-4325f98b3bd3@rowland.harvard.edu>
References: <20250120111702.3738161-1-prashanth.k@oss.qualcomm.com>
 <894f42a7-50a5-401e-a705-a06eafd6161d@rowland.harvard.edu>
 <1b1587e8-5c38-4138-a27a-1de71ff07ce3@oss.qualcomm.com>
 <e36303c0-9d1f-4c66-bc40-891958507275@rowland.harvard.edu>
 <d308300f-2559-4d13-8d15-5a2416ac00c9@oss.qualcomm.com>
 <e823a961-a0a1-46c3-84a9-7da3cd718f4c@rowland.harvard.edu>
 <158c9087-8252-432d-92a7-dad69add1133@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158c9087-8252-432d-92a7-dad69add1133@oss.qualcomm.com>

On Thu, Feb 20, 2025 at 09:47:58AM +0530, Prashanth K wrote:
> 
> 
> On 22-01-25 12:56 am, Alan Stern wrote:
> > On Tue, Jan 21, 2025 at 10:19:08PM +0530, Prashanth K wrote:
> >>
> >>
> >> On 21-01-25 08:36 pm, Alan Stern wrote:
> >>> On Tue, Jan 21, 2025 at 09:50:08AM +0530, Prashanth K wrote:
> >>>>
> >>>>
> >>>> On 20-01-25 08:17 pm, Alan Stern wrote:
> >>>>> On Mon, Jan 20, 2025 at 04:47:02PM +0530, Prashanth K wrote:
> >>>>>> Currently CONFIG_USB_GADGET_VBUS_DRAW limits the maximum current
> >>>>>> drawn from Vbus to be up to 500mA. However USB gadget operating
> >>>>>> in SuperSpeed or higher can draw up to 900mA. Also, MaxPower in
> >>>>>> ConfigFS takes its default value from this config. Hence increase
> >>>>>> the allowed range of CONFIG_USB_GADGET_VBUS_DRAW to 900mA.
> >>>>>
> >>>>> Is this the sort of thing that really needs to be a Kconfig option?  Why 
> >>>>> not make the decision at runtime, based on the needs of the gadget or 
> >>>>> function drivers and the connection speed?
> >>>>>
> >>>>> Alan Stern
> >>>>>
> >>>>
> >>>> Right, set_config() in composite.c does this in runtime based on the
> >>>> values of MaxPower (from configFS), VBUS_DRAW defconfig and speed.
> >>>> If we don't set MaxPower from configFS, this config helps to set it
> >>>> during compile time. In fact MaxPower in configFS takes its default
> >>>> value from CONFIG_USB_GADGET_VBUS_DRAW . Sent this patch because Kconfig
> >>>> has this limitation where it's only allowing values upto 500mA.
> >>>
> >>> Why does MaxPower need to be set at compile time?  Why not set it at 
> >>> runtime instead?
> >>>
> >>> If MaxPower gets set at runtime then it can take its default value to be 
> >>> 500 mA or 900 mA depending on the connection speed.  There will be no 
> >>> need for CONFIG_USB_GAGDGET_VBUS_DRAW.
> >>>
> >>
> >> Yes, agreed. Can we mark CONFIG_USB_GAGDGET_VBUS_DRAW as legacy and
> >> maybe also avoid configfs/composite from using it?
> > 
> > Indeed, the whole idea is to avoid using CONFIG_USB_GADGET_VBUS_DRAW in 
> > configfs and composite.
> > 
> > If nothing will still be using it, just remove it entirely.  No need to 
> > mark it as legacy.
> > 
> > Alan Stern
> 
> Hi Alan, small doubt, I see that gadget/legacy/webcam.c is a super-speed
> gadget which uses CONFIG_USB_GADGET_VBUS_DRAW. I'm quite not really sure
> if anyone uses it now, but if someone uses it, then wouldn't my patch be
> applicable there?

A quick search shows that the legacy/gmidi.c driver also uses it.

Still, if these are the only drivers that uses 
CONFIG_USB_GADGET_VBUS_DRAW, it means that parameter isn't really very 
useful.

The best solution I can think of is to make vbus_draw a module parameter 
in for the two drivers, with the default set to 500.  That's more 
flexible than relying on a Kconfig parameter anyway.  Of course, this 
means the .MaxPower field in the webcam_config_driver and midi_config 
structures will have to be set dynamically at runtime.

Alan Stern

> Noticed this while preparing a patch to remove dependency of VBUS_DRAW
> config from configfs/composite layer. Its ready, will send that after
> some testing.
> 
> Regards,
> Prashanth K

