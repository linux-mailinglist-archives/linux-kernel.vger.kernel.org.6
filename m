Return-Path: <linux-kernel+bounces-179934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350FC8C67B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04721F21EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44D713EFE5;
	Wed, 15 May 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW+HNlcN"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215E13E8BC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780809; cv=none; b=B1sXZEUQXYcb6b5RrgT1a1s8EV4/3DfOcL7OjX5BoFdqpNYzoVWFv/XYgZz+wH6txrHkk91fMWsMe7d1VUXT3QOH3dMwgBIn2aFWAtzcXo2HEMJ7ZLPFJ7GC7lFZVDuPvJwRUM8U25GNNzHRU9KIstSqpnOw/VecnmVSIz8lOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780809; c=relaxed/simple;
	bh=HlYUn+AUiMC8WNbrC/7yfkXXZ77wOhWytY7/oRygePI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVFZ+TWCrODvViX6SQUSuHOo/zgDkRxWD/fUecHnlh8SwVyW3B/U+z6o9PZLtRau585sXliMGrNtnZLTcSxQVC8vOBVoQc5KiL02bAOKPnqnMVMMiyXWcXNAPyjfaaROeoMESIi1SpOW2pTyU5b2gEk9xdWHNFp1GvUxCjRECF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FW+HNlcN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f490b5c23bso5872298b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715780807; x=1716385607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/aWNpGr2BOcL2s1INIGQclasXE+vLkMnsMhHhMCmzOY=;
        b=FW+HNlcN9Cxl4riIwpmgm8BBt8mWXCdneXAAzxEBkHjKTezt5aO9bjBRUFt8JfUxl6
         WZ8iuDa+hlfBq+94mht3D8AQaDAFjIHlleBGUWkjrUapVzbZxzceJhxC+0UcJdiRAnCF
         frMiCphGbRu3mDIJnQ/sssJrnCDN9gkpyKQ85/wa8V7J5aZ1a1zTRscR9DUr+onUI4CK
         TGvyW5LUD631i3fIuzN/z+CQM9wvkjKQvF6FMro+z3cPZYDvsKGPzPpC1d7ZQyYp7zWe
         enwppFmiLMLmnueETfX6rCHsRme3jXbx8EngGy5EplzEzenp1mYJKiZcK9hqrCsgu9+K
         6JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715780807; x=1716385607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aWNpGr2BOcL2s1INIGQclasXE+vLkMnsMhHhMCmzOY=;
        b=E52t28PDxB7Ye2A0dk9NDEUdKaW8JWVV2s2IxoW48zcinE6G3+WZyNSVY9cA+DPliw
         3T6lFfwpjpH0qe+7A3pPU49JV3lwt/F6WcZnU4b3wm6HXOgfASK5COb/I0A/StbhzOqw
         sSbgdNfv2tXviQWzSUgdt06X6wxLzN7d81CV8M2BdmfmygTjXCFBrxATvlQPj0g5RA4Z
         ugY9CF85rjVAprXVLerodylzzx7lfs0y+w2guP7ro5TOrDkp1jZhojC+bp8yPubdzTCc
         sQ3fBDwOAWLuXAHkoQfzhlysUe9bG4aB48iPagpEQ3QkK8xz/eNap2tLTxMD50a1AtS9
         eBDw==
X-Gm-Message-State: AOJu0YxOi74xNV6nHgQEnxsDN2a6JGGsVQvLaEmELTQzKpBOpbqMjt13
	Yxzof/+CdWFaNMkhdbTtWXvt0QSJE54PVpMB4tHdUhEnDd/6XhSN8kAcvYdA
X-Google-Smtp-Source: AGHT+IHs1EghNZ1hRbZKsC/fVHeFkKlv3ee/VNtyluVZ8OU+VysMmZn+rIve2FMUG65WW1L3076JJQ==
X-Received: by 2002:a17:90a:9404:b0:2b3:a79a:7e4b with SMTP id 98e67ed59e1d1-2b6cc76d24amr13108080a91.22.1715780806677;
        Wed, 15 May 2024 06:46:46 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628856d5dsm13524587a91.21.2024.05.15.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:46:46 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] cpu/hotplug: Fix dynstate assignment in __cpuhp_setup_state_cpuslocked()
Date: Wed, 15 May 2024 21:45:54 +0800
Message-ID: <20240515134554.427071-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4205e4786d0b ("cpu/hotplug: Provide dynamic range for prepare
stage") added a dynamic range for the prepare states, but did not handle
the assignment of the dynstate variable in __cpuhp_setup_state_cpuslocked()
function. This causes the corresponding startup callback not to be invoked
when calling __cpuhp_setup_state_cpuslocked() with the CPUHP_BP_PREPARE_DYN
parameter, even though it should be.

Currently, the users of __cpuhp_setup_state_cpuslocked(), for one reason or
another, have not triggered this bug.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 63447eb85dab..8a2fa196eb8b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2494,7 +2494,7 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance);
  * The caller needs to hold cpus read locked while calling this function.
  * Return:
  *   On success:
- *      Positive state number if @state is CPUHP_AP_ONLINE_DYN;
+ *      Positive state number if @state is CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN;
  *      0 for all other states
  *   On failure: proper (negative) error code
  */
@@ -2517,7 +2517,7 @@ int __cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 	ret = cpuhp_store_callbacks(state, name, startup, teardown,
 				    multi_instance);
 
-	dynstate = state == CPUHP_AP_ONLINE_DYN;
+	dynstate = state == CPUHP_AP_ONLINE_DYN || state == CPUHP_BP_PREPARE_DYN;
 	if (ret > 0 && dynstate) {
 		state = ret;
 		ret = 0;
@@ -2548,8 +2548,8 @@ int __cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 out:
 	mutex_unlock(&cpuhp_state_mutex);
 	/*
-	 * If the requested state is CPUHP_AP_ONLINE_DYN, return the
-	 * dynamically allocated state in case of success.
+	 * If the requested state is CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN,
+	 * return the dynamically allocated state in case of success.
 	 */
 	if (!ret && dynstate)
 		return state;
-- 
2.45.1


