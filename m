Return-Path: <linux-kernel+bounces-328942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34664978B42
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 00:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D311C2142E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158C71714D9;
	Fri, 13 Sep 2024 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MdzDee9x"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB23158A2E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726265426; cv=none; b=j4if1AMbc5/h2M3FnSCdXwOmBK8P2d8Csk3zJ0zF7Aadg4GMwGA8DAJDgYUeMIGhqDqW/lHjGloK8KCdpJczqKnM5EK1MZNhSQOE6cc6hNc3wOrnpdqsm/1fy/GuT208KDn2eQLrS2X5nGE/gEALtxXDjwk+c9zJYaHdB2dGCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726265426; c=relaxed/simple;
	bh=ZTrfQuGyFCS2AsumcTg+w0rsaBjorwPEQGTzauk5ka4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wau3s8JtGba3sKsQ1mNpzyIXTdFv8pCQ7G96Tsb6s1dzxZqXyk42HafPy1YPRncyF/3RlYU1NGNF1o9IDoE3hIzihR0wbICtwOpd4HvKwedv0/sHVfS1hcny5aI5OyR0LFJe3LijYXMyjGoJ+9ORoLdbvIOcPwbWcM7FTYexLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MdzDee9x; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a8d4979b843so351313166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726265423; x=1726870223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2meYNilRRL6ZpxyzsdbYRL3GzilIc/By/jbXG6B3og=;
        b=MdzDee9xXIQogUptTZXOI6ehP2KyU0tm9T7Rd81c227iJoTWo+phzRYEecI8Hrru/9
         2lI+XBVbaOtlzUxtJr4vAxjkHYZkyMgRh/2FJQjPI5/kxekv0wmibxIP1A0asWr2E5cQ
         KZ2YGWn0C7uUShTz3zhJnBAlPTchHDMqcWJhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726265423; x=1726870223;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2meYNilRRL6ZpxyzsdbYRL3GzilIc/By/jbXG6B3og=;
        b=eOn/Ns5m2lTWaNdRtHGrFjwQS7XQSvhNrFpemMFIHPNSW1a9V/dIQlEq7VybnJTHov
         5cdH8c+zdLG7YrjzvWVatjGfmH9tUnjZ89jl2yT1my5vlWRUsJHrC9k8yxAvOMIsRm+h
         k9W+miyMmS94tyMDvLqQ7TM24GV0sVDFjXiiHVmbaoAKEyluxTyBCoNI3mDSFWSpCzcx
         XW0u7BqegnsfA4aq8PYXAihOmmppDDORt3NY3Hfvkti+Rx/a9V4TLfWuFTtXsyMSHEdK
         tsvUYHEYPAs6KMtJAyvI4T99rnIW/bNqySXjiq6AwJIUNVv5/YLeF+xzh+xz9gvMKD0a
         PMzA==
X-Forwarded-Encrypted: i=1; AJvYcCVfDwcvFvQaIMVsexGi1DI8mtrlVrAIyQf1RQwMDc8s7sEHkZ74znIvA7VrcsRQ3YxNjgLuoNyABav3Q9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSa0zNagd4v5QIgimuujI3nVyDAFsAoArUYOtzVbGKsMMRKwb
	eCnOaWbgB1y/gTp4W6tf2E74ZInUEMHDrN6TkdQeWS8i5AxcoK2v0jzwULicDiQ=
X-Google-Smtp-Source: AGHT+IHMv+xQ92SQKfyzVo4RGOq07H2MNmmuAoswMF/cR5l8+MgG69+X0nRVWM0vA+1c1UFohOSB8w==
X-Received: by 2002:a17:906:7313:b0:a8d:128a:cc49 with SMTP id a640c23a62f3a-a902961ab57mr687116566b.52.1726265422469;
        Fri, 13 Sep 2024 15:10:22 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e573csm4710166b.180.2024.09.13.15.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 15:10:22 -0700 (PDT)
Date: Sat, 14 Sep 2024 00:10:19 +0200
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
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
Message-ID: <ZuS4S-TPa8b2TWXH@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca, kuba@kernel.org,
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
References: <20240912100738.16567-1-jdamato@fastly.com>
 <20240912100738.16567-6-jdamato@fastly.com>
 <ZuMC2fYPPtWggB2w@LQ3V64L9R2.homenet.telecomitalia.it>
 <66e4b22743592_19ec3c294db@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e4b22743592_19ec3c294db@willemb.c.googlers.com.notmuch>

On Fri, Sep 13, 2024 at 05:44:07PM -0400, Willem de Bruijn wrote:
> Joe Damato wrote:
> > Several comments on different things below for this patch that I just noticed.
> > 
> > On Thu, Sep 12, 2024 at 10:07:13AM +0000, Joe Damato wrote:
> > > Add a persistent NAPI config area for NAPI configuration to the core.
> > > Drivers opt-in to setting the storage for a NAPI by passing an index
> > > when calling netif_napi_add_storage.
> > > 
> > > napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
> > > (after the NAPIs are deleted), and set to 0 when napi_enable is called.
> > 
> > Forgot to re-read all the commit messages. I will do that for rfcv4
> > and make sure they are all correct; this message is not correct.
> >  
> > > Drivers which implement call netif_napi_add_storage will have persistent
> > > NAPI IDs.
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> > > @@ -11062,6 +11110,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> > >  		return NULL;
> > >  	}
> > >  
> > > +	WARN_ON_ONCE(txqs != rxqs);
> > 
> > This warning triggers for me on boot every time with mlx5 NICs.
> > 
> > The code in mlx5 seems to get the rxq and txq maximums in:
> >   drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >     mlx5e_create_netdev
> > 
> >   which does:
> > 
> >     txqs = mlx5e_get_max_num_txqs(mdev, profile);
> >     rxqs = mlx5e_get_max_num_rxqs(mdev, profile);
> > 
> >     netdev = alloc_etherdev_mqs(sizeof(struct mlx5e_priv), txqs, rxqs);
> > 
> > In my case for my device, txqs: 760, rxqs: 63.
> > 
> > I would guess that this warning will trigger everytime for mlx5 NICs
> > and would be quite annoying.
> > 
> > We may just want to replace the allocation logic to allocate
> > txqs+rxqs, remove the WARN_ON_ONCE, and be OK with some wasted
> > space?
> 
> I was about to say that txqs == rxqs is not necessary.

Correct.

> The number of napi config structs you want depends on whether the
> driver configures separate IRQs for Tx and Rx or not.

Correct. This is why I included the mlx4 patch.

> Allocating the max of the two is perhaps sufficient for now.

I don't think I agree. The max of the two means you'll always be
missing some config space if the maximum number of both are
allocated by the user/device.

The WARN_ON_ONCE was added as suggested from a previous conversation
[1], but due to the imbalance in mlx5 (and probably other devices)
the warning will be more of a nuisance and will likely trigger on
every boot for at least mlx5, but probably others.

Regardless of how many we decide to allocate: the point I was making
above was that the WARN_ON_ONCE should likely be removed.

[1]: https://lore.kernel.org/lkml/20240902174944.293dfe4b@kernel.org/

