Return-Path: <linux-kernel+bounces-335097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D6C97E0FE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34531F210C9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 10:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A80518FC99;
	Sun, 22 Sep 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+8OBQmM"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F02149E03;
	Sun, 22 Sep 2024 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727002340; cv=none; b=DFgHs7zRdBvnhN+tmaKsP22xhmCzz81AUutbHts2DdPjtpwwvrhVxJuaNIet5Xt0nmCk9aUMX4zY2MPHafYiunlKm2jVk1WN2RHH38THygBQLJ/1mLXzGbCarECV21T9vhDxXKGDodyMN/UJa5Qw2sXrRDpY5u/+L3WwNOwUARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727002340; c=relaxed/simple;
	bh=i/tP2SmX/sJJ4OmN5277UTw+ECHWt6l3Fa3UC1PE/rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIOLKDj49//6Pg1ZZn7XB08HjPYOdsMUXPW3BxkCCpuTaa7oijGKAu2cNP3BWBZcAuRknyA6QtfNVbIDAbOKM1RMLAo573EO4hO+1aaDWZUlE2SrGzA0YYxs6Cs8E2D/AdlZkFnung1Nll3tXSPHliQPz/V8Jgk18kPhkkChrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+8OBQmM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2083635a12.2;
        Sun, 22 Sep 2024 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727002337; x=1727607137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYNkcZOOFAOULSW26CQqeju6OQug9C3qT2bdg22sMxg=;
        b=j+8OBQmMlbFIJ0Gw38uG2sUKy3YgV1ferkxYQOulyI6qw2HrAz4ef4xq/D1CTHzY55
         xw2If5etBDOaLl0BtkJlkd8OKHCtaYIMgjBqKGRlr9ejJ02+7Le1zacSNmvLtMiuHHDn
         TjV11caItXUGdkP+HxTIl4bbFtkHrFYd2ccRiYu8AwYajBTPXhoUX670PbSNteTGIdAF
         QzQuKUW9GxePOjWkVY8P5gpPl0W4vnK5A72xp8odYj+S7knSXaFUL728bP4t/Clr5BM9
         Yl0mjQI1udHP2vg4vkOoD7Ihs9XqojlPgbEV81wNvGuXss/QMkiLPSQTQNNIx4VBEl/P
         +RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727002337; x=1727607137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYNkcZOOFAOULSW26CQqeju6OQug9C3qT2bdg22sMxg=;
        b=nawlO5u5XoI7tReDOBaBMpp7ieQGxUpYF1VMoccw82bgO0x4/DNvi4QRLWbXsSys9g
         Kuwnw3HOmmuSGWq8AFvrSEKb4q+LefAcTVqAvNsIaLC6dBb9vmU8UIIx8/iMZd4Oc5aX
         jaSc6mc3vA+a01If/ZPujjfuxCb8C2isUpLAg3wemNwRIBr1nFVU7nJ0SdT8Nb5LyVJ1
         qkpQYX4H0Wvok08ZIOZ4hkcnAxIHg8sTDvk+haYn5IBTC/uh20C66LaxhIkS/HDWbJJ/
         DBDnOZiJA7TPme4JW2Wmu+FRT8QG+HHYfHBPZQnVgJFHlyMgHR0an/bkCeICe6aqexF/
         rriA==
X-Forwarded-Encrypted: i=1; AJvYcCVovC6vi5nI4fMnl2VNwGC5pQyycRAKyU17mnRcRQOakoUAHWs3AVGPq7uJTyoMOoOJ/UAoIDXVlo18a4I=@vger.kernel.org, AJvYcCXJKC5PJ5cdcXip4FvOuuapSskgdLIn5LKtKGCTZEe6zVFddS/SYHwqWR2r7O3nqdyHD+fxp1yUqGCn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7E5dgecNQd53fVPNi3z9spvMH4npBbkAAjMRqz9WTlzE1hb3f
	uKEcW7ChfmFeCFNi4iGDSTiDWRV2PZLKKb7nfJLm2PPFKxCcRfSI
X-Google-Smtp-Source: AGHT+IFvZ1yvhIrBeq1eSAv9RBCJNlkIZKOVfJgU9XgJ3CyKpfPUA+GO8KpCw9N6BbWHLM7zmRBrJQ==
X-Received: by 2002:a17:90a:e00d:b0:2c9:649c:5e08 with SMTP id 98e67ed59e1d1-2dd7f3fe992mr10597826a91.15.1727002337512;
        Sun, 22 Sep 2024 03:52:17 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f947427sm5222331a91.48.2024.09.22.03.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 03:52:17 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix  dereferencing freed memory 'fw'
Date: Sun, 22 Sep 2024 10:52:11 +0000
Message-ID: <20240922105212.28099-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smatch reported dereferencing freed memory as below:
'''
drivers/usb/typec/tipd/core.c:1196 tps6598x_apply_patch() error: dereferencing freed memory 'fw'
'''

Invoking release_firware(fw) just after checking ret.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/usb/typec/tipd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index ea768b19a7f1..eb5596e3406a 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1191,11 +1191,11 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
 	dev_info(tps->dev, "Firmware update succeeded\n");
 
 release_fw:
-	release_firmware(fw);
 	if (ret) {
 		dev_err(tps->dev, "Failed to write patch %s of %zu bytes\n",
 			firmware_name, fw->size);
 	}
+	release_firmware(fw);
 
 	return ret;
 };
-- 
2.43.0


