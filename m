Return-Path: <linux-kernel+bounces-329484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E49F9791E8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CFD1F2295C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5361D048D;
	Sat, 14 Sep 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmLqfapm"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691EE1E487
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726329165; cv=none; b=Mp3RouNG3MSWYeaBPoygi9Nv+cweyDQq5cDGkA/SP1mHPI3a7YIVu9ett0k3pm5iqRrnGsdFeBeuvsPMBOU2um+hjsD280eX2ZQG1qH3FgxFe0VClIWQ3a4flXy+IJHQpG4kMlbqE9mL27FR3QDknYZSWoKKwTLJeHSojdTeH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726329165; c=relaxed/simple;
	bh=HOXqSDH6t1q5ebioMfv+ZSSCk0tUSisCmNA26sTU7X0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KAHW4gM0SW8yamIm8Rju7S8AVvA2mNq+1COqhIPrxUR6beWdpHY+jY8RQHWt5gpJly+pjVRJF8JypLeqIAr0EH+nxvGiY8jvuKfRmiHiW9tQ4sKazri86OiXN+rE5HrK0ERog1LXOH91D5zGyM+5kbAXAmTagR8y/Ee4ZeugquQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmLqfapm; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so2531956a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726329163; x=1726933963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pK0bAAMii6l/zWCiTt8slL91+XkdnGQngiqo2N/DQ8=;
        b=hmLqfapmaYUSF2NdpMNMVWlbfTdrIcx6vayzRVjwkrXrsRjGCHWYVdpC1e/FYc9PZe
         ztg+2lw1XiNMfwPjkIbS1MeRO+IRq3hyOjkQtE+CUi0nhObFya8T8rI9Zm2OwfsOmtUJ
         NscYgMGA1PolG7rqusowz6OXPJl2aK32Qcy215qJiMtQ/SjdMjM+LpfplfBz9/LL5Rk7
         aSzKhGs/DWwe2q14qxmHOXg2TctPAoG13Pd8ucjOoQM5KXLi02XBRE4g8IMzkfTXy57Y
         ijb9GdEEdpCKofH8Sop1eLE0W53EZWnWTuE59bXGxEUxm5G+Ow09XNsjgttZcES9EZj5
         gpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726329163; x=1726933963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pK0bAAMii6l/zWCiTt8slL91+XkdnGQngiqo2N/DQ8=;
        b=BadweOKt48tHAtOmwj/6npW6VD2ash52xbbuKNt0qcN3JVOGvEv1DnoiCUBU1I1CcM
         satecrOFt0h73YMVpz6ovqWPTgInAwWKYhN5IvBpP/7p5HQ/SjMJlT7TMDS99aaH+mVm
         a/CkjKAPEjfwXexlALhHOgNgLiFcTHaFh2W9WMSBw8ypSKgJoov7V/q8PHcVuMiazmok
         0wl32xUE/GEpsQXcByNwRqr+jKsW6Rwp/hJeg1iKl6GlaQ893vaPI9ezelinK75c2QIK
         PC60HC1DGlL/01Dhb6J+lNSc0VYadwHVD2m5pbrjGfPmgG8G51oNiqkZoomrYpGszRX1
         EESw==
X-Gm-Message-State: AOJu0YwOZb6VrmcfQZPI+BNgcBVcfaOSMpF4UNX5t1GRKLTfu2zoyKyK
	wgrB1LYVzcwlxX5Kwr+GGCb43p5AnZg1W+EwMBir7I/y3zstrueZ
X-Google-Smtp-Source: AGHT+IHCkJjIMP/SZ7LxpCIEbY30ptOv+YfC47ioTjU1MsZOgTKZZ9znxzpOD524Pah88Yb/tkV+ow==
X-Received: by 2002:a17:90b:2704:b0:2d8:e3cc:6c0 with SMTP id 98e67ed59e1d1-2db9ffb13b7mr13605191a91.1.1726329163497;
        Sat, 14 Sep 2024 08:52:43 -0700 (PDT)
Received: from localhost.localdomain ([115.97.189.145])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c4c292sm3834551a91.12.2024.09.14.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 08:52:42 -0700 (PDT)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>
Subject: [PATCH 1/1] mm/mempolicy: fix comments for better documentation
Date: Sat, 14 Sep 2024 20:48:01 +0530
Message-Id: <20240914151801.4388-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

- Fix typo in mempolicy.h
- Correct the number of allowed memory policy

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
---
 include/linux/mempolicy.h | 2 +-
 mm/mempolicy.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 1add16f21612..ce9885e0178a 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -47,7 +47,7 @@ struct mempolicy {
 	atomic_t refcnt;
 	unsigned short mode; 	/* See MPOL_* above */
 	unsigned short flags;	/* See set_mempolicy() MPOL_F_* above */
-	nodemask_t nodes;	/* interleave/bind/perfer */
+	nodemask_t nodes;	/* interleave/bind/preferred/etc */
 	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
 	union {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b858e22b259d..613fdb73c404 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -8,7 +8,7 @@
  * NUMA policy allows the user to give hints in which node(s) memory should
  * be allocated.
  *
- * Support four policies per VMA and per process:
+ * Support six policies per VMA and per process:
  *
  * The VMA policy has priority over the process policy for a page fault.
  *
-- 
2.39.2


