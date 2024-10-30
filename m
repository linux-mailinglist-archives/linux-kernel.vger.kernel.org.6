Return-Path: <linux-kernel+bounces-388332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9235C9B5E04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5115B1F23644
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7001E1312;
	Wed, 30 Oct 2024 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N+CMdqor"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEEC1E0DAA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277511; cv=none; b=j3MnTNGX9O0E/bAwOmU0ZtxDqExbrPByIXos0L912rljpTqf4Wl6PuTMfGgW7gg7p4pGzLRTGLr23qUO383koqNIXcI3wQ+jARry03cZi6qAsdVw+1BsCo/2eZW8pVX5RteYMs/0035bfROUGCzE1AIdIPy3Tnb6J39mhuxKKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277511; c=relaxed/simple;
	bh=qklFbffo83/k5hmRFQEWHllNrmp5HV93e0WzW0ZPMPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzcACsUci8WwcWirbjw2VXoNptGXFqY7BucXvQq1DM/+zftTrP91v0n8h4iZBtaxnP3sKCE0Zo45iuinKXM32CPjl6LIad394+d64zGZ9Z8Y95rVPe5n5aILOyJLFWCoJnRCoH0VUZm1kmryudN9KLiCJzvISr8FZqG315nWz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N+CMdqor; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a5f555cfbso423453266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730277507; x=1730882307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aftQ683jJAo4rXGMCxZZQX10YwNrjbmnKyIyZDaOAQ4=;
        b=N+CMdqorxLbuwFFCtrLtBIW1dmr9snI1O9/0JYH577m5GkHy0jMzFWuisQXELfudTF
         M/xpdAjP6x4YCG1cojH+dMXSdu5VNEtoXtIX70Jt7UqDVi8KE4fYxLmAgNPWeub49pec
         jIMf6Ge/GNGPsqLEWMmSoX0MbJiNyMOKqwi5cN5+aztdVuulKLYz9wD3MVbIJ1M+0zcU
         /EcS7+7n+laevJKosjxk0uSgsYhj88ICSVu7HVQRtBw5lOQq9WGJGKZ1TKdK5Kj658/a
         SHhDOgkvxZwABB2x3mPJnB6S1i/G/k587gkkZFV+i7F9vBifmE9vSjqTLBMZhU6PGZ5Y
         Xhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730277507; x=1730882307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aftQ683jJAo4rXGMCxZZQX10YwNrjbmnKyIyZDaOAQ4=;
        b=Vet35zc/o2J5wxB8PZOkHDkBnoDN69CGZM1ZBmcKB4AmHzKHTzyrwKGY0RnOwaQoyV
         1RTHiYp8yGRo+Rf3xfaQCq32XdjNwaPi0k5jjcX/bhX5sDo4YNL37lSTB3MRXtBu7lbM
         +68DG7WKGrnrWWarSPlGJltced9UWZz1SYyxtKuJG7ZGxOp4cU2dHuxoB6HmpNrqdFiL
         xb+fzXpUs4vW1cC3FVEMzaKFzn9XcPcj3lWhS6mNYT5cA1ZcpJ+jJsFAB70hPjRc+iJo
         rN8IFI7YVMZ2yfZ2kO3efbxGFlANcyzcFFf+35Gwlhrij90ds1v+zfDtz2GuiZSYRymp
         7nbg==
X-Forwarded-Encrypted: i=1; AJvYcCU8vWxsMIIgkfxiJGn+ZOY8DWwUtFfTYvKUqWXN9E7kiaNzLpAU7SEO22tzT1NrNmquy0Q6dU6G4i713IU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Y9laX4iF5ANcunfHQ53uaGLVwZpApwa55g1LMEVmgMHeOom8
	7X8SEX1fl4OYK+yLHUXuMiMsOa6McMV4qdLU9vDZAhxnCGk4dFBO67VRvlwennM=
X-Google-Smtp-Source: AGHT+IElsJPhn7Xm/au0bXMmmlRZ2SlufTEmqVxr4t9O0CeASfSKuYaq79XRGxmkxuwFdHyeeoZCeA==
X-Received: by 2002:a05:6402:2345:b0:5ca:1598:15ad with SMTP id 4fb4d7f45d1cf-5cbbf8899ccmr13639074a12.3.1730277507395;
        Wed, 30 Oct 2024 01:38:27 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629f83fsm4605151a12.38.2024.10.30.01.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 01:38:27 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:38:26 +0100
From: Michal Hocko <mhocko@suse.com>
To: gutierrez.asier@huawei-partners.com
Cc: akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	hannes@cmpxchg.org, hocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stepanov.anatoly@huawei.com,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyHwgjK8t8kWkm9E@tiehlicka>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>

On Wed 30-10-24 16:33:08, gutierrez.asier@huawei-partners.com wrote:
> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Currently THP modes are set globally. It can be an overkill if only some
> specific app/set of apps need to get benefits from THP usage. Moreover, various
> apps might need different THP settings. Here we propose a cgroup-based THP
> control mechanism.
> 
> THP interface is added to memory cgroup subsystem. Existing global THP control
> semantics is supported for backward compatibility. When THP modes are set
> globally all the changes are propagated to memory cgroups. However, when a
> particular cgroup changes its THP policy, the global THP policy in sysfs remains
> the same.

Do you have any specific examples where this would be benefitial?

> New memcg files are exposed: memory.thp_enabled and memory.thp_defrag, which
> have completely the same format as global THP enabled/defrag.
> 
> Child cgroups inherit THP settings from parent cgroup upon creation. Particular
> cgroup mode changes aren't propagated to child cgroups.

So this breaks hierarchical property, doesn't it? In other words if a
parent cgroup would like to enforce a certain policy to all descendants
then this is not really possible. 
-- 
Michal Hocko
SUSE Labs

