Return-Path: <linux-kernel+bounces-437243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343269E90CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFAB163651
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC333217F35;
	Mon,  9 Dec 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Enva8hJy"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE021771F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741209; cv=none; b=Ij4QtpWn64UDZKuFoxHPRmuGbqaQa7Gwm6i7NTZ//BwmzSsyL2nzTLo/Gg8z4kwe9r/mid3Auka6APBR79H0E5CltZRtMPdWkWuDMZy6ofGaoraTNsNQup+97Qge7o5cSBvm1ZRBCB7E1IQVo9MHh7iBqjfO/lfcOvn5K4WxlNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741209; c=relaxed/simple;
	bh=oWuzkn6XtP5CPz1KIgFXTYtJaDEpOL7Hzr6vzGVK1AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn6H3wm41g02BPRRdS45/qPVON8SUK45kJwJAUSas33tok3IS7EfWU4Xmn+X9JlEd8xg3F9vmeacJ+H5DV2Z0ythwknV2H/nff5Ub6zWytA3CiSad5HPVXtjE6SsLf4S7BWHNp/jCoNl4l5HF9YJoDkS4j70bWvmKpAkO9y983w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Enva8hJy; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 59DFD3F206
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733741204;
	bh=PqTnCOqOvmnFn3r9RLm8PAobY4TMfkIvEQFiv97/kVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Enva8hJymaq+ToTf4uvXQ8pas5AF1SzfGGaSHvNUvISVK5OZDbfslDnNz87ubHrQ9
	 t/9NizK6soY5a2etcESD+LsVIbGxRtdgHOtXVOe9Cx3nFO6T6k8P81BGPIVXRlNUwa
	 MrrVOh6Nb0vrYjnOp+VuiotO1rWfmC6PsTY2dMhzfrquvZLw8yKg5sktV3kHKYfi8i
	 h3tuCE0Ipkl7uGm58u4BAkd9hnE0mQYgMEpIhEdUJf5syW3lAFE+27cTspT66Cz/Ir
	 I+nCvORosC1wUtet0Hp+4/ht0IG31WYL0KOWgwE+Bq5+sHO8rxHjW7P548UXQfm5NO
	 iII7PqFZph49Q==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee36569f4cso4554805a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741203; x=1734346003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqTnCOqOvmnFn3r9RLm8PAobY4TMfkIvEQFiv97/kVE=;
        b=pD1IFj1MO40J7C9Jh6iCeGEa7gyHaKn6L5dZZtdyHYtpiSxbgiJUKLHsu9rAVn3Adf
         6GLqS4rzKuazFehvrKLNy8Rhrr3u8jJXco1OeZfAMJEAsuliEgGJ03A9hBFVdFEUyYrt
         Hv0NKa9xzCzhzZSL/c4EFv+pytrGMY+mXeISz4xzzoWnV3cNIBsSfTY/JeDkfj35XM2a
         ErjZIE0OTGEp3qV2V+5h0zpCIwh2sDAxKJysutS/RHpLBYROMCqLxxlOlZbZPZMtsoni
         e3MeLsBbL7WmmWbEp12JrO4JMCyKBzNWv3yKNgzwNgEYummogHj9UyIr6p9+0HhgfvGx
         MpEA==
X-Gm-Message-State: AOJu0YyjkbwQEVSw/G5aX+liva3cldbX7I/tnrwdt4KAjCY1TU0KM6SB
	hcFagjVvDJCIg9/XIV1vbpbV1LhnDDWx9kW9RbTwglcGAzkCvrYdNQiyfo82u61/YaX2aKvijd6
	iSGZmiVDflRaG9uXHAPQBrvbVrFKMidjiTu4fMoVit6+REWWCPh+lQaOeK1pPW/i7qrDnnJq/88
	51LA==
X-Gm-Gg: ASbGncseYuQlVaBIVU0d0f4A4m85kEIs5NNWxZRYD5XV4gpCJCyfiKoz5fUhE89moOF
	fINrsv7bjkwg4skgfCemF3diH/fJ4Fx/9HSw4Llzg/jPmtNFv+3acO9ILUkvFJtV9LoI/ohJIs7
	uqJ4N8/g2SrINyedVPbfhgZvA+EP1pmCdAdEmq+w64HH2xL+rBoNnlY0mJH7+wlZgmGW9GvWA98
	joE/38uTAbnSrKicRLeQS8hIDlyUAGl7E+0hvFstdhDyLCtCx2C
X-Received: by 2002:a17:90b:3b46:b0:2ee:48bf:7dc3 with SMTP id 98e67ed59e1d1-2ef69f0b16amr18007689a91.15.1733741203050;
        Mon, 09 Dec 2024 02:46:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiMlAiRf9i1SKVMvmpFLXY8OAfXLtDoJ0C5E1SrXHxmMZ17/OzDmP7Dx6O7Dh7dXl+/aKf6w==
X-Received: by 2002:a17:90b:3b46:b0:2ee:48bf:7dc3 with SMTP id 98e67ed59e1d1-2ef69f0b16amr18007666a91.15.1733741202618;
        Mon, 09 Dec 2024 02:46:42 -0800 (PST)
Received: from localhost ([240f:74:7be:1:de9d:b666:2989:74a1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef85f4fe75sm4032808a91.51.2024.12.09.02.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:46:42 -0800 (PST)
Date: Mon, 9 Dec 2024 19:46:40 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH] cpu/hotplug: ensure the starting section runs fully
 regardless of target
Message-ID: <skljhhmj7q4hiito277wbbw5u7ygpebfhhx7rkt5k7qtbf6qby@w2vnygftea77>
References: <20241207144721.2828390-1-koichiro.den@canonical.com>
 <87zfl5q5gi.ffs@tglx>
 <j2k25hhxv42zuakbqc2miptypxee6j3vwkb5a4yz4vutj6swhv@c6ejjddjn6oq>
 <z7nvvzu5lpdnul2m35lrsa7wo6plx7zsunhowtog3nqydmpene@tzvb2hofjeal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z7nvvzu5lpdnul2m35lrsa7wo6plx7zsunhowtog3nqydmpene@tzvb2hofjeal>

On Mon, Dec 09, 2024 at 01:19:43PM +0900, Koichiro Den wrote:
> On Mon, Dec 09, 2024 at 09:12:44AM +0900, Koichiro Den wrote:
> > On Sun, Dec 08, 2024 at 09:34:37PM +0100, Thomas Gleixner wrote:
> > > On Sat, Dec 07 2024 at 23:47, Koichiro Den wrote:
> > > >  static int take_cpu_down(void *_param)
> > > >  {
> > > >  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> > > > -	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
> > > >  	int err, cpu = smp_processor_id();
> > > >  
> > > >  	/* Ensure this CPU doesn't handle any more interrupts. */
> > > > @@ -1285,8 +1284,9 @@ static int take_cpu_down(void *_param)
> > > >  
> > > >  	/*
> > > >  	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
> > > > +	 * Regardless of st->target, it must run through to CPUHP_AP_OFFLINE.
> > > >  	 */
> > > > -	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
> > > > +	cpuhp_invoke_callback_range_nofail(false, cpu, st, CPUHP_AP_OFFLINE);
> > > 
> > > This is really the wrong place. This want's to be enforced at the sysfs
> > > interface already and reject writes which are between AP_OFFLINE and
> > > AP_ONLINE.
> > >   
> > > It's utterly confusing to write a particular target and then magically
> > > end up at some other state.
> > 
> > Ok, I'll send v2. Thanks for the review.
> 
> Now I'm wondering whether we should go further..
> Because in PREPARE section, things are not fully symmetric, so
> there is a problem like an example below:
> 
>     E.g.
> 
>     (1) writing <some state in between> into 'target' and then (2) bringing
>     the the cpu fully online again by writing a large value leaves
>     hrtimer_cpu_base's 'online' field at 0 because hrtimers:prepare does not
>     re-run.
> 
>            - hrtimers:prepare (CPUHP_HRTIMERS_PREPARE)
>            - ...
>     ------ - <some state in between>
>      ^  :  - ...
>      :  :  - hrtimers:dying (CPUHP_AP_HRTIMERS_DYING)
>     (1)(2)
>      :  :
>      :  v
> 
> While I understand this is still a debug option, it seems to me that there are
> several approaches to consider here. I'm inclined toward (a).
> 
> (a). prohibit writing all halfway states in PREPARE+STARTING sections, i.e.
> 
>      --- a/kernel/cpu.c
>      +++ b/kernel/cpu.c
>      @@ -2759,7 +2759,8 @@ static ssize_t target_store(struct device *dev,
>                      return ret;
>      
>       #ifdef CONFIG_CPU_HOTPLUG_STATE_CONTROL
>      -       if (target < CPUHP_OFFLINE || target > CPUHP_ONLINE)
>      +       if (target != CPUHP_OFFLINE || target > CPUHP_ONLINE ||
>      +           target < CPUHP_AP_OFFLINE_IDLE)
>                      return -EINVAL;
>       #else
>              if (target != CPUHP_OFFLINE && target != CPUHP_ONLINE)

Oops, sorry this was my mistake. it should be:

       --- a/kernel/cpu.c
       +++ b/kernel/cpu.c
       @@ -2759,7 +2759,8 @@ static ssize_t target_store(struct device *dev
                       return ret;
       
        #ifdef CONFIG_CPU_HOTPLUG_STATE_CONTROL
       -       if (target < CPUHP_OFFLINE || target > CPUHP_ONLINE)
       +       if (target < CPUHP_OFFLINE || target > CPUHP_ONLINE ||
       +           (target > CPUHP_OFFLINE && target < CPUHP_AP_OFFLINE_IDLE))
                       return -EINVAL;
        #else
               if (target != CPUHP_OFFLINE && target != CPUHP_ONLINE)

> 
> (b). make all fully symmetric. (I'm not sure whether it could be possible)
> (c). add all safety catch at sysfs interface. (For the above example, once
>      it goes down to <some state in between>, disallow to go up without
>      once going down to a state earlier than hrtimers:prepare beforehand.
>      I guess this would mess up source code unnecessarily though.)
> ...
> 
> Let me know what you think.
> 
> Thanks,
> 
> -Koichiro Den
> 
> 
> > 
> > -Koichiro Den
> > 
> > > 
> > > Thanks,
> > > 
> > >         tglx

