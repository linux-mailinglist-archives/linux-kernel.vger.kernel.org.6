Return-Path: <linux-kernel+bounces-439196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388789EAC14
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C964128E4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7E210F7F;
	Tue, 10 Dec 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnMj7rKQ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E55199E9D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822945; cv=none; b=ruykzMu7DEBf5LbEkCCiYhXwIJNZ4TgSmhZght4QE/Q1ruFrUt7PvkjljHleuAWMqqpbAn/I+4wwkTInzfpLpsJ/joFWz9ltYqSbXE78XD88r3Kh1Qpxn9Hz1MfItY1Hl4i6/VooTVz64chpx2UFexHOYPecid4h4Ty44YCwhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822945; c=relaxed/simple;
	bh=pzeupsIj270sR+W/PqVPJ7qfiPRVogiciKRbC2tMwiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMLgepeoAs8nzfy5Cbb9vh3cxMuDHY/+VE7GzW1T6cIBQUWcfyYBFUHQirYNs77dAYAxi4nLd96u5YOY6eoJKcDOyTriAImHXBooyhbIHDbeR+U9L/M+vD7ZUJeuj78zAcM39+2J1w5Lm/tk/hoZ3ghO3xwZc3WCjBaR4nQFn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnMj7rKQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so4245931a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733822942; x=1734427742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XXPbw4CmFZlsHQ1dqNkun8nNSKspNNgSNNzQzzqG5eQ=;
        b=hnMj7rKQxG+qzeThcV/jbgjNtNADgjURDCduYPH8DV0Xk0Zz21ebuasXtgQj4HdrKy
         FKU8tUlFV9aPhwesiNktqN+pklQTa2qVBGcJKGesqBitGp5a+IF6bo8wav8aaHOjGmo3
         Enor/86MWD8v6+8r2q7LltvyysKMGglJ4n5VoU2ODq6UdCFYYuOK4WpXvkFvRakJEVfR
         WX166/G+CVNGvf+lGQ7nzPRqrbsVXa3X6DKk47cLNZlHNcnTSq4luR8KgifEGTwLVXzu
         lyESFJozkMK4yBb4cQH77G6lDO87Q7tQpP2tdYDwEZVTpWRfiofRc9+luQAMkWMeb1gd
         vGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822942; x=1734427742;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXPbw4CmFZlsHQ1dqNkun8nNSKspNNgSNNzQzzqG5eQ=;
        b=MG9xLxuh3BsQEflfMrEEV9KohDHcVmO04k7XHtZqqF1desdiBkuE26u5FGdtNIESkr
         hEDuhCAIXRQBd3kEHA6IhhK2q7tYsYr9drrjgMUTJn9V9vpiSwC8bY4w1t2xnKesxcK5
         Vx6MPP70dFBgUZCkSKK54Y2kYkAmDgLDzPq4/2dogBFMrZDrsrg0JiCKpThgtNC4RZWd
         p9OGL6fqC3zUpchFeyqeRx+BSAcQNAW1eDp9yO4ju8UBmNRStJ3jQx9LJMbFDBBMEtqu
         2hzxd9k+awN9ph1wK7emchmgIgEABJPEzWuwcBjfQa1Gyn81fSe4U0MT41j/6f18NLWP
         6q9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLXK1WFchmRlqgWfsDySzQeGL632KV8ZWESttEvXkllvkznORQTrHBFopiWbCK70BsDQn9UogQmJVRU4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyde8kSdvEn0lT8u4uHatktrSZU46XFQqL2jqJCyq0mOzgEtM7y
	i1NPbj70+tX7PjYSElytqtanIusWACzUJDq3Xp2NGPm7fRoaMUUQ
X-Gm-Gg: ASbGncuLURhoAXyLNC/n43L0QDiYX7v0GR8MkNrJWRQtmmCEMhc1IH8H2ISdKT7qtTu
	MyPTOQq6l1g8eE78cVpKb4Q/8+G1FEM2kERx2+d0kvvnF5Qf+l+vpMlldwOYDAvPyj3v6L0V0zW
	6tVPfX9CBS10NCGbCfL+CAkCUxU0ANbgocwn2jrvvrJK+9WziiJGqsOq3mxqCYx+yQH6UJpqeqR
	ASX388uG7u+81lU0qNG+vwTBRci0M4OxFv8yiMmECnUxlns9CnHYasVM3FXGOBUzP4XKm//hEYx
	9/uIrvtL
X-Google-Smtp-Source: AGHT+IHMU7qNZnjZ/bkeJFqL1owhrOCa0EJiXmL8JTWuT/MSJlktqTs5oyZfJOCFQItybeRNzpjntg==
X-Received: by 2002:a17:90b:5184:b0:2ea:4c8d:c7a2 with SMTP id 98e67ed59e1d1-2ef6ab0d5b6mr24092612a91.24.1733822942554;
        Tue, 10 Dec 2024 01:29:02 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1568f26asm8750095a12.9.2024.12.10.01.28.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Dec 2024 01:29:01 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 1/3] mm, memcontrol: avoid duplicated memcg enable check
Date: Tue, 10 Dec 2024 17:28:03 +0800
Message-ID: <20241210092805.87281-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210092805.87281-1-ryncsn@gmail.com>
References: <20241210092805.87281-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

mem_cgroup_uncharge_swap() includes a mem_cgroup_disabled() check,
so the caller doesn't need to check that.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Chris Li <chrisl@kernel.org>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..79900a486ed1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4609,7 +4609,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	 * correspond 1:1 to page and swap slot lifetimes: we charge the
 	 * page to memory here, and uncharge swap when the slot is freed.
 	 */
-	if (!mem_cgroup_disabled() && do_memsw_account()) {
+	if (do_memsw_account()) {
 		/*
 		 * The swap entry might not get freed for a long time,
 		 * let's not wait for it.  The page already received a
-- 
2.47.1


