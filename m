Return-Path: <linux-kernel+bounces-283027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7894EC25
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088551C2153A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981C177981;
	Mon, 12 Aug 2024 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osx7K8zo"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936114EC53
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463692; cv=none; b=RQObSKz4rySEM/trn3LP8cz6a5XjhLA3pL2horHXKvKx9mECfHx6P0I7zhVZoSJ8gSwLAKPctikm6Wjk6gjd6wSDQNL1JgJBQerMeBAzxGk758RZsJgcLp81DKu/Ti1XO6e+LXERvaw2ab/dug3wfmpYfT/V20r1r+hzHLXso0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463692; c=relaxed/simple;
	bh=QWlClhvl1V6vaNUyex8DYPJT19XTYVOdJcyVMZ+0QQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IvKy3UtL0n/RKk/HdnEx2yAa3Sxrbdm9Ysgtzi9UPBv+nXoOUJ/ybZxZSAKw8hRdRjWsx7F8Favo1MJ9D/tIUEzZx7xXT1xz+L33shP+qKtFdaTBQocfGPAd2mWDLVayRGO9kbNzw5af6WHL39Iz12zu3zVdPf54tRCKE2QKwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osx7K8zo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso2539659a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723463691; x=1724068491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3ZonBi46mhEZLiHiOrha/1ljHlHpnZOgRT2boJbT9A=;
        b=Osx7K8zolRHPpc29ioRARXMwHTWHfjQ1kERk1IwYMKq+gvOBRfFrJ+T0RkSYKR5f7L
         mKA8wNLnhb4YeiftVr0JGAUN7QvPipUptZ0NNHvQsaS8U/KD5zpn8YFXoWwCSWu0kpfH
         +sK4vL7S6aBPr9wOTCBbcXRB+qIva+6SHM6MIOkBj9s6FpDsHP2946hHF2R+G0Afpl9p
         A1QFPCChrk+biCv3/Bcg6n0+MnO4U8leFEiGI775ADVU8wStWvH5rv8J/zu+O4g9IFB2
         qNk1WLyp+mPy+Jpw9ZMpOuAna+bPk1hfcznm4YW76ismoisYQtBgYQPNfESGQOKI6vIm
         3QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723463691; x=1724068491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3ZonBi46mhEZLiHiOrha/1ljHlHpnZOgRT2boJbT9A=;
        b=CtHoQT4G3gUuoLStmLOuJCXnA/Qpd3beDpsGIdBIeQb5oavJ7Ml+UVMjdPPcnJvrgB
         yCyjXKtGaSOgXCIDNq7KEZl4afCrCu5VqRwteWIs11UGzM40otMf5HTk/9Q/9ZV5y8LI
         ypCHMAcU661sQiqEh7f9LhElxmx4s49URzk2HnBl83m8kw5NiZP7RkWtRkBP6XYnOScj
         S0x1yeypYLxdWpkT8S11MuPvNmojTnEmZzIxe4kJ5+PjLArLCsRlfWBZlv3bgZ9aRz2a
         KOigD7LoBYPRegKvNGkGQYDUYGfVfBkY+LakhjbRqIx1+yfKvNQlRQXoq1zZU3Gbzgkd
         Iuaw==
X-Forwarded-Encrypted: i=1; AJvYcCVfrK6NgRhaIS1F21WRmO/ZZftXztTNCZTaQ7tEL4+2wkn0TyjK+626yr7EeWyMieqQrd8RxSGairLJuY3bbVglvjOXrHkF8tcZuvrs
X-Gm-Message-State: AOJu0YzbDVDzpIoftBTZtK2DhyiMoGS8oPBz1wY1A+qbxNY7K/eH+mNM
	NVbT2DJqGoOBy6+uhXGG2eW4dLcQcSsSNDGaUtwHkDc7O27rDC1A
X-Google-Smtp-Source: AGHT+IGjanmcxa8Wa8IoRZbrWv/YJZmsBZ5M/GVmY+WeSgR/Mpz/Bvjd19dCOFrnQtQVhe9k5JFX1w==
X-Received: by 2002:a17:90b:4acf:b0:2cd:2c4d:9345 with SMTP id 98e67ed59e1d1-2d1e7f99f8dmr6851180a91.6.1723463690515;
        Mon, 12 Aug 2024 04:54:50 -0700 (PDT)
Received: from rik.localdomain (36-236-96-146.dynamic-ip.hinet.net. [36.236.96.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c9cd66sm8085351a91.24.2024.08.12.04.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:54:50 -0700 (PDT)
From: ChengChaoChun <abc21531050@gmail.com>
To: tglx@linutronix.de
Cc: rafael.j.wysocki@intel.com,
	frederic@kernel.org,
	joel@joelfernandes.org,
	dmitry.torokhov@gmail.com,
	yury.norov@gmail.com,
	linux-kernel@vger.kernel.org,
	abc21531050@gmail.com
Subject: [PATCH] Fix struct irqaction comment order inconsistency
Date: Mon, 12 Aug 2024 19:54:24 +0800
Message-Id: <20240812115424.4748-1-abc21531050@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rearrange struct irqaction comment to match member order in the code.

Signed-off-by: ChengChaoChun <abc21531050@gmail.com>
---
 include/linux/interrupt.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3f30c88e0b4c..ba59ae4521c9 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -105,19 +105,19 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
 
 /**
  * struct irqaction - per interrupt action descriptor
- * @handler:	interrupt handler function
- * @name:	name of the device
- * @dev_id:	cookie to identify the device
+ * @handler:		interrupt handler function
+ * @dev_id:		cookie to identify the device
  * @percpu_dev_id:	cookie to identify the device
- * @next:	pointer to the next irqaction for shared interrupts
- * @irq:	interrupt number
- * @flags:	flags (see IRQF_* above)
- * @thread_fn:	interrupt handler function for threaded interrupts
- * @thread:	thread pointer for threaded interrupts
- * @secondary:	pointer to secondary irqaction (force threading)
+ * @next:		pointer to the next irqaction for shared interrupts
+ * @thread_fn:		interrupt handler function for threaded interrupts
+ * @thread:		thread pointer for threaded interrupts
+ * @secondary:		pointer to secondary irqaction (force threading)
+ * @irq:		interrupt number
+ * @flags:		flags (see IRQF_* above)
  * @thread_flags:	flags related to @thread
  * @thread_mask:	bitmask for keeping track of @thread activity
- * @dir:	pointer to the proc/irq/NN/name entry
+ * @name:		name of the device
+ * @dir:		pointer to the proc/irq/NN/name entry
  */
 struct irqaction {
 	irq_handler_t		handler;

base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
-- 
2.34.1


