Return-Path: <linux-kernel+bounces-178085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A2B8C486B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC741C20E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124B880BF7;
	Mon, 13 May 2024 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="zeR68r05"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE11C69E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633313; cv=none; b=clRqjq7UGRkFBa4o+bcuJCpj4XpizR+ofoA7OUyeR7hujylHsKh9Wqre003gD1Pg2DK3QJ83v5Fwa1sRdTN0MzxUtxP4yaHUY/HXFl/A//2Moppkk257jBqyETQ6XPH/yNGDelrOhCPSK2aTUmYllitRAuXoiaO2KwcVfBvVSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633313; c=relaxed/simple;
	bh=6NQIZmC3T6mXsunc4jLDIVJ5qfYCcsJ2E5DUWCP3ZnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hn18uoZBBJh/SA4jeOC6JxXWmwX5bhJ+4yZJrcTLJE6mnol1mBs0M/XBMxqxF83CyQRjVsyBy3aUItNkxMXhzkVIrvYqW1787YUq4XzVuN5WrcWMjxAl/FRTOKPNBzhEpn/GBB/wMCnYvOkEtu5AZ2aQnUfQ1bqgEwdIWwafrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=zeR68r05; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso6633571e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715633309; x=1716238109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OYPuebCXrFPix/veQ7EJx4DLctq9sIXjWmJL94zNtiQ=;
        b=zeR68r05bAxYKOLQS3KP4iK8OW7aILPosvIN8sj7f2orjit6hu76H0YWw2K1ZIxOOe
         5hydaRQuwJa1FdfZiL5Kyfm5bSDx+PZ2D7MSqz0K17TPQnWb0RQcdpRWrKimEcRfRJLW
         z/t0ibfgBn6lN8/ArnqPGipM2u82KE3xscLN3YzNysNNmLPGPvSTfvd2qW0ApJeDk1KM
         Bmc7//FV+uJhnUefcB4NTof5kWtc4R7dHpvuyEpJAr3y0ZwsXHIVbjaRLmlk7jM/vO4y
         p0T1mRIshugR5QI7YAo/ENm8zhQI+9Q4H2bHciFja4PKAeEO2zo3NoLAI0HSbLNk5Xgd
         81GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715633309; x=1716238109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYPuebCXrFPix/veQ7EJx4DLctq9sIXjWmJL94zNtiQ=;
        b=c+rdysVTJp3s3LuPFh9SSwVOwHrlJjbNHfAziLcXP5oR9RcMRb0hoygW+tDnpXvxW7
         8KhshtbHa2yqF6h0UiKX06e3TJYpfaR5JGxXRoVkn8hq0sMd8IzTEaXcpjIvUBZFFyL1
         YJ/r7ZAPW0IhCieDI+DXd9kWOxGtVYroYMp19E7VwBcPtxA/LJGNCe2CZDfYWHR7DGNG
         JxkxUOKG4N5vL7Wqhoq77lN6ubSli1m4DCqjRFQOuEtovBwX5DpaKyGsTxf5vS4opofR
         HCPIPLjo92ymoN9Z1Ew9d+c9tCetSOtiM2x9ke3pdO4y0Uc5GdkRTUahOH9tWU2vY+XA
         XorA==
X-Gm-Message-State: AOJu0YwXSfi7q4PO/gJRpClrgc4hQ0Ucipp6EOTXY7qyxbQ2Nhdf91ow
	PWz68Z0pSniaNDGb341yNsFFokB6vQAW/oUzI28Yr/yhugylXGgLOJIXzADBwrwQd7WmaPkzmKX
	H
X-Google-Smtp-Source: AGHT+IF/inAnv/4T/Kb5npOSIXsW2SLYWE+QafUUGSpWMdqVFgDTtKv1+weAXPEwdiYP2qGxCGGtqw==
X-Received: by 2002:ac2:446c:0:b0:523:5dcc:c72 with SMTP id 2adb3069b0e04-5235dcc0ea3mr683318e87.57.1715633308683;
        Mon, 13 May 2024 13:48:28 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17886sm639699866b.210.2024.05.13.13.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:48:28 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] w1: Fix typo in dev_info() message
Date: Mon, 13 May 2024 22:47:34 +0200
Message-ID: <20240513204733.291673-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/exists/exist/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/w1/w1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index afb1cc4606c5..d82e86d3ddf6 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -504,7 +504,7 @@ static ssize_t w1_master_attribute_store_remove(struct device *dev,
 		if (result == 0)
 			result = count;
 	} else {
-		dev_info(dev, "Device %02x-%012llx doesn't exists\n", rn.family,
+		dev_info(dev, "Device %02x-%012llx doesn't exist\n", rn.family,
 			(unsigned long long)rn.id);
 		result = -EINVAL;
 	}
-- 
2.45.0


