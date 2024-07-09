Return-Path: <linux-kernel+bounces-245785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F6F92B936
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30510B23EEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D985A15FA72;
	Tue,  9 Jul 2024 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="or84GZKG"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44015B98F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720527539; cv=none; b=q64808l7iUd8UnpShJU9CFksAbXUEPgm//hU9GTgtry9qZ0ojxoOvs2SnGIK2zQqpl1FzFfzlFwssoxWq+bI9wfAVmVGElCkNDcFE/y41opOdJJq8HIaxaLNkO5WcVuNKb1S+4dvz2VqktnPRItkljQ3I0zic95oPp1UplT22X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720527539; c=relaxed/simple;
	bh=zbv7YtRcsrRh/pS+I8vDNY8xLImRuljkKUBamUIJCt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=duGCi0Oh0yKHdAdRIKqSgQISRqJcxWmjxTkB41xPYEFXSnhDnL8cO6w4Wmq+H9cqmnDEFS0tHzvbVOXMdqAnLchxOK87K5Cyta5wEX3uesFR9/pHniyXXTIQ/aEbWdi+mOVlHttRxoiUG1RUfgqyGVXNqc2fiAsBMgZkvwNgBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=or84GZKG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367990aaef3so3469105f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720527536; x=1721132336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xkkRcegYeGDwTK0EBHvtf6oVMqW1P2Fm8Nd7gZ3YFY=;
        b=or84GZKGsaYXy8peTodujGdFIsk5fuemOto8wfaj8lHC6+dkyUpWbSPmtT6gPSAd7T
         jPESnuYEWA6M/4S/p/UBquOK3GEb+go1dR24osJZGyZIvQehFxIK+NyEjvMdNPRUJqsh
         i3RP75577Q10WbnDMUMOhTwavtrK5T6PhFzQqx3weNNiNJIEw2onrit8CTGblfUznFzF
         020MPCTcQX7GS5zIaPi7jsbQV03asuFAXd1vwtGdv/ZXhvobgUo+yIRzOx1/jAmJRjQ6
         XeQ5i4HHgK4+rPpIkhpdCGKSV04lVAtqAzaaVT75/sdk9bHCQEIx/JA3gXjiniWtCvoe
         NbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720527536; x=1721132336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xkkRcegYeGDwTK0EBHvtf6oVMqW1P2Fm8Nd7gZ3YFY=;
        b=mIECrs6GlMqM+Ae9rpFuIaAvhtDsrArLdBeu7k1tkBdqvdr+xECS6dRTgG3xxwG5eb
         JnXRu1+Mt/abikJY+2i9wi5U/SUHTpUBEO+mje58JrQne9rKlv0GERpNS7lzEEhVdCaY
         RKrMApqUepqo+akbXJK/rkBfl1IPntNeQmbXCbwLEBx1Am+j6unUUZxVI61bZ8dw0tzD
         ZrMyixAoFabZSRySNLZHNEJ2IrPeDN3LFGqDsAxKdJMkzYVZVsgTXkKgUCyf9bRerssI
         pPkeDBxY/97kHbcRAhRqxxDUW1C0ujNdFHCWEncwzLfpGeQ/kyfkwN4EOn1LOJAnbHht
         S/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiGuttCZn6jz9CieFT1otk6BNBxd7gBfYB5NSKojSwNhqmJHgjlEXTZDTsETmNS/vUcIE7IL9xRe+VJCc6P2dAn2nWGsnV559O5d/8
X-Gm-Message-State: AOJu0YwS07puBGhgpB/aggGF1oZTtYhHGz5G/wvntXAB6MfuFkCp1epz
	DOPV3/nMZqDY9Tz2xvXwEF0Q0oZEL7nXhH810qKD9wMxODhWNufq8jjWKZ792WQ=
X-Google-Smtp-Source: AGHT+IGbtHeJCzfGlW4lffEYrD+3Hvy5yFV+C9UCgAKFOnwMqXuUOQm86YyADUBf6ppXYEi1giF97w==
X-Received: by 2002:adf:f70e:0:b0:367:9b22:28cb with SMTP id ffacd0b85a97d-367cead87fbmr1561380f8f.59.1720527535974;
        Tue, 09 Jul 2024 05:18:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c270:70c:8581:7be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06d3sm2390574f8f.75.2024.07.09.05.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:18:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 09 Jul 2024 14:18:34 +0200
Subject: [PATCH v3 3/6] Bluetooth: hci_qca: unduplicate calls to
 hci_uart_register_device()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-hci_qca_refactor-v3-3-5f48ca001fed@linaro.org>
References: <20240709-hci_qca_refactor-v3-0-5f48ca001fed@linaro.org>
In-Reply-To: <20240709-hci_qca_refactor-v3-0-5f48ca001fed@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=p7sxdcO6Rc6Ch0t72rI1TR4Olk1v4kD+lhuXfG57byY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmjSqptqLawNtZ3KFl93Vg9HGrtdMgp1clLaDmI
 ggdZz5L/y6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZo0qqQAKCRARpy6gFHHX
 cvchD/9u1C/7sOWPpEFPIWSU47hw8fqylcNbzW48GZ1PPgd6zdXW6MOyPKZiLHIhNujuq6PyJRr
 Kw2YeVDc+C48VdJn/XRRL2De6Ni2R7WnWlG9/C441IbjsXGfsL4XfVXb0RAbv85UStOXJweUjmV
 WyoGVPg+oCnC+qrDLWWxtzL5YHA4tj3+BhlUXn+hpUr9LHDb/XfYJjV5U+YmlP8RBUJPF6vg14r
 woJd+Co7+g6+9CgNprJJRrflgrKbEMZs792shJ3UXHZjpIXBNY/JU/bJx7h4O4ae5I9535ODf5H
 6Xd1JkQdXN5tH9uLxMqFcKAyaLH9g9XFXrhp+EdNFP8OnlI+npOFb9J1x3Lw+tjlhIaewS2jUcR
 ZhgZZSp9haY+nUYKut1d0xF4nJPGzc/+rUP3k4vLG97hfmvFdgkgEE0VhGY1HOyEyDKzw+I9Dxn
 3vswdeSkCpbSIDfnewR/imEUvPlZq25AmWT3hh3eHsM+iFis7yCJQrvGu5Nuc5tVVpGTDrfwHo1
 uxIaiHufadMH5OsdvrNCzE/Hd7hSQM+ZqScRNv5k4ZPQYaCI6sME+1YEaBdptKn8cjQ5yKIEGaG
 cUmTwK/QWgZmlUxVHnIB5Nt70Bt2/LQ8ZJPDAYqxCJ3r2zHPKKAE9JMZAiniNdgkTw2XTyxpEzy
 ys03t6mqdm93JHg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that all three branches of the switch end up doing the same thing,
we can move the call to hci_uart_register_device() past it and unify the
error message.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ace920261aa4..9d2b50c8fc93 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2396,12 +2396,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			dev_err(&serdev->dev, "failed to acquire clk\n");
 			return PTR_ERR(qcadev->susclk);
 		}
-
-		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-		if (err) {
-			BT_ERR("wcn3990 serdev registration failed");
-			return err;
-		}
 		break;
 
 	case QCA_QCA6390:
@@ -2409,12 +2403,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 							   "bluetooth");
 		if (IS_ERR(qcadev->bt_power->pwrseq))
 			return PTR_ERR(qcadev->bt_power->pwrseq);
-
-		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-		if (err) {
-			BT_ERR("qca6390 serdev registration failed");
-			return err;
-		}
 		break;
 
 	default:
@@ -2447,11 +2435,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (err)
 			return err;
 
-		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-		if (err) {
-			BT_ERR("Rome serdev registration failed");
-			return err;
-		}
+	}
+	
+	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+	if (err) {
+		BT_ERR("serdev registration failed");
+		return err;
 	}
 
 	hdev = qcadev->serdev_hu.hdev;

-- 
2.43.0


