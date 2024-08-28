Return-Path: <linux-kernel+bounces-305348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33C962D48
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF321C216C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E117A1A4AD7;
	Wed, 28 Aug 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+q6JVi1"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE11A3BC3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861236; cv=none; b=ZBlAy33DhahOfHeWcxuSsiwufsygagJR77X0KKPAv6Hj1Q1gZZXqu9z2//Q292as3bbFOD6MBN1J4/dbcEGJbL/8MktdFGlt0b7QqB/qFjnaMunrl31x2LuFWlM/n303hXUZ7Z5mbKWQCTrPkB6iRs3DOnkB9LuNUq8j42GpRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861236; c=relaxed/simple;
	bh=ogjixKCi0r/DBOI/VYJEZdn8u1A0NUryYdI2bW6phTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZeviPOXXv5qqDsQj7xAUShUHdL0PR5wYTW5BRslODXxBOjA4llubz/aZS9QZ0D7HZWsCVRBfNLimRtDTf3muGn9re7fN9atUXevwGZ0PWtw7j12iZH5Sp8dLK9PEBgqDATWeuWf4x0DTjpZWy4sFuRbgA4+swebuniceZ1sZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+q6JVi1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42816ca782dso60854485e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724861233; x=1725466033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbU2BXq1tnO79gtv2UE1RsIiJczZ+KcvBGQej5bOV3o=;
        b=a+q6JVi1aSKfZDlRlM8SRIuh74tCO4XXVq6kXKyLFqeoGsmRyhReU11YBp7Ti2LLho
         axXE3EtiG5d30cKWwMdF8FeJlPCq81XHJ6R3n+eH27wlJ4sFlmOsvINEFkKBMccz3fuc
         2aW0pxgJPlkskjOg4YiKuOGZK00WlYeE3qflONvB2L/4rsW+VA+zNt8XfVaXRP7Esmc6
         mmLhY5JI5mAYTvlPlncGLwWKvJDsCVThV6S3eVhWlDbFgrASQMa5pWW498FhMy+K1YUk
         64kG/qZaYBLAPJdCVMXMZYfu3LeK/IF6ooXkbu/7jnmJT76IrwRFm0gTA9em31J5c8Ns
         27Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724861233; x=1725466033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbU2BXq1tnO79gtv2UE1RsIiJczZ+KcvBGQej5bOV3o=;
        b=J2vPuORmz8u0uNl/EUHYLeA5Q289FlkH/hNrVxFSEFH+Y+xfkT3CYZPPFl2wQ9hzmS
         GSGmt56ZTQNaeWoCKgZM0DtYt3dy9Xplz+w4+c+Y1vo0eiLFKub+vFoK6qKu/ykpaeaT
         1t3zKcKOlPJPRuYNm3wt6rOQ6TM2p0FRutpOUW6DGWKcSnVEFCFUanND0mycfOSYX71e
         Q0s46bOnqsTbnaKAkupMDnJRVXK/pjVuXaCN1fe3eD50PCAYxPieuT4T0LDwiQHpAhAN
         A1+w3UZOTsyBXDamgutga1THBmIHEMsb4rkO0bL//a7CnNeE57M7AJDmyjbozBUoYSRO
         F8yA==
X-Forwarded-Encrypted: i=1; AJvYcCW57qZB+m+cCXGHFAmsRuDpGCoghkZzWMosD3UcTCxTSsxcjns+/0CjaNTCDP+x3pmsN4m3/UKZn/jOL1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTkJa5Kf6EgUkKV16g5CKTEBJWN38h1iNJx09o8eMCSTLRZWqk
	kC02dwRAaL+nUefXGOe+xokF+gGuN+n9k6UWyBBsa7yUolZ8MEW2
X-Google-Smtp-Source: AGHT+IFteIv+aolP5lnxf71eCn1tlHkqiGzGQK6pUQ8+qbIIZfyL0r3ZwDrw7p4y6iw4futlBlj46Q==
X-Received: by 2002:a05:600c:4586:b0:42a:b62c:8c86 with SMTP id 5b1f17b1804b1-42bb02f95b6mr1077395e9.32.1724861232380;
        Wed, 28 Aug 2024 09:07:12 -0700 (PDT)
Received: from f.. (cst-prg-86-203.cust.vodafone.cz. [46.135.86.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749b22db16sm157598f8f.5.2024.08.28.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:07:11 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: dave@stgolabs.net,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] mm/hugetlb: sort out global lock annotations
Date: Wed, 28 Aug 2024 18:07:04 +0200
Message-ID: <20240828160704.1425767-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mutex array pointer shares a cacheline with the spinlock:
ffffffff84187480 B hugetlb_fault_mutex_table
ffffffff84187488 B hugetlb_lock

This is because the former is annotated with a macro forcing cacheline
alignment. I suspect it was meant to be the variant which on top of it
makes sure the object does not share the cacheline with anyone.

Since array pointer itself is de facto read-only such an annotation does
not make sense there anyway. Instead mark it __ro_after_init along with
the size var.

Do however move the spinlock out of the way.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I did not benchmark any of it, looks like basic sanity to me.

This came up as a side effect of an unrelated discussion.

 mm/hugetlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4461d27f7453..1a833f016847 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -72,14 +72,14 @@ static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
  * free_huge_pages, and surplus_huge_pages.
  */
-DEFINE_SPINLOCK(hugetlb_lock);
+__cacheline_aligned_in_smp DEFINE_SPINLOCK(hugetlb_lock);
 
 /*
  * Serializes faults on the same logical page.  This is used to
  * prevent spurious OOMs when the hugepage pool is fully utilized.
  */
-static int num_fault_mutexes;
-struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
+static __ro_after_init int num_fault_mutexes;
+__ro_after_init struct mutex *hugetlb_fault_mutex_table;
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
-- 
2.43.0


