Return-Path: <linux-kernel+bounces-172895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183838BF844
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4271C21563
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6367840841;
	Wed,  8 May 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHmJyW5S"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9E81DA53
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156202; cv=none; b=KTs4CIDhCVAxUNQ7KQhZM0RAagiRgvZx+GXpHP/OF9+hwcLdqhX9T3LJQaEJRoRFuDjreIrqhqnEF3kLhbbwOOGSL5Jp4t1iJO6dpMPJopAU6LceihCsLBLCxTQluTChtxo22WUmWHkJR0u1nmY2PBpYb38gDeyOZ1Pd2+JnqNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156202; c=relaxed/simple;
	bh=0AhxjfBUNhlENSAxe92nY9VoC8qprxHxldB8aoP2AC0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GB3mXURsc2n+wN1KDMZ8zHnYGUeMhKqy0hIsroRtkuT+05lD+sc/WVZBU4IGuWHN96LLlKX1KeEOHEhD5J+XauAxzhlt1auFPYCXPYqGb+hOPVI9reV+4R9Pgdm2hJMaIcVE2cloeNV25rn/nof9vePrbLz14DommSrbArg59jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHmJyW5S; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a64db066so1034999466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715156198; x=1715760998; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LyURlQNWFkOdQ16KIflmxTG/F13lDDlyX2+IEOje/E=;
        b=IHmJyW5SxLlA/uL7fsXV1d/nZsZX2e0Jsd0j6fcaNrjmriPBeZzF1wfI2WQ+ljwRHx
         aFkumMVBL1iYai2o532W9d8UvSBgg6/4mhesBIf5jjuObq8ITmF9QG/uN2WiQ8NVHvXb
         JbDJF1WrNPFWYd4gatIm6T+TNIi/mshcPBnzghp4dilRKjIbedDqhOfrbMzArFI50Hqc
         Iry3CINZ2jdogQRhhgA3fvVXEDX9ZagcaQrK/qqSYuujPzCVR10aOWUZVxv63j2wjRcT
         JR5pjhbHkHwT+++4Ldp8j+z+EZbBouV0bEbOrsmrJdBlx8RBnYV6Pg+TbUBDp+v60gaO
         lQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715156198; x=1715760998;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LyURlQNWFkOdQ16KIflmxTG/F13lDDlyX2+IEOje/E=;
        b=ThxwLzcZGbeg1GWP0M0Wxyzz2iiSdL/eUiun1yr9ELUwl5RwpCifxvE6kmR90rnNc6
         buOemus382XwfTI9HG6HXMBbTwO8hds4I4WkRy+x75Sm+kc9hVx8Tk6S0avpuk5vbyLc
         t9Ig2nSYknXaynObtZSXUsr+HVMUgQ/AkJujMHcCSxX/xzr/ppGpDeIvO05L3ZrZmNsz
         9eobesRwvvidxTcp0053zx+HYEzmOrxd1aMZ9TzVkNeUhhJltd1v2UZgykcD8GYfOg86
         4Mjh6dLFSsnKKscamS7a8wbORvJS9z3CBn/ZAaDBWWScR2axaEYQPEAQ7IqrPAvgoUkb
         7b4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWntsfLUqbHQWXA7xqWMP+ND3c8lDpKqq1C9K1yuWc47545tdfIma36rEY7bPZdsAIuxirLnFp1nMC8quW+QJXIk5xjm2ciYGqbDgws
X-Gm-Message-State: AOJu0YynmWdrvjfB/XUKQIVvhrlDckevmKMTPgKoZ/dThoaavVhHk6EQ
	Ak/mHYFIKWW478pT9XuN2As6gNkQCOzAtacMjT95IVH9oypDGgb4pJ1gwrsvcI8=
X-Google-Smtp-Source: AGHT+IHs+JurhXwWmPQdrBI2wdkuaapr5rWhfWE2s5lYO2xvo5avmMjueKZhOqtVq5beJTeZWebaNA==
X-Received: by 2002:a17:906:5947:b0:a59:c577:c5c4 with SMTP id a640c23a62f3a-a59fb94d7ebmr101421966b.24.1715156198300;
        Wed, 08 May 2024 01:16:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id va28-20020a17090711dc00b00a59b87dd0d7sm4564734ejb.147.2024.05.08.01.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:16:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/4] ASoC: qcom: x1e80100: Correct channel mapping
Date: Wed, 08 May 2024 10:16:26 +0200
Message-Id: <20240508-asoc-x1e80100-4-channel-mapping-v2-0-ccef9a66a572@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANo0O2YC/42NQQ6CMBBFr0Jm7ZhppYKsvIdhUWCASbAlrSEYw
 t0tnMDl+/l5b4PIQThClW0QeJEo3iXQlwza0bqBUbrEoEnnZKhAG32Lq+KSFBHmeLwcT/i28yx
 uQLamJ908+F6UkCxz4F7Ws/CqE48SPz58z+CijvV/96KQsFG6VTcma0z3nMTZ4K8+DFDv+/4D5
 XThsc8AAAA=
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=0AhxjfBUNhlENSAxe92nY9VoC8qprxHxldB8aoP2AC0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmOzTdgaDk/OCXSJX1MATpDLnCVpCQKb0X2aD+a
 1MbGr1FewKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjs03QAKCRDBN2bmhouD
 12BcD/9RJ4TY6c9upA/1dg4aTcTlGdWos5X1GufItF1YJZcQV62JVJp1MXIHBeAGRDIJFuGA9S/
 WCg63QChWfpXDr+reNSBkhGPxPqMPlWMwPWg2+daUTy55OX/Q0VA7KB5OWHtRE4JLwE/gSUrG9C
 vdjU3Hig4gQrzAuWt+xSLd/wfP9uw3OzSAYQUSI+hJlEQ2aXPmfNMgLAdN05uTrbAzC20GX/xsY
 pFd6aT84sPzMmFYFuT4naZ3P1GAWdbWPbwrFcQRec8AVG2uj6y+coNrv+QMWYXrLG53qLJRDWO4
 8wyLjF+o3VCtyEeLnVvXRCvPqR54b4nqVH+fjAC0dhEDIzYHmr1BwxVwpWpkpQkPDpsT765DPpf
 nzGBkngvP4YazG7Ae6TCwnhybOQ73tuLQAfQpaEPsSNXZq1NvCr9qXbqPjJ1S6PdyudxhtWO+tF
 BCcCYHpteY0xGi+2jCKK27iHNX8pxgzmnXvCyv2aLFm+1EBCcnGIl3YPTCdxjq4dO+5kxqKFftA
 ZLik7IhrYonACWKbJzW+J29L2Gg0RisWmpSAPJVaJZxWIbQwVFovgBWFfzC3jGcOOD7S0GhTN4u
 79MeIDiLcASW9r1BowHw2Ku7RBuQZ49Tnb2FAdXN1kKm7eifCnGPVKhfKJ5uqNRf4+LiC270mxg
 1wJnKsvIF2J3/MQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

First patch is a build dependency.

Changes in v2:
- Re-work most of the idea according to Srini comments: set channel
  mapping for backend DAIs, not frontend.
- Patch #1: no changes
- Patch #2 is entirely replaced - now channel mapping is implemented in
  q6apm-lpass-dais.
- Patch #3: rework to new approach, but most of the code stays.
- Patch #4: rework significantly, because only backend DAIs is now
  affected.
- Link to v1: https://lore.kernel.org/r/20240507-asoc-x1e80100-4-channel-mapping-v1-0-b12c13e0a55d@linaro.org

Description
===========
X1E80100 CRD is the first board, which comes with four speakers, so we
still keep fixing and adding missing pieces.

The board has speaker arranged as left front+back and then right
front+back.  Using default channel mapping causes front right speaker to
play left back stream.

Adjust the channel maps for frontend DAIs to fix stereo and four-channel
playback.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      ASoC: Constify channel mapping array arguments in set_channel_map()
      ASoC: qcom: q6apm-lpass-dais: Implement proper channel mapping
      ASoC: qcom: qdsp6: Set channel mapping instead of fixed defaults
      ASoC: qcom: x1e80100: Correct channel mapping

 include/sound/cs35l41.h                 |  4 ++--
 include/sound/soc-dai.h                 |  8 ++++----
 sound/soc/codecs/adau7118.c             |  6 ++++--
 sound/soc/codecs/cs35l41-lib.c          |  4 ++--
 sound/soc/codecs/cs35l41.c              |  3 ++-
 sound/soc/codecs/max98504.c             |  6 ++++--
 sound/soc/codecs/wcd9335.c              |  6 ++++--
 sound/soc/codecs/wcd934x.c              |  6 ++++--
 sound/soc/qcom/qdsp6/audioreach.c       | 30 +++++++-----------------------
 sound/soc/qcom/qdsp6/audioreach.h       |  2 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c        | 16 ++++++++++------
 sound/soc/qcom/qdsp6/q6apm-dai.c        |  2 ++
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 21 +++++++++++++--------
 sound/soc/qcom/x1e80100.c               | 18 ++++++++++++++++++
 sound/soc/soc-dai.c                     |  4 ++--
 15 files changed, 79 insertions(+), 57 deletions(-)
---
base-commit: 2b84edefcad14934796fad37b16512b6a2ca467e
change-id: 20240507-asoc-x1e80100-4-channel-mapping-ea5f02b9e678

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


