Return-Path: <linux-kernel+bounces-213053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4E906A67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB2F281EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423EC1428E8;
	Thu, 13 Jun 2024 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXuXKW3w"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7DE13D534
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275784; cv=none; b=eE5ZjPO5XxyN0ibxUiLlU71LXoSN9mZqFya9VE9xqzS0vMOdBOdpqoGx/pNFfQepAZrFNkagiZsECBkfM9M/owaBRLVEBe5wIYyGdssHJpnhdkM2z8vT0oVO5ia7AXFtoZQJr5MQjMnx4gg3gqfKq33dh8gYQDa7dVUhZo5nJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275784; c=relaxed/simple;
	bh=+l6WJNOuxbQP3zRP70rVUTm7ts1MNeRlz6RusiQ+0No=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mLPU6UjvxE0BbpTmTn1yM+/WBQSM6A7StJ0hBbpz0tOJ1jdmsgK2a82ReiBDaxQ77fepeigEYdU2mgpt/hUNBVLuGFgXPThF0INlkwc8jmg1zqbL/6pPnH8dAMJclRFvwOEGQllsvF9CsWyv7EtPoTeVZIzSucrLHfIh2jwXEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uXuXKW3w; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so827458a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718275781; x=1718880581; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UgbuPMjPxJhzEz9I4WN0wVps4ls2iJnyduYLx7mBuMk=;
        b=uXuXKW3wkJ42VEaKpfxKvKeCX+UWT7LoQbgNUI4EEJRRM5jq8vpsq4EmTlC4GsMMzH
         IPNvsifIbS36/7IRQOQFbaAfGrK2dBURx+vPWDti1DzAcqqd/rCPSCQ1qUAgPqGb6StP
         7H3oAhlE6dt2ffaALEVzPSVxS5fS89IVpCl8qgzTSP78kKWR33NGEAY5rxoYpn7lwNg6
         UYOm3D307BZ49VhmXBzFsxk+GHyvLGhgZfOuPUGNLq/AoZoiuPqE/C3L4xEL2NPvYMW0
         bEIiuR6wiC7mXuODCX8Y9Y8/nkvTVu4kf7JKkcxy18xUv8VMRnFZ3NPEed99zwDl1qUK
         vkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718275781; x=1718880581;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgbuPMjPxJhzEz9I4WN0wVps4ls2iJnyduYLx7mBuMk=;
        b=vV1CbisW2K0hG2GnJeOnL2yF1D8B4QQeyhJ8yXifLwFCbVM5/VPcUDiTTEyS5nVNUu
         npxYef9ij7WxhNia4gjv/8Dbaip9aa3xildKXKEtq4rHWOILOWpIx+fZ0yDx0xLNwrRP
         50NdTQpHR9uAmieo9lOCTjxmx7e7vE2sR0j3UEGAXNmaYCrmJBcbYJyJxPXavuAO0Bbh
         vvvkH60FY5aViQakVPFYm672U9lWpOmwU9EfaNicznXHFsgQnCo6YzSfD8X3N6aVvTrf
         2r0YimHuqR9/wVl8uMWL/keqih8s3mSLwLCio36Z9PtHKMONWoGY1O5kP7HncGQOzj1h
         FFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+vQVOAsSBD6WCVBSAmJGSQdTRhnppPbuTaqeEr7lE/hBdgnWrXg+ch7AdTLZgyu9dbcO4jtYAtPOP5Cq9oMN+9XWZbEs3k94RJoDh
X-Gm-Message-State: AOJu0Yy9oACKIWj0+RXEKpT4MswcXPrQ7OsnR69D03S9qLBkDTjRwS2w
	IXX9LKSnMQ0uXV6Tycux8aEz9wqS3eLhDtS6rW70wDc2zmJrTPHmhd9DbzfdJBQ=
X-Google-Smtp-Source: AGHT+IFHwP8nwev4WWa/7FwbekEhqhyDaz1iRXFB4BQJtqM6vA4I61TqsPRsq0r9s+LAnXChHJ1QBA==
X-Received: by 2002:a50:9b11:0:b0:57c:6021:f198 with SMTP id 4fb4d7f45d1cf-57caaac819dmr2501275a12.36.1718275781030;
        Thu, 13 Jun 2024 03:49:41 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdf2bsm762618a12.17.2024.06.13.03.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 03:49:40 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/3] ASoC: codecs: lpass: add support for v2.5 rx macro
Date: Thu, 13 Jun 2024 11:49:30 +0100
Message-Id: <20240612-lpass-codec-v25-v4-0-f63d3676dbc4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALrOamYC/3WNQQ6CMBBFr2K6dkxbsQZX3sOwGMoATZCSGdJoC
 He3Ze/y/Z+XtykhDiTqcdoUUwoS4pyhOp+UH3EeCEKXWVltK+2MhWlBEfCxIw/J3qCi2mlsO+d
 Mr7LVohC0jLMfi/dGWYnLsTD14XOkXk3mMcga+XuUkynr/0gyoKHuy2nQXO/6OYUZOV4iD6rZ9
 /0H83fv6cgAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, 
 krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=+l6WJNOuxbQP3zRP70rVUTm7ts1MNeRlz6RusiQ+0No=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmas7Dqes4b90n0wAJkFEiLP+ISbj5qrO7qZFVy
 WCXQYnRsVqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZmrOwwAKCRB6of1ZxzRV
 N+oaB/9yL3y1fzKJc2j4DPoJNV4R9zOBp/18qduXWCqt6vRhcOGh+48/XrxiM2vqlkq4ohqipIc
 2qWwoEFzQIe07WX+L4EVnd9CaphcacorM5ZsNQO9dXy+YsxqBNubEPQFbwq0JJovae4egl0bXi6
 oJ/fskYTyd6UjBEk8Qs5z7oetkxKVZEPWW0dd8YE+m+ONmHIpsT7PAw+tPnmQ0efhJeBpxSyr+x
 tHzzgOqNY1HkjjQWAL3FJNHr9L83zX6oYaox1S5OWJ0CgtonsefcWToEZzElbeLhufzHq8DbyIC
 mjoAEtUGTAHCpK7IzZz612M4Ambnl3xEeEACcntGTRXuApmk
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

This patchset adds support to reading codec version and also adds
support for v2.5 codec version in rx macro. 

LPASS 2.5 and up versions have changes in some of the rx blocks which
are required to get headset functional correctly.

Tested this on SM8450, X13s and x1e80100 crd.

This changes also fixes issue with sm8450, sm8550, sm8660 and x1e80100.

@Neil Armstrong  can you pl test it on sm8650

@Krzysztof Kozlowski can you pl test it on sm8550

Thanks,
Srini

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes in v3:
- moved dev_info to dev_dbg to print codec version.
- added explicit cases for codec version checks instead of using
range
- changed err handling.
- Link to v1: https://lore.kernel.org/r/20240612-lpass-codec-v25-v1-0-9f40611a1370@linaro.org

---
Srinivas Kandagatla (3):
      ASoC: codecs: lpass-macro: add helpers to get codec version
      ASoC: codec: lpass-rx-macro: prepare driver to accomdate new codec versions
      ASoC: codec: lpass-rx-macro: add support for 2.5 codec version

 sound/soc/codecs/lpass-macro-common.c |  23 ++
 sound/soc/codecs/lpass-macro-common.h |  35 ++
 sound/soc/codecs/lpass-rx-macro.c     | 595 +++++++++++++++++++++++++---------
 sound/soc/codecs/lpass-va-macro.c     |  28 ++
 4 files changed, 528 insertions(+), 153 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240612-lpass-codec-v25-4e960abd661f

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


