Return-Path: <linux-kernel+bounces-515829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE54A36978
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2043A4FC5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985619E971;
	Sat, 15 Feb 2025 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m82248Px"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990EF13D52B;
	Sat, 15 Feb 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577934; cv=none; b=mAXh3ZUK6+xOWyAlWHVdkoKFHzpq4djE+fNclpy8Eep3yDhsqdmOpvnBT8DXdyfmezSdfL9H/gqFg05M5STk4VbS9CL36OLWvKqijMLTWmze305dX7/9XwUFA1/CAfCvnJ21Nljq1dXKThqmXdhflYC2UCpcP58NeWvrMtbVsko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577934; c=relaxed/simple;
	bh=mhjYn8hCW2F2c4h2yo8pS7w11bq/v5wUZPBY7cvt+H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9bX6hgIqleANXiTwOWA2vr5ssP2d2k8EivtzSHLIGvs4o01PHfLtSF65GZqcXU3S44RESfeIX91FGJY1s7VsEfet5sGICeBTPtKrljLsbYs19T5uuLWiEnWYsfLSaLfiYaITvBtR6Yb86kQmt5b09s7Frqz721pEsX64lB/7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m82248Px; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c92c857aso42456225ad.0;
        Fri, 14 Feb 2025 16:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577931; x=1740182731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRvw5w+5NxuvIevv4OWKoiATV4ce1E+DcjU2wneQoIk=;
        b=m82248PxKMrvk1J6PYsaruasge5fY2LyDVQdH42nCia/OKxG3DDkUvCoteb3bDPSF5
         bUQ2Jatj98noqjZRp/2J8Q0lc373sUoP/5DJLARs1sTWwLwSCxVymnTLyal0ikNvZV7d
         dHKAzLMGBqtJz4YT94wW7s7anWtLk9D3nr2L1mOJ9Cb4igWpFJ+asPorG1g3yCy/SYb0
         JF9JS9oY3/5kAE3YVY/8DW5ucuwdXoXqcPNcVoQPs6uoal4OsS52b8h844OrPLDC2Vnw
         uFTCGRD8LuJGcZOniQjmEj34XyCHoTJRxDuXikzMCSJRXPiSFyXKRUimHiTf3uJwhYoy
         /yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577931; x=1740182731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRvw5w+5NxuvIevv4OWKoiATV4ce1E+DcjU2wneQoIk=;
        b=vBHXX5abqhiJbJ5j6zLWfYsZ2gC+SiwhmSflUjL51lVdR4h8zL9GJDWWyEKjWCZHRe
         7MPdjm08NV50C5GKhyIGrhVHBv3geFe2wsJLVNytZH1IOsd7f5gdcxueT3aZH7uWI+cJ
         5EeAxFnBdF7cn6hJaePk41oQDGhu4fknZMoQ2Fqqd37AX9/J25rdrkWX1+z2V+krfqev
         VfBceRijk3pgzXK4T6n3Q3b2AMv7IQtrNaKv62eNuB/5ESVWERmtJT6ret8cE7wpDfIA
         PoSaXffonXxx8oDjaFTpYhuIDEgY44gFMjqmOwvpuM/BcKY9VZ33qGt3TMrSKCERdUWb
         pXsg==
X-Forwarded-Encrypted: i=1; AJvYcCUpNMIeLXF7YM0NnAOS7xwKeUQ5dq7/cWa1iZXY2WbYkoIz3aw1Pik48Mc2VLHmBWRyPPGFycZEhsU0HgM=@vger.kernel.org, AJvYcCWDR52DtBTWMiVbtQOJvCqmLkRxAS+ar0+rXmdXJ1fdYHur8nNMJLtOwWziUqKCsuhI4qWxQn7w0hx4PoPO@vger.kernel.org, AJvYcCWUqt1CfLrxKEe0P2BGj4Mki53ahkqrW7tlAPhyPeEg5GHpATUrA8CB+ROTktV1iDLAo/D4PUUwIjBu@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQx5x8+RGkShv/QlXJ5Y0CwkmNxjWP2+XZFmo5e/sYIKWCgyq
	h3HPs4YAoEJO7zEpSzXwIJahgwZfKBhC+FxIhSOj3GOf9+7jobN+
X-Gm-Gg: ASbGncsSCK0p12W/UtRxOUAXa5J5XNp4LA+JuSnLFk5JVujeP7BLDhYa6XJSlnRWP7G
	QK/DPJyFqMVkrCbxuywbrXl1BOxh7Dd4hqIYuGH6gpneVZBkUtlXjLc9JgusIox3gFaXnny1eVm
	pHD3yJvRz88JdOkHtLFv6sDyqi7UpAy92uaov7E2s2G1asnqd8r+hFA+hlL0rStRZi8Zw02lIPk
	G46VAXkFwEllorFyMo+Iv2MwkUtg9DP+X/w9yEh74RR3gkUvGihVeik1JMy3cKTWctBpUahsJwz
	NvRsX0lcE25SfAXNCNQn3Ri3RdZlVCmtRNSLBH8tDbKjMWJi2SVxR0bpEf2/tUyneB81bQP2Oxa
	w30sFMWfbfg==
X-Google-Smtp-Source: AGHT+IFAlt37KrLp3aaCLabAYdTxN0gQLkRnHn3SeV4YCP7JDSRDr0QDjrDCqOwzEb4fOtQ9UuqhVA==
X-Received: by 2002:a17:902:ccd1:b0:21f:97c3:f885 with SMTP id d9443c01a7336-220d357a8d2mr155643235ad.18.1739577930896;
        Fri, 14 Feb 2025 16:05:30 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:05:30 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:53 +1000
Subject: [PATCH 20/27] ASoC: tas2764: Wait for ramp-down after shutdown
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-20-723569b21b19@gmail.com>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=7QEQPTza50FPvZwaOcwfVBkqbL5W80ScXX3sqRtjBJw=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb26vdXX9/4Zh5cdt/XWz+fy1pSa/nbFPTk138aWMK
 5eMtn992lHKwiDGxSArpsiyoUnIY7YR281+kcq9MHNYmUCGMHBxCsBEnuYw/E/J197F+mq9bHkt
 4979U69ZKwQzdi2bqWcpvXk9Z4DMf1+Gf+avdIX+Vj0IkpE4dmfGhE+LGPr77vLafnRf3bps5pr
 Dm9gB
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

When we shut down the amp, we need to wait for the built-in ramp-down
before we can remove the TDM clocks. There is no documented status
regiter to poll, so the best we can do is a delay. Datasheet says 5.9ms
for ramp-down and 1.5ms between shutdown and next startup, so let's do
6ms after mute and 2ms after shutdown. That gives us a cumulative 8ms
for ramp-down and guaratees the required minimum shutdown time.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 409c54b41dda41d33e8501fff9de421c98f2541f..bdbc210ea8306ecebf704fe33fbe41083867e1ca 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -159,6 +159,8 @@ static int tas2764_codec_suspend(struct snd_soc_component *component)
 	regcache_cache_only(tas2764->regmap, true);
 	regcache_mark_dirty(tas2764->regmap);
 
+	usleep_range(6000, 7000);
+
 	return 0;
 }
 
@@ -252,10 +254,16 @@ static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
 		return ret;
 
 	if (mute) {
+		/* Wait for ramp-down */
+		usleep_range(6000, 7000);
+
 		tas2764->dac_powered = false;
 		ret = tas2764_update_pwr_ctrl(tas2764);
 		if (ret)
 			return ret;
+
+		/* Wait a bit after shutdown */
+		usleep_range(2000, 3000);
 	}
 
 	return 0;

-- 
2.48.1


