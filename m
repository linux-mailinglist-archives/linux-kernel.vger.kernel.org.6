Return-Path: <linux-kernel+bounces-340866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5540098788C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0C1284192
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E541607AA;
	Thu, 26 Sep 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hAXupSly"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1E3FF1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372657; cv=none; b=YWOGqD9e7KEWFae44vFiQSh9LFGblucWDWcs/4O+xfbKenrf+Q8qblYO2JqPnJdi3JZj3gVINOrFult5AUolTlocXCmLWZ151tceqHcLGXBx3LjPb7z9/ynHhUoDImKq5/Yn8cGIWSTYWJB0rc98Xw2a4UxOvpHvxbfjJ7i40Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372657; c=relaxed/simple;
	bh=X/SBcrUhkDBQuYp5RI4cnhg6PNKuuJU1AAD6kMoNGV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upiTWRjHJS9q4VBoBKzbayVZVVJmfOsLv2V8yFbHLZXxYhrAkAKr0GKAQHjoqag8R+PPu3SmOJW9wIQBJY5qDFkphqC3jiyb1mydfqF4bYF876CrQtptF1JaQeb5VVvzVcoPk2dYY1bPl5EmJPjW3HUu7Tg44wNjm0rCNYzu4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hAXupSly; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2068bee21d8so13323995ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727372655; x=1727977455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qs6I4f1uojUFYR+5tPBYaQFjbQJjLMRwZ7Cac/Dqebc=;
        b=hAXupSly6cT9WjTEPXjvzTBzhue3Bqghg2Gcq768JTT4GC4mC/yWJ4KDeq1U2ID6KI
         4YdVeQY/IJ3Xl/XiX8NtxB5S/Xs6nn0tyuzfHISllBDlwlU8al0hpSZvIkKhfO309+J7
         UzSVkbffYIiFbMI6h+DAzm6wP42AvBwX28HZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372655; x=1727977455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qs6I4f1uojUFYR+5tPBYaQFjbQJjLMRwZ7Cac/Dqebc=;
        b=EZcdf2VoWjPH10D7tMB+mTOeURNWMfxSxsuQy+o4PVsPOHR/XU/fn7mDN/JbNihM9b
         uxmiRMYzSibBWDqO8i7J1GIyXRFR2BaVr0SJEVuAKbNh/Y0RENeWDE+wShWwC/KTAOpJ
         YcCPci/RAUeBy6QYGt+Fp9MTnX14Ln6tjDJJLkQjZJ0zOaaHnK58mMxoyuGWdlljIo+E
         3JwtQMbMmyGdkL/6JXeIPBVqCbRbKySYPSLSrNUfNJZl6GL62pBdJZCU94+8lcN2wS0+
         BzzSgGb3h2eCsrWnHbBfl4FoVP4ZngJ2TLq2CJEj7Gl3MWN+NIc0CTBM9+5z2p4Ztq4V
         zzCA==
X-Gm-Message-State: AOJu0YwrqUzuwMPyZaswyy95MU3KGrHcgzwaJHMSwkMVAN+frQeN+Wpu
	FRsfq2qm7jaFvUthZqcsltG/s0Be7S2EdRbBFrlZSpNbdm5+Qxm6O9Y1Qyeyt/BK8VDxAbVJPwD
	wUork2h86ejSow2FQ16y+ZJbWP6aS8sg0RmULfM/D6IS6HxSCO6TA72KFd+cRSkkVkL/EcS72+i
	0QtfTy/PDzJfwJZbnjJRBaQQsrL1ejezHBWztGVhtqIWFYLtq8KPxo
X-Google-Smtp-Source: AGHT+IGMnGm70MLKXT0fiUChGM2Xw1hOYHqWy0UW4F66QVEzwBlTtQzKq2ZDP6zOx9lGK1tcCVB+GA==
X-Received: by 2002:a17:902:e884:b0:207:60f4:a393 with SMTP id d9443c01a7336-20b37391a8dmr7054895ad.27.1727372654631;
        Thu, 26 Sep 2024 10:44:14 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d4b2sm1128855ad.155.2024.09.26.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 10:44:14 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	konstantin@linuxfoundation.org,
	ajay.kaher@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
Date: Thu, 26 Sep 2024 10:43:37 -0700
Message-Id: <20240926174337.1139107-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in an email address.

Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Closes: https://lore.kernel.org/all/20240925-rational-succinct-vulture-cca9fb@lemur/T/
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c37285a4747..bcea524fa997 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17491,7 +17491,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24695,7 +24695,7 @@ F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <ajay.kaher@broadcom.com>
-M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24723,7 +24723,7 @@ F:	drivers/scsi/vmw_pvscsi.h
 VMWARE VIRTUAL PTP CLOCK DRIVER
 M:	Nick Shi <nick.shi@broadcom.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.39.4


