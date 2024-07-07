Return-Path: <linux-kernel+bounces-243497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820959296E3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CE01F21733
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0149DD27E;
	Sun,  7 Jul 2024 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjqAzrPk"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9218029
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335182; cv=none; b=lztWNMeDTtbozwhpj9QhViHE5jZe+mjDazSj7xQvAjcZs1tX7ThfDp9rrOUD/M4k4XXBS8oClSbKws08LflsExPdo4B1UA+alUHcgHSTh7laqpxAEYJOJjeOEMN2Wgr17CaSf+Sii2o/wj0SU4zroG10NGHQn09GIIAPfTXjbTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335182; c=relaxed/simple;
	bh=+OdeM7Q25FxSsSEoW4motBu9ZOsamZSAM/sERqWT5bs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq6Lho4fOSH/DZNNEqnDB2xjboVhbS2d2Q3wMCjKtLqndyFDryTMTePBm+eNeUtTVztUuuRo/FYr7LlEW1S3lu5rAxrR5Clfbp1/WjwCcRe1AUQ+hun0+2guOrYapIcMmenoR09mC+5wjb9xZhLm6W7R78U1i+yKZyG8s1bDN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjqAzrPk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4212b102935so3367795e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335179; x=1720939979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6pDyIeoKRhiuoeVnWhq04lCY4A6A3zeGOBt63c/XD6g=;
        b=NjqAzrPktUYWJ+5w7RVYi8dam0xW4Nutm7OBQatWW9hYkPxsQyy8Wei4RI8U11ykT8
         mRlDg6V7VFS1wAa/qjIkbuSWDlVQPPRtQJS9JU/4oJp0PPW1Fq4xfK9kI8bi7794y1x0
         zxxVWhr1MdyL19nKk5PrLvZDRsRe4e1fXLG8YSgDbWNfa9ykbCn/TfO5Q4/5tyt/wpEU
         xBWeyRjn8k/L/scpHoLw0Uur9/6+aUjS4SDPkCYdlw29VernVcwOQ/cuwqGwe8etRBZS
         p/4vd1O6l+QnOVnbSX7yvMhlnhzMGTBJwtoyV5bDtsZ27mbEaJarFDpC+JihgGv/4zTT
         FuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335179; x=1720939979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pDyIeoKRhiuoeVnWhq04lCY4A6A3zeGOBt63c/XD6g=;
        b=UyFD4HJEEY4GRDxW8Q2WQHGvqwJLhOgZD6MDUdB7jmRZGUfrn2liuF0mMqVCCxne3g
         dImZYDIEyqdQkVe0NZ2uXPykSbjpE7rGUxp/oWrccEIi45Pk9LR4MX9eqYQklPELBwCt
         vljdR8JWaahIucXzOXgKFZxi4YW6znFn4DFHD2vEFW/3CtL6QH7M5tnNMh/U7cpIzEDR
         EHs6rDbSB18f1WU4IATRrCwxX2xtNAcAyNAlkGbP+Le1r4x6v99RIcFb1gZL0tK3NVOI
         M14pyQnerFRByYAThP7K4cyShfBy2+Y/a2ZCNDnEWcvv67glwiZvWPz32BBtWkBAyTPF
         Jm+w==
X-Forwarded-Encrypted: i=1; AJvYcCVLGKzfPTYB6yEzdcduEvqumdbIdEk41lpOsMTYFxemOd+6tDa13XurmbuTB15s99GwDoNabkcXHbYlIGwb8iiaogbxFOw0ccrSAyp0
X-Gm-Message-State: AOJu0YzuNqsuIDQIJRtkmCD7IEf2P7qDJxamdYAbFAgCaUo65tBjt+Mz
	4D0kzM/105MO5r8BxIwWbcdOzdm46OWS2y1Vn8ljY4MeS7iC36oI
X-Google-Smtp-Source: AGHT+IHWHB8202JzynzPEhTs+hGiUNfyPqzhtxQkibO3EG+cddHGQdZuHA9BmvdYc/DgzSyYpk3RvA==
X-Received: by 2002:a05:600c:3b17:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-426668f622fmr4682225e9.2.1720335179082;
        Sat, 06 Jul 2024 23:52:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42659fc902csm68702045e9.5.2024.07.06.23.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:52:58 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:52:56 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] staging: rtl8723bs: Delete file hal_phy_reg_8723b.h
Message-ID: <04db91723915fc5e542a49b37d07ac85f1f853f4.1720245061.git.philipp.g.hortmann@gmail.com>
References: <cover.1720245061.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720245061.git.philipp.g.hortmann@gmail.com>

Delete file hal_phy_reg_8723b.h to increase overview.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/include/hal_phy_reg_8723b.h   | 13 -------------
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h    |  2 +-
 2 files changed, 1 insertion(+), 14 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h

diff --git a/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h b/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
deleted file mode 100644
index da549b773243..000000000000
--- a/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef __INC_HAL8723BPHYREG_H__
-#define __INC_HAL8723BPHYREG_H__
-
-#include <Hal8192CPhyReg.h>
-
-
-#endif
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index c1d7249e3e9d..f9ecd9047d52 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -17,7 +17,7 @@
 #include "rtl8723b_cmd.h"
 #include "rtw_mp.h"
 #include "hal_pwr_seq.h"
-#include "hal_phy_reg_8723b.h"
+#include "Hal8192CPhyReg.h"
 #include "hal_phy_cfg.h"
 
 /*  */
-- 
2.45.2


