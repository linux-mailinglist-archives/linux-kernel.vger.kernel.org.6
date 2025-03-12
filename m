Return-Path: <linux-kernel+bounces-558321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB08AA5E456
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8B217B9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2174258CDF;
	Wed, 12 Mar 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yF0Wr/YT"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574122571CA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807657; cv=none; b=g0X9dfbSH5lth8JEl3GjPcIP9xD7u0XoiFrHFjyR5wM2AxeAAqX+JOU8otUfhyaH6AmwPGAW7tIpkzbCbE592+Wh6/PgYUGT9VqMD+4WNjnv/ruOANwR7VvlAIUNn62zD5+mD/qB68ePZjGkeyYzi0CK4XWo4hvWWdsZSDwUp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807657; c=relaxed/simple;
	bh=8J3A0ji22Y6h/FDPK1qt+T9Apzwb5fa5VQDP9nUjmp8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=to7bo3YpfV36wKoCN0R7Xh+Hhlmham2UzRTPZQqy2x/cZQQU4qQMWaSsSkVbbqI10xqV8dUXEzd82L2dogvcLe5SP40k/i2aHvdfvUlSvKLdFPwlYuxHvoJmR1rEa2qnASh54OHOBhpx91Z434s4hApJblMK/aNZQdcZXdnAxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yF0Wr/YT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf89f81c5so170235e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741807652; x=1742412452; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qNFJ58EulLJjjDnGlinq/XAWc4oXkkPOMl7PNRBj5M=;
        b=yF0Wr/YTsmak84RRHrPibwn2poRCOulMcitW8LTSLzzP0jbZwAG30BLhPBd+H0iLh8
         /3z56NyNlu3s//HR1k6oMpH6CTt4DF0AO7uL+PcF8R3BuQKZBGv39SFOHrUgbuRuqSWF
         U38O1Tgh2Q2yjMZL2I/wvo3iyTYs5sq6z9FNXNA6gjkHa5dcaCq1lbCb+CdXMd5DnbT0
         LQDC9BQQ//VZtEmYiWydsuwUrgThw+U2kkMBWLkKk+/SxOwiFoV3/Z7BdxPkFEU1vRYH
         kRu2xT0Y4rFjvlh37EtoDG8pIPhL4+HI4b9eN+Dk0PhHyAAGM4VcUN5Z8/8IGb1i2Jg2
         GGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807652; x=1742412452;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qNFJ58EulLJjjDnGlinq/XAWc4oXkkPOMl7PNRBj5M=;
        b=rYKZ8Wmk70G+EM8XK/ZhZA0MVdxTxrjyUAqiw/uOtcrIYDqwo3hBAZdbakBJyqnkS0
         ZWracPYVwuXg3ERqnAurOygkJ/EXohJYbRcOzW8u44lj5ZL87Nbub5tmJtUyzWUtdDeF
         RFxalhujOmxGxyur8iZsePXZfDU+jSYLe1Q/Up5GVUe5u5VnZCFKk/bsiR+cW++jv4aQ
         j7aFgaWHzyICGKIBsDJpDqF72A5HIyW4PHmrrzG4tdbowsL+CW5XSDkoWxhDIFspU1C7
         p5AS79yhMZSPbjReY5y2YVyZoCvWees5fSFJDg6YV1ahcIVLsKAAMTxoY9htiGevSEry
         393w==
X-Forwarded-Encrypted: i=1; AJvYcCXCs98ujsILPYDClUVzwFwVpCfEnX2+hnuA/QVhItlALHniYP9S3MAxXE+S7CZVg8ImFz/tW288+vSnaDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mDdyGzrQq4TnLLByBp8t5cs4nAO45uTxS0c7q2s7X45FzRkO
	UXzej8EypkNywn+LtSdLrADNeqxtL+QVoIViu+0mYteKGYuOHi6Efh2juEn/pT4=
X-Gm-Gg: ASbGncs6yZpLwF4ICTQNSijKVcFoFL1bJOI6/zCZnZ+gSsufG4dnROn2EiDYM5sIDy5
	VoTp7oiubYUuzGYo2RdqHuMzjuf9u70BMggrUFVQJAimJoZYHW+sFApBi6bJxHvJ9PS38ejpptQ
	aG/+5oucLpG8jqfV172J6UUvEuKw9/jMUV/UgXeSAveNhGIIiDBGi8G8F+7D0ax9JyvXlMegC9b
	KkTPGo765ltjCHwqb0egXZzcP4S2QwUZVw5CpUkUxMq/Zgonm7oBeQBcI2vYdimba1W+C9nSsQZ
	6mgqfRolBZuGCw5USpW6MQgr/btzG5VJO2ymmuv895vs5qdMbN3wNysaDZY=
X-Google-Smtp-Source: AGHT+IFc4gbHbMQDr8/rSMbHEP9yPiMBWXiG9ezpmI6xwNwZDE9d6F1rlpy758Gz8IvrBC2ZvFtPLw==
X-Received: by 2002:a05:600c:b91:b0:439:9c0e:36e6 with SMTP id 5b1f17b1804b1-43d01c1fa4dmr37678165e9.3.1741807652636;
        Wed, 12 Mar 2025 12:27:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a7903fbsm29331995e9.32.2025.03.12.12.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:27:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/2] ASoC: codecs: wsa88xx: Correct VI sense channel mask
Date: Wed, 12 Mar 2025 20:24:58 +0100
Message-Id: <20250312-asoc-wsa88xx-visense-v1-0-9ca705881122@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIrf0WcC/x2MwQqAIBAFfyX23EIZRvQr0cHsVXuxcKEE6d+Tj
 gMzk0kRBUpjlSniFpUzFGjrivzhwg6WtTCZxtimaw07PT0/6oYhJS4+goJh/ba63sIsnkp6RWy
 S/u00v+8HiW9BMmYAAAA=
X-Change-ID: 20250312-asoc-wsa88xx-visense-e5cfda65e2bc
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=716;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8J3A0ji22Y6h/FDPK1qt+T9Apzwb5fa5VQDP9nUjmp8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0eAdaFsakhYnGyr0q1TLAq6ZqOsdPYoG7LOWa
 ZlIAIQyU4uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9HgHQAKCRDBN2bmhouD
 1y/6D/0UdCfnE6ub6lMVKwcmd6uyIO+GVsH8EH/FlIcPCiUsJItZyWD48h4T16L/+HJKqbktC1u
 gjg5G0sACnZK8+pn47T6lOFBApvpjffw6b7u/d9oeiydL/Wc5D+wwObX7APc0Z46Yt5SD26MCm/
 FYzaHmELKaR7wWbL637UnVsdtajjpSDbXROHdKdveGcT/YcR30zGTD8nBwaSbQoffevFhXcNXek
 e312VtHcBeH8Y0QXuZypSStCp2YFchpvqZmGB/F7Y6kpdN95s8wOejhIZSGRTHgSsLLSW+4d4mw
 6jkMmdXyaFr1yPYHHcLa3d+iAGP4ME4jBLr7ZziygOO34RmJCY24pU4Kzfu5OixefL7Cl42Y+jY
 ek/VfEu2BasnacQWC2irbPBht4pu4HuzbKiuTeiJwzwA7rSwWCaRXxfmZVnI3sl1/jFp0+PVmHI
 dJ4YnY/EStueDh6brMs6rces6MMjwNhrmj3UwaQw3Ep51KthTlBAKmwPgJLLhrSaCw2GBrR+7Xt
 WYJOilkcf0qxmsEskoKdl0TqNtO1QjoE3vr4kG0rGemZLlZgWR6Mrh33VD/gl71qR48016CYXhP
 6zJ1nbJ5SfuhEMJzoLPZvLy9CTYApHhqfRhJdsPXK7ICXehEy6zUyroO9rY+o7UjMWcJDY0vmaj
 3UCHKE5FI582lKQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

VI sense port on WSA883x and WSA884x speaker takes only one channel, so
correct the mask.  At least this works during my tests on different
devices with both speakers.  With original mask (0x3) I get
noise/garbage.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      ASoC: codecs: wsa883x: Correct VI sense channel mask
      ASoC: codecs: wsa884x: Correct VI sense channel mask

 sound/soc/codecs/wsa883x.c | 2 +-
 sound/soc/codecs/wsa884x.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: eea255893718268e1ab852fb52f70c613d109b99
change-id: 20250312-asoc-wsa88xx-visense-e5cfda65e2bc

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


