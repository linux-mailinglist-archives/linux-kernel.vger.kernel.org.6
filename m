Return-Path: <linux-kernel+bounces-320301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BB2970882
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BBA1F21828
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB411741FD;
	Sun,  8 Sep 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Zf3T5kmP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924AF170A19
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811049; cv=none; b=aVs42+6C9D8/I3QsCx0x61zCy7Kjhq9cKLu7gG0le+9YIibqiR4iCifB33MG6uTY+og/ApPrOdb2EWb/hO9x3CSfErp8kVpUfthoyx6j/cm5pGsw5sJAvurUEFY4y9YfePKwPpVqzdqc4DI0eFqpPmpCJi7VvNzRDZE9juIo4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811049; c=relaxed/simple;
	bh=Fn07FkjO4KL+zrTmO8nEprjo3WSCE7Ic9mY7bx/fY5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVkozhvAeaDGtbuODNzDWcgUYH02eNnGHBYlFErg0lHk+KmkmyW11ANobyEbAlQbL24W9DfJhjDOmfC7V535jh5jBQ/+EnpcbnSNOQSY3XMT+urFUGOFCJYdUWdPhF90permVCKlFLstLb1+7AFdeX/qppsmxEoHItJI5tV3gRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Zf3T5kmP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c3ed267a7bso957937a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811046; x=1726415846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3a8KnBDMWn4RkRd2/jsnNyy9ICxVO6K+kLrOwSfi54k=;
        b=Zf3T5kmPGJO+3d5toeiF/CuTvS+hr76qI88G6mMAPFC+WU3LACT9yZXHZIoCMeEuID
         2gP6/UdBBckpWLtpvYBnyrv5YVIHywSiPsFNxEROyGiNx8i92i2YbFRdS9ek9mZGRTh2
         Mhflp8vxHo5ZtLYTUZ0KCDkJd8kCYiozeux9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811046; x=1726415846;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3a8KnBDMWn4RkRd2/jsnNyy9ICxVO6K+kLrOwSfi54k=;
        b=CgC70Iu7VRn8U2jawXhRM7BBIQgAslPoKMowv9JqQz0Ukfp86sE71GXx13hb16GiKP
         0+Wv3yzulbJGRPrWRnf1NmFufAXw1XaBpkRtP9l7RCyKH1QDVtJNKv0bbnX3TlinHRKZ
         ECrrhNGBt96Q4KM7lMPLKndBK4kCpmM5dlvrPOzDQ3pgDkkiaAPbU2Y23rdjYsjQlJoG
         +WSBQjhsxpmfrlfjRFR+gLpW5D6k+tqzXx8OrP4pinsQsD0I4z+w5UML7fJjh5NZEuCf
         vhlQzRNxGcHGZ2rzbklBTO2EpnddznkB0vdPzAXfKIgReiQJsDS9QWpaIaCGWgnLVroR
         EjCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU9Ts6Xkq6SnD0gnXo0auHvULKAuNdGLakMH4aadCyenDwyS0cQyX8GZproowhVKEHfj0VyBZ8jMldE+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXEoO/dEW11qc9mIXJH1fCKW41sp9LSa3cyCO7UIgJkWKbsWhd
	EVajpRr7eG+OjStiDuKo2Cs6UetEQ8oW24qmUYWs1h47QXaqh1lUj77gFzALimE=
X-Google-Smtp-Source: AGHT+IHzWsWXV7IUa/mSepFTAuyyHM/JET+7iZmqlHiIFLew/7QKd46VQ7tAbIv1i4vvQzOWB4wtFQ==
X-Received: by 2002:a17:907:3205:b0:a86:7b01:7dcc with SMTP id a640c23a62f3a-a8a885faa86mr676469066b.18.1725811044906;
        Sun, 08 Sep 2024 08:57:24 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2583555csm220675266b.15.2024.09.08.08.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 08:57:24 -0700 (PDT)
Date: Sun, 8 Sep 2024 17:57:22 +0200
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <Zt3JYp5Ltz5Imnq8@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>,
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
 <ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
 <20240830142235.352dbad5@kernel.org>
 <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
 <Ztjv-dgNFwFBnXwd@mini-arch>
 <20240904165417.015c647f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904165417.015c647f@kernel.org>

On Wed, Sep 04, 2024 at 04:54:17PM -0700, Jakub Kicinski wrote:
> On Wed, 4 Sep 2024 16:40:41 -0700 Stanislav Fomichev wrote:
> > > I think what you are proposing seems fine; I'm just working out the
> > > implementation details and making sure I understand before sending
> > > another revision.  
> > 
> > What if instead of an extra storage index in UAPI, we make napi_id persistent?
> > Then we can keep using napi_id as a user-facing number for the configuration.
> > 
> > Having a stable napi_id would also be super useful for the epoll setup so you
> > don't have to match old/invalid ids to the new ones on device reset.
> 
> that'd be nice, initially I thought that we have some drivers that have
> multiple instances of NAPI enabled for a single "index", but I don't
> see such drivers now.
> 
> > In the code, we can keep the same idea with napi_storage in netdev and
> > ask drivers to provide storage id, but keep that id internal.
> > 
> > The only complication with that is napi_hash_add/napi_hash_del that
> > happen in netif_napi_add_weight. So for the devices that allocate
> > new napi before removing the old ones (most devices?), we'd have to add
> > some new netif_napi_takeover(old_napi, new_napi) to remove the
> > old napi_id from the hash and reuse it in the new one.
> > 
> > So for mlx5, the flow would look like the following:
> > 
> > - mlx5e_safe_switch_params
> >   - mlx5e_open_channels
> >     - netif_napi_add(new_napi)
> >       - adds napi with 'ephemeral' napi id
> >   - mlx5e_switch_priv_channels
> >     - mlx5e_deactivate_priv_channels
> >       - napi_disable(old_napi)
> >       - netif_napi_del(old_napi) - this frees the old napi_id
> >   - mlx5e_activate_priv_channels
> >     - mlx5e_activate_channels
> >       - mlx5e_activate_channel
> >         - netif_napi_takeover(old_napi is gone, so probably take id from napi_storage?)
> > 	  - if napi is not hashed - safe to reuse?
> > 	- napi_enable
> > 
> > This is a bit ugly because we still have random napi ids during reset, but
> > is not super complicated implementation-wise. We can eventually improve
> > the above by splitting netif_napi_add_weight into two steps: allocate and
> > activate (to do the napi_id allocation & hashing). Thoughts?
> 
> The "takeover" would be problematic for drivers which free old NAPI
> before allocating new one (bnxt?). But splitting the two steps sounds
> pretty clean. We can add a helper to mark NAPI as "driver will
> explicitly list/hash later", and have the driver call a new helper
> which takes storage ID and lists the NAPI in the hash.

It sounds like you all are suggesting that napi_id is moved into the
napi_storage array, as well? That way NAPI IDs persist even if the
NAPI structs themselves are recreated?

I think that's interesting and I'm open to supporting that. I wrote
up an RFC that moves stuff in the direction of napi_storage and
modifies 3 drivers but:
  - is incorrect because it breaks the persistence thing we are
    talking about, and
  - it doesn't do the two step take-over thing described above to
    inherit NAPI IDs (as far as I understand ?)

I'm going to send the RFC anyway because I think it'll be easier to
pick up the discussion on code that is hopefully closer to where we
want to land.

I hope that is OK.

- Joe

