Return-Path: <linux-kernel+bounces-541339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF00A4BBAE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142973A9805
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26341F37DA;
	Mon,  3 Mar 2025 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Fs+7Qod3"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3D1F2C58
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996393; cv=none; b=kYxeM25OLSOdVAqyRA7dLwkSRwQpKOutvnEFYSdtIkpsmwLhvItR2qWhjZhQfskB80vzmN0VRwkTPTvXnRWViAOGa5eR6V3A0KV2M8RzxQ0JC1jnBsn4POzJonXEtlo5H9e6V370nW3rqAAO6UbdVrS8o+iwgffRyp3xcW+kheU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996393; c=relaxed/simple;
	bh=q4V8PCiwKojPy1QYgapBfO9lTDA+LB5m3KPLTH/ST84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dseJopjkw+5Axc6yZAcYbr+MUChTUIRXaxEc/Sltx3+ux2eHPNpx+jamyuuPu+4pyqKL9ASFn0D2gXE5BdiBhV124S7ojVR3R4hKj95BgHvIEVaSVhOL20S9O/0lfcN9BF9Bgz4d+merOFHTgnhqMol5O2Lx/MiJwdvSnuAEEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Fs+7Qod3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2235189adaeso64204095ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1740996391; x=1741601191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlOgUF0I+Rkuiq5isF50AFm1bBn1sNSF5ax0jaYNIBw=;
        b=Fs+7Qod3K10fvD4Su8HbWX/q4o85LCBPoozoYzvvUAcDRlQl96GY+8btzFXi/rEZ52
         bXLnNFbVUY960ppNVBcLbURzjWh+w+uy49nkbwVdNDdBdyepRkFOHdPMY7pQIdULSmZ9
         gTshS3wtf6dYNs9aKECZOV1JNyNSh1r6zS+AzY8AIUFaA+RezauogotUWq23PNaeeSIB
         dCeezkzk3qJGiTe+yRtaJtcKGfm5B5AKobl9ak29polJQQhWYAC1m2/xbiUJ6DSSTHhE
         3cbwawafLwWhDfdoHgeoEQBnlsFpgn5yb7BNnE+TIH7VQdMoflefL+ZOxpzzcRb0A5vN
         suqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996391; x=1741601191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlOgUF0I+Rkuiq5isF50AFm1bBn1sNSF5ax0jaYNIBw=;
        b=eXmW5JgHLk/rf4l5VrXKSWXqX8hZMyGpUJMHOz0f5BUf74VIk1QEJytlTNdsz7GmDs
         JRO54E6enZDPw/+lJaFUZYMeFZ4GUOA+clFUTuCmh1OrJnBLT2JHkQMFe+qfz+p9WYSb
         0hsNoWZaPuQHuqvBWkLD1zcQJK0hY6PFHhvjFLQiEXxsJY5+qhcJbvUIJ/CQIHw253u0
         BOq3Eivruk1kfyg8207rjhFS3yUFKcHrNZlPVxcgcduwfOC6Uy6ixWfDmU2odlEd6M3b
         ipQnRUAyvsLiblAxNW/RuNPtr6awx2QRiItexflPlO2AZpfKqWplCYofl+xqRDCGUcJd
         u5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOG2U5MpDaCres1iyz7B3rpFDbPsvp9VnD/9UMycixA5jQL+wUkHFucs6rUfrEnzdXpf1uVXaZr/LdnKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzekfH3txBjpT77unhFWxquge+jKLcL0k8VZ8VJTIpoAWGGwcZk
	jCDUDLM1ZsBYplFiEw9uNkyzQVzFjUUe13pWrplzGIW8Zsc7IIN1mxRc+aatGJg=
X-Gm-Gg: ASbGncumUk1eJsYEEiUT+zn1p6pGZzyT+xms4YdT7p0N7HCN5hUODIOc5AsdxKRuMY1
	gGTfw8AXCcIZadjVYgK2DzI6wcclyhPuWYihEZ5KkmE1nLtRIXA/Qt+2OYOufHIvGhMUqEwzEdW
	hKTdPjmdNvnsD91XJXIsCdcLeCuHWUjYi7z6C7rHIt8IxAWT4dleBsbyzIDp5XcIsUU+IuKojJk
	XMSe1WhnEdy/isG2o3fEUjbXDUgtT+edj8yMll1FATMw/29hX02q0WZq7F6YLbui3BYo13ce0uP
	8R1uru1EKCyczkIBvath2h5J92jujw==
X-Google-Smtp-Source: AGHT+IHIVt3VPmyTSVrkUCPhcW9I+/9BdLXMLDmjaYIvdMR9bAGzwWvrVsZS6NIolMs+7Bf7bchTHQ==
X-Received: by 2002:a17:903:1252:b0:223:4d5e:76a6 with SMTP id d9443c01a7336-22367413da7mr199503185ad.1.1740996391188;
        Mon, 03 Mar 2025 02:06:31 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350537b47sm74397275ad.251.2025.03.03.02.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:06:30 -0800 (PST)
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
Subject: [PATCH RESEND 2/2] writeback: Fix calculations in trace_balance_dirty_pages() for cgwb
Date: Mon,  3 Mar 2025 18:06:17 +0800
Message-Id: <20250303100617.223677-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303100617.223677-1-yizhou.tang@shopee.com>
References: <20250303100617.223677-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In the commit dcc25ae76eb7 ("writeback: move global_dirty_limit into
wb_domain") of the cgroup writeback backpressure propagation patchset,
Tejun made some adaptations to trace_balance_dirty_pages() for cgroup
writeback. However, this adaptation was incomplete and Tejun missed
further adaptation in the subsequent patches.

In the cgroup writeback scenario, if sdtc in balance_dirty_pages() is
assigned to mdtc, then upon entering trace_balance_dirty_pages(),
__entry->limit should be assigned based on the dirty_limit of the
corresponding memcg's wb_domain, rather than global_wb_domain.

To address this issue and simplify the implementation, introduce a 'limit'
field in struct dirty_throttle_control to store the hard_limit value
computed in wb_position_ratio() by calling hard_dirty_limit(). This field
will then be used in trace_balance_dirty_pages() to assign the value to
__entry->limit.

Fixes: dcc25ae76eb7 ("writeback: move global_dirty_limit into wb_domain")
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 include/linux/writeback.h        | 1 +
 include/trace/events/writeback.h | 5 ++---
 mm/page-writeback.c              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 32095928365c..58bda3347914 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -326,6 +326,7 @@ struct dirty_throttle_control {
 	unsigned long		dirty;		/* file_dirty + write + nfs */
 	unsigned long		thresh;		/* dirty threshold */
 	unsigned long		bg_thresh;	/* dirty background threshold */
+	unsigned long		limit;		/* hard dirty limit */
 
 	unsigned long		wb_dirty;	/* per-wb counterparts */
 	unsigned long		wb_thresh;
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 3046ca6b08ea..0ff388131fc9 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -663,9 +663,8 @@ TRACE_EVENT(balance_dirty_pages,
 		unsigned long freerun = (dtc->thresh + dtc->bg_thresh) / 2;
 		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
 
-		__entry->limit		= global_wb_domain.dirty_limit;
-		__entry->setpoint	= (global_wb_domain.dirty_limit +
-						freerun) / 2;
+		__entry->limit		= dtc->limit;
+		__entry->setpoint	= (dtc->limit + freerun) / 2;
 		__entry->dirty		= dtc->dirty;
 		__entry->wb_setpoint	= __entry->setpoint *
 						dtc->wb_thresh / (dtc->thresh + 1);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e980b2aec352..3147119a9a04 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1072,7 +1072,7 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
 	struct bdi_writeback *wb = dtc->wb;
 	unsigned long write_bw = READ_ONCE(wb->avg_write_bandwidth);
 	unsigned long freerun = dirty_freerun_ceiling(dtc->thresh, dtc->bg_thresh);
-	unsigned long limit = hard_dirty_limit(dtc_dom(dtc), dtc->thresh);
+	unsigned long limit = dtc->limit = hard_dirty_limit(dtc_dom(dtc), dtc->thresh);
 	unsigned long wb_thresh = dtc->wb_thresh;
 	unsigned long x_intercept;
 	unsigned long setpoint;		/* dirty pages' target balance point */
-- 
2.25.1


