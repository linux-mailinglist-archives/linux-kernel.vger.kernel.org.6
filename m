Return-Path: <linux-kernel+bounces-360940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B210299A186
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6291F219FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71EB20FABE;
	Fri, 11 Oct 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhXHsTmB"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE881E3DC0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642991; cv=none; b=vFldhQIRXeCBaRYoGxrmuOsXLQHhrWiUQ8vOn8kG0Gmrxer3AIumHQZGgeJR3j1c/3frYFyMFl2gS+GauJxDZeIzN9I4oV8aqN4R4DsKNvztDG59rusCnR7b6IgPwg/J3Lt2s/JDbWHUnULZ3NQTOEYXuqkc8emzAKpVUKjDKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642991; c=relaxed/simple;
	bh=EVmR+Fmg9FYNhCpLTAx6g5e7evdOdM4dPxNwN1bh6A0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozHOEshqpXpicAoxr6lsQRSYm7V3x+kcX/IaNFsDKDG506Aef7Lrf68d8+GbZqQR+RRP4LIytfMsiJK9ybTi8v9QgyQvxDvKJFM4RPPPxFj5xPx8AZ6Lzqy1Y/3+FYikHJQGtE5ZOvlp9EUMxlsneg4muApkM2RiZH9goShBqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhXHsTmB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2e23f2931so1082661a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728642989; x=1729247789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WeeyjeveEMxHGf8ZHXtt9KSJnd9K4LOjpG4HA7v12xU=;
        b=lhXHsTmBhu9H1PvlowTQ0pU6qZfUwwfImvWtxkySOkWQeP5PXIqCdyw99fJokyELXy
         fiJG5LEd3XHj3Xb9GWMXkpLW8MFYO6rA5RrUHOMC1NwcJ9eC8RDK8Te1fHt947eFO7WG
         wiaVE+c5dTXKCGXqXc+bGe71ndi21uGx2yw8+PRrI1uAKV/DHXapHCTe3fy4tazuEOdF
         fV4r1bYZFtATKg3de8soe0dZFdqMhNzEmfSkyv45jXNenl1NSrifo2VPS4ljE/ZJSKu8
         SFJgoRXxNjkYunuTmEBfZ0DXvh2rqdcI/PHnhD784/VFTr7SxSv1IZVmKUU73BZVThlc
         Im2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642989; x=1729247789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeeyjeveEMxHGf8ZHXtt9KSJnd9K4LOjpG4HA7v12xU=;
        b=fE7JD5wT9aW/dnk2EDOtAf9VjJXL6fOiJMGmAp8ADphqKBmUKEeVZdK7r6Kdm7iGfO
         fNd21IsX9RCAtoQpYaYkD48CYEP2EE93YJCQqDX+N6Yros6UKWYLO3PZM0ifbp+4VsKP
         22DsqQS+GMTX1RBUW5QXokAgOEja88zmnT2l/en+7OInxeFp+dkYbVJBXhwFrWrdwuNq
         e6xDoUjE5+Xv78xtEHqIuU9dJK7JdkrOBxP8mQXc8+bBJvSetiNm3/0hlFn3jeMwZVTX
         O1PlY62Pajo5hGHxWHd+h6iq+dHwbYv29vLroGDQzW8fVDCiIbZV2V8mvexeX80cYR66
         CzEg==
X-Forwarded-Encrypted: i=1; AJvYcCU3aJj4mkTayM8fZ7H6DUO4EE7iV0tEK/pOTv12A4Dq00OWxUMroPCA7200QdGY5iflbSTW7G60dZNmhuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznHv7+Q0ksQ/z3RrP5UNcTCReRNUPH3VJ/nVhzgLVDiJQv9gZt
	kWQwgcFhZVi5j0jWy5Fj6+QBNO4UD+rMPWndHoQ2PgmHfIVe3M9BumgiAAw6
X-Google-Smtp-Source: AGHT+IH8m6/2cucqCJrNv0+6/VSKuLfjNdMCRcGA7sJqcjDMQvMmg3o5/YZKWOWoM4OhyGN6DuZnxQ==
X-Received: by 2002:a17:90a:2dc4:b0:2e2:b41b:854e with SMTP id 98e67ed59e1d1-2e2f0b3c54dmr3186576a91.20.1728642989050;
        Fri, 11 Oct 2024 03:36:29 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2cc488249sm3178721a91.50.2024.10.11.03.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:36:28 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: mengensun@tencent.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	alexjlzheng@tencent.com,
	MengEn Sun <mengensun@tencent.com>
Subject: [PATCH] mm: make pcp decay work with onhz
Date: Fri, 11 Oct 2024 18:36:10 +0800
Message-Id: <20241011103609.1992042-1-mengensun@tencent.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: MengEn Sun <mengensun@tencent.com>

when a cpu stops tick, quiet_vmstat may flush all the per cpu
statistics counter.

while, the shepherd is needed those counters to kick the
vmstat_work.

when a cpu in nohz with a lot of pcp pages, and do not do page
allocating and freeing. the pcp pages of the cpu may not be hold
for a long time

we make shepherd keep a eye on the pcp high_min and high_max

Reviewed-by: Jinliang Zheng <alexjlzheng@tencent.com>
Signed-off-by: MengEn Sun <mengensun@tencent.com>
---
 mm/vmstat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1917c034c045..32768fb8f769 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2024,8 +2024,13 @@ static bool need_update(int cpu)
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
+		struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 		struct per_cpu_nodestat *n;
 
+		/* in onhz or nohz full make pcp decay work */
+		if (pcp->high_max > pcp->high_min)
+			return true;
+
 		/*
 		 * The fast way of checking if there are any vmstat diffs.
 		 */
-- 
2.43.5


