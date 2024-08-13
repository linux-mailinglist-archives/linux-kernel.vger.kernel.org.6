Return-Path: <linux-kernel+bounces-285398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924D3950CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D7284AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E331A7041;
	Tue, 13 Aug 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Lq7OPLBY"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671BA1A4F2E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576330; cv=none; b=De7wj+fM8wLKFH/B8ma4IFFshYTqtmNlE7N4/OrT5/vhW5kwlXZRqmyJpFmLSwseSLdQYbTWPV8HWRHfzWA7l1VJrRfX+izRNgQn5AV6txjThzga16EiScUCjDSUr/reE5q1aF1JDh9HSSqcfkNk9JfjlTM0RBWtgdXMtITeqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576330; c=relaxed/simple;
	bh=PPwW78qgunnYtZvqCU/S509OHopFesLiZnEPd2aWgyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3UlwdtDM1UM4bYWgUphVfaTu4TbAq6/rLtNHaXJZDNP515ecH2odNWspztzAz48OBjtOCtkeHZr1zkXthm9Mra9Y80N1M+ci3HAhwHc9dL59viFdCJliEeQd0LcYtMT3LPdvEeg8HuBOk580rgx+9Dpum07ym1A0GyMAx/8RIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Lq7OPLBY; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5314c6dbaa5so5372167e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576326; x=1724181126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UIp7b12fAVv8rkm6/TKT5fjSShHkGlLIT78jfOCi3C8=;
        b=Lq7OPLBY+5yUQD/vMeyVH1SMtw0uJDKWc/qR0J6nnjQQrx+obM0Zx41Og1SaF4DewP
         iWueO0tRZSn3bWfOV27Wre7KIz+ndYGFAvAx+hKGx7jfxWvL9b+5EXKcbEvheCpirLQs
         QMwFsiHj2DP1lQmN1O6m9pAUUsvr++DDXjmzO4TRuhhOYrvIndHv650KmdE+iovNM8t7
         RR7CtG9u/z3zsElW84ms5jQIVEzpXSUZWoyy/JM3M1CkhnKr3d7qNNjV9i0SITzR+V4z
         IvutAFW20e447/B/Wl91FR+hjuFHfyIMli7FTCqGwZoas3yd35JlVau6dqXw00UZ0HFE
         oQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576326; x=1724181126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIp7b12fAVv8rkm6/TKT5fjSShHkGlLIT78jfOCi3C8=;
        b=mmo+rfB4pFygHpUD02qnt8orxiArzFiTlYBQJAtets6V8YYNCcKlb1EDol47VSPqvh
         OyP31TX0XFTbTeRpAgBaZqo+Rsgo7oXMDfQ233KTG+9SyGJ8Mj6K5/k3KFMabKpUA4CK
         VdFnC9UnR7zQMyHraRNXvrjF6dPrR2ifL27M7iGa6Qi+ipG9m3GCbc6sQBqyOSEOb/eF
         4mQsB0TroN8jSEbfMy+ruqers64ZFazRaBd/gIKU2rBh3U/H/MQlhARWlC1C8P29nIuN
         XW1g+aq7d6/u07XiYhUJstdCmWlY8sRbUCfSNpd1OMaOUIKW/GytgF7Rnx3imr3ZNRVo
         KcDw==
X-Forwarded-Encrypted: i=1; AJvYcCWIQbmaTf5ZmdUlYl249Yvi+CS/hwmC7rDuA7h14pP9PTi1TI1mJumLDQyC17NWvzCTgf8JXDei55i67Mh4pZ1Nod8D7VLEUf24Kysy
X-Gm-Message-State: AOJu0YzH70Hu/JbCYvos4z3Fzhimenl9acaMzCOIe6IiHz8KRJQiFkXb
	qQk5e9D6ehkbMTVasqA50zk8yp4Yw2RxooMnpXfQDQQK1uCKrsfa91GgXJ+//fw=
X-Google-Smtp-Source: AGHT+IFIBVxZaulsbwEixDBwx/xvqg42Eqvsg5pKm87hj4sJVV0voSlvx3fWUfrZpH18h8eGif2S1g==
X-Received: by 2002:a05:6512:1396:b0:52c:e03d:dfd7 with SMTP id 2adb3069b0e04-532edbe9ab4mr264805e87.39.1723576326356;
        Tue, 13 Aug 2024 12:12:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51e966sm11091807f8f.75.2024.08.13.12.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:12:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] PCI/pwrctl: pwrseq: add support for WCN6855
Date: Tue, 13 Aug 2024 21:12:00 +0200
Message-ID: <20240813191201.155123-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konradybcio@kernel.org>

Add support for ATH11K inside the WCN6855 package to the power
sequencing PCI power control driver.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Bartosz: split Konrad's bigger patch, write the commit message]
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
index f07758c9edad..a23a4312574b 100644
--- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -66,6 +66,11 @@ static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
 		.compatible = "pci17cb,1101",
 		.data = "wlan",
 	},
+	{
+		/* ATH11K in WCN6855 package. */
+		.compatible = "pci17cb,1103",
+		.data = "wlan",
+	},
 	{
 		/* ATH12K in WCN7850 package. */
 		.compatible = "pci17cb,1107",
-- 
2.43.0


