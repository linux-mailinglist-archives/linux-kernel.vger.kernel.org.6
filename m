Return-Path: <linux-kernel+bounces-279891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3594C31D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC21A1C21E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989D19048A;
	Thu,  8 Aug 2024 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL5OZUB7"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82721F19A;
	Thu,  8 Aug 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136084; cv=none; b=U3J98/iJu95SLiEu9OhygFYz2dMphQi08ogIK8pDFqhMFtBmUWHKvIVU/4xk5bCaW2GjRov1oCLsnEPKdTI1+w03QmR7M1sCYqrdxAdEoL8wYLKJJruRBWLHUYuhj9ZUdYSIO+4LpGjnATht388KkclsnXaEXi9yvieg0hdVxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136084; c=relaxed/simple;
	bh=F51NZMZKlIVOUokpqmJ++TqU6OeEn9SIj5K+CmrXoAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTqGIGXWp/3W/3bZgItsNIjR1+AwbpK7QZPRCkenmwtgWylbalzHNWnE4RSjOf5A62WMmxvwR6gkh+FzUk4pWn2vaKWgNwCSJc81HXP+KeNPF+9chGS6IxHe9LIfurfFfdUunYCwdPgwYGAi9Iemw+O2xkJ82RNaciGwPbm5q1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL5OZUB7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cfdc4deeecso987982a91.3;
        Thu, 08 Aug 2024 09:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723136082; x=1723740882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aicxt+UzDt3qNgwZqQLVh/meDWsH0wnhB4ZpKgCLbeA=;
        b=bL5OZUB7V2ALsANUnsApw3OuVgozmrT/cbZ+VT1s0Hgq3ICQaqmYYOQ3mWk1tV+lNz
         gUY9fnwRYYDHA3Jo0/bRJImFgrVb9mMCvNiuwvL5HtmiF9AwTKfCivhwEJQsuCyQCdyz
         Prk4g1OVw0YyDZHTyWzwg71JAxbbpId4XzPsaZuIWIWTD7Pof0HaVAulKDmajEeuJgRE
         7Z5COd6WBQYBD4WFXy9YyPa+AD8Ey1mZNAJC49poncZS+J7Oqgb4kjzvVjW7i87nhAvB
         r3hltjPXweikv5dlz2sQPAgUgTHKzII6xJibqjVJEEnei1SxK47A6B+yCdJ7FjMMRLXi
         ZSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723136082; x=1723740882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aicxt+UzDt3qNgwZqQLVh/meDWsH0wnhB4ZpKgCLbeA=;
        b=iIf8FJOqJERjssDpUsdgh768UFVtbdI4WnHiKl5jrK32C8kZxIrW8jFFBoBkG9Y0YE
         8yOrF/IzmR9pSIHGJ2VpP811i31h1VBt8ch3u/ZxuE5RwUYyslvVMVwn49z1Y/qCtvpE
         fYWRbOg82CBdimMP7A4hZjtXgzfg491bNy0jMT7UQ77cXaeQwnzjBQld0c5p6i+tG9Ml
         g1slZ08etPWER9QB5F5C93O7qV7qaf9su1uWXH09y7SSKSRswGWw07MngbXHpfGPvUpH
         tBnr2aM9ku7gSR81L3VymKLyVw7qNcwolynDfYhJGWqVtiTmdl/Gnff9GeQakgSzuXsz
         4Mtg==
X-Forwarded-Encrypted: i=1; AJvYcCXZkk7A2tBMaVon8eFvA1K3jT4xdybe2PKR9ubR1IwGWfk5eW18TN5SAUy5pwYG7/uG/eHrcS8e7OCYCVLnCnSJCeRGtTFdsE5nu48gYnIyshVi69txaVYX85l2ZT0/SaZFLuajjaNLNmM=
X-Gm-Message-State: AOJu0YxK9ACYoW48switOVu7K0OGvbRQq7XIF5g371bM0+Z9yCC1lrvR
	YXwNxsJoSynP3mPTS4Of+77QxWs04uPSMhIuWURBZH38fSZuyc4Q
X-Google-Smtp-Source: AGHT+IGRw2qYNrFvhEiozPxxhI7XfYAGB814LeAhXp+mawE9FFa/1kAyTkxl7kjoMIOgHIAGJaz/Ng==
X-Received: by 2002:a17:90a:898e:b0:2d0:680:48c9 with SMTP id 98e67ed59e1d1-2d1c339e70bmr3176521a91.13.1723136082069;
        Thu, 08 Aug 2024 09:54:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c5e48asm1387316a91.8.2024.08.08.09.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:54:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 8 Aug 2024 09:54:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: jdelvare@suse.com, skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (lm93) Return error values on read failure
Message-ID: <e03f91c4-c25a-4c9f-a0f4-2774f4019f54@roeck-us.net>
References: <20240807181746.508972-1-abhishektamboli9@gmail.com>
 <bdca4f35-ec3e-4fac-bbcf-ed5326feb6f4@roeck-us.net>
 <ZrQqhOvt3zCHNh38@embed-PC.myguest.virtualbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQqhOvt3zCHNh38@embed-PC.myguest.virtualbox.org>

On Thu, Aug 08, 2024 at 07:46:36AM +0530, Abhishek Tamboli wrote:
> On Wed, Aug 07, 2024 at 11:38:34AM -0700, Guenter Roeck wrote:
> Hi Guenter,
> Thank you for your feedback.
> > On 8/7/24 11:17, Abhishek Tamboli wrote:
> > > Fix the issue of lm93_read_byte() and lm93_read_word() return 0 on
> > > read failure after retries, which could be confused with valid data.
> > > 
> > > Address the TODO: what to return in case of error?
> > > 
> > > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > > ---
> > >   drivers/hwmon/lm93.c | 10 ++++++----
> > >   1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> > > index be4853fad80f..b76f3c1c6297 100644
> > > --- a/drivers/hwmon/lm93.c
> > > +++ b/drivers/hwmon/lm93.c
> > > @@ -798,6 +798,7 @@ static unsigned LM93_ALARMS_FROM_REG(struct block1_t b1)
> > >   static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
> > 
> > This is still returning an u8.
> My interpretation of the TODO was to address the error condition while keeping the 
> existing logic of the driver intact. I understand that this driver is 
> old and that changes should be approached with caution.

Those TODOs are, at this point, pretty much pointless. If you want to help
with improving kernel code, it might be better to pick something from the
drivers/staging/ directory and help improve it.

The only thing that would really help for the lm93 driver would be a
complete overhaul, and that would only make sense if someone has real
hardware to test the resulting code; the driver is too complex to just
rely on unit tests. For example, the excessive retries might be because
the chip is really bad with its communication, or it may have been
observed on a system with a bad i2c controller, making it completely
unnecesssary today. Either case, if those retries are really necessary
due to chip issues, they should be hiddden behind regmap (which should
also be used to replace in-driver caching). And so on.

Really, if you want to get into kenrel development, it would be much
better to help improving code which is actually being used, as mentioned
above.

Thanks,
Guenter

