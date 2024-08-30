Return-Path: <linux-kernel+bounces-307929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81984965512
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13562280C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A92854278;
	Fri, 30 Aug 2024 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Wbn2i8tk"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7954673
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983514; cv=none; b=vC21qh6KGjMw/LdT7fw6foU3emFMiW97UfcI889HBG8+SmHBHZFvqiod+S4uuIxqK92cCkMXNC+RI8dAiVyCWhE07ZUlcJ3IAx+yPYyT8hVWr+t3atP6vwN/fz4st3YGphkfmlk+axjvsvs1ymtWx1HGageK38ZllhwdmypRZ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983514; c=relaxed/simple;
	bh=PQScFVLklN3b4uqseu3LguL99TZd6dgo3jvqJXQ1tw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9ZO0VxKOKImGd7JZn172BOTKwA1kb7lG87KOxmdkpex2yPMnEAVkqX4iZtJTYzf0bCStg7ZAd0d9PzunZ2013yEdLEpycre7RbAO+zdceeWRNjVWy+1t9JtdwCxf/LuUpvN1N1vLKuCuxsVUVMajgiJqQxdJBTU8dU+sjmrkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Wbn2i8tk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201fba05363so11814935ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724983513; x=1725588313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoxLTypTzSmD9Jrs9y2L3ad9JzSXceDl16Mn2x58Bwg=;
        b=Wbn2i8tkkrWedML+WlIC5IStc0Ql8ybE88D7lAMc0creEzLrnglu3f09wB6mMKHXbe
         CmlYjZE/LDUgqkg6wyb+2ftCmUao+nNToc5MauMDyeHCPBzP86kgoKOH0QHLyqVVbs1R
         KcCLw7oKvzHZGF/Wd0We36tqEADZy4ifSlENFTTk1wJxZPk1wofYDidvBTUGuv6KsBHm
         3e0SIXimLL1yO1FUIVicY3VWZrzk60pEbvscf9Brs0DtX23r/fzIPwuLNgsKbKSZjd69
         XG5SmYM9Oa5kGX1pirYt4RVqF6VACW1wmvEF+k7t6WTEC8l8c7DPjuFXJ72nTZ67BI2w
         CQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983513; x=1725588313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoxLTypTzSmD9Jrs9y2L3ad9JzSXceDl16Mn2x58Bwg=;
        b=PkvUeks8jycmY7LTUqNnLdZWqybt1WRpxuC3RErZWInRvcu+HLM7o7rf4syiNWfsRC
         YNqzEF2+5a0sjbz82xtdqTXtqPBGzXTV3s2EiTLMDQEtP/w5bMRprd8geQd0TYBmFj81
         KTzjt6wz6LCiwSRzc7pXBojmXwH0BjAN2MrdVtJpH5IQHbN/7iJeZaYYwA9JQwjEscW9
         KZxXVKQxZC6VMneGbcnh6XTXjjvaL6Sa7ZO21M+EKmH01gGRIb2SJKB4Ckb5FnsjhTUn
         2mp45CQsTuOwHq1zNw1NCY7PbDFK+JjImJcNBmaitpGfI4HXIA6IWNGvEn7mtDZyjr2j
         BAEA==
X-Forwarded-Encrypted: i=1; AJvYcCU5UxcK+Wjd+Sdz9/Q4+0BKcx1O+YfZ+Seq/RYcHisr1mWi4jzaCy0bCdLIZMQBJJUnXrfe78I1yOm8ECs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/safPJZRyJVZeUX91PM7MzjbvzESMHoSeJkGIoKl6VTH8nqf
	9RzQEQcFq9fSLaqS499hplwnO2MmJRcb+GczQzU08xiAUIhpP2RGgNca0kOmC/I=
X-Google-Smtp-Source: AGHT+IHZ0GbBErc3BAd/f206Xl6wkR9bcF4wNZpyvHMK+5GBX4qGLnnszFzDuDIBZl+zCRsd+z+JXA==
X-Received: by 2002:a17:902:e542:b0:202:301f:36fd with SMTP id d9443c01a7336-2050c23c7aamr56760925ad.18.1724983512645;
        Thu, 29 Aug 2024 19:05:12 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534444sm17643255ad.147.2024.08.29.19.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:05:12 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/3] Staging: rtl8192e: Rename variable bHwError
Date: Thu, 29 Aug 2024 19:05:07 -0700
Message-Id: <20240830020508.532945-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240830020508.532945-1-tdavies@darkphysics.net>
References: <20240830020508.532945-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bHwError to hw_error
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 519cad9e1106..15fda2d87da9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1506,7 +1506,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 				  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 :
 				  (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 :
 				  hdr->addr3) &&
-		 (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV));
+		 (!pstats->hw_error) && (!pstats->bCRC) && (!pstats->bICV));
 	bpacket_toself = bpacket_match_bssid &&		/* check this */
 			 ether_addr_equal(praddr, priv->rtllib->dev->dev_addr);
 	if (ieee80211_is_beacon(hdr->frame_control))
@@ -1630,13 +1630,13 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 
 	stats->bICV = pdesc->ICV;
 	stats->bCRC = pdesc->CRC32;
-	stats->bHwError = pdesc->CRC32 | pdesc->ICV;
+	stats->hw_error = pdesc->CRC32 | pdesc->ICV;
 
 	stats->Length = pdesc->Length;
 	if (stats->Length < 24)
-		stats->bHwError |= 1;
+		stats->hw_error |= 1;
 
-	if (stats->bHwError)
+	if (stats->hw_error)
 		return false;
 
 	stats->RxDrvInfoSize = pdesc->RxDrvInfoSize;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 82fef04e5784..76f53b797644 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -467,7 +467,7 @@ struct rtllib_rx_stats {
 	u8  SignalQuality;
 	s32 RecvSignalPower;
 	u8  SignalStrength;
-	u16 bHwError:1;
+	u16 hw_error:1;
 	u16 bCRC:1;
 	u16 bICV:1;
 	u16 decrypted:1;
-- 
2.30.2


