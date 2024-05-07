Return-Path: <linux-kernel+bounces-171096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2DA8BDFB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCAE1C23094
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008414F115;
	Tue,  7 May 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ApJpkcCu"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD114E2EF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077666; cv=none; b=qZ6W+WbTc5Snxe0CQXHZqYg26bPMEvitQ//ukyhtqkUxyUbSRppOfrW28JrCOzq2InuvKEvQpYS3RKl0rMVhe1kxD4XV7yZeDmDH0C1c67aeDncu3ysrm2igGFr/y4U+CU4K84S7VU+sgYRbJ2G0xt0sqZur3mF8u7b1LwhTfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077666; c=relaxed/simple;
	bh=UA3F40A7r6F4bjPkfKJpAKLHE1h9mHy8CdOamekYs/0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y70maRhBs4oHQMEJbODREAXTHrr1SZOvMf6V+Kw0pYcAAGtXsFptIxQeO1zS0zF5PawKM91h2VcllMulS5N7QAuv/3NarlFnB35WhaY6R/hmHM90OvdOF6OcgNyDd3hRHwY1G6GaHULn/1yNWgSc/vPWFbjraIiss3d9m8QzqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ApJpkcCu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4702457ccbso748468666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715077663; x=1715682463; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFiLG2QOTgMREMZMtW7unZxhYPzyuGBw42NHTzIrjEg=;
        b=ApJpkcCuvAzwMcmep+s4Ks0+8uF0N5fODwHEPL0HJ5tbLufuq+nYlT9+KHKy8RLERp
         i8dy4UVBSO9wyuqlREwPliPt2m4/TY9usUJw1wJNnMVlGBXNEyV7RBVq/Jv62QfGT7rp
         TiLWcdO3tjNicOlHDm7Ivt/hxfcUKfoFbk9oZbPBhMCPiCvj32vgQ7caFcCVouTiCwUa
         JOOSLe99IPmGIPdVXfm8BrXMREvQdSnFly8iCJd+ijE3IbsElVMhvzU2W8buLcS5EgEM
         w3XWnf775EAJs1ALOz+iWkaxW3StA5n0ksIOXsLA3wUpLUqQVcEvv9T7f0gy9m2JeZF+
         /5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715077663; x=1715682463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFiLG2QOTgMREMZMtW7unZxhYPzyuGBw42NHTzIrjEg=;
        b=ZhBY+4oTYjZS5KBuRZbJxtKb6GyazlNTHmwrrJycYNgFSZTa9zaJtpG+BZYthYPdvk
         FFi8qwXBUMEiln+HIJliDG3gVtZyR75Qmppa7VRX5N5XYGmKEQ9KW7DltaqJ567g9Qhj
         fXFkw6gBTVxChIl31EobppjCDqKoz46O87wfhwfy0IsotlTW6fJlMxZYA1Sm3ckBsQWu
         9mlrSTjq0IG/c9qMPov/Rvg2FZ/3ui/7jqVUOEtmj5UNs0bg/B26Y8KA850bqYxUV7iV
         BMxsmAuHBenudkjxhh4FWkdnj7ygkPpVWF309EKoMDvYLu0Iuaw1EpFAwgKQrBcCoAj1
         /4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVJqCb0b8F6x6wi60b+cm/kzvws8OLgnT0qdAizcS09fFEqTq3iSQh6aC7O/DRf0ix9RdcFIAfa+mOYcCWXUclFTH/kp5Esefy/PywD
X-Gm-Message-State: AOJu0YzXhC6LD6DHVnRB8mw858sSlMWp6AltDMIuoy5yj87BEE7dSG3R
	xV8iFT83XD1XHZN4D21MF/cV2on+kuGuQK4L6k1sAgVDSHhIZrvKSukqZotaf10=
X-Google-Smtp-Source: AGHT+IGiGDBt5yxrFViI2K6OwEdG5BxYWaB5AQ6x9sPDuZmTlizY4kXoke2k+cqZtkEZS82lyV2hMg==
X-Received: by 2002:a17:906:f595:b0:a59:affe:b9f with SMTP id cm21-20020a170906f59500b00a59affe0b9fmr6075822ejd.6.1715077663076;
        Tue, 07 May 2024 03:27:43 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id bo15-20020a170906d04f00b00a59b87dd0bbsm3370093ejb.161.2024.05.07.03.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:27:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] ASoC: qcom: x1e80100: Correct channel mapping
Date: Tue, 07 May 2024 12:27:29 +0200
Message-Id: <20240507-asoc-x1e80100-4-channel-mapping-v1-0-b12c13e0a55d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABECOmYC/x2NwQqDMBAFf0X23IVNiNX2V0oPUZ92QWNIQATx3
 xs9DgwzB2UkRaZ3dVDCplnXUMA8Kup/PkxgHQqTFeukloZ9XnveDVoxIuz4sgJmXnyMGiaGr0e
 x3QvPpqVSiQmj7vfh8z3PP1coU5NxAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=UA3F40A7r6F4bjPkfKJpAKLHE1h9mHy8CdOamekYs/0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmOgIZDiepsVWvVzHlozJIF74v2e8BDRMWdJ9yg
 tul3Qy5IlSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjoCGQAKCRDBN2bmhouD
 106XD/492uoI9DGw7QfAgKxvhjg/WFIaXDR7JoFHNQBWWpD6g8oM/uOyKXhus/RrfCk7ZXcD+H9
 1bhDN+FFWC9W43rhUMYNBsJlql7J5BH5PXmEuB2YdsEmIgEHw9fuzNtXCeN/hj4DVtmcpuVlZ62
 8lpWMKS3FSpH9BYVlMKzN7C1V1RvxktZl2h/bXs4eHVMCGnUBNkyzOTzkFwdIPdRy33RBidEjBP
 AVPtgRJMSg2SENodHxrjpvdM9gzNZD7Ag4h1S1AIUm14eD1fdnNeaZoDwrinJ0U+G4NOIScL2NS
 VxDR8P437XoyX5dsE/1kviIFmp7ZvB3jhXf/gqJm0HYq6sbnx3GXWcuGrxSiVnHuIpMhCu9VQhn
 DVFU2IcSCJlXZpd/PteAxMbE12AOQUrKCac3CnJHl38KiceuRIyF4iasoquQmtsEL2WEA94z+ie
 BA8IP+TPVkABmK5jhnLs8gULj5/mshiB+jPdqGCMuXRSt/iwBkuV83XFk5y42RYy6dr286bz3r5
 JK2Xpj6KCLkpD6/mpHknjMk2Eb2NJzoAMjsU4qaGgjNI/07WAT/GLCnV3eswbEl2Jet58KdMA3+
 TEzMjoO7nZ8GsatHKT/TLgKrV90MCRwXw4aloqAZdjAz60ocAoZi9meM0T77FLj0KstAFiq1iQX
 hGestPGsZPrgzaw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

First patch is a build dependency.

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
      ASoC: qcom: q6dsp: Implement proper channel mapping in Audioreach
      ASoC: qcom: q6dsp: Set channel mapping instead of fixed defaults
      ASoC: qcom: x1e80100: Correct channel mapping

 include/sound/cs35l41.h                 |  4 ++--
 include/sound/soc-dai.h                 |  8 +++----
 sound/soc/codecs/adau7118.c             |  6 ++++--
 sound/soc/codecs/cs35l41-lib.c          |  4 ++--
 sound/soc/codecs/cs35l41.c              |  3 ++-
 sound/soc/codecs/max98504.c             |  6 ++++--
 sound/soc/codecs/wcd9335.c              |  6 ++++--
 sound/soc/codecs/wcd934x.c              |  6 ++++--
 sound/soc/qcom/qdsp6/audioreach.c       | 14 +++++--------
 sound/soc/qcom/qdsp6/audioreach.h       |  1 +
 sound/soc/qcom/qdsp6/q6afe-dai.c        | 16 ++++++++------
 sound/soc/qcom/qdsp6/q6apm-dai.c        | 12 +++++++++++
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c |  6 ++++--
 sound/soc/qcom/qdsp6/q6apm.c            | 28 ++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/q6apm.h            |  8 +++++++
 sound/soc/qcom/qdsp6/topology.c         | 12 +++++++++++
 sound/soc/qcom/x1e80100.c               | 37 +++++++++++++++++++++++++++++++--
 sound/soc/soc-dai.c                     |  4 ++--
 18 files changed, 142 insertions(+), 39 deletions(-)
---
base-commit: c5e512ffe106f751c61e5a036560f522e58eadcd
change-id: 20240507-asoc-x1e80100-4-channel-mapping-ea5f02b9e678

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


