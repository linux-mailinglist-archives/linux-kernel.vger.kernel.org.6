Return-Path: <linux-kernel+bounces-182702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E21B8C8EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1228B213D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE15C1411F3;
	Fri, 17 May 2024 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPU/1mAI"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAE142645
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715989113; cv=none; b=gU1WeE0T5wLZswPJWtcuWvE8qkiWhboR3QbUJO2k3+fbHr1HmD4gA40HLTtJe/LDcvv7fHZXfTtkA4XDRCtiOamK1IhXyo/pP63mM+N7JX9lDbD8zheiXCkWOOVbHdjaMm0/ds3JJjUtgj81MV1wkzY3a7mT06jFc7Jb1k5Y9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715989113; c=relaxed/simple;
	bh=qAGg3p02CzshPTR3Olk+XX9L/LU7qQre5bMGAyQj6y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghz0/5O3qoVaf5uame2xVm4jTkjghwWRrtLr9LzdlFNALoZTBB8HNdeM9ivfCK5vEb5QztJlSjerZ0w+s1dNSLbmZ2KU3zmO65zYQbJMszIiyEbO0Gu4BjHmbaa8rOU+PBq458cjnPWiJQ1b8abZHnHn0EI880TUwYM28Xmf9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPU/1mAI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51fdc9af005so2233098e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715989110; x=1716593910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9H//QTWRYsZ8CFoh3lKgy3kB9SwxktnsEXW1iP/ZhI=;
        b=IPU/1mAI4WK9Om4gGfiYSGdMfHiL2n+ohl9N61jgZ1XZ5DwovcXtPA2qXrcS04AWGV
         NrvkJkahJFuxUZ1YpR/iFf1sCRu1OiNFiNH2qC0/9ymoVatOYF2e90AJAMK4zSRzLoQF
         awmL4yR/ZMCG2nHx+MroaX+bC8JHgTieU/cpIOntFbGPi6zZ4KLvxSy3tjDCWQayFsgh
         Nx4cJFPVcNf47ywzIaF7Dz1pDl5QkzC0tEqksUH8C+zV6Ik/Y9tSu3B83fDFSODzZwnm
         a0tlL/p5/0ER3URfJ9CGz+Nqt5UXANt00TIu6+AievU9FqA6CCZJ9AwUgzJoQ3Ynmh78
         FYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715989110; x=1716593910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9H//QTWRYsZ8CFoh3lKgy3kB9SwxktnsEXW1iP/ZhI=;
        b=e83T/krBY8mZi0QH7bNocpd4HxzzI5Ovmye8AXoRY3YwTRK1myFOD3bsxLayUNUnHZ
         NUmUcpZyvGZosXqMNB3wzkkbPJLmQ8aDmmypb2MDXCLQBP/Oxfi3R7j4rSmKKkzXQG9U
         TBMQsOGiaXSne31HB2j7YRwaoaTg48oXhng5pv0Cy33IvhnptExJA2Y2OxuCMRIx2CKF
         6X6d+qQEc8RZ7OF99quMaXeV6W8cix5tP6nfUWBRqBogxEocm6CBox7xa9MMA3b/xEUw
         Ja3sE8n/kEOT2SCg+xtp503NZmZTHcYKPwIb2Kc/adyqK5du7q501+vaT8Uy3Sja1bkK
         NleA==
X-Forwarded-Encrypted: i=1; AJvYcCUyejTXUl9X9RfV7r50aRV9iikO/xqL/XsqgOJ+iy0HYvM+XtJPtyxJTAsT+RNHM4s5L75qFpizNw+N36S2gGYrgXMrhkVy6u7p3qAH
X-Gm-Message-State: AOJu0YyQhqHy0PM/liY9KeqYWjW+yzSLRprDGSJPw6P7RYyFZr5nfZhm
	eb/SFbEzwbEqR72qkwJ/TQ2JxXUnw6oKBv1A1XpGc+rCilqnFAxfdLpQYA==
X-Google-Smtp-Source: AGHT+IFaErxkK8QmTqIKSlBWlqDGbStWQOEEvoXxfSx+yl+QzEoB9cgAW3Ayf6V8blHmOHuSQHxOmQ==
X-Received: by 2002:a05:6512:1308:b0:520:36ea:9375 with SMTP id 2adb3069b0e04-522102783ffmr23154832e87.43.1715989109520;
        Fri, 17 May 2024 16:38:29 -0700 (PDT)
Received: from michalis.. ([2a02:85f:fccb:8700:ae86:838e:b741:f781])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17cd0sm1156810566b.214.2024.05.17.16.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 16:38:29 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: vaibhav.sr@gmail.com,
	mgreer@animalcreek.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	outreachy@lists.linux.dev
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH] staging: greybus: audio_codec.c: Remove redundant parenthesis
Date: Sat, 18 May 2024 02:38:06 +0300
Message-ID: <20240517233806.36849-1-michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary parenthesis as suggested by the checkpatch.pl

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 2f05e761fb9a..dfb5322964de 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -305,7 +305,7 @@ int gbaudio_module_update(struct gbaudio_codec_info *codec,
 	dev_dbg(module->dev, "%s:Module update %s sequence\n", w->name,
 		enable ? "Enable" : "Disable");
 
-	if ((w->id != snd_soc_dapm_aif_in) && (w->id != snd_soc_dapm_aif_out)) {
+	if (w->id != snd_soc_dapm_aif_in && w->id != snd_soc_dapm_aif_out) {
 		dev_dbg(codec->dev, "No action required for %s\n", w->name);
 		return 0;
 	}
-- 
2.43.0


