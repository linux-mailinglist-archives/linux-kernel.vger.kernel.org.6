Return-Path: <linux-kernel+bounces-320383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFC797097C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583011F20FB5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B018801A;
	Sun,  8 Sep 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="dHtDpadk"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BB1862B4
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823609; cv=none; b=g0ruU1lW1Wd2DfEn7XVTXtrQT2VRSbLTlAeHBgFI/s+bpJiueLIjfhWp7+qJaAiLgCWMUIJ6w1M3nb8z9jswbCvtKUEAIFlBEBWkB0/FlNpqjmgnQLHvd+QlLLQmPEOMq3O+aGN5WcTSHe5I5F9oOcgJcGsljz0dVJGTNqbgpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823609; c=relaxed/simple;
	bh=JzkYesItRdPywlcTwoNQUMjC7AQGa+S9Iz69eRwz31Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPU4DIaLkGoI8I2ciqwD8zRtUWRdFEt/z62hHPGHY43LusyS9Ax5qSR1FNsXEovuLaDuT24nrmNe65bSXOrZ+6nb9FD0kX+jkKOM0zeqNKdH+is46B27ef8GC7gROppvZuTpTbe6pCgrc5sbSCHqKk+QY37hFoApIMelkVdY1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=dHtDpadk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d50532d335so1277009a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823607; x=1726428407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b2uQ0KLJAAtQJ2wmUi2c9S1xBAjjzTRADBi7POwrfY=;
        b=dHtDpadkZvB5/vH8TYpTwShQD8aedY7qkWUspAyigWKJ+YM+dboZB0Nz0aFdeJi+ed
         vo6LOMbyxMQIEvlm0i3tiW70+jSh4D/CB+4DyowOaMrbFuS6RzALQXg2xNSMxu3WRDJA
         pQsuE3Wa9Bcdi5K8TRM2QypK5XeJz0/pZoJhSTWgfeE6UfS+z0p4DBms6AwT2eoBlYGG
         JWdDuxKPsTUcb/ZGubOxWcZnbe3BsLKftKmhv69ox9E6xQUTCzMy0Pgv/2sNOYZ0wjAM
         HuEn/C4f/SaJLUzCfgr3A28Z9zCzGui7Ew9LxOfBjZv2O2/UqaTthWltpBl1Kmj3aFhm
         D42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823607; x=1726428407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3b2uQ0KLJAAtQJ2wmUi2c9S1xBAjjzTRADBi7POwrfY=;
        b=rkcXhdKQ/qIESZppQ3lJo11zdWP/b4oYK14wwaK+qfRivmMtr8nDBarDIbj9i8d2FZ
         qTGaC8ERQ0DYOBinLel46Ar/7UgF2GnWkQn7vhu/qOsZtK0we1zVd5fYThhA/BERGolY
         vh/LCc0KjlYA05kQuzHjzVcubyA6taaCYCPr+LSNgaj3lFN6j27VljYPo4GdAWMBz3pK
         QoeuWHq0I2KzfkUvlutWlsQp6UxVqRxKQa5eNhitAQvNbpn7I7qO6IUclyEYAlZ0vGED
         aycdHQxYTcWEtDNikUw4pbjw/uYmNtuwBTWwYFtmhIlOgj+dN0b/9LGbIelYCYDt2GQD
         XV1g==
X-Forwarded-Encrypted: i=1; AJvYcCUr2DWGRygZWyQvmwWlXdMaBw65xr91blmUUnikXw2MdO7m3qRM45MzGTr5C1wXwrXbrsHNu1OK66h9vVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JVXhLauXpBLTSJ8COpCCJ+xCsw7Ko8EukErw5QYj389YlOGa
	knJQfuApDB2/N135KS/ZAySs+RAC+GO8VBhOHZa0nUT9Y/EUc1v2VIShJqZAwIc=
X-Google-Smtp-Source: AGHT+IHDxtbQnGaGi1juqUlvIl0ykr1sv4pKQVI8yozX2KId5ji/h6/YeJ0OSduDeyLYMC7fvWQDkw==
X-Received: by 2002:a17:902:e847:b0:205:755c:dde6 with SMTP id d9443c01a7336-2070c0d83b2mr72644015ad.30.1725823606904;
        Sun, 08 Sep 2024 12:26:46 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:46 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/16] Staging: rtl8192e: Rename variable nStuckCount
Date: Sun,  8 Sep 2024 12:26:30 -0700
Message-Id: <20240908192633.94144-14-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240908192633.94144-1-tdavies@darkphysics.net>
References: <20240908192633.94144-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable nStuckCount to stuck_count
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index a5980253183e..5a4113c97b1c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -860,13 +860,13 @@ static enum reset_type _rtl92e_tx_check_stuck(struct net_device *dev)
 			skb = __skb_peek(&ring->queue);
 			tcb_desc = (struct cb_desc *)(skb->cb +
 				    MAX_DEV_ADDR_SIZE);
-			tcb_desc->nStuckCount++;
+			tcb_desc->stuck_count++;
 			bCheckFwTxCnt = true;
-			if (tcb_desc->nStuckCount > 1)
+			if (tcb_desc->stuck_count > 1)
 				netdev_info(dev,
-					    "%s: QueueID=%d tcb_desc->nStuckCount=%d\n",
+					    "%s: QueueID=%d tcb_desc->stuck_count=%d\n",
 					    __func__, QueueID,
-					    tcb_desc->nStuckCount);
+					    tcb_desc->stuck_count);
 		}
 	}
 	spin_unlock_irqrestore(&priv->irq_th_lock, flags);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 5ff3fab72589..540ab4e34e70 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -107,7 +107,7 @@ struct cb_desc {
 	u8 tx_use_drv_assinged_rate:1;
 	u8 hw_sec:1;
 
-	u8 nStuckCount;
+	u8 stuck_count;
 
 	/* Tx Firmware Related flags (10-11)*/
 	u8 cts_enable:1;
-- 
2.30.2


