Return-Path: <linux-kernel+bounces-375537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF6E9A971E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDF1286D21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEE13D509;
	Tue, 22 Oct 2024 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfYxC/IN"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFEE3D994
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567900; cv=none; b=sdHL0EygGsM8v+3e2BVC9xiTGHkZS4WhNNPJN2hlNUK5dNFk28wqH53j2X5JJG3ueqtzFQeyw7KP/AUO07GSLQyDsm3p6aFmymGRNxAZXutzarlyU2w6RLpK55Yt5vPINstdyFfrTL4VP9N9Wk3VPtWid5oPdlkn/JrFOTPvsog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567900; c=relaxed/simple;
	bh=KlYS0u+UdAyAAPyvPaxQwNeaRW79KZNHr8momw/teMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRSwljVjeaMOm5IV1hplefmUvG0MtnJsR6YND1l6WuG7lJUpoS2l1zUhb6ZIiT1aQpjBPHpm9j8/gnVwIFN7NaUH+eJ4CWlsKbBP9gzDLTX8pXP1EJ+ynEt3GdhyH6BSW7ApomKBte6eBEvvRLvm0ReEKsRD04xCXZUklVO3h+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wfYxC/IN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315baec681so52934805e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729567896; x=1730172696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnGrvWyEkfJGt/0DtGtUAuajOGPJlvd3hyTQL/5+oQU=;
        b=wfYxC/INd+q0EidBB+EDUXKxsV7PUfelOAXdiFG0BcMVPWe9sRCkWZtebP7Wryu2hq
         1VUNoCzgyP2fTE6d6CEnbL7K55CCcNvvK+PtPSe+fmUFfRwEtAm/XWWpE1gAZfMWNWch
         fpZGsXrPEyu0QmFmwTbACfSs0amIzYYjD3su9YW1+ndQXv4zX5XX6nCKuN1p9cPGcM90
         rNQ4czF4fag3LRduZ6iLgJBVD1CmnxW+k8y4ulUUDgcTrYQePbNX775uZlR88zi8Y2Ru
         zRvmo5XwtEgLX4cZWrHd1ufh/+T9pYuUB0HI8E1D+a3xZ6ot2nKfgGajG2DqecZyjq7z
         MydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729567896; x=1730172696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnGrvWyEkfJGt/0DtGtUAuajOGPJlvd3hyTQL/5+oQU=;
        b=Hs6aMhBtyKcte5stydd66B+rjKd+RcOfy+LKQHBbMFqjDMgi22fnGvEpfGemFz6OjO
         wbXsCNAeQt3rGMaFiIKrWdUNDanJBKJCCi6MfJj5q0rO5IRoF8iFMnfSoVVcUw/S/C4O
         c8FjishOZweEr2pksLNZk1mQPmUifPiSMxQ8jQIiDyO4ePQ3BAveQERLiBIAXBafRjQd
         KpFheBHKoxtp2520NFAiRmAI/rYeBdYZYHlPT+/AximzeBEGIrSxMHuOap2grU7WxAWI
         v09cjqrPgMGRlKQiC+S654k4w6SIrc1tEgc4c7V+G2v6okX53CRXtrqUUUa/6jcrq3iw
         IEAw==
X-Forwarded-Encrypted: i=1; AJvYcCXi3mU4+d6E8INVCYNvrCntRJM8cNc3N6qjoVL+cQ4LfYtkhr0Cx2Q2kgFyVywLj8XTFDI4BhFkgry7oVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nAXsvF9f5gLznSUkhsPBXb3cyvrGoUcvaoD3QvZcs98+RzzU
	AJOIJdCsZDaTJMnwjwKzNyQd1aLv76Gd2w272hi3G63VtuobhF0p5NBqQeC77w4=
X-Google-Smtp-Source: AGHT+IFuE/kXInfVZsurmtQHN+jwzqaTxF7tmY59sYJo7LsBOCzg3DUkV15bKsOh9KTl27pnowbuhA==
X-Received: by 2002:a05:600c:1c29:b0:431:5df7:b337 with SMTP id 5b1f17b1804b1-4316163b55emr101507355e9.8.1729567896395;
        Mon, 21 Oct 2024 20:31:36 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317d03ea4asm4768455e9.0.2024.10.21.20.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 20:31:36 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: srinivas.kandagatla@linaro.org,
	quic_pkumpatl@quicinc.com,
	a39.skl@gmail.com,
	quic_mohs@quicinc.com
Cc: linux-sound@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] ASoC: codecs: wcd937x: add missing LO Switch control
Date: Tue, 22 Oct 2024 04:31:30 +0100
Message-ID: <20241022033132.787416-2-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022033132.787416-1-alexey.klimov@linaro.org>
References: <20241022033132.787416-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wcd937x supports also AUX input but the control that sets correct
soundwire port for this is missing. This control is required for audio
playback, for instance, on qrb4210 RB2 board as well as on other
SoCs.

Reported-by: Adam Skladowski <a39.skl@gmail.com>
Reported-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Suggested-by: Adam Skladowski <a39.skl@gmail.com>
Suggested-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/codecs/wcd937x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 45f32d281908..0f0d2537d322 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2049,6 +2049,8 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
 		       wcd937x_get_swr_port, wcd937x_set_swr_port),
 	SOC_SINGLE_EXT("HPHR Switch", WCD937X_HPH_R, 0, 1, 0,
 		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("LO Switch", WCD937X_LO, 0, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
 
 	SOC_SINGLE_EXT("ADC1 Switch", WCD937X_ADC1, 1, 1, 0,
 		       wcd937x_get_swr_port, wcd937x_set_swr_port),
-- 
2.45.2


