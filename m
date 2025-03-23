Return-Path: <linux-kernel+bounces-572727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FD5A6CDD3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 04:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB93174DA9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 03:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D41DE8A0;
	Sun, 23 Mar 2025 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="qssDhBXD"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12B2E337D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 03:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742701628; cv=none; b=o0FtqBtbegR04DVGLo2MCpH4a95cuv0NpK/oymmKgz6Jc7tgOOMvlSceOq+jz087FXIF+dyhLXCj0cHhO9kN11xlxlJrGwx91V6azCE2P1HFtqjAL/nix+vp0F4NLVnknAoJkLosCsyIixyJkB8K0TcShTylJaXe8TK/ghrjSzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742701628; c=relaxed/simple;
	bh=DWlSmLs0w7ovSD6AiZ8D7b/plWn/qpD/PqcGawu+u5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFmey01EEed3MMk7VqNtMvBs+BDH9H3MUVuX4E2lyoQTmAhonHerARKIieYZCBBj4VNI3kByluzILINO3+mnJyZGgd3j8kM7FF0aEE5uDJKv74F0ym544tlrPRlXAfq1rdFQCiW3Wj2e8YReUTtLiweQymfmbq4W4iyTD40EDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=qssDhBXD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47698757053so42627101cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742701623; x=1743306423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=40bNv7hMAwwtRXNVkAj4nxm757/6riVRcENrQFl4p2Q=;
        b=qssDhBXDdqNt5+CHT2H4kpJU6G+CkNjXuHabBM6yCA+ktca2ca09RMVDLhGbWghplv
         Zb/KX5JujUDN/HBlC+UkvXp15+xvzX2LGEeE+hionKWAjde/qHZxz80QRMEbKyedYO4E
         0zR+yg+/+ZVNHg4hGFsoelATMezOZxqCV6/5flRkkRuTDfd5sf43U2I+j/n2/DHgq4D4
         BYH9mQdZEbBFzqHzdYqKNL8634dRFa/AkEoNuanMDltPMuWl6OAXPXMO/ViTCYDdJNv0
         w/Ty50jHdaWG65g0DMN91mKCGQebIG7lsjmUzT/qJ1v4g2u75hlsz6opB1tQpoH7RueT
         B6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742701623; x=1743306423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40bNv7hMAwwtRXNVkAj4nxm757/6riVRcENrQFl4p2Q=;
        b=SQIjICVFfrBYdH74yFOLqT+eMS5U3dW1KAX++uBFByeCNY0B00O7qch9JjyWjh7UaI
         sg4Zs12kVu75GzRJc0+xzOsrmxboJy62VkZ+8+/e+cJlnz9HWPpjQKab6I8qHW5u7mbP
         SEFcBLLmBo8gnSO9mAf6w3uf2dkVRO6v0Aq+cqFwL6D5ajKKhin/OOYYzJjPJBytM+gf
         tL88c6l4LDM8QANxtQPyFEpbLlTuIWPAYRlGnpC6XEermEUIUIhhcQCbu8T3Af0fNYdV
         T5HS1dV/nqjh7w4GzB0mmy1rzc1SHsUf+6j8qZxIEWA1DDbsXnlZWjZZo/gLZiQfAA2/
         Kk/w==
X-Forwarded-Encrypted: i=1; AJvYcCVrTLoJLHgEQNAFJzW77D3zPkfJqTIHWZhHX38L05p/0ZY/1OB8YGgueD0ZIpZjIRFs7znkOtJPVe4VANc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOc3ul5IfIVLJWsDEnF0wCHhHTaGef33tJzEYnILGH/TnHhQS
	sbtHJ9udFDAzWsuQbP9s0HOiW0iZTtwZLusgQJmMOWr0YijgmsZTsnW8M+HzJ0E=
X-Gm-Gg: ASbGnctbfmA7SbaUPTy3z8Pbj8OnoNrI2VCHBSyttqPd+zN4bZfKf5jHJdGSCzws+11
	QBrSFzdVkC3xCy+AC2E0dAUkU1WGcEjU7+fzFXPmZwalve/Jd8AS/20M8dXLO6sotJ40o/DOn5Z
	h5O41rfrZX2b94IIYkF0yz3K3U0KKU7u49abeaaibB3eNCyrue5mqtsWctl4EIICLAtaQSrEW+a
	5Jq1HXnoWlUZwrYNnVuIPH+kh5GLnIAOYf26gqT0oDJCHQyHZqC83vJan03d2PuwJEUAjEZ+NXh
	k+xZDBguOrhiBtrGHuXkDd6F3SIf7d7xdI9gWF3Go4g=
X-Google-Smtp-Source: AGHT+IFnRcBONefnUgCdgjRnWDkdRzPswf7L/Fq+jixakG6CxFaIgQKJOmOkORZ5wK1xmjSBQij57A==
X-Received: by 2002:a05:622a:5449:b0:476:923a:f1cb with SMTP id d75a77b69052e-4771de13fccmr162328441cf.41.1742701623704;
        Sat, 22 Mar 2025 20:47:03 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d51fd8csm30548191cf.49.2025.03.22.20.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 20:47:02 -0700 (PDT)
Date: Sat, 22 Mar 2025 23:46:57 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: page_alloc: defrag_mode
Message-ID: <20250323034657.GD1894930@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
 <20250313210647.1314586-4-hannes@cmpxchg.org>
 <D8MVZ8L12HJN.1LN4G4H0ESLY6@google.com>
 <20250323005823.GB1894930@cmpxchg.org>
 <20250323013405.GC1894930@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323013405.GC1894930@cmpxchg.org>

On Sat, Mar 22, 2025 at 09:34:09PM -0400, Johannes Weiner wrote:
> On Sat, Mar 22, 2025 at 08:58:27PM -0400, Johannes Weiner wrote:
> > On Sat, Mar 22, 2025 at 04:05:52PM +0100, Brendan Jackman wrote:
> > > On Thu Mar 13, 2025 at 10:05 PM CET, Johannes Weiner wrote:
> > > > +	/* Reclaim/compaction failed to prevent the fallback */
> > > > +	if (defrag_mode) {
> > > > +		alloc_flags &= ALLOC_NOFRAGMENT;
> > > > +		goto retry;
> > > > +	}
> > > 
> > > I can't see where ALLOC_NOFRAGMENT gets cleared, is it supposed to be
> > > here (i.e. should this be ~ALLOC_NOFRAGMENT)?
> 
> Please ignore my previous email, this is actually a much more severe
> issue than I thought at first. The screwed up clearing is bad, but
> this will also not check the flag before retrying, which means the
> thread will retry reclaim/compaction and never reach OOM.
> 
> This code has weeks of load testing, with workloads fine-tuned to
> *avoid* OOM. A blatant OOM test shows this problem immediately.
> 
> A simple fix, but I'll put it through the wringer before sending it.

Ok, here is the patch. I verified this with intentional OOMing 100
times in a loop; this would previously lock up on first try in
defrag_mode, but kills and recovers reliably with this applied.

I also re-ran the full THP benchmarks, to verify that erroneous
looping here did not accidentally contribute to fragmentation
avoidance and thus THP success & latency rates. They were in fact not;
the improvements claimed for defrag_mode are unchanged with this fix:

                                                VANILLA    defrag_mode=1-OOMFIX
Hugealloc Time mean               52739.45 (    +0.00%)   27342.44 (   -48.15%)
Hugealloc Time stddev             56541.26 (    +0.00%)   33227.16 (   -41.23%)
Kbuild Real time                    197.47 (    +0.00%)     196.32 (    -0.58%)
Kbuild User time                   1240.49 (    +0.00%)    1231.89 (    -0.69%)
Kbuild System time                   70.08 (    +0.00%)      58.75 (   -15.95%)
THP fault alloc                   46727.07 (    +0.00%)   62669.93 (   +34.12%)
THP fault fallback                21910.60 (    +0.00%)    5966.40 (   -72.77%)
Direct compact fail                 195.80 (    +0.00%)      50.53 (   -73.81%)
Direct compact success                7.93 (    +0.00%)       4.07 (   -43.28%)
Compact daemon scanned migrate  3369601.27 (    +0.00%) 1588238.93 (   -52.87%)
Compact daemon scanned free     5075474.47 (    +0.00%) 1441944.27 (   -71.59%)
Compact direct scanned migrate   161787.27 (    +0.00%)   64838.53 (   -59.92%)
Compact direct scanned free      163467.53 (    +0.00%)   37243.00 (   -77.22%)
Compact total migrate scanned   3531388.53 (    +0.00%) 1653077.47 (   -53.19%)
Compact total free scanned      5238942.00 (    +0.00%) 1479187.27 (   -71.77%)
Alloc stall                        2371.07 (    +0.00%)     553.00 (   -76.64%)
Pages kswapd scanned            2160926.73 (    +0.00%) 4052539.93 (   +87.54%)
Pages kswapd reclaimed           533191.07 (    +0.00%)  765447.47 (   +43.56%)
Pages direct scanned             400450.33 (    +0.00%)  358933.93 (   -10.37%)
Pages direct reclaimed            94441.73 (    +0.00%)   26991.60 (   -71.42%)
Pages total scanned             2561377.07 (    +0.00%) 4411473.87 (   +72.23%)
Pages total reclaimed            627632.80 (    +0.00%)  792439.07 (   +26.26%)
Swap out                          47959.53 (    +0.00%)  128511.80 (  +167.96%)
Swap in                            7276.00 (    +0.00%)   27736.20 (  +281.16%)
File refaults                    138043.00 (    +0.00%)  206198.40 (   +49.37%)

Many thanks for your careful review, Brendan.

---

From c84651a46910448c6cfaf44885644fdb215f7f6a Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Sat, 22 Mar 2025 19:21:45 -0400
Subject: [PATCH] mm: page_alloc: fix defrag_mode's retry & OOM path

Brendan points out that defrag_mode doesn't properly clear
ALLOC_NOFRAGMENT on its last-ditch attempt to allocate. But looking
closer, the problem is actually more severe: it doesn't actually
*check* whether it's already retried, and keeps looping. This means
the OOM path is never taken, and the thread can loop indefinitely.

This is verified with an intentional OOM test on defrag_mode=1, which
results in the machine hanging. After this patch, it triggers the OOM
kill reliably and recovers.

Clear ALLOC_NOFRAGMENT properly, and only retry once.

Fixes: e3aa7df331bc ("mm: page_alloc: defrag_mode")
Reported-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0c01998cb3a0..582364d42906 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4543,8 +4543,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		goto retry;
 
 	/* Reclaim/compaction failed to prevent the fallback */
-	if (defrag_mode) {
-		alloc_flags &= ALLOC_NOFRAGMENT;
+	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
+		alloc_flags &= ~ALLOC_NOFRAGMENT;
 		goto retry;
 	}
 
-- 
2.49.0


