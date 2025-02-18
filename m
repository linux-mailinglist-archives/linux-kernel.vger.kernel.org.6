Return-Path: <linux-kernel+bounces-520061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7554EA3A52E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72988173F13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F374A1EB5F4;
	Tue, 18 Feb 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rE847qC6"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DB1EB5C6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902654; cv=none; b=AR6S2e0LgDaA8kK3RMQAlrk6Xz+QPMHVD6fiPhRQqJ2UF/8Rp2GuxIrrmmFtbtLp5DEnvsBgdht93sevv6PLe1I6eNaaS5/Esd5G7RdGGgshRejCJv2BZeTdvijVWb3glrDMUphGIyoPryatg6bG82N25Mrjje2NG8ID1ohyEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902654; c=relaxed/simple;
	bh=lrRgmzj9/10Vr3asw2AFLfUaXCwQBx6aXNj76P8rbMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UqtKv0/ahsQcgRRqybWOkWvAWiD9gG4Ver0qLYSDEX2yeCVl1VOBra9tYT3KPrnlgXd8NyXolJXczWYzXBnjkBrQsGX+JXDcEH378qYL8RoVGIlhS47LevpVSPlkYzJGi8+PShMD+ejc9Ue/75f2sjh7cfEW4rDezWFcGIUhynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rE847qC6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so18442642a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902652; x=1740507452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lCunPNvyoNHPREweiOwt6l2g29bvKIWb/bOkZd5SCY=;
        b=rE847qC6czc/2JYbWSAEQXb0ziB6y8vjsJ2Pnjw3LEU+UcNA67GPvlCNhnKqmAojHE
         HkZB0dtJiSRd8dryXmpeh/cKx8DRUkrOBkGmDCwoY6Wn6FKFEwABS4qjMI6y3WqxZStP
         uYMeRHiKiJFfVZBLS0P8dPbJigtiZ3iiSq6oxkSJ3LBoeEsOeuz6jZin60lc60MQoU/s
         jKS0Ek60XJOOcdTXx+Ly37cJBX0R/4nVmYVBGyUIx/SL3KyK67WXaLJN+ANRTZqV8oqs
         s9C1jWJt1Gf1IePpIgkhsizkByK+nFpYPoPCZcwI0xxUgySs+YI1r0JGwI75m9+2+E6F
         NHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902652; x=1740507452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lCunPNvyoNHPREweiOwt6l2g29bvKIWb/bOkZd5SCY=;
        b=K3Oq+e8hL/3QVzozbDEXerQNNhjTv+euADxR+LNwZWtuA78jUEZYCP9HXbE2UOUvYc
         VEDzmOz5JzWnif7xUxsomX9Uu5kDz//+VDiIF2CtVvbXH62zllrdc9n1h/nRJ6bw14fK
         5HwbBK2x0yzJnP+UrAgpHeHnjsekj4+nunV9oOWinz+SamWUGbUC5gWzEwDaZ/TYs0n4
         ZBwPaxmK7ZKafoFk2+XZKdI9KhopfBuHHCZiEwyEquG0FGfJy03FkY+vBEO4bIAV02Qs
         5W/r8jXyG1QItLrxj5bHiAvYherWMGoUyZDeYVVqdPpM8KT9fBhormuvbAPJxCVUTmht
         Ry9w==
X-Forwarded-Encrypted: i=1; AJvYcCWAd8nWwZQOm5f6lOCzIFVESV4cC3na+awIlJbb/AjnRZ2shX9Lbj7mr/RyrPN9PxDqAQG7mXGE8w3mzK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+bCFDCuWYa841bWLBb1UdM6ccUD9w3XuheZBZ53bz2zKFacC
	R6/VaFh+slqAG3+K/GlxAcRsj7gvwAGakSWzRe6fc6F5Ok69JsABS7zAyzBrKtn6P9ZZQg==
X-Google-Smtp-Source: AGHT+IEiGtyScdRky5bkAafNraZwWCRGFXYj414LaJ08JfaMF+efUR8WKUPEyVMq5sIlSaMu51tlCpWi
X-Received: from pjc8.prod.google.com ([2002:a17:90b:2f48:b0:2eb:12d7:fedd])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a09:b0:2ea:9ccb:d1f4
 with SMTP id 98e67ed59e1d1-2fc4078e984mr27765805a91.0.1739902652189; Tue, 18
 Feb 2025 10:17:32 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:44 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-17-fvdl@google.com>
Subject: [PATCH v4 16/27] mm/hugetlb: move huge_boot_pages list init to hugetlb_bootmem_alloc
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of initializing the per-node hugetlb bootmem pages list
from the alloc function, we can now do it in a somewhat cleaner
way, since there is an explicit hugetlb_bootmem_alloc function.
Initialize the lists there.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea5f22182c6e..0f14a7736875 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3574,7 +3574,6 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long allocated;
-	static bool initialized __initdata;
 
 	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
 	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
@@ -3582,17 +3581,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 		return;
 	}
 
-	/* hugetlb_hstate_alloc_pages will be called many times, initialize huge_boot_pages once */
-	if (!initialized) {
-		int i = 0;
-
-		for (i = 0; i < MAX_NUMNODES; i++)
-			INIT_LIST_HEAD(&huge_boot_pages[i]);
-		h->next_nid_to_alloc = first_online_node;
-		h->next_nid_to_free = first_online_node;
-		initialized = true;
-	}
-
 	/* do node specific alloc */
 	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
 		return;
@@ -4916,13 +4904,20 @@ bool __init hugetlb_bootmem_allocated(void)
 void __init hugetlb_bootmem_alloc(void)
 {
 	struct hstate *h;
+	int i;
 
 	if (__hugetlb_bootmem_allocated)
 		return;
 
+	for (i = 0; i < MAX_NUMNODES; i++)
+		INIT_LIST_HEAD(&huge_boot_pages[i]);
+
 	hugetlb_parse_params();
 
 	for_each_hstate(h) {
+		h->next_nid_to_alloc = first_online_node;
+		h->next_nid_to_free = first_online_node;
+
 		if (hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
 	}
-- 
2.48.1.601.g30ceb7b040-goog


