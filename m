Return-Path: <linux-kernel+bounces-238388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3019D9249CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B14AB21494
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60920126E;
	Tue,  2 Jul 2024 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8hDkNlS"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7271534E8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954959; cv=none; b=DaKzFGVAbyoZNPeBkEJwAcemMv5uH8UeBkwTNisyHOuTdfDq+d9sHAA56lo49KNjnT1GLren4hTh8iHwq49esWaVQ22qPzkfg5ZCC+7C2zW+UjDZJ5ghN+rV/Ss6FyEZkIdyinrLHWrlaTpJSC1ctsksuoHWHZ79Pq+xzcF4gWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954959; c=relaxed/simple;
	bh=Z53qQlIZsVbeOjfncqkv72fJDhuWFnhGQH+Ptt1okOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3ZUk1m1jZTPjWaG3M257l6CxAt8Ugt/FJ2Gi7Ydqwd4LIL5ghYwKRvWImmbu/m/6eTShdMERn6nw7F5znRwLQyyRYzVLKnfw43oO6ItHe9zEzUyvEse7zES2H3g4JlTUa1bk9Baqkv9lu+fEznOZ3ucd26DfeMuGddNv1382Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8hDkNlS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab63so2660793a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954956; x=1720559756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLK9aj4vFqWhZL5t10A0/zYFTcmHZM8OXrcD4U0TrDc=;
        b=E8hDkNlSHSIWg1WUWDg1cwQqAYys7efuJTbIY/DaCI0wEp1nkOdFgeU97P/JasDYBu
         8iDewzmsDow8PQluvQtnKksXxGL2AEhrcyBVuWO/RXlVVbOI7TdQSyF4NT0eD4hwyGQy
         /kM/rV9gRhj2XxKqM00FCC0A5kyvZEBETHRrilBU7K1xGSCyvZJfN40D/N3s14w6Q2j3
         MCS8iszOq9zKdlukq+Ld/gt9l0r0jlMnE63Pi3NT/kgsHLYWlo5ZIF9gLM9TOXZPPj+k
         s5F9qSBXMZrpji0OZ1scVaYFKq0NiHwnjwvdIKRh3cjxaH1ds1EBwHy2+XAM2S60avRL
         sxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954956; x=1720559756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLK9aj4vFqWhZL5t10A0/zYFTcmHZM8OXrcD4U0TrDc=;
        b=Ep4qsxLGCS7lr7DeaIsvaY0De28OVu5vlwsTWgV7d2rjnzckqeL2arVq3zRQHqZSPt
         xK6TOp8fWC70/lovA2q5mtA8RHN2ef+Rc+lVEwsapz9Ch2AfNjthSXikQz0nz5gPonFQ
         TiVAthHaTqY5a/Dos2a3F6ToLcr3WU6OpuOr3wuEgk1UQlBGFX8sLi9EN0ciEIBkRCst
         gI8M4DQ9oQGeJGtWzWFBzWQmXX7GRFD1O013S5u88TvHS4ANc5tPcrzD+RDAsu6S0OHb
         lqhu88iEHePCgJdfoOBmu/jeEkvxeCAZyZNkrvgX9+EWeDOIAbXrVTqM7G7SLMfTytYD
         9VVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoobNw5Nq/QcP3j8j8sd2iCyRrz1KhNLH55IYUWp7p7tp2lRDJLouvETUQCUvrJ4P0EyhdjLDumZpULBQS4WKvv/Lt79lRCMECyqY7
X-Gm-Message-State: AOJu0YyrITdakEXLFBnTn7j9i5ANPyri4/K3WW+IHF/nEm3NRvgszORc
	J0ApjAtgjh04W10oi7z7UQmbI+2ZLkUMl1V1xj58HkDlzFzld4JaFMGwhg==
X-Google-Smtp-Source: AGHT+IGCT4ZcS2hWBpqR73pLxAO1+F3bfc5uZOtzmRlNvQB2X8vmqHx3H6TNdYR0k2Aqy7zatnWdXg==
X-Received: by 2002:a05:6402:354c:b0:57d:5c96:72aa with SMTP id 4fb4d7f45d1cf-5879be9a1a7mr7914346a12.0.1719954956486;
        Tue, 02 Jul 2024 14:15:56 -0700 (PDT)
Received: from f (cst-prg-31-46.cust.vodafone.cz. [46.135.31.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614f3d415sm6196769a12.85.2024.07.02.14.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:15:55 -0700 (PDT)
Date: Tue, 2 Jul 2024 23:15:44 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
Message-ID: <6knlkefvujkry65gx6636u6e7rivqrn5kqjovs4ctjg7xtzrmo@2zd4wjx6zcym>
References: <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
 <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4>
 <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
 <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
 <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
 <CAGudoHH_z1a6MX8Z8Cqbz-jDTUoAjoxdV9KrQ6yvUkNszXO5aw@mail.gmail.com>
 <CAGudoHHg-T+ZOTm0fSpW0Hztfxn=fpfnksz5Q3=3YeCeEPo7LQ@mail.gmail.com>
 <CAHk-=wiBGSLNW6GGbnec-dCbn0kWvD+OXAa5VNXPBKLXYy5KOQ@mail.gmail.com>
 <3g3arsrwnyvv562v2rsfv2ms4ht4mk45vwdkvssxkrjhfjtpdz@umyx5tl2du7o>
 <CAHk-=wg6e8QMaBOyFaGon7pik_C1COrkmEz37mtUqpBoq=R44w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6e8QMaBOyFaGon7pik_C1COrkmEz37mtUqpBoq=R44w@mail.gmail.com>

On Tue, Jul 02, 2024 at 01:42:48PM -0700, Linus Torvalds wrote:
> On Tue, 2 Jul 2024 at 13:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > If you are politely by lkml standards suggesting I should probably drop
> > the idea due to unforseen complexities
> 
> Oh, absolutely not. I'd love to see how nasty - or not nasty - the
> patch would end up being. I think it would be very interesting.
> 
> I'm just explaining why _I_ never got around to it.
> 

ye I get it, but the above by me was a passing remark anyway :>

I asked you something in the previous e-mail though (with some nastiness
of the problem pointed out) concerning handling of slow vs fastpath,
here it is again:

[..]for example did you know xfs does not honor rcu grace periods when
recycling inodes?

https://lore.kernel.org/all/20231205113833.1187297-1-alexjlzheng@tencent.com/

So this would have to be opt-in per filesystem, probably stuffed
somewhere within the inode or dentry. I am definitely not reviewing all
the other filesystems for sanity on this front.

Rather, one could look over tmpfs, ext4, btrfs and maybe ask Kent to
sort out bcachefs (if necessary) and call it a day.

Sounds like you are deadset on the callback approach. I'm not going to
die on the inline hill, but I will spell it out so that we are on the
same page (and I have a question too).

In pseudo-code my stuff would like this (names are for ilustrative
purposes):

struct rcunameidata {
	....
	bool in_rcu;
};

...

struct rcunameidata *rnd;

error = vfs_rcu_magic_lookup(&rnd, ....);
if (error)
	return error;
if (rnd->in_rcu) {
	/*
	 * fast path goes here, callback code would be identical up to
	 * the point below
	 */
	 /*
	  * Now validate
	  */
	 error = vfs_rcu_magic_lookup_validate_or_drop(&rnd, ....))
	 if (error == 0) /* things worked out */
	 	return export_stuff_to_the_user(....);
	 if (error < 0) /* fail */
	 	return error;
}
/*
 * slowpath goes here
 */
 /*
  * all done, now whack the lookup state. the routine returns void
  */
vfs_rcu_magic_lookup_finish(&rnd, ....);
if (!error)
	error = export_stuff_to_the_user(....); 
....

Can you pseudo-code how would the consumer look like in your case? Do
you want the callback to execute for both slow and fastpath and switch
on the flag? It is rather unclear what you are proposing here.

fwiw I think the above would serve as an easy to copy-paste idiom for
the few consumers which want it. All the complexity in their case is the
in_rcu block which wont go away with a callback. If you still want the
callback, callback it is.


