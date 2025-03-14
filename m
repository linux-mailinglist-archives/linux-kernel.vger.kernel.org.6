Return-Path: <linux-kernel+bounces-561916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE1A6188C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F431460E33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9813AA27;
	Fri, 14 Mar 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXfqWfDm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA3204C3F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974521; cv=none; b=QRfifWqdncllPsVE2AFpCSiMdjbO94UNCC/KF96nOUF81HxJt3s9+OPty+dT2NQilSMjuge6GHSDq0+FAzbl/YDJMPiMxawcgxDuQ6VFVfXFeBiMNlHrHCD9RO+QX18icAozj9cVeYlEtSpJ7QGli88xM303ZBBfVOjF/AJINB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974521; c=relaxed/simple;
	bh=mDhcxCgdC1Fi4Bo8nQTGMpqT/fTEu0Rlo6oOEAE3xhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E0bmXpHO/a+OsWiXlgpKslFVln2KXqns/tszUekByGY8qz0Gp2EZ/hnpNRCF7xaukBK8vmxeu8rX1GWe2SOlC0fgVvkZZbEjrg2b/IUV2FuLdzF2IQ4/3tSmTYcKcaa3FbR+AkB4UkGjQ4eHZ8pPAJEzUdFt40CNqTdpCz/MXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gXfqWfDm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf848528aso22666815e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741974518; x=1742579318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdTVjAwVNmK2jLxhOXzxyRxn49OEqRRCS+ScTGbOGto=;
        b=gXfqWfDmh+B1szU5Xa0RAATYoSCm5lGgeMqwIDeQB+jdV+yo6hkpOndNHNCax5Y1oa
         rGLvo89PnQfVQyKDvicTfVKhEJiZcX8bXUfinrnm3txJnn1xbQe5r3zTbVM9GetXTvwf
         Gmo1twwUXRJnqTo8z0q1kLoq05jYJCkX0lrqBAuOeMDzV5VVLOsOXZk31yy/bmNjNAfd
         oXDihB0gUzyURfOy7/OaIYxl6u0yEeKT85X0j33Ff8ajytNEgMgnEhlxVvG4W78gmVLV
         BHJPsORyFJhUc9qH6WuQ+afT5KFe0QeoDAVjx1tKqbFCdc1wBsDseisnfrTSQrHh3RD0
         RjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974518; x=1742579318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdTVjAwVNmK2jLxhOXzxyRxn49OEqRRCS+ScTGbOGto=;
        b=rc92jfut9EfEnjq+wmOogCltYEatCy2XkL0GZNXk0kyUHPmWcbZ7JuTRL79IwbxJIT
         +/tbwYjlsWvOpyOKbbiFtyZdfwOYDL6UAZI43K6V9pZjz7+XEmkPKRkJea4m5RQ8UWLz
         O5iWcepHvymNS9kxYfESXKAbqVGO6vgYrlTANpzG9BRTbi9bQHynrWIEqA7ceZbK/Gvd
         H7rgmb79A4CVYR6pvSFkUUTR5ebCxhRBjs1jS314qeyQYtK/MJLlPgJyjZP7IUyad/3O
         nHLr1ta9Aw0sktydnwl+Rz4wu7erOLAT78BalHpDhqYszk9TBugaJbxVON6xUqmytWzp
         MRgA==
X-Forwarded-Encrypted: i=1; AJvYcCWlDN99FnZZ22UWYbfAB45etOWpd81vKMBc68bFrfB8gn1NWyK5+0rL9bJgJ8tsodtsEAnoJRCeWeCUtmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkPFjnfmS3XnhbloLmnI8fvBiouDXrjiJ9hjb5kvf9NryxVKM
	gYYY+Oyv/V9ZAIJKGYy59ccc6pD4u0JvicANSD2Jywgaq8WWkP0yK43k9DK1hHk=
X-Gm-Gg: ASbGncsWc1gP5MZ65w4xAMC4bOmvArD0XrRmYadDWnF7s6HdoAuMWl12TLGFdbq7jTo
	hYUUX3Tzj7Q+7ohM0NFz4XPPoOHMt5g41w4DbjKjKsOHZ8XStJYqaVGmq1hYauAzx6gXqSxHPJ0
	50qPfJyARrcWVo/bvV4zVY4I71obuibi76UFHhr/Zzfkrg1oZErq/ym5cn9Z8nvhGIjtzQsPekK
	m1ofH/5XxHO3g1mJHcVQjBDHZCq40mrfrLqCSwlM8d3FeAcG5DRFVMbMNBg/BR1Kxg6APGTi+YR
	//f8+cOHFZ4RyYd8BMZy8QmoJ5l894dfmkgzI4Sq4xGggvK1TVzpqOxJ7F1VBGhisErPzQ==
X-Google-Smtp-Source: AGHT+IGcUNko8z5XQMYL2/1B8FhFeQVonlKSYBeZ53undzrD9L8aOYiUUqdt7GUF3RfwMi42lXGfRA==
X-Received: by 2002:a05:600c:1994:b0:43c:f470:7605 with SMTP id 5b1f17b1804b1-43d1ec80e5cmr44898745e9.12.1741974518070;
        Fri, 14 Mar 2025 10:48:38 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975afesm6117243f8f.47.2025.03.14.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:48:37 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v5 4/5] ASoC: qdsp6: q6apm-dai: set 10 ms period and buffer alignment.
Date: Fri, 14 Mar 2025 17:47:59 +0000
Message-Id: <20250314174800.10142-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
References: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

DSP expects the periods to be aligned to fragment sizes, currently
setting up to hw constriants on periods bytes is not going to work
correctly as we can endup with periods sizes aligned to 32 bytes however
not aligned to fragment size.

Update the constriants to use fragment size, and also set at step of
10ms for period size to accommodate DSP requirements of 10ms latency.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 90cb24947f31..180ff24041bf 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -385,13 +385,14 @@ static int q6apm_dai_open(struct snd_soc_component *component,
 		}
 	}
 
-	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
+	/* setup 10ms latency to accommodate DSP restrictions */
+	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for period bytes step ret = %d\n", ret);
 		goto err;
 	}
 
-	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
+	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for buffer bytes step ret = %d\n", ret);
 		goto err;
-- 
2.39.5


