Return-Path: <linux-kernel+bounces-426547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF89DF49F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 05:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C36B231B7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 04:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270FA22612;
	Sun,  1 Dec 2024 04:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFzA54M2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA10320F
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 04:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733026296; cv=none; b=igZxefZ1FLlS8YOhk/zEtSyqleDTGPBO0rZA5Dftztp7ONR+fkkgFr4/RLBIPzYpihedKP1CBIep45Y0RC4Jibfag3/gm5MZKWaN0yZJq4g50r1J100rM+pW7Da63xoYWh4kZyjzUuLOjS72YWgM3yO43H2pPS+l2TMNW4ICKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733026296; c=relaxed/simple;
	bh=YdhYNfi1nzvJUMr2lScsoMJVNq8sVzWUnAcD+3BFhj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hR2jqyC5Dn6yAKEjtBR5j0WdqvOakoM8Lb2FN0yJUMTK+gmcA0DS4FqF9t1P6oASiRD2nxGFkHJ2HpjjGfZsURVp8lcBjMLu8ObgaF4DRLbLC+K3Ay/mw2zo1XL24yVjGUC7H0zInjPAdMUqXFN7DeOUZ+YDcjGb6oKp4SDOzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFzA54M2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733026292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPtLOt/hURa3iFsAk+oAcNvPgjwDjT+1ZbyaJ1+Kf5s=;
	b=fFzA54M2vjcSGpJMGhkxk6uUKmDW78KZYJ1uN2amBDRZNmqNxS/fn6zzPRhmQKrjIqnSvk
	/uUabXyBr69YZt9criOua5iEQWmVoeh3b/M95EaaQDDpmT5mzc4m6FwXkgm0VItZcYwoKs
	YHAI47wHqhV331VzOsdvb5C8ObL6KzU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-ZcirIlHpM1icNl3ddWtteQ-1; Sat,
 30 Nov 2024 23:11:30 -0500
X-MC-Unique: ZcirIlHpM1icNl3ddWtteQ-1
X-Mimecast-MFC-AGG-ID: ZcirIlHpM1icNl3ddWtteQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C10D8195608C;
	Sun,  1 Dec 2024 04:11:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.33])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68C4E195605A;
	Sun,  1 Dec 2024 04:11:26 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mgorman@techsingularity.net,
	snishika@redhat.com
Subject: Re: [PATCH] mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()
Date: Sun,  1 Dec 2024 13:11:23 +0900
Message-ID: <20241201041124.472908-1-snishika@redhat.com>
In-Reply-To: <20241130184017.7290e756a5f2199b463a7172@linux-foundation.org>
References: <20241130184017.7290e756a5f2199b463a7172@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Sun, Dec 1, 2024 at 11:40 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sun,  1 Dec 2024 01:12:34 +0900 Seiji Nishikawa <snishika@redhat.com> wrote:
>
> > The kernel hangs due to a task stuck in throttle_direct_reclaim(),
> > caused by a node being incorrectly deemed balanced despite pressure in
> > certain zones, such as ZONE_NORMAL. This issue arises from
> > zone_reclaimable_pages() returning 0 for zones without reclaimable file-
> > backed or anonymous pages, causing zones like ZONE_DMA32 with sufficient
> > free pages to be skipped.
> >
> > The lack of swap or reclaimable pages results in ZONE_DMA32 being
> > ignored during reclaim, masking pressure in other zones. Consequently,
> > pgdat->kswapd_failures remains 0 in balance_pgdat(), preventing fallback
> > mechanisms in allow_direct_reclaim() from being triggered, leading to an
> > infinite loop in throttle_direct_reclaim().
> >
> > This patch modifies zone_reclaimable_pages() to account for free pages
> > (NR_FREE_PAGES) when no other reclaimable pages exist. This ensures
> > zones with sufficient free pages are not skipped, enabling proper
> > balancing and reclaim behavior.
>
> We'll want to backport a fix for this into -stable kernels.  For that
> it's best to be able to identify a suitable Fixes: target, to tell
> others whether their kernel needs the fix.  Are you able to help
> identify that commit?

Based on my analysis, the issue appears to be fundamentally rooted in 
the original design of zone_reclaimable_pages(). The subsequent change 
introduced with a2a36488a61c ("mm/vmscan: Consider anonymous pages 
without swap") does not fundamentally alter the behavior but it just 
refines the handling of anonymous pages. It does not account for zones 
with sufficient free pages but no reclaimable file-backed or anonymous 
pages. The relevant commit that introduced this function is:

Fixes: 5a1c84b404a7 ("mm: remove reclaim and compaction retry approximations")

This commit seems to be the most appropriate target for the Fixes: tag,
as it introduced the logic that my patch modifies to address the 
observed kernel hang.

>
> Thanks.
>
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -374,7 +374,14 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
> >       if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
> >               nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
> >                       zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
> > -
> > +     /*
> > +      * If there are no reclaimable file-backed or anonymous pages,
> > +      * ensure zones with sufficient free pages are not skipped.
> > +      * This prevents zones like DMA32 from being ignored in reclaim
> > +      * scenarios where they can still help alleviate memory pressure.
> > +      */
> > +     if (nr == 0)
> > +         nr = zone_page_state_snapshot(zone, NR_FREE_PAGES);
> >       return nr;
> >  }
> >
> > --
> > 2.47.0
>


