Return-Path: <linux-kernel+bounces-310798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BC7968161
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718F31F21C50
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D69183063;
	Mon,  2 Sep 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHR8E6N/"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222C317D378
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264463; cv=none; b=Mxa+3OBLzJEvkH2u6IZF2da6R3clR3fYcY8kWBFwVbep6DhfVWtL6mVNzBWBZfXsQIknJncvLOFUCIDqW6L76GsJVr5Idjbe5TPeMb9IJ28h6uCyYf5V/4+5+VOeaGNPSnVnerw4NPNkBlQUES08Xt10oMC3Nlg+Me8GZ02tmGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264463; c=relaxed/simple;
	bh=rSzOLDpxNrGYOFBb9/ohAD5jEwjufWFBu3BNvtsoDGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KFUPQ7aAhw4o8SruTFaU2JBCZSebgpVf5PQb7Fl9jQhqcw9qf1DFkGjonJDFmFgFMi+VQGbcCNd6jc1x1u16LG/yXwCLk+om7nNA8GZDUNnxZpkln5rtCz7hGcTQeaK5TS+TkVIL7MGdzWhVG8Evs4Q+qJQNz51hDZZEbfBkaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MHR8E6N/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86933829dcso470607366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725264460; x=1725869260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIWKMObLhmm0ReUohPT5N3jC+cuFjQHBvP9sAB92UL4=;
        b=MHR8E6N/ydspi1e+5c/YqAWlKEotxalGkk2FCxo3w7mO76om99XtQpFJ0IQmlPZbir
         rw1OZpTCimyu9bUpcNdZsLsL88NTGL4zinI0B/59vT//huo7N0FWSATlaY5mjdeVMUSB
         EzrU1Kk0YUxd5yYoO5wuQQkNycdsHBTU/c0GYZ7fjRmbX+qu29bn2cyCPCb6FideOI1K
         SvKAvsGQ/8XS2poJBcqPk+fp1IXE07/ae1HM8T5qOHDgl3zRZoS0JAs96eMCOdg2KV9y
         ckGFj7RTWIfuyck5O/kZQclHwzG6B/9I05JH+Ad2OR3zpyvGws+tVdUqKMiePA6OCcFr
         n+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725264460; x=1725869260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIWKMObLhmm0ReUohPT5N3jC+cuFjQHBvP9sAB92UL4=;
        b=It/7szsJ8PoS95uk6UeiSsdFve05JrAlOP0B1pCo53nGaMLQBdZ3JKqr/cvvuXgjIP
         aPU3RCqK2pOOlcSdSq+zSvNBDTtmPJW08t/vCbKsfOyViWd1mb8S9Gy170/lM6DLM5Sm
         nWnG8hoWS6CY+5AEocx+BlDlh/+P0vOEE2UFCoI+7cm4oVkLuCqUqoffnfECTcUGudl/
         BMmvh8jZRoiKUH28Mw7tEmgWmWnPXubzGu/L3aT83ubQlnnbHF02f4WDj7ZjJy3cqCfi
         wpIalasRXwXXaM7TtReG9296+6q8HBWOeusviutKHYISSY3kxvgMKJSf1r+xy4FSPUek
         CB5A==
X-Gm-Message-State: AOJu0Yz3ArK2syE2EJKpbSaESKlaZYK2H5SyLDXaLGoSp3OJLFL6nru/
	KZfNBVg170LWlXctqUQ2ahG03NOy5fgqttLtPvFj2B1jaTX7gMRlxeh+m3+D9U7fHqGGgs6KvUu
	IVmA=
X-Google-Smtp-Source: AGHT+IGaGrxRY5RAoY0VdDbHyTCkaRCV9CYZOghqLcPJgyVc4ghnTQVj5b8CXWjl6uYumgPdiIADtQ==
X-Received: by 2002:a17:907:a4e:b0:a77:eb34:3b4e with SMTP id a640c23a62f3a-a89fad7b7cemr220065866b.7.1725264459933;
        Mon, 02 Sep 2024 01:07:39 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb0cfsm524973566b.8.2024.09.02.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:07:39 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] rpmb: use IS_REACHABLE instead of IS_ENABLED
Date: Mon,  2 Sep 2024 10:07:27 +0200
Message-Id: <20240902080727.2665235-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the macro IS_REACHABLE instead of IS_ENABLED in <linux/rpmb.h> when
deciding if prototypes or stubbed static inline functions should be
provided. This fixes link errors when the calling code is builtin while
the RPMB subsystem is a module.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp@intel.com/
Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB) subsystem")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 include/linux/rpmb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
index cccda73eea4d..37b5273c4027 100644
--- a/include/linux/rpmb.h
+++ b/include/linux/rpmb.h
@@ -61,7 +61,7 @@ struct rpmb_dev {
 
 #define to_rpmb_dev(x)		container_of((x), struct rpmb_dev, dev)
 
-#if IS_ENABLED(CONFIG_RPMB)
+#if IS_REACHABLE(CONFIG_RPMB)
 struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
 void rpmb_dev_put(struct rpmb_dev *rdev);
 struct rpmb_dev *rpmb_dev_find_device(const void *data,
-- 
2.34.1


