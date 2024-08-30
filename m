Return-Path: <linux-kernel+bounces-308117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9682596577B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1633A1F26DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3409152170;
	Fri, 30 Aug 2024 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvqdsM77"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778BC14F9F4
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998459; cv=none; b=J31hO+qAtO8SX53WKZ6C2B85rzoTBhfmgKibluqeRhphZB5CoIwjsnYjC6dqfvHAa3qjInn8Dj330dYiQtRX7A/6rwBS12704ZLoqXpaIIbJknLhD5MoWZnzGgzmWk+8b/94aGVcQnTU8LyBlW3Ib9RQnaBOrayx7kfVjLXE+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998459; c=relaxed/simple;
	bh=wNyTbjZVcZeWtQ/BlRNyw11A04tuQhFdI3SAkNS2RWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R/yJezc/1Jx1PaG7Ch6W4w+SuK9okmnbu72T8JlIdHL11m2QrSiEOICmS9q/EsuWEqWueZF8CJ4ImRuG3/jqYQUTr4e/04HqTD5T/3O3eNpwysEGkVo5dgd/nAKN51BAR6iTL9HugcR54u8pIHNtDu81XIQzbSE6IC83efDHCbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yvqdsM77; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so4287043a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724998455; x=1725603255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Yzw4BhHGFBoSQw0otrHClfaogVrdF5imgHtQgCzAUo=;
        b=yvqdsM77mpZ4ql8+fhoe59/wIU0W/FSgEZB5t9d0L6MjwBeIdUdPJXV7cZGimZCLFq
         xdl4QHprYEycor8AdIcikOKI9lmMHtDVR56rMRmsJbJrW+fx2ZAzB1wd5AmFtMxvobp8
         01jJ/j8toPKDjcOXFIdlAGN9dhIiN9viGrqmpCptJqLohNbp+Ie3wke88D7cEP7vr/XC
         T5ncXNM91duw4JEKx/yGorfAQRNG6zxRKJ1D40d5mSfu2NUXY1v/ZPHaWPkCW81MrUIV
         dAO0wgT2QVzqRlOmJk4xAS3/n3d9hCq+EeOfKE+w4WHTPzgotdchXtRWpZh/rOqjuNy0
         T96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724998455; x=1725603255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Yzw4BhHGFBoSQw0otrHClfaogVrdF5imgHtQgCzAUo=;
        b=VoNFGOal7mJUWU+ePSAhM06KjjnY62AWsYZN9nPYUV36MPbRBKNzmOjlJdvhH5dU0v
         yF3YEx+VOsJRf9u/3b8NghWRlcFw1LVH8LB04DwRnFpLcQzJqk3QgvfW+IwwcLKPuvNH
         ND6/tWvzLp0M9p/D3rDZ0AjE6h+MkXA9R1DhQc6JphRVXDqNxe1s0hfxgZThia00wrHQ
         UnAFBegv27mFv6FefDgMDz9zEvYsp2UMQnYkAcA77rIkFoCZVl3QW4NCt3V7NK7sN1Zv
         dmmbj0AVMAKuHbRON1Z8aJL2OgMhBcNP6gV51Ki0+IXDP3wB4MuGUmPBfhXJvY0sU2O3
         tKLg==
X-Gm-Message-State: AOJu0Yyv1HmflNhRkVLBEjGWXr6vqCX/Kls4W3aYlIO3khiAPFBnzJId
	Y97LnBUzDnnB1/9reh+8S/bJr8zQBb3OCYtdmXcmKWXuh3/AGlL2VxUJrBRNY8r/fg5dH7hQIBG
	NRxg=
X-Google-Smtp-Source: AGHT+IGXsi8VJlVJC4hmbvBdXPPbx7Ew4xOXTgRXlkX76r26u9VjORvUxAVs5MtLFMErlP+C+TeXJw==
X-Received: by 2002:a17:906:ee8c:b0:a75:1923:eb2e with SMTP id a640c23a62f3a-a89823ca0afmr466226066b.14.1724998454984;
        Thu, 29 Aug 2024 23:14:14 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989022ac4sm173065766b.59.2024.08.29.23.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 23:14:14 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] rpmb: fix error path in rpmb_dev_register()
Date: Fri, 30 Aug 2024 08:14:04 +0200
Message-Id: <20240830061404.2831708-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until this patch was rpmb_dev_register() always freeing rdev in the
error path. However, past device_register() it must not do that since
the memory is now managed by the device even if it failed to register
properly. So fix this by doing a device_put() before returning the error
code.

Fixes the smatch warning:
        drivers/misc/rpmb-core.c:204 rpmb_dev_register()
        warn: freeing device managed memory (leak): 'rdev'

Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB) subsystem")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/misc/rpmb-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index c8888267c222..9d41404f8b91 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -187,8 +187,10 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 	rdev->dev.parent = dev;
 
 	ret = device_register(&rdev->dev);
-	if (ret)
-		goto err_id_remove;
+	if (ret) {
+		put_device(&rdev->dev);
+		return ERR_PTR(ret);
+	}
 
 	dev_dbg(&rdev->dev, "registered device\n");
 
-- 
2.34.1


