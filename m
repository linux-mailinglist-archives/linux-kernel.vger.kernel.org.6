Return-Path: <linux-kernel+bounces-439198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30129EAC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746C7161F80
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA357223309;
	Tue, 10 Dec 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH/aqBN0"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9F215771
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822948; cv=none; b=WvXjVyf9jCHOiaOvC9U0ka6ekQeMZCtQbHjJICtgdHOhiGFgmism0ZAzkhpT0ssIPs27tLJAf5u6h6sWUNMizDmHjD0wXKz3SdA2t6oEEjjNJtl9EAg3UFf7cnHUX+cgEklwk4OodzbHwm13huYTjkSb9uCoE/vboOqlceXZukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822948; c=relaxed/simple;
	bh=hOZ5NlNngeRjH8z8G2TqenUNXh7uBbdu8kbCPeD0Q80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXewW41fx5ddKWYRvqhokQrnLtE1Z1wRi8DdYOztwpSlV/cAn77CajyFmoHGp910gZJ7xWGn54Kg2uBgMRpuM5ygjk8ddp0M26Bg+unMHMvLjCqyGKf6VhRIvHcJL8irbtdTMBgClZsO4oRoJdl/LXAypwdpHOC8M2pBHjb2Fl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH/aqBN0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725d9f57d90so1938461b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733822946; x=1734427746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BSCLGHYqLWfZbOCM52YJejtZzzMrW+w4kb+fWMx8dAg=;
        b=BH/aqBN0nh092+HSFm1B7czHT3mUDytnmw+cV0hKHiWzhPvVmSqIL0dWrn5OYa4DAK
         smjDXJSU8bM0dQENBWxQSHrG3mIL3qGV3yPe7xUF8vxoQckdmPxmzcumKT0+vs7YXHIb
         GyG0eTaUySExEDLouNeYgwt3kyVu0j9XF08V0IHU17qHqUnulsNFRLlYymZuzJLWiyBd
         PXBsItwmGVb72prT99dANLpjZu7/t97IwS0bCnc4chbbByXjigXDP4Dxffj3M+6rTWGE
         lyF5seba+y17tA4XgxTvgvRU8C7w725FDDIe0/I6CVh6cOM8eLM79cAGecVM6dWEOToS
         fwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822946; x=1734427746;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSCLGHYqLWfZbOCM52YJejtZzzMrW+w4kb+fWMx8dAg=;
        b=ePqvgG0H71HOZ8ki2Q0sPQLf0U/bF4ZcTD9h6fespgpOeuuE17+Y8XuKsT613MmVjy
         dvWJmcgmNXTbgp5bBq5M4G2JLyNv7K5GqUKNY6aGd9ieZ2RGeUJQJjCk/fhs+CcnxLMk
         ecNeqQ2bMfz/ejiUiMmoiGFnqKc7xiBLsp7U1GYOYNexV2NQ+0edi0xR+S7BOV+ppjsd
         TI3IVu2D7SCzv7zc9AN90i9JCiLA5mPe/LT5vD5pq4uf3d/FljVpqKNhUWEvWAi7xgH8
         5qI4nAPfNGOJGrEqnYRTPyQcmOXAZzftgyoZ1au23KHSZTFOvsZdsAbZLJFDCm18dNgM
         S0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbEKrQg4rBVnQ4Fz7jWRud7BTzJ44cs4LWiRDiSeIyD5CfIk90A83TtRXEzGTvlFuYeNBekwQO+Et3UWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLwv0sf4G7rKPqMEmb1+Pla/VnPuPyQXKFSvpv52eMCh8n7Dc
	WtML7DM5Mf3rZ0tYBdSpFPVtOhVSZyapmXCnNWl02K6M/Mv6QUDx
X-Gm-Gg: ASbGnctIj62xEu2pF9R09y0xlnLA6YSuRuUz30Yyfeqol0/3u3NckQAdj5liGsDLE12
	DGIIxGFBYG+jd4+ZOw6CM9ET0aHu1cjBGimNOGIFE2jP1FBTh+sLz0NTe35RZtCBJ6z8XMXP3F0
	5OHFbAyHgBNar+dwtGDjia2k+vMTJYZcuI7kunLF0zI21bBQtItswiSfHQZ1UORnRuYGh8r9Elr
	GfpXdklwcliRon3IZCgoAlefB7dGqbCtjVPJqmLXI3E6ybTphgf8t28/l3jd4OTkH5iGR5q/Rqn
	gz7eKIu5
X-Google-Smtp-Source: AGHT+IHV3lqRAPpmlMOBZuYBAiL3Q5xtUsfeTC5YD+b1WYrzaAKgKUOsPSV0U0jw1or5OftGfUdPEw==
X-Received: by 2002:a05:6a21:78c:b0:1db:ed8a:a607 with SMTP id adf61e73a8af0-1e1870bd7a6mr23599578637.11.1733822946475;
        Tue, 10 Dec 2024 01:29:06 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1568f26asm8750095a12.9.2024.12.10.01.29.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Dec 2024 01:29:05 -0800 (PST)
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
Subject: [PATCH v2 2/3] mm/swap_cgroup: remove swap_cgroup_cmpxchg
Date: Tue, 10 Dec 2024 17:28:04 +0800
Message-ID: <20241210092805.87281-3-ryncsn@gmail.com>
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

This function is never used after commit 6b611388b626
("memcg-v1: remove charge move code").

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Chris Li <chrisl@kernel.org>
---
 include/linux/swap_cgroup.h |  2 --
 mm/swap_cgroup.c            | 29 -----------------------------
 2 files changed, 31 deletions(-)

diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
index ae73a87775b3..d521ad1c4164 100644
--- a/include/linux/swap_cgroup.h
+++ b/include/linux/swap_cgroup.h
@@ -6,8 +6,6 @@
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
 
-extern unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
-					unsigned short old, unsigned short new);
 extern unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
 					 unsigned int nr_ents);
 extern unsigned short lookup_swap_cgroup_id(swp_entry_t ent);
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index f63d1aa072a1..1770b076f6b7 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -45,35 +45,6 @@ static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
 	return &ctrl->map[offset];
 }
 
-/**
- * swap_cgroup_cmpxchg - cmpxchg mem_cgroup's id for this swp_entry.
- * @ent: swap entry to be cmpxchged
- * @old: old id
- * @new: new id
- *
- * Returns old id at success, 0 at failure.
- * (There is no mem_cgroup using 0 as its id)
- */
-unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
-					unsigned short old, unsigned short new)
-{
-	struct swap_cgroup_ctrl *ctrl;
-	struct swap_cgroup *sc;
-	unsigned long flags;
-	unsigned short retval;
-
-	sc = lookup_swap_cgroup(ent, &ctrl);
-
-	spin_lock_irqsave(&ctrl->lock, flags);
-	retval = sc->id;
-	if (retval == old)
-		sc->id = new;
-	else
-		retval = 0;
-	spin_unlock_irqrestore(&ctrl->lock, flags);
-	return retval;
-}
-
 /**
  * swap_cgroup_record - record mem_cgroup for a set of swap entries
  * @ent: the first swap entry to be recorded into
-- 
2.47.1


