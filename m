Return-Path: <linux-kernel+bounces-561828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B017A616E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8165B17D548
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB1204098;
	Fri, 14 Mar 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="JGv9RUJS"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D118B494
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741971469; cv=none; b=MVw54+XMfj1SPf+h7e71csYV8A694O3+4xIy3kqSTO70Nss3nvU4p0Hjdt1Kdu7+t4DsDQOoQPG2V8t8ig6CMNobQ6dijb68oGMmmp6Jwaf0/DBUUWTGw37tO3C2e2darMmOh5IRrD+YQCygoYPuHbCDHa8tRmZMAu6PKiVR0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741971469; c=relaxed/simple;
	bh=iAzF9u+HY2kWX0aOrmwyvAyeoOPyHcnPC1du2Is0Z7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMLD/oDDk6aQDWx991fDucB2ItQRewzCZyZjkgw+xXouGlpxgFcpA72gyOvJQji7QiDBQla29u0wB5VuyxkC6tjgQBhw5/tIFf5EoA5ssVE1QD0WZ04248PJTSuvj7xEYPvS6Mp8E4xBNlrp1Sr0zo4W0T3wKOzMlFegpxWpGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=JGv9RUJS; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4769bbc21b0so23378021cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741971464; x=1742576264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bVU7xRz9+BuoJ0Omh1aw8MsUvRzQCT7HAyopIIXQUc=;
        b=JGv9RUJStXJD6t55Ujroc81w3VhVTXUfbZeL/TcT8yx2fO96jIq4QCjIzv4yitJCH/
         gXnEyNL3O8PUFiqus+ymz6HrpC1srQXnjm3KOSEqKMcUfYI+V5pXpAl2SFmvKizh0gCO
         4VJvmm/FtrNuRLQJSsDMxLGya4jHb+Av964awct04PxthoYqJqjrc8Rvgbsbj1UCDXp+
         otw1Z0vRP97ihOv790NPcKg/PON2iqbppGuQqui97z9GLi1RiOMrVeg96Ip7UmLjLA35
         6kw85P8hpj8cOaZWHGstdfuz7P6w+uDtS/R341JdM29jFZINqtV2vEzpG+pZRrI4uU5Y
         WJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741971464; x=1742576264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bVU7xRz9+BuoJ0Omh1aw8MsUvRzQCT7HAyopIIXQUc=;
        b=q0NY5omUBEiVNNE/UFZ+D36aulTwtw3kffGO2j2qKITz38eroKu7hSJ1rWXYqJBaBz
         I5esRfrQUMYITzM7ii16BkiaXl58vHb9zYBh6U2n88uLRDxD0A05Px9WVZDAbtoWnkkC
         LXfJMM3vt7BFGXVjc3/WNinNwhvGJPWuGIhgmhN5YwYxKFr7Fg1ifFbOeYRIbdhZp39w
         vcMojZdh9buXEtTV3Sssqt8c3j641Gm4l7GkygenLQhfdV/X+BP835x11xob2y+X39FS
         b38VwCrK+QMdNlIS4yueCPz2sqxOGf+oSUrmFkAkkdLbduTMO7W3pzSIXRs2KwxSXY3l
         AovA==
X-Forwarded-Encrypted: i=1; AJvYcCWBgm6uE9ZWQDIzQzUTYegjqnDdK5HISaqJwqHms51DfUHJUFSNWsDuB8fYuZxEQbgdHBp5bS9e7d6cEQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweDVhUg4yqztrKzjCH4BIqgekrpa1/sgD30qze6SAXGzDiRyPI
	dNdM56gNq7kR+dF4ym8skZQZuB9msGQplrHOxM7KLhX0ebgAPcw0yeea7qP6IW0=
X-Gm-Gg: ASbGncuQ0VKJ3zRPBPYs3ixQTBs0VsewzFUQyFwyR2kH7SO4UvNvy2lLWxtwauqCrPb
	U2I6JCw6uPuVZS82RO3iVnIXFRzorVGsgL7rNnkijFjMyuENpNsTS0/IxW2OZ7PoWChFKY1s6iA
	NP7PIg3qS9gXR/jcaL1x+vd9vVAr/9LdDQNCKlpjDSIiSTUvcvU+JMMAM0akQE/ZK33ijHgQenJ
	16CklmLH1toFnX2AzreH96YzFXy/g/Fgkq2QuB0mOZtb4sAAmGJlHE7O30oH0rhha/68xx3lbhM
	R+kqcjWHLocFy42ikhiB9lqhMV6rm+LqO6OAiETl868lc88tHR4ltw==
X-Google-Smtp-Source: AGHT+IGRjUQU+0AC9eIw4hobeKQ9HxQMqF5ruqdLJhpFMzyfDl2DBx9fQrFgm3nT4YDNxDk/2xCZAg==
X-Received: by 2002:a05:622a:11d4:b0:476:b956:c5b9 with SMTP id d75a77b69052e-476c8152ccemr45548701cf.27.1741971464531;
        Fri, 14 Mar 2025 09:57:44 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb63baabsm25428341cf.28.2025.03.14.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:57:43 -0700 (PDT)
Date: Fri, 14 Mar 2025 12:57:39 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>, akpm@linux-foundation.org,
	muchun.song@linux.dev, yosry.ahmed@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: vmscan: skip the file folios in proactive reclaim
 if swappiness is MAX
Message-ID: <20250314165739.GB1316033@cmpxchg.org>
References: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
 <Z9PuXMlHycL6Gco0@tiehlicka>
 <Z9P2nZ6b75FRMhCp@tiehlicka>
 <20250314141833.GA1316033@cmpxchg.org>
 <Z9RB-gHgtXRc86ro@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9RB-gHgtXRc86ro@tiehlicka>

On Fri, Mar 14, 2025 at 03:49:30PM +0100, Michal Hocko wrote:
> On Fri 14-03-25 10:18:33, Johannes Weiner wrote:
> > On Fri, Mar 14, 2025 at 10:27:57AM +0100, Michal Hocko wrote:
> [...]
> > > I have just noticed that you have followed up [1] with a concern that
> > > using swappiness in the whole min-max range without any heuristics turns
> > > out to be harder than just relying on the min and max as extremes.
> > > What seems to be still missing (or maybe it is just me not seeing that)
> > > is why should we only enforce those extreme ends of the range and still
> > > preserve under-defined semantic for all other swappiness values in the
> > > pro-active reclaim.
> > 
> > I'm guess I'm not seeing the "under-defined" part.
> 
> What I meant here is that any other value than both ends of swappiness
> doesn't have generally predictable behavior unless you know specific
> details of the current memory reclaim heuristics in get_scan_count.
> 
> > cache_trim_mode is
> > there to make sure a streaming file access pattern doesn't cause
> > swapping.
> 
> Yes, I am aware of the purpose.
> 
> > He has a special usecase to override cache_trim_mode when he
> > knows a large amount of anon is going cold. There is no way we can
> > generally remove it from proactive reclaim.
> 
> I believe I do understand the requirement here. The patch offers
> counterpart to noswap pro-active reclaim and I do not have objections to
> that.
> 
> The reason I brought this up is that everything in between 0..200 is
> kinda gray area. We've had several queries why swappiness=N doesn't work
> as expected and the usual answer was because of heuristics. Most people
> just learned to live with that and stopped fine tuning vm_swappiness.
> Which is good I guess.

You're still oversimplifying and then dismissing. The heuristics don't
make swappiness meaningless, they make it useful in the first place.

  This control is used to define the rough relative IO cost of swapping
  and filesystem paging, as a value between 0 and 200.

This is clearly defined, and implemented as such. cache_trim_mode is
predicated on the *absence* of paging and caching benefits: A linear,
use-once file access pattern that *does not* benefit from additional
cache space. Kicking out anon for that purpose would be wrong under
pretty much any circumstance. That's why it "overrides" swappiness:
swappiness cannot apply when swapping at all would be nonsense.

Proactive reclaimers like ours rely on this. We use swappiness to
express exactly what it says on the tin: the relative cost between
thrashing file vs anon. We use it quite effectively to manage anon
write rates for flash wear management e.g. Obviously that doesn't mean
we want to swap when somebody streams through a large file set.

Zhongkun's case is a significant exception. He just wants to get rid
of known-cold anon set. This level of insight into userspace access
patterns is rare in practice. You could argue that MADV_PAGEOUT might
be more suitable for that. But I also don't necessarily see a problem
with making swappiness=200 do it; although we might have to teach our
proactive reclaimer to auto-tune between 1 and 199 then.

> Pro-active reclaim is slightly different in a sense that it gives a much
> better control on how much to reclaim and since we have addes swappiness
> extension then even the balancing. So why not make that balancing work
> for real and always follow the given proportion? To prevent any
> unintended regressions this would be the case only with swappiness was
> explicitly given to the reclaim request. Does that make any sense?

That would require the proactive reclaimer always knowing enough about
the access patterns to implement cache_trim_mode manually. This isn't
practical. And removing the heuristics would be a massive regression.

