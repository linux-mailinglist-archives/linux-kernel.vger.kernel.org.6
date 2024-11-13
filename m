Return-Path: <linux-kernel+bounces-407334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BF29C6C11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA58288942
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2D1F8F1E;
	Wed, 13 Nov 2024 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMVBDg+j"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847B1F8190;
	Wed, 13 Nov 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491498; cv=none; b=fzTgB8fTK05Sk/GI+x5fU+hhTXIjmBZRiOpFSEeHMJ2b4tG/c5K3q7N8Ne1VCYcKYNck1K/F2l83X6yCo7p1iZ8EldxhkLZiR34pORETrm4Zm0gDJd8txJTd1ZqJYXA+eyYoucxwhPoN1KkP080ic53Tq3FxvOFAH9IraLF3PeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491498; c=relaxed/simple;
	bh=nYyRxnFF/jwmIHY+f78CqbSRmWYA8avGOLYGGmATsYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V27qNtBJFir36gL8jqv//eb7VdDjp2K7JxRDIUfWWT5xZ4PmzmVQ3QmMulgRhQgAceilD03t3sAH7tHYXIZQcoqSRjOe0Kbt9NEQA/abwhMF+lLnTS2xV08pX5qfBtEhDoIfVrvOpWipYMt7PgKoPVCIlivptkhRDSpS0LHsQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMVBDg+j; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43158625112so59350545e9.3;
        Wed, 13 Nov 2024 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731491495; x=1732096295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ma6LJpMyph5BlokEgD49BI0xGCXCShWZectdP6DWsY=;
        b=BMVBDg+jXjizTSR/l65i0mtfSOei2x3jX5b3e+RG7dl0SHYQeZOLdA1QqgHyOeax6X
         wPrULr+MQ2Eie8IhQiDRM63LmHV/e9ejE/Is+Vn8M/jzKLgSlkIgbqEA7E45LEXnZ5pt
         1Vg1Fil5uRpIJIkUCRkJXAet+bzhcDep84Vww/lAYJDF8RydtEybUgVdUgAL8+vYGQUX
         /cpEGD1px6GjchBjfBpTI7zoLJblCzS6cnySmm+xAyt/DVzCCzIfKfyoUNK2OWlt8nSB
         lKFjpjdhKsohLfkBYSMsQ4TNgJ8Q5IrtRx6smPaT6MMB35uIGrgCHPm8K/gTRwkN0/Tn
         B6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731491495; x=1732096295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ma6LJpMyph5BlokEgD49BI0xGCXCShWZectdP6DWsY=;
        b=AvK7Q22M9pULC2mw4+pzhXHBHGp4Nnkxo/hI0QyEqc27ml/SFrUYRkSEODbC2BqXN4
         DMV/1GvAL1b0e1m8SjXqJw9lzco5755yjGa9TUYv6Iq2kGkalZGP8ka4SPtQ05oG4Qhy
         UBHVsthTOiMBD8eFaPZD7B9duAah3sNRLOwEFXTZS+T3TwFHRbgRKKkdpxSV58uEPA1I
         Ee98tU2L/Ul3YYyL7U+6/yHGFasDBdDL9oU3Kl4lqJ5CSrrKBjpPz5IHIF3XYTtDkmR3
         MnfM+lYXiuN4XHjcBe61aim58Dcs8VGep+5xOyjg7T3ytbrD+uf7vHBnENiBmhKtC3Mh
         OW+A==
X-Forwarded-Encrypted: i=1; AJvYcCXVgCFov+tqA1ZcKuydWwFw1HWfRZHwCoC8Ygsx3HfSimlMtkydtlJTobL0I00O5bs9BtWrWGnReakw8LU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0OQgUlNqtVk+xX54eS9FJUN1KyiRA4mQ6nmTlW2qBFqxm+oU
	OyZZT6rHkHP2dGTK44nQWiYtCXkPHCvtpg9Hfx3DHsoIRxFm5Khj
X-Google-Smtp-Source: AGHT+IGIyxpZbftNmLxYcPUxUPbo+RAXDNQ008SUgeUaLnizyTrOrKXnDr99TUt6sCU98PJsbDGvtw==
X-Received: by 2002:a05:600c:a4c:b0:431:5f3b:6ae4 with SMTP id 5b1f17b1804b1-432b7509869mr188198255e9.17.1731491494469;
        Wed, 13 Nov 2024 01:51:34 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda137cesm17407641f8f.108.2024.11.13.01.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:51:34 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Huisong Li <lihuisong@huawei.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] soc: hisilicon: kunpeng_hccs: Fix spelling mistake "decrese" -> "decrease"
Date: Wed, 13 Nov 2024 09:51:33 +0000
Message-Id: <20241113095133.1160847-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 8aa8dec14911..828ec8fec5d7 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1476,7 +1476,7 @@ static ssize_t dec_lane_of_type_store(struct kobject *kobj, struct kobj_attribut
 		goto out;
 	if (!all_in_idle) {
 		ret = -EBUSY;
-		dev_err(hdev->dev, "please don't decrese lanes on high load with %s, ret = %d.\n",
+		dev_err(hdev->dev, "please don't decrease lanes on high load with %s, ret = %d.\n",
 			hccs_port_type_to_name(hdev, port_type), ret);
 		goto out;
 	}
-- 
2.39.5


