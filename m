Return-Path: <linux-kernel+bounces-176076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6F98C299E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7FB1C21447
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EEB1E525;
	Fri, 10 May 2024 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRYYs+JB"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E47D18C1A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363921; cv=none; b=XrkYKdg4oU8LmkomYOsbwD3zVszL2F/D7pMJi38KkBQxfX0bjNsm6dqvgxINVlGuIWQKakGHwy2DEkBrFiPjl0N0lakWEpwjfw5umRUVjAaiSRsW+/dEY45Pst6zWOkag4z4eFuIYLRPqatHPGVDY6uZjqu2yd23LfqC1aTuea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363921; c=relaxed/simple;
	bh=XEetVV5LzjZUd07Qjndu3ZsIUuE/RU2UUw/4u9G5G2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tyAc/ZwX1Vg4zwRZussBXyxnNCv5joIsK2Sk/BiNYt2HEBjbAlRrSKs4UAaO3DvsGUd9+xQ3R6kW6gvSqxtaMBBJuKvzVZObj3ZrSK1UUyPmjNLo/hqEKDP59AHBeh3wirDn1G1ataYMf0g3Rhx+7NYJqerQQnJrTxGX20hzI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uRYYs+JB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b782405d5so22889025e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715363918; x=1715968718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXCAYOzW1kXWnEuZ/9Q/Y2a8adBdw5ihjWlLUmIWrWE=;
        b=uRYYs+JBJ5J1weAxFuQU4CFdym9guQ4wDUqtEnH2qkzHjV6wQ3OHzONcsyG4RlokcG
         KsY1IDITmbyzJ2TDlNULH74xPWTx7qGup9lSdBxQGM1glNvsk9WmHiI2CBtX4OksvSea
         HEVYxceX5BxBEez7RnHMhOCiZRXfLR+Xo7F/s29T8/yTO5nC6JEFT2IRv4MtxpUE1ktl
         du/eIug1/eiW/xxg2pyof3Xl2kMe8o2Ng8XX2DBXX8ndBlJOpCAML3FBDMNv5bGZ7hhi
         bFOFNZYAEgV0la+xrLUB09SrGOZRfhgDDz/ae3YCYuQ1Eqw+ijMvDkxo+fC3w9yKEfWJ
         d3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363918; x=1715968718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXCAYOzW1kXWnEuZ/9Q/Y2a8adBdw5ihjWlLUmIWrWE=;
        b=kStT6Opa81nHEKfNCa7Qw7dQjxf5ffyFR8FE3W+bjFOPslyL1NiNHUXfSblbY1cVr1
         ldRsGro1AQ7cyEUGYUhZc/6+KU1CWNxKiNtUeKBTIFimhhTB8xQm8ptxWJaXZy4Gq2hd
         sHe2DrqxI+lXai54/gERQNi2ZwpkA3Pqc0wBpfmDREhsCcrlJcDNViL/wcZyeZlvqiNQ
         7JWPETiwh15jHV7mqv+vFl4Mumcp2Ts2zsBTI24wPxuzRodTTpKuACOYB6uUICUt2EDm
         ZDDQ5MKMRvWF/UWL2ytemeYl409EeFKneg2rtldvc4hCEIGbbza5OMI2Ed+uHcoTLPgP
         5bOg==
X-Forwarded-Encrypted: i=1; AJvYcCUOQ8dsNh3srfAD3fIbCBms1SbstwY493x6khqCrkmEYxBLWZ0zjp2eXle1gTM+DAytsATa2xSSdBoImcmW8vVM88AQe+cyNCSzBiuc
X-Gm-Message-State: AOJu0YwpB5GBa6evzTChF4NAS84JWQpVYX56R81F016doEj2EJ9QNqOe
	U15Tfi8Rda0syR1Ahq/pMQRNxEq24JRDGOzzPyWv3q8F5CLmCL09TU7k+lbVULM=
X-Google-Smtp-Source: AGHT+IFpNhfIiTH8BJNxZ6X9G34svc9ayq/CjtMPzgYhTlVv2lj1PM6vQcUjlEJ2Boam2c+yC2C1qw==
X-Received: by 2002:a05:600c:2042:b0:41c:8754:8793 with SMTP id 5b1f17b1804b1-41fead790ecmr27551705e9.41.1715363917705;
        Fri, 10 May 2024 10:58:37 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4200a8e6846sm11046755e9.15.2024.05.10.10.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:58:37 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	neil.armstrong@linaro.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: codecs: lpass: add support for v2.6 rx macro
Date: Fri, 10 May 2024 18:58:33 +0100
Message-Id: <20240510175835.286775-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset adds support to reading codec version and also adds
support for v2.6 codec version in rx macro. 

LPASS 2.6 has changes in some of the rx block which are required to get
headset functional correctly.

Tested this on X13s and x1e80100 crd.

Thanks,
Srini

Srinivas Kandagatla (2):
  ASoC: codecs: lpass-macro: add helpers to get codec version
  ASoC: codec: lpass-rx-macro: add suppor for 2.6 codec version

 sound/soc/codecs/lpass-macro-common.c |  14 +
 sound/soc/codecs/lpass-macro-common.h |  35 ++
 sound/soc/codecs/lpass-rx-macro.c     | 565 +++++++++++++++++++-------
 sound/soc/codecs/lpass-va-macro.c     |  29 ++
 4 files changed, 488 insertions(+), 155 deletions(-)

-- 
2.25.1


