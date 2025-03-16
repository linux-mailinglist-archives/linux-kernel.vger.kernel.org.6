Return-Path: <linux-kernel+bounces-562866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF16A633D3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 05:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695C13B01A1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 04:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE5D143748;
	Sun, 16 Mar 2025 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybcTjqnH"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543B13632B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 04:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742099312; cv=none; b=Urk2sKcAb3JverLMpSEqvOEtzbRjPPuTKJUQvYjEzTXtP7dsJzWvpK93Bs6Je1Wquf5nsLFcMRWuTY9yLYSYc8/RsME/5FMFJEJx50LlKsH/M6QCt+tO0Mo31H/GtIVuPiGwa5gQTYkor5q937acDG2MgBtzEazPpEyIBaKp9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742099312; c=relaxed/simple;
	bh=FZSJWiZLXjqC6y47npzUT1f4iHsKu36HldeTTvNpvO8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=He3cULqS2fOAqMuYKglbyr0iaPppoXgSVBOzeR45+HX0JWbTDnNf3ct/U8a5iH94tdmR3u9W1HuUk6m6uhWf+CgIZv8+uLYfPLRSPQdpyGHwdDSelXVDtZm5A8LATs2nGf22THQJsFIKDE/PaAZZCMLw32LheIMqJQsPfX+udIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybcTjqnH; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7273f35b201so2092535a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 21:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742099309; x=1742704109; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zn/hFEmYVNTaOoS0zsULqiyCkDZvvdFkC8aMRGGcsM8=;
        b=ybcTjqnHV7MZTRVIeCBs+BZ7aG5ZZwJtV9x9gBWOm6Vr+HWslR/hqhikey8661q4BL
         VGfRlqZUGMmm9fBPCk21dbhhe6Ly4vWtL/slLjD7p5L417DD79R4m5dEsoyQ6YS5r3Gu
         RdIgdwuCX7PIWgDOztFRaxxThkp81xfYxJAkA8xbTw1alZiuu+ClQxOcFxxnPq2PlpVE
         YryFRAAGz3L5aLxIrzjwXzFjnU1KMOV7FP5NOI4oXsMVBmcelv/6833kocZuCVaL3KZu
         tu+vwgpOw0LBT3jZWttKZSUjeEiQSdgphEu9jdiReRGCgWtY6+GxqOXKXbCGzAwPj1vZ
         gLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742099309; x=1742704109;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zn/hFEmYVNTaOoS0zsULqiyCkDZvvdFkC8aMRGGcsM8=;
        b=ugk4BZu9izWL9qmGIM+AawfQdpIBiXkHSuh00nJz4yLXA20Ta8r+dwyg/xN4SGLwVT
         fmmmKv/9OhG2w2+u+cSSuVAa/KROcXpxxTof2XDCPsvWEUKvOjGFQ7wexQ5EwKdb6jJr
         tc0cXi8RrXxN25fTzeEko7fQIIHlVFNbJKgwcc3gcEwUeBL9pLdKMMR3LOjFjqkq8ohW
         6SS4T1GxCkTHocAVLNaYs+li+cxfkgIHHAwXrjthWxLOIf9d2JOJaTud4C8TnP84Xtk/
         YMJtdY2Pn+CY9L2WjF6R0gcdy7xtZ4pFeDqWBULTYigtYTFIXxKHWEDF0pj3emUAO6uz
         gHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEVW908Ai+31j1gp0S9Xmhbdl1MeDzTvW3NeL4cg10Tpn7z25U5Po+L9nM6YDPxcF/S+Y0WW6x9tS0c8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNv57TrfALhrnIrzrxPMN7/mwl2e9Xef63ljleov7Ox4KEqdG
	heoYzT1pESM9zOiHZJiuUaeiouUyH/Xtj98ofXBxCvnh8DkY/jKJicu6IS0q8Q==
X-Gm-Gg: ASbGncshZ82PMCOf+DMEi+vL6On4NuPc0pl4maSUUNoVVRynvFWao0s/WJynH7a5lz2
	A8lE7lITQVmmWP9/wgr1bE+GjxDLI6Fx7rJz+UMMHheJMKa6sO3CxgP+PeYIZfzwmUJHACx4LPK
	Iy/G9ngyzhWEgHndEpZ4Q996WGKcY35RmDRhAMSzQg2H5dXlNqdp8ZFvd4ADrokOXNyM64NS0+q
	xq/+luA+ZURTx/KJk2tK4i4j9V2hHJ2mIZWsYeCdgbNXx0iYlMyP/4ectG+r5cLq0Bne3hUmGhG
	Vdxh4a0wSecoWUZK0Wbz9EpHUYMw7Ss3yQ2N3nAU+PFHyrrhTbwTW/cZ0vig6AjS24ucb45TNQq
	mL7zM4ePz0y4zJFMFCiwmbeBrJiUn
X-Google-Smtp-Source: AGHT+IFK+fYuCkkcOcDXAF8C7bDOskY1oi3b1lZCxddFTu9Fs37o6wimSvL0D05uusubWvgWsWaWjg==
X-Received: by 2002:a05:6830:43a3:b0:72b:9d8d:5881 with SMTP id 46e09a7af769-72bbc661152mr4342091a34.28.1742099309294;
        Sat, 15 Mar 2025 21:28:29 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6713586e1sm1603777fac.47.2025.03.15.21.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:28:28 -0700 (PDT)
Date: Sat, 15 Mar 2025 21:28:16 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Johannes Weiner <hannes@compxchg.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: compaction: push watermark into compaction_suitable()
 callers
In-Reply-To: <20250313210647.1314586-2-hannes@cmpxchg.org>
Message-ID: <005ace8b-07fa-01d4-b54b-394a3e029c07@google.com>
References: <20250313210647.1314586-1-hannes@cmpxchg.org> <20250313210647.1314586-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

[PATCH] mm: compaction: push watermark into compaction_suitable() callers fix

Stop oops on out-of-range highest_zoneidx: compaction_suitable() pass
args to __compaction_suitable() in the order which it is expecting.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 4a2ccb82d0b2..b5c9e8fd39f1 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2433,7 +2433,7 @@ bool compaction_suitable(struct zone *zone, int order, unsigned long watermark,
 	enum compact_result compact_result;
 	bool suitable;
 
-	suitable = __compaction_suitable(zone, order, highest_zoneidx, watermark,
+	suitable = __compaction_suitable(zone, order, watermark, highest_zoneidx,
 					 zone_page_state(zone, NR_FREE_PAGES));
 	/*
 	 * fragmentation index determines if allocation failures are due to
-- 
2.43.0

