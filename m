Return-Path: <linux-kernel+bounces-542356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F14A4C8E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2103A53E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3E41F152F;
	Mon,  3 Mar 2025 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj9bpWSR"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A15253B64
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020545; cv=none; b=tqk0JR9WfaYoG+aaser37ewozJ32RfZ47vOJIGQO0t+DIMiTE3IECfj9pzEALApKFdvTu1Y0p23n82KTnmrsW55qpEhc0Oh2d3mDCzNYayC0yuvFHBnW+WM3Oz8V8WVtq54+YZkykpRGSBL4ucadhH9P4VotK12P2x3+ReQetDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020545; c=relaxed/simple;
	bh=5zzvhgf+9sezBXuMLZNak0Om4qDrOgevJ+eKDzFF/PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7EAMUk8dbBZabtvqkA7FiwQsDfSQG8JAdVQ4g1vFGJu/IsJwsSD1HNdC8X71MMZ8WOP+CmMzyPlqSQfIrce4i1uTcMCq/q1cR/2NwAuaHON98JnW83pj2rBqHzgqHxv2FC0NermLSwl32x2AnbK+qgEyn/PWAlvmhygZfSoUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj9bpWSR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fe8c35b6cbso7411068a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020543; x=1741625343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y+ZholA0ceJ7Su5jVZt+i8wcZai/pfi/b/zX4887Rw=;
        b=aj9bpWSR3k+JDC7YjXPIEUhSS+NrsylfLOnTIsdKdPD+xjXD/TzwH7jz1SaxOhW4md
         6h4g79SWG5tbxIS7FQCU6DKmUCpXDSHGfy8+2XczcYtfPLoga1b94aS0FZvwbod8Znvx
         /g7ZU4/A7WFSLiFtV/UERKgTf5ZoqdWFhI1aqHAjCoy0s/XIftzfNiZEqlLc4mL9tiI6
         jGE8TBmHWOzoqBtdevuJ1RvIGXYA9aaOoLKCUHV7OcvyrLojXlXu7GTR/YtcMX+PMED3
         NYDg3mrU5rQ1IHiLkJKWw+ry61AMO7eSwIElgJ1cnQUkROUaz5NVpL6FJ0y7QZ1TNRX5
         A0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020543; x=1741625343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Y+ZholA0ceJ7Su5jVZt+i8wcZai/pfi/b/zX4887Rw=;
        b=Fh4aHTyhwnqxm4M5EORzk8MQAAM3Wzv0Ji3lDqBPo+bfSGiAVke0JEbpHW87zrSsMy
         SHN8bTlDyhY/E8fOLinOezKlm7ozDhQj+P9QHxUfqdJUMArvICZ7VDfgB5Y8wPXtfjQL
         +64/JZ/iwmfP8mcZFzDI7p2/mprrU0suqAlDjREjJOhL6QyL3qRDMvP9bmNcVeaJp/kp
         MVfQO+76Q9MGbBwciUF7j72euOsnTv2woDrFfov6GLe0QK4Lc0AHytI7yQv8e4X3jhxU
         x6gIPq75dXoeavQyaO++Z2ulGMVx7nZS2shWr4H4HMhh+ntClQkzQ7WTjfZCL0YXPkuT
         ae1A==
X-Gm-Message-State: AOJu0YzKsyJ5AYdF5/JXUsUaKpvjBFvC0hHPZqjxD/mWixrEt8uKq3kJ
	ktG2pHQ8jZ+Rze+XMrhcK2x/OWAvZQp2VwppLnfNO9oYs/tRR5lJW3FhEbZr
X-Gm-Gg: ASbGncsmHQ8/t86Owyi2IELtRkAaiSdTpVVtdSdE72+fRtSAAL3WGbGa92UQlC0iFFC
	GHgzyQQ5kAxoyjLstH1nPmCLf6CcX3ilUZXjdUNqQQzydUDGDMJpdtABcsFX4ZUESkMGsxbzdk8
	ODOeNcIfs8aOHK7I6Lq4Pfc/NKXRG5D2wtV3HnEkXZfWK0pkKJ9h+9Nbk9iTBePPtygyme0g+rW
	UFFYCIyoAnVZmVHXkJK0CEL6mZ0M9Z8sRg3w88rYmEshx4M1FXfctw8me2gunuMHlXsfnNt5hKx
	3x1rzwkuNgjFXnSuwJR3i9uGuMHl8fbvxKgl8ZGNnmszngFCRhYGPE5FegHWYw==
X-Google-Smtp-Source: AGHT+IHa9E893IUXS94zHfGB1bLtpfRRUBkXPzB/2iQ420dArTjNANECMh7NNtwG13QgivtOKqL5dQ==
X-Received: by 2002:a17:90a:d40e:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-2febab6fb09mr23953304a91.17.1741020542734;
        Mon, 03 Mar 2025 08:49:02 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8427ee7fsm11168224a91.23.2025.03.03.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:49:02 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH] MAINTAINERS: Remove Laurentiu Tudor as maintianer for ehv_bytechan tty driver
Date: Mon,  3 Mar 2025 22:12:05 +0530
Message-ID: <20250303164853.94528-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Laurentiu Tudor no longer works for NPX. When I reached out to him,
he also expressed interest in deprecating the driver.

Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 The listed email laurentiu.tudor@nxp.com is invalid as well. I reached
 out to him via Linkdin.
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..236723980b63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8528,9 +8528,8 @@ S:	Maintained
 F:	drivers/media/rc/ene_ir.*
 
 EPAPR HYPERVISOR BYTE CHANNEL DEVICE DRIVER
-M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Maintained
+S:	Orphan
 F:	drivers/tty/ehv_bytechan.c
 
 EPSON S1D13XXX FRAMEBUFFER DRIVER
-- 
2.48.1

