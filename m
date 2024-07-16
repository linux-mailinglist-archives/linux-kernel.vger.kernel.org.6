Return-Path: <linux-kernel+bounces-253462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4724B9321A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9761C21B41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05344B5AE;
	Tue, 16 Jul 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwIZIrKy"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD242AB9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117067; cv=none; b=CrIl1lHyi6lKvj1AghXTEvJ9kUc3iLNtMyWie3WzB7ZYS4/7pqYn4GxM5pfhESUxF88b6Pu7ASob6SwzMlZ7BWMYZgD7w8AK8QO9OUTQABVmD6SCdXBJcsSxkVo9wqoUA+mR0JQBsyPi/KTvDZhAgY1Qo2UDGu/2zgdHuEtoJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117067; c=relaxed/simple;
	bh=jsfF1gN3gUksixf9Bkiwr3QSTwWhwgdrGkomU57PBTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KNgkyiU4DNOkVQ04XDm7Dk3/GUKRj1gQH7RHt+HkVjZExF8WFJX8FhnHYnkHOdPsqH8/5TuFVkf3MTKK68PLav7SQOSE7NBGDHSrX5EpVjEuk1/TQaohYH7m/XRXf5QfATOssPGA8WiYgEd5KzDqvB19P6c7+EsGZsPEwb49gj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rwIZIrKy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b3c0a00f2so3180305b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721117065; x=1721721865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkM4AK1wLq1RcPgMy7pkSiBJt1X0LEeQgySlCKfgP6s=;
        b=rwIZIrKymIDzcpsxslMcKNCdiIj3EMzvGJEb3RzHUPHwaErKNDy4tWGKu4L9m6XJPY
         SSc1q3WyyU1PIJDttQ0dFSY8+zD8SYX7iGUR9B9tU5DLrkfiyLPOmqq76fTfWWo9uPKT
         Eq6Vkd+kqzg2oMt6dxAvyRSIPtPNQbmGlHiIhNNkoOiC1TT2g7GH5vUyHGBkufSdakU0
         530xMc05c68MEwqqS1ga6CfG5R2voAEiKg+9edQC8xy8O/8KLRTMqfnQIz3oR/wnZb0d
         GG0I8+PkKe5ZUNojARhFVA+FupK9vgQyOnlhQdjitt2wb1l+uqWSTLFcdSXPpEQo94K/
         YDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721117065; x=1721721865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkM4AK1wLq1RcPgMy7pkSiBJt1X0LEeQgySlCKfgP6s=;
        b=iGY5p90lILlaZbrgoAeYqJM2Oy8QKIVtqy0g4sJz9I9SIzJYastv//QCSdrmmNeQqz
         9EMhbsGD1J4jOxB1MvAj/E3AVLPsrMq1ldBf5NP9kKrEr7ohYHPG9CdG2sjEpn+ZjkOD
         FzeWuhiCZzUVKEe5GO00l6gv8b4dX/y1cAjUQ+n4OUZrtmIce33KgebIlNDQjwYPnjAu
         qPwrYAPXHY3rv0e3rXISh1ViU1pyFgnqahJ3eLZatb0pE+TeEbRYk3qkUFMdsUz2vsyg
         BAFlZdjwWVscHhd+9URCNvEv4o/ItiuX6A91omjBNqoJ92UE6gbgYizRH+KnY1cT5Gik
         l3JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrqBZU+VcgLqUWoxi9ce7XWKTVsMMJlaP9EaI6/nVxaGdVrezr5/ECUt5rDs59zmyp7MKq+1c3pTJJnZEfjEqHw2pA6dWLBkcL3p4z
X-Gm-Message-State: AOJu0Yw1vkVhpF4mpNSL7TzCMkyUhn08wbEfq2nb1Gl2c9TQA+YDd2ID
	BbskIkCWzhPtEgyBD79a45r/js2bInec3sICJTy4IlMUCTm6F0E+YY/2n3uS8A==
X-Google-Smtp-Source: AGHT+IH/I4iziZlSdOB99kuzzC+PST98BOa3riW9i/KFN3qAbA9Dk9mqTZn/53P9Ipc+jILvkWBKfA==
X-Received: by 2002:a05:6a00:a1a:b0:70a:f3de:3f2 with SMTP id d2e1a72fcca58-70c1fb71aaemr1798437b3a.3.1721117064611;
        Tue, 16 Jul 2024 01:04:24 -0700 (PDT)
Received: from localhost.localdomain ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc947fsm5701798b3a.195.2024.07.16.01.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:04:24 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: Check for the existence of 'dev.of_node' before calling of_platform_populate()
Date: Tue, 16 Jul 2024 13:34:18 +0530
Message-Id: <20240716080418.34426-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 50b040ef3732 ("PCI/pwrctl: only call of_platform_populate() if
CONFIG_OF is enabled") added the CONFIG_OF guard for the
of_platform_populate() API. But it missed the fact that the CONFIG_OF
platforms can also run on ACPI without devicetree. In those cases,
of_platform_populate() will fail with below error messages as seen on the
Ampere Altra box:

pci 000c:00:01.0: failed to populate child OF nodes (-22)
pci 000c:00:02.0: failed to populate child OF nodes (-22)

Fix this by checking for the existence of 'dev.of_node' before calling the
of_platform_populate() API.

Fixes: 50b040ef3732 ("PCI/pwrctl: only call of_platform_populate() if CONFIG_OF is enabled")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/linux-arm-msm/CAHk-=wjcO_9dkNf-bNda6bzykb5ZXWtAYA97p7oDsXPHmMRi6g@mail.gmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3bab78cc68f7..12849a164acf 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -350,7 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	pci_dev_assign_added(dev, true);
 
-	if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
+	if (IS_ENABLED(CONFIG_OF) && dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
 		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
 					      &dev->dev);
 		if (retval)
-- 
2.25.1


