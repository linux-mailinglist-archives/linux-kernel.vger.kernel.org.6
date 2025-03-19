Return-Path: <linux-kernel+bounces-567558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5816A687C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07EE3BD398
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED26F253344;
	Wed, 19 Mar 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psqRCYKa"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A30252903
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375873; cv=none; b=aLOir21btz2LXbQMIFh9629XBl1qaLhld+f06NLjpLdLHPO7uEzKcsm4HK1OMd75crgKXHTYRS6qTGhehmsEMbiQoJ3soY3iNuTlO96ivhOxe123YNU53NYhWS3wkcGDEfy+k+859bFy3o0P7kXZqg+xJX963Ntm9Jgy5LWaNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375873; c=relaxed/simple;
	bh=VPh5eje9bAcWDgKXkvNDiNcxKVyg6L/lyX536kltyjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OxUiyGiQLpekZhq1HGtHgjXRiMoMZx2km1LNN9OfuzfOPfW9na+zdNTTXwnhHrDcHugsi2KUELusiNqyaCD/SXJDgrsErWIxGFmX05rXDQRd08511RYUydXeFPLQZpWIDq7BQ90dlhvQ/RumgQUJrNwjPD5Vmsws07pdQpzAfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psqRCYKa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so42973235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742375870; x=1742980670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eu9AneJ6jeTssLgq8R/dkhVI+8UdajKVGpFrU+v3rj4=;
        b=psqRCYKaXIvspoe0E0TDmR/BP5gsCMay1Pp6vir0zKoYOcoJVIgyw6O6Can4x4lTuB
         xFUf9vS6zEPzeTbMeqsrgoOw7D82kJ/nj0CNKqY1SECHlexuxaq3ugKMRpCKoc7T6Ss3
         JwDrUxzGUlRCegKoJ5qsWyN+jkUhNTgHiiofJhedVFhvS+KRdBZFwEP/A1yvGJiXCb0G
         VZZCmA78GLE1QgUQ4XBpC4gOPn1o7ccJZelqE1eVZMFEkUmEsCX8SxCCobVKoepC4kP5
         ChKxR5c7w9pdjUn+zB+n1Byc3Owa9bRdVQVj8RxT9TL3BSXsNjVfhNBA3TOqcy95Js1M
         kA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375870; x=1742980670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eu9AneJ6jeTssLgq8R/dkhVI+8UdajKVGpFrU+v3rj4=;
        b=YGHEoFk404oVLDXx4ng5dz7SsEmFKRswPziIyHE+mgFkaBgfP64xFWWMYvTxK7vmFA
         kvYqKQkub8TR7kJdgZAt0CZBNKDp1/4vLpw/AwC5dWNvof0gWiN4kSDipmLpS/0dqku8
         DTt/R6WaT4gftGvQ2G40sUCMUv2xFN+H1RUrqTZw8yZf3hudU2r+onPged75Di7mtyy+
         OYzLjLrXZOiZ1ozb4T9qLuiZghC2Be4ZCWw/BQaRmeScnHz4Xk4GOP0m9LhjG1QQ1yGW
         uVIkwJq5Vx56oUXUHgM4e7t5fZh6XxTxX2fwDwKun4p/ngxUbZkRoi/q82SkH3yf3x2Q
         ovng==
X-Forwarded-Encrypted: i=1; AJvYcCUR2Mr5aih9lPxXKmZrPNkCZtkfGknhXHCvLJiza98ShZZnoPn8LKnk69EiToEugoAcvyv6Qh2Nkr6hrrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7XxWr4BmdZIua+N8ggcKZACZu041wp+L5ZW8YbUA73mEoHgD
	voTLKpbG1rpKd1ArV+m6Uns3+JeNsJenlHN9gMv6d++J4WGdhZ/rsa9RpEvNGpk=
X-Gm-Gg: ASbGncuFemp4C2Qt/SINqjL5qlK8r71C3srA0LidfG+TGcBChqb+0tDFlkyWswvwATP
	9WwtE6Yl/Jc8pjxZYOXTYvKrefRdXG7wjZwTqANfxi0ZSGU9QlfPiHZpNratmXc6rJWg7lzcnLy
	jA0LIAVEOqyvE8q1jhhCSXzCmkA4/SiULgkqC7GnrusJUagl3MoKXf2ymlPIkDGoTmRwew2HThM
	d76F/JwOg65b9/imssTIrlmEqMNntX1oXMBNKckvRjaocC4JQblVQinpWWtfqrHlTPPnAtkVudT
	1VOU7ix6J30O7wZvpuuEL2YpfJh1JvyYSapddhTwugCu965ES+AkFZ6HMflvP+t6vRe68g==
X-Google-Smtp-Source: AGHT+IFM+lzR/VCSJcNgqIaD4wovGQBkSyZQxDj6HuZig4PP75GSKCAEII3ZXglrni0En0micDVRvg==
X-Received: by 2002:a5d:6c61:0:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-39973afaa73mr1518826f8f.37.1742375869548;
        Wed, 19 Mar 2025 02:17:49 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c255bsm20023810f8f.23.2025.03.19.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:17:49 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org,
	andersson@kernel.org
Cc: lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] ASoC: wcd938x: enable t14s audio headset
Date: Wed, 19 Mar 2025 09:16:34 +0000
Message-Id: <20250319091637.4505-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Lenovo ThinkPad T14s, the headset is connected via a HiFi Switch to
support CTIA and OMTP headsets. This switch is used to minimise pop and
click during headset type switching.

This patchset adds required bindings and changes to codec and dts to   
tnable the regulator required to power this switch along with wiring up
gpio that control the headset switching.

Without this patchset, there will be lots of noise on headset and mic
will not we functional.
   
Srinivas Kandagatla (3):
  ASoC: dt-bindings: wcd93xx: add bindings for audio switch controlling
    hp
  ASoC: codecs: wcd938x: add support power on hp audio switch
  arm64: dts: qcom: x1e78100-t14s: Enable audio headset support

 .../bindings/sound/qcom,wcd93xx-common.yaml    |  4 ++++
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts | 18 +++++++++++++++++-
 sound/soc/codecs/wcd938x.c                     |  7 +++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.39.5


