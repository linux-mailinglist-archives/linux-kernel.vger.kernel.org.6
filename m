Return-Path: <linux-kernel+bounces-353671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77826993101
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2475C1F22652
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50711D88DB;
	Mon,  7 Oct 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOK3gmsC"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E61D7E31
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314550; cv=none; b=c6oRTQPvsXhJL5VpITTos1ZNtWyNjyLE24a4sD6fyzUrp4tMSaaEyYA9Pi5dmdjuticTthqIPg8bXgwUAWJT6Dj4djuOP5LaN9E4InTvIjlrOR1GeEgGU6MK/OMspJE37whJXuZfFWaA4mpeZZQD07gXZs2RTEuVao/e/lUAsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314550; c=relaxed/simple;
	bh=DQQVfGrS5RUHTZ+tOB8qSUpU88TcHxUfCXR+O1O7nys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3x58lStqC1q9XosSIrizewoek6j1KrIFDGAF7HUO4NQRh8loG3cfsyjWewkBVmebuPRRby8HyfG4EGQoy5i5Ew/g+X/mbjKazdjN7qqPaNEh3BGmGXDGnafF5f5wKAAN03y19VfA+szirDpbPYVWuuMqJyzi95eqlOPoj9/UmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOK3gmsC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71df8585a42so1371867b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314547; x=1728919347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2en3p3K0idvwobjjiOo582pKirErAeqEZWAXl8QOuws=;
        b=NOK3gmsCSniQ7truhZsNas4FJZT2b4K883fttttxYpoGnotTMtqWhlfdN/d+pu+8Zx
         3aKPPw5hnaTmIlwvYVD5h1SkfpUgF78XjSFgY7r0Zq2p5lZkTaIiYnqr8ky6OMKpm7kD
         amTuPx24nADI2Na8DS3vgIAjljJpLTQ+XpLh3o9uk4bIVSPoi3iA1/7MjFv0EZ3aH6LK
         XgxuxA+8gYlcz2S2sAsrLySvPoTRhgyBOC22E5/JoiLlLoTSng+4ynPT1JAdU8OsCV9h
         bxflSstdlRt9iBPBBi0Py9GbglQmIYshjRkOcnYqCyvWlk7nane+pXWDSCujqevE0eD2
         zDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314547; x=1728919347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2en3p3K0idvwobjjiOo582pKirErAeqEZWAXl8QOuws=;
        b=vl7L41jLSEbvPx2ASsTd2563ZFn/f2/70Dtg/aJKcwK+ZjJMH+jWMgQI+ro4Pttl+C
         0fnm7KWCYjGxpZOMAKYfvlgRudXf3rOKpK3uS0F/qjOXUUUTkMXN7d5q2uCqg0kXXkCH
         HIyuH1+7g1s+KYWtTMedQOlFQbQ1lsGuVBIDOs3EUbvZUS/IOzriAEbwl1MIUWRkmTHj
         cv3RrlhOcFEOx2Zbq2CNI/qTFTBr7QBrYdxTBkpHdyBZetD5IgMCACu578oj8Oe9fMB7
         tjbisEBL7fJDh+tnoNwGaldU0+yB4hiw7yPwGu3R26EQaQq0u5gDVevjglbwvb9lBqSy
         8hOA==
X-Forwarded-Encrypted: i=1; AJvYcCWv/1DE5tjlDzETZs98D049P5bZDdUOXo/x1yCkzEu8E/+qV/lIF/92jkoRorhtNhR3fcW//pg5ej2ajS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XC0wgTz+1G4JtT5IOBBCj6EEGl2dtahGlmKDdGXpBMb0uj/B
	+/2VQs7V9Qp575RhgTZ9wV+llwTawUI3c06i8vNHf9UYathIcG7I
X-Google-Smtp-Source: AGHT+IEOIuARC4t3bbCfRUL6FjWcjVTlAwmRSxsVCma2x9vxwVwrkHaImWNCBrRMWA6Q2aCcSvQd0A==
X-Received: by 2002:a05:6a21:3305:b0:1d5:10d6:92b9 with SMTP id adf61e73a8af0-1d6dfa55caemr17683670637.30.1728314546949;
        Mon, 07 Oct 2024 08:22:26 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d407sm4493234b3a.210.2024.10.07.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:22:26 -0700 (PDT)
From: Hridesh MG <hridesh699@gmail.com>
To: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Hridesh MG <hridesh699@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH] staging: vchiq_core: Fix code indent errors
Date: Mon,  7 Oct 2024 20:52:12 +0530
Message-ID: <20241007152214.23240-1-hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace spaces with tabs to adhere to kernel coding style.

Reported by checkpatch:

ERROR: code indent should use tabs where possible

Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 1f94db6e0cd9..3f3ef1ca7154 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2761,13 +2761,13 @@ vchiq_bulk_xfer_queue_msg_interruptible(struct vchiq_service *service,
 		state->id, service->localport, dir_char, queue->local_insert,
 		queue->remote_insert, queue->process);
 
-        if (bulk_waiter) {
-                bulk_waiter->bulk = bulk;
-                if (wait_for_completion_interruptible(&bulk_waiter->event))
-                        status = -EAGAIN;
-                else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
-                        status = -EINVAL;
-        }
+	if (bulk_waiter) {
+		bulk_waiter->bulk = bulk;
+		if (wait_for_completion_interruptible(&bulk_waiter->event))
+			status = -EAGAIN;
+		else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
+			status = -EINVAL;
+	}
 
 	return status;
 
-- 
2.46.1


