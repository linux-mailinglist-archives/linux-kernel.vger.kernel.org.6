Return-Path: <linux-kernel+bounces-339996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D68986D16
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E425B254E0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2F318FC7C;
	Thu, 26 Sep 2024 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X6/otQVr"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DB118FDA6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333769; cv=none; b=obFL+yiwtIXTDQP179KxHkGafvG9SLjaix7PC0PkvC362kg0NM5vy9eNSQptpNDWF6cXn2qE/jBvYasZSJxMc8U+7ykUxJMzUsIm1Dh5aaNn9zfyaA6XCYtsxfKLjnrGoYMTdhlMM+LYEt3YkeVpl6C15o1/45wS9SUDeehrfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333769; c=relaxed/simple;
	bh=pkVjMZLZKKCNOFrA3WyyFnCA5HqJGbO5ff4ImnIzRrs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U37uCXjHvwlyXU1+VGJuNgdB+QRcpoWfJOdK+j9GCdD4JmWIiUJUf0nTk2Lq+l72XMJ7mcXJjCvs8oQ1sFAqVBcPmKgXxQRylFDCZja7v0InX/wtMFnaKnRgMbXz76AIEr07xeSobvd9WGYoVaSLfBZgnt8MsaV2lqmQSLdoJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=X6/otQVr; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso467993a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1727333767; x=1727938567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Pc22EUqI7DPrVM6a23jwJ8zZFnPa3YTszP9VJN1ZIc=;
        b=X6/otQVrbfw6RYkKQaKmeW7rz89figng150CmWoyvnHnJeH9sakPbqMWnKGv4X36/s
         MdmvUMgaCASDT4XAws2The0VsXGKj1aUrxmKLWiS+bFQzC4I+NfeSX9khz6btRz13oAL
         Vu/9tqMmRbOMcbPqCyVurH+apLC6oXfsgP9Qs8kMLt3b592pxSlmqWxPk4Kb8ZuTL/4J
         vhCggEXRA5tTu1seU6nxSHzYRmUhdGu4JacBEPb0z8jAsKmBkuMVIQWPKhrznezrkJIg
         hruCJdkCC0Vw0h304w9x9pNwR37keahe+Z91EB2PXtRKQ9NKa92sw4+ZGxD6koUUO1Zq
         mFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333767; x=1727938567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Pc22EUqI7DPrVM6a23jwJ8zZFnPa3YTszP9VJN1ZIc=;
        b=fB5CaVVCaeeJ0tpxcsDThbX0Ka2/Tys9rrIYC6AGnnD75cKRRZ++HCjJN1Mykf8GR5
         K6f73oVBTRZwVyVnrFhXppMMdSA/YDmws7oOkq+Nkfewv+Xdl9Uj177v2eJ1o443Nju4
         hUa70WBwY3B/HPDsiaWYoE22xlK1D8EITYRJdMAIYBIkJpFyxRXcKOT3uy4hs14vlhOm
         VCcTMOnhXhkFRlLACK4CViYlT5fdsDrZ/Go3s5+wo6yhfEJY03XmguJWhJrwYFjEoTRP
         vQkFcT6dcJTT4o/deSRNflBMTI0Ksd7V5rjdq6dZuKMAjpCCoo5REF6Z1MRVDVFb2uvU
         +SxA==
X-Forwarded-Encrypted: i=1; AJvYcCVb8NMcBLXwxNF2XtnNvF3p8QkoZvE7qaCwiEWutFjiSBjqOorKGYNjLBck/0XWIzrr8Tjiy8vThyLa0i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzAM5qqGE+LO3N3gpWOFKDAfENLmQ3OVt0lJlRextYuQC4kBK4
	MeO/8pFTXKnT4Qi5EihqzDz1Y6PjYFS5pYROspU2A2TBo7Rhu2EGjO9NuzjdtIvEgOSvje2yLhD
	kJSc=
X-Google-Smtp-Source: AGHT+IEO6HyO9ourHKj89akn4hwO0QEWGH3NS+KxhD+L1x5BptifZgMYW8BoqFjQGO0+rzUQWyRL/Q==
X-Received: by 2002:a05:6a20:7490:b0:1cc:e71d:ea10 with SMTP id adf61e73a8af0-1d4ebe73f00mr3514567637.14.1727333766880;
        Wed, 25 Sep 2024 23:56:06 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73120sm3592352a12.68.2024.09.25.23.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:56:06 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: greentime.hu@sifive.com,
	zong.li@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Patra <atishp@rivosinc.com>,
	Nick Hu <nick.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 3/3] clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug
Date: Thu, 26 Sep 2024 14:54:18 +0800
Message-Id: <20240926065422.226518-4-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926065422.226518-1-nick.hu@sifive.com>
References: <20240926065422.226518-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop the stimecmp when the cpu is going to be off otherwise the timer
stimecmp register while cpu non retention suspend.

Suggested-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u
Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/clocksource/timer-riscv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 48ce50c5f5e6..166dee14e46b 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -127,6 +127,12 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 static int riscv_timer_dying_cpu(unsigned int cpu)
 {
 	disable_percpu_irq(riscv_clock_event_irq);
+	/*
+	 * Stop the timer when the cpu is going to be offline otherwise
+	 * the timer interrupt may be pending while performing power-down.
+	 */
+	riscv_clock_event_stop();
+
 	return 0;
 }
 
-- 
2.34.1


