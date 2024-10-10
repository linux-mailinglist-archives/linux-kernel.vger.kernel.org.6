Return-Path: <linux-kernel+bounces-359735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD82998FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB266282D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A21CEAA6;
	Thu, 10 Oct 2024 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRCplQ8k"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6216138396;
	Thu, 10 Oct 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584438; cv=none; b=WEZ0Wh2FJfqgs4JTY/CGoWVYFCpgCeG/ApZM6xLr+5i0hEKB9k5VIIbhOaNh6tUZbuO13rpuRL+qo9IUhA9JmMm/qw/OKYXokZlRfoY6k0f17DtxuiTMXHykH62hgZGG6P5HLEEPQ/X/JRUo3K50L3oi28BUiV37W+c5rjh9Bjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584438; c=relaxed/simple;
	bh=AQ0kR/CdHYq7xnw3rsJ9i4pLf5dT9pWRk+1pMPO0hlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AItMX/I+YXdBODtL4FpmcgcE10s4IpB+8CJJyvNB6yiAMLjPhSyrBPLCFzhnSHdakNBVNfWKaIvMvC1YJkrKD+pzHkEc/zJVWKdIE6uUyVGVwEHsaMlJIUE4zFLvZ++Igxpx1+D/HKKwWae+tYBDMaejank2TLkNG3Bb7HlPUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRCplQ8k; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad100dd9eso13440971fa.3;
        Thu, 10 Oct 2024 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728584434; x=1729189234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnAkawjZqfeZ7VH0Jg0DFYz+xjlN8xdngDCa0VPoccA=;
        b=VRCplQ8k7YwEpfTNDE+xC+RQnOCZsCmg8d8yC2VdXn4NmgiluXSyVXbjvYVWAinwRS
         0EStBxN9M4lDYbzqLeWf/NnYBxOl8Cjvin0+Jx7ooIvSkjXaoQC8C6DnZi/pzi/pJY5f
         Rk2WgyP5snJi1sjGsEXSR3vkZc43fWM2Pi0z6CmhT3zggsXzAE3EWuwW6Ma4MKoDPOxB
         PVNLCzCVnuAbpQgVl25MKgNgtDG7hXHG8CTbtlqYuDzy5s/SALXyzHzlpwuyKRP/XSgO
         uEzxgyFvt9eQeHxeZQx6scK1BkN0pkAb5zApRwsTCiUku+/y/OQmyH4Xskna/IznIRWZ
         ci2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584434; x=1729189234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnAkawjZqfeZ7VH0Jg0DFYz+xjlN8xdngDCa0VPoccA=;
        b=YWvwk5LIpD2Qi8UkiFGvg22XIgWVOHRzwZlqlSO4BOib6s1vamQylgRDgiSuiRrVFi
         srMI0Lc39PT0Vb8vSBwCOeernBcMdIamKaGSLcA8kFQyDUOB4E2rvPSHBhfJcVPC6IIu
         i56gpzY4bwFMwqH170crfUxkYceHL91i2Xt0Ef+fUf1tJCrG5NbWBjZI+pCkZ/NcAnf1
         eoBvB1m+B5Hpun47tSZLPWeFPR8ImU68n+8Rmhe12odsWjaM0NfHf4xh0T2iEl2SwP2V
         9lpzBGeAPFHxCNyEMGPGE/N0RLAjjAB43WXKzPEz4nkZx6lneWBRy3Tfto8QP9r33s7x
         DCHw==
X-Forwarded-Encrypted: i=1; AJvYcCUbKEJP8dvCkehpwXKRXScmmurx/QMI04Xc1764J/wPhDNY0gMkooarwbiJS1/Sk8ua32mKtkUfSEpKW8I=@vger.kernel.org, AJvYcCXzXvg2jILYxZyDKHe9vKr7CoT+Hi/PcDylrR7Nng82ncq6IlzpzkUBdc+OlmnuhsAVYyxJGQTYTb5pvU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYT0XgQWNQdSQLc1I08tNnRppIIhzLsgEfJV1BCrtAYjBGOmyl
	Oi6jovp6kg4BW+neAIbqOzTlA+/FVvUe6XdsL6FNHSt/Y49xrn8+oyiiw0zW
X-Google-Smtp-Source: AGHT+IGfi0DarAWtv5MybSL1H7WiCZ+sBqFN5puLs0NY6kQSdyj0bxg7ojxxdV7ITOUPdk+lSwn9/g==
X-Received: by 2002:a05:651c:548:b0:2f3:f4e2:869c with SMTP id 38308e7fff4ca-2fb188105e7mr42531671fa.44.1728584434204;
        Thu, 10 Oct 2024 11:20:34 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937153032sm1096641a12.53.2024.10.10.11.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:20:33 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Ryan Lee <ryans.lee@analog.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: max98388: Fix missing increment of variable slot_found
Date: Thu, 10 Oct 2024 19:20:32 +0100
Message-Id: <20241010182032.776280-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable slot_found is being initialized to zero and inside
a for-loop is being checked if it's reached MAX_NUM_CH, however,
this is currently impossible since slot_found is never changed.
In a previous loop a similar coding pattern is used and slot_found
is being incremented. It appears the increment of slot_found is
missing from the loop, so fix the code by adding in the increment.

Fixes: 6a8e1d46f062 ("ASoC: max98388: add amplifier driver")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/max98388.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98388.c b/sound/soc/codecs/max98388.c
index b847d7c59ec0..99986090b4a6 100644
--- a/sound/soc/codecs/max98388.c
+++ b/sound/soc/codecs/max98388.c
@@ -759,14 +759,15 @@ static int max98388_dai_tdm_slot(struct snd_soc_dai *dai,
 	slot_found = 0;
 	mask = tx_mask;
 	for (cnt = 0 ; cnt < MAX_NUM_SLOTS ; cnt++, mask >>= 1) {
 		if (mask & 0x1) {
 			addr = MAX98388_R2044_PCM_TX_CTRL1 + (cnt / 8);
 			bits = cnt % 8;
 			regmap_update_bits(max98388->regmap, addr, bits, bits);
+			slot_found++;
 			if (slot_found >= MAX_NUM_CH)
 				break;
 		}
 	}
 
 	return 0;
 }
-- 
2.39.5


