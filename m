Return-Path: <linux-kernel+bounces-324283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08609974A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33F62885F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B167EEFD;
	Wed, 11 Sep 2024 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CPqhKdw0"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D264A8F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037379; cv=none; b=tzUa0aGTZc+OKwV/qxIeiaSLUzUpn4S6Ph3VUXGMh6CxYQlCQY3oip98egnyRsE7Y/MeZyCDlJCDjogG6Jv8PVB2of7u4A4YTvrXPTsd9SO3ScpM4IneDnUM6oCL9OVGpaxjm/83Ao0JnA0HjTBeNmg1olh+4sDaGKkrYComQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037379; c=relaxed/simple;
	bh=7aySWBK37Utwqk8wanc4+48Xp4u966ZDNesVcFqJSMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZTk3NW02vPk4yqBJnYYZGjugfkLU+32M7DsnT7yMQhCGpIx2L1SC/lfJonD0/GokNSglGNizqkfS6R4fByz3P9QIYwchUtfI8wS10Ot1lvwXgtVnp7d/5mi/aGVJH47SpXUDzVxMMbZ7dFc4nicYjVUVe+WTXavjHcVmEV2d0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CPqhKdw0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so15853835e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726037375; x=1726642175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojANVXIIKwLfsI2BYdwc81ZHbE8Xfha5SVNFyojXl+c=;
        b=CPqhKdw0LqFZKNHoM48Jg1wcTrD8Z7RZp7wsnINs/b5wlloXJaXeHHIVWQcY5c0MOP
         sIpxn+2AAE/lxximqZJ4F3Mmqi3feQjqTdnjDuU0R7bQSgJ4D/bM4FaGMGHy6K/7I5G2
         PelXjs7IKjEHMaD80moSeZwAGJgDoonieqoUhNu+d19rLubgm2Zxb+BFiC1Ca9iDc+v4
         y8jW7cneQ4d2Ab7vchO+56jpXaZ3WGk375VyjarvIai17TSqd0RzJRJ9KFx8ihtbneGm
         6LhbynPOLuLnoD8Jg4WyAq4PO0TniR7wPSiANo8NUNhWp4EwEITTS44n+cdDkdKrnUam
         Sh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726037375; x=1726642175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojANVXIIKwLfsI2BYdwc81ZHbE8Xfha5SVNFyojXl+c=;
        b=d19hJsmQJ5mY+q2V1eHjoOvPSGWT4tjEgPC1Xnae7LFjVhnhcuXB3rVhTAaDOmcFHf
         t0+yTxzsGANsJLO3jmaamaWG9UHHu4OuXoKm5naYZrUjL8k2uYgQRFh2+kq5fezwYvuh
         rNjnytHR3n3xOS2tl6CzXLUw/QO4Mqjs8PR9fqL4gWZOsOQvZmRzG+7imT63EfzcRj92
         UEAjqog4CnZqrUySnp4ZhnD0otJ4o72XJoard0iQlkEgwVNd9saMLb0QeszNa9Jrv5Ym
         dTVQnly3rJ2ooZR26CMWS4r5YDkMdOwMdqTH8Z2DFTuNtSh41ir22Zo790EFyd5MB58C
         atnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgyVW8ex86KtuhEjq1P53VliKRwkkRWmEDBQoVZePUIiUsc/znpXIX76lW3e0ub/xUtyVeigwLfCZ/Uxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztVsgaLLJA/nv6ESY2f+UMpCBGSnRkN/VCtctkrFFg8JFt9vzU
	yJsP7W7c5sle8CXyGMZsc7um3a8P6VQTo1q5oLYeZsFYp12CoJstMgcjfnwBRvE=
X-Google-Smtp-Source: AGHT+IEuVV2vIaPVWOkyALjjEbcsmlQGk61wj/zPhgCTAtPbhBHaiLd+dpXlGD+KU/S8zxsUL2Uf+Q==
X-Received: by 2002:a05:600c:3ba6:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-42ccd35b205mr14050435e9.27.1726037375133;
        Tue, 10 Sep 2024 23:49:35 -0700 (PDT)
Received: from localhost (109-81-83-158.rct.o2.cz. [109.81.83.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3765sm10691799f8f.74.2024.09.10.23.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 23:49:34 -0700 (PDT)
Date: Wed, 11 Sep 2024 08:49:33 +0200
From: Michal Hocko <mhocko@suse.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
	yosryahmed@google.com, hannes@cmpxchg.org, almasrymina@google.com,
	roman.gushchin@linux.dev, gthelen@google.com, dseo3@uci.edu,
	a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Message-ID: <ZuE9fSvWzlUdY5z2@tiehlicka>
References: <20240904162740.1043168-1-dave@stgolabs.net>
 <Zt6hur2TZJUrJ2IU@tiehlicka>
 <20240910163115.cg26kenlejlkmnsp@offworld>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910163115.cg26kenlejlkmnsp@offworld>

On Tue 10-09-24 09:31:15, Davidlohr Bueso wrote:
> On Mon, 09 Sep 2024, Michal Hocko wrote:
> 
> > On Wed 04-09-24 09:27:40, Davidlohr Bueso wrote:
> > > 1. Users who do not use memcg can benefit from proactive reclaim.
> > 
> > It would be great to have some specific examples here. Is there a
> > specific reason memcg is not used?
> 
> I know cases of people wanting to use this to free up fast memory
> without incurring in extra latency spikes before a promotion occurs.

Please give us more information about those because this might have an
impact on how the interface is shaped. E.g. we might need to plan for 
future extension.

> I do not have details as to why memcg is not used.

I am not saying this is crucial to clarify but it is a natural question.
We have a ready interface to achieve preemptive reclaim, why not use
that and introduce something new. A plausible argument could be that
memcg interface is not NUMA aware and there are usecases that are
focusing on NUMA balancing rather than workload memory footprint.

> I can also see
> this for virtual machines running on specific nodes, reclaiming "extra"
> memory based on wss and qos, as well as potential hibernation optimizations.

Do not virtual solutions have own ways to manage overcommit/memory
balancing (memory balooning etc.)? Does such interface fall into the
existing picture?

-- 
Michal Hocko
SUSE Labs

