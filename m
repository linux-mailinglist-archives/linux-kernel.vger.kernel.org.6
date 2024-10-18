Return-Path: <linux-kernel+bounces-371660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFDF9A3E02
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6E1283143
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169851CD2C;
	Fri, 18 Oct 2024 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1lk3lAo4"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155511878
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253852; cv=none; b=j8gkWTG9KpjFaBERvSfX3yOC6aMym7V94M6r92OmR3ASO046BTIaJJnyPj528GilICjpPAP1/wKboBNhj71xwuB2b68YsFvDKT+MMXpgzA0CB4E1z9bhhUJCve/nW8WU/2XEok21Tcs0+aCwwfXGydw3QwqUzr3hbY59Yj6AUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253852; c=relaxed/simple;
	bh=cRedNhZinFJWNF1LdgN5osG3CkN3lOod1l75Ye8/xU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqjqbhGxDanLjGX8P35AjvXqrdxpqiaNHvGI029y68IsH9x0TfoRxdjndY0vfZiplN0AWUIV3lxg20DE05BbSaV22qDfd1p7vawouItYKb3K2bkWmZPJQhO4CD1zh0jc/3dn93Rvfk291DNyUPBdtSHo8M2trc8C8KGKD2A+mxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1lk3lAo4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d518f9abcso1494258f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729253849; x=1729858649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJU/+Wh+ldjpgT/D+5mz9a/ir4F3D+2s5F/fl+n3k4k=;
        b=1lk3lAo4H7wBfuL8O9IclLpC4vMhNyuHlAmokQc2gBL6IuYcpDy6GELmVX6ZPKwLLd
         /zSupjLSSNutEwos1LXsv5CugoppNDMjJl/6nc7+H19ZvXPWZVHmm7YLpuCRIa2E4Wxk
         VwboVxMu3HUA4NYZ2gX0/AJhEqgiF6/G5RGu6KbwCbdOQidAVd8NBXQv8JGcmo3sBfB7
         sfwAfStdkl9P3TPMlf96i3aAcQ9I2fRCgaKXYkiX3jDPwsAisMqcTJyRsuHSKkd/9XHE
         W0mQMI6MhLc/2N1whL/7cmp6fJJ/hnGIHCdW99eIHGwHCTRoz383H4xOouO4GyNrM9Au
         U8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729253849; x=1729858649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJU/+Wh+ldjpgT/D+5mz9a/ir4F3D+2s5F/fl+n3k4k=;
        b=cAnnpDsXwHpLlde1jg1BnV/3borj6VqPY9shp+bSgTjcQ6rVACWnV27QykP2ABJOz/
         JE1SgFSwUfoQn7CTByYJL9XstuEkJUR0WbQrzdPy3AOc6Ev0LpZoeKd5HV7jGn40WXIJ
         Z6Zcu8OGbHhiqluiZG1S8Z/74OBDADLOt6U7vSEkvg7/SQSiGovNEjTUJQ9adLsnlhnQ
         7dTpspJShtPaw5hb5EHPfPmZxyQjEN37kqTdSc9SH7bRwZf9SH44+WviQ40pOtPzePYX
         wmd4dRh1yycjWa3QxX3UYU1bQ+VBq1IY3ruGYyQar33WHg2Awyo/M80qp6evG8ktA1lT
         3eXw==
X-Forwarded-Encrypted: i=1; AJvYcCXGoiaZ7DGHVclq9Q9KC37xqeytXSRqFvSLqVBM4JQnOsaXEtkX2XxmgRZT8z9GVwYoQYTit0G+MXd0UAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQJbQGHidUp9ellKKB414YViFLNrTS8N0FkLCdtSqPcRCrTy0
	bHQ89BRMaweNRoJ86gQlet2wiO/1eUn9IePJTFgkqicPhLMjBWiy7n5epcXUslo=
X-Google-Smtp-Source: AGHT+IG330zsN0flUqcTgZUnJJ1SpIQvi23hlZqBRQ8HFr1BZREwbQHpxywMkQFN0Av5sFjn2jDufQ==
X-Received: by 2002:a5d:4535:0:b0:37d:49d1:1e89 with SMTP id ffacd0b85a97d-37eab6e46b9mr1521452f8f.27.1729253849150;
        Fri, 18 Oct 2024 05:17:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160dc9370sm22535955e9.12.2024.10.18.05.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:17:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] iommu/sysfs: constify the class struct
Date: Fri, 18 Oct 2024 14:17:25 +0200
Message-ID: <20241018121725.61128-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

All functions that take the class address as argument expect a const
pointer so we can make the iommu class constant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/iommu/iommu-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index cbe378c34ba3..170022c09536 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -34,7 +34,7 @@ static void release_device(struct device *dev)
 	kfree(dev);
 }
 
-static struct class iommu_class = {
+static const struct class iommu_class = {
 	.name = "iommu",
 	.dev_release = release_device,
 	.dev_groups = dev_groups,
-- 
2.43.0


