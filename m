Return-Path: <linux-kernel+bounces-543952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F265A4DBC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA2C189531D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626FF1FF7B3;
	Tue,  4 Mar 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="W5Ft+z9H"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F51D1FF601
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086215; cv=none; b=gI1Etq3GncWQi3pr/DPeAEB9HL+bAxoag72Swbu4NJ0coCFLvvU5ntPdkB8Ttx7y6tXYc7uaWMOrtx5v18ct3GLbEd0t40Zd2MznEnsp6588tpzSy7JpLWVrcPZVP1Htle/01FF/wPTpqWvEFS6CK9hyQbwSkFqZzQXUpCvOGNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086215; c=relaxed/simple;
	bh=wFr310lePl+3sCKMgYEpa1cVuDPHCXJAKPYyZiwfkrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iUikepKo5y5x3+e41fFRmU+cqw9TZLOBwCFVmmrxXVqsMqDpMP1fQz3bG7plEIIpMsMeLdVN7gMu5o/FMiHt2dWGa4M4lpIgID3OuNnTjsxcL0Q4PfV7Uf29BdTelAcMYH+LPIs+sTw33TyXufj5IxDJKtnckd2D8gKFLodQfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=W5Ft+z9H; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2235189adaeso88598995ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1741086213; x=1741691013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lES0apB7zPp5Y1gMLsCJ52oXjFeABBbwB1psLGF4yI=;
        b=W5Ft+z9HUGS6ScmyN3/pxQBoH1N4U4CJdER5cU6G7ZhjMdNEzwMBhZDi7k4Jlt73XX
         rXFFdDCEn+KoKcRodtnt/eMw5oC2hfJtgf1WP7cOGc6m5B4m0H7bL771mYSLNtpe964N
         3i5CyYv3zuroTYOWQvX87ku9hkfEZxhJbR8z/8hBtwO27t5RAASQdTrsffXo6MDIR/R0
         ZipgHZEeQ7Jka5xtAyOIg0UxstT01Mwf91hUpCUI/nDrCvT1BMdWNv3q6DhhcwcTnt37
         XoOH8D++XRBRUObPwiXnzWDT7G5hwIcH7d2D7/onRdj15wn8XezuH1LCwNGN9N5Yebos
         1ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086213; x=1741691013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lES0apB7zPp5Y1gMLsCJ52oXjFeABBbwB1psLGF4yI=;
        b=HZpqFnMRcXLreS9tjpNMg7PSKUd/XsX/7BgZ6aY3zuDkOPnTjO0By150qGp0VUd5er
         ygJkJSH9iIRNNbqAzoR1KaV3gv7UxHxZf1qhHkC3LBZTDemP4lmA/Mv9QjS9uzlnklhu
         0MvSusRQ/H3HR1eCf+Mjk5h6EeLOBnifnqQJWRSEnXc9AY4YeGjxDowvTPC9jXZI35N2
         Q2wRBjKuvMPCUoTLTfEB7B81fzX6GWgIfeP70BMUnIv57jr0r6H0MI/lZgqlqZFON0RZ
         vFoCeX4vFiYfYrqHgp+ZQaktxM0e0nUHQ7g7MMqosAt1ColkvE6lukHpYdw4FHcTKFDX
         1dPA==
X-Forwarded-Encrypted: i=1; AJvYcCXSPXCkbTsW6wldW333z0FCy+tXDHbZCB21D29OXGoetGgiKcJkizuAaYbJDcTXPVBMWE+A+DtSeUBadZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+g8GJfDwj6ffzuOdSYmM7oCW58x99F84xF7ZlVLcLax3jdNV
	jy/4aUL7i+DMEhV3/Cp/Nk9ytzGuKah3cNsrZpRbVJgQQfLjBLCSo38v4wXdHvs=
X-Gm-Gg: ASbGncsjXdBwunD62L8F0fpaObLlC/C5zvud9qJLdkVkty7AyYxqAs4VWfTT1e6i6R1
	yb94hDwZgHJvczDbEayRO8A3k9jI+ot6tjI8fWStMo7R8x5mFXqDe/sXQjwBS/c3TkyOW0tYD5j
	dqT4Zyl+jD6HJCTfLasRTCG0Au11U0MnIBRJ1rNUWLxtEUoB7o3e9DyV9+hRkbRJSv/oN7/ZcJi
	P2AnhG5ctt3HgIlm9MniB3i+c6XLlBZj38FtFuFEjDtCdcZiTJLDjoPhWnR5MfmNpKdp5oIifEC
	hQr5EYqqdToDak0Z8wpGvU2+dHUA/Q==
X-Google-Smtp-Source: AGHT+IEx0Bo+gN1RIbUhA8tGm6rA4iMJsFaRlXeDO7JP3HXXARwvvotVyI8kAbe7AiglMeVqNhDPfA==
X-Received: by 2002:a17:902:fc45:b0:221:2d4b:b4c6 with SMTP id d9443c01a7336-223d978eefdmr47027275ad.17.1741086213564;
        Tue, 04 Mar 2025 03:03:33 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2778sm92764415ad.36.2025.03.04.03.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:03:32 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	jack@suse.cz,
	brauner@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 2/3] writeback: Rename variables in trace_balance_dirty_pages()
Date: Tue,  4 Mar 2025 19:03:17 +0800
Message-Id: <20250304110318.159567-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250304110318.159567-1-yizhou.tang@shopee.com>
References: <20250304110318.159567-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Rename bdi_setpoint and bdi_dirty in the tracepoint to wb_setpoint and
wb_dirty, respectively. These changes were omitted by Tejun in the cgroup
writeback patchset.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 include/trace/events/writeback.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 3213b9023794..3046ca6b08ea 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -646,8 +646,8 @@ TRACE_EVENT(balance_dirty_pages,
 		__field(unsigned long,	limit)
 		__field(unsigned long,	setpoint)
 		__field(unsigned long,	dirty)
-		__field(unsigned long,	bdi_setpoint)
-		__field(unsigned long,	bdi_dirty)
+		__field(unsigned long,	wb_setpoint)
+		__field(unsigned long,	wb_dirty)
 		__field(unsigned long,	dirty_ratelimit)
 		__field(unsigned long,	task_ratelimit)
 		__field(unsigned int,	dirtied)
@@ -667,9 +667,9 @@ TRACE_EVENT(balance_dirty_pages,
 		__entry->setpoint	= (global_wb_domain.dirty_limit +
 						freerun) / 2;
 		__entry->dirty		= dtc->dirty;
-		__entry->bdi_setpoint	= __entry->setpoint *
+		__entry->wb_setpoint	= __entry->setpoint *
 						dtc->wb_thresh / (dtc->thresh + 1);
-		__entry->bdi_dirty	= dtc->wb_dirty;
+		__entry->wb_dirty	= dtc->wb_dirty;
 		__entry->dirty_ratelimit = KBps(dirty_ratelimit);
 		__entry->task_ratelimit	= KBps(task_ratelimit);
 		__entry->dirtied	= dirtied;
@@ -685,7 +685,7 @@ TRACE_EVENT(balance_dirty_pages,
 
 	TP_printk("bdi %s: "
 		  "limit=%lu setpoint=%lu dirty=%lu "
-		  "bdi_setpoint=%lu bdi_dirty=%lu "
+		  "wb_setpoint=%lu wb_dirty=%lu "
 		  "dirty_ratelimit=%lu task_ratelimit=%lu "
 		  "dirtied=%u dirtied_pause=%u "
 		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%lu",
@@ -693,8 +693,8 @@ TRACE_EVENT(balance_dirty_pages,
 		  __entry->limit,
 		  __entry->setpoint,
 		  __entry->dirty,
-		  __entry->bdi_setpoint,
-		  __entry->bdi_dirty,
+		  __entry->wb_setpoint,
+		  __entry->wb_dirty,
 		  __entry->dirty_ratelimit,
 		  __entry->task_ratelimit,
 		  __entry->dirtied,
-- 
2.25.1


