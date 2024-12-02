Return-Path: <linux-kernel+bounces-428191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225FA9E0D69
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22AD7B3EB23
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE061DE3AF;
	Mon,  2 Dec 2024 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McTFBxXp"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861E1DE3A6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164943; cv=none; b=EeTydwHWWWdtWJdNvm2fNGyU8HJKf9GSAnAF7u0Kbhu5yA6197jbTIlodjL1KnGNdqe2EN5Odm+14eCWnW9lcmGlnAOD8FSPqBD84A3ICMsMjiLRxu5i+Dh+LIonPJnB2gYJD+WZ0RdMilwKGfFkqWHYnBGc6SZp5ua+uGDc7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164943; c=relaxed/simple;
	bh=kohIEs6g/0WO80fMbekc0VeT6TBBEae4RbP8+DGDZrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WduKyws/9imjTL9KYb8pAMQBNWBTEpINvrxut4eeQRjKUPzVUZKE+4ty/sGdxOa7poxDblZcrFfbvTMSOVsPdxFy5S2wMwDuuiGyod8p7/dgYr8GsZoaFywzzjRIEH7xUpVs178yvuHSFz5rVUEz6v9IJ62Y4xviebYq9Mh3xmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McTFBxXp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso3895488b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 10:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733164940; x=1733769740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1aeU1SawrmUs4i99mcy6Gmav34YptGDoV51/MymT7EU=;
        b=McTFBxXp0+ybvd8OlR4iRofdkvFq09vmJm9hdC/ykKwb5/K09ctDLsipSPtpvEeUS4
         XpgQ65K4l1AVSSrKzzAdDI8QhrM1FoFSojBr/jlsUi1jXT4hf3sijNUJpH6oR+eRkeAD
         DqpSXvIJEhdwPn474kH9z9U7uzqPn0oMcLIqMQnUSj4Gndv0fZKedSgtkQtVVv3L/ZVP
         hjnp+3zXBtYJbOxNU9Gw3ZzkGU3zDon7AP35sJfnB7aNdANqc+QEzQcGiml74JKYT9Dv
         oI4ouHFoFL2EX0/td59Hq/Ek+GDcNyjvShRzSL7beogJv+w9bcFNTMMJgRhVXivLu51t
         EbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164940; x=1733769740;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aeU1SawrmUs4i99mcy6Gmav34YptGDoV51/MymT7EU=;
        b=mVLSAo8OJd/nmn/2K6scLZ3I35hv4Wm+PWrovWwxPoSG0H8tlsMr0PPPQV95gKKycL
         uqXN8q1ZiBSUrABLLy94GOZQ8jHmw90UuhWD7Oo2rTEArm3hvFzZYZdJgLfa94EjPL05
         UmScx+4Urf5lba7tsVEtT3G6uVEk5NagUx5gwFdMW4xFcocc7A+l3GR81Lxkc9GvzX0J
         Tg9MkuD2BGfc5T4pvhhIuPFwyGctag51OsBjiWxW+qKYyg2q+oQNuZV4lgKLLecWSs60
         rJ3O7yXbA9eucvBjeuINInHoTLkFaRKLkaobto81mxrSP888JTdrc4oX8Yn/DdPFkMfR
         FEzg==
X-Forwarded-Encrypted: i=1; AJvYcCVqDoZOZK2uoSSIsmv2cytNZW1dpnCapV47Ux9XZib3HTUlbN4VGvhExADif2OovCDvFz9bn4cKhh718wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsJJ2QyysEzbSorrHObvBPrultvQy9lhC/CBv7oJfGC0NShmV
	GqVxpdIlYq5m8wR+4tRVGytcSVTwx25RjNdPc8q4UncJBaQy3QVK
X-Gm-Gg: ASbGncvJzgMNocQLGZ+ikG/WO72SPZZPt7iTd6BspIm2+upQ7BvNqpnYSxj2MJ909l+
	Miky8s53WGq9nSDAJld51kY+CmLyCHmkWix5+6wrqttS70/rfp2ITaoaXCG4YfBqL5OBHu7o0sK
	4BWmegOMpd237vAwwXSGiKaEtpVMkO5SRNH/SDSJLqvSDXL6Iln1i+Ovm9YVAA4knmGRXsgtF99
	sYmeCsq2fu9l+J4D2cE3aKP95hXfE/541f8crIu3mY6UxsQlIWfuklV6f+HMvbyGlavgBE=
X-Google-Smtp-Source: AGHT+IGfiyQ6y7KACpekf7bdygxRsz/ROBwam32XtlPd4Ct4vBnneUD3+Zdg4Z2+z0w6o72q8gMZxw==
X-Received: by 2002:a05:6a00:1a8b:b0:724:fcff:505b with SMTP id d2e1a72fcca58-7253007218fmr32371685b3a.14.1733164940196;
        Mon, 02 Dec 2024 10:42:20 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb7d5sm8849781b3a.94.2024.12.02.10.42.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Dec 2024 10:42:19 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 3/4] mm/swap_cgroup: simplify swap cgroup definitions
Date: Tue,  3 Dec 2024 02:41:53 +0800
Message-ID: <20241202184154.19321-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202184154.19321-1-ryncsn@gmail.com>
References: <20241202184154.19321-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Remove the intermediate struct swap_cgroup, it just a unsigned short
wrapper, simplify the code.

Also zero the map on initialization to prevent unexpected behaviour as
swap cgroup helpers are suppose to return 0 on error.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_cgroup.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 1770b076f6b7..a76afdc3666a 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -12,14 +12,12 @@ struct swap_cgroup {
 };
 
 struct swap_cgroup_ctrl {
-	struct swap_cgroup *map;
+	unsigned short	*map;
 	spinlock_t	lock;
 };
 
 static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
 
-#define SC_PER_PAGE	(PAGE_SIZE/sizeof(struct swap_cgroup))
-
 /*
  * SwapCgroup implements "lookup" and "exchange" operations.
  * In typical usage, this swap_cgroup is accessed via memcg's charge/uncharge
@@ -33,18 +31,6 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
  *
  * TODO: we can push these buffers out to HIGHMEM.
  */
-static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
-					struct swap_cgroup_ctrl **ctrlp)
-{
-	pgoff_t offset = swp_offset(ent);
-	struct swap_cgroup_ctrl *ctrl;
-
-	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
-	if (ctrlp)
-		*ctrlp = ctrl;
-	return &ctrl->map[offset];
-}
-
 /**
  * swap_cgroup_record - record mem_cgroup for a set of swap entries
  * @ent: the first swap entry to be recorded into
@@ -58,20 +44,21 @@ unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
 				  unsigned int nr_ents)
 {
 	struct swap_cgroup_ctrl *ctrl;
-	struct swap_cgroup *sc;
+	unsigned short *map;
 	unsigned short old;
 	unsigned long flags;
 	pgoff_t offset = swp_offset(ent);
 	pgoff_t end = offset + nr_ents;
 
-	sc = lookup_swap_cgroup(ent, &ctrl);
+	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
+	map = ctrl->map;
 
 	spin_lock_irqsave(&ctrl->lock, flags);
-	old = sc->id;
-	for (; offset < end; offset++, sc++) {
-		VM_BUG_ON(sc->id != old);
-		sc->id = id;
-	}
+	old = map[offset];
+	do {
+		VM_BUG_ON(map[offset] != old);
+		map[offset] = id;
+	} while (++offset != end);
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	return old;
@@ -85,20 +72,26 @@ unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
  */
 unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 {
+	struct swap_cgroup_ctrl *ctrl;
+
 	if (mem_cgroup_disabled())
 		return 0;
-	return lookup_swap_cgroup(ent, NULL)->id;
+
+	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
+	pgoff_t offset = swp_offset(ent);
+
+	return READ_ONCE(ctrl->map[offset]);
 }
 
 int swap_cgroup_swapon(int type, unsigned long max_pages)
 {
-	struct swap_cgroup *map;
+	void *map;
 	struct swap_cgroup_ctrl *ctrl;
 
 	if (mem_cgroup_disabled())
 		return 0;
 
-	map = vcalloc(max_pages, sizeof(struct swap_cgroup));
+	map = vzalloc(max_pages * sizeof(unsigned short));
 	if (!map)
 		goto nomem;
 
@@ -117,7 +110,7 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 
 void swap_cgroup_swapoff(int type)
 {
-	struct swap_cgroup *map;
+	void *map;
 	struct swap_cgroup_ctrl *ctrl;
 
 	if (mem_cgroup_disabled())
-- 
2.47.0


