Return-Path: <linux-kernel+bounces-221124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8448C90EF38
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D091C22A24
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C56114EC42;
	Wed, 19 Jun 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hj0y7WIj"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7614E2D7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804527; cv=none; b=pcOid1xk27zAk2F7BQlkqRrwiZp1l+Zvdqeu83QRpcQyrZHFQA+8G/29C/CoHqgOBygt81I/uVMoWNX468ClQbQfnoyr3kGvrWjYta+9pAMp5iBXgSdQ1Um/CGlA/giqNz/HVUF2fYzdGt7t5xUcem+1afU6jr6fOagIN8KKI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804527; c=relaxed/simple;
	bh=rgiEYLNQb3RpLZpQYuT7fM30aAaSLPjiSg2mR2Q0qdU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ei/L4W52TUBr+mTnDPxhu5iq7dWSfmgEdQfDTOQKjRHe6K8GUK9eqtqTm+sWJuPrpYGL/UBpt1snryQ3HS6/k1cVLCYFrVA0BQaC6KyDC6bG/JyKX0+AxkvbQtRPRoYK9aY21Jr3FhO7YmhifiZ9xc2B4tB14tWx23d+1NuEGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hj0y7WIj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42138eadf64so53459635e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718804524; x=1719409324; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7go2tHNRxtX3hgSDycL9uJw0C/nuPgmVzfI4zryzEA=;
        b=hj0y7WIjBL6+bm4bKfhXM6ty1dItGe3hRwEy8yviOrfawVevSvOI0luzB+Xb38Ja2V
         taKIg8MB4WlXwMw+eKffcm5UNVr6lRaMJpPBmBJTYuBAiey4jzDhgpKap/jBYbkH6YjR
         rfKlzbj0QPm1/Q0jCvkHI3Z3EFVM0FKiW6LE1UBSlLnA75V9VCgiKvxscbYBpsr64meI
         +QATvoqokHCLf+jPK0W8bx5wv2ykLy5IMNDpY44BKGkSQR3tHNae09OR8dKJCLZKSiWg
         FDRjCcK9NxblQSzfqnL9bik02SSaJwgM3ELBEbSnA52bBK7fGMoKmHtDm6ObkjBX4axW
         K1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718804524; x=1719409324;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7go2tHNRxtX3hgSDycL9uJw0C/nuPgmVzfI4zryzEA=;
        b=Z5LaCYhBL3sUqeGh0P+63bUGxK0YbJwsZtgM1qLwbOqF0szN7JW+uVN2C/wRPeHm78
         pOB5pNZ2efGadCHSLQEKUrGDPAV90oDQQzgDjlYELm6ZXLeuFXkrk0Q6ivAJsZO8fG92
         n/YC7hnb+N7vw5HXQKuGBOp4cjUCxjkgoDezqWMYylGOjnKeAzN2BZ1/oC82i0GsltSQ
         DQoDjrdX8HyGKIg7m88kchdES2ThgvstoXgZKRCeE0LW7VK9ULpGk8a9WvmaHEhZpXtX
         2+ODZ3T9ye9YiUyalftOUygkUDaEgmU+vj3LSCRd4MBVFx1z2ExMhIMLRzT0Q2++wSLi
         6ikg==
X-Forwarded-Encrypted: i=1; AJvYcCX3HDfXuO2zjMgA48kZOAuTz+aSnVEoJXtGQ4yQP/un+YEe8sgzWfXcsXV6/Etx0QEVY5CVMoE6eQlneRzH3LgqxXIBZ8JqXtA712LX
X-Gm-Message-State: AOJu0YxfeSP4uxXOpnHCeqvPjSmJh998O93TaXtDrEwRQSRfGbW+Ke3C
	8rG3NJi/psEmQDQC98p1nsCTAMXs0vEhwIvg+u16vaGGDbFwHRew48AQyHGDnklL50mgc1GcCgC
	cXYo=
X-Google-Smtp-Source: AGHT+IGEJY74VeA/iUAaIflTiACCdqFcTGgnATrpx3F86GZfFf5/C8nUkxOe22alnDGyRaQQxhM5bw==
X-Received: by 2002:a7b:c3cc:0:b0:422:7d95:b815 with SMTP id 5b1f17b1804b1-42475293d79mr20545735e9.27.1718804524163;
        Wed, 19 Jun 2024 06:42:04 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229c60f758sm251639505e9.20.2024.06.19.06.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:42:03 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] ASoC: codecs: lpass-wsa: fix vi capture setup
Date: Wed, 19 Jun 2024 14:41:59 +0100
Message-Id: <20240619-lpass-wsa-vi-v2-0-7aff3f97a490@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACfgcmYC/x2NQQqDQAwAvyI5N7DGItivFA9ZjTVQomysCuLfX
 XschmEOcEkqDq/igCSruk6WgR4FdCPbR1D7zECBnqEuG/zO7I6bM66KoarqgcrQUBTISWQXjIm
 tG+/Ip5/1aLIvt5yTDLr/X+/2PC/kWKvBewAAAA==
To: Banajit Goswami <bgoswami@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Manikantan R <quic_manrav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=688;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=rgiEYLNQb3RpLZpQYuT7fM30aAaSLPjiSg2mR2Q0qdU=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmcuArq9LaU4lDY1TIcq5GY+jXvwF5YzEAMvgpe
 bbm0K09BZqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZnLgKwAKCRB6of1ZxzRV
 NySZB/9Kw+4BhXGebevZTGw4wsBxspq/E3A0lEhk3nUEqZvzMdPTOUMjnR9DuJA7U3BFcIUeWop
 nckdsW4X21/tsrAxwFA+A5C39AJaLSiOUXttuPzFgguxCSUmmH/kFE9NCEEmIoQ2gnmHVJqN1py
 9nH2Bt7srdHximNA/isi13m5AZABHOB356Rg+CM/zowkFUzosKyVzVFkCun/Q++lSJjJIdh5l34
 NWV5095lkn7+aApmunvisqxuvMIDqPHjG1xIhEQfpnW5tuOm2RqwY0XigpXRj7FOpQlAcIeJYkM
 QUrW6oW62lmaYVjDHPiyLXoL07ZplToay30NJZqjTHy7afXD
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

This two patches fixes issues with VI capture rate and path setup.

Changes since v1:
- added missing break statements in switch case.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Srinivas Kandagatla (2):
      ASoC: codecs:lpass-wsa-macro: Fix vi feedback rate
      ASoC: codecs:lpass-wsa-macro: Fix logic of enabling vi channels

 sound/soc/codecs/lpass-wsa-macro.c | 103 ++++++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 23 deletions(-)
---
base-commit: 8aae76179d6b4587368d50614e114b391cf33ec9
change-id: 20240619-lpass-wsa-vi-0336f21092be

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


