Return-Path: <linux-kernel+bounces-252871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03714931929
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C6D2824E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90034D8A3;
	Mon, 15 Jul 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="h8boxVwV"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA5446D1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064182; cv=none; b=rc7ZyI/2fhrupbHgeQSuBDD02oETCTYdIgwfcdj8jlGr/jcxWALdoPAWGkMLi3kO9HxFo6jXPja3B6fQ+Bfb0PJAH8qUzfWHA0wUlmDWx/Blv4H99E3kZE6B+/YmUXudZdM35i6P0YBCcStQPtL2NVx6m5O9qKx6QntFCnuvFME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064182; c=relaxed/simple;
	bh=J67CIHRUbdGmnrl2ITF7KM9nbk16I0qPrrmM1VDeTB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V566Ekz323ttN/DDUWgiDR4bdckg4I0180yN6f3vu6HD7H1GBAymMocbR3Dczk1k24VUUDPC7Qw8N1FMhdMRW3LxdWkdUf3pVLAKIsKYRwRKwqb78vS/kfIkJ/wxlBsg5EUF1wVS7mP7U/aiGcpvMYYdyhkB6rHcnLPNvkn6qNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=h8boxVwV; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b5e760eb36so27371256d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1721064177; x=1721668977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LS+Pt/xtcW0R8fRx1VsexXvG+4qSHFVI3AS2OkJyMY=;
        b=h8boxVwVszPgvAy2Pz9wr2EtA4dvTht84DNysl8x4DX0e6r/WQYo8rXRPEPrUycRi2
         nxOh+IWdZpwfm2OemdTrkM08qY9Orzwf8qaoEM4lw+qfwVa0G4kjE9yt5sCSdnfv/Jib
         POxpd6S+XywCoOoCjcHU7aqiEaN1X5pRkWv2CsiLpdbKRjalfyAov7x8MwqWAxuyPtmZ
         lxkhFEaQrLuD7WJjZxon6Tok2I6AQ8ucXwVqWVbnD8HU7Xla7iq4ITQZUlaRgwARgkIP
         sTKI/pYfauyDqJLOPRmS/R2/c4FFLcYQRQcd4NvO9yLKo6mgqs8SKjRQxvLWvCrjdUn0
         foXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721064177; x=1721668977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LS+Pt/xtcW0R8fRx1VsexXvG+4qSHFVI3AS2OkJyMY=;
        b=OcT4A2G2IVbZCTCrt2wkviW3PjMykffYp4PXLvDL33wbxeTvQF1Rz7G1ruQYEM+OoO
         QpGUa3wYySSPXL39/4u8JIhT3nYUfuv7V1zxnkmiz4k1xyPQdQ5EslqR9oaMMG9J02k+
         B8y24FMu3RZzDYfn1hv4Qb6OgfaDy9hQSNoXRWCwtr2HYez76lwJSJuAQ8Fr4KHsVeTX
         I8PtdpNu8FxML5cLbX1gcUgf7W2MkUOO19225/ussdZAGodLEMEb0yzsQJDQ2Npk11ua
         wFogXzXXldtjek3sFeZUe2UDD8Q6kgC6CGWAyh/mSTGxnvqpjHfGvz29AZPwQYBnh6Il
         J6hw==
X-Forwarded-Encrypted: i=1; AJvYcCWTJxt2jKhdfh3hRkwxVGJA82Xp4F5BV0WHu67bv6U0kOneS4ij4p3/gvi93Yj4/LqE/ewU02lvMtwTm7lgwV+15r7Pgk3MUIxYV5oG
X-Gm-Message-State: AOJu0YwFhQJmERrCZrD161bcZlQQV6seNBEEUqJEdkyfvo3X21egM8I4
	8GPmNDpvikGIrsVo5IVU2xZXeKDN9jagstSiOcza+enAPB8leJlHQirAAcD+McU=
X-Google-Smtp-Source: AGHT+IHfPdDjkIPhp1T/zEM1IxAuupFbb40dXjl3O3lyXkmAszC9Y7O4atftQvaNDw/ztZPARS2yJw==
X-Received: by 2002:a05:6214:4018:b0:6b0:6dba:c947 with SMTP id 6a1803df08f44-6b77de71b14mr4032816d6.18.1721064177246;
        Mon, 15 Jul 2024 10:22:57 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7619a7218sm23200826d6.73.2024.07.15.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:22:56 -0700 (PDT)
Date: Mon, 15 Jul 2024 13:22:55 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH-cgroup v7] cgroup: Show # of subsystem CSSes in
 cgroup.stat
Message-ID: <20240715172255.GB1321673@cmpxchg.org>
References: <20240715150034.2583772-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715150034.2583772-1-longman@redhat.com>

On Mon, Jul 15, 2024 at 11:00:34AM -0400, Waiman Long wrote:
> Cgroup subsystem state (CSS) is an abstraction in the cgroup layer to
> help manage different structures in various cgroup subsystems by being
> an embedded element inside a larger structure like cpuset or mem_cgroup.
> 
> The /proc/cgroups file shows the number of cgroups for each of the
> subsystems.  With cgroup v1, the number of CSSes is the same as the
> number of cgroups.  That is not the case anymore with cgroup v2. The
> /proc/cgroups file cannot show the actual number of CSSes for the
> subsystems that are bound to cgroup v2.
> 
> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
> we can't tell by looking at /proc/cgroups which cgroup subsystems may
> be responsible.
> 
> As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
> cgroup.stat file is now being extended to show the number of live and
> dying CSSes associated with all the non-inhibited cgroup subsystems that
> have been bound to cgroup v2. The number includes CSSes in the current
> cgroup as well as in all the descendants underneath it.  This will help
> us pinpoint which subsystems are responsible for the increasing number
> of dying (nr_dying_descendants) cgroups.
> 
> The CSSes dying counts are stored in the cgroup structure itself
> instead of inside the CSS as suggested by Johannes. This will allow
> us to accurately track dying counts of cgroup subsystems that have
> recently been disabled in a cgroup. It is now possible that a zero
> subsystem number is coupled with a non-zero dying subsystem number.
> 
> The cgroup-v2.rst file is updated to discuss this new behavior.
> 
> With this patch applied, a sample output from root cgroup.stat file
> was shown below.
> 
> 	nr_descendants 56
> 	nr_subsys_cpuset 1
> 	nr_subsys_cpu 43
> 	nr_subsys_io 43
> 	nr_subsys_memory 56
> 	nr_subsys_perf_event 57
> 	nr_subsys_hugetlb 1
> 	nr_subsys_pids 56
> 	nr_subsys_rdma 1
> 	nr_subsys_misc 1
> 	nr_dying_descendants 30
> 	nr_dying_subsys_cpuset 0
> 	nr_dying_subsys_cpu 0
> 	nr_dying_subsys_io 0
> 	nr_dying_subsys_memory 30
> 	nr_dying_subsys_perf_event 0
> 	nr_dying_subsys_hugetlb 0
> 	nr_dying_subsys_pids 0
> 	nr_dying_subsys_rdma 0
> 	nr_dying_subsys_misc 0
> 
> Another sample output from system.slice/cgroup.stat was:
> 
> 	nr_descendants 34
> 	nr_subsys_cpuset 0
> 	nr_subsys_cpu 32
> 	nr_subsys_io 32
> 	nr_subsys_memory 34
> 	nr_subsys_perf_event 35
> 	nr_subsys_hugetlb 0
> 	nr_subsys_pids 34
> 	nr_subsys_rdma 0
> 	nr_subsys_misc 0
> 	nr_dying_descendants 30
> 	nr_dying_subsys_cpuset 0
> 	nr_dying_subsys_cpu 0
> 	nr_dying_subsys_io 0
> 	nr_dying_subsys_memory 30
> 	nr_dying_subsys_perf_event 0
> 	nr_dying_subsys_hugetlb 0
> 	nr_dying_subsys_pids 0
> 	nr_dying_subsys_rdma 0
> 	nr_dying_subsys_misc 0
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Looks good to me!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

