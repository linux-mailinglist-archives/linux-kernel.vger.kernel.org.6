Return-Path: <linux-kernel+bounces-416780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8A19D4A20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B27282166
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D41CC885;
	Thu, 21 Nov 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SyV7K3Hs"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33531BE84B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182038; cv=none; b=QjOPsAv66P+0JpB4IChiijhWeEHFYn531a5KTwcLKIvFsR/4GOHd8wnU3QTZLCbRmGg1My+IdqUropHcotB4RH4MtgTW8xI9MnojKT1MqXbl2srTp3otAmipWQGp1Fc4r2O4jlC0BW1Ct8e/eHLly9tmRcfyYVDHem3rFK8CqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182038; c=relaxed/simple;
	bh=B8w7IqS349xKvkVm2TAGzPcrpQkbEaSMjvOYJjFtRWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lZwv2z6TFy4ccy8NS8yZIikFzvUd6ELm/JcaM1flkPV4N9E1YW5tz6GkEd+SRl4yB1Iaw+HF2JNTiVi/pH0kbh/oe0IEFzzsir5Upmqn0HK2+3BB5r5hf4KNhZIotYO8txk3arCHJaXcRdXJFizvn90LY97KxvTiw9861N1tEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SyV7K3Hs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f71f2b136eso626701a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732182036; x=1732786836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQA02CvD4hEDuB90g/mxqJCe2MU7YNMFhdksR6W4flA=;
        b=SyV7K3HsmJnU3EOkt+Jpen4oFd9WSmSwwByosQNU1nk/nLRY+S+jUg/Gd5TpEoFYP5
         akuYzuu7eQrl8EHjeRs3eGZzi3KDLJWmDOUYYPsxm1U5mlmMo8fpgYJqU85i6dFvB/Pc
         +kebbt8bG2ybkwyAMs6GGOqMztZiIIFQ73SIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732182036; x=1732786836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQA02CvD4hEDuB90g/mxqJCe2MU7YNMFhdksR6W4flA=;
        b=oRXCIuCWuYP6aTCcxOwXb4vzGF2x6IHBH0sxUSxk47byiZZ0o7o/SDfAMe3631mcU2
         BZE1fQAj4UB+cyBnlfAd0GyBSLfiK7DQk66KiXor+kB12uvkiksB3UtFT+nISL4ud3fC
         864lYX4M/aFxOhNLWfC4SZwPP4VdhdEp0hDlFHtp6r6GLKvOtEu90KNvnjcLDvr4gv2e
         pASsJ7xDfOFDqxeVsj+gHXPuTx4GWLRuZOB9JG1lugmRHLGFd4oddofcnAJfhGGbRbnB
         mVo97r7km5l6oanawvbCeIqAkAZMpgSxtmhOF2w7E4rrLmjKXtgBpQ8IraBb+9RUM1SC
         nVSg==
X-Forwarded-Encrypted: i=1; AJvYcCWrxjqEwrhnJnBKg/qZNMZ8L4gSibeMyO5yoAHA8/Ip0a4EWwTEZThY7xT/0x93HuzOt37dH3q1KtSf+Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMBqGO5cgt4gGQhJM0ek3GDjZr1Esrefs9Yz5BWQCd/0+mBrmX
	mrBidsQFfu2D0Bu1yKZ5b9Zbi3HgCl8/ZWEThX2Ywr6vfj2rcyW+GgVJ5/rCpA==
X-Gm-Gg: ASbGncvqvNrE+0Ijf4q0+yoaYul7bkA77k0xyrQNr14HR3gKAgnHmKORQUpfnMnWLXP
	wrEOFk0drlwsZRf1ad84KmfL+zUdfr0f/ui0VIf1rfv8tLsbZcOEYvr8HJMYWsCxFgpPRodZZ4N
	NiS4BF1/Pue7ZrV/GbTYBfbeEiwxmceXCrImAGiSsG7hpo6lWZ8Yz1vy660ByxCYkjskLsvftHI
	8KO+YA2nHB3vsb2pRZqxyphTOkc7/Jju8t83yButfLgRQmF9cMZkbp8p07ow5RvGC7S
X-Google-Smtp-Source: AGHT+IEyGvNhGFgKSNb4OSSuTfTsntxe5CklW9nyxQKa272M/cZBdFd6c0ELCErV9/RJhNPPjU1XuQ==
X-Received: by 2002:a05:6a20:12c6:b0:1db:ed4d:fa90 with SMTP id adf61e73a8af0-1ddae3eb113mr8532716637.10.1732182036084;
        Thu, 21 Nov 2024 01:40:36 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:527f:df65:78d6:c140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bef8dafdsm3296596b3a.104.2024.11.21.01.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:40:35 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Klara Modin <klarasmodin@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable+noautosel@kernel.org
Subject: [PATCH] PCI/pwrctl: Do not assume device node presence
Date: Thu, 21 Nov 2024 17:40:19 +0800
Message-ID: <20241121094020.3679787-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A PCI device normally does not have a device node, since the bus is
fully enumerable. Assuming that a device node is presence is likely
bad.

The newly added pwrctl code assumes such and crashes with a NULL
pointer dereference. Besides that, of_find_device_by_node(NULL)
is likely going to return some random device.

Reported-by: Klara Modin <klarasmodin@gmail.com>
Closes: https://lore.kernel.org/linux-pci/a7b8f84d-efa6-490c-8594-84c1de9a7031@gmail.com/
Fixes: cc70852b0962 ("PCI/pwrctl: Ensure that pwrctl drivers are probed before PCI client drivers")
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: stable+noautosel@kernel.org         # Depends on power supply check
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pci/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 98910bc0fcc4..eca72e0c3b6c 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -405,7 +405,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 * before PCI client drivers.
 	 */
 	pdev = of_find_device_by_node(dn);
-	if (pdev && of_pci_supply_present(dn)) {
+	if (dn && pdev && of_pci_supply_present(dn)) {
 		if (!device_link_add(&dev->dev, &pdev->dev,
 				     DL_FLAG_AUTOREMOVE_CONSUMER))
 			pci_err(dev, "failed to add device link to power control device %s\n",
-- 
2.47.0.338.g60cca15819-goog


