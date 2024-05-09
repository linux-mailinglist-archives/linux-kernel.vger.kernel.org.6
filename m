Return-Path: <linux-kernel+bounces-174583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49498C1124
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534DB1F22BC3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34015E800;
	Thu,  9 May 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mC8lFhqn"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634315E7EE
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264534; cv=none; b=WCO4nET07DGgZtt9dMI0/SmUCpE2mpZdo7RESBKr6an1BGKRe7lp65jernhuCco1Vlc2Ei/XMwWCigOStgscmy6zEIoracVkmkRL9ESAj0/NAsTOy+voYyBsUg8z1jDzUMBnih5bgXC/p+NmHG93aYrmAIZPDlzAny2Mf65Smc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264534; c=relaxed/simple;
	bh=QdDwawr0O/riJwdrzUTafrTYHVls8nX2SLZCABjqkdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esKEDFcg/8l0zEnmnyazAUzYE6KizhSi4aDPyF5nnmPK86DDlV3Zcz6ag5u/7V832wkolmFlvrDmcXKd1pmUTu4Jlmk8pK7MNmYbTjo3nui5Qu6rCJ2fqEmFkpwfl0Nu+rh3G3rxW06CGBNI4owozSe4x4DaQ7iafvxfrUxlqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mC8lFhqn; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-792b934de39so73354085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1715264530; x=1715869330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcBytk2n4T6nIWd/npaemm6yu6dWZ4i/FlSD1VR3tyY=;
        b=mC8lFhqn6yaKl5ZrdsyxWnRYLlBOYuh/Cr+phQBeAfP5ueezWdWBH+rT0RI5RkVEmU
         vOJaNBJR6AdCR4fP1oz7PPAu/P0CNkM2pcxx06X4uFCxu6WmXWr5Pyr3t5HGv5Foile7
         NXi/DZjy49A2xjlBtopcAAsaZPrmc83lpF9xl0qldKpBa2S+d8e8ETi7Pn5UeJymJdEy
         15fhru4+ewvQ9KawmyTTQhi4y120rzBgXHEMqjk45rZMv/yw7pYPLcht5hi8OTJOschv
         OYbbuZi6ERGP/YY9AjflMRugbV/p6kYc0zBS0BIjbYXKPngo1Lg8JKdDa5/z/CI3qyC+
         OjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715264530; x=1715869330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcBytk2n4T6nIWd/npaemm6yu6dWZ4i/FlSD1VR3tyY=;
        b=lKMZZY2BkYuYTYIfKlTmHyAOJEktGRDz/6T/ESdUEc6wUge7SRSiITR6l1DfYzhhgH
         w9HHUB2WLZP6s19j0a+IW3pclL/VkVRdIk7IC5RDXf37OuXOTB98nikcNUSMGtNYgMwb
         Jtyz26PhZR3XpBMYUXbvEyOmT2zEb0zvRuhwUSXjOdbHOXdDH7ut4UnCw2Kawg+pAp8w
         sIS2baxS5oZwwsidStCXhIvItXQycjn/BxVxrGwp+CCxX5gBgR/yEu/9GagH7X+pd3Bf
         rD4K2uEfdOfUlNfuelT0Kp5N2n4t48YPL9cEDZL1iPoy4wOD/mpVvnhC1K6mkrQJSoTG
         1MJA==
X-Forwarded-Encrypted: i=1; AJvYcCXwY+frGK4hZXMo6Yty3d2+uffBZW21w9/VxczYdOqIdTLDUXAYTAO8Zzi5NcvE9xDkHbsPMy863QPLwR5NqfyIJQvp1yjHvt65c24k
X-Gm-Message-State: AOJu0YzIqG5qvbs+DMQBaN/Nj4Dwq5aUxBlYgQ0zqBndV+6kjrn9ICc1
	dfDlcd9Ju+QthmwohEYfHvMVbJ+Yb4W424txp26vTB0pmFMEayZeNt4HO64f+Ik=
X-Google-Smtp-Source: AGHT+IHoAcxYfCzK1FPN6e2A3nH4NjGXt84ygMCPooqRmh6Rbnc25nHZ41TUIg6syypqwJahrNYlpg==
X-Received: by 2002:a05:620a:4496:b0:792:c3f2:bfaa with SMTP id af79cd13be357-792c3f2c24bmr74746785a.36.1715264530267;
        Thu, 09 May 2024 07:22:10 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a45b5sm73117885a.62.2024.05.09.07.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:22:09 -0700 (PDT)
Date: Thu, 9 May 2024 10:22:05 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <20240509142205.GC374370@cmpxchg.org>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509034138.2207186-1-roman.gushchin@linux.dev>

On Wed, May 08, 2024 at 08:41:29PM -0700, Roman Gushchin wrote:
> Cgroups v2 have been around for a while and many users have fully adopted them,
> so they never use cgroups v1 features and functionality. Yet they have to "pay"
> for the cgroup v1 support anyway:
> 1) the kernel binary contains useless cgroup v1 code,
> 2) some common structures like task_struct and mem_cgroup have never used
>    cgroup v1-specific members,
> 3) some code paths have additional checks which are not needed.
> 
> Cgroup v1's memory controller has a number of features that are not supported
> by cgroup v2 and their implementation is pretty much self contained.
> Most notably, these features are: soft limit reclaim, oom handling in userspace,
> complicated event notification system, charge migration.
> 
> Cgroup v1-specific code in memcontrol.c is close to 4k lines in size and it's
> intervened with generic and cgroup v2-specific code. It's a burden on
> developers and maintainers.

Great patchset. The moves look clean and straight-forward to me on
first glance.

> This patchset aims to solve these problems by:
> 1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1.c file,

+1

> 2) putting definitions shared by memcontrol.c and memcontrol-v1.c into the
>    mm/internal.h header

You proposed mm/memcontrol-v1.h below, IMO that's the best option.

> 3) introducing the CONFIG_MEMCG_V1 config option, turned on by default

+1

CONFIG_MEMCG1 should also work.

> 4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set

+1

> 5) putting unused struct memory_cgroup and task_struct members under
>    CONFIG_MEMCG_V1 as well.

+1

> 
> This is an RFC version, which is not 100% polished yet, so but it would be great
> to discuss and agree on the overall approach.
> 
> Some open questions, opinions are appreciated:
> 1) I consider renaming non-static functions in memcontrol-v1.c to have
>    mem_cgroup_v1_ prefix. Is this a good idea?

I think this would be great, to make it more obvious in memcontrol.c.

For core cgroup code, we used cgroup1_foo(). Maybe name them all
things like memcg1_update_tree() etc.? That's short and sweet while
sticking out visually pretty well.

> 2) Do we want to extend it beyond the memory controller? Should

Could you please elaborate? ^_^

> 3) Is it better to use a new include/linux/memcontrol-v1.h instead of
>    mm/internal.h? Or mm/memcontrol-v1.h.

mm/memcontrol-v1.h sounds good to me.

>  mm/memcontrol.c            | 4121 ++++++++++++++++++++++---------------------------------------------------------------------------------------------------------------------------------

Lol, awesome.

