Return-Path: <linux-kernel+bounces-371203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 409BA9A37DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0BCB23CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE1918C337;
	Fri, 18 Oct 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HklbUGo2"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF681442F4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238283; cv=none; b=dSprQL/76tZiTJaV2MUyzpo+CiYKgFfSdqQN9B3/SeoFJ6JmtVfCfum999Y2n7DPZkDVcULl21SlqQAa/3k177DIhUAA1iA5hHf/i6E76xl38Khp1pBMxJfIlVwNCuWEPflPXzbeGmJIGk3qhygdfjm7egHn3vVvCAiFfgtKwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238283; c=relaxed/simple;
	bh=Ti5gna2oLMfSpkSXoyf0MAGF7yyXdcwXsWLmGTNSOeM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=X584I0nVelKwYjYCjhbtna0EdxY5g/nBrk0RFOIWuHWIQzyzVCihtTiQVOdbVDttrDTvUyjJRo0uD9emvHTXCrlrRKVBAXTzTPH8osNFaySFiPvc/tDyVjUtLbZQFSTLCCGlxmHCVmbeAWOA7agCbTXFfSBTzeN5C68yJGdbVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HklbUGo2; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db54269325so1462986a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729238281; x=1729843081; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Drm6GSMszdRwDqRBijgtPROGYu2UjXAmF0Jy5tagAhk=;
        b=HklbUGo2LWygtUllbQ9Sd2Pj0vb2vdPWfZDPbnfdftDRBg7dbd4mi6aQkkNJ18pmJ1
         UYWMBQhDgVZFtzf+N6Z/XNhx9n7uGZnnFVCCD7rPtCR2lRqSQ2mCT2U8VUU7VkfQAjiS
         6fhx0bu3GzGjviQHSR7ARTPV4oBt3prggOi4AibSHaY/cTHhr2Hy67NxHvG2HNUWhGsZ
         D9b01fiCS/+5cXr8hfGk+bhwqyoXrqOpm6kyQRbazr97GXdDKSyl/6S7nqfK9heTmxA7
         o6fSAbtAgnfPTZ9JRSP2/r5V1CyVcUzZu8FcmGzixEhcEUQ5SMyRAAWtCylMLTIgWb9f
         cMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729238281; x=1729843081;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Drm6GSMszdRwDqRBijgtPROGYu2UjXAmF0Jy5tagAhk=;
        b=Zh8ieUSY1p4I5y9rmMoWRRtJY+UHmY/3qZBzXB6JeMkG9n04WgDFD7DDYbkoCc1QB4
         9aiXw3v1LTn6fyllG8oQHG8GHY1uK64o4mVfB6QB/cRnxkLtuKqgR2HmsN96nv4oQaV/
         oi9FZeuqwoqTSyK96t+hh7/nsrpLZFP2/Q7yj22qTekUrNvXgyVXEd0q3wapgSL4XZvw
         5od0IwYJVJmQF+4bpMxuGr2qC5XKMd7OF5yqXRP5SuFHDija/IC9fIpBx6qnAlDu8kSc
         SoBXL93Qq/pUG9PE3AXuCrH+gXFr8WV+sAEgL+fEtsJeY3jodLQfvFX3OBFHGdeP27sp
         tUPA==
X-Forwarded-Encrypted: i=1; AJvYcCXzFT4E9Dok+TkV0VurEcvSx7J+/Bxypgw5MdY9H63ADcNqdJdWmcbPSWr5TUwyuK7sp+m9nsEOOvUaqzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytrYAbYxZoeThMDRjVusOvBW1eHr/1EkotiuXhtVl2PxV+3IsT
	PUaboGTtdYDdSu2I6nF8nz0g8U0jCpI9UbyWAiDr8FdEL7VidCL9
X-Google-Smtp-Source: AGHT+IG4zD6/7f12yR/mjUbybtqozcn/vgZSk2HbLlusGBxbrjzCt4vXo/MKgYMbufIpewVJGmwk8A==
X-Received: by 2002:a05:6a21:4d8c:b0:1d9:1fac:7256 with SMTP id adf61e73a8af0-1d92c52a598mr2108382637.30.1729238280938;
        Fri, 18 Oct 2024 00:58:00 -0700 (PDT)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d7970f4sm1290248a91.5.2024.10.18.00.58.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2024 00:58:00 -0700 (PDT)
From: mengensun88@gmail.com
X-Google-Original-From: mengensun@tencent.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	alexjlzheng@tencent.com,
	MengEn Sun <mengensun@tencent.com>
Subject: [PATCH linux-mm v2] mm: make pcp_decay_high working better with NOHZ full
Date: Fri, 18 Oct 2024 15:57:57 +0800
Message-Id: <1729238277-26683-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: MengEn Sun <mengensun@tencent.com>

When a cpu entring NOHZ full, quiet_vmstat may flush percpu
zonestats and nodestats.

The vmstat_shepherd only check percpu zonestats and nodestats
to determine whether it is necessary to fire vmstat_update on
the target cpu for now.

If a process on a certain CPU allocates a large amount of memory,
then frees that memory, and subsequently the CPU enters NOHZ, and
the process not freeing and allocating memory anymore,the
vmstat_update not being executed on the cpu. Because
vmstat_shepherd may not see zonestats and nodestats of the cpu
changed, so may resulting in vmstat_update on the cpu not fired
for a long time.

While, This seems to be fine:
- if freeing and allocating memory occur later, it may the
  high_max may be adjust automatically
- If memory is tight, the memory reclamation process will
  release the pcp

Whatever, we make vmstat_shepherd to checking whether we need
decay pcp high_max, and fire pcp_decay_high early if we need.

Fixes: 51a755c56dc0 ("mm: tune PCP high automatically")
Reviewed-by: Jinliang Zheng <alexjlzheng@tencent.com>
Signed-off-by: MengEn Sun <mengensun@tencent.com>
---
changelog:
v1: https://lore.kernel.org/lkml/20241012154328.015f57635566485ad60712f3@linux-foundation.org/T/#t
v2: Make the commit message clearer by adding some comments.
---
 mm/vmstat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1917c034c045..07b494b06872 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2024,8 +2024,17 @@ static bool need_update(int cpu)
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
+		struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 		struct per_cpu_nodestat *n;
 
+		/* per_cpu_nodestats and per_cpu_zonestats maybe flush when cpu
+		 * entering NOHZ full, see quiet_vmstat. so, we check pcp
+		 * high_{min,max} to determine whether it is necessary to run
+		 * decay_pcp_high on the corresponding CPU
+		 */
+		if (pcp->high_max > pcp->high_min)
+			return true;
+
 		/*
 		 * The fast way of checking if there are any vmstat diffs.
 		 */
-- 
2.43.5


