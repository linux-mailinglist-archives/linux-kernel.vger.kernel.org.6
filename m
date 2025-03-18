Return-Path: <linux-kernel+bounces-566738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E27A67BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F9A18929D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7DC1C9B97;
	Tue, 18 Mar 2025 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMH8hq2L"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251E20322;
	Tue, 18 Mar 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322632; cv=none; b=GcB226UKazJvpIpzSG4XoMlbM6506OE3M8GkpnIyi+UXmkAaqGacQWKTT6YJp0jh0I5k8yvp9HFXC0vB6VveC22H+zrtXEtufVi5uItSwJyDhc0I19w+nQHR7D4jmoakxCkKqmQM5OqPk1AsKS/WwRXW8LBhh6SdlX4QToLJoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322632; c=relaxed/simple;
	bh=i5OfEoSljC+HbbhTACIKKpTdq1guqyC/ApD6p8ex79s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMT695iO37rDfvc1SYcu6S/h+yqNC6kSJ+1FDafD3O1qaHasoOsM9g3oEL2ifCml6H1fS5XGHeB4QznvdTYuYr487vyFZqvttV55dJEIkDTvsUe4AhZIjPPKEJtJQPl1uF1uRRZWEnxuogdgkIqlfscYHqKZ7V4flyNAOGDKZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMH8hq2L; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f74b78df93so60548627b3.0;
        Tue, 18 Mar 2025 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742322630; x=1742927430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNwhYyHLUku5wWb6XEn1vDwJORz/NTg7eokwpgJAoks=;
        b=MMH8hq2L86d0SuwKGkFyvv0Tuew6PTM6Nsedq+oaIrgZXTOswE1vetfmLKbOPKjkn6
         wfJd+ED5VN7Mbqh9RY+NP4J4BL4il6ABpN8EFEA2w6ihSqcsXFG5W0AgIX2ltlOVHxLY
         VlgL5GhenoQR4UhoAQsXLjsDZ9VDx+SBSkTi6hXmRSRbfQdU6/yw6LKXRcPfutKKy3Hi
         i5IIaxhpc+qSIbzx9gnYm7DZBZqFI1bIlc09DUG1Tps+saNDWehQn8MlhZfyxoD7ozXQ
         bDzhaiEj2LLLcdyVBZw1WemJzXCP0tDQhyILsqpe+2pulwFjGma0JOPksmn7K8QOY2IX
         TliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322630; x=1742927430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNwhYyHLUku5wWb6XEn1vDwJORz/NTg7eokwpgJAoks=;
        b=qtgmQAoe5Dp4+kgxR+OeK9c0Wsfbqq+5DTYaVoNZ1ysuD9ufSR3SRxRoZr3UY1FTVZ
         GbcK+DUCUv4/uDbSlhxFenUEILQNPE3fLEsY//Pgs48gVv1HBRol4iDaSabxhFncJ/kH
         mR+JEBO6QehqnQu7rUTCJ3hcYP0PvPP21PqMSQ1LSJ1B4Nzz/beT2L7ffY+52ilsyi+t
         eOO+hK+W9siAqlYkxXrKaaGw3zdaUZKVGNsZFe0Z4qRgWCCIwvqrC13QNnmH+IoGEl5J
         9YiLu9+792Jg0iRsksh0bUP+fQxihivQO+zy1DIE0wTOzRLlG+iwfo13rXaqR4/ya/4x
         /iUg==
X-Forwarded-Encrypted: i=1; AJvYcCVXvX5LnG/GWT/4eICZ6eYORlr76sUnZX1QH5GwjE6jfVxQYz/t00gdV5MIUwj5TI98TSEAPxvMR6o=@vger.kernel.org, AJvYcCVrTViF4yDUHg78EpcaedLYF+ei1hlTJtCndQaW0qUVmCidbwz8eDgNZiu5SVL+4saWtT5BYtRR430ATqW/@vger.kernel.org
X-Gm-Message-State: AOJu0YyD3tYdIdxGcVUKRgaOa41msUoWkFH9GV+nuqBSCf9y1yRMcQID
	3bMrdwphdAPDL29o0qi5jEwDY28kGfkeXcS9Y64bEk6ImpsCWlCpziR6Qg==
X-Gm-Gg: ASbGncuf+9z4UG/v+uIYiHSRSTkqcTaG2+mFw1rEpfXek5jQqOS5La30NM8uAgwnk+w
	GkLMnSY7ixmpqoTMyL7QZK9GwvSLee5zgZGVMw78IgSCWSQPJe19yuABq5iy8OEF3b5XnYvO9ZO
	k2fcuZ/4aGZJ/1FtjEnlhWnDC5uQp2M5NuqVGPGVyg+8G8WcLST7r2tm5aWGt7vkTQVa4r1Lhjh
	5puXJhLRj/s5OLh9sG9oyGZqAR6mGb3JJiDipzcHKReWr4NYs9xR1KPv41MlaiRRo1EB8WUrY4B
	XQB1ln4qE3VBGc7LAVc74WDJDpC1oWi8uLYW
X-Google-Smtp-Source: AGHT+IE4IZmkYAr1CYhWXfFj7jyE8tpcUyeBW1sCfCwj6z7X4tNm2KMPObQ5RHcAkj4MPiAxgpoWHA==
X-Received: by 2002:a05:690c:9985:b0:6ff:1fac:c4fc with SMTP id 00721157ae682-6ff460f42ccmr234534797b3.37.1742322630047;
        Tue, 18 Mar 2025 11:30:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm27095807b3.111.2025.03.18.11.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:30:29 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: sj@kernel.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH 0/2] mm/damon: introduce DAMOS filter type for active pages
Date: Tue, 18 Mar 2025 11:30:27 -0700
Message-ID: <20250318183029.2062917-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory reclaim algorithm categorizes pages into active and inactive
lists, separately for file and anon pages. The system's performance
relies heavily on the (relative and absolute) accuracy of this
categorization.

This patch series add a new DAMOS filter for pages' activeness, giving
us visibility into the access frequency of the pages on each list. This
insight can help us diagnose issues with the active-inactive balancing
dynamics, and make decisions to optimize reclaim efficiency and memory
utilization.

For instance, we might decide to enable DAMON_LRU_SORT, if we find that
there are pages on the active list that are infrequently accessed, or
less frequently accessed than pages on the inactive list.

Nhat Pham (2):
  mm/damon: implement a new DAMOS filter type for active pages
  Docs/mm/damon/design: document active DAMOS filter type

 Documentation/mm/damon/design.rst | 2 ++
 include/linux/damon.h             | 2 ++
 mm/damon/paddr.c                  | 3 +++
 mm/damon/sysfs-schemes.c          | 1 +
 4 files changed, 8 insertions(+)


base-commit: 40caf747267c18b6206e26a37d6ea6b695236c11
-- 
2.47.1

