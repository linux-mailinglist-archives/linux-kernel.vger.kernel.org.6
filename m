Return-Path: <linux-kernel+bounces-311495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C13E9689DA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8B81C21D32
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850119E97C;
	Mon,  2 Sep 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7lJ9Gc5"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6EC200114
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287117; cv=none; b=TgVkNA7kS54TODxh8leqZBUpAKZqAvFQOxwaHTkJCV02u4NT4IFMf+mHrzxUQ8izL8m8ho1tCfD4mLVNeVyfvwnlz0NhOpBcUwOSJa+lqfm6HLbMe40nvaZXmQ9WgAOEG7fcjF/SgEn/6CJUsCZOvyACsyCay8xbHT+OGX7RmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287117; c=relaxed/simple;
	bh=5+yk9MCmFeJBQ7L2gym3cTFE5OlnWTiYDPJMPD7RVnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m/dIMK2uKc20KZS2URlG36qnRRpRfabd0kw60TA0R+o3HAEZl93mUq0IsXybLC9H8KL8ogMUed2lOcLxuyf49uCkD/8MI37vP0VGkLrZfa8/3NdwnlBydBslXvK2BISFj3keyGIovBkXB8TjIT+UHaE+bFPZlLaDtSKFey64BoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k7lJ9Gc5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f50ca18a13so51062491fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287113; x=1725891913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u3JhRT9F1Ebc+AzTXK0vkwr9Xmwvv6xTBM9lEdVHDNQ=;
        b=k7lJ9Gc5pUQTsXPOcd4XHNCUdq62kF3a+lnq7nrj87N5tbogowb8LpMvlWql+5cCpX
         y445OBWq+YFPxd6P2uHMgThRp96aaQ4xE4MEFmXKHLmUGc9giyjxdaUOFBIiCIsD1EDg
         lhvQD8dt06OFI0h54View82IQ5ujAugrnvR3cL5SvST3h3jivXtQ/fodtXVqtxQlQgf/
         8h138dE/2d9Pam5+ZT6GiO8dgiwWsz3VdoVeAAtTD30B+5an7gAyMm8IrbaX/3vy6imf
         VSVGWQ+A5UuIKhlbV0lbWZFxP7qrl25MbCOBIRhsHCembc0vJLsPBObgokNCaPtNUZzO
         bGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287113; x=1725891913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3JhRT9F1Ebc+AzTXK0vkwr9Xmwvv6xTBM9lEdVHDNQ=;
        b=iJmkR2bxKyRUKAIvTRubHq57TncAM+Za5ItvbOENoVtHdAMMmrPe9jvSNdibIpGSfz
         xJvqDPBzeVbZQO7MHsDuR/4dZcwXeI7P6lw7l8QjFVFMNidpkYv8KzaiZxdVvDO5FIeS
         u50FcvBs4da0lEaPZYwIKJ+cDD3O4L9PzKCCvxVtD8aTc2kloU0W3Wff65DReVyz11OV
         ZOf6yKwG4GcUIZOvROxznxcFyS4GLzO4N6eB4MLjgdi9gM3lLlZA4aaXggbMpHEHnGtU
         dG5xdqiOGeorTgUehd5iKzuUXFibjkyofM+E0SwYtOP2xNo3izx+o9zQUx7g9t5eKjZO
         7pLQ==
X-Gm-Message-State: AOJu0Yxar8/3gUXmuwX8NR8MszIR0jrjXDVJVZ4/v7Hu7SLn4DDlqXSv
	JMJ0M3QLBSPiW+8kbQpxmXrKk13AF/VFluAQVr3vdYjY4kayKQImDQprmg1ppK8=
X-Google-Smtp-Source: AGHT+IH/xNFREYRFjRwWttEEMsV0R18Ua4UO7HrIhfQe96SyTxf8zLRNGyVUy2Qpv0QoEkL7KxrCLA==
X-Received: by 2002:a05:651c:b13:b0:2f1:6cb1:44c0 with SMTP id 38308e7fff4ca-2f61038c633mr108241651fa.6.1725287113249;
        Mon, 02 Sep 2024 07:25:13 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a3f5sm5308881a12.2.2024.09.02.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:25:12 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] nvmem: fixes for 6.11
Date: Mon,  2 Sep 2024 15:25:07 +0100
Message-Id: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few fixes in nvmem for 6.11, Could you queue
these for next possible rc.

fixes include
	- fixing kernel doc about return value
	- fix u-boot provider boundary checking
	- fix dt-bindings for Zynq nvmem provider

Thanks,
Srini



MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Geert Uytterhoeven (1):
  nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc

John Thomson (1):
  nvmem: u-boot-env: error if NVMEM device is too small

Michal Simek (1):
  dt-bindings: nvmem: Use soc-nvmem node name instead of nvmem

 .../devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml       | 2 +-
 drivers/nvmem/core.c                                       | 6 +++---
 drivers/nvmem/u-boot-env.c                                 | 7 +++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.25.1


