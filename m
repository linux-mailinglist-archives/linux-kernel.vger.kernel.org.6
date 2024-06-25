Return-Path: <linux-kernel+bounces-229746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B907F917397
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B64D28253A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451917DE32;
	Tue, 25 Jun 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAvRsXTc"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4A1369B6;
	Tue, 25 Jun 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351469; cv=none; b=FWnwN1BY82X1AyP4/7tAJuliYwyl2sFb9bCCBEM4W1fi4aovp8OkC1K0vQLEa1Qw1W1ioMlcwdBZAr9yZbAXydvInlmGrJE1OpRXarJr857jZnCJKn/N3ubGBhsmZVX7vUBeXaioY0PfHbacpc8O9ktLyUqAkzY6ymcCrRRLKqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351469; c=relaxed/simple;
	bh=pl2TqE2z9lm/nLZCVVZYqoMH+AryhVyL7hcdq1r/Nas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvVpcHtRBdYOaeCT+oEsCcvx1YfJOlv9H+RPhEYsB6HaWT/xDXG+zEBZyBi9sxr67BG9Y5KZvSgyaGQQbKcCM+EqHeER9gkyl+NoEL8K+OjXzAUGRtQjRCAFse5m3Hvz7J1wkgxw27Xu0kZHZv9dOeaPNbDqDGkQkRmBZmR5Q/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAvRsXTc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7066cba4ebbso2408287b3a.3;
        Tue, 25 Jun 2024 14:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719351467; x=1719956267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weB+BtIEG/QYH8z5HEJPhBi6ESLOJWOiD/JGuYsu58s=;
        b=dAvRsXTcrEjb7+2B1yMPEMTmD07vVN90s8bjaFiGp8ZWYv6OLimfRjoZmeF/eR6woh
         oK+9eBeIZPwt3yOf66yMewl6r9WKxvnPDyv+3h/26M6mIZXFre+Vl5ski+EscLbgkGvD
         uxFS/pEnqvL+lAmaCRAmEts8sx8d1CZsHF3qvLPhUzQcd+wuTYtETp48hQ4RHX/HB9Zg
         KAPvniEhAzaJ5BQydcYI89hpNMRYMGJPOmBan0STEEF1pIrfMJOK/WKi17AR/iBAKjyq
         d4j7orBu+TRMRd0GFDyybTP5GsZ0W5LaoQAV7UA8ZWsb0sJHlcPTZqmSRdbmJfzQK3tH
         CbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351467; x=1719956267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weB+BtIEG/QYH8z5HEJPhBi6ESLOJWOiD/JGuYsu58s=;
        b=MqVCT+oMpKL7d0cGxsUhnkCNtArFYiLjJONAL7pS76XoMa+zCm4iNjScxQoB4uiV91
         e3bHtYMoDp3aiIc++/MHzSIebUXr4WbBCHI/dKLGWy9uaSNOdQa7D7rtbpRfhyS0fmL6
         d93yqV2yrwKaY9WOATStR1GheFKlxAtovm8/97uhyMFKzVWgzr8JbvlE/pUt092NlbLy
         AF9lHkbaa9YQmfllrRZ8Zn2tjsiDMpbQYPqzSeToDunrCNSiF3J9K0+A1I9J6I4ref+E
         IKAOzTUILeYNFBNt9KINxhHil8tAmkKNdhJyAtML2QWATgPhj++aiCJnq4HfPtoCHISu
         /Lkg==
X-Forwarded-Encrypted: i=1; AJvYcCVYL6Yz+V7rocEIifZolfzeYy9dxE9dLv1GEHSxyM1QTKF822aFz25+Lg2rXJKbcbe0fG8nwJUuacq3gpjV2mD5qEl6vxR509MLwlfzZ4vfhqlMmaNU4JCtcLMiTukZecl9wmTzqK0r+Ss=
X-Gm-Message-State: AOJu0YxAFqdc2jEAGkgtzogh9oZj+KAd+OzmZpjJPUcsqfPSm+AbkOok
	izDGb+b8gLpWVDWcN1tmwHVGUjyJVQM4a8rJbwwv8pPaPU/2sITd
X-Google-Smtp-Source: AGHT+IH6ihr8MB0JtEUmCJt93CanJKKkIIEErjZEigCIacEIyFu5swR7SLrYKP5W5xM4WXF1iH/qpw==
X-Received: by 2002:a05:6a00:1891:b0:705:a450:a993 with SMTP id d2e1a72fcca58-7066e542f24mr11560458b3a.17.1719351466813;
        Tue, 25 Jun 2024 14:37:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70673ca69efsm5638390b3a.168.2024.06.25.14.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:37:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 25 Jun 2024 14:37:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Allen Ballway <ballway@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Brady Norander <bradynorander@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	Mark Hasemeyer <markhas@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk
 detection
Message-ID: <01904abc-5e7c-4006-96d9-83fc5de8bb21@roeck-us.net>
References: <20240430212838.1.I77b0636d5df17c275042fd66cfa028de8ad43532@changeid>
 <83e218f9-29f5-4f35-bd0c-b298e3bb9e8c@linux.intel.com>
 <CAEs41JC-vJaMHj6fzmNO=-bu5oURRA-u565sN2=yzBeVtKb=4g@mail.gmail.com>
 <b2375610-4044-49e6-86e9-5c172abb2ffa@linux.intel.com>
 <CAEs41JAPPr3xRR42H6vKic5rVrtV-on4HyT5wNCXxbJtwijnCA@mail.gmail.com>
 <3d44c749-6c81-4c11-9409-b01815fe1a91@linux.intel.com>
 <3d9ef693-75e9-4be0-b1c0-488d3e2d41c5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d9ef693-75e9-4be0-b1c0-488d3e2d41c5@linux.intel.com>

On Fri, Jun 21, 2024 at 10:35:31AM +0200, Pierre-Louis Bossart wrote:
> 
> 
> On 6/21/24 08:15, Amadeusz Sławiński wrote:
> > On 6/20/2024 9:27 PM, Allen Ballway wrote:
> >> I filed a bug and after sharing the requested information it looks
> >> like this device won't work on SOF without vendor support. Given this,
> >> would the original patch returning this device to using HDAudio be
> >> reasonable, or is there an preferred alternative to force this device
> >> into using HDAudio?
> >>
> > 
> > And can you share link to the issue on mailing list, so someone reading
> > this thread in the future doesn't have to guess where it is? ;)
> 
> https://github.com/thesofproject/linux/issues/4981
> 
> I don't know what to do with this configuration.
> We added a quirk to force SOF to be used for ES8336 devices. It worked
> for some, but not for others. Now we have quite a few ES8336-based
> platforms that are broken with zero support from the vendor, with
> obscure I2C/GPIO/clk issues.
> Are we going to tag each one of them and say 'not supported, use HDMI only'?
> That's pushing a bit the notion of quirk...It would generate an endless
> stream of patches. The alternative is to do nothing and ask that those
> platforms revert to HDMI audio only with a kernel parameter. That latter
> alternative has my vote.
> 

Given that this apparently does not work for many ES8336 devices,
would it make more sense to disable SOF support for those by default
and _enable_ them with a kernel parameter ?

Guenter

