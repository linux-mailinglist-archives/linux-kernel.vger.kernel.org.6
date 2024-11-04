Return-Path: <linux-kernel+bounces-395642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C57859BC0E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5159DB224BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB9E1FDFB2;
	Mon,  4 Nov 2024 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiBxjYn0"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FEC1FE0F5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759294; cv=none; b=DzRbni4KafiyFqci8cjY8Nx1zwn1uAzBaJZv1sXQ9XGCKl5K5H7ls04avwUx0lvwUYYwRwBQ9FlkbHktUaOkBw0KMubefQHuHxVT6tomgEChguqWjTWuxw+D9z/M2OV7ive/OuJ8rGchudStixzPNOJpjA/ajDkF957J2kPf/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759294; c=relaxed/simple;
	bh=+iOvuRNiKIbq55ASUVdH3ADxYemn89V9ikEUEtAXEBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ktt6SSoeKEHJ1JjGfk+BbV9EzbklI77TTpT3u0BAnNMY4d3WQ40e4PvX2QbNiJJKunAnMUc3E304Tr0D7vPCnybEBgSyPCygc6uHOF5t6DXkuLjKgt6r5MjL8b2cglwAn6Hm+xYhtKuJpmi72/8OxRBCC9OIqIh1ivppAcu2YW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiBxjYn0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2e3321aae0so7389434276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730759291; x=1731364091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJTHsOFb69amuDKNp+L1s7mL9nLva+h50iWgGzl+suk=;
        b=NiBxjYn0/STNuIFzwHHaweSoLJezHWzij53EBAd6b/qUv3WprGZFbdbWvNoDY4werM
         0lhx2CyhhvyXe1/LiKPzRLF8VdlnMYwKFS3D/EcEaYsMhd0LPhEMQT4lhbuZJEyCSpsN
         JcsLVCow60KskstofdSTyW04cEfI9ELfIq3h32Tdsdx5aV9hL57bgOpQxpyHQFIWsZiP
         duvjlurRshcor24TwKZlcGEovMBTny+0rQ/Xz13S4sWA9D+g9888M27thrCxA5VMS4pZ
         kYfq1YSsRA7vztJssAUPj1YJOPx8MKfUmjN+pCl3C9cCms29GiRcVXMY1z6TR8+LCZDQ
         HcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759291; x=1731364091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJTHsOFb69amuDKNp+L1s7mL9nLva+h50iWgGzl+suk=;
        b=lwmkAuDRUiYzzYWlHp16ySyo7I+ZoHhIv4+2VM7a82GAd82/w8DkiLz1Ss+NArwuBH
         Hito/qOSTXkpw68G7kiuiBT0C+N2EJtxZVUchNSJtVTqTGPvgA+3Mg/WKHvKCToMs6RW
         Y8uouS99Rjo8fnscnsg2bwCo9FfdEez+atfjKnBJifLJztzOzDCTQdSrlT28WdMlDs5Z
         rc4UW9v4OhgQVDijWqRIkdd8Cktn6t619HY+mRQ5c42Y971jHtePYQRPUFBB0S18SnEX
         IYgyhhXyj9Zfgkxy826BnnAvaXn6pvpj1bg5Xaltnmemvr0l7YFvcrzgB/sOLOjkQrcT
         Knkg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Hfzq+NoThWGc57e3LCB87rjW+QDzVmNQFnOMv9YPoMW84sGIXhGDG5Oi9mui9fBNtqP68rLfyQCbunU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCUc9Js1Pm3jrwOZPSqP6oiFhes3pVcdu+DwxI69/iV5NvPM5
	KSa2hjF3g9OQH1bnOYwVpf1Ai27L/W9rd6ug9ceGG5eURhrAlG60QJyW261dMz+WFMykDICi9Jv
	fh5bMeYpkSw==
X-Google-Smtp-Source: AGHT+IEg/gpZS2Wwa740IUzym+/kFOc+iN2HO8l3hmsWV/sKpXe65l+xXYWOwxm8vBrp8FmpwtXAU3uOAkOjqA==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:2520:b863:90ba:85bc])
 (user=kerensun job=sendgmr) by 2002:a05:6902:1d1:b0:e2e:3031:3f0c with SMTP
 id 3f1490d57ef6-e30e5b0ee45mr11671276.7.1730759291389; Mon, 04 Nov 2024
 14:28:11 -0800 (PST)
Date: Mon,  4 Nov 2024 14:27:36 -0800
In-Reply-To: <20241104222737.298130-1-kerensun@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104222737.298130-1-kerensun@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241104222737.298130-4-kerensun@google.com>
Subject: [PATCH 3/4] mm: Prefer 'unsigned int' to bare use of 'unsigned'
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

Change the param 'mode' from type 'unsigned' to 'unsigned int' in
memcg_event_wake() and memcg_oom_wake_function(), and for the param
'nid' in VM_BUG_ON().

Signed-off-by: Keren Sun <kerensun@google.com>
---
 mm/memcontrol-v1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 5f9d3d6d443c..5e1854623824 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1851,7 +1851,7 @@ static void memcg_event_remove(struct work_struct *work)
  *
  * Called with wqh->lock held and interrupts disabled.
  */
-static int memcg_event_wake(wait_queue_entry_t *wait, unsigned mode,
+static int memcg_event_wake(wait_queue_entry_t *wait, unsigned int mode,
 			    int sync, void *key)
 {
 	struct mem_cgroup_event *event =
@@ -2165,7 +2165,7 @@ struct oom_wait_info {
 };
 
 static int memcg_oom_wake_function(wait_queue_entry_t *wait,
-	unsigned mode, int sync, void *arg)
+	unsigned int mode, int sync, void *arg)
 {
 	struct mem_cgroup *wake_memcg = (struct mem_cgroup *)arg;
 	struct mem_cgroup *oom_wait_memcg;
@@ -2598,7 +2598,7 @@ static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 	unsigned long nr = 0;
 	enum lru_list lru;
 
-	VM_BUG_ON((unsigned)nid >= nr_node_ids);
+	VM_BUG_ON((unsigned int)nid >= nr_node_ids);
 
 	for_each_lru(lru) {
 		if (!(BIT(lru) & lru_mask))
-- 
2.47.0.163.g1226f6d8fa-goog


