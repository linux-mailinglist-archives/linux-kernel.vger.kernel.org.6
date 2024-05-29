Return-Path: <linux-kernel+bounces-194574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015C68D3E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA1C1F24502
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755ED1C0DC4;
	Wed, 29 May 2024 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="nKazFgMu"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D813D8A6
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007774; cv=none; b=XxsdcjHaOZlaAWErr8pOjhtchTY2QRHbzfsj4+p1PLrFC8nC8KCXTgCgYvBrUUe92bsi4LMEW4TBlgaaYWvLeivIL2J+brbKv25jdETjS/Ej5DUIstAD7ON4lK00rPrsbs52c8MKMFRs/5HwGdeHi9HrepOOmGaBp0ePl0bodMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007774; c=relaxed/simple;
	bh=6f0OKuDc4xwKhf8DbPPMe4W1MttTNxW/9P8EiCBR1J4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WGd3SD0eK0cpEaZ0R2ZNpCLXX0GPO2nFgdvnNsiOQq/gGkJJAixBB8fHpAr+wsbOJgmC1mff56D7YFPxLD6wySqYSxXx/MizyvB0YkN4ebS5uU66cr021XGzQrhLsbrKa/hUbrg9NeVZHlFrX0wIu71UxULh4L11yMgy/xuwe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=nKazFgMu; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43fe05d6bc9so7716631cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1717007772; x=1717612572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzU5m9p0hW+uIvBBACeY6l1fdcE0COmEg3DhD8s4LKQ=;
        b=nKazFgMuPoVhc11uLX6HRLwRaW39cLYgdMP09MSA9t3qvM/D9KmH23ikFjmI/S6MuB
         6+GPQnVu6OKQlftsBbyn4nBF5andYm5XuXPnnxR0DBttmCWTtRfEPtn63ihi9JjoAcx5
         2Ul8m48F1A02kPAxWzYC0vQqjE6Q/TvqKg5u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717007772; x=1717612572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzU5m9p0hW+uIvBBACeY6l1fdcE0COmEg3DhD8s4LKQ=;
        b=q29iLFm6SGmkihdsQllzGf2FjYHChnxz6sI/JhNIEYp/oo99FW/l53YjqH63/uLPPN
         8M+2dDXBgR9z6aYnHxu04ThN0n1FHVBUAhcbpciLtwllgNeTzEQxGsupPcAlZV58SLtD
         0MKbVE27BKcy+3KueJPPAdHuf2szLFzJ+qU5ZxpKEax3eJV2tZFOrE7esuPLBghuXqZA
         z91wlebfGNJLcskFd3H6EJ9OTP+/u3LG4MQUK0PkFX+g/LoxwpdOMrfTHXdmKDHksvsK
         xr+rzCaFAi6ERKHLgh737hpPJPzg36mEYzTETaz/sY81z0b4A/Fd+rjzzJPHGnOfcgRS
         /hCQ==
X-Gm-Message-State: AOJu0YzuLOTI8iCoiaXI0LARCKwpaS5uRiZOKykprVXsTa8dOdJzw8Y8
	Dc30RYArwKF6yZGzptcauV/neJWeVNue55amflVRC1Gi6VeR0fciutP70vzgijC5OPBLHTdgA4e
	K63M=
X-Google-Smtp-Source: AGHT+IGK2EaJq8xTq5YX8FECXjkU83ooRyKqStSYH41hZ4iz47ckmSjtwhF7cxHO9/usWdOChGgaSA==
X-Received: by 2002:ac8:5f0c:0:b0:43a:ef50:e6f1 with SMTP id d75a77b69052e-43fe92c217amr1050951cf.33.1717007771517;
        Wed, 29 May 2024 11:36:11 -0700 (PDT)
Received: from andrew-laptop.. (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16b792esm57101801cf.9.2024.05.29.11.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:36:11 -0700 (PDT)
From: Andrew Cooper <andrew.cooper3@citrix.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Tony Luck <tony.luck@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH] x86/cpu/intel: Drop stray FAM6 check with new Intel CPU model defines
Date: Wed, 29 May 2024 19:36:05 +0100
Message-Id: <20240529183605.17520-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The outer if () should have been dropped when switching to c->x86_vfm.

Fixes: 6568fc18c2f6 ("x86/cpu/intel: Switch to new Intel CPU model defines")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Tony Luck <tony.luck@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ashok Raj <ashok.raj@intel.com>
CC: Andrew Cooper <andrew.cooper3@citrix.com>
CC: Alison Schofield <alison.schofield@intel.com>
CC: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/cpu/intel.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a813089ca408..a9ea0dba6f0c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -294,17 +294,13 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	}
 
 	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
-	if (c->x86 == 6) {
-		switch (c->x86_vfm) {
-		case INTEL_ATOM_SALTWELL_MID:
-		case INTEL_ATOM_SALTWELL_TABLET:
-		case INTEL_ATOM_SILVERMONT_MID:
-		case INTEL_ATOM_AIRMONT_NP:
-			set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC_S3);
-			break;
-		default:
-			break;
-		}
+	switch (c->x86_vfm) {
+	case INTEL_ATOM_SALTWELL_MID:
+	case INTEL_ATOM_SALTWELL_TABLET:
+	case INTEL_ATOM_SILVERMONT_MID:
+	case INTEL_ATOM_AIRMONT_NP:
+		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC_S3);
+		break;
 	}
 
 	/*
-- 
2.34.1


