Return-Path: <linux-kernel+bounces-515248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CBBA3624A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A8B1684A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A81267387;
	Fri, 14 Feb 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GkqUT5uk"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3D245002
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548367; cv=none; b=LpNcLfj9n1+re4JVoLrFbPltIEGIB0mffGau8v8gevxyC7uZTPJZdILV5gkwNYYyMse3OVg5RkTbs0aWTFm8VBRcHIcag7VOjYOOJUXx3vIOu+h2mPeovJZxcUmDDzgKy0qsuSvta02MvRtWL0dPW7yjKf8XKH0AbE2rKikeB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548367; c=relaxed/simple;
	bh=3d5yNh+7mmkzMBeCsstHX2sTs31Ph92UicrtFLPMvh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2dhgRjdYOt97/zCkrsZNeXzjsJ6dwe8hrlbrDt7kCBKxNlkdh9t/duEv0WwtzkYPEXYqY/DrTFm3HzP7dI20+xJiuYdXf4LYU6wTi16ehxCoRLvCANKIG6lXf0GHqbLwvdJRuYetNB64pvOxV5Sa7KNq3j8QX0wHltztape62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GkqUT5uk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7e3d0921bso394163266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739548364; x=1740153164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPQDSWdyumx+7kZtAbOyAbWC8fKUL0iK50FAOdUwRCA=;
        b=GkqUT5ukZkKR6mvWShznmI3n+bEZzR+OiIYdPNGd39OABUsTtc3DEXp9VwDReB4l7k
         pNhpx2eMiEcriuZyHgevYItOUP/zZR2PGL3FCm8WfTmmcimweU/cU81es7+1VuMezVME
         4jkuOaV+0F2rXLncrirYBcoOFr/PaAp6TUVNjxbi9nbfSlAROqBox4wKWarhjgAFcGlu
         HGcyoULfWBNcBdsQF5VfdUVFtJ0ShGkJ8JlZRySNJVjrBTTdWVCYciW6rW/nESPCuRgL
         sJgaukFHyG4ngpHAllhpQpIrXDC1q4x9yhQHqK5E7+D+lXdm4rBscAnjlE6df9vSfTr1
         aLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548364; x=1740153164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPQDSWdyumx+7kZtAbOyAbWC8fKUL0iK50FAOdUwRCA=;
        b=XEfqQIjpBCtWQTCsQaKOLytvd4J6TS3iy50FTedvHRk/fhndfV5GvbbpHmm0c0YiMa
         Mazs5n/vtLRb/6ADTb/lcKK5Kd5liKPTQ38OwzFj1QAb60uIzpyEyS8uNSObr2pSmdZ9
         4tAFSIO0gbS2FSsMw06en9Vc+GbnbDDRfnZLS6rXsajR4wOSfw2j2DhiN5mAcou56RzM
         qC0KpgxB/HF+zZx4UkZDXQ7HmWtfxdcRatJRrgXfbYHdkW+qnRiiYBDuTNoxCCPBdIsQ
         /BiFA3L3UGMNs54nkahMMIPQggcKEg6QRQU7hLOoxpPKHHdJXopcbxfBPcB/w/8llrLX
         auHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMoEYH6sI6/V/Lh8TgRtFt0c6LmsMqxuKhDpi46MCoJq3RWC9UeZJbfByo2GKdXeKVTNLPxipxhKNTqZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxekpOV/BwDBIuAeriUq7kXcWzzARON/Z1BX+IwzrYtBKl+JFon
	r5ayk0fcTPH8+W/bv87aQ52TGID4qH4hmbL51b2/WYlTwyBZd7XnB48N2MKAbJg=
X-Gm-Gg: ASbGncsSnWbmQoA3oZQroaCZqmIiv1wLhWzDOxDZAczyHexhLdA02EAiC94jzq8OH0L
	0IESBK8zoBvGk+TDiT/dmvOCKtCcB9h6dRU2z0W9J04JjEzZPzeBhYjF0bWCHNarW5eE/SCqwt1
	k2vtoSl52zl8oDL7HCDNHSaLpa6UJ5/C06j050RbTPWD2L9Z07+0f0yk3ZvFFs00GgzbRmwG4ZX
	/VepbjFrfh8Upe9IwK3f0EgoDM02z+wKEj/2GWlfXO0NDzPiJM9qViJB9uNpz5fJ3O1x95A18cC
	CNk7MjaAtdF5lGH4cT+vrbo8VR1w
X-Google-Smtp-Source: AGHT+IGM4zyda7P3q+Y2IYo5LojVyQ2Ld4whAaXWvkt3be7ScN0HjwuroYqtgMUfJbnJWY08Yx4Lvg==
X-Received: by 2002:a17:907:94cc:b0:ab7:da56:af9f with SMTP id a640c23a62f3a-aba501a9dc2mr940172666b.49.1739548363814;
        Fri, 14 Feb 2025 07:52:43 -0800 (PST)
Received: from localhost (109-81-86-120.rct.o2.cz. [109.81.86.120])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba533bee4asm365187166b.170.2025.02.14.07.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:52:43 -0800 (PST)
Date: Fri, 14 Feb 2025 16:52:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Message-ID: <Z69mygllBATJ6dsm@tiehlicka>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org>
 <Z6zS4Dtyway78Gif@tiehlicka>
 <Z6zlC3juT46dLHr9@slm.duckdns.org>
 <Z60KQCuPCueqRwzc@tiehlicka>
 <Z60S4NMUzzKbW5HY@slm.duckdns.org>
 <Z60VE9SJHXEtfIbw@snowbird>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z60VE9SJHXEtfIbw@snowbird>

On Wed 12-02-25 13:39:31, Dennis Zhou wrote:
> Hello,
> 
> On Wed, Feb 12, 2025 at 11:30:08AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Wed, Feb 12, 2025 at 09:53:20PM +0100, Michal Hocko wrote:
> > ...
> > > > Hmm... you'd a better judge on whether that'd be okay or not but it does
> > > > bother me that we might be increasing the chance of allocation failures for
> > > > GFP_KERNEL users at least under memory pressure.
> > > 
> > > Nope, this will not change the allocation failure mode. Reclaim
> > > constrains do not change the failure mode they just change how much the
> > > allocation might struggle to reclaim to succeed. 
> > >
> > > My undocumented assumption (another dept on my end) is that pcp
> > > allocations are no hot paths. So the worst case is that GFP_KERNEL
> > > pcp_allocation could have been satisfied _easier_ (i.e. faster) because
> > > it could have reclaimed fs/io caches and now it needs to rely on kswapd
> > > to do that on memory tight situations. On the other hand we have a
> > > situation when NOIO/FS allocations fail prematurely so there is
> > > certainly some pros and cons.
> > 
> > I'm having a hard time following. Are you saying that it won't increase the
> > likelihood of allocation failures even under memory pressure but that it
> > might just make allocations take longer to succeed?
> > 
> > NOFS/IO prevents allocation attempt from entering fs/io reclaim paths,
> > right? It would still trigger kswapd for reclaim but can the allocation
> > attempt wait for that to finish? If so, wouldn't that constitute a
> > dependency cycle all the same?
> > 
> > All in all, percpu allocations taking longer under memory pressure is fine.
> > Becoming more prone to allocation failures, especially for GFP_KERNEL
> > callers, probably isn't great.
> > 
> 
> Wait, I think I'm interpreting this change differently. This is
> preventing the worker from allocating backing pages via GFP_KERNEL. It
> isn't preventing an allocation via alloc_percpu() from being GFP_KERNEL
> and providing those flags down to the backing page code. alloc_percpu()
> for GFP_KERNEL allocations will populate the pages before returning.

Correct.
 
> I'm reading this as potentially making atomic percpu allocations fail as
> we might be low on backing pages. This change makes the worker now need
> to wait for kswapd to give it pages. Consequently, if there are a lot of
> allocations coming in when it's low, we might burn a bit of cpu from the
> worker now.

Yes, this is potential side effect. On the other hand NOFS/NOIO requests
wouldn't be considered atomic anymore and they wouldn't fail that
easily. Maybe that is an odd case not worth the additional worker
overhead. As I've said I am not familiar with the pcp internals to know
how often the worker is really required

-- 
Michal Hocko
SUSE Labs

