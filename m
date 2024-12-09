Return-Path: <linux-kernel+bounces-436747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13019E8A38
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A628184C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7AC156C70;
	Mon,  9 Dec 2024 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZgpVk958"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E6E155335
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717999; cv=none; b=uknWk3hyGv9lIyhBGtAhr64tejiL8MFTnlVhrZWRn6+kj27hfqblpWdwbx87V75FUJmeFtmQlaDp+dUN2WK4REe195MINe1+ooVu8+MokU7b68QqK68oviRRCZfrKs2ke2vE67ltf2hY9gfIMgi9zKzYYv3ApqKtueugjlF5K9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717999; c=relaxed/simple;
	bh=MUBf113ecwXuaidIvsx4wcGHY8d3DGSD3UL4mGm5N+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHYLdmlOcbkLZY8XBU2i7SwWTKZ00aSBgpyEYddQFalZlNLjErG/FdHWFlfTUobibOl349gKdTW2W3lJuUTQSuU7ejtptiABX/kGjAyYywHyDyEeQG+MyUApLyGzKr24Nc5iHHeBTzNppik7fw1ww1PKQpt4GnWYhtt/1GqTxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZgpVk958; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B3AA53F102
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733717987;
	bh=KF/ZTyxUyW0kRKE6qKIf9Plwb+lDLbmDDHJgN6yD4ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=ZgpVk958SUuXlOkuXJcOolERGciFltkcaE4xuNGnuN+PNRy8sxGLJU4pdphXbXqXh
	 4RNoEMiPsH9hRsYfG8HurvfTYnZ69Hl8pVnyed3M9M9NPcIQ1xqqBnWw1UDhj9qwFw
	 YpOCr1nsn6NNZSJABa/IvrLZD86oVbRTM+EL2BM+TvsQnemKKtsBKt3ocT3UrCuymm
	 drw8QNecObGZXd5/OL+OU4JxKgkp4EbN9Gry/pjZVspXco0KzQTvUu54ofdI5xFxs8
	 KzSddQzw2UppyxMRWfK9TVhMYVeQJxVbLmpWWlXke/sE0fKyl9HQ1Yv7CS8WrerD2z
	 KC/bpKYiIBU1A==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7f72112de23so2767034a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 20:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733717986; x=1734322786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF/ZTyxUyW0kRKE6qKIf9Plwb+lDLbmDDHJgN6yD4ig=;
        b=m4sTDrCKoEIy5goUy0Hf9wVfHcZ501/8+uazplf70FsmLrnNk3eIm8MAeRJGvy2Jcq
         8dIujS3DSyNtqbf48M/389ctTnDMfA8SZLUSeQ86l3KbKC0GjL29sGbWH//8cdf7aj7E
         I2RizeDk23TbcljFf6JJ8cPRmPXz3wlNRUcsIfSE8YF8uWBzVrocj6HLtB0LWsmmynnB
         HC+HWNd2ecO56Obqu6D4dyo4rSbXlhHeeBal34O8QOX5tz4Wyrva6FFCIejh6JCb5Y1r
         jeEGHnTA8RN+ykCU0YVEmtkKLIKMngp1H4TXNZ0xK2WLLoKXyV6jqApFMFyvCdQTDCJ6
         TWug==
X-Gm-Message-State: AOJu0YwEjohDxA6IyG1vhOq5FCI/ahCtmrRincpqQR3WfGEoyZfy1TVp
	g5C8J2pJNRcaS2gUGxWfHjMhvHh3eZU3VYFS7MPp3LXL31dyqGzvnJVJGPg86hvyZFAdSIKKgpH
	xYw+YdSPLgG9Vdnec0L0sGB/t1zM7fnbCZPNQoItHRS7YPDjubTfKnaghHeoqbCJ/34GFHgIoq3
	akUA==
X-Gm-Gg: ASbGncv+wU2v6895DogDRDpkA2jVWqU5879QROOb3tnRM/IyVNSPm0F984sIHlvigug
	vAYw1vSdnMXW2OcVDM0Em+oaLWROtFHlY5amrDHSWL4seGGh7KHN2GxvkyHjg0DOYI50lMG0tSz
	t0Y4aQpeZuwDNYWWoQHDGB9GYnrHUWMqGuUUaHgKCDK/+BCzm0xrCDBGb9wnRGbVP3+Y8OBxij3
	iQ+5/WqeLV4cziOd2OHuliEutHRIp429vhKMfewh3ntKppDCROm
X-Received: by 2002:a05:6a20:9183:b0:1e1:ae4a:1d50 with SMTP id adf61e73a8af0-1e1ae4a20f7mr276503637.25.1733717986238;
        Sun, 08 Dec 2024 20:19:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6Br9TXrVJ6afuhFTSKvfB0owtCQsosQa6oF//wRj91qsG5vMNYdJZq6OhvRcaVhLtIMzSkQ==
X-Received: by 2002:a05:6a20:9183:b0:1e1:ae4a:1d50 with SMTP id adf61e73a8af0-1e1ae4a20f7mr276475637.25.1733717985854;
        Sun, 08 Dec 2024 20:19:45 -0800 (PST)
Received: from localhost ([240f:74:7be:1:de9d:b666:2989:74a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e77d9786sm1559346b3a.37.2024.12.08.20.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 20:19:45 -0800 (PST)
Date: Mon, 9 Dec 2024 13:19:43 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH] cpu/hotplug: ensure the starting section runs fully
 regardless of target
Message-ID: <z7nvvzu5lpdnul2m35lrsa7wo6plx7zsunhowtog3nqydmpene@tzvb2hofjeal>
References: <20241207144721.2828390-1-koichiro.den@canonical.com>
 <87zfl5q5gi.ffs@tglx>
 <j2k25hhxv42zuakbqc2miptypxee6j3vwkb5a4yz4vutj6swhv@c6ejjddjn6oq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j2k25hhxv42zuakbqc2miptypxee6j3vwkb5a4yz4vutj6swhv@c6ejjddjn6oq>

On Mon, Dec 09, 2024 at 09:12:44AM +0900, Koichiro Den wrote:
> On Sun, Dec 08, 2024 at 09:34:37PM +0100, Thomas Gleixner wrote:
> > On Sat, Dec 07 2024 at 23:47, Koichiro Den wrote:
> > >  static int take_cpu_down(void *_param)
> > >  {
> > >  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> > > -	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
> > >  	int err, cpu = smp_processor_id();
> > >  
> > >  	/* Ensure this CPU doesn't handle any more interrupts. */
> > > @@ -1285,8 +1284,9 @@ static int take_cpu_down(void *_param)
> > >  
> > >  	/*
> > >  	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
> > > +	 * Regardless of st->target, it must run through to CPUHP_AP_OFFLINE.
> > >  	 */
> > > -	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
> > > +	cpuhp_invoke_callback_range_nofail(false, cpu, st, CPUHP_AP_OFFLINE);
> > 
> > This is really the wrong place. This want's to be enforced at the sysfs
> > interface already and reject writes which are between AP_OFFLINE and
> > AP_ONLINE.
> >   
> > It's utterly confusing to write a particular target and then magically
> > end up at some other state.
> 
> Ok, I'll send v2. Thanks for the review.

Now I'm wondering whether we should go further..
Because in PREPARE section, things are not fully symmetric, so
there is a problem like an example below:

    E.g.

    (1) writing <some state in between> into 'target' and then (2) bringing
    the the cpu fully online again by writing a large value leaves
    hrtimer_cpu_base's 'online' field at 0 because hrtimers:prepare does not
    re-run.

           - hrtimers:prepare (CPUHP_HRTIMERS_PREPARE)
           - ...
    ------ - <some state in between>
     ^  :  - ...
     :  :  - hrtimers:dying (CPUHP_AP_HRTIMERS_DYING)
    (1)(2)
     :  :
     :  v

While I understand this is still a debug option, it seems to me that there are
several approaches to consider here. I'm inclined toward (a).

(a). prohibit writing all halfway states in PREPARE+STARTING sections, i.e.

     --- a/kernel/cpu.c
     +++ b/kernel/cpu.c
     @@ -2759,7 +2759,8 @@ static ssize_t target_store(struct device *dev,
                     return ret;
     
      #ifdef CONFIG_CPU_HOTPLUG_STATE_CONTROL
     -       if (target < CPUHP_OFFLINE || target > CPUHP_ONLINE)
     +       if (target != CPUHP_OFFLINE || target > CPUHP_ONLINE ||
     +           target < CPUHP_AP_OFFLINE_IDLE)
                     return -EINVAL;
      #else
             if (target != CPUHP_OFFLINE && target != CPUHP_ONLINE)

(b). make all fully symmetric. (I'm not sure whether it could be possible)
(c). add all safety catch at sysfs interface. (For the above example, once
     it goes down to <some state in between>, disallow to go up without
     once going down to a state earlier than hrtimers:prepare beforehand.
     I guess this would mess up source code unnecessarily though.)
...

Let me know what you think.

Thanks,

-Koichiro Den


> 
> -Koichiro Den
> 
> > 
> > Thanks,
> > 
> >         tglx

