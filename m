Return-Path: <linux-kernel+bounces-252170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2CA930F71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA5EB21285
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE354171645;
	Mon, 15 Jul 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TiMryFWY"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AD4C66
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031588; cv=none; b=pDtRpZ3fefx3guBHdxjpM7MYYX6PGoTPlbSEp2hd9OfrFruIMsgT3Prcv53k9oQpkZD7z9by+cA39LhcRqeqe+vK4NCbZRBwspM3LIwMZdN7kPz9kDLNIe7Cq1ETLB22vSjaIgvE6A8+H4/fwsNhr9zja3Kg1kZc9r9zOsdWtBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031588; c=relaxed/simple;
	bh=AxcHVjXcWz+f2jTuc9Dzf58zKPdt9EW330ehtbZST7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQmcfc5KOS6LONkaIbqAUWguOBLDjhQYZWvnah7Cp5QwcH/GX39T798xZKYeGRjLdmlxoGq03CiC1JcDvIZevuboa7DggQBVFtP7hI2kctBqUL5IgIvU1zbC46wWPqT8//QyXz6nUzUaD+Pg4oGG1xJ+WbNUcGVRLjnf7MBq6HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TiMryFWY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77c1658c68so439552866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721031584; x=1721636384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzuOERVB8BYXcS6jzRnPjykns7akEqZft0CH0SokcpA=;
        b=TiMryFWYtmBuvDCqZIqkoPUeuF+Cl8RnWd/Mnj78mM3vRlnvD2LX5mMjgvNCZ5l2b7
         D3xjQecwjSvEWXpKPHbIzcZv1pXWRbMmP4M+y8oM4R/wJ+x0H6aYxV9Vm7A4v2Z3KM8I
         fChxseHgjFAJ+y5kcl/dyx8jq0NJOkDHSlJTHtSfhBMtnFC+HUDReotX22mv4zzGswgD
         +rYY62nCpaV1bPidtm3UHpjmMe7D1W6s8DhFyIiTddJJ10fGc0hXqySVscWEtOoohYqC
         o015JJUnVL0WGABANG9KuoLD7JIly1Ov53XecdnW5qmJDoiBMPrV+A3Bv2QrZiDe5ywQ
         yHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721031584; x=1721636384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzuOERVB8BYXcS6jzRnPjykns7akEqZft0CH0SokcpA=;
        b=d1LS9e9I9VfgGkBa4au6qhoaXqchcjMakkOyxLyC0afX2u49Y7lAwokeIa6PMlNDMN
         9nm0W4+458agrN37/AlQmacazVKbFgRalsproYrIrdE9MgC2Av/VvViwp12Rd5vaiNcQ
         UEEtCVKSodKRcw416YdPa7fC5GLm/CpZhI2iy4eZddb9x1HV6MhgpQ6VwdIsWXPDP36r
         dWC6zEoHMDG3xcJvBCdDA2Ge1G+5P0YAbVodDYE03x+fyM9uHopps0e7c7AEmK5vb7No
         5X+EKNNV0Y70rnMlbsO7TjQEjcJyeY5JXaHenidA0U5Rug++wvbHUvkATt3nSuMP6g2N
         N3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXYMhdut+27Gl1YlX7aGmdVJlojCRKisTgNliNooFW537IDhn7yyp20aIUNlnzooCTlQmSGhdVbM+/jnaqhuSR+Z1yvt575JTRbH6Em
X-Gm-Message-State: AOJu0YwFn9uuW/kbRrhjmSkN6tgcWZ/cDJ8u8L2uOHxkbbhzOfoU4Bld
	AMXjwOrERPw/bdGlsuX/ahE5cyCom7vCmZwiXO03xzknUavmi8JwaphF3d6MekZWOgU5FRNN4UZ
	f
X-Google-Smtp-Source: AGHT+IFDnYLOn5oKibGY3IW1WB4tX5z1g4icCI1F/jsVTt3hrAU7A9vAG7HpYO0pa9HXpkwRm5mVtw==
X-Received: by 2002:a17:907:7da8:b0:a6f:e456:4207 with SMTP id a640c23a62f3a-a780b88498fmr1522974366b.61.1721031584079;
        Mon, 15 Jul 2024 01:19:44 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a359asm195317966b.19.2024.07.15.01.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 01:19:43 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:19:43 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [bug report] mm: memcg: move charge migration code to
 memcontrol-v1.c
Message-ID: <ZpTbn_pEd1XsvOD1@tiehlicka>
References: <cf6a89aa-449b-4dad-a1a4-40c56a40d258@stanley.mountain>
 <ZpF8Q9zBsIY7d2P9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpF8Q9zBsIY7d2P9@google.com>

On Fri 12-07-24 18:56:03, Roman Gushchin wrote:
> On Fri, Jul 12, 2024 at 09:07:45AM -0500, Dan Carpenter wrote:
> > Hello Roman Gushchin,
> > 
> > Commit e548ad4a7cbf ("mm: memcg: move charge migration code to
> > memcontrol-v1.c") from Jun 24, 2024 (linux-next), leads to the
> > following Smatch static checker warning:
> > 
> > 	mm/memcontrol-v1.c:609 mem_cgroup_move_charge_write()
> > 	warn: was expecting a 64 bit value instead of '~(1 | 2)'
> > 
> > mm/memcontrol-v1.c
> >     599 #ifdef CONFIG_MMU
> >     600 static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
> >     601                                  struct cftype *cft, u64 val)
> >     602 {
> >     603         struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> >     604 
> >     605         pr_warn_once("Cgroup memory moving (move_charge_at_immigrate) is deprecated. "
> >     606                      "Please report your usecase to linux-mm@kvack.org if you "
> >     607                      "depend on this functionality.\n");
> >     608 
> > --> 609         if (val & ~MOVE_MASK)
> > 
> > val is a u64 and MOVE_MASK is a u32.  This only checks if something in the low
> > 32 bits is set and it ignores the high 32 bits.
> 
> Hi Dan,
> 
> thank you for the report!
> 
> The mentioned commit just moved to code from memcontrol.c to memcontrol-v1.c,
> so the bug is actually much much older. Anyway, the fix is attached below.
> 
> Andrew, can you please pick it up?
> 
> I don't think the problem and the fix deserve a stable backport.

Agreed!

> Thank you!
> 
> --
> 
> >From 8b3d1ebb8d99cd9d3ab331f69ba9170f09a5c9b6 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <roman.gushchin@linux.dev>
> Date: Fri, 12 Jul 2024 18:35:14 +0000
> Subject: [PATCH] mm: memcg1: convert charge move flags to unsigned long long
> 
> Currently MOVE_ANON and MOVE_FILE flags are defined as integers
> and it leads to the following Smatch static checker warning:
>     mm/memcontrol-v1.c:609 mem_cgroup_move_charge_write()
>     warn: was expecting a 64 bit value instead of '~(1 | 2)'
> 
> Fix this be redefining them as unsigned long long.
> 
> Even though the issue allows to set high 32 bits of mc.flags
> to an arbitrary number, these bits are never used, so it doesn't
> have any significant consequences.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol-v1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 6b3e56e88a8a..2aeea4d8bf8e 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -44,8 +44,8 @@ static struct mem_cgroup_tree soft_limit_tree __read_mostly;
>  /*
>   * Types of charges to be moved.
>   */
> -#define MOVE_ANON	0x1U
> -#define MOVE_FILE	0x2U
> +#define MOVE_ANON	0x1ULL
> +#define MOVE_FILE	0x2ULL
>  #define MOVE_MASK	(MOVE_ANON | MOVE_FILE)
>  
>  /* "mc" and its members are protected by cgroup_mutex */
> -- 
> 2.45.2.993.g49e7a77208-goog

-- 
Michal Hocko
SUSE Labs

