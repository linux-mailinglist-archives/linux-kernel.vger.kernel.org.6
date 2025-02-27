Return-Path: <linux-kernel+bounces-535515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1450A473CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89FB16A353
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49B17A30F;
	Thu, 27 Feb 2025 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ZlVh6G+C"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7EB194A44
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 03:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628324; cv=none; b=eL0VvMtf3NQEiyIDG4YGKXvlu65Z0QiEDsa5zm1i448uGW+Ao6RPHUPEwgDy/98OJUkbUrk2vgSkzfJiqyEC916jfWMGiu9F4yAArp+Mnh84+e0xamCUpWY/106YcXCajGJyqhcAuY0iilnYSZT+1ShYNwBoLeLi1d48yF8OoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628324; c=relaxed/simple;
	bh=LhXyiRP95p2qnegONw9qq9lcl5m6OeJobMPGwRkHiek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7yN8Cn7Kxr6T8ZBDBVZ4zJqWshmnRgqhkhT+pKncS+IXTs7DxtrNGFVtpIDffxDatXprRMWo+NDQPA2lTz+kdqq7GFU3uaTuPEC5TH4BaK3KhJSPjPyImt3z4F2B922FU1N/2Na6YSVNZZR2JKiwM9yS4sl/8dOcDzn1HN5gOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ZlVh6G+C; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be8f28172dso47723085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740628321; x=1741233121; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D152tJB0jt/kqzpF9TVSogVELjlgAH9yv/g2cEtnuuc=;
        b=ZlVh6G+C/9MPE0caP27V2TypkOxS3LwkK0OvHxDJ+lSNUJZnNlnJGnyM+RH7aVGrBm
         e4eSV07OYtFQqswbOiLGt+dq74Knoh0QRZC0xrHlAi0JCOCPHUC7D/5l8GJ7eGAbelTb
         JkkB/oNkdofTomnJN0KLwoPQYFKicVdCkz66uYB2LjssSpf+nSIjWhSEx0fekTwzrg22
         x40k/9pWIXRHniHtvZXtoj3ZEjqsL6dkYgaWc9kA+20+7ib4A6Tn/B26APq7KdPn0osw
         +R4MveOrJwRffD3DABCBpmPjlIgGTQEBbwzTqunKIewBcm9/aVzBuMRCkfWti2dgA/ug
         tbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740628321; x=1741233121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D152tJB0jt/kqzpF9TVSogVELjlgAH9yv/g2cEtnuuc=;
        b=CM2kK1FK8lh6ZJwz+y0mWyvdo/q2dv3YlmfwsvDwTkZNooDiI4FGTVe08uQiPpv7uH
         NMhqCf8znYdeiZT1F3pZ1u0JiuQf6V/I/q/p6hrj8E8lUd641zNDYxfgako8NW8UGLWi
         FZl7z8zWhaS3ffRYZRahxQh3qpUMnsC4t+1b4RvydMYGlX4kKb+ECizmV+q8wQdQmz8M
         +5sAuEQs18NJXqtaGhLWYKwuJTa3wE8jlerKt5WdKWcoriHWEgTunYbkMH3pW5k6tfmu
         vTqCY/o76sZMypf4MMkwu7T9fLEysbbTFRKGnaoDsMSnyUEBjCxdNezCZFLHDg5ot5Ng
         IL7g==
X-Forwarded-Encrypted: i=1; AJvYcCVBcj7H2JzH8YG450cRfP5OXBIZNUpQJnpjxLaXQfphmodMOeY3xcyoIfuIg7gSH/RRjeWBy1B1VTA1PU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq9SC7sEJnUTlTeh5zXa5ZO15ITas6Lhp1Fem5Z/YmurxzC+cB
	GkxdWDxWJbcKLd5yT/OeNxMOok8J+O7sCT+NFrxYc6m7ao8dzmF+w11Ze6dELN8=
X-Gm-Gg: ASbGncvpG5rlB/8qo1GnBrCtBfYpgj/59Us7jnDAyGIc6lY3XiJCrPoNNHjR1yS0lCt
	UcKD8URQLs1WaJojjddcxKdCYb86N6IvsSbIcSMdHFW0OkLYrYB41AkXWkIkXRaCA0aPNFspGlP
	RBeD328h9G5XTC0Tv9jm6bvtQJhyYJRBkxNfzQcQqY5rlZ3N0G/o8XfKILg2iKqUg/i6TCq8P47
	nrFqb6Mi8j0OJVMmiUjreCc2ZVkbas0Kcl6J70IqSb30bfpz6OM6NPY2yGHSX0SuWZGVLrq8+Wb
	FfgiyTv7/QzfHhXDq3784C/K
X-Google-Smtp-Source: AGHT+IF/njoBngyhpwfoM24JZp8O9ADqy3RWhB/v2KYJBKIGxtN8S2AjLfLLwyTh/X6l3uH8JOV/lw==
X-Received: by 2002:a05:620a:370c:b0:7c0:8359:7130 with SMTP id af79cd13be357-7c247f2582cmr963274785a.18.1740628321185;
        Wed, 26 Feb 2025 19:52:01 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c36fef5beesm57800585a.32.2025.02.26.19.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 19:52:00 -0800 (PST)
Date: Wed, 26 Feb 2025 22:51:55 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <20250227035155.GA110982@cmpxchg.org>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
 <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
 <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
 <20250210225234.GB2484@cmpxchg.org>
 <Z6rYReNBVNyYq-Sg@google.com>
 <bg5bq2jakwamok6phasdzyn7uckq6cno2asm3mgwxwbes6odae@vu3ngtcibqpo>
 <t574eyvdp5ypg5enpnvfusnjjbu3ug7mevo5wmqtnx7vgt66qu@sblnf7trrpxs>
 <rpwhn5zwemr63x4tafcheekdmqullcjvvabdgrm3jgtbtfwgki@6sxglgvtgzof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rpwhn5zwemr63x4tafcheekdmqullcjvvabdgrm3jgtbtfwgki@6sxglgvtgzof>

On Wed, Feb 26, 2025 at 01:13:28PM -0800, Shakeel Butt wrote:
> Sorry for the late response.
> 
> On Mon, Feb 17, 2025 at 06:57:46PM +0100, Michal Koutný wrote:
> > Hello.
> > 
> 
> [...]
> 
> > > The most simple explanation is visibility. Workloads that used to run
> > > solo are being moved to a multi-tenant but non-overcommited environment
> > > and they need to know their capacity which they used to get from system
> > > metrics.
> > 
> > > Now they have to get from cgroup limit files but usage of
> > > cgroup namespace limits those workloads to extract the needed
> > > information.
> > 
> > I remember Shakeel said the limit may be set higher in the hierarchy for
> > container + siblings but then it's potentially overcommitted, no?
> > 
> > I.e. namespace visibility alone is not the problem. The cgns root's
> > memory.max is the shared medium between host and guest through which the
> > memory allowance can be passed -- that actually sounds to me like
> > Johannes' option b).
> > 
> > (Which leads me to an idea of memory.max.effective that'd only present
> > the value iff there's no sibling between tightest ancestor..self. If one
> > looks at nr_tasks, it's partial but correct memory available. Not that
> > useful due to the partiality.)
> > 
> > Since I was originally fan of the idea, I'm not a strong opponent of
> > plain memory.max.effective, especially when Johannes considers the
> > option of kernel stepping back here and it may help some users. But I'd
> > like to see the original incarnations [2] somehow linked (and maybe
> > start only with memory.max as
> > that has some usecases).
> 
> Yes, I can link [2] with more info added to the commit message.
> 
> Johannes, do you want effective interface for low and min as well or for
> now just keep the current targeted interfaces?

I think it would make sense to do min, low, high, max for memory in
one go, as a complete new feature, rather than doing them one by one.

Tejun, what's your take on this, considering other controllers as
well? Does that seem like a reasonable solution to address the "I'm in
a namespace and can't see my configuration" problem?

