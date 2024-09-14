Return-Path: <linux-kernel+bounces-329399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA239790D6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 775EBB2331A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17291E487;
	Sat, 14 Sep 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IpQoebab"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300131DDEA
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726318849; cv=none; b=UCcQPfJrqH2SnLcRecoTkJaNt0P1xRrBJT3PmkfltdLLF5sPIYLMLKAe8oP3J9viH/JitSYSKWkopI3ixWAXu0B049QnJK1FSni/+aqBDJzLyYQBirpUX3/kRWy+4brp2zG8N0g42DpHlRXgVc94fSLc961KVUvLAAD5J872OE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726318849; c=relaxed/simple;
	bh=FlPnTkHRww/0HfCm3LSt7YGaZ1A8XeP5eOeIzOuK9CQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6K+ShxgA+77A6W2E/eBMDSgsT0UcaDWvqrPEp0RQUbElYfTON1DV2Bbr8P1/hC5OtI8iKhkJ54/5Q64GjImhVKy3IlT/H1lh1XE19z1dNWiuaodAZw71T0gL9FIylJqXxV8r0m+AdRPPY4w1ZpjlRNpR08v46DxfNKBBfm7MV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IpQoebab; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso1864746f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726318844; x=1726923644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sVykr97z0XR3OpTPbKddEnashI6uWHYzWI7Isl1zQgQ=;
        b=IpQoebaboEKbcc6XzaakyF7Iyj9mvxR1L2j5eeG9CpNUqGCzqsmAaWWdIVtaHTiBLo
         iEjIJ6BxuyNCxQbNlbAmiCPJXu2sKp0MyLYuko6zeMhqRhUUMdBoXRU4VsIEFZk+402p
         t+e6Qr+eM50SGq7YnUSBzYo/ETV3DgWXIEg8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726318844; x=1726923644;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVykr97z0XR3OpTPbKddEnashI6uWHYzWI7Isl1zQgQ=;
        b=sLYXogDexfWByPwbhimJpg1sHmhHx+x0VO0pWQm85r4ZUbZpU+vTirrRE8splYKPzx
         OhbU16vA5FHN7ljqX7vRHLhZP33mqSY85+JbxT0hyATwFatxo5RzNgRzIynUTXmrho3S
         RRfodI9dUZCvFHecntV8vou1jLgNiW9GlS9zs5WBltosBriFnt+3Kv4+IKgjC51OI/w5
         qI8Buu2fSxqGCEoX9mClcSGFITqbM0QW7ueuhhS2uHsAlWkSDQEHasdYsoE60/clHHSK
         607SOpWanHqAZW8ZZhiEf0CO/nxDzWPWGNZ/IBNPE6rwihxZLkKkzlHeDNXsa311cDXR
         ZChQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Sl8p34JQ1nM4jbt8WK9Jjt2oXz8/ZGtLebJBR2s07IKtIUi+3JreCET59jX4j02PJ+R5Vz0CQOxLBBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7rdkL23rqNA4+Z5mtTW48jfl+UvVc1NEO/22GBtcSYgLAQZM
	QlP86Y6sovHKsA1/dd26mnNrffROsDE0CIhVVFP/WHrxr1P0emxtOYhgewYgzM4=
X-Google-Smtp-Source: AGHT+IG0jBTYaRSVHOu857guVqz4tS/j9DE0cDdQvqOUBnuEaA4yEb8hhcixepV+eRSC65bpXaDyNg==
X-Received: by 2002:a05:6000:bd2:b0:374:c512:87ce with SMTP id ffacd0b85a97d-378d61f0beemr5130162f8f.30.1726318843553;
        Sat, 14 Sep 2024 06:00:43 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e1a55sm77946166b.157.2024.09.14.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 06:00:43 -0700 (PDT)
Date: Sat, 14 Sep 2024 15:00:40 +0200
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
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
Subject: Re: [RFC net-next v3 5/9] net: napi: Add napi_config
Message-ID: <ZuWI-BVwTYll2l43@LQ3V64L9R2.homenet.telecomitalia.it>
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
 <ZuSVBfgrN5wigT90@LQ3V64L9R2.homenet.telecomitalia.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuSVBfgrN5wigT90@LQ3V64L9R2.homenet.telecomitalia.it>

On Fri, Sep 13, 2024 at 09:39:49PM +0200, Joe Damato wrote:
> On Fri, Sep 13, 2024 at 10:42:37AM -0700, Stanislav Fomichev wrote:
> > On 09/12, Joe Damato wrote:
> 
> [...]
> 
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6493,6 +6493,18 @@ EXPORT_SYMBOL(napi_busy_loop);
> > >  
> > >  #endif /* CONFIG_NET_RX_BUSY_POLL */
> > >  
> > > +static void napi_hash_add_with_id(struct napi_struct *napi, unsigned int napi_id)
> > > +{
> > > +	spin_lock(&napi_hash_lock);
> > > +
> > > +	napi->napi_id = napi_id;
> > > +
> > > +	hlist_add_head_rcu(&napi->napi_hash_node,
> > > +			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
> > > +
> > > +	spin_unlock(&napi_hash_lock);
> > > +}
> > > +
> > >  static void napi_hash_add(struct napi_struct *napi)
> > >  {
> > >  	if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
> > > @@ -6505,12 +6517,13 @@ static void napi_hash_add(struct napi_struct *napi)
> > >  		if (unlikely(++napi_gen_id < MIN_NAPI_ID))
> > >  			napi_gen_id = MIN_NAPI_ID;
> > >  	} while (napi_by_id(napi_gen_id));
> > 
> > [..]
> > 
> > > -	napi->napi_id = napi_gen_id;
> > > -
> > > -	hlist_add_head_rcu(&napi->napi_hash_node,
> > > -			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
> > >  
> > >  	spin_unlock(&napi_hash_lock);
> > > +
> > > +	napi_hash_add_with_id(napi, napi_gen_id);
> > 
> > nit: it is very unlikely that napi_gen_id is gonna wrap around after the
> > spin_unlock above, but maybe it's safer to have the following?
> > 
> > static void __napi_hash_add_with_id(struct napi_struct *napi, unsigned int napi_id)
> > {
> > 	napi->napi_id = napi_id;
> > 	hlist_add_head_rcu(&napi->napi_hash_node,
> > 			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
> > }
> > 
> > static void napi_hash_add_with_id(struct napi_struct *napi, unsigned int napi_id)
> > {
> > 	spin_lock(&napi_hash_lock);
> > 	__napi_hash_add_with_id(...);
> > 	spin_unlock(&napi_hash_lock);
> > }
> > 
> > And use __napi_hash_add_with_id here before spin_unlock?
> 
> After making this change and re-testing on a couple reboots, I haven't
> been able to reproduce the page pool issue I mentioned in the other
> email [1].
> 
> Not sure if I've just been... "getting lucky" or if this fixed
> something that I won't fully grasp until I read the mlx5 source
> again.
> 
> Will test it a few more times, though.
> 
> [1]: https://lore.kernel.org/netdev/ZuMC2fYPPtWggB2w@LQ3V64L9R2.homenet.telecomitalia.it/

I was able to reproduce the issue by running a simple script
(suggested by Martin):

  for ((i=0;i<100;i++)); do for q in 1 2 4 8 16 32; do sudo ethtool -L eth4 combined $q ;done;done

It does not seem to reproduce on net-next/main, so it is almost certainly a bug
introduced in patch 5 and the suggested changes above didn't solve the problem.

That said, the changes I have queued for the RFCv4:
  - Updated commit messages of most patches
  - Renamed netif_napi_add_storage to netif_napi_add_config in patch 5 and
    updated the driver patches.
  - Added a NULL check in netdev_set_defer_hard_irqs and
    netdev_set_gro_flush_timeout for netdev->napi_config in patch 5
  - Add Stanislav's suggestion for more safe handling of napi_gen_id in
    patch 5
  - Fixed merge conflicts in patch 6 so it applies cleanly

The outstanding items at this point are:
  - Getting rid of the WARN_ON_ONCE (assuming we all agree on this)
  - Deciding if we are allocating max(rxqs, txqs) or something else
  - Debugging the page pool issue

Jakub suggested the first two items on the list above, so I'm hoping to hear
his thoughts on them :) I have no strong preference on those two.

Once those two are solved, I can send an RFCv4 to see where we are at and I'll
call out the outstanding page pool issue in the cover letter.

I likely won't have time to debug the page pool thing until after LPC, though
:(

