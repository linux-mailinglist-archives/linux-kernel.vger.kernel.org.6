Return-Path: <linux-kernel+bounces-338379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1D7985714
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC7283058
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2B015B97B;
	Wed, 25 Sep 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSP8l8H/"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1880043
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259612; cv=none; b=Fsy0ZCPTHp/22iy6SagA/FFX7J6RtviSXa4tlyzaOI1xxYsfL8O8MjtVQeXyk9ImZwNRCqJg5r0SI9QSozgQ67gT/3OFCXVW2B/5nw23Er+0mobfLFLXh4HA2YH8Y0Fjk+riVI0VOxPl7uSAfwo5AL3waWwhe+vecifJUMTtlZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259612; c=relaxed/simple;
	bh=voDV4wFQFi2xOqx/UnjRHXuDa990Fddo2SCDz3KIxNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dO/8tqRELlPOrK6w6we9EQkqhrM5aWzgmdqkV/L3a1dQeNjXikeohzbemchXlIl9aDfmfUp35tVLD+z/4mZXzsWdKKieK1kClcxxod6jcw7vDemJWhscKB5Nwbo+W5KlDb9VzuhP4zLemBTNGM2wS+iDC21lAvyngytFGHrYccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSP8l8H/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53660856a21so6437495e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727259609; x=1727864409; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9VUsotsT7+jotjk+NaxATMLAWETEEo1ZJ/3V2VQxDE=;
        b=KSP8l8H/J0CSRITj8IbHWO9XA1iAkORW0J64edUtHuckJVMLOAevWNLpNrfbUnZmdy
         7VM5PeVsLVz7RCWNbWRIgrn9AfuPsNFKG4//XULJ+T4OWPyYqv1E9+AIqcdF9xhbbaln
         oe33mgD+y5OEPzl8RsE/UyY7Q+HGnNzC6q2BldMNGr3a7XHhXFVizgAUZ/1jxpIfLx91
         MrY/Ki+IlA81JhIYaMCaGrou7Z0YjgmtE9xDGRwOmzou+9M67baJ1rcfzakbaLlNiBh0
         V736QkEucR/kYD0qezobt6qV0yawJ8UvGMRwshBVnCyofdAA1HYba/vvJQ1s7AqaVI7E
         JoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727259609; x=1727864409;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9VUsotsT7+jotjk+NaxATMLAWETEEo1ZJ/3V2VQxDE=;
        b=KnFXgbVh9+BPpkVXPYhssd1fKghAudb289trIo2ov+mbe3+01LAR2pmQwi5FDRHP9i
         Wwnnc3mdH2r6wYKtUUuJwfL6m3i1jSCrXLdsbYt4O8hq2tCED6C6sShhLzv3jKdm3AOr
         oEwgp2VqhpPscz+INvCdV/+esu2rV+EVehE1bZ2PbNXr4f2427uPa8BzTojBWuL+Tm6S
         r9ZwXC8xpjQLVXMfXUIo4Rg78IBLtnOXTocTPekdM9VcumB2nvjmXeqxmRIA1DnlmCGS
         lBjlb2lqgMIiFKJIb3nz8wpjiZ8CU1QuFmRG6ZPl6KRRKOFXKhIUAj/BdwuMBa9kQj4o
         h2NQ==
X-Gm-Message-State: AOJu0YxqVs+TAihVoPEoeJ2+T9CdiFopS7QYqWYLwZgs1MZXNSn0XvnV
	ShYcNa8zgw27sD2jt20Ar8bEI0T6Nsy7F++sumb775l6FLsVUp7I
X-Google-Smtp-Source: AGHT+IFklTGcVK7E1XRpWZDj2mzINC5ooVP4yvjosH4DwgGG+q/bPwyqzQJ1hZMkxYNx7VdHSGUBkg==
X-Received: by 2002:a05:6512:3b8d:b0:537:a824:7e5 with SMTP id 2adb3069b0e04-53870499ad2mr1329071e87.18.1727259608346;
        Wed, 25 Sep 2024 03:20:08 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e0515sm483656e87.42.2024.09.25.03.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:20:06 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 25 Sep 2024 12:19:53 +0200
Subject: [PATCH v2] mfd: da9052-spi: change read-mask to write-mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-da9052-v2-1-f243e4505b07@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMjj82YC/2WMQQ7CIBBFr9LMWgyDmIIr72G6QJi2k9hiwBBNw
 93Fbl2+/1/eBpkSU4ZLt0Giwpnj2kAdOvCzWycSHBqDkkpLi0YEZ+VZiTAafXJ4t0ESNPmZaOT
 3HroNjWfOr5g+e7fgb/1LFBQoPPXUt4O08ddpcfw4+rjAUGv9As19q6ycAAAA
X-Change-ID: 20240918-da9052-df843a1b9d0e
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Axel Lin <axel.lin@ingics.com>, 
 Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=voDV4wFQFi2xOqx/UnjRHXuDa990Fddo2SCDz3KIxNY=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBm8+PPkmMquWNBCCAuzYsbhPlr7dGZeRrF3DojM
 FYm/dK0kQeJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZvPjzwAKCRCIgE5vWV1S
 MiFeD/4qUDw83fwOCsbEX5dJT1N8f99+/+Ziwgbq3Qmz/qsSgJSGEU99gqNXAXocaXpTg+pAhsx
 MJVNHPYCBlSkjo7YcA7G+2XPjTqDUOF5EzA/BgAWlBIqSM8NZ1fvi1dxtznE+Gc3wV8foPd3veQ
 fQO3c1MQh+drRNNoozkx9Ch3oyfUZ0POKP1RL/r7wpy5Y7Ws7XUgbiHRk941Tx3J7HJG0VBPc64
 xyS8EQ8xf19No3qT45V6MRQ38ZSRzPycx5Rzl5f+BkDrRx0MwgEMc99VeBvpRkG24FCpwfpk7TH
 YrbBYnI1UyZj18RRadPyoBmGi2WP7EOEjxbeeaR6rGLkJvs/eKvfQwL/iYOfOAw2rj2LKhXK+/6
 fA3Cf30i6SEUziXjS0jyDaGqHE3kuZ3H6gvsicpsD6WkiToxFDGr1kE+XrbcP3whZkGI1KiVmPf
 m5FlpZmSU0rQifjFHh9FWEYDXNgZLcfy+47HdVnpaAT19HExqykm351p9BXyccDaCVkhPJ20Rm3
 OvfD4/adIAmnxgET+J87iGhnbLb0lhSaDEqIpS13IEU4C+35IjotqyBqyVNVFoSnNiqvuB0AiUv
 KbrsksDgsSnpyKWqfUEhTlhx74nY+f+EP9bj5WLoeYhMyCfl7S3d0nO/QiSWZn5Uyq571rA7c70
 2vA2yzRFtRyss4w==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Driver has mixed up the R/W bit.
The LSB bit is set on write rather than read.
Change it to avoid nasty things to happen.

Fixes: e9e9d3973594 ("mfd: da9052: Avoid setting read_flag_mask for da9052-i2c driver")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v2:
Reword the commit message and add Fixes: tag.
- Link to v1: https://lore.kernel.org/r/20240918-da9052-v1-1-ce7e7024e48c@gmail.com
---
 drivers/mfd/da9052-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index be5f2b34e18aebc7a9506123b366af5a5447df43..80fc5c0cac2fb0e5e99e6db8972f80ae4155b226 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -37,7 +37,7 @@ static int da9052_spi_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, da9052);
 
 	config = da9052_regmap_config;
-	config.read_flag_mask = 1;
+	config.write_flag_mask = 1;
 	config.reg_bits = 7;
 	config.pad_bits = 1;
 	config.val_bits = 8;

---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20240918-da9052-df843a1b9d0e

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


