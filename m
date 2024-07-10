Return-Path: <linux-kernel+bounces-247532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F392D0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D2F1C22A14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7F19048D;
	Wed, 10 Jul 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bf3zF0lr"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC97190489
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611582; cv=none; b=AW48mWDHVuwmFp/EuvNFrZs332+W8WL441eFzAaaN9dMs6Uv5NFCK7pqb+5HB62JeqQdg/TpxPlrTcZwdH74BL0Oam4soa/ySfk0VKldkf7RcpHJ+X7kPvzC7hSFOmV6cPIzD3pOCdrepAAnmMePSiMNQp6vyrMH95Q69aUvzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611582; c=relaxed/simple;
	bh=Zi1bu+0mhBf3Hk6tKFUnpbpzDHk75+uCDG1w0Ixbnr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pivWHmRpZk/QRo1NE+KnLU1CYr3nL1/VoaYMMRdyj4sihXhAfKtVewGdgFdL9NUEOezz6r4WbQCmTwmE0n9AiBzNhboUudC4KuKItgXCvcRi0/bo1MVWsbge+WA7PUPVkZru2J1aZAHdRg2ZnWpSpF5ml77E1l5PD2dH1z4dgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bf3zF0lr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-426526d30aaso35029125e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720611579; x=1721216379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MHKc6WWhLmwAuWzJd0ksrdeT5LunJAc73Qa62Pmp84o=;
        b=bf3zF0lrAjMZG1XAs24vtGv3b9bZuWMLPwMKZuSrq1Xxr36q1+GbV78eKuKr++b2Mg
         QBgfvn2JAEXRvZYwpARsYzalMtzoXYw/i7fJOuGc6heO7IZhiX1zZs398a2yUNIVpp06
         BttZdjuSQxBKg/u1YGsxbTwO3yAv5Jj3j8B0IT2qQk49z1mzAVBSO8PPdkkkWvZe+jmw
         HKoMBbUk8Q1fwu0lc8DFwDHhxCLYNA49dDswu83OGjre98U7jcEFe3SSR5s2zxcfmWAC
         Vu8ISbLWif/FBJZiqBq4LAfQXGyuE55G0Dcpi1tmTi5zHCy5vODxjNgqzWDuP7Ff76iF
         PQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720611579; x=1721216379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHKc6WWhLmwAuWzJd0ksrdeT5LunJAc73Qa62Pmp84o=;
        b=l/I9AR7IfaO3cKDvoTCquZMr4lVa4ZWMU0Go3ZHIcRPLy2yf5zgqACKTZnEs9+D6Sm
         0G1DoWPHzM6xGSpFkru5eITV8KpWx1lDeX++50AuKQM8QQ4lYRFnjj0enVGLPBODIhyD
         lAOZ9xqHliblgwYqeUza73SeMjgkcYeHUxTQBNlg3oz8+cXgiGYGTw9mf8PwUYEYkVf3
         pxnqSZokEnWXscDoz3QoHC2Hdtm8lrwcMyeDIEzDBQm8l4ukItFWVUlE50/Sgm+Xa0my
         +SYSIaUtPY8sHjo7OhY7takjdXiPOLl2vzohr9OhwkZFPLnfs8WADpt9jgmN8RdW1Wi2
         2DXg==
X-Forwarded-Encrypted: i=1; AJvYcCUs42vfCqcIp4wDqdh3pYcxDdETqnPnCCTkQdBVLEyJ4tWcPSs/fYtJDBHIHRJBBYcwPxb+Qi3t26ECLRIZ8IVGe6toDsg26S8ZsgXu
X-Gm-Message-State: AOJu0Yxhizv3ofJNGti0lhNLfLZhkhXdb/cfSBiWT8pDsppOBWQ9UwIw
	SanPLU3GC2AFUhCnR0A/IKAr2RCp4Y/ZxIr0r2OeW4yY44ixqGezYHWnZG/ZB2M=
X-Google-Smtp-Source: AGHT+IFHYPwe6yZ9R+JtpGuu8hlP3VMdv3GZsmSGlWY6ENZv3HqEopDNWzX5jjb+nxuJh9OPTx/xuw==
X-Received: by 2002:a05:600c:22d3:b0:426:5f09:cf57 with SMTP id 5b1f17b1804b1-426707e3445mr33231125e9.19.1720611579201;
        Wed, 10 Jul 2024 04:39:39 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7361b5sm78602875e9.29.2024.07.10.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:39:38 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	alsa-devel@alsa-project.org,
	Banajit Goswami <bgoswami@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] ASoC: dt-bindings: convert qcom sound bindings to yaml
Date: Wed, 10 Jul 2024 12:36:05 +0100
Message-ID: <20240710113833.39859-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
These patches convert the remaining plain text bindings for Qualcomm
sound drivers to dt schema, so device trees can be validated against
them.

v1: https://lore.kernel.org/all/20240709152808.155405-1-rayyan.ansari@linaro.org/

Thanks,
Rayyan

Rayyan Ansari (2):
  ASoC: dt-bindings: qcom,msm8916-wcd-digital-codec: convert to dtschema
  ASoC: dt-bindings: qcom,apq8096-sndcard: use dtschema

 .../bindings/sound/qcom,apq8096.txt           | 128 ------------------
 .../sound/qcom,msm8916-wcd-digital-codec.yaml |  55 ++++++++
 .../sound/qcom,msm8916-wcd-digital.txt        |  20 ---
 .../bindings/sound/qcom,sm8250.yaml           |   1 +
 4 files changed, 56 insertions(+), 148 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt

-- 
2.45.2


