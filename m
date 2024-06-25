Return-Path: <linux-kernel+bounces-229760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217499173AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EE11F23065
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A9617E460;
	Tue, 25 Jun 2024 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="nQ1t/J16"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4417C9F5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352256; cv=none; b=NRPFNtExstsqhAUu4heFBPtXwDPaCWOZsCDChwM1ooZcTgSnfTILMKVXU92BOZZieDyN6crIucI76vzyQC5IwCvTsVD4dH49OEyml5BgovqfAZOOEKdZMJL9XWBXEDGgtX5kQ4WbG5vCZSx2aPi2WXw96PZr+s6JF6715UzmUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352256; c=relaxed/simple;
	bh=3/XvbT/HbryRxG7MEP98/VDP+yLdCmmDfJC0sUbuR4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBTgzHUVg5kSeOZL9AFyq+20EbevLCTaOvPH99DFwssdlI2SE/9cAiIL/9WRi75843mT7T5AIRVT6CWV+E8cE4x0rr6XWXriHJhcApq3MgKHQB9j/1WOYHVlVKcWRQ6R+qiElPflxkA0X9HwqFr4VNyCrHOe8S5CuYvplPBnkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=nQ1t/J16; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d044aa5beso6959982a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1719352253; x=1719957053; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A7X+HmsNznUN/58VRWo3e8OS/8Tej2Ru2PNKKOq5qu4=;
        b=nQ1t/J16jDNF4GaoXUOKnI496lamvNwi1cBvKx8nsZY3ixeOGbECX7FK6VtetmsPoW
         ojdIomxanPnxM/GiGDZ+ulvcelUq3KG8VDTJkY4kJWPWKhatTTm7+So/Evz/QZztil6u
         1q76SpsKvQVjvD6ytRJU0LyegFDpDs750DwTUMIMNcmWBbneM8FRJI5koeFn45hqzCeg
         vjIhLhzkBv/UuGjGfeZokDSChhjKDMdAv407y/Rntq0fhFGcQsqf17hs95C3JcI+nTiX
         Wit8bwTz6SClZWLl4eFZRUBpDgQwTXycIZ4ybl/8ePuhs6s8CdSZU1fFRJkbvXPpFAo3
         +jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719352253; x=1719957053;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7X+HmsNznUN/58VRWo3e8OS/8Tej2Ru2PNKKOq5qu4=;
        b=Nkq26PKd75+DOjO1c5dnuFBtozqqXMfURvrwLpvQDogHi2/rPaGwtj8Ks1wJh/N0lP
         954Nl7pfrbRljIi+gXdlNt3BPVkEEvs4UbCzJaPdedtMlPNJG7IrfULxLufGh1OS/VPU
         PCQEqzrkxwgoJWAqCLxeOFh6jiice/N86t7+uQhYUfanzSOLqhk2w5eaYhJu2Zn5jy9A
         1zrzrGVK7zYEvFumyfUbbualEsTpYPcCO52Hsq0JrcXzTaeltg1Jfw6A6mqu2eINV2f+
         ZaCh/m9MYIpa3SVZA4e1AurfDhGEA7ReCbIGFqZ+nwzGYYZf9TZdB+egrD0gy8o8dZDy
         qbpw==
X-Forwarded-Encrypted: i=1; AJvYcCVALjRACbqfEWyZ7CGhVpFxjNGzfko/GHLWhGvDeucL7ttHQ/3hCQdko9Ac3DmYX4c7jzrvlkCdQNrHFVZVEcisjhOm0M7PxqgEJQw+
X-Gm-Message-State: AOJu0Yx90BW8sKHcNFxBa5hQgVx7k6OEYzFevmt2RWn9MKTTh1FWNkOR
	qER9/yM/TK8d2yVQtr8aU3wseMIqvKVInAWLdjR6rDTvSF6+WbjL959PdZ86I05Rsgc2vTK7fuZ
	yZn9ZJMmdWzjHNggF579YJQgf2XQukryTS9z+wZIdpsS/3jdNirHoX/tqMW5WTRdplv/nFs6KcY
	PHvfJnpzMRXaKocKdWLstPtGgNrs9KSb1jB0/8hSK7
X-Google-Smtp-Source: AGHT+IEewJnFaL2EuN3g+pF3mFt2pFH6EUEyuFJFQdYyjTABQB0Ee7+84vIfcwFv8vuIggTCmhKCRA==
X-Received: by 2002:a17:907:8dcf:b0:a72:6416:5cba with SMTP id a640c23a62f3a-a7264165f7amr316479266b.19.1719352252507;
        Tue, 25 Jun 2024 14:50:52 -0700 (PDT)
Received: from admins-Air ([2a02:810d:aec0:2a54:f136:1973:486:27b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7246f08016sm338147566b.162.2024.06.25.14.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:50:52 -0700 (PDT)
Date: Tue, 25 Jun 2024 23:50:46 +0200
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: pavel@ucw.cz, lee@kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: Add LED1202 I2C driver
Message-ID: <Zns7tih4M2y3SX6B@admins-Air>
References: <ZnGMAK9bd3pZjWmG@admins-Air>
 <20240620175543.GC1318296@google.com>
 <ZnmDUNgwu_1LYMzw@admins-Air>
 <20240625071610.GW1318296@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625071610.GW1318296@google.com>

On Tue, Jun 25, 2024 at 08:16:10AM +0100, Lee Jones wrote:
> No idea.  I use NeoVim (with kickstart.nvim).
> 
> https://dev.to/lico/set-up-neovim-with-kickstartnvim-on-mac-as-a-vimginner-53f5

Thanks for the pointer.

> 
> Please strip out review comments that you agree with.
Hopefully like I did for the rest of comments?

> 
> Numbers should be easily identifiable/readable by humans.
Ok, will do my best 

> > I reused some naming. Should it be led1202_ for all?
> 
> st1202_?
st1202 will be in v3

 
> > If this is not appropiate or custom practice I can redo it, but I need some pointers
> > on where to look as "good" examples.
> 
> Google: "Linux Error Codes"
> 
> `git grep "return " -- drivers`
My concern was mostly with how I'm extracting the channel(LED number).
ll1202_get_channel is called inside functions where only struct device is available.
So, I extract the device_node to have access to the device tree "label".
I'm char compairing label value and dev->kobj.name, and if they're the same, I use the
"reg" value property from the device tree to get the LED number.

For most if not all of the functions I did see some similar setup in other drivers files,
but I might be doing something the wrong way...
 


 
> > A dump of all the registers with their values. I didn't add show/get functions for
> > all the registers.
> > Remove it?
> 
> How often are people going to need that after initial authorship, really?
>
No idea. I'll just remove it.
 
> > > 
> > > Space out the code properly - this is really tough to read.
> > > 
> > Ok.. with or without the help of the IDE, it shall be done
> 
> I mean new lines between functional groups.
>
Understood.
 
> > > > +}
> > > > +
> > > > +static int ll1202_channel_activate(struct ll1202_led *led)
> > > > +{
> > > > +	struct ll1202_chip *chip;
> > > > +	uint8_t reg_chan_low, reg_chan_high;
> > > > +	int ret = 0;
> > > > +
> > > > +	chip = led->chip;
> > > > +	if (led->is_active) {
> > > 
> > > Reverse this logic and unindent this block.
> > > 
> > Sorry, I need some more details on what I need to do here.
> 
> 	if (!led->is_active)
> 		return ret;
> 

Thanks for explaining this.

> > > 
> > > We already have global helpers for this type of thing.
> > > 
> > Ok, could you please point me to the file/link?
> 
> I suggest you pull as much of this out to another _normal_ function as
> you can, then have the fewest lines possible inside the macro instead.
>
Ok. Will do.

 
> -- 
> Lee Jones [李琼斯]
Thanks Lee.

May I now push a v3?


