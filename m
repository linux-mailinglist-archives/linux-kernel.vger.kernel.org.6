Return-Path: <linux-kernel+bounces-510304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 693FBA31AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5EF188A792
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961731CF96;
	Wed, 12 Feb 2025 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KpMJj+CC"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA66136
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739322501; cv=none; b=ErpRucmoIuvZkb6esW2y2GsHA0ZxrrWMv/G1lLp3NdlTSHD3mw6BsnaK7qk58rZZu2SSGFyO7AgFZH14d7v7ykNqx1OAp+ROC8ebOPN6aqaY+TSDTPg6TWbsemeFkxSDEjPT1ilwDHQfJ/sgfTHbnSl6JOwAYQrnmEAs44M/5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739322501; c=relaxed/simple;
	bh=2rJJ7HfL5LNYfbuvkH9bco/27aob0ttoKR1Oc5+4vjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1zbMPsn027g9Dq9Qeqp8QRHSoGWw6Eativ5tiXepQNkHqGrIotoLeKEQdCirquD9ImLpDcIxejPS7nEOkoHrovtiXkag5XtnxmOCMYAbAx4wQF71bhwQfX1e/F557fxV7t03YMAqFsn+qFDpZ6y2CmcZg01FsKgHWVRyIk/bUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KpMJj+CC; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Feb 2025 17:08:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739322486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RY6F2Jk4IS2djWCEuxsfNU6S62Bb19qyazUJLPUX6Fk=;
	b=KpMJj+CCYiRUftmezhybDgQxVgOdlBuJMz7VWmLJk3sYRCZ/cPc5p8Qwydppuy57w8Uc9Q
	wd+ur4mot2ZuuiIB9isrfL9H4t3QUt6ZBQszrxEgh+zW2tAFgJ8I5BGins7XTkRGR7A60g
	4DtFkfJgJ9rcwInRLhbixOS4P3eMcYc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <bg5bq2jakwamok6phasdzyn7uckq6cno2asm3mgwxwbes6odae@vu3ngtcibqpo>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
 <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
 <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
 <20250210225234.GB2484@cmpxchg.org>
 <Z6rYReNBVNyYq-Sg@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6rYReNBVNyYq-Sg@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 11, 2025 at 04:55:33AM +0000, Roman Gushchin wrote:
[...]
> 
> Maybe I'm missing something, but somehow it wasn't a problem for many years.
> Nothing really changed here.
> 
> So maybe someone can come up with a better explanation of a specific problem
> we're trying to solve here?

The most simple explanation is visibility. Workloads that used to run
solo are being moved to a multi-tenant but non-overcommited environment
and they need to know their capacity which they used to get from system
metrics. Now they have to get from cgroup limit files but usage of
cgroup namespace limits those workloads to extract the needed
information.

