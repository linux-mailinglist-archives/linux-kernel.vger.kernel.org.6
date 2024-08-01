Return-Path: <linux-kernel+bounces-270437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B65943FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195B81F21D34
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296213BACB;
	Thu,  1 Aug 2024 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq0cN4I4"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38213B2B8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 00:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722473548; cv=none; b=Od27vSM5L6l0gSrCz5SYeaCnTtYfnqYxqXlZID1ungqQ74NlhDTbOOr6NhW+efqriHQwpvnR6Tta5uHS+dRnbGhbDarzfVW6tMXEVQw2NfxZRO4eZ96tJlXlCUks2wQbz2YuxGmjJVWGsgIwuYROLMiPNUT1kC8KE+uIaCBohoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722473548; c=relaxed/simple;
	bh=6zpUOYvmgs4mf28LE44Wn7aUylE6Q/W5yM7OT7rNlok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qB1qH9UrOqHQI48VAbDGLc0AwUjt9PTTmy3Liu0hQRRPIW3EQIynz8BcBxVG3rkLMXmDNNYDqh/OxBvNVpw+RTvTjcqRLRAI8bd4nxA0Yy8oiuOQ2Meq7YLx3uVqyBOTN2YKg0+Ro6V+de6iq5akWM/Hyjc4yQ1IPu4CK1Yv5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lq0cN4I4; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2644f7d0fb2so949112fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722473546; x=1723078346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYyDUh8QDt19IO8gWE1U0Llcb5gV/MS83pUHIhDVvh8=;
        b=lq0cN4I4j1WyEbONlUEI4EaUddtDwe/XLhl9OSIWyxzQCQlS3D0kuHQ876tSM/V218
         PEU3+XGaz5lS2q2NPErvNiHS/DwfmxyKGHk7KRLGsYopSrkKe1oGQjFwDAIptRxmsmu9
         tAklzjD9pwvdHX8f98QMr2VWQFWJD1JFKM5g2zFMXSSLXzv8uBiJ/8usJbJkp/TtQ9Lm
         bl9nEowr4FqbohdhVJw0zds3yXN+V/w1Jl/EsS29q2jpr7JnOVDGthAP2r8bNQa+accN
         acBFbQWRFGGLxWZ4k/umzkPKVgP7cg1AXYm2VHn/oaH/6Q7622v9X1XZGcNme6siO/v0
         hTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722473546; x=1723078346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYyDUh8QDt19IO8gWE1U0Llcb5gV/MS83pUHIhDVvh8=;
        b=NtLBDtPTRG4FZ88eg94SRtgFiWGDSNPXF6tfnEUj27EhHsh9dzx0eiY/qWwnUSeKes
         8Sql75ILlHfPY5wqClqPRN2f1OlNCwF2KRrlnvsvE6UerN0UeVjuJdGVrPrd9u6JkmnV
         M2e82rhaxQw5cVX/dabkL2whhwuUJHaj8ofkjQ2pd4Io5pec6S8ocQfn3apJIH9Vkxa8
         EPeEDVms6Vg+158pCt2UoYlncvyv2EtKAlCmLOlsHeEOhjP9Lg8XTPhfH0qm9F9gd/rc
         okIx3JRTtS14uml9WdJMFOFVJ/qKzpSEgsStP1EuzW93etXTSz6jm9IAIWStnap4Wgm/
         pVcg==
X-Forwarded-Encrypted: i=1; AJvYcCVowf/jtQsWFzNnZDCJJd+4BiCZ/Pnn4Wexl2eWE4SbSGdDINW/DOADxTgziRLLpooZTXq0DH5jwssVN0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcEVb8jmroiG8iX6ME5tsXhxZSJ+fni5KF7XMALYjx5MM15Yl4
	IQ7cMJ3HcQq4Xal9kPWBwSxbmgR9uqLug/X75wzVIV7pBMLDbtKY
X-Google-Smtp-Source: AGHT+IEXNNn+Yo7EeBFfz6N3WlzE2imJ5Z05MHRulKU23vRf3dbpY52A64ReDqUIaA7b9+EGN88DGQ==
X-Received: by 2002:a05:6808:1b22:b0:3da:ac08:b74a with SMTP id 5614622812f47-3db5123cccbmr539368b6e.7.1722473545811;
        Wed, 31 Jul 2024 17:52:25 -0700 (PDT)
Received: from alissa-Surface-Laptop-Studio.. ([2001:569:500b:7500:ee7d:a955:12b:463])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa5a08efsm9539375a12.83.2024.07.31.17.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 17:52:25 -0700 (PDT)
From: Alissa Guo <guoalissa@gmail.com>
To: skhan@linuxfoundation.org,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	brauner@kernel.org,
	kuba@kernel.org
Cc: Alissa Guo <guoalissa@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] documentation: key header files: fix member variable description warnings
Date: Wed, 31 Jul 2024 17:51:38 -0700
Message-ID: <20240801005206.126984-2-guoalissa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731043609.9762-1-guoalissa@gmail.com>
References: <20240731043609.9762-1-guoalissa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following documentation compilation warnings from missing member variable descriptions when 'make htmldocs' is called:

Fixed misspelling of @j_transaction_overhead to @j_transaction_overhead_buffers in ./include/linux/jbd2.h:1303

Add description of 'target_rr_divider' in  ./include/drm/display/drm_dp_helper.h

Add description of 'width' and 'height' in struct 'drm_plane_size_hint' in ./include/uapi/drm/drm_mode.h

Effects:

The following warnings should no longer arise upon 'make htmldocs'

./include/linux/jbd2.h:1303: warning: Function parameter or struct member 'j_transaction_overhead_buffers' not described in 'journal_s'
./include/linux/jbd2.h:1303: warning: Excess struct member 'j_transaction_overhead' description in 'journal_s'
./include/drm/display/drm_dp_helper.h:127: warning: Function parameter or struct member 'target_rr_divider' not described in 'drm_dp_as_sdp'
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'width' not described in 'drm_plane_size_hint'
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'height' not described in 'drm_plane_size_hint'

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


