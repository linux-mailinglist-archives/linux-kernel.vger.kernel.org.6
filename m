Return-Path: <linux-kernel+bounces-446557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9EE9F2619
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4658316538D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE491BD4FD;
	Sun, 15 Dec 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrV/4c3D"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA272110E;
	Sun, 15 Dec 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734295847; cv=none; b=PiVIL+TIKGlxZ2qmcx72TZByHbMrM+6O1GqfCk/LD/Enr+w6i3X6o/e2IWj+fndQjE6uWKHynJd6s1qbjVWGriI/2EcVrl23Q7cYsmFezBIOCeqlHrdIplIM78LQDhJ8MXZOVorE8ACwGDwuNtnw9M4Kbaru0vBij0L3ILMvH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734295847; c=relaxed/simple;
	bh=ly7KOMis8y37i/Aj18BLstwTMiqKtz7KWwawzAsGmyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qptut5C4YLHaAM6LBeE59LndK+s7XobCGffG2f2WiD5PKj9sOEBqa469q743r12EjKFjrq6GmM1JvSuK81RAb+4sxF19m9AEM6tdk9fvavx/rJGAbzsOwWkIChzZ6ry2dgthP0rUsasLOhqpJp87tpq38LlSV8uWciQGTHQdwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrV/4c3D; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a9caa3726fso11089855ab.1;
        Sun, 15 Dec 2024 12:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734295845; x=1734900645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSzYDwGU98hhiIHp7Cz5Q+U+n3DYeO6hHfkJfNIvdSw=;
        b=PrV/4c3D0f5YfsppdVIheK+9Ap7J1m364lzWqrDTw+aP1mEchgZ0vLE5yxGhM2KPL+
         +t5ltgu7ITi2SzjMAgEhY6u4KJ/c8MmjwotPxglbvn8HIrS3E4p537SaywJlN4koOeBl
         jg2nIzLRZUoBrmS/gj57iiBxyPblJNiLXlVrBs5KZE0zHT/Ze3zFVifSRf1fK2aDEzWJ
         kOSjpD/qG1vjQvlr3q+94F16sE2SHCNFfp1wakzAfCJQh8rlmcdF9w+WD+gIgLi4bktm
         7/v5+MY7FCcljsJc52JsclcXbrk1tPlJ3ecPsthY3CXtVxeqOXWY4V0+vn9YM3x1ZE8M
         B/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734295845; x=1734900645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSzYDwGU98hhiIHp7Cz5Q+U+n3DYeO6hHfkJfNIvdSw=;
        b=QbZg/iOPXClb7vxn8wqmSc1MteFbrl9vwKADXwNMU5tEc4pvwLqCuikBFUMhAlSPqb
         XfJJSDJzY9rTwFd2jJhoAQfVmMCZZ+pVf1CrqDob4A7ctsf8YFp+axFso4/heEkeSbf2
         Zqq505jmoD23oCcBsoXDuqH5oW58S2Z8rYq1l4OzBygk5YcNFyv07ftg7npzbK6uBdKn
         FUT7+CjV59KUr95ELd2PDgnelRYP1xfc8ilrV9aMl3lgDc+b+DZ8t94OcvKd0/LJsyIW
         YHkhDjsGOolrz2aACgC97355ib3HNvePQPIq73qSJKwoRKjbdCUqxe6bENSsW+ZC+GZw
         OzCg==
X-Forwarded-Encrypted: i=1; AJvYcCWtvCUWdDmQ1gQ5/XoNuEU0ANV45g+wfIK+rADxcA+kl6hHNP/1EaiJ+JgWlfKygEuB40fMqIJ+Ad9l90g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlV6b80k0oEY8ETZ77bgTTyrGIh9nwSp+AqOL+catcwugx2poc
	asyd3HUM1m/Oe4EcMwZtB53AJ0CMjSYphr+R3p3sa44u8muYK52b
X-Gm-Gg: ASbGnctLapSLcre6QRQ+Ie5vDkIEl9Y/5QdG3HBb0dyikM4e4gbF/eFSPTHD/A/taba
	dFUkt4WNWoo61PylmD5rNkaXNFpcwwf9ezWCcXF6YsgFdVdcCv5O0n68EuJCkLMoYn0JxFRzaaZ
	QR4f6/XB3Z7pIPFt8NqOhCzSIEdX7lUK4yDMySvwiuyfI3xB9qj8UDcihltQpt3Ja+q4pACnKMV
	/aTyKaoxrZwEl9p3L5GcR84pd7p7qJtSsPvY/PyvCDAJzDRxg1NbB9UhiG2jDvgFEvk
X-Google-Smtp-Source: AGHT+IFDFQ4UWAS7qksUY4FPCHbmBK+G3GsrMV8OcxRDs1FPFeMGZHpNKMua2Z0CdUsb3akbTA3/Ow==
X-Received: by 2002:a05:6e02:1561:b0:3a9:d404:c427 with SMTP id e9e14a558f8ab-3ae6551d29bmr119755435ab.7.1734295845329;
        Sun, 15 Dec 2024 12:50:45 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b248dac6a4sm11735775ab.38.2024.12.15.12.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 12:50:44 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: gregkh@linuxfoundation.org,
	u.kleine-koenig@baylibre.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] usb: gadget: m66592-udc: Add check for clk_enable()
Date: Sun, 15 Dec 2024 15:53:58 -0500
Message-Id: <20241215205358.4100142-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: b4822e2317e8 ("usb: gadget: m66592-udc: Convert to use module_platform_driver()")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/usb/gadget/udc/m66592-udc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
index a938b2af0944..bf408476a24c 100644
--- a/drivers/usb/gadget/udc/m66592-udc.c
+++ b/drivers/usb/gadget/udc/m66592-udc.c
@@ -1606,7 +1606,11 @@ static int m66592_probe(struct platform_device *pdev)
 			ret = PTR_ERR(m66592->clk);
 			goto clean_up2;
 		}
-		clk_enable(m66592->clk);
+		ret = clk_enable(m66592->clk);
+		if (ret) {
+			clk_put(m66592->clk);
+			goto clean_up2;
+		}
 	}
 
 	INIT_LIST_HEAD(&m66592->gadget.ep_list);
-- 
2.34.1


