Return-Path: <linux-kernel+bounces-328800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB71797890B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F70284D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7DE1474D9;
	Fri, 13 Sep 2024 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hfMEeYIq"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273F1369BC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256395; cv=none; b=l+GrZHOJqygpmE37r6Lz1TIT8J0Qg7Z0iCSe2k9mqrFcHjiMu70IMvYVY/vCqsEVCZXek0fhNsbUGJKwVFEes5sDQ6MvhqiHvr1K7OvefXOkH0hc2ulnmRpnU5NkqV9eHd71hi/AnSJ0503Ns2DQVtiHMS/D5YJjOxSdPFzQmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256395; c=relaxed/simple;
	bh=CMo7HkkIhI1I7aI8ilt0+qYkkVtrZmJ4OottzfDvO6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj5bm6gVKFg73KpB/uYq07AZj5XbNKIuhRBPXRgJUcukc+h41y30kdwZWVGTkZJSezm/q1FpebgnfgVrIYb+O+PNqXM4fQopANtuOfv2Nn5MrqCSPLMDnnxagrJ8J0jZ+nvX6SKSSAnzeA6h2/1c/lbOWLAuZJ+MzAQzGAs/c54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hfMEeYIq; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a83562f9be9so276490066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726256392; x=1726861192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5CQI17h6VCYt4zGN52zL9wyqg2yBHJSk6YPjhxtg2Q=;
        b=hfMEeYIq0E7XiIOnaENE+m0ZAYe1nK9r3tnTUpseNJtY3+K3k+bLqL3PEIvbwDccXS
         QTC+u5r7eHYDPObbV9f1PUZ2DTmJV2H+oL/VTzLpXLJuGSQjIVUisAVgPNfggWcstxhJ
         lIyon8B3eG+wTroLMMw2bJK6eR7mbJtH9kfeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726256392; x=1726861192;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5CQI17h6VCYt4zGN52zL9wyqg2yBHJSk6YPjhxtg2Q=;
        b=hK7vbT1ZinrVNUXq0ubHEoNU2PyhN2eVHLNshsKACqefirPrckqqW7b+dWoHbLiT1b
         J6w97uG1lADqc0v9uzu+LtNPr/Bsq2tpU1U3BQoHcQ4IHcN+0/T+dfeEbEpH1mv/66W2
         IsgrYqOX9yPTWHc3TlopUBgscuRdt74c1526Ttu6gGEGhBTemewJywo9lNuQ+EXLKIxZ
         wBLD81FmjEhBio/v/NgqMjjrV1ng4GPh+vBnogCXp9AXrM39xcQbCO6qIMm8k9yrq4xV
         NpuoR54R3gy7ORsTAIjoT4iV8ND2YXvBX2Q6B/bEt9LHlt4Wn62uMNgPzO0jnoskIhsJ
         EyWw==
X-Forwarded-Encrypted: i=1; AJvYcCVx/iZclzN9G5kH822QR5VAjR9kldwFv8fGTfvdO9pZOWczQAjZkEoyALljfITPgMoJpJ4xkI6AE5cHO2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OFx3CB/yE1S+Wy0ETeM/JzDG7xNp30lzGcVYz+qq81+7bzfj
	ub3hHJvP19FmixdFw2JsPBFjJ/WDaBzF4Uz7NEiAMOxVyZGW1kmupwAthZPtUSo=
X-Google-Smtp-Source: AGHT+IGt1aG8kG/1Hgn/PR9xu8QfYT2lfl93SU7pfYjcITtFlHzQXzZGxUHxJ1HFhi5SShCzMCXnTQ==
X-Received: by 2002:a17:907:e8d:b0:a86:80ef:4fe5 with SMTP id a640c23a62f3a-a9029617930mr702246266b.47.1726256392054;
        Fri, 13 Sep 2024 12:39:52 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d258354ecsm899909866b.8.2024.09.13.12.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 12:39:51 -0700 (PDT)
Date: Fri, 13 Sep 2024 21:39:49 +0200
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, kuba@kernel.org,
	skhawaja@google.com, sdf@fomichev.me, bjorn@rivosinc.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 5/9] net: napi: Add napi_config
Message-ID: <ZuSVBfgrN5wigT90@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240912100738.16567-1-jdamato@fastly.com>
 <20240912100738.16567-6-jdamato@fastly.com>
 <ZuR5jU3BGbsut-q6@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuR5jU3BGbsut-q6@mini-arch>

On Fri, Sep 13, 2024 at 10:42:37AM -0700, Stanislav Fomichev wrote:
> On 09/12, Joe Damato wrote:

[...]

> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6493,6 +6493,18 @@ EXPORT_SYMBOL(napi_busy_loop);
> >  
> >  #endif /* CONFIG_NET_RX_BUSY_POLL */
> >  
> > +static void napi_hash_add_with_id(struct napi_struct *napi, unsigned int napi_id)
> > +{
> > +	spin_lock(&napi_hash_lock);
> > +
> > +	napi->napi_id = napi_id;
> > +
> > +	hlist_add_head_rcu(&napi->napi_hash_node,
> > +			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
> > +
> > +	spin_unlock(&napi_hash_lock);
> > +}
> > +
> >  static void napi_hash_add(struct napi_struct *napi)
> >  {
> >  	if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
> > @@ -6505,12 +6517,13 @@ static void napi_hash_add(struct napi_struct *napi)
> >  		if (unlikely(++napi_gen_id < MIN_NAPI_ID))
> >  			napi_gen_id = MIN_NAPI_ID;
> >  	} while (napi_by_id(napi_gen_id));
> 
> [..]
> 
> > -	napi->napi_id = napi_gen_id;
> > -
> > -	hlist_add_head_rcu(&napi->napi_hash_node,
> > -			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
> >  
> >  	spin_unlock(&napi_hash_lock);
> > +
> > +	napi_hash_add_with_id(napi, napi_gen_id);
> 
> nit: it is very unlikely that napi_gen_id is gonna wrap around after the
> spin_unlock above, but maybe it's safer to have the following?
> 
> static void __napi_hash_add_with_id(struct napi_struct *napi, unsigned int napi_id)
> {
> 	napi->napi_id = napi_id;
> 	hlist_add_head_rcu(&napi->napi_hash_node,
> 			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
> }
> 
> static void napi_hash_add_with_id(struct napi_struct *napi, unsigned int napi_id)
> {
> 	spin_lock(&napi_hash_lock);
> 	__napi_hash_add_with_id(...);
> 	spin_unlock(&napi_hash_lock);
> }
> 
> And use __napi_hash_add_with_id here before spin_unlock?

After making this change and re-testing on a couple reboots, I haven't
been able to reproduce the page pool issue I mentioned in the other
email [1].

Not sure if I've just been... "getting lucky" or if this fixed
something that I won't fully grasp until I read the mlx5 source
again.

Will test it a few more times, though.

[1]: https://lore.kernel.org/netdev/ZuMC2fYPPtWggB2w@LQ3V64L9R2.homenet.telecomitalia.it/

