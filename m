Return-Path: <linux-kernel+bounces-448090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8C9F3AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0945816C64F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9748B1D5AD3;
	Mon, 16 Dec 2024 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cJBRdOaw"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DFF1D5147
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381474; cv=none; b=LQTimGDDQDAobtr3P8yZmsPuRN32HLB+7CQNhma8Jmnd4HJezBLqbZZoCy8k4+MPoiF6RQSdam9YCflvo50gnFqc8cBiG6sB2jxsmve0gohUbaBFLZjMCI6y99zFDH0xxICj+1LAWeRuWg2BBPwC3I6GXnZLW+XaW/onmZStSPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381474; c=relaxed/simple;
	bh=+lZHZ4OM8rTY/dhezSlahZGVnk6ol0FvguLhf0YmUqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vh6RFSgPyXWwaUzGyeihh2Phy2V1OFxfdvOIW9Y2DQMzc8yiSHmWy+7PYRpMacIoHoVP8FI5gM2oiWGj914iXYhnuckqTFVwFtkJFK3TMCjnMeOi3bx5AtX8rz3ivbSLeYZapqQxvUZ6WRdSK84AMSmKJvNqZt6gImSWYQyW+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cJBRdOaw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38634c35129so3568228f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381471; x=1734986271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfrMkIY9tbM1sPwHCNYu/jKLHOMpHgwU9OMNQ7g5My0=;
        b=cJBRdOawEkOW40eACpx42wbMrSVUoqbwIGoTmQkGn5wEPVc5K1P1BdsyIbURYgQRvS
         hh/rB6IA9YGN7ouwRmQO+s2M9ifO3Cd8S7+vm0SygSqz+MPqIGQOj0YXqB+UPVpLTpab
         r5UWjw9x3eOHpiQ3pyvOaIQjNNb1QleehpbQKxv1msu57g/sEXe5lya/qmPXfrzTPxVO
         S1vuAW9hcx1qhNsnzNud0oMeUmmluX3/kWrtGooJnCN6cZK//yq2pLq2WJvqg0tK2fUF
         zq0WsUzBAnUcpC+mc8JkqaA2UgpoxhSHNk+ku2Aao24rqHLde9sn7SpVimOdLsGNIPtb
         wfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381471; x=1734986271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfrMkIY9tbM1sPwHCNYu/jKLHOMpHgwU9OMNQ7g5My0=;
        b=PxYmg49pzevb8annZ2yyApfLcktEJ0aUj29WUKmQgVtTehX0k+M3hrqskPn5CTRaMk
         8XOrS+DurwgAi1Huc3uZfw8M1fQtjZuG0MXWmlv2o8Pi1QhODilfTUiYubikbLNt0y4j
         DhuIRi9w3LCmt07XoItXPUc3f2hQp+/vnAPve6FlC+E/rSARYdE+1n+n3rLGVKwVZY4S
         YXGAidONptdv3wec063CuJXHm+iMevp40CRZrIV52QZtu3rS3c0wQeoCq+lSH+3OIshC
         JJrCZqnLKW2PAi42BogXcg6rFsCqpynr1vfoJxQ8pTGpMZQpjBJFcnL+jqtcVZu1CVKV
         1+6A==
X-Forwarded-Encrypted: i=1; AJvYcCUBu1D6V32MoN+AC1rVGpRtXpfPYKIMsyUYq3758wGBdCW6MAdEk+vJcgreGHv6g9nGfcZUEbt951UhdzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72As6f0zFkdeLCkzl2E2zQwWz6qwTnK35GtymFD0F48zajBzB
	o37rg0J0UCVmvvJYXvvfAq89tIUChglrHK8EyIpPnBq7IfuZ6IQ1iF4zHK+gelk=
X-Gm-Gg: ASbGncs63+78qegAnyhy9g/6YJ4P6rl+qWkqDpwM6fQbjNoNUtkpNXHce+Hk3VoVcR7
	VHZlC+/9zxlJphI1gA/gKiX1XVUhl4DVpjOk7ZhP0dWI5ezTHVXRZfmafLv/iEfMecySVweMate
	07YaY8YBHUq1FOLf/u43TKuhO+9j1Im/HabL1/QuxTPimxE+ZyOr2RONSXbYJwdt/n+xjytf9sV
	9LuMMVI7WGVWNHXtE5f2lgBxbs3WcRsY+UAz/6qCh5Hb/puPiPZnRkhyIlgZAdbjhpLqisWKhPc
	PKXr3MBXEwsv6bLtqtPftYvkE2bim0sTOg==
X-Google-Smtp-Source: AGHT+IEoJVL8cN2aUSGgeveVOviRfZY6zn17RiTNDc/doqRdW4vCiAiD453Ku2lgjqBBhDniZ5kaaw==
X-Received: by 2002:a05:6000:1acf:b0:385:f0dc:c9f4 with SMTP id ffacd0b85a97d-38880acd9dfmr12653328f8f.20.1734381470841;
        Mon, 16 Dec 2024 12:37:50 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:50 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:23 +0100
Subject: [PATCH 3/8] iio: dac: adi-axi-dac: modify stream enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-3-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Change suggested from the AXI HDL team, modify the function
axi_dac_data_stream_enable() to check for interface busy, to avoid
possible issues when starting the stream.

Fixes: e61d7178429a ("iio: dac: adi-axi-dac: extend features")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index b143f7ed6847..d02eb535b648 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -585,6 +585,17 @@ static int axi_dac_ddr_disable(struct iio_backend *back)
 static int axi_dac_data_stream_enable(struct iio_backend *back)
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ret, val;
+
+	ret = regmap_read_poll_timeout(st->regmap,
+				AXI_DAC_UI_STATUS_REG, val,
+				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == 0,
+				10, 100 * KILO);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(st->dev, "AXI read timeout\n");
+		return ret;
+	}
 
 	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
 			       AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);

-- 
2.47.0


