Return-Path: <linux-kernel+bounces-263069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA393D096
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97592281DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA0B178CCD;
	Fri, 26 Jul 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSO07mJr"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDC01EF01
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987240; cv=none; b=kfhBG3UBk0Y8GRwpHQwRwpezHVzOlP+vDq2Dz/SRnA5ohcOh+cMwh78iPLX6Ftmp1/06TtfHKeVTm2t4bLgdwbd3RHiPZ4YOTg9EcFDWB5w3lSE02d3kicWBkbrHSgdIGXpHOgL4d/VRieif/A6WofvdBe5Upnbxwml7zdkdouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987240; c=relaxed/simple;
	bh=hO9I+1EL0ym6IJbhpsqFzCYlpCQcinEzfKCa4f4gmOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxY5Vk8CAagRvdu9acCOkp26ivD+eahtMi39J9NK/4hetCBJMHT6fyvfgc1jl0WiAhZeJ8t0TAKYE7L1d9IaZHKQ9ps+LgFf8D6EoQ+a76FI+3bEr5iV8qyw2BDMPeF2idoWI5D1QCwBhWRW3Eb25GwG3upiwkQfB+7lizxzmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSO07mJr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd66cddd07so4125845ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721987238; x=1722592038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iStQPHQRdxqlUzAFxf7mNsjUptqesHyoCMxe2kJhC00=;
        b=FSO07mJrT5LRg58chJyyNPNyAL7cRAUO1V+K02pGQN4sUaFUpRXkH4BijT0fwM2h4y
         4MchUggMFLBl6u/6XzG6xUcNeimc4esn8NCPWhqmx1L2LFcQJFcXa3K5GkcGGlg4th0B
         qlRmqAtvOkh7KtWnlaGbbTXcmbcx45cNL5iZ2zJhP0oXKyT+Lv4nGop+luPEbz1L/kFY
         xQ34GZtXSSBGv2TG26/1cL2Cydi0dt95p0UTKX3HMG04he7jXSpseRF1Kn0aDx40wPZY
         gnqaNyDLGjvFklrhq2j/8Fo0j55OQjhImy3QOctx/zJs7d05t7m9pMg33ogFOmbwUwmw
         6w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721987238; x=1722592038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iStQPHQRdxqlUzAFxf7mNsjUptqesHyoCMxe2kJhC00=;
        b=qnhBMgou9/IBtUi7u6qjwJF+JuPq55CH0+347Ney8STQvJMbfAexkP56vevzCHRHdz
         wctwH5fgJ8vTVYut0PSktSt0mcOJcCioh0xAsEyxb1N1Mm9TQF3us/YqGHKv8XNHQNQ9
         m919NsS+G2eDY43WzU5vmQ//kO/+6MjP1AZu7Yp8+tVr9LDpjQGeiK2t4uilAjKn7nzb
         x2wSeQCexfSKpc2UukFnm3Vd54hmZkzWF/mBh2J72RRvpXUpifIRarXd8BFhfPJn2PTv
         Tg7D5B7XoVw1ln+aV82vSIaiYzfmHrSG6HyNpQlO3q23VomtrEqBRQa6vmRLxo88oFMd
         0Buw==
X-Forwarded-Encrypted: i=1; AJvYcCWbAfsLxk6XKxn6mXE2CI0vvofulxBYksgcljKsNu2HL8H07tZianrUJzkCVSPJ6jxSY8b0Qycv+nz5I0Evu3XQQsQEmQcIyo72TFwD
X-Gm-Message-State: AOJu0YyOuG3NmZ1a1yca5X7vKw27gfxtjiwO6YIfx9snO6EbUoOQJfTM
	+qaHhsFYUUfdXrvn5JgRYdinjNlxSjBJR2MYYMru7o8WjNwjsM/6
X-Google-Smtp-Source: AGHT+IFV2vyejBZHn0Sbv1/bTqARWkAYD5OnxGQx8g/+AtNmVatjTvFKeAc/Eg61DQwGNl7rxqQGzQ==
X-Received: by 2002:a17:903:18a:b0:1fd:6529:7447 with SMTP id d9443c01a7336-1fed389c064mr59497475ad.29.1721987237952;
        Fri, 26 Jul 2024 02:47:17 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d15e98sm28127455ad.99.2024.07.26.02.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 02:47:17 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: ying.huang@intel.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	yosryahmed@google.com
Subject: [PATCH v5 2/4] mm: Introduce mem_cgroup_swapin_uncharge_swap_nr() helper for large folios swap-in
Date: Fri, 26 Jul 2024 21:46:16 +1200
Message-Id: <20240726094618.401593-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726094618.401593-1-21cnbao@gmail.com>
References: <20240726094618.401593-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

With large folios swap-in, we might need to uncharge multiple entries
all together, it is better to introduce a helper for that.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/memcontrol.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1b79760af685..55958cbce61b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -684,6 +684,14 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
 
+static inline void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry, int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++, entry.val++)
+		mem_cgroup_swapin_uncharge_swap(entry);
+}
+
 void __mem_cgroup_uncharge(struct folio *folio);
 
 /**
@@ -1185,6 +1193,10 @@ static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 {
 }
 
+static inline void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry, int nr)
+{
+}
+
 static inline void mem_cgroup_uncharge(struct folio *folio)
 {
 }
-- 
2.34.1


