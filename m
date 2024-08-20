Return-Path: <linux-kernel+bounces-293063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F0C957A35
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D00B22DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F70A1E3CA0;
	Tue, 20 Aug 2024 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c9figtNB"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C33F166F17
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112034; cv=none; b=nKS0O5ICWRbn1WUr3kEBm41ge9pujNX/vtuQFUVOanpVJI+9kOfqgnMQ/BEGUPq/hZF4iKoZ2RXBi3p3prBZ8ytgY8ofAB3plFCnCM+KJozpRA5YEEtqYb7kxjwmFfcU5Zv4bPVAtTdQ5JOCGttDBXexvr/B9G/MGqU3kG0jR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112034; c=relaxed/simple;
	bh=L4fq2gAJAjxK1sLC9lcg4L6kyHQ2+G8MiyoeO5HwSb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZeFeErF+gnyvqPPsqkbjzHro2LquHV+XUPcRe2/4Lxb3SvFRt5hPkXozSmTS2L5CRn+NjtO3wL2qkNXw+uad1bl4rNmZbnlxeJRVW0TQR/Q80SM8pmYxRkVyKJZ/e+lsSm3w1VirfzqFfKA/4xO8/1ztvvWtQWu1Z03CH7PfsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c9figtNB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso4050234b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724112030; x=1724716830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfJuZFlwIrV/yx/dP7X0WZTWclq0poFO0QEtz4ByiOo=;
        b=c9figtNB2zBG5Ua6Rd2KmxIpQFYnnkLDrPGDIc9EsyPMHR2BFIvJ8pGD0D0y+FmVO6
         GZlw0JG0ZLkf4EOC/29WGyHao8AnLbsjVI44zcSmCs58B45M9xrtLxdoC7bNF/D11QrG
         0nGhxaQp5wRs2J2RNcPVPWH7rQZVJZsExBREgzgOJHm7LU1CFprOPB9xqwMNMem2Q2TT
         YKfTThUMEnUPnDVqnQHXxCjO2u3Qjcda1219hd4ghGVpoBAPkJBK+veG0lSbUFE+kjSN
         JmB4amPWKEeoVVUzVjMB3NIzD1nTJJQTvrkDgPY/3Zs0COJXkuOHfHMTP1mqdSs/4KOP
         FwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724112030; x=1724716830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfJuZFlwIrV/yx/dP7X0WZTWclq0poFO0QEtz4ByiOo=;
        b=fK/kUYMRzxyz8erZAFy9RtAk0s6hpYCKhOpkEHn+o0uNXMJA8Z32EIxFO8xxztlPEh
         Edu8j8TibODHxpEo6AwCv/EgMKRj1vcj7hzW1a9YnW9IEPibvxBM2RjRpsyddqXkG8bw
         9HzaHS1CsdMJihDSrEfxm/dO2CtamI6Q01uZN5H9jA6OJXXFrulI7KHs/mg6SxrEQqF6
         XYoaFkI+qbaWAwe50+aogXaMyBNdcIHbImjWgRrnKNS8EUz3di3spHLRwpL4e4rr/66l
         xgJYr9dWgobzJskbsi1gnv03fHxBqZvcDo+CoK2lpNHGwKtKMymhPv6+4fHhZLi/xZqI
         lGUA==
X-Forwarded-Encrypted: i=1; AJvYcCVK/VV8PLmYzO187xbNLqHT+b0luOGU6Ivmb0VZbRgSvR9x+/gHN0YDemMt8YYJar2yiUW+MEKQnZDhxL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyED7UI9t9j45n0pIIiC2hSnj2t8dEIAMn1Azo2FzKdBxOsrCkg
	ziD95DACLd3lhTTmxlJtmSy+bCqvgwqjeiED6q7zZXXMyzJ8BWOWEfRFQ4OrL2s=
X-Google-Smtp-Source: AGHT+IEjigYtUu+PbI7wCwmy0Ii9OICfFb3avBHTHKA3P6Hw3f5ftxJbKPUF8yyUXK/WBPt5jDQEfg==
X-Received: by 2002:a05:6a00:2e99:b0:713:e70e:f7db with SMTP id d2e1a72fcca58-713e70f02damr7068548b3a.18.1724112030040;
        Mon, 19 Aug 2024 17:00:30 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0739dsm7115321b3a.61.2024.08.19.17.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 17:00:29 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Mon, 19 Aug 2024 17:00:13 -0700
Subject: [PATCH v2 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy
 chain wakeups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-lpm-v6-10-constraints-pmdomain-v2-3-461325a6008f@baylibre.com>
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
In-Reply-To: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=L4fq2gAJAjxK1sLC9lcg4L6kyHQ2+G8MiyoeO5HwSb8=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmw9yaIa+swVNTOJfnTzx2jNlfK8fU9hmVzvfkW
 YvGVUUN02WJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZsPcmgAKCRBZNxia0/vG
 ZbHqD/9AOVXyi2FjVlLWmnOgTyw/r/8682U5ynfjVoIEs65YqH3/oEsnehsr/kj12+uZT+/Ryq9
 UlKviY1R9vBFUihHTR4o0s93HKbqsdM1Pv+J6AA9j1u9nOKapr2aDoOn8CRMkeTZKUGXkHqF8cj
 GH/HFug511+/BRfu8QetRE9K99DRodxTYIrPuITvQFFGq4GYO4jPZunFD9hzHKAmuB3w1IzZA/I
 C/+BryWDW7B1Q4Ax1LJVun9jywG4CTFBNOn5/mkpDSNdx1vp4T/GePnLGwP/OiCn3lDHnKcBEAC
 9DXHx5PMWMIqvmPO3TnKg2bzJlmLW2VkyaYYbaac9JzPuPJkriIRTfZ+4pHle+RpA8nucH6EExQ
 7KdK5Wxtr6AhSmW0RtIW9bDQHSMfzI/+5C3grmCQ1iDBMI8kbMoew5zt4nioHXM3rBIuE5LDZkP
 KZ1sgXaTuGwb9L/WmPwCZWes/gkGd3Ra+022fQ8kfnpbXw9I9Xb3/R3dQufV5Wb3jvPpMTRgrCm
 gwu6H3ceeRU4PBigHyGFlnbdWZIHMp2Wi1dOa4/oKpR3fGftRnWVgu0rbmh/ypVFW9rHrrvYQge
 lnJ0iNs4wN3AczLWtwz/m2J5R8hDs60skpG7k62B/H0pYmR5njtmQTBOUU6OpJA6mANCsIeYBZP
 Z6LIyKQO3Ag3JOw==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

When a device supports IO daisy-chain wakeups, it uses a dedicated
wake IRQ.  Devices with IO daisy-chain wakeups enabled should not set
wakeup constraints since these can happen even from deep power states,
so should not prevent the DM from picking deep power states.

Wake IRQs are set with dev_pm_set_wake_irq() or
dev_pm_set_dedicated_wake_irq().  The latter is used by the serial
driver used on K3 platforms (drivers/tty/serial/8250/8250_omap.c)
when the interrupts-extended property is used to describe the
dedicated wakeup interrupt.

Detect these wake IRQs in the suspend path, and if set, skip sending
constraint.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 8af907579152..f7c327cb059c 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -84,6 +84,15 @@ static inline bool ti_sci_pd_set_wkup_constraint(struct device *dev)
 	int ret;
 
 	if (device_may_wakeup(dev)) {
+		/*
+		 * If device can wakeup using IO daisy chain wakeups,
+		 * we do not want to set a constraint.
+		 */
+		if (dev->power.wakeirq) {
+			dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);
+			return false;
+		}
+
 		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
 							       TISCI_MSG_CONSTRAINT_SET);
 		if (!ret)

-- 
2.46.0


