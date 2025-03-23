Return-Path: <linux-kernel+bounces-572929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE3A6D07D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF5716A673
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E541624D5;
	Sun, 23 Mar 2025 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D58qloWL"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4713D8A3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742753092; cv=none; b=fWWqsMT80FeEr3QOtZojvXAifz82KJRfePtEYCrOQUTOkJ6kIj/f+IH+h/bjATOfy5d2iFGVHvnJABE3jhY37hlQExUs8tmyez00kBWDi5rPsi5hhfOc5/ZV3L21/MXpphhquNluQ8+gTPA+jTuIJon0emOCxxLWtUqT0l4SKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742753092; c=relaxed/simple;
	bh=2ViIV85TyUxCGCpyYYEI6HM+pZ9CTOpguG2K49jmR40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSJe55KQTt8euB/pXfgZzyQAiaQv1jHEUepOSsoR1AS5nA+kAZgXiKJLPM1BmDbdVdKqOC7QdbrjgZZ1OkGl2rHeS5DR4uSC++kU0xSyzXeiDJ51xNMxXpxxcZ883tc8UpKJB5AVDxo6vKFuMYWlSo4AzhEIfwofVA+/TJhRPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D58qloWL; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3913b2d355fso1376610f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 11:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742753089; x=1743357889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/amBw34dpEJnnZjSrhxGc8BplLP2Fj00al8Lay6Rbc=;
        b=D58qloWLGGFp9emvBt+BABFch7w7Fz0NXvb+YanpeMcsbn4Fa/A9TFjLQPV8oRpBBk
         NWwK/5bvdETtJNUrDhkrDLB9MVogsc4Wg26noFJ+rgAk3v/b8SO899hZtMpHfQwEUNl6
         em0cCV0G0qZzrryqQlkjGsG8AL6RBGojtsSfUePNeYPMGGu4aBuQ7kDXUmbyNIHD6/pr
         MmR63HIHM9vpvH2dso88NssHMzEqeN7I/q+ocEuWQbtD28H8vlLCOSyBM3Pgem3GRAJa
         VPWNjMiV2QxPlkOqJnVQmeV+2s9wq3CIympNc+LWj6Kap/flYwW44S2tos2Pg25p+/Sh
         LLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742753089; x=1743357889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/amBw34dpEJnnZjSrhxGc8BplLP2Fj00al8Lay6Rbc=;
        b=Vknxu7skiyOc5oyDOsxTH0L/+iryBWNqnz0L1n+5SM54g6vDFZhJgvacis1GpmlWJG
         lzOK8GLIQD6Md4xgQRbpJQllOgW+S7KjfvSnTsywLvj1JXGxrkbCrLPUly2M+gQlj11y
         YQfC5P9NGb/6PwJ/MPt368pLMIHqI3heBJOG9TPIAwtvtP9WmmK4S6dzz5UbrSQFr0j5
         2527/PvS/+1uSx0sOAG5nmx3iWMKF2Erg3NO0bzDNMIOwML4VxZ3ehNQcLNl6Q2BRwSb
         5967MN8hpL6TWWuDHpgNlDMQomdxNGc7kmxEUWRpyDWFcEokqHJXLwK5K0XoEvkzTZ+F
         G2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6F3GwnQfpdhPgNmR3UZ0/yWCYP9antgW2D9kSFjOFHY9HYRA06cVD0N82mk+ZrP65UuYbyrt6k+RSyT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3egTZhi1LfA7n7qdNFEx+3JXMx/NLPU6/sY+6KfDHOnkbUTn
	q5CgYPnb8eilCh6T2vjcrGR2Z2TaFbBuGSdrzR+nvpra/ChB1+uPBCNmIYuVAmQClsDrVgzJJnu
	/K/JkcLZmgw==
X-Google-Smtp-Source: AGHT+IHBHcAWixxdn5uLrsnvUaunJRGtJMk3uonV52a0UmLLxu6s63W45Y6bQKKwRo7EqfSZ10WJhR/FTkf1eg==
X-Received: from wmbfl10.prod.google.com ([2002:a05:600c:b8a:b0:43c:fa2a:77d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c2:b0:391:2df9:772d with SMTP id ffacd0b85a97d-3997f90f731mr10974102f8f.13.1742753089037;
 Sun, 23 Mar 2025 11:04:49 -0700 (PDT)
Date: Sun, 23 Mar 2025 19:04:29 +0100
In-Reply-To: <20250323034657.GD1894930@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313210647.1314586-1-hannes@cmpxchg.org> <20250313210647.1314586-4-hannes@cmpxchg.org>
 <D8MVZ8L12HJN.1LN4G4H0ESLY6@google.com> <20250323005823.GB1894930@cmpxchg.org>
 <20250323013405.GC1894930@cmpxchg.org> <20250323034657.GD1894930@cmpxchg.org>
X-Mailer: aerc 0.18.2
Message-ID: <D8NUEJHT150J.17YZMGLU54JG7@google.com>
Subject: Re: [PATCH 3/5] mm: page_alloc: defrag_mode
From: Brendan Jackman <jackmanb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun Mar 23, 2025 at 4:46 AM CET, Johannes Weiner wrote:
> On Sat, Mar 22, 2025 at 09:34:09PM -0400, Johannes Weiner wrote:
> > On Sat, Mar 22, 2025 at 08:58:27PM -0400, Johannes Weiner wrote:
> > > On Sat, Mar 22, 2025 at 04:05:52PM +0100, Brendan Jackman wrote:
> > > > On Thu Mar 13, 2025 at 10:05 PM CET, Johannes Weiner wrote:
> > > > > +	/* Reclaim/compaction failed to prevent the fallback */
> > > > > +	if (defrag_mode) {
> > > > > +		alloc_flags &= ALLOC_NOFRAGMENT;
> > > > > +		goto retry;
> > > > > +	}
> > > > 
> > > > I can't see where ALLOC_NOFRAGMENT gets cleared, is it supposed to be
> > > > here (i.e. should this be ~ALLOC_NOFRAGMENT)?
> > 
> > Please ignore my previous email, this is actually a much more severe
> > issue than I thought at first. The screwed up clearing is bad, but
> > this will also not check the flag before retrying, which means the
> > thread will retry reclaim/compaction and never reach OOM.
> > 
> > This code has weeks of load testing, with workloads fine-tuned to
> > *avoid* OOM. A blatant OOM test shows this problem immediately.
> > 
> > A simple fix, but I'll put it through the wringer before sending it.
>
> Ok, here is the patch. I verified this with intentional OOMing 100
> times in a loop; this would previously lock up on first try in
> defrag_mode, but kills and recovers reliably with this applied.
>
> I also re-ran the full THP benchmarks, to verify that erroneous
> looping here did not accidentally contribute to fragmentation
> avoidance and thus THP success & latency rates. They were in fact not;
> the improvements claimed for defrag_mode are unchanged with this fix:

Sounds good :)

Off topic, but could you share some details about the
tests/benchmarks you're running here? Do you have any links e.g. to
the scripts you're using to run them?

