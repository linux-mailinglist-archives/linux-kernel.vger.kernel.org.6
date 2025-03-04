Return-Path: <linux-kernel+bounces-543951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA746A4DBC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADAB3B4032
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04501FF1DA;
	Tue,  4 Mar 2025 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="NCYpASAD"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1301FF1BC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086211; cv=none; b=nhhVQ05bAUjFimvXKaeBynYy7+RY2UZ39yYg/hdBI/Z8CifqqakfSzh522u5NeBNNjynsFiE0HqPgTMs5OY+0cFftCAj2AlqHY9qBDiU3kpzQlCeLe81sEKBlQIerUQ+OrukLdmYZtJ/rHGbVQR/zATprQUSV3QueQ1ZoZ9xUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086211; c=relaxed/simple;
	bh=WMWcERJJfbqiD3z8oE5+hnpSPeiC/ts2lZLJl0kJDgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5vbD3b4w/7v9MMu+xKfM4x+8522O79sSMJ5xyNBFP5FYTa6Hhu00nKKsnq8zcYLKoybaPJArhLGsk6p9/JfVOWCuqtbggpVvd8SME1mgU512eiJog+xHSsOu9xbHByRgCUxqpeTSBk21rCJsGCzTckAOovws9TaCpJKCOKA+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=NCYpASAD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22356471820so86723855ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1741086209; x=1741691009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YawdmYDPWdB9hnNHcTCzRAEqbfP7zzuyOxM1DZL9r8=;
        b=NCYpASADNuvRESIPIYSAyNqu/x2P/gpnp5pgmgeYpTdbzy4ZOANSsFd5jGuG++WrXI
         ocg67nmijefF4haDICHjBOlUNjiq9uVzHBPOXgAYS/cYtrRA2c+K5EcG50ZSOZPx2xFa
         0qZ5gY514tjrfYNeVNKHYxAXnAjYdOY3Ar5jLWCIhEcsEehb+0LGYi6lNLtvHv4F9h7N
         W9QSQvNXTkmFRjv9jY8+rWAxk01qUQJ+gTaT1fSXPo2HBY290bhwb5VboFzidvAnuHKe
         5hB4GV7svePRMG4iN6gMuKNagf+qwglnV8JCISrFWavzEto5DXfTUpOwZjH1fPAHK8SR
         Kpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086209; x=1741691009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YawdmYDPWdB9hnNHcTCzRAEqbfP7zzuyOxM1DZL9r8=;
        b=WULCkQGwurgjjU2FVtEsboColXz1G8oguEnO4MrWwKpVq5zTkUiu89acrqN00qLjKG
         hrKArlnG1WAK1LocKsvJpP29txafVDNRbnBs80gxecQLXB8uYW7H+U0cnoYa/QYv0yro
         dOZhDVc5HQ53GN9zAICq1Es0+qsOMS/4KSS4kUDrXJFllg5S5avV++TExHiXXD4lBc7J
         Gnmd0b3lnCBL5C52YtbhGZ94P1MUaTELqCQ07rX1y3PFzksAOLn8jESF/4mYuJ+9aoRl
         qNxKVzTdtCvJaR/m1/sgtD4tT4G8xu8rTLiiXAMacKDIPdKKO40I53fJR+ehELsZ9C/C
         7ikA==
X-Forwarded-Encrypted: i=1; AJvYcCVG1Im0CsKOQzhyh+vnbTVT06bfH8khJPji3+isCViv5MTiDkd2pQFYJ7Wln/69I7PxsBK4T3fqAkdPTus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYR4UHwaux8OlGWhlv12ZQMdBneQhGM3kPkMGRdY36hqhwn28
	eRmXbj/D9xc8VfW365hrlAG/TnMHlLdR+36VnBgefvoe3K63ErVZNLdZIYMIQL4=
X-Gm-Gg: ASbGnctVYLDrrI4XXNfJx96nUC2rLj+7lxm3bvPAZsoZ861GWFs9wIIiA8HMqiEpBX7
	ttUMg6tMFJQSp8z9EyPaNFWnEMeqzzJPF1cmo8P2tyzxyILmhNe/uG5RZS3GXUtsLvpnq5qAtvO
	dLHSDp8Tifdvxv/r5uGFE1OMdYYc3asx3+LsprCCx/ToxwKAfhDkPmOOp9F11gzZNuMlU8dHRxF
	/x3Y3QPzoFIApfQLIvKKQu8txOTB8+jQ21j4nc1CIjoMparUfYaRlgFhCRTxzXloF8hrvfY8QE+
	54bF1vLiF0FyHmM9mH3ca7uLGRyh0g==
X-Google-Smtp-Source: AGHT+IHcP3j8xP5tujxFcnjNnFi/BdlYDT5lDMwXz1AMbsqmlg8tbp0AtTG0gER04iSD5VopiJ2d7g==
X-Received: by 2002:a17:902:d4cb:b0:21f:b6f:3f34 with SMTP id d9443c01a7336-22368f9d88fmr239812185ad.15.1741086209642;
        Tue, 04 Mar 2025 03:03:29 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2778sm92764415ad.36.2025.03.04.03.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:03:28 -0800 (PST)
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
Subject: [PATCH v2 1/3] writeback: Let trace_balance_dirty_pages() take struct dtc as parameter
Date: Tue,  4 Mar 2025 19:03:16 +0800
Message-Id: <20250304110318.159567-2-yizhou.tang@shopee.com>
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

Currently, trace_balance_dirty_pages() already has 12 parameters. In the
patch #3, I initially attempted to introduce an additional parameter.
However, in include/linux/trace_events.h, bpf_trace_run12() only supports
up to 12 parameters and bpf_trace_run13() does not exist.

To reduce the number of parameters in trace_balance_dirty_pages(), we can
make it accept a pointer to struct dirty_throttle_control as a parameter.
To achieve this, we need to move the definition of struct
dirty_throttle_control from mm/page-writeback.c to
include/linux/writeback.h.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 include/linux/writeback.h        | 23 +++++++++++++++++++++
 include/trace/events/writeback.h | 16 ++++++---------
 mm/page-writeback.c              | 35 ++------------------------------
 3 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index d11b903c2edb..32095928365c 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -313,6 +313,29 @@ static inline void cgroup_writeback_umount(struct super_block *sb)
 /*
  * mm/page-writeback.c
  */
+/* consolidated parameters for balance_dirty_pages() and its subroutines */
+struct dirty_throttle_control {
+#ifdef CONFIG_CGROUP_WRITEBACK
+	struct wb_domain	*dom;
+	struct dirty_throttle_control *gdtc;	/* only set in memcg dtc's */
+#endif
+	struct bdi_writeback	*wb;
+	struct fprop_local_percpu *wb_completions;
+
+	unsigned long		avail;		/* dirtyable */
+	unsigned long		dirty;		/* file_dirty + write + nfs */
+	unsigned long		thresh;		/* dirty threshold */
+	unsigned long		bg_thresh;	/* dirty background threshold */
+
+	unsigned long		wb_dirty;	/* per-wb counterparts */
+	unsigned long		wb_thresh;
+	unsigned long		wb_bg_thresh;
+
+	unsigned long		pos_ratio;
+	bool			freerun;
+	bool			dirty_exceeded;
+};
+
 void laptop_io_completion(struct backing_dev_info *info);
 void laptop_sync_completion(void);
 void laptop_mode_timer_fn(struct timer_list *t);
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index a261e86e61fa..3213b9023794 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -629,11 +629,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 TRACE_EVENT(balance_dirty_pages,
 
 	TP_PROTO(struct bdi_writeback *wb,
-		 unsigned long thresh,
-		 unsigned long bg_thresh,
-		 unsigned long dirty,
-		 unsigned long bdi_thresh,
-		 unsigned long bdi_dirty,
+		 struct dirty_throttle_control *dtc,
 		 unsigned long dirty_ratelimit,
 		 unsigned long task_ratelimit,
 		 unsigned long dirtied,
@@ -641,7 +637,7 @@ TRACE_EVENT(balance_dirty_pages,
 		 long pause,
 		 unsigned long start_time),
 
-	TP_ARGS(wb, thresh, bg_thresh, dirty, bdi_thresh, bdi_dirty,
+	TP_ARGS(wb, dtc,
 		dirty_ratelimit, task_ratelimit,
 		dirtied, period, pause, start_time),
 
@@ -664,16 +660,16 @@ TRACE_EVENT(balance_dirty_pages,
 	),
 
 	TP_fast_assign(
-		unsigned long freerun = (thresh + bg_thresh) / 2;
+		unsigned long freerun = (dtc->thresh + dtc->bg_thresh) / 2;
 		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
 
 		__entry->limit		= global_wb_domain.dirty_limit;
 		__entry->setpoint	= (global_wb_domain.dirty_limit +
 						freerun) / 2;
-		__entry->dirty		= dirty;
+		__entry->dirty		= dtc->dirty;
 		__entry->bdi_setpoint	= __entry->setpoint *
-						bdi_thresh / (thresh + 1);
-		__entry->bdi_dirty	= bdi_dirty;
+						dtc->wb_thresh / (dtc->thresh + 1);
+		__entry->bdi_dirty	= dtc->wb_dirty;
 		__entry->dirty_ratelimit = KBps(dirty_ratelimit);
 		__entry->task_ratelimit	= KBps(task_ratelimit);
 		__entry->dirtied	= dirtied;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb55ece39c56..e980b2aec352 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -120,29 +120,6 @@ EXPORT_SYMBOL(laptop_mode);
 
 struct wb_domain global_wb_domain;
 
-/* consolidated parameters for balance_dirty_pages() and its subroutines */
-struct dirty_throttle_control {
-#ifdef CONFIG_CGROUP_WRITEBACK
-	struct wb_domain	*dom;
-	struct dirty_throttle_control *gdtc;	/* only set in memcg dtc's */
-#endif
-	struct bdi_writeback	*wb;
-	struct fprop_local_percpu *wb_completions;
-
-	unsigned long		avail;		/* dirtyable */
-	unsigned long		dirty;		/* file_dirty + write + nfs */
-	unsigned long		thresh;		/* dirty threshold */
-	unsigned long		bg_thresh;	/* dirty background threshold */
-
-	unsigned long		wb_dirty;	/* per-wb counterparts */
-	unsigned long		wb_thresh;
-	unsigned long		wb_bg_thresh;
-
-	unsigned long		pos_ratio;
-	bool			freerun;
-	bool			dirty_exceeded;
-};
-
 /*
  * Length of period for aging writeout fractions of bdis. This is an
  * arbitrarily chosen number. The longer the period, the slower fractions will
@@ -1962,11 +1939,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		 */
 		if (pause < min_pause) {
 			trace_balance_dirty_pages(wb,
-						  sdtc->thresh,
-						  sdtc->bg_thresh,
-						  sdtc->dirty,
-						  sdtc->wb_thresh,
-						  sdtc->wb_dirty,
+						  sdtc,
 						  dirty_ratelimit,
 						  task_ratelimit,
 						  pages_dirtied,
@@ -1991,11 +1964,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 
 pause:
 		trace_balance_dirty_pages(wb,
-					  sdtc->thresh,
-					  sdtc->bg_thresh,
-					  sdtc->dirty,
-					  sdtc->wb_thresh,
-					  sdtc->wb_dirty,
+					  sdtc,
 					  dirty_ratelimit,
 					  task_ratelimit,
 					  pages_dirtied,
-- 
2.25.1


