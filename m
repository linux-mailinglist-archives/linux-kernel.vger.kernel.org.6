Return-Path: <linux-kernel+bounces-268505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E114B94257B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BD21F24742
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A351BC20;
	Wed, 31 Jul 2024 04:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoXH6VMZ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874AC2905
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722400592; cv=none; b=SmADlx2wPljhM5wWEScpFIb/GynCkcpO3UPcW5suML7U5PLvrjbDmrIyUpvg+lzHAx5UP7u9kGC7rxYsbCO4MHiJ9QI1j5qfHaGXBIUBAJoPk4rf2BOq3SU83aMiTdOnUEWPRJ84D6WdpJ5S9bb5qi8+reZqyqUkCC9JBs0vrtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722400592; c=relaxed/simple;
	bh=t7j5oivEcVAEMB07+HHtx7HM5KFWzAAdUoNk0+fgP/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSNS+QSUK9LP1pTIjgCAU9lYNQVA//ErUknclfcntDtbLi1svza9iFkbj2CiOos4+jum0SWfYcTEf+NbFGq2aI7jqwFoBQZ+6acyUcCSEoemHCZR7v07fA63CQEjtQo9K29TEGZmV+0TsPMKB3+7Qhhi+0crTUNgjPD7bA3XYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoXH6VMZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb7344ed8cso988344a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722400591; x=1723005391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8t6lHyICDZC2xXXxPIuD1GvAQxVFNn2UNYnzFQ8J/E=;
        b=AoXH6VMZrMxMBiTy6QFPtgKiBpMZChi9S73UVlwBMWKgFEyHGpqWDpufuhXAwjX7WF
         VuJLeXT7ovl1VKVW7QWdv0obxrR0jXIohnqAE6NzrUk5Ho47gItFtcwhjZIdu6umB8m5
         3C+2Sswj/cK5itIwVJhZUyeDO6tGXt1G6TVOt0EIWG1ZtaiDZqvSagy5q+MGxxnhra4+
         BZGPUYAX5yS5u+qbOwBdMnizFIzt+y4Bq91HFQ19iQE7WMoLdZ3Aulz1OXGNn+THLgrx
         4YBanWnM7ROhOB30M2g9Nk8mkjTly0462btoF6CuAWR4nbYCbF0HTpY6ljTDRMG60Ko+
         gvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722400591; x=1723005391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8t6lHyICDZC2xXXxPIuD1GvAQxVFNn2UNYnzFQ8J/E=;
        b=obPL18x2FdVCnoPn982nfh43MBkDo+oQzQkby+313vlTsyao9g66N7CuQMmG+9u6Be
         CjTFbCJj97dDyEpPpIRRIdsQ2JU3cDsG0L9l0pA2Ne8Dl6TdTF9m6d7vPd/8W4s74nIP
         2cfWeG9zEAb/DLJQughW0O77kxT+X7OG4pJZQZM/b8VgNjiSuxZOk3alLBf5qk/9hRVT
         erdMP/nfb0In8Ywq5i7AxQDsfbd8F4x7fM5NS+qn+HzluHpZZD9wrnzrs/Bv1YhPc8Yz
         2w3O92iO+PcY0lnww9zSLW6KntkSlpd9EB2ppZl9WpiiQH37bk9LuegMPmeMp45zbfg7
         5pVA==
X-Forwarded-Encrypted: i=1; AJvYcCXpthWT4sYifKU5vM3T3xXMrSxM6ZrmoiHPRjOhWiZIe5k6HD/QMOqRqhrozc4AHMe4/JmLRFUrhxBBxRS+3KpjI0nWIyhxYzMyUEBs
X-Gm-Message-State: AOJu0YyC/e8/NseSykqpkKRkVIHwjdjARFqpw1ch0WJhNE5EhcgEOTzO
	uCsEfXCYCFqL1LVYg/54M/uShT3YogxqkPndCddwpg9JkCHnwl+szI8OXr87aaiUyVSh
X-Google-Smtp-Source: AGHT+IFJI7eNzMfeGSUXtjOztq06ZcpJIdJPAfU/gDQwRNZNdmlLgwXsDTAmt10Y4VUFz5U13fUYgw==
X-Received: by 2002:a17:90a:4cc5:b0:2cd:8fcd:8479 with SMTP id 98e67ed59e1d1-2cf263815bfmr13765998a91.4.1722400590635;
        Tue, 30 Jul 2024 21:36:30 -0700 (PDT)
Received: from alissa-Surface-Laptop-Studio.. ([2001:569:500b:7500:a902:c9b:7452:5a43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4a8049sm288030a91.37.2024.07.30.21.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 21:36:30 -0700 (PDT)
From: Alissa Guo <guoalissa@gmail.com>
To: skhan@linuxfoundation.org,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	brauner@kernel.org,
	kuba@kernel.org
Cc: Alissa Guo <guoalissa@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] documentation: key header files: fix member variable description warnings
Date: Tue, 30 Jul 2024 21:35:59 -0700
Message-ID: <20240731043609.9762-1-guoalissa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alissa Guo <guoalissa@gmail.com>
---
 include/drm/display/drm_dp_helper.h | 1 +
 include/linux/jbd2.h                | 2 +-
 include/uapi/drm/drm_mode.h         | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index ea03e1dd26ba..7f2567fa230d 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -112,6 +112,7 @@ struct drm_dp_vsc_sdp {
  * @target_rr: Target Refresh
  * @duration_incr_ms: Successive frame duration increase
  * @duration_decr_ms: Successive frame duration decrease
+ * @target_rr_divider: Target refresh rate divider
  * @mode: Adaptive Sync Operation Mode
  */
 struct drm_dp_as_sdp {
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5157d92b6f23..17662eae408f 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1086,7 +1086,7 @@ struct journal_s
 	int			j_revoke_records_per_block;
 
 	/**
-	 * @j_transaction_overhead:
+	 * @j_transaction_overhead_buffers:
 	 *
 	 * Number of blocks each transaction needs for its own bookkeeping
 	 */
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index d390011b89b4..c61b72bc04a6 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -864,7 +864,13 @@ struct drm_color_lut {
  * array of struct drm_plane_size_hint.
  */
 struct drm_plane_size_hint {
+	/**
+	 * @width: Desired horizontal size of the plane in pixels
+	 */
 	__u16 width;
+	/**
+	 * @height: Desired vertical size of the plane in pixels
+	 */
 	__u16 height;
 };
 
-- 
2.43.0


