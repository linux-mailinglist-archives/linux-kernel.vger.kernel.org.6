Return-Path: <linux-kernel+bounces-320261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B20697081D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412B71F21E47
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE2A171658;
	Sun,  8 Sep 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjbuDHUQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE4170A0B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805312; cv=none; b=LiPltn2wpjh++OXQSQ+wc0MmQBIZFu+1Wk+MuoIcuCJtbOzmVoabnChA6y8nNyl2wHAnirmrsEYkX82Or4/U0WlCcmhA1XdGHsprrZDp7ntUsPwWsOE4IDNRLVdenC7TX+9cEFmxNkVL7UyCAIf8IRwrl0OH/79RWzXlEb/0wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805312; c=relaxed/simple;
	bh=xt0kZ7eoXJhJeMpnCj+RSo+GXDsYwuHZwovewC7CyRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ar7eDY6YvP6YhhkMlJwJtUZtvK0W1NFpuE+y7+0er0dYtXbOfaniU7cg9/QY7No3r+uhpizCoW2JrKixU56SeF9IiPEZcIzVUMb93KJxevi1U4B2yuiW3fVlJxb/Kq3fT5WoFcY+xi2YPZ6N+jnwyl+jMbuIoXe7HyxIdGTdo50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pjbuDHUQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb6eebfa1so283825e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725805309; x=1726410109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmNCAE4Q1YMX3Tcl8gMK7BYQKsWpwsEcc2NsJh2xrh4=;
        b=pjbuDHUQQ2ZTE4eQeAku7G5CFaylDPKSZ+Gl0139EOIXFOpoBho9kc06hKcNGiKR84
         sKNhISlJ106EUYceWTuDz6jP+5COiCHNAI9P4Kk9B/EyDg+wuEo1Y2XdSQA5O/A1eryp
         16L+Fp5n+iQ7gHoYBIaG6P0NUr4FzLCyG4IC5LyscB2qWVmuuFgt7JFuixQbKPWjDfKa
         rgXsaVDi8OJQ8yQGux7c+S8BZ80pastvFelReajEjaw9aIXc63rpCJQ4E+kBMUDu8oZW
         gez/9Mgisac3Om9MSeT4vkAoz+4hDp5Bih9N/Yi1zQsl/4Cza4x0M7ML4/qY2mVMnpKw
         9yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725805309; x=1726410109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmNCAE4Q1YMX3Tcl8gMK7BYQKsWpwsEcc2NsJh2xrh4=;
        b=DcHKkm4iJUKyRPSX7hawaHF816oTpX4h2YbJY29z7zOawJTRXFzmfCIN9xmNvD/kJ/
         Zp3aUl9Z/ND1zv3wcJVXYD7fyr+cJZs7m0Ep+18iqcUkllggzvZ3lNbCj4FPTg2NvtHB
         sWFUdAQWRiuwfHlcNCrMSEyw5laVOffs6awPrH36rM3EjBcyhksgvzcdfspEdSj0Jlyr
         TAlC0rGQjdNKgEg0BSIC4Qu1aGwkHVrxaBXQMWEPLkYg/CJJZZ91XZik7gmTDrsRZLI9
         8PhfJo0N8pOVqZyTMDTquFZiDRiNDL7KiK7/EXJcs/49KdUyiQSrKQogKsKbh50ongYs
         dpTg==
X-Forwarded-Encrypted: i=1; AJvYcCVfk6nFaPlQpRR3yPJPl2RJSKqr9N+y++HgRncEili/pjE0oh7D/6EOkLSiJ6OYB2K/2UCM37b/1i+4Sy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv8PeEYsOg8WvT687uPfz105kpBJkoSUWoVC/HKkf3tXJ9KS8M
	4bk5XcO1+dIzfbxZHcGR9RiIUXTpmRxaW5IRqzIFyPCfMhmNIhSP+KQjrnBeohw=
X-Google-Smtp-Source: AGHT+IEfPYmeZxoWXAcFQnFIynwYI3IhFwp318lmX0rGJhOu4zCB8JiThVgRlAkTPUtEGTM66TbBWA==
X-Received: by 2002:a5d:5985:0:b0:374:c4c9:d501 with SMTP id ffacd0b85a97d-3788969f8famr2540273f8f.10.1725805308342;
        Sun, 08 Sep 2024 07:21:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675bc9sm3465092f8f.56.2024.09.08.07.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:21:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 08 Sep 2024 16:21:31 +0200
Subject: [PATCH 1/5] drm/meson: drop unused staitc dw_hdmi_dwc_write_bits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240908-regmap-config-const-v1-1-28f349004811@linaro.org>
References: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
In-Reply-To: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=xt0kZ7eoXJhJeMpnCj+RSo+GXDsYwuHZwovewC7CyRM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3bLzifbiOLGTfi1rakImHboSKV6MijiY+nxNL
 64lIGN8Vw2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt2y8wAKCRDBN2bmhouD
 1z1VD/wOZ9MQKyB3Sw1CKjUwzx//foRb4DryywNPfnPq4l8A3dIm616OmVccvSkkz53RxzHsiSo
 Dw7eEnEx2HVoW7kyWifS/sxsqjS+ZJNu6o96aJZNPknaYTjCGqvsm31f+pa4nEJrbh5K6FiC34M
 jDlUbCSrH2rdiUg9gB8kqAX+93smcGE7+Z10Q8e+v7U3AOr+RRMuFrcAjN+fbvV85gIg4iU+3y/
 k+l+eWOMcpnaAdQPcSnMx/vgGKSJuJHpQO91fE04UmJyzAwR5F8QgYSVcKByRExvYTirjmiDD4k
 13HJUKlryiBKlnP/3dtY3lA1eJaLwhaBnMLGwWxL4msNZF3martYB6dBVDA5Q6erhi9JEytv3Ub
 Ck26TT6lop4XdFmACe9z7xCNOvZ2yBRaE6MEG6PRcBvu8mpDivvO5qgntKo9mxltoomeo1GYOCm
 6R1wWzMkLJdMhIqe7eamaJo2hVQ3ukJeC4co9VFodFrMVzTdfFqbMDmRQPgymuj/NrGyOszj9Wu
 BDuPkwp9WiHXiWR3TA7WFsOBTacW5opg8ZN4omiWyDM0FzJRydwvB1jYYMEcdoNasl/DdhxVwW1
 S+JC3i1S3tCLgePg2qs5HvIsCsX0OC1eAphTQ96Axhrg6L20JVzHESqtRnLYOmerln9EJal3X6C
 SIMxC/TjklYx1pQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

static inline dw_hdmi_dwc_write_bits() function is not used at all:

  drivers/gpu/drm/meson/meson_dw_hdmi.c:276:20: error: unused function 'dw_hdmi_dwc_write_bits' [-Werror,-Wunused-function]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 5565f7777529..b75db829b1da 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -272,20 +272,6 @@ static inline void dw_hdmi_g12a_dwc_write(struct meson_dw_hdmi *dw_hdmi,
 	writeb(data, dw_hdmi->hdmitx + addr);
 }
 
-/* Helper to change specific bits in controller registers */
-static inline void dw_hdmi_dwc_write_bits(struct meson_dw_hdmi *dw_hdmi,
-					  unsigned int addr,
-					  unsigned int mask,
-					  unsigned int val)
-{
-	unsigned int data = dw_hdmi->data->dwc_read(dw_hdmi, addr);
-
-	data &= ~mask;
-	data |= val;
-
-	dw_hdmi->data->dwc_write(dw_hdmi, addr, data);
-}
-
 /* Bridge */
 
 /* Setup PHY bandwidth modes */

-- 
2.43.0


