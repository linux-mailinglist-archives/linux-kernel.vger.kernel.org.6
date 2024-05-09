Return-Path: <linux-kernel+bounces-174214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931EA8C0BBC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DCC1C22177
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059E6130A65;
	Thu,  9 May 2024 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcDDk0fh"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E157C0AB
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237527; cv=none; b=gm2JzhObTR228A1W//R1vWR2gT1NQgaNw/938j5OQXogssocXf+74aiat7YoMZlG+W5/6E3R8KS7TNqTQk6PzLIjD4GFLYEwD8+BEjpJbEJFNCa4fuG4sbMbl10KrlREfQ+Sk0Bmh0u4IwHxRwXulpMnKDAdu9DYVvZDGuEErg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237527; c=relaxed/simple;
	bh=rOxCVpuvUmbACYXpkXKZKRD3h2JXgl6Ma28qOmXdJFk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L3RaHO3TuqBNzCOss0WOiE4OYhY/pSU7Z5MynDaVLOtS6IaAjfXjoCZGPVl8na0a53eCXe3IKZFjRxZBle5A7UEH5cclF/FWRsRK2YgfnjlqKU0HJU9vXBcXigMen1nAqkQhszqLrKXtsQfzwqiwmMsb+NNv+vgED2qwf9I929w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bcDDk0fh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59cdf7cd78so126420966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715237523; x=1715842323; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rnP8lifwF80Zq93ecat3fo7l4f28X4MCb0bTfRERyQ=;
        b=bcDDk0fhV6fH9poBnJOcTWuLPAyx1KxlO484Cdfxdb22oPFkdDivXS6q2VydScC629
         Zj4hxL5I+Om9eKbpDP//BmeUytn8MJgUW4GF0Qz7bdCP6iwAwjrhmzsF7hVc83EX9iOF
         eQ+EjWJzYqGeLl0h5w35C5QceYoEi0cVrn+YodrIyhzkxZP0EsiuivEk88+HJHD+n/WR
         0MmnHIIXws3OEihsEwO4UyUm0I+xmHBBJnTdKyIDUM+LGNX+rs+3ye+srXzvwMb4Mk5n
         jg7038BeY+r42HrlrLGyPUZr4Xt8nDia4uxF2qrSWscxKz/Tr7Spgp2y6ARYqw6BlPQc
         PooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237523; x=1715842323;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rnP8lifwF80Zq93ecat3fo7l4f28X4MCb0bTfRERyQ=;
        b=qrGyU4yCtWUma0xHUwzCRf3fbyGpfkdU+fjAKHGRlFXnurgvTXcUI9PP3RUi1PiV1n
         uA0DHr6xtwLnAwwTIjPG2fm2XDstinG3Q4XRTtE9gIgn7CPRGf+DtG+BV1y65hjSoRa7
         04tIWzEg3bG78Padd8xmhy/TkFwlSICNxsikTfpPaR06QNad3TRIVyWlA4l5F1YUm9dF
         c7hJ9pVifaQJI4bDzAbj1uLoK9Lb/3d0SzgvscM+JGvSZEeV2Uf2W25KP+Zes3lcJ/Km
         Dlbv0Gh8xPGu0OC1UiDrzEVGGb4fy/4Cfn5AOMdEX1zUzd9giJZQWVwYBOyz4xTk1+Ky
         m2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVpN9uqr2i4V5+HyEgz48oEx/478JMNe6I8kzIKdMC0tQx7Z54EuQ+imscWwADREkor5kGpYd8uEEJRYVAU79YVPaKGHbDSCvduiPIt
X-Gm-Message-State: AOJu0YxpOVbUAciCxeselWVRbb/JJgl5lAkxbGdrwy6t8S9gmi3BkvyG
	kqTjH9O7wsuNvMTOLcpQQEgjC+d25hqNOqHDu+aOSJyLqy12uWaXFQE/t3U0Urk=
X-Google-Smtp-Source: AGHT+IFdc13lszpf7lxX/nmLUxwCIGMYlPf62pSkNTQt4xpiimPjtHkcnxTGJfCijKqU+LZx+421gg==
X-Received: by 2002:a17:906:3c08:b0:a5a:15ac:13fa with SMTP id a640c23a62f3a-a5a15ac1545mr60104166b.38.1715237522834;
        Wed, 08 May 2024 23:52:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81b4sm40730966b.113.2024.05.08.23.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:52:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/4] ASoC: qcom: x1e80100: Correct channel mapping
Date: Thu, 09 May 2024 08:51:51 +0200
Message-Id: <20240509-asoc-x1e80100-4-channel-mapping-v3-0-6f874552d7b2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdyPGYC/43NTQ6CMBCG4auQrh0zLZQfV97DuChlgCbYktY0G
 MLdLax0pct3Mnm+lQXyhgK7ZCvzFE0wzqbITxnTo7IDgelSM4GiQIkVqOA0LJxq5IhQwP5laYK
 HmmdjByAlexRtQ2VVs6TMnnqzHAu3e+rRhKfzr2Mw8v36vx05ILRcaJ4TKim762Ss8u7s/MB2P
 IpPsP4NigRqTX2jylLJSnyB27a9AS0hH3sgAQAA
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
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rOxCVpuvUmbACYXpkXKZKRD3h2JXgl6Ma28qOmXdJFk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmPHKK+jVIzjueNuFIpjzLc9l0An3OYN7GlvfDY
 r/bfc0O8A+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjxyigAKCRDBN2bmhouD
 1xX3EACFu/Wuja+nxzB5jFUGdRcGxTyLQNgkhNQkHXBONE9jJdNSUm0BlyHE78b6wPVxwiYbuyM
 kkSxNw0UlZOHUrLn8eSWXDJYVXXOqDFUM5P4TXS3UVPbGguTL5hw6CZJWbDkVTGCgQ7PR1+ghWj
 J64mXAZdnY+BjQ7PPvP5MpxdfuHIrJu0jcNI6/Jgfam0GDcCADhXHzmITQsjZyjAUhKDolhSpVy
 Ln1DNg2myYcHCYSb+eZieOC68XEDzDCb5gkdLL95xe+36rXWVgN3obOsVXys4WSiIEXMKse6Lm9
 NYbCRq/OXov1nG0EFDae55WzY3upKHAGWNib3cGW7UDZ2MUkR7X501nII5BDB0s3SilXNmXmAuM
 sZT1/pufvqXxCCndfx8fwiarp1LVpwMaeHL262ODAcgSY/TPxQsGWjekujtAIVxJ2FRoounknfk
 rLN+umADyowLivtNDX/2rNywtuhhPHKVzMZz/wB/MAU6Ik82b9x0EIPawIkZMhnu8ENg9OddgeF
 LGnFCfSYP3OdxNPG6+Wun3P1mcB5MZmJ3Ujn5nPq0BtnT5r0sO0XkRBDzJSGiIj0v0Q9vte3CiA
 fywMS6aYF2xRvq94fU4wJgfda3xHAmEI7ktV7xD9UWFCOpRfVdk/c0rM9NmSUzf8x7HGzMx4fza
 SL4xj09R6U4NphQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

First patch is a build dependency.

Changes in v3:
- Add missing Charles' Ack
- Link to v2: https://lore.kernel.org/r/20240508-asoc-x1e80100-4-channel-mapping-v2-0-ccef9a66a572@linaro.org

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


