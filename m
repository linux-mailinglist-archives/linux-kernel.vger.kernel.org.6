Return-Path: <linux-kernel+bounces-409864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFE9C92A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77959284898
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB611AB50B;
	Thu, 14 Nov 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b="K75+XVop"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051019CCF9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613887; cv=none; b=fJxIowVLJpolHYbGY7DyUhBEa/ePPni5mnIBv9Ac0vBid1xgF+4W+0FnpiOLGY4O9GuTOCK1ca2gcXXdodctx0R8HSa6jEwjnYhtttrK1jJEH4Etc+Ed9n/s/K5PRv26Sk2rat8YpCxyJ69t8jWLzBwB0ShatPbVZocLw0tzW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613887; c=relaxed/simple;
	bh=EupYCYVmBmtFqE7ERsjzdBvWr8HIJUlJ4UMy0QJfrXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRmcfsyUgwRfCdWuz90FaH9ZVP+YYpOJeoaSH/GIkJsTgpBIowHCU/kXOUBwqr8qwOD3HOFwMLcEPhOeVs77Pv+RjX8VLmqZhWA1L6bnqVHBw4fGZGH8GQDSM/1wHQCadsaS8CpVCjTKJxG1oJ9P17wjGY7OKM7S1gVF2BrnQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org; spf=pass smtp.mailfrom=amundsen.org; dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b=K75+XVop; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amundsen.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539ee1acb86so1064994e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amundsen.org; s=google; t=1731613883; x=1732218683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUamNRwdHqaneOvXI0azbdJiLRkfCesKErrnB+oq0dg=;
        b=K75+XVoplnx5H0utnU9lMpv3yoV+1maUW0PpRdvVvEb/ekEWAcUcyeV1GkhkRBR+Li
         /ZbrgbipQzW2MymSClcODiyutiXzenhyGsekPevlYABaRXToDy/cDCpRypTQWLsQhvqk
         jsPCIGnPiEjUJwYwWZFP9zqDHK9j9m8aS208w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731613883; x=1732218683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUamNRwdHqaneOvXI0azbdJiLRkfCesKErrnB+oq0dg=;
        b=PDM+7ozvtSKRoAVZSQaT4eLrcDTodrvZfEZZs9q4BGmzYh7IGsQsvUiIRU3QPmlnsn
         mV/Uv+xSIEmz/ELOQpE+atygEx0JzqHnq/pPcp04+ggKOLXfWRhxthXmI6MWiUryiicb
         g6+IZare4dhDLpqZnuxKNnnL2TBVoS2/hwX5hwQ31qW9cmGRATptQJSP2aMDn1ytgMR5
         1TEnaQFbwoJPougi6JDUGQVAC0pHNj4thpbMHN+XdhDG0ZMAT2Ngq4kCH1BKpKqMTL5y
         BvO3yRoq//ERxBh3spYfe5xOBBHsb3UtcbYyh/cBGzrPsU1DdEBfKL3gzrAwlx1vrCTB
         pSNw==
X-Forwarded-Encrypted: i=1; AJvYcCWchbHLVg/axFWmW5sFX98tpgfZ+FGGklPNLsU1FJMsuHfuMIKPQqoGft4JUT3v7DrOV/okCxJvhla9cQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyImAaDGSI05t3UVL6zHTqmJPRMCTyDApezugJSxNAZHZ4uGAoF
	RKlTQH0AMR4DQXEtSfUWv9dZT6O0y++7WsiuU8Ib92Z1imxRew5TYv6h1YZOTbg=
X-Google-Smtp-Source: AGHT+IEBEehanLwEneeIOLJnVHbZhhye/fiGYEV3b8jPAjjxCTLWMT5lmYur9Jh3ksL3tfhl2Y/Ltg==
X-Received: by 2002:a05:6512:3981:b0:536:741a:6bad with SMTP id 2adb3069b0e04-53dab289f4fmr3648e87.12.1731613882471;
        Thu, 14 Nov 2024 11:51:22 -0800 (PST)
Received: from localhost.localdomain (77-95-74-246.bb.cust.hknett.no. [77.95.74.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6530d81sm288780e87.160.2024.11.14.11.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:51:22 -0800 (PST)
From: Tore Amundsen <tore@amundsen.org>
To: pmenzel@molgen.mpg.de
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	ernesto@castellotti.net,
	intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	tore@amundsen.org
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: Correct BASE-BX10 compliance code
Date: Thu, 14 Nov 2024 19:50:47 +0000
Message-ID: <20241114195047.533083-2-tore@amundsen.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114195047.533083-1-tore@amundsen.org>
References: <ec66b579-90b7-42cc-b4d4-f4c2e906aeb9@molgen.mpg.de>
 <20241114195047.533083-1-tore@amundsen.org>
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

Fixes: 1b43e0d20f2d (ixgbe: Add 1000BASE-BX support)

Signed-off-by: Tore Amundsen <tore@amundsen.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
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


