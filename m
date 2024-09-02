Return-Path: <linux-kernel+bounces-311584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67A968AB9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF60A283C44
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA25455887;
	Mon,  2 Sep 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtmt7Ndb"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771211CB519
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289959; cv=none; b=ijxYYVIAiB4MQqAtT4cZC+3x0GIapZBDUv2wYpIepoD99ZppjVJj7tynZZWb8GjZgbI+a0Unwtg8Iil8q1MaGP8C3AAXksdPFNAWg7igxp3hwLzmu4Q2upBhrWxFGGJSvCY3nVJUZXRi3pMvQTT/Y3rnsNJpzuxHnfCaf4d0fI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289959; c=relaxed/simple;
	bh=Gmiv/E+cDRWnVMlt9y/4OfF3IdLGtZ1sh6be+KXdINk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZAt1xWyr7vBDM0JEQh9bDPHVuGE16yJxLeCKQzdCinxiM3mEiGcUlfDaW2NIQGTHyiMbEdeTNf9t4OjbF6vcnzcl9jjaGVPKLRd/Gtc2WZd8xlSeFm0Rz/1vJ2tAZFNYs1FI5JS/KWmRbjF5p4+iikEYkOomxFfZr9gx5kQyGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtmt7Ndb; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f4f24263acso65069241fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725289955; x=1725894755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HwBtwHrsiFKlPsAPLNk9m8K2n9DcXTsTBYrntTzFN+4=;
        b=gtmt7Ndb+J8vkiX9zOGLpFVGJswzPG61OVdR3p3/oVC4bMbe5p87ycIiYjN7x/nHI4
         P/+WAHVypd0LQtdf4A5NXm1a1WYh0C4yh1BkQfzOKuCKTqzqRgHduTbUnKmY82YhkD6N
         Ka3Luy3LH567LLP0Yn/R7npSHlGPoaxUAhWmvpyFvMV3U/mNoWX03nVUGUHDYI4Rk4uM
         UvBVo2xFAHtNksUci099Nj1Zwh43Cng/0iQmhquh3G0damRArp5hAXVZDOU5A7gauJvN
         aU4ONx7Q7dw1mr4nfQOqrFhHg1Hj1AcjocJXxUMG+huhpEyofiQtIxIMP3y8p4YkjDt+
         oDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289955; x=1725894755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwBtwHrsiFKlPsAPLNk9m8K2n9DcXTsTBYrntTzFN+4=;
        b=de5F1X40KvJoN33oEHgIy5To5OcRvzxNR/QgyqRp9ofqaGL0vYrD4Mkqsi8OaCeaPB
         ZqsI2GX7EUAD0XObQl4noxe+EZaY1EnsXMzqMX0UdY+PRIaLZk394fQAlCpMe1oltHZf
         pb5SgwB4AITnd3hu2zb4h4UQAomrUoH/Jc46wkCqF0SpdliguYsSSjcBETvbAg0Wyy9I
         W8HUZxm42y7jtqgt67BW8FCHJL9KiNOxvvhS56xU67NG1qILX/SJ80uSpKqjLsWDYOiK
         Dw49Xa7Ujz4AVMBo0YOk+xwkcdcBJUOtD3F6U9qtFCJ4rR8PFcmNErV7+y9ME919vZwf
         NNPQ==
X-Gm-Message-State: AOJu0YyCGKNghQCExdgau9zj43WXQz2rG8YlMmqvCHTmnLZqjFD801w3
	fmS9Wfb6QvY0a4ha3V1P6t6zRVtEtcSbaGFsp+TMukOH8v4w2ffa3Tj5BJ6mTOt7vZ1mPe10xjH
	JFyg=
X-Google-Smtp-Source: AGHT+IHmQ5yecOA48RQWgeB0rb9/S0HYng5ewvld3qXwZ6/2jVYReqFiUM10vIrA9Xd1128y0qC9uQ==
X-Received: by 2002:a2e:a987:0:b0:2ef:226e:e150 with SMTP id 38308e7fff4ca-2f6108930d5mr130784961fa.32.1725289954815;
        Mon, 02 Sep 2024 08:12:34 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c255d3da3fsm1923394a12.79.2024.09.02.08.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:12:34 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sumit Garg <sumit.garg@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] mmc: block: add RPMB dependency
Date: Mon,  2 Sep 2024 17:12:30 +0200
Message-Id: <20240902151231.3705204-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent build error when CONFIG_RPMB=m and CONFIG_MMC_BLOCK=y by adding
a dependency to CONFIG_RPMB for CONFIG_MMC_BLOCK block so the RPMB
subsystem always is reachable if configured. This means that
CONFIG_MMC_BLOCK automatically becomes compiled as a module if
CONFIG_RPMB is compiled as a module. If CONFIG_RPMB isn't configured or
is configured as built-in, CONFIG_MMC_BLOCK will remain unchanged.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp@intel.com/
Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB subsystem")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
Replacing "rpmb: use IS_REACHABLE instead of IS_ENABLED"
https://lore.kernel.org/lkml/20240902080727.2665235-1-jens.wiklander@linaro.org/
---
 drivers/mmc/core/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index bf4e29ef023c..14d2ecbb04d3 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -37,6 +37,7 @@ config PWRSEQ_SIMPLE
 config MMC_BLOCK
 	tristate "MMC block device driver"
 	depends on BLOCK
+	depends on RPMB || !RPMB
 	imply IOSCHED_BFQ
 	default y
 	help
-- 
2.34.1


