Return-Path: <linux-kernel+bounces-247269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD992CD51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C931F246C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F612EBD3;
	Wed, 10 Jul 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3lrIdmP"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F512C491
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601066; cv=none; b=eC3YP51Be0LrnbtbsPd/uM8FZ+Xpw2miUqKrh40RFEQeAbNtaw48rIUGk27pIgX+sjywAkiRNiu44kN3Q8G5vFyshrg3dLCvAqi6BygaV30pweAkA8X075Ihcj2NPVsjdYM/GS97wAjw2ZG3gM7EzdcK/RMDr+UiwoRtzH2awPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601066; c=relaxed/simple;
	bh=8ivO6POCAIo3G3CYfy3m9OdFWnmlORGF6h0AojDDhAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cq150NLpJPMX1DPPdooQWSAQ0kI4urBz4VtU85hcu3fmlSIQNqTz9+AfgLwBWpZMrWiPdHXujZzMpQn42+yIWvAsLIbNLOHkInGwtAisMv9mhd38qVVvgjEWKBDDq0NDs7rN6sELBWahp7sIO9diQHKxNfUKEPVsd82yLJbR4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i3lrIdmP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42726d6eca5so7324165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720601063; x=1721205863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BonLjpSet1ctnfC03bK8l/0hpA9XluDOFZV6vKsFj/k=;
        b=i3lrIdmPI7UpuG4Otqxi74Uc0qTO5YTYqYgFT+sFXEjJWdRdCBJy/w4O+J8RzeSvoc
         ATKFJZ2N7KgmUTaJANpR+4hmCUU0cEKJrhRWJkTK1njiArjZY2TgNI+Fx7taBezMPdHw
         y7TY6iX9r596Ul4IHnvgLbb5HXyBT2ET/NmivYh2g+8pCcTzY/sH89V0PeaoAnrzygc0
         DAf6USTZjryYwoi/9A98sS9cfJM3zype6/x9xXLEtbgzXsGohvfTXes867USk/14BZ66
         nnQoRQCDPPEWLLoimcO0bBqIphIhzYzdV2vMf6AXJj7r6JvBfucgU+p5RarFNbRn9q8N
         8gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720601063; x=1721205863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BonLjpSet1ctnfC03bK8l/0hpA9XluDOFZV6vKsFj/k=;
        b=vRpOJBUXXavOD3ETkWOZRzrY5fTXevtkH8eisZjkNL9cafJ4f4tt3R7wZbsSqJV1xO
         cr2/DKaaU5SUvBrZJoaCpZg23Va8/0N9B9/pyafR+qK0w1wY2fDFwGNY3b8rCJCTFXHJ
         60tB3GNgMnaZoMM2k+3flBdb9ePYSl+WBncEKOyxGAXWfHbBAKYrZ9ELsZgy6EpgGzzY
         x9Q+oiPONUMvusrSrsSQeOcBGKQYgfBD0pdNT9xYWOMpN0jacVYPjhgFi7PP2MiY6RCo
         AGoGIFikj+WAIVrM1Pj+1dah90FgqU24RNk6wIetlsLKu/CPz7VpgkZj/nXAJ1PEsBVC
         JdCw==
X-Forwarded-Encrypted: i=1; AJvYcCWoj0hQz7eIAsfFZkNU4vlniPbFYrtucSS3tV2sGw/80P8KjgAyl7GCImjSC3LXEa7E+ysYTqp05Jzp+yw030bS7LfWIynXs3m3y2qm
X-Gm-Message-State: AOJu0YzQ+fts6M4hbI7OjAfJx7p7TaqP0mDN6P/ZBlBpkddghkjUJn3Y
	7VcnJN9ISffpgh0DdrAog2IH4T97keIWOBpYHY6z/yFtYYox3P22ru3AJJOtGk0=
X-Google-Smtp-Source: AGHT+IHJw2e3QTVBDhstDlKVjyu4nCN3502ntTVILiGZA1l68yg2qaBJmWreQgXWrZkmJl5tO5vlgQ==
X-Received: by 2002:a05:6000:2ab:b0:367:844a:1ca3 with SMTP id ffacd0b85a97d-367cea46c64mr4085862f8f.10.1720601063248;
        Wed, 10 Jul 2024 01:44:23 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06ffsm4700403f8f.77.2024.07.10.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:44:22 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/3] ARM: dts: qcom: adhere to pinctrl dt schema
Date: Wed, 10 Jul 2024 09:41:08 +0100
Message-ID: <20240710084250.11342-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
The following patches make the device trees compliant with the pinctrl
text to dt schema conversion here:
https://lore.kernel.org/all/20240709162009.5166-1-rayyan.ansari@linaro.org/

Thanks,
Rayyan

Rayyan Ansari (3):
  ARM: dts: qcom: apq8064: adhere to pinctrl dtschema
  ARM: dts: qcom: ipq8064: adhere to pinctrl dtschema
  ARM: dts: qcom: ipq4019: adhere to pinctrl dtschema

 .../dts/qcom/qcom-apq8064-asus-nexus7-flo.dts |   4 -
 .../boot/dts/qcom/qcom-apq8064-cm-qs600.dts   |  25 +-
 .../boot/dts/qcom/qcom-apq8064-ifc6410.dts    |  25 +-
 arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi | 362 +++++++-----------
 .../qcom-apq8064-sony-xperia-lagan-yuga.dts   |  10 +-
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      |  34 +-
 .../boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi |  34 +-
 .../boot/dts/qcom/qcom-ipq4018-jalapeno.dts   |  27 +-
 .../boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi |  26 +-
 .../boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi |  14 +-
 .../dts/qcom/qcom-ipq4019-ap.dk07.1-c1.dts    |   8 +-
 .../dts/qcom/qcom-ipq4019-ap.dk07.1-c2.dts    |   2 +-
 .../boot/dts/qcom/qcom-ipq4019-ap.dk07.1.dtsi |   6 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064-ap148.dts |  11 +-
 .../arm/boot/dts/qcom/qcom-ipq8064-rb3011.dts |  76 ++--
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi      | 114 +++---
 16 files changed, 309 insertions(+), 469 deletions(-)

-- 
2.45.2


