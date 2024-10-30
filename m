Return-Path: <linux-kernel+bounces-389457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94329B6D53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBED41C218BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D4A1D1506;
	Wed, 30 Oct 2024 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqnWApoN"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560411BD9D8;
	Wed, 30 Oct 2024 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319107; cv=none; b=oWPbaAfuUscp5Jw/bPJNho5YOZCLPEZJ/goDQmi0ch9q0jmXO5vTg5fQc+W6+C5nQ42mXooB7Giir9nJ9OJigrEpC2AQ6vuKxOcAtmq/uAvx48OP7bNr6JtRtySPjpJ7EOjaLzXWvjILrywKqV5eFdPBjRI4Dyl6bZQ2kP/LDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319107; c=relaxed/simple;
	bh=k1mtjuleGMBcgiyWtLhwWeMfsKRLA4FX8o1BSklIGPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhAt3wQgb4AmAqqgdEIdCdHi+Kx46gqI3D0sHLEY3Aadta5YQakZeDSryjnHPtV51HtKEBtgo96kXCONW6iiDkmUMA2ZqGVmoQlsCZaVCnxmTsKQ78e8FT0UKPuL/dqUX+6QkdLgXtdpH7ys0a1B+dWp6ynPwZEwiwSYQYXmnDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqnWApoN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7205646f9ebso182333b3a.0;
        Wed, 30 Oct 2024 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730319104; x=1730923904; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cV4eBxUtILgYqLmr7fW7UYCg6RbX9ACeOtbq1mqi1jM=;
        b=nqnWApoNWFpxtOBr3oZZHLTfkIR4pzhDFz2FE3HbOjJtNgxIjJBnBIGPmKn+v22wSp
         iDrfLo9eiX2de89lKGwHeqmGP0rp2StHrnBQEynCY3md15J58KCgr+D+fZfcmR7JY28z
         qNTrh4/Yg1UKDQVzgIPLJdebNJ/wxf7KQPoe8wGZim6OC1IUrW9OfuC1HO+mKNPK6myY
         yUxhRNtYpfqW1EZI7VEgT0O4YKR5Lgf+xzBMNy2v4geW+5SUeHOJDedTg1SEJV3QCq3c
         i4Up7W1ISSfNiz5w2RgGEp0GA4lZ5u3qTji/GGL0w/HKZXKq8HhGo9GOLldEMG2PR6FI
         8u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319104; x=1730923904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cV4eBxUtILgYqLmr7fW7UYCg6RbX9ACeOtbq1mqi1jM=;
        b=FIgG5PLLgbL/qGFjTc8M8JT+UUCmq3vkHOuHmkdW4X+QWT1EJSlJ2+uSImcKO0ZHQt
         med1NH4o5SOA7NSpcARxhE8X9YbSIn77klhAM9XMSVSozsGGR1gzC55aWl26zqXC7VAf
         bACJYaEcoPUU46WkJhCia2obMCH48UXDVkpu1fTHrIjp48Ib/gIy09CKCcLYu9broXhS
         tnTGT2AMARL6GEIqewO0RXbDkRlxk2BGO1QjlngdFvuLshXKJSNTS5Yx04OKrnkgTOvh
         6kzkqYhrLCwzcDhWnTjSJNOXANpAGpldqfXvusdvCoplZP7J0lk6Y7+bcJTXsCAaH5T1
         tdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU54qwe8pOgFYuKD+FKH6G2/dmixbWg8TyYoWD3eJpTzWGNFeDhqJEKzvfqhHfuVRlpHEiVHPdh3v4wtaE=@vger.kernel.org, AJvYcCWf/ghyWzeICyvNeP3H6reshh1K+3W7Oxqim4yX3T0EjYr6hR7Sf47F/iAMXgYI3FygdPBwaGpd9t5P1/g7RfgDBgLe3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVQwUZrAxrt17bPdy4hXuycROqBbTrangnCwf8N8y976quBKr
	jgd8yyAu0rYaCZBvA3Y/Gp//Zs1avnC4xBWYLATS4VZumeSiqapA
X-Google-Smtp-Source: AGHT+IF567BWRQM4yyOxyYEIwsjINk+0YmRbQ32Zok3RpTngOlG5nBfZ5tonj7UZq7+HPUgS3NLMYQ==
X-Received: by 2002:a05:6a00:190f:b0:71e:795f:92f0 with SMTP id d2e1a72fcca58-720b9b84653mr1363603b3a.3.1730319104175;
        Wed, 30 Oct 2024 13:11:44 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2e9316sm281b3a.148.2024.10.30.13.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:11:43 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:11:40 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [PATCH 2/2] dell-wmi-base: Handle Win-key Lock/Unlock events
Message-ID: <hj6jurton7ll4i475cwcqvk6dzjjire2briawxmuemnliofpyo@kpjdxpwflekm>
References: <20241030181244.3272-2-kuurtb@gmail.com>
 <20241030181532.3594-2-kuurtb@gmail.com>
 <20241030183436.3w5po6kcg6jmqigb@pali>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030183436.3w5po6kcg6jmqigb@pali>

On Wed, Oct 30, 2024 at 07:34:36PM +0100, Pali Rohár wrote:
> On Wednesday 30 October 2024 15:15:33 Kurt Borja wrote:
> > Some Alienware devices have a key that locks/unlocks the Win-key. This
> 
> Please specify (in comment / commit message) which devices. It would
> help other developers in future to track for which device is this event
> needed.

I will!

> 
> > key triggers a WMI event that should be ignored, as it's handled
> > internally by the firmware.
> 
> Can be this handling in FW ignored? So OS can use this key for any other
> functionality?

Probably not. FW locks the Win-key regardless of how the event is
handled.

> 
> Anyway, what is that Win-key and its lock?

Win-key is the LEFTMETA key and the lock key is the RIGHTMETA key.

> 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> > index 502783a7a..37fc0371a 100644
> > --- a/drivers/platform/x86/dell/dell-wmi-base.c
> > +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> > @@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
> >  static const struct key_entry dell_wmi_keymap_type_0000[] = {
> >  	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
> >  
> > +	/* Win-key Lock */
> > +	{ KE_IGNORE, 0xe000, {KEY_RESERVED} },
> 
> nit: code style: spaces around KEY_RESERVED.

I will fix it.

> 
> Is not there some better constant for this KEY_*?

We could assign it KEY_RIGHTMETA.

> 
> > +
> > +	/* Win-key Unlock */
> > +	{ KE_IGNORE, 0xe001, {KEY_RESERVED} },
> > +
> >  	/* Key code is followed by brightness level */
> >  	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
> >  	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
> > -- 
> > 2.47.0
> > 

