Return-Path: <linux-kernel+bounces-324374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 997D2974BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293351F24F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6284A1422C3;
	Wed, 11 Sep 2024 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SLeotUed"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5896A33B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040841; cv=none; b=kC+YPvOTGJaekkAH/tiiTRzn6jaI/XkrQTkAD4vCsTtD2xmJBNv7qbahuMNNvmmfcy+XYfRl6SoNWz2+x2EmMObgnG395UoG/x4b7ZgqsJEf/VaOgarOeM6lQNEeWnMFPmIgB/nOmvHKvNSvk3CTISppFOTm0F1Gw+mS+S/r2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040841; c=relaxed/simple;
	bh=OSECwwry7omDw6kVuf9LHDYXkSDxt9YPV7Chpakq6C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp+xr5GspwasTcrq7OLxcdo4pDO+qP6jm8c+YpV1N5+VG3C0w8mM2o/WjTi7AmGO5hxU89xOXZHjpRQuDBwiKxNgSPpwtVES3CwGGjg1Tz4YSJlu0FdgSGTWtytf0bxo6O8lzJUsabDwxTQWjnTYtZlETgT3hLCZUjvRV/4wtl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SLeotUed; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so565441166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726040838; x=1726645638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrC/2SxsXmHRQDCmsuooXppFrVV7rFAi0NzzJwvVREs=;
        b=SLeotUedzuMBPYTjKneko6JwucYlvGxuwUa6tvu59iDQH3ziiCt5L0UN3c5yLrNINx
         8wh3ocW2XIQcguM8ReazAS5Gp2rBoFYgOfzIOvzwE1zEasQfL0Ya16nuZxs2pwxRyGLG
         aVctwYYM00MiLpqW7wGCZZnuG9lVMXapfYGNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040838; x=1726645638;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrC/2SxsXmHRQDCmsuooXppFrVV7rFAi0NzzJwvVREs=;
        b=s58nyqof2R+0PxWr2fIafAVu2BUu3hctOafdQ5hesx4NN0NPKAI4uday13CQoL5iJB
         e6vQ9ssIdF/g8HWZJQgfzKqC26AFsRG2Up9HSnjxSF+SEAGVO8LgNxNmfA73+4CMgBkR
         Jp9NFBjPk9944QAmXeJuaXNM7f1aOOkhkqX8WQcfDc8g8RYgylaLAcos0yVwmnHGTCog
         7N/sWcnaB8jb67r3djG6je6jtzoFmBcO9Zvmfg0DyonRcrybCgcNh5VOfI+xAN2fBF4K
         dNIN9/kqY1zMc1VtTylgYlPzseknnpZmhxOs2Wa58BjsKSli9nirVYPqeXinR8hPCZFw
         07tg==
X-Forwarded-Encrypted: i=1; AJvYcCUZjBJt+dpVb98bU35CnS8b/CavCj/5BoyJKPVIiB90ANMMnJs/6UPGQBgjSqI/bTbqFHTV2tXUZkflAdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtMxlrunDEcwpgHUSiftyy94davVykhml5+fTDIIKSXAGuHRw
	JjPqWzaVBp4BI7JVXhUD6lMVo5AwKHxaCJcpskGs3cmBDMwQBLxdzXzuc4UegWs=
X-Google-Smtp-Source: AGHT+IEIx/mVHa5yX7Ld738n4e5sy7cq4wrJvNFFRjI3e4hFieDqXbaBbnIg+7b98YiMjPfGwEdfrQ==
X-Received: by 2002:a17:906:4fcc:b0:a86:7a84:abb7 with SMTP id a640c23a62f3a-a8ffab2a178mr347062666b.20.1726040837395;
        Wed, 11 Sep 2024 00:47:17 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d63c0fsm583648666b.213.2024.09.11.00.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:47:16 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:47:14 +0200
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 1/9] net: napi: Add napi_storage
Message-ID: <ZuFLAnheyMGrJjym@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240908160702.56618-1-jdamato@fastly.com>
 <20240908160702.56618-2-jdamato@fastly.com>
 <20240909164039.501dd626@kernel.org>
 <Zt_jn5RQAndpKjoE@LQ3V64L9R2.homenet.telecomitalia.it>
 <20240910075217.45f66523@kernel.org>
 <ZuBvgpW_iRDjICTH@LQ3V64L9R2.homenet.telecomitalia.it>
 <20240910171048.768a62b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910171048.768a62b0@kernel.org>

On Tue, Sep 10, 2024 at 05:10:48PM -0700, Jakub Kicinski wrote:
> On Tue, 10 Sep 2024 18:10:42 +0200 Joe Damato wrote:
> > On Tue, Sep 10, 2024 at 07:52:17AM -0700, Jakub Kicinski wrote:
> > > Hm, fair point. In my mind I expected we still add the fast path fields
> > > to NAPI instances. And the storage would only be there to stash that
> > > information for the period of time when real NAPI instances are not
> > > present (napi_disable() -> napi_enable() cycles).  
> > 
> > I see, I hadn't understood that part. It sounds like you were
> > thinking we'd stash the values in between whereas I thought we were
> > reading from the struct directly (hence the implementation of the
> > static inline wrappers).
> > 
> > I don't really have a preference one way or the other.
> 
> Me neither. I suspect having the fields in napi_struct to be slightly
> more optimal. No need for indirect accesses via napi->storage->$field,
> and conditions to check if napi->storage is set. We can make sure we
> populate the fields in NAPIs when they are created and when sysfs writes
> happen. So slightly better fastpath locality at the expense of more
> code on the control path keeping it in sync.
> 
> FWIW the more we discuss this the less I like the word "storage" :)
> If you could sed -i 's/storage/config/' on the patches that'd great :)

Yup, I actually did that yesterday. I also like config more.

Right now, I have:
  - struct napi_config
  - in the napi_struct its a struct napi_config *config
  - in the net_device its a struct napi_config *napi_config

I figured in the second case you are already de-refing through a
"napi_struct" so writing "napi->napi_config->..." seemed a bit wordy
compared to "napi->config->...".
 
> > > > I don't think I realized we settled on the NAPI ID being persistent.
> > > > I'm not opposed to that, I just think I missed that part in the
> > > > previous conversation.
> > > > 
> > > > I'll give it a shot and see what the next RFC looks like.  
> > > 
> > > The main reason to try to make NAPI ID persistent from the start is that
> > > if it works we don't have to add index to the uAPI. I don't feel
> > > strongly about it, if you or anyone else has arguments against / why
> > > it won't work.  
> > 
> > Yea, I think not exposing the index in the uAPI is probably a good
> > idea? Making the NAPI IDs persistent let's us avoid that so I can
> > give that a shot because it's easier from the user app perspective,
> > IMO.
> 
> Right, basically we can always add it later. Removing it later won't
> be possible :S

Yup, I totally get that.
 
> > > > Only one way to find out ;)
> > > > 
> > > > Separately: your comment about documenting rings to NAPIs... I am
> > > > not following that bit.
> > > > 
> > > > Is that a thing you meant should be documented for driver writers to
> > > > follow to reduce churn ?  
> > > 
> > > Which comment?  
> > 
> > In this message:
> > 
> > https://lore.kernel.org/netdev/20240903124008.4793c087@kernel.org/
> > 
> > You mentioned this, which I interpreted as a thing that core needs
> > to solve for, but perhaps this intended as advice for drivers?
> > 
> >   Maybe it's enough to document how rings are distributed to NAPIs?
> >   
> >   First set of NAPIs should get allocated to the combined channels,
> >   then for remaining rx- and tx-only NAPIs they should be interleaved
> >   starting with rx?
> >   
> >   Example, asymmetric config: combined + some extra tx:
> >   
> >       combined        tx
> >    [0..#combined-1] [#combined..#combined+#tx-1]
> >   
> >   Split rx / tx - interleave:
> >   
> >    [0 rx0] [1 tx0] [2 rx1] [3 tx1] [4 rx2] [5 tx2] ...
> >   
> >   This would limit the churn when changing channel counts.
> 
> Oh, yes. I'm not sure _where_ to document it. But if the driver supports
> asymmetric ring count or dedicated Rx and Tx NAPIs - this is the
> recommended way to distributing the rings to NAPIs, to, as you say,
> limit the config churn / mismatch after ring count changes.

OK, so that seems like it's related but separate from the changes I
am proposing via RFC, so I don't think I need to include that in my
next RFC.

