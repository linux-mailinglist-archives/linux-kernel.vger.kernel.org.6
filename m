Return-Path: <linux-kernel+bounces-308613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE04965F82
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA51282C39
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3949F18FC9D;
	Fri, 30 Aug 2024 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ECeZnR/U"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719417E00D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014587; cv=none; b=cDq3KK1QchzRyhygoOvfWThJofYZx4VFzNE1AY9RMAUchkAWi8QtEINqMMc656KGRhNRNeLAA2dXHXvgOmvgdNu6FyX3iTrI4fqPjTYJkOA6YQLWl/3OWyksln3ymyei9xvgqu4zJTKSOJCXUGomZZ9/D5N9A9v7puGFmsmo7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014587; c=relaxed/simple;
	bh=3OXDJ/YV5ntUCOTLntGPh80oAc0JLV9WHlfswnb96Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiFOKo6SJ32b+kMuueFVsQQDGW+uFniZyZjIehyZquEkRaly8/wcYTxerZgggxFmrYyNR2AZ6780YCB/vtN3TbkSbO9GvU8c3kbWTc+W9RVbkRRV+Og1WDB1duVvocbYLEVNjQSp2+n5lL/+rgnTb3/1tExBYNxv3JvA4CGfjq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ECeZnR/U; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c210e23573so1712423a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725014584; x=1725619384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Je6Wjumy2niLetCiqW7SybPIeqbB/pPPnknSrf/ORfs=;
        b=ECeZnR/UHosC+I6qGgSuC0Hh0uwIgokhCK4PuvsBpazfjPUEg/Mf8BYKmZV3mdi428
         742ZqbbWRhGHMQ194XdPuXV8J92Uhh2CNtvlWGXddmfefdP0bRq5VVctnG7zmAYzzUYY
         pJpWEtVxghM07Ia2lpNSHBOrn13BCLHPxRwas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725014584; x=1725619384;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Je6Wjumy2niLetCiqW7SybPIeqbB/pPPnknSrf/ORfs=;
        b=Z9OQXWZKcnKsKLqgF68RRpmH5dkwHogh/LNeCDkjX+ZlMunSrdZrTsDXRWQ2sO/uIo
         f1YFdJLCeVVof6JBKAWZKGYNLBLVNWxCneAqWLaOmYq7w7tzq9NDD5dnmECATMTvqsOG
         4cTj4YBW5ZV4E/PjvvodKFk8ReE/j4YPkphCL018PjqBELd+ac8jzH/aHpkKzvhH27dw
         2vMI4pRzDx/lPkS+m7XzxAg4BJkdtTtF46prbhRMR5qXgtdT15lpbq466Rfj+MXBQ41B
         O1k62HTKX+LQ+NHFWB3fYl/ycovRwucdnnWHyX6WcJnaahb7JIABbCIPdbWrDDk/hWqq
         nZJg==
X-Forwarded-Encrypted: i=1; AJvYcCWmzAxtUrxdm9RIKBCUnXLzFAFoMf7UjzMv5fJoT9xX6LFJGgc3wwBpTB+2jeGQ7n5L+cV04I7wK4MFMA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyySVyjvmNCjOyxaT989BM6Qsv7njAfm3tz2jD+5BChoLVfKRz
	Xp/iY2qx/8Yh9J83rC530m2n8bfZ5Q7brxABRLSuUSk8aMqCW5RCu4kEERCgSZm0rOLqdwbpuFj
	WTDDDlA==
X-Google-Smtp-Source: AGHT+IGMlDKIGEY8ssQPPlyMSo2xuzkQZhCal/VHSN4eDt+f9FqA88qFAHUKPFdbYolYA/9gjXzQrA==
X-Received: by 2002:a05:6402:40c4:b0:5be:fbce:939e with SMTP id 4fb4d7f45d1cf-5c21ec5b94dmr5706860a12.0.1725014583088;
        Fri, 30 Aug 2024 03:43:03 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c2d0sm1778033a12.45.2024.08.30.03.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:43:02 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:43:00 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-6-jdamato@fastly.com>
 <20240829153105.6b813c98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829153105.6b813c98@kernel.org>

On Thu, Aug 29, 2024 at 03:31:05PM -0700, Jakub Kicinski wrote:
> On Thu, 29 Aug 2024 13:12:01 +0000 Joe Damato wrote:
> > +	napi = napi_by_id(napi_id);
> > +	if (napi)
> > +		err = netdev_nl_napi_set_config(napi, info);
> > +	else
> > +		err = -EINVAL;
> 
> if (napi) {
> ...
> } else {
> 	NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID])
> 	err = -ENOENT;
> }

Thanks, I'll make that change in the v2.

Should I send a Fixes for the same pattern in
netdev_nl_napi_get_doit ?
 
> > +      doc: Set configurable NAPI instance settings.
> 
> We should pause and think here how configuring NAPI params should
> behave. NAPI instances are ephemeral, if you close and open the
> device (or for some drivers change any BPF or ethtool setting)
> the NAPIs may get wiped and recreated, discarding all configuration.
> 
> This is not how the sysfs API behaves, the sysfs settings on the device
> survive close. It's (weirdly?) also not how queues behave, because we
> have struct netdev{_rx,}_queue to store stuff persistently. Even tho
> you'd think queues are as ephemeral as NAPIs if not more.
> 
> I guess we can either document this, and move on (which may be fine,
> you have more practical experience than me). Or we can add an internal
> concept of a "channel" (which perhaps maybe if you squint is what
> ethtool -l calls NAPIs?) or just "napi_storage" as an array inside
> net_device and store such config there. For simplicity of matching
> config to NAPIs we can assume drivers add NAPI instances in order. 
> If driver wants to do something more fancy we can add a variant of
> netif_napi_add() which specifies the channel/storage to use.
> 
> Thoughts? I may be overly sensitive to the ephemeral thing, maybe
> I work with unfortunate drivers...

Thanks for pointing this out. I think this is an important case to
consider. Here's how I'm thinking about it.

There are two cases:

1) sysfs setting is used by existing/legacy apps: If the NAPIs are
discarded and recreated, the code I added to netif_napi_add_weight
in patch 1 and 3 should take care of that case preserving how sysfs
works today, I believe. I think we are good on this case ?

2) apps using netlink to set various custom settings. This seems
like a case where a future extension can be made to add a notifier
for NAPI changes (like the netdevice notifier?).

If you think this is a good idea, then we'd do something like:
  1. Document that the NAPI settings are wiped when NAPIs are wiped
  2. In the future (not part of this series) a NAPI notifier is
     added
  3. User apps can then listen for NAPI create/delete events
     and update settings when a NAPI is created. It would be
     helpful, I think, for user apps to know about NAPI
     create/delete events in general because it means NAPI IDs are
     changing.

One could argue:

  When wiping/recreating a NAPI for an existing HW queue, that HW
  queue gets a new NAPI ID associated with it. User apps operating
  at this level probably care about NAPI IDs changing (as it affects
  epoll busy poll). Since the settings in this series are per-NAPI
  (and not per HW queue), the argument could be that user apps need
  to setup NAPIs when they are created and settings do not persist
  between NAPIs with different IDs even if associated with the same
  HW queue.

Admittedly, from the perspective of a user it would be nice if a new
NAPI created for an existing HW queue retained the previous
settings so that I, as the user, can do less work.

But, what happens if a HW queue is destroyed and recreated? Will any
HW settings be retained? And does that have any influence on what we
do in software? See below.

This part of your message:

> we can assume drivers add NAPI instances in order. If driver wants
> to do something more fancy we can add a variant of
> netif_napi_add() which specifies the channel/storage to use.

assuming drivers will "do a thing", so to speak, makes me uneasy.

I started to wonder: how do drivers handle per-queue HW IRQ coalesce
settings when queue counts increase? It's a different, but adjacent
problem, I think.

I tried a couple experiments on mlx5 and got very strange results
suitable for their own thread and I didn't want to get this thread
too far off track.

I think you have much more practical experience when it comes to
dealing with drivers, so I am happy to follow your lead on this one,
but assuming drivers will "do a thing" seems mildly scary to me with
limited driver experience.

My two goals with this series are:
  1. Make it possible to set these values per NAPI
  2. Unblock the IRQ suspension series by threading the suspend
     parameter through the code path carved in this series

So, I'm happy to proceed with this series as you prefer whether
that's documentation or "napi_storage"; I think you are probably the
best person to answer this question :)

