Return-Path: <linux-kernel+bounces-263357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E793D4D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5981C232C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1921F95A;
	Fri, 26 Jul 2024 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIu6kCSi"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F71CD16
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003067; cv=none; b=p+cNclxS5ksMQelM0WSqSVAF1cbtQjpU0nQqvUxYaXCAQujj9Pj6QIQdNhxyHppIorroeGNNYFHPEVEnMUbrXIkPVaQ4CNFZWAHM8XA4QjAEikD0QZDHHrKbdCSnfXIlWwG6hOvQSDt35PEFSoHltVBGgcdYow67uID+E0zThHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003067; c=relaxed/simple;
	bh=Vu+vQdTFKWsQq9i9w0o9ZFa+ZQrVAJEgITfkg5lDM4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUtWxWyNEA80nQ0oxWK4p56jE7RgXF0hm1a1FMbOguZEZjCY4/4vonPUDK32OTAR+AbILVvFBWiL3KvahlzaaJyRICIkRYlb8Ic1eW0UCpEkRGosgKDFr/tmrFPc1Vo4xP5KxA5sWGgkljPTzwjDhnKP5VxZT1or1aDi6LXgng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gIu6kCSi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso16222425e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722003064; x=1722607864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnPQ2n6JhiYWWn9VeOeK/rEp99NPC+ELvUYPMv+J6Iw=;
        b=gIu6kCSiQ2jaCwqted0ryUzMZMm0U0QUedqdo5D/x9S4EhAmFFCjtkn+MhIIXIMeGS
         nEJagepm/TsRISe0VEvpeAnXxvGB2GeAr4UuzvzG5YfcRArnvJ6ascGHBsd2ZXVIul2d
         FE1A9Yyg44UkiVPtAeGJJ0Rcoko3nrnkWgZbQCtq8qTpaEFoQTYN08QuxH/BlgeaiE0L
         xstesxH/XJ1p40dN4eDZZHyzHg8HvSFxHF9c6pXtVgl8f9jFEgPMrk5d6qwfeIRRIdnc
         uIyhhV3x5m5iIclrVQ+H69blbXQqn7O7ZtXXVGA6WO36w36N70PE/aQ8gXl8Hy3RokCe
         0Qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003064; x=1722607864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnPQ2n6JhiYWWn9VeOeK/rEp99NPC+ELvUYPMv+J6Iw=;
        b=oGvqQWGBH88E5C4CsUzQkvyMB6w6i/OPhAazGA7NmILaTEJaNbwnR2ZHJ10g8N9ygo
         c3VpqR8v8Jx3hpXNsgPfX6RtSnlc2JxZdLLtVuro3j15JdZkVf09WJTBYYh+yqMp94mi
         jK1IJ9r1UgfYkFcIoAwNuA3iMy9WYNm4BSPeUkHt78QUSnmrtVVR0IUa0vT+T7//RQ19
         PK6mZtD+hJcVVDimRrBBudTaNNCsdZpJ8ZaIHvzvZN7qFtX6gkKTtQGcCngIPB7DrVcw
         JY3lKO+sBl1ybd6wMLhBQaf0ZZ5aYgLEyUoC60POj1JS+Q5M0AzQHivGPOLlbCHZOzn+
         6NAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXncRrQHRzoAIstMLG9I1nEqid5OL4KQ6D232zCPasiwaUKG2UlWPLjUCmMnBLMKIYIW2qNUKI7HM9drOV0JsFfjdAGjbtz2UT5Jfd+
X-Gm-Message-State: AOJu0YzoWdj6mBy3P8kKXNeJISrTDDFDFHZDTe79gbPnZOKbeNmMs3Tp
	ZoewUrFPWOIR+W88RePx4UefP3+k3j//ooF6GLlsK0ARk1Zu/HM7DtC5rzVcDkY26cGiaza5T+X
	5
X-Google-Smtp-Source: AGHT+IFEX4rzg7NrNx6gbQi2pw9HHCL43584sSMR3P82rbrDcYIFr+PaqQ5QJ29wTGiIy5vcKmx21g==
X-Received: by 2002:a05:600c:4712:b0:426:58cb:8ca3 with SMTP id 5b1f17b1804b1-428057104eamr39404725e9.21.1722003063990;
        Fri, 26 Jul 2024 07:11:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f941352asm120841115e9.41.2024.07.26.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:11:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jul 2024 16:10:45 +0200
Subject: [PATCH 5/6] ASoC: codecs: wsa883x: Correct Soundwire ports mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-5-d4d7a8b56f05@linaro.org>
References: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org>
In-Reply-To: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Mohammad Rafi Shaik <quic_mohs@quicinc.com>, 
 Prasad Kumpatla <quic_pkumpatl@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Vu+vQdTFKWsQq9i9w0o9ZFa+ZQrVAJEgITfkg5lDM4Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmo65sdY4HV/1FoN5HkK5c6lQNXwdRdwBIMLNys
 QrDcxPsPziJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZqOubAAKCRDBN2bmhouD
 1zCID/4viT8zslptT+J+Wyj3J9niHRv30fzKO8dyhhocsvtCsFJ42+NDmGPkTmHOOub3SxgLP9p
 CVa180tqGAVdwWlFCbFSGFPYzMsITwNnSS60fIwtqBcEbCToxyMQf8OwPX+nSeyzUUiU6iYYzqU
 FWcLRTupCcUfpDXsMPS5BKsnQFpjrnem3hTIMFgofs+kPHsElcmNMaGzrgoMiyQ/kQSy2DFI95U
 JD2yXtUfnhAQbof1PmfMA8g0rl2Z1jin2Xj6GqYUHvjT1ULI6VUs+5DL8VI5fsx3cz1V47XSKok
 wtUly+RB3YL630VU4tfMS6acALC/0bOv64GLuXLgGcdftot+Bueb69WzVF7Y1CdAv8YpL4+7+tJ
 QWGM41WCQVRW24EvCoOWPDLybVAQPUqUG4NYsFY2uokPc5QeB/w/hAprlCgIggY/YMsYj699004
 X12s2MmtS7wnEiiV2o4X7qdb3LxvRXdHRw4Vh0kmlxSL1IHljB2JVRN0icjSa1NLBoeYtZsrycU
 NmiutNzyT0q7S4++eUxqmN+Xw/q5D7Wck+1cHxXWxtnI4Y8k+w02fykXMRsVWtqe58SU4MqZU9t
 xE8/kWlSaXC9a7CDDVpvLXaWXjaeJbp87KFkyy0tLZvi8HeVs8HrNAz6medqWhwmgRAXUUeX0Ws
 WxDpoYEDH8Zyauw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device has up to WSA883X_MAX_SWR_PORTS number of ports and the array
assigned to prop.sink_dpn_prop has 0..WSA883X_MAX_SWR_PORTS-1 elements.
On the other hand, GENMASK(high, low) creates an inclusive mask between
<high, low>, so we need the mask from 0 up to WSA883X_MAX_SWR_PORTS-1.

Theoretically, too wide mask could cause an out of bounds read in
sdw_get_slave_dpn_prop() in stream.c, however only in the case of buggy
driver, e.g. adding incorrect number of ports via
sdw_stream_add_slave().

Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not adding Cc-stable because I don't think the issue can lead to real
out-of-bounds read.
---
 sound/soc/codecs/wsa883x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index d0ab4e2290b6..3e4fdaa3f44f 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1406,7 +1406,7 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 					WSA883X_MAX_SWR_PORTS))
 		dev_dbg(dev, "Static Port mapping not specified\n");
 
-	pdev->prop.sink_ports = GENMASK(WSA883X_MAX_SWR_PORTS, 0);
+	pdev->prop.sink_ports = GENMASK(WSA883X_MAX_SWR_PORTS - 1, 0);
 	pdev->prop.simple_clk_stop_capable = true;
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;

-- 
2.43.0


