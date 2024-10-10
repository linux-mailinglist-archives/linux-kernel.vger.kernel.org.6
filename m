Return-Path: <linux-kernel+bounces-359674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F990998EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1337E1F243FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5EF1CF287;
	Thu, 10 Oct 2024 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="3Jgul8jO"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FE1CEEB3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582709; cv=none; b=a83XxuWdU7aCBB6lEmEifstMkhAa42DYT5zP+o7l3J7qMjklEl4zj9bhwicrHS5zs9cG0udT0HIf0d3m17XRLZq4eGFWRJA7TOh2f0Eu2YEr4Q3skGDiYpP6dreCsWxgNjpS7KIq9DSf5wHUHhqpd4NpnnsZEiLBvSfudpdzKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582709; c=relaxed/simple;
	bh=UJSZFYvRctXI6GJz7LSK7kgB9Tp1FqTUY187+BR/Ba8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/7jGcVLzswUjmey4UFDCuvvUB4d6viVyZ6xw1XXPyVXydC63/gKkg96/atbROD/h5AXZFPiY9XMtNf2kN2RNe2yKa7WRPssJbQWVk2zkAxmC+HfIIoWXNgFr5auI5wsuDrPJRihnW+WYRItAzcHjI9opyGbKtcyIrRAEBSDrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=3Jgul8jO; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20bb39d97d1so11229465ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728582707; x=1729187507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csIVU1oc3NWcT8E0sSB7eGgEyy3jd+R9S7E8JN2nK48=;
        b=3Jgul8jOxWtdWFUM8gB/OYYdJdWVbIvCcnHhT6+jMY2GI7N2Pza4hdsEH9GEujv0jl
         anCb3C7XiWZiyvtCj01HjzWdaZu2S4UM49LrQeh6mJsPaNSSw/mzP26W5K6EvX0zkMWL
         rbnh/qHKekT7IPYRixV84gSrU+zSjQd53pzpdDLXq4mV1vC9oddEKO6Q2ykw/Dk91mps
         JBand1vZ2hVJ3s5Me2ZshGCVH+fsHr9EPZ1z33IjlEnWz3ACwXS4D4+5Z22TpN83VqgP
         DFK3Sr3dAlw8nnItfZ8G5Rwg4vqwPa6olGvZd7U5yQeLdcdkpCT81F62uDKk79rFkaob
         OvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582707; x=1729187507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csIVU1oc3NWcT8E0sSB7eGgEyy3jd+R9S7E8JN2nK48=;
        b=sQQNZaG4cQukOl4SIOHnbQFIXw323bSuEaAzoth8XA9nqfnEvgv+NJjjj+MnGb7nCM
         KkBgSGjThYmMjSP7NJHnW+VX5iR7NtkleYQ/XjvN1rnzlRxdhmvL5jdLSyNuti+TaFGu
         l3XaYCFOR97XvMHB/no0mYNvjn8Z40yDfPxQ8djS6/VyR4W2aTOFYr4u1eMOm8bHpOdd
         dBjTG2qnAA6PbvPFXPn9yG3Ac2C/XSSnF/KVec0tPEKjyQszcY6TV9zwLqaIVw8eGgHp
         LN9fbyxbltWh723EdTUc8Gkv26FYhDkDIs3LSpjYkHfnWciV+mlrIBRvS/+qG290XSl3
         C2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXIhPubUUiW6QGDX0O0959szIPhD2j4byHklAnNH/JyEjqtmhMf5vzRphABJkomxfjqTTWj3FOp0hbAMvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbx4qnuUQ5IqG/YISlkDlBEtKIGd1IoHLEvlr+wLy4NncIzEvB
	PFTRLCHhBsewRIUYvkp/79Rp5jPTUJzY7L8zoCg2bKuPyXZBgKXObz1xpJcuGKQ=
X-Google-Smtp-Source: AGHT+IEliYQ2vY5alTul/DtuqR/MXBtKqCl5haGquRWIHTiKT1ggtignHxaIZxZft39sb2Pf9aPzQw==
X-Received: by 2002:a17:90a:cb01:b0:2e2:c406:ec89 with SMTP id 98e67ed59e1d1-2e2c63551e8mr5170125a91.20.1728582707484;
        Thu, 10 Oct 2024 10:51:47 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.16])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e2a571a2ecsm3906665a91.33.2024.10.10.10.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:51:47 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt722-sdca: Remove logically deadcode in rt722-sdca.c
Date: Thu, 10 Oct 2024 11:50:16 -0600
Message-ID: <20241010175017.5215-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the same condition was checked in inner and outer if statements.
The code never reaches the inner else statement.
Fix this by removing the logically dead inner else statement.

Fixes: 7f5d6036ca00 ("ASoC: rt722-sdca: Add RT722 SDCA driver")
Reported-by: Shuah Khan <skhan@linuxfoundation.org>
Closes: https://lore.kernel.org/all/e44527e8-b7c6-4712-97a6-d54f02ad2dc9@linuxfoundation.org/
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 sound/soc/codecs/rt722-sdca.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt722-sdca.c b/sound/soc/codecs/rt722-sdca.c
index e5bd9ef812de..f9f7512ca360 100644
--- a/sound/soc/codecs/rt722-sdca.c
+++ b/sound/soc/codecs/rt722-sdca.c
@@ -607,12 +607,8 @@ static int rt722_sdca_dmic_set_gain_get(struct snd_kcontrol *kcontrol,
 
 		if (!adc_vol_flag) /* boost gain */
 			ctl = regvalue / boost_step;
-		else { /* ADC gain */
-			if (adc_vol_flag)
-				ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
-			else
-				ctl = p->max - (((0 - regvalue) & 0xffff) / interval_offset);
-		}
+		else /* ADC gain */
+			ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
 
 		ucontrol->value.integer.value[i] = ctl;
 	}
-- 
2.43.0


