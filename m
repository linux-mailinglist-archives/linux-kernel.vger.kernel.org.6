Return-Path: <linux-kernel+bounces-297469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6755895B8B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2665A2828CE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD011CC150;
	Thu, 22 Aug 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="HwmjM/fi"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29C26AC1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337655; cv=none; b=kLaLMgECKwloJjqpKhIEyZBSeIFWNd9vhvRn5QbqANutX+l9812jUU3IEiPkE3eJ776rFgqNUfDqsvxO4GP6pa5nQuFCSyiiKnmM6WJ5OyyshjoKumGwh8DEQ7WieMFOZaznTzZ5Ch7j/pn6y7KTBVcWqVizeh0s9QDEUNPj2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337655; c=relaxed/simple;
	bh=H8BscHhKFJDUT+YO5wHLmHbth4F1hYgX6AI7OGF4GUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBGxPM2BfKS/Tt1xDga0tI9ZYjTdF7KEdjDCK0B3SLE9mq3kcXV44m+gNpszLPG0CvfOKU/uyN/CAd77AggxwT86DdJf2V2RqHJYkBQdTEUqSBDwi6UZamlMOXs6x5KKSajZh4CBjJaZKdtyeTYmyaO/nkmD3+yCJQfFcWPkIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=HwmjM/fi; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70b3b62025dso655153a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1724337653; x=1724942453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2BI5ynqFBhoBoWz1wdgqO1G8/PbBu+hf6d0XfvEXko=;
        b=HwmjM/fiVqDeKnw7iQ5bRjDXdG/6EPqRNaE9yLtFeFeqrfoQ+iTJKU9VOSCpPi6+6Z
         9Pf1iykEBSInzoc6GJLAWZ2qF0EwabqgXjDD68HJfl3A9I6/I+mrK2GcWgcwGRkDOpcG
         WW9nVmaeJE6cvytXGNmNT0H6Hsl2ibV1c5CyXQU15X53zRfUASTYf2ckHEl/egAUoHk0
         e2l5QJaHEHtAVxqj0JCyueUW78zDTnaVf93/4Ex766AeMb+kGigaUmw64dQbybS1W32M
         TOAUgDzQUs+i8OdNs5eCzlVI8ALRDauJb4orpMW5aLfEqAh5+zVKCGJyqerqI9ZBiJfN
         Wdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337653; x=1724942453;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2BI5ynqFBhoBoWz1wdgqO1G8/PbBu+hf6d0XfvEXko=;
        b=A+EBV03W98QJHgV7JQ5LfP/SGFz+SXxydmeQKrUTq+n4LegHKnYAoJtSBAgFLXghRR
         FeBLvN9zQvodbb4S7UlKUcq1KHDJ4U8pHStM4tDwklK5neWAEamCAQgbW28wTLPsPCRh
         nZh/LC0udMMge4bhcAlPUjtkkJP1cRL/lfv7QoKZJUIgvmze70ocWT0iiivSnnbC9O4L
         8KnEFP9YyG27TvtTFt2gNXHG3zG7LEtjHMOhbNFMi5wtZIhpi4Rra34RALaSuVL3dYyL
         WpX3GM4IiJ8BeFQb7Baohf7UvZKOzAKKWiMIxzj1H2Prf7l861d393F0vo5Pt1pjVo7e
         m97Q==
X-Forwarded-Encrypted: i=1; AJvYcCV580EDdxWgu8adR1kW980/UFwwhby3tUob5HnIgVCTEl40zyYQNFemiV4Cj+hEfKen1NgdoAj0zxWEhYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqRujISZSuv4kzhVrH5uiQDKObe77+B1AzmDO2E915RMEaXW/X
	+RcKMm0yrUuAmrdGGLjbFl4I1Q731bKggV5FxHkjMOUhV3u+4u9cAbk6POAXwoA=
X-Google-Smtp-Source: AGHT+IEsSYDHHqm+C58leKzz0AgQbycyJyHK7W9kTO0a+Ck80Gt+pTCBBI6JswuJ+PWDlTw/jQ9dCQ==
X-Received: by 2002:a05:6830:3494:b0:703:6ac4:2ab8 with SMTP id 46e09a7af769-70df851d524mr6573637a34.0.1724337652490;
        Thu, 22 Aug 2024 07:40:52 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:57ae:721f:378d:39ca])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03ad2847sm288312a34.46.2024.08.22.07.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:40:52 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:40:50 -0500
From: Corey Minyard <corey@minyard.net>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Improve detecting during probing
Message-ID: <ZsdN8sBIUYetCUOp@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20240816065458.117986-1-iivanov@suse.de>
 <ZsU9SRlQgzQn8bDs@mail.minyard.net>
 <20240822072255.fncuy4xdkglnf3bn@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822072255.fncuy4xdkglnf3bn@localhost.localdomain>

On Thu, Aug 22, 2024 at 10:22:55AM +0300, Ivan T. Ivanov wrote:
> Hi Corey,
> 
> On 08-20 20:05, Corey Minyard wrote:
> > 
> > If an IPMI SSIF device is probed and there is something there, but
> > probably not an actual BMC, the code would just issue a lot of errors
> > before it failed.  We kind of need these errors to help with certain
> > issues, and some of the failure reports are non-fatal.
> > 
> > However, a get device id command should alway work.  If that fails,
> > nothing else is going to work and it's a pretty good indication that
> > there's no valid BMC there.  So issue and check that command and bail
> > if it fails.
> > 
> > Reported-by: Ivan T. Ivanov <iivanov@suse.de>
> > Signed-off-by: Corey Minyard <corey@minyard.net>
> > ---
> >  drivers/char/ipmi/ipmi_ssif.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > Ivan, is it possible for you to test this patch on the broken system?
> 
> This exact system is not available to me at the moment. I have few
> other machines on which I could test this.
> 
> > It should work based on what you reported, but it's nice to be sure.
> > 
> > Also, I discovered that the detect function is kind of bogus, it only
> > works on an address list that isn't present (any more).  However, I
> > re-used it for my purposes in the probe function.
> > 
> > Thanks.
> > 
> > diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> > index e8e7b832c060..4c403e7a9fc8 100644
> > --- a/drivers/char/ipmi/ipmi_ssif.c
> > +++ b/drivers/char/ipmi/ipmi_ssif.c
> > @@ -1368,8 +1368,20 @@ static int ssif_detect(struct i2c_client *client, struct i2c_board_info *info)
> >  	rv = do_cmd(client, 2, msg, &len, resp);
> >  	if (rv)
> >  		rv = -ENODEV;
> 
> What is my worry is that in case of SMBus errors, device is there but
> for some reason it got stuck/crashed or whatever, so will get out of
> detect function from here and with ENODEV return code probe function
> will be called for no reason.

That's not how the i2c code works.  See my next comment.

> 
> > -	else
> > +	else {
> > +	    if (len < 3) {
> > +		rv = -ENODEV;
> 
> No point to call probe(), right?

Originally (before I add the call from ssif_probe()), this is not involved in
the probe() call.  Instead, the detect function is involved in calling a
table of addresses in driver->address_list.  So in this case this
function is never called at all from the i2c code, since there is no
address list.

> 
> > +	    } else {
> > +		struct ipmi_device_id id;
> > +
> > +		rv = ipmi_demangle_device_id(resp[0] >> 2, resp[1],
> > +					     resp + 2, len - 2, &id);
> > +		if (rv)
> > +		    rv = -ENODEV; /* Error means a BMC probably isn't there. */
> 
> Same.
> 
> > +	    }
> > +	    if (!rv && info)
> >  		strscpy(info->type, DEVICE_NAME, I2C_NAME_SIZE);
> > +	}
> >  	kfree(resp);
> >  	return rv;
> >  }
> > @@ -1704,6 +1716,16 @@ static int ssif_probe(struct i2c_client *client)
> >  		ipmi_addr_src_to_str(ssif_info->addr_source),
> >  		client->addr, client->adapter->name, slave_addr);
> >  
> > +	/*
> > +	 * Send a get device id command and validate its response to
> > +	 * make sure a valid BMC is there.
> > +	 */
> > +	rv = ssif_detect(client, NULL);
> > +	if (rv) {
> > +		dev_err(&client->dev, "Not present\n");
> > +		goto out;
> > +	}
> > +
> 
> The point is that even after this point IPMI device can start failing
> to properly communicate with the OS, real SMBus errors, like EREMOTEIO
> in my case, but unfortunately code bellow do not handle this very well,
> I think.

It is possible that the BMC gets rebooted or something between the call
to ssif_detect() and the code below, but the probability is really low.
If it answers a detect, the rest of the things should work.

-corey

> 
> 
> >  	/* Now check for system interface capabilities */
> >  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
> >  	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
> > -- 
> > 2.34.1
> > 
> 
> Regards,
> Ivan
> 

