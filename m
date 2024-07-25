Return-Path: <linux-kernel+bounces-262099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F2793C0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3DC2829CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0E19AA40;
	Thu, 25 Jul 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbpkpJTX"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D779199EB7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906645; cv=none; b=lrzUAWijSnNhaCn3g2jdjVAN4oqg3gAM9igKxZA+KPRteFRsbNMO8vJivtFIEx5yfGnlNHW3H5st4tJmNGXmvHP3uODLswYxwwXWoNdIdxGfa1AXE+z0cGtFvXcyZSj+pyYqYYKGma7uNXu+yoFnghIuKI3d26klb75VDN2qwtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906645; c=relaxed/simple;
	bh=Z4sl3UsaDoDW0qIaCARjl/i/ur/SZTyjyXlvlMhISio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pb/HgsEzRw1YGiS6be/DG3On4kgOxvYEVusVWYS1kSjLxCkl/SRxxevoLP182klHWKQHiGg+P8rKnv/fEwvjfIrzXCe788lWSsi1dyqMfwuUjIq54crk1ilbwk9m0RgOW7zE5pKQaoUopy7kNMKTDZMakkIQaZt4i00STX1Wh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbpkpJTX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3687fd09251so473647f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721906642; x=1722511442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8qPNmhqMV5uO1WWAeGcfg+Xje+HVJGnsDnxifCQEj4=;
        b=JbpkpJTXWan/nRQjHIHFXYwexKFJsDxsrWCurkJkD8EDtRkpUJ2AEbFiPvyzRKgaFp
         snoMjDsDnv9TDBmygSifP46Q5Y5zGz7ZQHr6Ilsp2fUNgBezCYVvzoo5SG8kcyu6by3/
         OpcQzmIQfVJjtHLWvFQSHBVZZb5gOeJlynfqg9GBZqBcqSZ0ciPmvTMWqBDy7jY5tN27
         eMfuI+fyVk9uAwe3ppZFN+P66X7DiqwrxTwBX+CskkeLzSQ5P1/aiZL5AA2NktgYJJ0F
         zs8P0TTgb+4CC6KL+k1ZGIIKl5I4vBZnR7x5fL7AoRj1e2oGZvmjN5HLewcGVL9Y4s9L
         uCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906642; x=1722511442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8qPNmhqMV5uO1WWAeGcfg+Xje+HVJGnsDnxifCQEj4=;
        b=eotB8BmWEA65OAl+rVuASO+6ydJtJ3o+9Y1fysddWg7DKh8u9jHhlF2VdIvGRk2PbX
         gU4+XbBcHzWSLMVthZ5iYR1k5n0GgmPN7enuukjxrexlv6BhCJu0AMVkkxc6ycTfCQfA
         0lXoN1uYEn29Cwzl7v2eEBf/L2dQTXnb0ZiAI7z1o0Ipy9arWvaibVMyNdxMSbn3kE1s
         AEiB4eXIa6wE9RfTHFTIDPj0owyl4OUjvokKttjSdKGll4Yo8v+jIo44EfXjGRVu9UyC
         3XSmCObFtzIREd069MiQ2hz5Qj1FmyabyNDt9R6iCTbF9IXEOH+o6MqJP5jtEFefF7BN
         P/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCULdgw9KYbtRpdgSm2G5hVLd4i/0jA3HLmbyIsqSTCzQpZOtDw9yMkJiPPhsikKZXmuow8/PUw3YbEx7O3fTYgHX/+QbLXq+/MAYmWZ
X-Gm-Message-State: AOJu0YyfTxsWijPWiEbspvOBQROlAGfFkKlfo1jlYKqN/ca5TN7yEgE4
	916wTOAFpu7rpXlSNWnvrIvdG2mauUJxbofIhkMKm5VZLFE3sT8jtaWBjNfhZdY=
X-Google-Smtp-Source: AGHT+IFHswFHg9qmycJf/sCn7iOfKPi40kcr6NaDof8fg3mdrjY/DuoYO/J2eafkoWqxIU+1HxAapA==
X-Received: by 2002:a5d:5491:0:b0:367:94a7:12c8 with SMTP id ffacd0b85a97d-36b3637efaemr1166676f8f.6.1721906642614;
        Thu, 25 Jul 2024 04:24:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e072asm1823607f8f.42.2024.07.25.04.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 04:24:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Jul 2024 13:23:48 +0200
Subject: [PATCH 6/7] ASoC: codecs: wcd938x: Move max port number defines to
 enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-asoc-wsa88xx-port-arrays-v1-6-80a03f440c72@linaro.org>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Z4sl3UsaDoDW0qIaCARjl/i/ur/SZTyjyXlvlMhISio=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmojXHFok6viGl1t4tqCGW8JGde7k+DNzVVWwgU
 3NqGUpxprCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZqI1xwAKCRDBN2bmhouD
 1wdtD/9b3CBdXYwVtROD9UQpPesni0OskgB0SQJW7DEily9DHVNcaKvnwyguS7HHt6uoRedT09y
 0w2vb7l1TxEms5pi1ntoFI05ZHtU12m23kxLITMfYOFshfCL/4rz38IFgstCyWEJOY7qvecqC0m
 bPMv0eynywhZdWD/kn6z+IzdtRfUmxVL6ann7pvf+ELOmn5xl2Dui4YwAFzIPwhwV4M8G96MLj7
 NF3cvmIbE1tNr2eJbGIlJV8aZJkcV9eaGVFwUdeHxQ1kQMGhmvlbbzGJfgCHCiZfi3tf4XDECPe
 BGP+VhExGXM7DzhrMlHG3cg7H6dE8lrg4222cgvDiE7r5QwO2MTKVpwW2H4h+2Es5yEOafabJ3C
 vcUxFmpkZmfaQIu1O/NpjGyX2Z2NQLmYjDhFJYyL7W6IYVAEajpWoU/QLA+7Gn23WrJH9wfs7IW
 emOew4ct4ILK46h4qCLfGXtIiiGEpHMD9gIig4HvVxiKcTw3ZyrWjA1SNMkV4/igeHVzbj4ycei
 LmOjWh3I9P/QAD7KIsSPg0uEtcJFdiGvWAywG2BtrudfE/SaIivPaiPBq6umH7A9f7Fj1xhidQr
 eBFyBvYxheeshYPAH+/5GIGP8hePYktBgEPoV6nBXuM8rUXCHwoxSztqMZPf8ZKcynUCDLW7tlG
 iMZ7OHWB8i8ZzaQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Instead of having separate define to indicate number of TX and RX
Soundwire ports, move it to the enums defining actual port
indices/values.  This makes it more obvious why such value was chosen as
number of TX/RX ports.
Note: the enums start from 1, thus number of ports equals to the last
vaue in the enum.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index b2ad98026ae2..fb6a0e4ef337 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -585,8 +585,6 @@
 #define WCD938X_DIGITAL_DEM_BYPASS_DATA3        (0x34D8)
 #define WCD938X_MAX_REGISTER			(WCD938X_DIGITAL_DEM_BYPASS_DATA3)
 
-#define WCD938X_MAX_SWR_PORTS	5
-#define WCD938X_MAX_TX_SWR_PORTS 4
 #define WCD938X_MAX_SWR_CH_IDS	15
 
 struct wcd938x_sdw_ch_info {
@@ -606,6 +604,7 @@ enum wcd938x_tx_sdw_ports {
 	/* DMIC0_0, DMIC0_1, DMIC1_0, DMIC1_1 */
 	WCD938X_DMIC_0_3_MBHC_PORT,
 	WCD938X_DMIC_4_7_PORT,
+	WCD938X_MAX_TX_SWR_PORTS = WCD938X_DMIC_4_7_PORT,
 };
 
 enum wcd938x_tx_sdw_channels {
@@ -630,6 +629,7 @@ enum wcd938x_rx_sdw_ports {
 	WCD938X_COMP_PORT,
 	WCD938X_LO_PORT,
 	WCD938X_DSD_PORT,
+	WCD938X_MAX_SWR_PORTS = WCD938X_DSD_PORT,
 };
 
 enum wcd938x_rx_sdw_channels {

-- 
2.43.0


