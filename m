Return-Path: <linux-kernel+bounces-543953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD20A4DBCA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36D63B55FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2A21FECC8;
	Tue,  4 Mar 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Mxndf6Tz"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DBD1FECCC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086219; cv=none; b=jzbZKZDRpOTgYRFOqG2amAQL70WFOjGmtXUVHZSxOq2/nczqaXOszOrgBbRkWxRfSikEAZqgFDW472n8zP6SGXIgCtR+PYrYdwSFchlMEQgoH6TDDJNRD1iH62iBexDCjK8+mpGoZTKDD/P3u9xf9pYD9OP2DmLFhk3XqBX9kEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086219; c=relaxed/simple;
	bh=wzIi4HZXwqVOWENoquV+UIkh/r0UJZTDI0sJVxfYL0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AGt7DGgNt7fmmBWRlCmANYuWKV/sHnPx9vIXoy2ZPfRCi/jvNeet2D9+ejK+LsPompJVR7Db+Qx+Y/R6ZS8EY3I+TObqMysdaZvof9PJFghmYa0Qr//ZEVkoRzWL+dd2yEqKAA0vmlmfDX8eTdBZwBjzmHjN51A3S1pTozKJ6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Mxndf6Tz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22356471820so86725645ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1741086217; x=1741691017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGd6xUUug40ndWv/7UEStbMr4MjIVHoaP0yPiRkB0+c=;
        b=Mxndf6TzleS+dRPLQMadyqWS9fol6eDBfKYTyFAP3FcRTlGK5Bdfnt2yRUWOI7NFv+
         vm7I+i6koCEW9iBSc+/OkyzOKEYOVqX6pVPGJ9mg6eM/sucNWYZyYBgC+7ZOULQoaJEA
         tg2G/1/mbqP7jMdeh5gHuyVsN0e2IMU04CN9OxvBZOGTUNWs/B4JPSL8naJkAqLcW9HN
         WxqGW8FME4qh0WtGzYgeTNZSkoPPyQQ0XSMmG8XT07mMEiaslY0wG/q+jRP9nCkPUkPS
         TkSb7QjCEgApM3CxSio/GcNcPeHNOEgd5Wrf7bcemmfXoHUbD6/D8FvOJemXObW5b/XA
         iOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086217; x=1741691017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGd6xUUug40ndWv/7UEStbMr4MjIVHoaP0yPiRkB0+c=;
        b=VHHi/wF9/M5egfM1+tFjHBTwPr/9nr6EAX3rdziuYqPfKg5A3i3XSrR8W+zJ11oxRJ
         PKIHIJyiCPl+vBYP0L7FfZFrwdIsq03OjKlCZNRIaKaXi9hBwZ5xuO98V9ytsdg3oDJn
         bSMzwOwNKPy8Dc6EvVxgq11467UnH2sWGS77/LsO0WkBVWVPdnpeob1Q2EprtxVZ/CIN
         I5FdcAK0LBsFMa47vLtW4Xy9nTpM2vpfpNRGhhIhwGn1BnNAdd8tzUcuD+TScAWC6kLi
         wKXIJDMShsveCVtbcbUvgsuFH+D4O16RNCgO7RyXqvtF55qtuUBsS4MIprSzIV9MA7Ab
         RDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwPacQFcgERFdMwBcjDbeF0UMoU9mLoA/7VZMhaioMdfIknzAz32UvKswvtK2XNnbHOuupey+LuZ/1LeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuScY363g686HuJ7sVzWUCheHFDhpBJczWKezhfaezQQ2+NYy4
	cZ2mwEUxRYpJKD7SuoiHW8Zwk/MwZ1IKczBOnbn6xkrgOB2DkyO7rwK29ARnYEs=
X-Gm-Gg: ASbGnctF5+vktGpN0+h8j0APUp5jtGFGK7IrKFbiBZ26T3Yuovxv4uMQddPHicTlNww
	iXKuflWwdtsy5D8Jl22rZA99uuk3k7u68UEFQVBou7qBcJT6+Si3QcwtWBgWgxCd5V4PSJzE4Ul
	1zQ208Nv1RSn+kWte505m3KtPkH6ih7wtiwFbm5RP7IzNFAQv9edRgvTaKTXXAl8xkCUnmY/NYV
	16upuSWJp7xC/x6Ucqf6MULIOT0DiK7EHh9evbLhp1aRYHKQgVW6CyQOtGxrxfnPEVfNDNdivXs
	dlmfHPQlIYIU9GkhGBdDvUorVnzKwA==
X-Google-Smtp-Source: AGHT+IHC27naAV4G4mjua+6oLFQl9im5/HZZ3hI9l/b48C3Mb32O1UgWu/XF/2xkyJ8188GOgWiflw==
X-Received: by 2002:a17:902:f990:b0:220:c911:3f60 with SMTP id d9443c01a7336-2236926a639mr179441625ad.47.1741086217307;
        Tue, 04 Mar 2025 03:03:37 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2778sm92764415ad.36.2025.03.04.03.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:03:36 -0800 (PST)
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
Subject: [PATCH v2 3/3] writeback: Fix calculations in trace_balance_dirty_pages() for cgwb
Date: Tue,  4 Mar 2025 19:03:18 +0800
Message-Id: <20250304110318.159567-4-yizhou.tang@shopee.com>
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
Acked-by: Tejun Heo <tj@kernel.org>
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


