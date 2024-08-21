Return-Path: <linux-kernel+bounces-296238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A9595A80A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF6F1F22B61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942EC17C7C4;
	Wed, 21 Aug 2024 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQyGdj+E"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2A176FA0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281570; cv=none; b=e72Qw0PmSxK/BrR8JYgQVvscfgvWUJ/PeAU0h4uKOgqOa1SupmNBLZp2OnFstWo7d8wM9kfs53PXZ3BkiPY+RhO+pb/gNBFAGg6x5KOsCy8jRGiPrZKTcx18vzRQoPk7+SBrB+ffhD3oXiZe0LMIBI30/WH56Rg10rodZL4n0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281570; c=relaxed/simple;
	bh=jzrXL2/Wc/gnh+jcFVlQt7TwdpbKVZ8MiMKPdu9H99U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAH0UEpOCZUwxCLhOybSAIwbBhym8m4qHrljhjfgEV0v7/qCVdvB1t1dSIXAlEbDSgRxTn8lFvQ93civt1YFCHJ2Df5l1gbv+BdaEMbYvBT/q5hEIHiiCtKztqUkHYPndhxcRHfly2Cva1WLrPWWS2KdYDKC7NcqhUhpuF0gBEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQyGdj+E; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2021a99af5eso1824215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724281569; x=1724886369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKUMIFDlDxML5PfSkH8a/brAuUCM0XB6TZRLngrEIFo=;
        b=bQyGdj+EclBpi48379r6UvOmlqQ+UcNLTrvs+R7TFUV+k/ZxuhxcPoFf8CBRk+K8ky
         thl5NWlol+ZteKEuFY8fxAA2RO+bdbH24bFeHO0o4X436qNbpadhcQjd+eL42LsYdh1J
         uMTiOg1B2HgnTFHGTP/biwBrWY8f0IlFNRQFNhHe8oMubBkodlEM/rqGxxm5smzU1P+R
         oOwDuu86gPEWrXX5ObgwWTZOZzlGbNSR6YmOqSo6wQzEaU0sLlRmNcRUE9SCDS3erXf8
         bdKj43wyvt8SiYFx0JY08JRqAP/Zbro4yBgNX67x+YsNJ3VDz/84QRJTGUwjajEa/kMv
         e8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281569; x=1724886369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKUMIFDlDxML5PfSkH8a/brAuUCM0XB6TZRLngrEIFo=;
        b=MRfsSKP+HXyWRFzONnAjL1wBIaKbcoCbuJlMulbElfktnlLiLT/Kt9YPmy4AYjP7zh
         nEonLi3c/W70qLdwVAtWgKXm7ctO0pWzdPGZSIJ/aIk7gABJ8Q6YMNT6JUVpE3VRpQKw
         kkz2ZCGaF575k45PMuqTAUZyIn0ZPhGyc8mcBomWcdkwT9pDvv4TNu3IcGPP1JlseCYW
         rakDdtVdB8CXwUloAapoX4btRV8OHmhHqb92jYClUJAqqBtT2+4UygnryswU3mcyvO70
         8lhKM04rgSQqwEYiqP+3U5amXb0la0ClsPpPTb2kQbCEBsHG9r2de3ezYGxLP7t0dEqS
         yPTw==
X-Gm-Message-State: AOJu0YyO6xCMVQVuo3YBmfsx8A08CNAujdbt5g9fmXLlj12A3W1lmwk5
	cUe7rd1KKNspyzl8dFlsYL/TO0sfBVZnFbyNxZuSi0+qDF148Nnv
X-Google-Smtp-Source: AGHT+IEIneXRyLEnHTQM+Mgu7X5rFgB0b/SNpcbcwYF5eqGbonCqHaHsn/QxfJsqm3Si1Ya41ZmcTg==
X-Received: by 2002:a17:902:cecd:b0:202:2d:c87 with SMTP id d9443c01a7336-2038820fb1dmr1438735ad.12.1724281568671;
        Wed, 21 Aug 2024 16:06:08 -0700 (PDT)
Received: from localhost (192.243.127.228.16clouds.com. [192.243.127.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566509sm1182065ad.36.2024.08.21.16.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:06:08 -0700 (PDT)
From: Woody Zhang <woodyzhang666@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Woody Zhang <woodyzhang666@gmail.com>
Subject: [PATCH 1/5] bit_spinlock: add irq variant for bit spinlock API
Date: Thu, 22 Aug 2024 07:05:35 +0800
Message-ID: <20240821230539.168107-2-woodyzhang666@gmail.com>
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

This variant makes bit spinlock easy to be used to protect data that
can be accessed from irq context.

Signed-off-by: Woody Zhang <woodyzhang666@gmail.com>
---
 include/linux/bit_spinlock.h | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..5a176e574a8f 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -6,6 +6,9 @@
 #include <linux/preempt.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <linux/typecheck.h>
+#include <linux/irqflags.h>
+#include <linux/processor.h>
 
 /*
  *  bit-based spin_lock()
@@ -97,5 +100,39 @@ static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
 #endif
 }
 
+#define bit_spin_lock_irqsave(bitnum, addr, flags)		\
+do {								\
+	typecheck(int, bitnum);					\
+	typecheck(unsigned long *, addr);			\
+	typecheck(unsigned long, flags);			\
+	local_irq_save(flags);					\
+	bit_spin_lock(bitnum, addr);				\
+} while (0)
+
+
+#define bit_spin_trylock_irqsave(bitnum, addr, flags)		\
+({								\
+	typecheck(int, bitnum);					\
+	typecheck(unsigned long *, addr);			\
+	typecheck(unsigned long, flags);			\
+	local_irq_save(flags);					\
+	bit_spin_trylock(bitnum, addr) ?			\
+	1 : ({ local_irq_restore(flags); 0; });			\
+})
+
+static inline void bit_spin_unlock_irqrestore(int bitnum,
+				unsigned long *addr, unsigned long flags)
+{
+	bit_spin_unlock(bitnum, addr);
+	local_irq_restore(flags);
+}
+
+static inline void __bit_spin_unlock_irqrestore(int bitnum,
+				unsigned long *addr, unsigned long flags)
+{
+	__bit_spin_unlock(bitnum, addr);
+	local_irq_restore(flags);
+}
+
 #endif /* __LINUX_BIT_SPINLOCK_H */
 
-- 
2.45.2


