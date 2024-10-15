Return-Path: <linux-kernel+bounces-366584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE70999F758
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942C2B21FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0451B3953;
	Tue, 15 Oct 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="0anlkkK6"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA87B1B6CE0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020710; cv=none; b=CVrqWDoJlDG9rJxsGw4TGJifnfqR/T2NcQ07NuwtNrzg+RoKxwfTUZCbACOGxBWjFCwQMh6csfls2MpnaeNv2oOip/kdA7kgF5Rz/EbJ8e5ylpd360Vne0Xp0G3BmGwV1+z9zMKWQdzJ5Wt493voOmV+YKk4PkUxPANqilBHeHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020710; c=relaxed/simple;
	bh=3MPzAc5mm/Td1wN/0LfJ7lxh6mw6E65klofZVkDNSj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtHhctrXnu8v70088z3Qk8OiuxeOa0KyQZzL7FBIDPpua2EQ8lXuLYVvy+XPx0tbKhDaLBNWRKJdLbYg8i17WoHSYNMkf4Grorv50jsX7PhJapVSrxYuhM/emQ5Nf1fl+ks4Pv7cykSsdq/JRsl0isOUi98jPqVh3BHypwPPZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=0anlkkK6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b5affde14so35599495ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729020707; x=1729625507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=paWX0vjIceTNHtj5M3qpnChYLs9Zim+rhn02WroKkm4=;
        b=0anlkkK6UWUBOpVcjh8ziyb4NXmWm35Wqc9wUT9f81ug1Jec7rgj4OmsC1bAx1j26K
         yuADvMdRutwEt6zx8hdm50Mqv5Kdj7iQmUn1hCILaBbjd5+QJ34R9BckrR1VamEbVE5i
         nbmtMiNbl0VYm1u2E2BJmFF9ea6n0TOWzZkRjrNTWUDKmayOj2PQQG4tBQYxUZrUx2lt
         ppP8vvL8yAtPp3pCg+4eKw+9FPEnQS8wiAwrJowiTDuD3geYnJ22eFzr92dFfRMI/6Bc
         uZJYqPcxi89A7Hb4xuGyfUkTH/ynoXE2enryUyoyqCj1QHmR+gYPG431NDOjCCTarQtk
         6JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729020707; x=1729625507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paWX0vjIceTNHtj5M3qpnChYLs9Zim+rhn02WroKkm4=;
        b=dKNF4p+qGFquZCritbon8dO4oi3qFB/+Hg1XzdxGmDG+sPk734hgOtdboBJsQKSPTu
         CBX1qBY9jjM6mq4r0lKD0SMlhBXCycxNJepeKvHJaKzPqquO/7rWARoTt6PgzB4ypJ0s
         VJs4tZsYV/BH8t7e02ubKrm57FgsYpZqvTo1JwsM88y4V5X5YATzQnbjBbp7jnhlEZYv
         mdiv+9DfuMrg19Qhl0cqSKqWtbX3zxKxegJQjrDJkDVVF6tc5vUftvVH0kwreRG/54hY
         /NLVsrqg6FMFTDRRZhueoRsSD0hTjwRMDQ6gaTNfWdqbUxzRmUImbb3KayG3ujkD6tPN
         eWwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlqtSxl2nBNFX5+eqM1C76f9hxzClSysIWolFD6VtR+QPuzO8GRBFEvs4htcYTMC144MJvc1mGTDeyXQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJugoKz+DcHoPm4WRtZmAESB9JIlQjcF+/LqJOfK5bGpjfunPm
	9myFrQLpK+CmeSj6Vsv2bXcOj1Q3liVgAZlc/qo7qPjXTmNA56Nqm/M3cJ9PfkE=
X-Google-Smtp-Source: AGHT+IHtLTfDwQo39Vgb1mIVfVhDjaIFxsNNkqLBR7YB7rOsqgXVh2R0uxlTOXo63nSKZ/Yc5F25Xw==
X-Received: by 2002:a17:903:244b:b0:20c:eb89:4881 with SMTP id d9443c01a7336-20d27f1cbc0mr17589345ad.37.1729020706961;
        Tue, 15 Oct 2024 12:31:46 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d17f84e22sm15472335ad.52.2024.10.15.12.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:31:46 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	kernel-janitors@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3][next] Bluetooth: btintel_pcie: Remove structually deadcode
Date: Tue, 15 Oct 2024 13:30:12 -0600
Message-ID: <20241015193013.16790-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch case statement has a default branch. Thus, the return
statement at the end of the function can never be reached.
Fix it by removing the return statement at the end of the
function.

This issue was reported by Coverity Scan.

Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
V2 -> V3: - Removed that the change was successfully built
	  - Removed the link to Coverity Scan report
V1 -> V2: - Changed "Fixing" to "Fix" in the changelog
          - Added that the change was successfully built
          - Added kernel-janitors mailing list to CC
 
 drivers/bluetooth/btintel_pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e4ae8c898dfd..660496e55276 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
 	default:
 		return "unknown";
 	}
-	return "null";
 }
 
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
-- 
2.43.0


