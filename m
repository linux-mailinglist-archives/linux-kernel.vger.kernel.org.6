Return-Path: <linux-kernel+bounces-245787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 877B292B944
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5933B24616
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADF9166314;
	Tue,  9 Jul 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="c4DzXZ4M"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5F15B968
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720527542; cv=none; b=IvvW9Ri3xKAn+XI2415YvAngqC11ox1o/DqUmcFLAGkurQhpmasJ6J+cbyOv0WBwjKDul6unUIWjaNCjXAZDqo0m/W8uuhFBuXnHsZxFCpVHP8jSk5e/fWSNtsUODSNsiSkXhvYdiHXIybT7S/aDlaz595Jn8zpdXNcxclQM0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720527542; c=relaxed/simple;
	bh=n8IBlhPoA/qgk+fNyg4rQ99SOZqrqxt6zskITPsCtAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SUdImppQI3++N3aRniC8NpVA3HIf1qkzJMoPKAGW6LyBHwQdyv7Q/uuqCVaut5yuVbsFdheAeAPoQqNMpnVb167W5ziYjGWquBFxnrH3wrxlTJALy/HcYbutE+GjW/tOiuhkkkWvKPxJFTFsjstJnxNs1Dj3CFD8pvpshiTrs5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=c4DzXZ4M; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36796aee597so3361245f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720527539; x=1721132339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBgx4nxMez8W2SjWNK7CrGe10S5aZxdnZ2lslTHcnEM=;
        b=c4DzXZ4MAXww+Lcko7MebYNE9Yx6/2kVhpuEVg3PHG1DrXCq1Ae9R/ZAsJi7nh3fGG
         ZZoBscRzi1238IY+yJUpoKqhpjIlIo6roo7Oqp8Fag8YKGbSBJ5a0XAMlgUZ5+HL3jjw
         sfCHcnCcMkxEsp2Mxol8rSgdbutJS2JbCkyJbSLRMlAOKV4fRpYdljeLYlYhP1zXEhPK
         na+iH9TJntJhQtSYpen8AIK4bW1IdgfqPT7r7ZW1904idWsBMYInEbvcikYGSH2ke5Nc
         zp3JK/+bcxA8exgYGovfpQVaI2dod8e0dEhvwLHlGxedyKSo7j2GcMPODMbEgbGS41pb
         4Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720527539; x=1721132339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBgx4nxMez8W2SjWNK7CrGe10S5aZxdnZ2lslTHcnEM=;
        b=gKo3g/NQRqJFDAOZBzTN+NJwGuGNWejKHR4ViQrXDr+70W6QSLWL7piDpqbjfFZpnc
         7M/F+05s+znVl4O4q4199NjdGIlfgO4yRq0wtgY6+jNzq71TmT0RNUWI15Tge3MqdNuj
         DbaTIrCfCi4LZcDCbeEKUwqD4YamExxUtOD9BZ94nTzYsE5BvrQ8qhGO84jmHEeYrRH8
         e1e8gFcc/NUtrj+HJ6W0/BxGEWSFRhq2NLaWmSRDFTrRLf8AL/0Oha/TbhVGCFcSYkJs
         9Wrq6fYj18Z+6KWTB/6QL9/OaAWiZZB5AC1iHHT8+rLsjIE7bVNHDHS5LNoY4dlFxIYu
         3Obg==
X-Forwarded-Encrypted: i=1; AJvYcCW7WzdTMB39T47kMmQZQJi9zq8zBgA/ERTS4eKqZim6F6Z7BBnGaL/jLppz3jWy2uTRlTZPNNFTRVUYF93Mk1zbWdrx6TGMZKllFZIh
X-Gm-Message-State: AOJu0YynhB8lLadbIianRzb7SUcblWmY+irPUraOYJ3lzKeL5Dr1Z8s0
	HF4x1KI6CiJPpATpJMHJzxxv086WtGvyXRI7EdD89zCusItcwWZgnRoZmvuSIq0=
X-Google-Smtp-Source: AGHT+IFnvGSyQk+JwuP1pJ1NJhpsMH0jooyRjnJvbTEQ0UsiMwwndrWdEVaXsrZzWiPykoSpg196CQ==
X-Received: by 2002:a05:6000:178c:b0:366:eadc:6ca4 with SMTP id ffacd0b85a97d-367cea8f92bmr1809396f8f.29.1720527538916;
        Tue, 09 Jul 2024 05:18:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c270:70c:8581:7be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06d3sm2390574f8f.75.2024.07.09.05.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:18:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 09 Jul 2024 14:18:36 +0200
Subject: [PATCH v3 5/6] Bluetooth: hci_qca: use the power sequencer for
 wcn7850 and wcn6855
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-hci_qca_refactor-v3-5-5f48ca001fed@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=aMM3yb5DV2sqwmZi3WupHB7UhA28/Enh8+8N3IKgp+o=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmjSqpN7GRC30B/SHjFyGW5VYELyVeElFf0sklh
 /R0EWxhMSmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZo0qqQAKCRARpy6gFHHX
 cudiEADQlewK0sjcqdn9ajDRDxg8P9BDth8RsMC/BZlWszh3+aXaf4Lwm5RbDrCFWpMxHu0seWr
 1g6ebFYtgySiLKS/qW3XmSHWkvnsmYZ5aB1DI6Tc+26ZvRcax/97E/u53rX71qXmndeNBqSjOhT
 /g5Ks016FHICaaZf0b5Qc9Xe6EyNB21fculjeUOvR0H0UDbal/+Y1TaoKlGk9/g0g5zsfv0bEsv
 Eukc+paFTCvnkizHCnwRccaiQ7u7aez4XIDSggaOiPlB0fpgPEWBss9vgm3XJ/3/jv9O89xQWio
 roOh9Guc4SkSFOfxxD2GUfkwNymsNoYMChCVke0ZFfc/R2GC8aYdoGi173S5aHYqxyo1ADxKUzs
 xbfdyt7c+nQWItlZhXW+mj24l0o7KCBtgzMs13tUhJ8ePfIbZ/aCFZZrql+ikgv4w9k6DRgG7Jo
 wBC0gtdaedHggxCzbplodpYTqhfi3xJOOZGeXZAKQqA8Iq8ZbXjvzDXrySI4pREyI2hLD/CCwqA
 B0taUSyT3QhVGI5PLfVWvx26Y5C44pU1tSF6dxiCpS9YV2Rjoe5Jag0UxSRehUOcjSQXJhoQRas
 DrgJ/klF0OPNk+jPzsqt1ch/L89aAdwg+42Xz81XtAGm15klggSrzszJnB1RHxtIyP70TnfyCKf
 wxvc3L5FGtfy6GA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In preparation for using the power sequencing subsystem on sm8650 boards
and X13s laptop let's make pwrseq the default for wcn7850 and wcn6855.

Both these models require an enable GPIO so we can safely assume that if
the property is not there, then we should try to get the power
sequencer. Due to how the pwrseq lookup works - checking the provider at
run-time - we cannot really do it the other way around as we'd get stuck
forever on -EPROBE_DEFER.

If the relevant OF node does have the 'enable-gpios' property, we
fallback to the existing code for backward compatibility with older DTs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 49588072589e..030153d468bf 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2354,13 +2354,28 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	}
 
 	switch (qcadev->btsoc_type) {
+	case QCA_WCN6855:
+	case QCA_WCN7850:
+		if (!device_property_present(&serdev->dev, "enable-gpios")) {
+			/*
+			 * Backward compatibility with old DT sources. If the
+			 * node doesn't have the 'enable-gpios' property then
+			 * let's use the power sequencer. Otherwise, let's
+			 * drive everything outselves.
+			 */
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
+								   "bluetooth");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+
+			break;
+		}
+		fallthrough;
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
 	case QCA_WCN6750:
-	case QCA_WCN6855:
-	case QCA_WCN7850:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);

-- 
2.43.0


