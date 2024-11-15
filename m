Return-Path: <linux-kernel+bounces-410798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0861C9CE116
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B231F213A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F11CEAD3;
	Fri, 15 Nov 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b="WO309TWA"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2EC1B218E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680272; cv=none; b=EkCtj87DPy23DlqF7K3j69qPSu99r9AC4QkmrtVXQ7Mr73Kg2dbHiMT9Wf9kiVtYe1Q0Qij7Cf4x4RkNSr+l/M9S8vSlRZkSLZ0yENUafRWLD1SO32Lbg7awCgNKSLxcZCRM1kGLKXDPlgD2wZzo3Cz6qSt+MDNTVAvVaU6PqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680272; c=relaxed/simple;
	bh=L3xpZ/FFqX3wjwyttua720jfc/R05tAReQiCDMXpsdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UenkBJZYVqaqRxLJSTc6f6+YPaSLNUBZoVTUniRLpNL09NDVm07dcPf/Z6F6xpbv+xi0Ly40YL/LLb7qQwIWqLSkLCyZzMJstd5s4/pT5iX3hYqmtZrevpCchWaQ5av5bi0/sVq/91vgawAXq475+Q6pJJKf7Pz50xSAl2Hw9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org; spf=pass smtp.mailfrom=amundsen.org; dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b=WO309TWA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amundsen.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so7373461fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amundsen.org; s=google; t=1731680268; x=1732285068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji98jAueku6e1lv14MgUoovwYkrHFp8EgmSQx8sgEos=;
        b=WO309TWAZ9EHGiaJyMgNx4IuURJBIMAQe9q+fTVSefyw8FmG72ifNdZeklKYh8x8ws
         z5HdwnwaYWPhGnqQrmdTI1QdSipZZdOF2pwu7u5hX++xXaMonNjqcDUZ1HFU1sUkdbKl
         A8ZKFyNTEXvKQ/hlL4eYP+4ToMvjSo5kiWkGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731680268; x=1732285068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ji98jAueku6e1lv14MgUoovwYkrHFp8EgmSQx8sgEos=;
        b=xTGLtTcBHJEb8+8hPf1tA5zNrkLcu49ebHdlcxlZstre1QQ7+ILQ2+EUbkqJ89CW+4
         SyMFc2neLVH2QgYtettepMtjOgfcalGbyJYsCUpjb59H+n6d8LVsa4Z5PWy8/OmAr8XQ
         OOpVplwrRq5tbEOh3JBBp+UpvkFW4+QzMjOWt+sTx/7bka1o44pFSFjXvBPduxV3Qjez
         +yoJ6GP1AqQ8mu75ur9TL5AIBt+atQERqmYA4whEtberUQ0YRVrnif91JCOZ8KGhZd+y
         il9NFg6SzxVF/BOEB6vXU+8OOWJUI3iRNmbqj19qp6xbYDUHZP2l+1za3zouYudJhURx
         fDWA==
X-Forwarded-Encrypted: i=1; AJvYcCXtoRg94RsYJ02O3K2M+J0SfFW2D/OXc1+9x6mjOLJublQo+npbd+usxRJ+erNZxtDo9YefFh3+Uh7bIqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXj4HVztgNBueHzgGblb51PjJ6UYnSRV+nHpGGMAZEV/9iUuLE
	dbkB2hujnBP9xyQH222YS+fHsYmDXgImv8fVx8eEBnMxcyAnR2LhQBIe/xVg1I0=
X-Google-Smtp-Source: AGHT+IGVhdFKt8T6HX7yVrULBvS6gpPhEbblidatFeADEvWpgf+4fMZ34SXLF0m/q5wdbPdVX9sMbQ==
X-Received: by 2002:a05:651c:b27:b0:2fe:f8e1:5127 with SMTP id 38308e7fff4ca-2ff60665f0cmr15414471fa.9.1731680268056;
        Fri, 15 Nov 2024 06:17:48 -0800 (PST)
Received: from localhost.localdomain (77-95-74-246.bb.cust.hknett.no. [77.95.74.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff5977ab18sm5588441fa.46.2024.11.15.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:17:47 -0800 (PST)
From: Tore Amundsen <tore@amundsen.org>
To: netdev@vger.kernel.org
Cc: pmenzel@molgen.mpg.de,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	ernesto@castellotti.net,
	intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	tore@amundsen.org
Subject: [Intel-wired-lan] [PATCH v3 1/1] ixgbe: Correct BASE-BX10 compliance code
Date: Fri, 15 Nov 2024 14:17:36 +0000
Message-ID: <20241115141736.627079-1-tore@amundsen.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SFF-8472 (section 5.4 Transceiver Compliance Codes) defines bit 6 as
BASE-BX10. Bit 6 means a value of 0x40 (decimal 64).

The current value in the source code is 0x64, which appears to be a
mix-up of hex and decimal values. A value of 0x64 (binary 01100100)
incorrectly sets bit 2 (1000BASE-CX) and bit 5 (100BASE-FX) as well.

Fixes: 1b43e0d20f2d ("ixgbe: Add 1000BASE-BX support")
Signed-off-by: Tore Amundsen <tore@amundsen.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Acked-by: Ernesto Castellotti <ernesto@castellotti.net>
---
v2: Added Fixes tag as requested by Paul Menzel.
v3: Correct Fixes tag format and add Acked-By.

 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 14aa2ca51f70..81179c60af4e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -40,7 +40,7 @@
 #define IXGBE_SFF_1GBASESX_CAPABLE		0x1
 #define IXGBE_SFF_1GBASELX_CAPABLE		0x2
 #define IXGBE_SFF_1GBASET_CAPABLE		0x8
-#define IXGBE_SFF_BASEBX10_CAPABLE		0x64
+#define IXGBE_SFF_BASEBX10_CAPABLE		0x40
 #define IXGBE_SFF_10GBASESR_CAPABLE		0x10
 #define IXGBE_SFF_10GBASELR_CAPABLE		0x20
 #define IXGBE_SFF_SOFT_RS_SELECT_MASK		0x8
-- 
2.43.0


