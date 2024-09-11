Return-Path: <linux-kernel+bounces-324085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608F9747C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FBF1C25ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09428DB3;
	Wed, 11 Sep 2024 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="eNNUzauZ"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A827456
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018069; cv=none; b=oRbuTbv2Eki8aUkbbpin93NiYJq+ZnywJ12tNJKSTXw5QdILPzEJrceitCMkpjgGj4KXpBHw0hwpDGHyseC/O9qro4txVUimZ6UP19Ok4Akp7FAOIUS4ITINWSdzNYOjQWfhh681JEExNKmbedRV7moKrejW5ZZj7kVXGzkKv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018069; c=relaxed/simple;
	bh=OnbverfZMHXfJO4VbN17IMpueSZrdBDLytCG1WLkAng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deVnx9NfsLuQPpcpHdF7dImByI5MYIUqNFqwN3LkH2Vdbdt17xGd0EosZXpVdv9Kj6AWb3XrdJoXKgQ8stMFjJFs5ZMGln+U+y1GEKAs3hP5YYlp1M5N/xmbLXKaLqnZc7IJwXz+u3DBmMfTF9krXwbZ8lzBuTEt3gWNQfnXrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=eNNUzauZ; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=eNNUzauZ;
	dkim-atps=neutral
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id A9549356
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:27:46 +0900 (JST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-205529c3402so81349135ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1726018066; x=1726622866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=piebQm/1epxkP81mU8tuwXGPc4HtMsCSKOg4ODSsprs=;
        b=eNNUzauZTncp8f97kFj/5LHBDs++mEwUPgIwEG4GfqyolSxnmrmZpKV7r0LY1MoHiS
         QEa0jnIzdgqHrpBJH4ex0Ug1jDG3VxYwrGlh4Lt8bdXnsgXVd9+LNlVrSM6PYrOaqz40
         7sQ3zc6mFAnrZOm+TBtVXZ3NzXLW8F5A9xbUw5D4UBrHDhR77ucbeqG26hlHY+7YZva2
         AOVAGrL7faw2GjSGnK4v1bzjcJEnhABbEoeUcxgYBHbBPuUwWxXNk4GpaBXFvS7MVmfy
         LcIFXctIJgm6PDrMyyDZ9C38UqukJWQ8HWc73ABeUotriumxaPl1E2m1ayqXIV38gMbr
         BCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726018066; x=1726622866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piebQm/1epxkP81mU8tuwXGPc4HtMsCSKOg4ODSsprs=;
        b=eCL/FqdT8dutgjDvryhUQxoaLN5DIxRzfiML6EpAkXsN7SbjTid5GjUNs5UP/8poDn
         nKLgZW5WQRFxc/xvaM013vlCgZJNbLZ5589MU/Mfip+zjg2Ow5pBFiWs2Y9jNm0PRpQI
         B0GPJ96XfCr7Qo4U5vTdPffy4v8XDKrLEgad0uvWg1s4BwUcUMlPgdvKZF7UirXJDv6C
         tN6VisZyuPrtWAFTa1hdb4Pq13zcdnjJQU98ub5x4mJc6fDvp0iRTuRqOyesAVtJmBu1
         U0ZAa3VhCK1QA9if2P2fFKh3n+na4KV7KWsPOrRK7LqM4R2P8miEdegtVHF0pe4SfTUj
         E/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXquDDTgfGXbGe5rI+8mG5/0/oL8oY2LjXvPxsqexkoC/TNcmSGEXIcVOtRLNdzF7ZCjRm22j80RKVzuKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PGnyC8deI553bNTCu6W8rgpteM/thc2r2TbH37fQbv5kGgxa
	5sriSV0xIChQpV7NdYXyn2P4EO9hjFpV4AYIc3cyz68o3/x7T+7oveAe97VGacGH10/l2wT3PPt
	K7ADeIr7O4ZolHx0IuQRz4vJA7+OzQ+UvaCk0/2O7C5bLDBmqMOusiTki+snKsLjC57RH+jo=
X-Received: by 2002:a17:902:d511:b0:207:2093:99a3 with SMTP id d9443c01a7336-2074c4c4fe4mr23879945ad.5.1726018065721;
        Tue, 10 Sep 2024 18:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGazzt/LaGGBY2DoRrtPEoEdLzev+TuypaNYFEnIn0/5MgpFyaXvG93yy4tnQ/hkAPoU1RVew==
X-Received: by 2002:a17:902:d511:b0:207:2093:99a3 with SMTP id d9443c01a7336-2074c4c4fe4mr23879675ad.5.1726018065232;
        Tue, 10 Sep 2024 18:27:45 -0700 (PDT)
Received: from localhost (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e3368bsm54300225ad.95.2024.09.10.18.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 18:27:44 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:27:33 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: Frieder Schrempf <frieder@fris.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] Extending PLL LUT for i.MX8MP Samsung HDMI PHY
Message-ID: <ZuDyBQ1I2vcGzAqX@atmark-techno.com>
References: <20240910181544.214797-1-frieder@fris.de>
 <ZuDjAwPxHeJTvXAp@atmark-techno.com>
 <CAHCN7xJD8jsqyZX1JkWxrA84XkZ8YYN19hXW6KVe+jkOFugqrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7xJD8jsqyZX1JkWxrA84XkZ8YYN19hXW6KVe+jkOFugqrw@mail.gmail.com>

Adam Ford wrote on Tue, Sep 10, 2024 at 08:16:04PM -0500:
> > That aside, I see no problem with this, just one meta-comment about
> > adding a link to the script in an external repo: I see some other
> > drivers have python scripts in their trees e.g.
> > drivers/comedi/drivers/ni_routing/tools/*py
> > drivers/gpu/drm/ci/xfails/update-xfails.py
> > drivers/gpu/drm/msm/registers/gen_header.py
> >
> > would it make sense to commit the script here instead of linking to a
> > repo that might be lost in the future?
> >
> > I'm not quite sure what policy the linux repo has here, so leaving that
> > as an open question.
> 
> Is there a reason this couldn't be coded in C and used to expand my
> integer calculator series?  With that, we could drop the lookup table.

Quoting a previous mail from Frieder:
> I will clean things up a bit and then share what I have. I hope that this
> allows anyone to calculate parameters for their non-standard displays if
> required.
> 
> If someone feels extra motivated they could try to calculate the fractional
> parameters at runtime. However I'm not sure that this is feasible. The
> numerical computation of a large number of parameters is quite heavy and it's
> probably not easy to strip the algorithm down to something that can be run on
> the target without too much overhead.

Trying a random frequency with the algorithm he has implemented it
easily takes 10 seconds to run on my imx8mp board, so even if we asssume
C is 3-4 times faster I think the current algorithm is too slow for
runtime and it makes more sense to extended the LUT to me (as long as
the values can be & are checked at least once, which we now can)

The current algorithm brute-forces its way through so there could be a
better way of computing the fractional part of the divider, but I'm not
sure it's worth the effort at this point; I guess it's a good
intellectual challenge though so someone might do it in the future.

-- 
Dominique

