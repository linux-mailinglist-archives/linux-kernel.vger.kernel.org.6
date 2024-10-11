Return-Path: <linux-kernel+bounces-360535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B885C999C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C1A3B22E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A92B1F9A97;
	Fri, 11 Oct 2024 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5xphyqG"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA7E1EABA2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625732; cv=none; b=SztGGN/42XxsKzxe0Hni32oV5V26icmxRGZrooxTBD31/MGUoXzjwoZ0YaaYf4H3jIH++lkwzchAAhbHIjmCDGKXS6BegRa7doVAYz71QCk0FCLU5uZSUAi+rTmtbVXT/2GFahtLf9bYo7Itj1b5iDFnpqzv8iqyOkrzV8wSv2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625732; c=relaxed/simple;
	bh=gSDr2qXiWunqD83kcCcfkWzmofL1UeyjfIsv5gb6YVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=arwDSK8Wd8hzF63ZVwCxGYjFP2vibw6Xy2p2mMkQ1YXrKV+1qmT3+ZLfhSX5HLYiB6k8U0BybIo74nS2ER4mpitXIFs5Vrs3z7Sx8ShOxlHd6WIg2N1H4UlchJ5mdX9hXN7DJWxGnyuGq03FSglI7TeOQBzCT8ksBrgx9U+furQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K5xphyqG; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2facf481587so12885781fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728625727; x=1729230527; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAUIBKUFiqHBE7OX0O7eWG2UC2nEpnjuYCzeR97fn5c=;
        b=K5xphyqGvesNOdZhdTEFto1ShyNHS1P1jN2zpQl4Ps5Dg2JOv+Qhg0fZB/UJmrHbcQ
         ZqqQcOsBVBGrbRPRzY5fNdWjsa2A+j6rlWD5dQzvX1KWIjJ4hoJA3F9+jry+pZyyuApe
         rXxLTYRDaIoaBeEbVlPHd90yly5NvTRjOF8wYaR9uxHM+7Qm2YbBvttCu9qTIdbqFS72
         WBOQYNjzwz9k9w/ZVe3fsqdsW0wPNqvQbI9wp9E8HZdi3QQlVmKihUCfSu0UBHmKxv91
         /LfD/BPrwd2kXofVW+k+hohhEH1pQbKYiqHYj5Fov2r0zX1I3V/WdNvhtbhESLwcyJN6
         jXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728625727; x=1729230527;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAUIBKUFiqHBE7OX0O7eWG2UC2nEpnjuYCzeR97fn5c=;
        b=pgpdmaiC+Ni1EkGECyQAb9blvqRTE0ZA6HQbTO1iZuTT/S487csO99cWQeg2IKHEST
         H3e8SwsW1X+eNppWQlBkhYwOYKGZrfSHLGvXR7OjVbXIUUakKK1E/G30H2/F/0mSDoNn
         u1FPf8R0XSYdHX3ZOdLYUixHkHK4YW87IbhewvZk0KidYR3uQlUptg9H+igi9uBpdyux
         UVmEMXw2idL/hBZl/TRoxFn8gxeEUlMNEuhFM3Is+rAkQSTDGT61I6imwMvYa4vjMtHv
         Uknat5m4L5g82ho8Fh9dc5DrnHFFiWdOuKry4y/HsudYhSCFyMazhnHQKNNyuUfPmKfz
         0lpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnA/RBzZ8+OGA+4I8DFDTG//BOxGt3tYH9L/0GXQqC+YI0SXKH9oxfu8vghO6B3Pb4mZeLyOuaOPdlJNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6yOukGhP+CUbI6ppWXySmXlbIHSzctwPMkH4P5vwJjYsZNIb8
	2paICqw5AprR1yYIa2AyXNMpfateEA6mVMmLK8V52XjY6XJSZq0qG9JWrXnq+n8=
X-Google-Smtp-Source: AGHT+IElgnZzJUF2VeU6qLAFyoymFdQaxiQWEzvuNGs2dbyEg43CbtOA9CKVQOGhLlMEcGoNVmZPew==
X-Received: by 2002:a2e:be13:0:b0:2fa:c46a:eb4e with SMTP id 38308e7fff4ca-2fb326fe462mr3847561fa.3.1728625726600;
        Thu, 10 Oct 2024 22:48:46 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb24770a41sm4186111fa.129.2024.10.10.22.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 22:48:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 11 Oct 2024 08:48:39 +0300
Subject: [PATCH RESEND] thermal/drivers/qcom/lmh: remove false lockdep
 backtrace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-lmh-lockdep-v1-1-495cbbe6fef1@linaro.org>
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2582;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=gSDr2qXiWunqD83kcCcfkWzmofL1UeyjfIsv5gb6YVw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnCLw70Pj12BWKspOc3Iexi6FaN+ED1D3pwfnZc
 rZjUEBmHieJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZwi8OwAKCRCLPIo+Aiko
 1ZIXB/9KZut2clhqKYo18Rw7gj6QdBb3gWOHFkHnZwIf4UKQIRvHY36O3T/LEj/iqLn6LnMhO/G
 oMx2OjPb+s6le34h63v+PU0Zj6RUbR6lJyZhBpb3PIUhh/Xb7ncNroEgagZXa101Wx9RO4CsTls
 Z9bELVN7jxZ5zni4l08TXgV6Rscm9Vz21wyTpAjytzy8zgjl38QVXbPVAxcZO76N1OOw3ZF3uoz
 ny+8AZBw8zZDCmtq+Dxoi7ZA7JtXbPMHcjEqEnx491tIFMA7Sn2xliuZbpYj7WEtd9osPi0SBit
 VqJfFGBlEVV4lDOCl0RBgJzUo7zRdNfg86xrvOnpfE+MH1KD
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Annotate LMH IRQs with lockdep classes so that the lockdep doesn't
report possible recursive locking issue between LMH and GIC interrupts.

For the reference:

       CPU0
       ----
  lock(&irq_desc_lock_class);
  lock(&irq_desc_lock_class);

 *** DEADLOCK ***

Call trace:
 dump_backtrace+0x98/0xf0
 show_stack+0x18/0x24
 dump_stack_lvl+0x90/0xd0
 dump_stack+0x18/0x24
 print_deadlock_bug+0x258/0x348
 __lock_acquire+0x1078/0x1f44
 lock_acquire+0x1fc/0x32c
 _raw_spin_lock_irqsave+0x60/0x88
 __irq_get_desc_lock+0x58/0x98
 enable_irq+0x38/0xa0
 lmh_enable_interrupt+0x2c/0x38
 irq_enable+0x40/0x8c
 __irq_startup+0x78/0xa4
 irq_startup+0x78/0x168
 __enable_irq+0x70/0x7c
 enable_irq+0x4c/0xa0
 qcom_cpufreq_ready+0x20/0x2c
 cpufreq_online+0x2a8/0x988
 cpufreq_add_dev+0x80/0x98
 subsys_interface_register+0x104/0x134
 cpufreq_register_driver+0x150/0x234
 qcom_cpufreq_hw_driver_probe+0x2a8/0x388
 platform_probe+0x68/0xc0
 really_probe+0xbc/0x298
 __driver_probe_device+0x78/0x12c
 driver_probe_device+0x3c/0x160
 __device_attach_driver+0xb8/0x138
 bus_for_each_drv+0x84/0xe0
 __device_attach+0x9c/0x188
 device_initial_probe+0x14/0x20
 bus_probe_device+0xac/0xb0
 deferred_probe_work_func+0x8c/0xc8
 process_one_work+0x20c/0x62c
 worker_thread+0x1bc/0x36c
 kthread+0x120/0x124
 ret_from_fork+0x10/0x20

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/lmh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 5225b3621a56..d2d49264cf83 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -73,7 +73,14 @@ static struct irq_chip lmh_irq_chip = {
 static int lmh_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	struct lmh_hw_data *lmh_data = d->host_data;
+	static struct lock_class_key lmh_lock_key;
+	static struct lock_class_key lmh_request_key;
 
+	/*
+	 * This lock class tells lockdep that GPIO irqs are in a different
+	 * category than their parents, so it won't report false recursion.
+	 */
+	irq_set_lockdep_class(irq, &lmh_lock_key, &lmh_request_key);
 	irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
 	irq_set_chip_data(irq, lmh_data);
 

---
base-commit: 797012914d2d031430268fe512af0ccd7d8e46ef
change-id: 20240721-lmh-lockdep-88de09e77089

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


