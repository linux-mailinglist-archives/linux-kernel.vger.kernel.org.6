Return-Path: <linux-kernel+bounces-251100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754269300A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E151F218AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066E2233B;
	Fri, 12 Jul 2024 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nh4JaPaH"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255C1EB3E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810576; cv=none; b=HYXt3lpuxxNasGc+gTOIlELAefdvb40TzTSZDgiwTFbbKZYK6OEOgbff0kSvKnBsSu3uJLR8uRWPI3B4WKs28/ie/3tGux9Ej7IE71cBIPHPp3u5IxmY5LVkyQHd2iv0K61XsdXrGq4FZzQx3rKu5OBQ4ghTDirnuZkdD8NsJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810576; c=relaxed/simple;
	bh=IQCLsBi/RkvLOEgoSSl1XQ/GIxiJJy6agjjoG4e2ZU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1X+q8XxROXFEVr/q1+4IQG/LjvZFsJ0l82zTw5trctDHfms59zX/NjxPahKnj2bfs+FTCnJvFdlXXITElFbsmOvU+0wD/IslDKageYxyISfrMYJW7oOvwgN22v9HHjwe5iCcOEZBMsw52LlTH3HG2ULcG4ga0V0NE/GOReSm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nh4JaPaH; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dan.carpenter@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720810571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLOuCRQ0OaEn4CRs61suYHL8mnpNY/wKKFfs4K+hv9E=;
	b=nh4JaPaHNlL6nLBdOjcY/PKNDiItVRVQ9xhllFUjjYbPY8sSv7cDsirO3xQuMT0ZvKms9G
	ovvREJr4c5R9y4n1Ywc9Ojc8h94iUqjAG1SGNvQBK/IAMXdDxGubYPosMT2Qxj8IVnk/Ik
	kVQb5jonTLZzT6dJxnsO15NVB3aM8RI=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 12 Jul 2024 18:56:03 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [bug report] mm: memcg: move charge migration code to
 memcontrol-v1.c
Message-ID: <ZpF8Q9zBsIY7d2P9@google.com>
References: <cf6a89aa-449b-4dad-a1a4-40c56a40d258@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6a89aa-449b-4dad-a1a4-40c56a40d258@stanley.mountain>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 12, 2024 at 09:07:45AM -0500, Dan Carpenter wrote:
> Hello Roman Gushchin,
> 
> Commit e548ad4a7cbf ("mm: memcg: move charge migration code to
> memcontrol-v1.c") from Jun 24, 2024 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	mm/memcontrol-v1.c:609 mem_cgroup_move_charge_write()
> 	warn: was expecting a 64 bit value instead of '~(1 | 2)'
> 
> mm/memcontrol-v1.c
>     599 #ifdef CONFIG_MMU
>     600 static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
>     601                                  struct cftype *cft, u64 val)
>     602 {
>     603         struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>     604 
>     605         pr_warn_once("Cgroup memory moving (move_charge_at_immigrate) is deprecated. "
>     606                      "Please report your usecase to linux-mm@kvack.org if you "
>     607                      "depend on this functionality.\n");
>     608 
> --> 609         if (val & ~MOVE_MASK)
> 
> val is a u64 and MOVE_MASK is a u32.  This only checks if something in the low
> 32 bits is set and it ignores the high 32 bits.

Hi Dan,

thank you for the report!

The mentioned commit just moved to code from memcontrol.c to memcontrol-v1.c,
so the bug is actually much much older. Anyway, the fix is attached below.

Andrew, can you please pick it up?

I don't think the problem and the fix deserve a stable backport.

Thank you!

--

From 8b3d1ebb8d99cd9d3ab331f69ba9170f09a5c9b6 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <roman.gushchin@linux.dev>
Date: Fri, 12 Jul 2024 18:35:14 +0000
Subject: [PATCH] mm: memcg1: convert charge move flags to unsigned long long

Currently MOVE_ANON and MOVE_FILE flags are defined as integers
and it leads to the following Smatch static checker warning:
    mm/memcontrol-v1.c:609 mem_cgroup_move_charge_write()
    warn: was expecting a 64 bit value instead of '~(1 | 2)'

Fix this be redefining them as unsigned long long.

Even though the issue allows to set high 32 bits of mc.flags
to an arbitrary number, these bits are never used, so it doesn't
have any significant consequences.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6b3e56e88a8a..2aeea4d8bf8e 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -44,8 +44,8 @@ static struct mem_cgroup_tree soft_limit_tree __read_mostly;
 /*
  * Types of charges to be moved.
  */
-#define MOVE_ANON	0x1U
-#define MOVE_FILE	0x2U
+#define MOVE_ANON	0x1ULL
+#define MOVE_FILE	0x2ULL
 #define MOVE_MASK	(MOVE_ANON | MOVE_FILE)
 
 /* "mc" and its members are protected by cgroup_mutex */
-- 
2.45.2.993.g49e7a77208-goog


