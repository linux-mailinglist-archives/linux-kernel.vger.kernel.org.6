Return-Path: <linux-kernel+bounces-273426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1FD94691D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12970281C40
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4EB14E2C1;
	Sat,  3 Aug 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idBS6qZZ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C821ABEA7
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722681709; cv=none; b=XNewsqt7bou4EegNZoaEi4IzHg1VoHEPEXx9pbJjlCQpr7d3dE5ETqVotlWdOLySEr7fdqcAFXT+NJfXrvMRCOpyO569LqjwoBxKabV+OxzlQoR5OTElcy3tUTj/KHIWTOmHHKCxcfDpBfhVnYSsgCKZtZHD7m8kyal7D6EUzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722681709; c=relaxed/simple;
	bh=/keCe+RYTAEof6iY2K+Bnv28/+hoBwjA1/9NQ0Hke4I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JpMoMfesjkhe9f0qsykyb5TuHlKshaobTsuLMs8Qile7AUK7qrwR6FkOVd0P5+DQ8Fvk7vDsRTcmXu5FJkFPrC7+FGWDQLl7ZFnfh7LN9qzqTlpfvqcuNcIU+wk1w/IOJJCqVSOIIKV0B1Zam12xWj4NKqYRNSmMGpCPMBNUI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idBS6qZZ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so19468179e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722681705; x=1723286505; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6XfE0wuy/HIDAoO9pP4NYutSvJQFGt1Hra+lGxkJO4=;
        b=idBS6qZZpRrFktyEkNxKJ2O1rIhtVqdf02d+J9QJ16mrpTO3/LxkQiXXR9buGakS0b
         IbHZLJfd6JsaeIDCSqkcnEe0kI7B230Sz330uKar7RQfh0VIoawYrR2N50AZBYgp1+OM
         jIPz7Hf+1aAryySTlj8C+Bc61Y6sUX/VWprGZApClVr46Nz1WrL54Qj6Y6BLFXEIrOgp
         mxWCeWOwoqhd/nQ1DP7P0phb6Nktoaq47dzy/ISiOK91Hva5JIvwp5K7YKszFJxhZKFE
         e5X05WirxPT+wWurQo+owOEabvFWqUBU/r4ZXikJZvhcncIgxex5+meNw0nmdy2MEbLB
         2D7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722681705; x=1723286505;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6XfE0wuy/HIDAoO9pP4NYutSvJQFGt1Hra+lGxkJO4=;
        b=LiVlmKeEMofgpEiiMbkz2BGGktjpIHdUcRqpq+YHIvSdCz7UbstNGpXkWcG8Eylwtz
         zwaweCehYXUV9VfU4l+o0hhnxXelVFaAjsCU6CRakRpYrKUi/sumZr9I776BI3qS08Za
         28yTCEk8mOQAXmKymxbRKoTUchjmGJDOnn8BJ4soRfsKMboWiNa8c8vE3/So0jSOixYj
         yN+McMiLUzFK4bi8FzJxYr3xVVgQwcA0g2fGxliME0k+nTkXDaUk1lARD1zBqtj1YhBl
         g1wmEo3HxsXNxTdNZLn8d4lDujVav8kXpA3FuATHmF4d68Lo7oFA8DYFOjILr4vrMGHx
         zOkw==
X-Forwarded-Encrypted: i=1; AJvYcCXsA11vhfyJ4hy2WkHhvvTXo+/Jx5HkjjSAjUIJ62BBJ9JJHfxfMyz45q7/Pco1dyVWaMGWbJLMHCPZbuyxC04CwAPEdoT3t8Sxey6U
X-Gm-Message-State: AOJu0Yz/LMWuDfxrY5Ga2RFZtPNgN6j+zsuoGvru9ZgpIYu+bp47yXk5
	1NxTNSQR2YXWvcYB9pDZH2uvZAHb09YWIqe56UpbTVHaH1ar4PWqhAq87OHWLA8=
X-Google-Smtp-Source: AGHT+IF800af46goSmkquETHEPslclS/M3eT6WGABoZvnDas++CS/5VA5nNGupa/GwDs2mHuxpiZKg==
X-Received: by 2002:a05:6512:1094:b0:52c:df55:e110 with SMTP id 2adb3069b0e04-530bb373806mr5208762e87.12.1722681704438;
        Sat, 03 Aug 2024 03:41:44 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e7feecsm202086366b.176.2024.08.03.03.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 03:41:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] ASoC: codecs: warn on unknown codec version
Date: Sat, 03 Aug 2024 13:41:39 +0300
Message-Id: <20240803-codec-version-v1-0-bc29baa5e417@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGQJrmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNj3eT8lNRk3bLUIpBK3ZQkszQz08QkU8PkVCWgnoKi1LTMCrB50bG
 1tQASd7tkXwAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=967;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=/keCe+RYTAEof6iY2K+Bnv28/+hoBwjA1/9NQ0Hke4I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmrglmKnfdtOGxXRACB8UtRgTdRs5sMF7sJRo7w
 3EY4ygT+smJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZq4JZgAKCRCLPIo+Aiko
 1WG/CACayIklwe1wlfXJJ61EnWlvC8/+TtjBvjCNMmW6IlKA8j+pUQYqOb+lXwgofI8nDEAN7mG
 nC4IqS1m583hIVeTvOVh+A714w9AgQ1lRSBHIn//0Wo4RXGYOfuPZUuQg+BknlbWx6iE+X14gwN
 mLSDiebkQtEx5ePwbUl41NGCM3i8XHCssI8Kl9ptHceBty9qD6lwk5XdyTbQn7RbzbeWXk8vVc/
 25iTZbVmDW4iIEG37IzqszToAl+A8YkD4xEN5x/F8Yr1wA5+uZyiY8aO9zAPrdlLKtaiDLf1ME2
 xpy3DXb2xx2u+DNMojPMNf68mgvEShp/c4KgWQNeRq1KjCZC
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

While debugging broken audio issues on some of Qualcomm platforms I
stumbled upon the kernel not providing the actual error information.
It prints an error from the wsa_macro driver, but the actual issue is in
the VA macro driver. Add error message to point to the actual error
location.

va_macro 3370000.codec: Unknown VA Codec version, ID: 00 / 0f / 00
wsa_macro 3240000.codec: Unsupported Codec version (0)

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      ASoC: codecs: lpass-macro: fix version strings returned for 1.x codecs
      ASoC: codecs: lpass-va-macro: warn on unknown version

 sound/soc/codecs/lpass-macro-common.h | 6 ++++++
 sound/soc/codecs/lpass-va-macro.c     | 4 ++++
 2 files changed, 10 insertions(+)
---
base-commit: 668d33c9ff922c4590c58754ab064aaf53c387dd
change-id: 20240803-codec-version-db6f65ab51ce

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


