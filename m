Return-Path: <linux-kernel+bounces-428156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C312F9E0AC9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C2A281669
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1A11DDA37;
	Mon,  2 Dec 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cuzW3LBD"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3C1DDA2F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163435; cv=none; b=mjur+sJi55JGseo+hjflQKldZ7FiXYGFGgRQWV5sXVVghEwpkq0UyeixLpYSN2oytuLmW7SZnL+emgP1qSrnWuNKddl2BfzX6m2HRILCPuVv8Nl1xuA86DgaSicq+dfreOqChv5Pvmqu/7FFipZOn3el2wkZrGMJ8MLtHlI6wZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163435; c=relaxed/simple;
	bh=i88j319yHh2zG8T4J9vF9CfVLtWB2sGn2HbQeiyoBmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRibsV8c/5ohzXSLomJXsuAQeIAhUoPo87KyZTJ+oh9K8MEkG9tLYdHQf1GsUTlpX0o/6sfjwXA8x47BJnSF7Bnh/7kb9szpaj+2XYCRc9UD6TvGzqY8o5QGVS1Eadgvnlh2JN8hVJi/cXBTt7xRsUjzywo7drUOKUtMuGcgH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cuzW3LBD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385eed29d17so1063831f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733163432; x=1733768232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgdP7+HUTpe6zKfiGIinqvZPW64OFdTHhNUxceJSha8=;
        b=cuzW3LBDxH7XOSLR5TP7s7YuStEULawVViLO91/5foVxva0Kk+EO8KEzAWNo5eatxm
         ObZWdL/CKKJANmnylHeU8KQ3/JBy0AhhVP+o3CQlDhivCdOi3K9rpTepwlPJJ2vknOa3
         KZik0iLhBmJ+6gebItNaVjoLrbRVfpH+rE2y4gaihx4wQRc8lkPGgm4ijZ22yz2lAO+3
         iPlQlzWz0kloxWrpu6R3ezV7gXVgDfQBfaEvGyS3/WMqumurD4MbUssjg+ZtG4YGGy0+
         CSsI8tvpORdIFCXflBJQlDfAHYo4xi4B7ANNdsAF5BUYhmADMI33Umpaid8m91mVED0Y
         LaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733163432; x=1733768232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgdP7+HUTpe6zKfiGIinqvZPW64OFdTHhNUxceJSha8=;
        b=XBVXQZaP9Iq9QmYcu9m16LQEg4WLtGPlrewVTb8DhsIQLwgKdWgF0qH5rA8dXfxK8r
         bz9zcfPdiwESX0M/kTwQSYuHhRHCb2he+WB0HCq8dJjLA4Ds5vFVeqzloPcTf7NR/MqV
         djuxGYI0wRmGwm6La8pBVDaPHFr1g0MnlWu5i+cZuxT7H8iNrFVWYP1541JlY8JzB/Wf
         r5g7wYZeJkjuJgTA/I83P/81JL1rqKqO2FM/XG91tuBsfJoPgyucAcbO/lxQNxQYZCdj
         eXSfemHPByvcWlRIplg44esgX0a8XblcK9Jjdup6SGE9y/miJnVun6CPAHP1M9EbxyID
         AH/A==
X-Gm-Message-State: AOJu0Yxa5ur22AyZWgIq4N5cXkAtUftOxlhxsfWtN4O5CEU9kf5m2+hG
	s6syNhhvlbV0HefAacu7RsyGU9cV2VLLb9R4ZFdDdu9F2DEkHhu1zWIZJmWHmCc=
X-Gm-Gg: ASbGncubOv+Yj5a5x69B1n87URDWrcVVyF1OwLS0U6JuC14wmOifltGyIoMjGDhm/hI
	Tz1+F/5rjmrbKA8+dUUb4Jx3dQZtfJl82cSoniI6a8cTr21mBijUoToJpQHBfXW7CfZh3fRnhz5
	IYGa0DvnaF1+RapLoMSISyxoYgskj3ruEXl2UE9nZ9p+VAqdKaX2r42VAGUQWO+pIV/5zFB9Lz3
	Xlbhvd7iOfq7a1o7mOf/Bx+BXzurZKWGGFHMqmzK5AKL7y+7hiQVV4FEQL9Khuap+RX
X-Google-Smtp-Source: AGHT+IHBZuMRoTqk0ff0zFgomtZh0lwYSOjK0OAouCzYS8LsM73bDDnhaC3ZfGNsquBXzjWB1XFHDQ==
X-Received: by 2002:a5d:5f4a:0:b0:385:f7aa:7c97 with SMTP id ffacd0b85a97d-385f7aa7ef3mr3230079f8f.1.1733163431579;
        Mon, 02 Dec 2024 10:17:11 -0800 (PST)
Received: from brgl-uxlite.. (228.69.205.77.rev.sfr.net. [77.205.69.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a410sm13343303f8f.46.2024.12.02.10.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 10:17:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] uio: uio_dmem_genirq: check the return value of devm_kasprintf()
Date: Mon,  2 Dec 2024 19:17:03 +0100
Message-ID: <20241202181703.28546-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

devm_kasprintf() can fail so check its return value and bail-out on no
memory.

Fixes: 52e2dc2ce2d8 ("uio: Convert a few more users to using %pOFn instead of device_node.name")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/uio/uio_dmem_genirq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index c70dd81bfc61f..31aa75110ba59 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -167,6 +167,8 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 		}
 		uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
 					       pdev->dev.of_node);
+		if (!uioinfo->name)
+			return -ENOMEM;
 		uioinfo->version = "devicetree";
 	}
 
-- 
2.45.2


