Return-Path: <linux-kernel+bounces-297260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC995B50F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A8F1C230FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134EF1C942E;
	Thu, 22 Aug 2024 12:32:34 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D367178372
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329953; cv=none; b=PjcYjyU2iQY8InXOgm5eXK0oho3jCAmqt+Vta4mgP0b30YAP3H/owT1rY/btfKiJ6KkWhWdCDtoGsZRhfX7TTisp5034dwb7/9c/ZvdGatWu2rDsg/iziyA2Hx72BJOy2yrDvaY3ytrNmmKjwAyWyqMjwDxrEqSDKfKrDNK1Qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329953; c=relaxed/simple;
	bh=eEk+KsDZNRWR2xhHsOL7NbOcRiRilBUuzavFnoahOFg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XqS7pPdhyuE9uYLSG7ojgW/nDlbs5RLzBcf2SZaHVSJofmTj8E2jaOPG7vSoj9RKQem/Z1xL2dZhbpqyDU12t0SOIiUCzMJUkC1IFbwCJyQcme8Za7WRq7NHbXZWSZxbPcK/I5hgySgNMD2fXNae+JIly7tjNucHyBcrnkuY1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428101fa30aso5701415e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724329950; x=1724934750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUoiP4MzTh6ZlaFvB4vYeM5H1FzzOE8klDlNv0Drekc=;
        b=arXI6TA7r/L171RvwAYWZdosqCp1sEr2mg55Pu+e/GivZo8AT5oZZDlWQ1/y48oZOt
         i1xy4TAaaR/l8Yx45Eag193MFVI3JsZNwKn5zCUGtYpoSg4hnLAwkMWWDajHv1JmPRB7
         /JsXkYD3WHa6weIlCZNHoYycCq+4wB38eDsiSaCwfIEVPJKCatitzjROXIwswFZaNp4A
         a8cY9mZGY8KA5Qr9HF3rww5MXPLm29VVJg3T3ce/dWLN4/998KQMHVe29Ym1F2VNvtbK
         3y+cWWkXcgwSWsaPCfm2+EGXdMCcMcIBDkUM96Nkczd/r3NJJsveEZRbyLEdml2bMASk
         VcwA==
X-Forwarded-Encrypted: i=1; AJvYcCUdqhoiiag115CJCkt4YZY8INgz/4heJUab6zcDYJ5tRObO774Hld8vHoJDXzMkzHqVe1ukA/UlLjvyol4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5yqDbvna1bxXh1jnS9uv2+Xay9vSiuq6utheQRfxZjRCfumUw
	ghHmXUI9vBkPw9bc4+uXq6kcvq0HBFTurbpQk3/Jzz10sU3EfX26
X-Google-Smtp-Source: AGHT+IHvj+hiI7T9+FiI8RZ1o0xL4xgxQMGrl4l6sFwtWWILHGoswhrw/MyRo6v1utbNYgGVY0pzrw==
X-Received: by 2002:a05:600c:310c:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42abd11e2famr46546935e9.10.1724329950124;
        Thu, 22 Aug 2024 05:32:30 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac517a4c9sm23297445e9.35.2024.08.22.05.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:32:29 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] interrupt.h: fix typo in struct comment
Date: Thu, 22 Aug 2024 15:31:58 +0300
Message-ID: <20240822123205.2186221-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant "e" in "assign(e)ments".

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 include/linux/interrupt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 694de61e0b383..457151f9f263d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -276,7 +276,7 @@ struct irq_affinity_notify {
 #define	IRQ_AFFINITY_MAX_SETS  4
 
 /**
- * struct irq_affinity - Description for automatic irq affinity assignements
+ * struct irq_affinity - Description for automatic irq affinity assignments
  * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
-- 
2.45.0


