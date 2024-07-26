Return-Path: <linux-kernel+bounces-263832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B16DF93DB29
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2431F2315F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16314A09D;
	Fri, 26 Jul 2024 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2WtcdiP+"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16117BDC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722036694; cv=none; b=rOtKhjCaV8YuhnWoHEwV+gYvwfgDPyJ+1PI+IEJ0Y9Fd9kRyUSz23I5X1ot5G4HXQZuci28Jnf7BoYljL0fUHt0OiDkgFs1+0+M4qM0H+bT4iDBmUi2Ftb2MqVRkCDtKbxqn8HPjZMnm04q8z8M2XgzkHuKF6eC1mGCfkYGOJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722036694; c=relaxed/simple;
	bh=xaKnwmyhqZC0ZiYoKFtZzVqc94Y2RV9eCA6Mo6zMLAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZijpreDwI/31vzmWxq44Pg5Ffc5ltntTBnmbBt7ibmrsAlHm1CC5qdRV75R9QE8LMT7qG2GB8v5LDsIgN/f4iS2YygvoVyVWHWFPIB03NKnae2bP2z+clVk7A0cGIoj2TPYZeURYRzytANvVoO+OWQ6OoMKVFRtBThtHYpKxMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=2WtcdiP+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44ff50affc5so6996161cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722036689; x=1722641489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=biuKcawwBlNMD+laH28Ncnx2/ZwF1wLoS8xlXY0k0qo=;
        b=2WtcdiP++dSBd6XXpr2xEwkCMpV/p1CYaOwzwOP3Vk+IDioCBc2c+PGe6kRmiBEdsD
         c0EG8ZU6WFTafPAtMEDsFOYhtp+bbSs8OJkveL3MTZ+JYCxAMPCJigECnjh9R5TCrEbu
         z3o0BZ7xjzVXTtWeFmAbMXlO7dOWtzqqKwyNOrDJO6saNJPJqxLhBelMc6Zkqth/Zlca
         FRCex0Qt3TsQPlO9PsyyJ5aGpqOhLI9b9cetd9k4Io8AEsgQVbVvXhhMxsrM3SqCXCgM
         mYeP7uNSxwrPMjCxH2MXxs6FL4X3PZef5jKYluf2OO/QM1/DVknL7e7YwfCNePwyAk5a
         /PdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722036689; x=1722641489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biuKcawwBlNMD+laH28Ncnx2/ZwF1wLoS8xlXY0k0qo=;
        b=ijQLjApjZqx65KXiY9s2zBJ8zhKHZbuioGtoG7RSKzi4JbGpCNFbsxWNDLujiNnRt2
         9oZUk5p0i5H5YNv66bY864+Mjs4jlNSpJJW7K/WIM+5ql1uoiTqMSjWhGzGZ2eqzFi5C
         rTzkzrD9BkvTTOfltl6Fbf1q+k5dOX1xRYPOs6rvyy5e2AbrB590BuAwYUGwZfeS7OGW
         tEqnI0FakBuCs/q5M6wmP0CBB+2uwZWanUTXtGlXoFrWMM6f0Aou7ivWdR77cJ/jcaWE
         TUfZYeTngoCxaIyXtlEqyqP1DR3OZCCBBzeBxvZyOJdTUJWqXlA9acWeIHFK6CNK8clp
         KtVg==
X-Forwarded-Encrypted: i=1; AJvYcCXfNTNBWXobaCesTRUR3eUewQaGwVW6OY52d2O64DqC0LhijQyRl0eK4l6GycLoxRzLBC9YMEliKiNGBvqJVlA9WISTJfnETk+etM3X
X-Gm-Message-State: AOJu0YylaPRoD4yYIKkQaYralFKPik75wEbCj7WgLWzaTC5pB6VXwUHM
	hAMz1CHmCttYN9vcNl9itLhsOgGIiR8U/FpGMhwRi32OWI8aR+jhqimTtjSka3I=
X-Google-Smtp-Source: AGHT+IGSYhJwCawC3mAvb2HTZ0jkpic6PitolVJPtOM5TcVmi2Zwx7iaFRACbetCiBic2bzak4rvEg==
X-Received: by 2002:ac8:7dcf:0:b0:44f:9e6f:d00d with SMTP id d75a77b69052e-45004d79d8cmr17878461cf.11.1722036689529;
        Fri, 26 Jul 2024 16:31:29 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8413194sm17045201cf.86.2024.07.26.16.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 16:31:28 -0700 (PDT)
Date: Fri, 26 Jul 2024 19:31:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 3/5] mm: memcg: merge multiple page_counters into a
 single structure
Message-ID: <20240726233123.GG1702603@cmpxchg.org>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-4-roman.gushchin@linux.dev>
 <20240725214227.GC1702603@cmpxchg.org>
 <ZqLg30nOUVlerBh1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqLg30nOUVlerBh1@google.com>

On Thu, Jul 25, 2024 at 11:33:51PM +0000, Roman Gushchin wrote:
> Hm, Idk, I do agree with what you're saying about the self-contained
> piece of abstraction (and I had very similar thoughts in the process),
> but there are also some complications.
> 
> First, funny enough, the protection calculation code was just moved to
> mm/page_counter.c by a8585ac68621 ("mm/page_counter: move calculating protection
> values to page_counter"). The commit log says that it's gonna be used by the drm
> cgroup controller, but the code is not (yet?) upstream apparently. I don't have
> any insights here. If there will be the second user for the protection
> functionality, moving it back to memcontrol.c is not feasible.

If it comes to that, I think it can be its own abstraction as well,
with a struct containing all the elow, low_usage, children_low_usage
stuff etc. and API functions to propagate and get effective protection.

Both memcg and drm can embed this into their css descriptors and use
those helpers as necessary.

> Second, I agree that it would be nice to get rid of the parent pointer in
> struct page_cgroup entirely and use one in css. But Idk how to do it
> without making the code way more messy or duplicate a lot of tree walks.
> In C++ (or another language with generics) we could make struct page_counter
> taking the number of counters and the set of features as template parameters.

It shouldn't be more than a for loop right + the unwind on failure,
right? *Somewhat* duplicative, but pretty simple code that's easy to
wrap in a controller function and have it out of the way.

Actually, we could keep a simple hierarchical version of the page
counter functions, but expose non-hiearchical ones for users that want
to do additional operations on each level.

IOW, e.g. page_counter_charge_one(), page_counter_try_charge_one()
etc, then implement page_counter_charge() et al on top of these.

swap, memsw, kmem, tcpmem, hugetlb etc. could remain unchanged. The
memory counter could have a memcg version of the charge function that
uses *charge_one() and handles protection propagation.

drm could do the same.

That would keep the page_counter->parent pointer, but would save a bit
of complexity for simple users at least.

> I feel like with memcg1 code being factored out the benefit of this reorg
> lowered, so how about me resending 2 first patches separately and spending
> more time on thinking on the best long-term strategy? I have some ideas
> here and I thought about this work as a preparatory step, but maybe you're
> right and it makes sense to approach it more comprehensively.

Sounds good to me.

Thanks!

