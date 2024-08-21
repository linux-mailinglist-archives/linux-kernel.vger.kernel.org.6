Return-Path: <linux-kernel+bounces-296239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB1C95A80B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A497FB21F90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4046A17C7C3;
	Wed, 21 Aug 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtEeogBO"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241817A924
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281580; cv=none; b=HOThro8hyiEseQupwz+RP6qjzdEml/ZmgVO2B00BY8xzWhXn7S2e6Y2kAw87C+cQY6UjU7otp0IxMRFMVV3gj3HvJ2mVaDEM3fbG1LVH0NQFdvs4XJYSXnSn+9lCVhrrTKV9ePhxIy6pQve+HYfIuP9iEU2sawyxJUNT5uCvv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281580; c=relaxed/simple;
	bh=6hNk9e2UJVZwlstXMPYh1DVJSpZvzE7EkgsrAtnLwXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxdPF3N6WIHP4AArY2dYS3lgf6jYyGJwm2FJGFAsyVSsCXS2nedDq41j+zKRPjvutBhro9fWqSCgaf0SOmuq4JupTSfh16x+7S3wUHRw3XDfySsDiTlM9WnLc+ZivlatGkkJJ/ZkJwSH0FKrIfIpB5lccSygh0MOGkCQ9A4WSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtEeogBO; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7106cf5771bso193711b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724281578; x=1724886378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JYgy2mO7B9WkjZc16hmBlriFY5uzQgt+dUrYiCZERg=;
        b=FtEeogBO0kI+ExZVGiCB0j85lGJzE4jYlsrXZWSN4oyMpL38VQbZZhxMZXvtdikz/Z
         CgUfSMPs4jkfGFmXq2pKGGTn8vZvt+AD15JfLNcpexKcA/HpB5qtxfWF+1bRPA/3QkIt
         iodwA5TiIZCH9R5PA61ylIQHKh2j2xl7nvR4+TUebLXtO2tEUOMFCT/sA/7rm3cUrXeQ
         WhrChM5eis7Sycjh6c1+8gDgxJ4qmDuOP6Al7+3y4AUnBfYRSYq8ax03cQuoF7WzJRFh
         rkemHZRzCd1C+sq1yVCcpUgaddrPmjg9bapqA/CCsHqW3dLhK/WipbWjS/QoGizDE323
         9I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281578; x=1724886378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JYgy2mO7B9WkjZc16hmBlriFY5uzQgt+dUrYiCZERg=;
        b=EW2reZlt1eN3PJ3yOYI8+IftDS9DEbsSpqAuTD36yv13HwLuYmz5pqVGO1ebQ+DV5h
         rplRWr6DLCB8URvVg8cNmPBleSlJbMFN185EYMWbaHSPsaGjpWwjHKuRHeT3Hhr/tYPg
         Ij00b0fRz7ALjMmnsPaSf9pjsU5LumMTagkQBFRvABBFL+LnmqMLGp/7O+b8hHyLIaO+
         uvrgyTJj5HKN8OACeINRXQQTnZCrSIqNZqVwV1NI/QckxlCMubLb6p92/n8XT2EBibPZ
         Bm7HG9+mapKbfTlGf3dcgO4IxvKLSADfKOUyA+ZRni3OwmlBAU7QXyF98k7RkXTFH4+I
         umAg==
X-Gm-Message-State: AOJu0YxXy4KFqqaGDN85cXPI0PUXKCLbOrKMAildr3hodMHyTJprvfYw
	bpzuVLiqfluO3RUKwKggFkat96tuCMuso4J5iU02FCAirv7/7HZX
X-Google-Smtp-Source: AGHT+IHWeoiz+aECf92Ri7281VwEPf/0I+K7OqHjM4FcrWKptmVsHw/fALssf8mlgiaZBXtoSoStsg==
X-Received: by 2002:a05:6a00:1898:b0:714:2cea:1473 with SMTP id d2e1a72fcca58-7142cea15bfmr2722751b3a.23.1724281578259;
        Wed, 21 Aug 2024 16:06:18 -0700 (PDT)
Received: from localhost (192.243.127.228.16clouds.com. [192.243.127.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343972e3sm170889b3a.139.2024.08.21.16.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:06:18 -0700 (PDT)
From: Woody Zhang <woodyzhang666@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Woody Zhang <woodyzhang666@gmail.com>
Subject: [PATCH 2/5] list_bl: add irq variant for hlist_bl lock API
Date: Thu, 22 Aug 2024 07:05:36 +0800
Message-ID: <20240821230539.168107-3-woodyzhang666@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821230539.168107-1-woodyzhang666@gmail.com>
References: <20240821230539.168107-1-woodyzhang666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variant makes it easy to be used to protect hash list that can
be accessed from irq context.

Signed-off-by: Woody Zhang <woodyzhang666@gmail.com>
---
 include/linux/list_bl.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..7ce411567fe5 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -153,6 +153,27 @@ static inline void hlist_bl_unlock(struct hlist_bl_head *b)
 	__bit_spin_unlock(0, (unsigned long *)b);
 }
 
+#define hlist_bl_lock_irqsave(b, flags)				\
+do {								\
+	typecheck(struct hlist_bl_head*, b);			\
+	typecheck(unsigned long, flags);			\
+	bit_spin_lock_irqsave(0, (unsigned long *)b, flags);	\
+} while (0)
+
+#define hlist_bl_trylock_irqsave(b, flags)			\
+({								\
+	typecheck(struct hlist_bl_head*, b);			\
+	typecheck(unsigned long, flags);			\
+	bit_spin_trylock_irqsave(0, (unsigned long *)b, flags);	\
+})
+
+static inline void hlist_bl_unlock_irqrestore(struct hlist_bl_head *b,
+					unsigned long flags)
+{
+	__bit_spin_unlock_irqrestore(0, (unsigned long *)b, flags);
+}
+
+
 static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
 {
 	return bit_spin_is_locked(0, (unsigned long *)b);
-- 
2.45.2


