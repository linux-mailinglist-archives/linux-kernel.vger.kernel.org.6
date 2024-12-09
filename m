Return-Path: <linux-kernel+bounces-437429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCF29E931B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BE4284D64
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC321D5B7;
	Mon,  9 Dec 2024 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+P+mljN"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE16215182
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745644; cv=none; b=q2vZrX80TOtJ5l4xtX03KAVoUhwrPx3tqcDimcQ3773BBjV3SyvTnDvh5ithfTRrQm4gAmU1HRNiK6IduP5kXqYOSxWR5SOGNw52kRRY7+iimPtzwn+pHpD/i7b5lc64Uwf9o0Gj5wIl6z+Ln3B8Pvzrgyv+6yNVkN8JZyrsqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745644; c=relaxed/simple;
	bh=pKQFOgVvHvF8uRLGx48niqw4WYJuJEP0QbflMT7oLXc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N8zamOKpdmAqocHuDbYTMLFZTXI+t4Y2AIfL5eHoNxYK6mar+/TgiQbTN952XmE9bBIlMblFGFZmk5P+I6OQhnudkAQei/Hp/hXkxtoyI+F7K535zb0cmuZD4lGJqK/dB3PZPOHaYngN6aj7y9qPy0jBNcglDVegksyMovlWUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y+P+mljN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa67773ffd4so21750066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745640; x=1734350440; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eF65SP8yB+gSSGZtE3l7QFu2YELZzCe75eNTRt9jHx8=;
        b=Y+P+mljNjLxnpwahK70kkdSffmGkEt/6dxtswdFI2j9kkNh77bacJMm8P/eukGXhQg
         Xpk/eBXEVUQMCeobPw1smFWnWfD/Kw4ygKj2hNYDVaGxub8pfseeDCMNTE0DJZUnFBOT
         5iTAUX5ur9/kHY7KJIUpidy8k5d6LeIRvFoAQ7dBNMBfYIbBuTL3eJc0JBKFedEqKeBq
         SMxlQGOYktbzftby+96UY8IwP9EnP4NikWabLM+UmR9lrlz3VNLSiIO89CcnOZu257JZ
         2vHr9xitbhJHD/FHMsyKC4Eo+s65IgNtyoTR0p7YIbg6l9PERDh+sljowHm4yU2xtyWt
         qaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745640; x=1734350440;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eF65SP8yB+gSSGZtE3l7QFu2YELZzCe75eNTRt9jHx8=;
        b=pA5lkMEGzRNc4kaumQXirKB7oUZqtKNH72IR13jq65pC3ozgjvXHY+NnSmmdCcqBxp
         UeETID+cJlWg1VSq5GBTTjH69bQxjWFZf1lFhSkzhmOjEDss2yUgdZSXuOnFwQtAZEV/
         GLE9MXpLVfFzLmIqCByNHAX/vf4xPfGy1ZBPUSDuOFWuHAWW7llKr4tdGDvhPvqI1VqH
         ZZVBbyIPFFsAey7+QtSuZTtauqYpWC5hWTrYp90Cg347+ByaG3Yz4W/1cwaDua2B9rq4
         uBq4+pr6bKlx+yCFHRciiEiewOCcUIOonVYIU2s0qI/C5zZxig3ve1v2RJGa7dIXfQiZ
         l62g==
X-Forwarded-Encrypted: i=1; AJvYcCUb9642R2aV7dpVdzypTsxvs91yJf4dnXkMS9p3dj9nlQmgtxqXEuvJ7At5tq1usyT1qWOqQUHfK29MB24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2mHzJgzbY39Pm12CMyPpa9ihgpzt8E6abNDlUj9mh6gFzS+S
	7ZmCMybytn54arYHkRanrudaBw/rsmkwdFLe7oi/MqnU8zpkpVeA7UZY1Ltcn7k=
X-Gm-Gg: ASbGncvunMe8LfHGBUDQoytZsnxSiFC1cRcir9EV1owv+Qd5So/g5gu1Q3H+7aadp11
	2ZndVJ0mth120J+j7T0QKR2oyYNtnKzB1RuQOmNu8dMJZntczVXQ38tkIUigtkp+kbkahqSZ6/E
	V/dckYpBsM8G9xq87IbagY+Lv8J+hKlpTTiTiqsTG4HCqANUpc9m7Nd9wgIeoLNsxpWZ8pZseEN
	w8c4aYamcnfvVhRIWOVSOvNKJbFSzFwRuM0OgKTuBB5Xq2FtmebRqVq0EpxFiUNBg==
X-Google-Smtp-Source: AGHT+IF+WpItAHMZCkCObJQJIUQLG8YPpxFC9UNwLpAHwB0jPg4phO2uDPMZqJ8G6UoW8qNnR6UVkA==
X-Received: by 2002:a17:907:874a:b0:aa6:35b1:5c02 with SMTP id a640c23a62f3a-aa63a207324mr463930666b.9.1733745639874;
        Mon, 09 Dec 2024 04:00:39 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e33f7sm678589466b.183.2024.12.09.04.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:00:39 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND 0/3] ASoC: codecs: wcd93xx: Simplify locking with
 guard()
Date: Mon, 09 Dec 2024 13:00:27 +0100
Message-Id: <20241209-cleanup-h-guard-of-node-asoc-v1-0-397f6385e4a5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANvbVmcC/42NsQ6CMBRFf8W82WfagoJODrI66GgYCn2Fl5CWt
 EI0hH+34Qscz73JOQtECkwRLrsFAs0c2bsEcr+DtteuI2STGJRQuShVhu1A2k0j9thNOhj0Fp0
 3hDr6FqlsBJ3oaGVBkBRjIMufTf+CR/Ws7jeo095zfPvw3aqz3N7/ArNEgSrLz40pbFPY/Dqw0
 8EffOigXtf1B5kqpWzRAAAA
X-Change-ID: 20240823-cleanup-h-guard-of-node-asoc-e8b0e6e5f17e
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=915;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=pKQFOgVvHvF8uRLGx48niqw4WYJuJEP0QbflMT7oLXc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVtvjbwJgnPu6xyFntGnwH6PN4A/jgSTLBwwn7
 SiSkqIQd++JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bb4wAKCRDBN2bmhouD
 13sMD/9XTivHVWPlGJKUfe6Nqb6WDJFokIWNiYlxlnrcJXqXpgfe8jKCKlWERvRcIu/0p75JQFz
 kMD2FVYaMLCGCDIpjL3NdTMxko2iKVnhPNQ1li3tVLt2G8TSMIGNMToc7iN/mwnMQvPwTrzClUg
 +Xq/vmY1s5UVDKlhd9Imw/1phgspQKBdG5rdj69TKEnWiwYMfuw+CUzgi2awY5cyYLQQqNHR8TP
 v60NwIPhJjHtqsWUoN5/6wd98Y+iwfveb+HVsndgebg87BKTta142oDNZvvDGgvZOtt0eTg+Kgc
 Yv/KUlA5Wopj7KeSaWuh/j2BHnWa19wz9C/eIWTeMP1FOVvbpujk0u/lowwpfXHymyUMNNv11By
 bXTj0QHemM/6rITgc05LQc+6AjReGILAcaQxIQhZNczHIu4agikfXDaBYnFsDCrzu64v2Vuxuq2
 lfQelMybv8Cvpw5nQ2rMTIdq4xkkSlkl3yt2sDn4oz/+qSEIwlXCDCUmB6ADQq+GLIg+RE8CNDh
 gMA3BjEX9vupVjl0gFinn1rsbKYiW2h+kftWC9CqEQv6j0TZ9G0DpGGdag0dhe8R7LvFP4t/van
 iyOLCftsEhOpjrQveISVZrAtzUYThCI5/Z73WvAbpCn/l7/tP+3ozRpN50JdvNEYdzykf46301p
 pSBomVRuQ3kbZdQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Resending, no feedback. Previous:
- Link to v1: https://lore.kernel.org/r/20240823-cleanup-h-guard-of-node-asoc-v1-0-2349bd7fb7f4@linaro.org

Simplify error handling around locks with guard().  Less gotos needed,
drop local 'ret' variable..

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      ASoC: codecs: wcd937x: Simplify locking with guard()
      ASoC: codecs: wcd938x: Simplify locking with guard()
      ASoC: codecs: wcd939x: Simplify locking with guard()

 sound/soc/codecs/wcd937x.c | 24 +++++++++++-------------
 sound/soc/codecs/wcd938x.c | 24 +++++++++++-------------
 sound/soc/codecs/wcd939x.c | 21 ++++++++-------------
 3 files changed, 30 insertions(+), 39 deletions(-)
---
base-commit: 0dd030fe5c2e08b61920b0e6e86214ec9a5442cb
change-id: 20240823-cleanup-h-guard-of-node-asoc-e8b0e6e5f17e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


