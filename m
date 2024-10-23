Return-Path: <linux-kernel+bounces-378932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78099AD762
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D231C21D32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389C21E5731;
	Wed, 23 Oct 2024 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX+pUk19"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CB15A863
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721725; cv=none; b=Ep2ZYwkHryqoNOSalJy3Idae2n2S3QEJP4iTYeawBzYJ7dG6xktbFWC/ZkkGfvn0h/6FYUrDerliYBswjBo4olPc+G9Ky0Vbs3+tInR/i55lCmk1xUoW3Xal9vu05qqsa+MvzIxVf0c1QaIOyb5vKXMoh8hW4xicKyZ3j2dkyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721725; c=relaxed/simple;
	bh=qJHPSuneuuNot42iqdIruCaoaEwBntijojqkdOvaphM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mixKbhuohPnKuCMKicdzm++hfGYk4PthtfnHKhox0HuXsnmWtt7cYDpLcDMgPxRqqfT42YtDwMRbJMhTyAHGUdGFLGXBPJ5BtggmeqHCeKkb2RSqAk/KonccbJfmFe3H3/5KZoU7f3K100+HY5ovlD4iM7lHICFJiMzZZOJD7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX+pUk19; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea9739647bso181437a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729721723; x=1730326523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=doAppx4+TadSeVQxVULvvCbAT6vdFA8GhI0qYKsV1fs=;
        b=MX+pUk19Tpd7xvmBRIDAUYXsLGOQmIzF2RWqUwsyOYLP8WW2+orDKeJnQm4U+bFCti
         PM1lwGCCg1diOXeZ1i+HNU0crD781CLYQ/oXymdRbAkxXxOgBd0foG+cK08lGKSuoWP7
         elBlgDeZn7SCdlv+m9tz7tvJTvsI8rbfjwectGvHpnNVmtPa8KsaQh+M13kgClMNkhRN
         3LOeZcTNW+Uy3xbWxCaDbEsXh63Rf3SoLqWwnnIINsQYSXxHHQryg6mEn/nD+CZXFVg4
         27H+7szcgPG4A2TVNx0JDLS00TNX1wwtjTp3hx7bTVYnWeNYP1x8+JK0Q34hObxO4KSM
         kOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729721723; x=1730326523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doAppx4+TadSeVQxVULvvCbAT6vdFA8GhI0qYKsV1fs=;
        b=NsLOJsU5QO7WEHDL/GowQZCYvymP7sEH6C9Myj6wF+lpdhGQk/28YSMEViC9eCgQWw
         QZr9oRTDV80JIknVg+Ip2XUyJQtyx4E5ZTgjGFALd7SMT7UTq1OQAUlZIy23MjPZXNAW
         OMyEhR5PnrcqaPhqqm/v1juvfnh8HvihQTYVBuWZ9Dg5fGmO4je/W6qdctQ6aOiuZeVo
         HR+l963/fb2+B820NDwlviWAqYE1oLXyyXGA+9ujTXS1/E/G+h2967u4trj4KAs4Dn+L
         WGPdyqIQkHlnxULuSB0jM1uSaBjhVm6HwqSuI83XUOatIDJWE5RrXy15f8a1afwMdEmC
         KGzA==
X-Forwarded-Encrypted: i=1; AJvYcCUYKtLrDLYcmTOhmHA65GsaPwkBMkA1k7WvQSjZLsHgUGlottOdlNb5hAk0nALlZhS6lRyX9lCGxayVf40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB74xXpddnkbeNu9h90EMhiKSAnmd3FXSM2oUeuzwefn193WHy
	pP4U8zrDQ31RcRqLYizuN9SMowo3UuxHAxeL5c9GTTgBpgLTqwMW
X-Google-Smtp-Source: AGHT+IHDdJDwHzZGwwclE9qtVpWU9B9cO5pJh5TqEvqZ2h8Gj0qv3PQn+OgJnpIfkt3V+B7Y1+25YQ==
X-Received: by 2002:a05:6a20:e607:b0:1d8:d6b6:94c6 with SMTP id adf61e73a8af0-1d978ad656fmr4371224637.2.1729721722925;
        Wed, 23 Oct 2024 15:15:22 -0700 (PDT)
Received: from eqbm-smc020.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d74cbsm6854452b3a.138.2024.10.23.15.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 15:15:22 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:15:20 -0700
From: Dongjoo Seo <dongjoo.linux.dev@gmail.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net,
	dan.j.williams@intel.com, nifan@outlook.com,
	a.manzanares@samsung.com
Subject: Re: [PATCH] mm/page_alloc: fix NUMA stats update for cpu-less nodes
Message-ID: <Zxl1eOooy5lwJwSo@eqbm-smc020.dtc.local>
References: <20241023175037.9125-1-dongjoo.linux.dev@gmail.com>
 <Zxk6bHlrP5S_0LBK@tiehlicka>
 <20241023134121.68d4af59e2d9cc3e78a34cc8@linux-foundation.org>
 <Zxls4HqdkV_yBYxZ@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxls4HqdkV_yBYxZ@tiehlicka>

Hi Andrew, Michal,

Thanks for the feedback.

The issue is that CPU-less nodes can lead to incorrect NUMA stats.
For example, NUMA_HIT may incorrectly increase for CPU-less nodes
because the current logic doesn't account for whether a node has CPUs.

Key changes:

local_stat: CPU-less nodes can't be "local," so allocations are
counted as NUMA_OTHER.
preferred_zone: If the preferred zone is CPU-less, NUMA_HIT and
NUMA_FOREIGN are not updated since no CPU runs there.
This ensures more accurate stats, especially for cases like dev_dax
and cpuset.

Hope that clarifies things.

Thanks,
Dongjoo

On Wed, Oct 23, 2024 at 11:38:40PM +0200, Michal Hocko wrote:
> On Wed 23-10-24 13:41:21, Andrew Morton wrote:
> > On Wed, 23 Oct 2024 20:03:24 +0200 Michal Hocko <mhocko@suse.com> wrote:
> > 
> > > On Wed 23-10-24 10:50:37, Dongjoo Seo wrote:
> > > > This patch corrects this issue by:
> > > 
> > > What is this issue? Please describe the problem first,
> > 
> > Actually, relocating the author's second-last paragraph to
> > top-of-changelog produced a decent result ;)
> > 
> > > ideally describe
> > > the NUMA topology, workload and what kind of misaccounting happens
> > > (expected values vs. really reported values).
> > 
> > I think the changelog covered this adequately?
> > 
> > So with these changelog alterations I've queued this for 6.12-rcX with
> > a cc:stable.  As far as I can tell this has been there since 2018.
> > 
> > : In the case of memoryless node, when a process prefers a node with no
> > : memory(e.g., because it is running on a CPU local to that node), the
> > : kernel treats a nearby node with memory as the preferred node.  As a
> > : result, such allocations do not increment the numa_foreign counter on the
> > : memoryless node, leading to skewed NUMA_HIT, NUMA_MISS, and NUMA_FOREIGN
> > : stats for the nearest node.
> 
> I am sorry but I still do not underastand that. Especially when I do
> look at the patch which would like to treat cpuless nodes specially.
> Let me be more specific. Why ...
> 
> > -     if (zone_to_nid(z) != numa_node_id())
> > +     if (zone_to_nid(z) != numa_node_id() || z_is_cpuless)
> >               local_stat = NUMA_OTHER;
> >
> > -     if (zone_to_nid(z) == zone_to_nid(preferred_zone))
> > +     if (zone_to_nid(z) == zone_to_nid(preferred_zone) && !z_is_cpuless)
> >               __count_numa_events(z, NUMA_HIT, nr_account);
> >       else {
> >               __count_numa_events(z, NUMA_MISS, nr_account);
> > -             __count_numa_events(preferred_zone, NUMA_FOREIGN, nr_account);
> > +             if (!pref_is_cpuless)
> > +                     __count_numa_events(preferred_zone, NUMA_FOREIGN, nr_account);
> 
> ... a (well?) established meaning of local needs to be changed? Why
> prefrerred policy should have a different meaning for cpuless policies?
> Those are memory specific rather than cpu specific right?
> 
> Quite some quiestions to have it in linux-next IMHO....
> -- 
> Michal Hocko
> SUSE Labs

