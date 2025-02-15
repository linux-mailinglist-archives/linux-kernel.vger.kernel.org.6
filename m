Return-Path: <linux-kernel+bounces-515828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64E9A36977
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E85189052E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB6019D897;
	Sat, 15 Feb 2025 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5ddtGoO"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D851C4A;
	Sat, 15 Feb 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577926; cv=none; b=VT62eWGlobvNLA1e3l7vu/ItURTDB+pte9Znmg2FCm/nYuermxVmW5rGTvIvS4JvGx3FdnYfjbxXPIYQI7XlWWulhzqE6CsEhAM2ALAt3SYhxl24tSuB0JEUjeQ0CaI7NmY6eHUeizuW1Lyf92xIBneloe8JbJ2N2EMnU9Ifnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577926; c=relaxed/simple;
	bh=PgPFLwwP8g98bJUED+moaf3Y8c9mYSFzQVbyN/AZze4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EMpvBLnhlooNK3WXWIkQznsexoKdY6XW5o1NgXU3GEbB2N+IBK+savGXs7krt18zZGkKbxdPwphJ95Vqe7E2vAmVe7iTTMRF+G0UfBA2byKuIdWUJ4/lePcUAMTRMLMR0Ihv+mn1cOkzqa25rkTYsjMTcZwPviy9wc1leP6Ji00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5ddtGoO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220bff984a0so46107035ad.3;
        Fri, 14 Feb 2025 16:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577924; x=1740182724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPAvKhgJ+unXUmEQvWMbvYBDHLwzjFI865XBH7Bpkw0=;
        b=P5ddtGoOzHRjhcpaGTxQDV/mYne72/Lma2tE/p8aaXNZisVncm+Jo5d4dNM8sxQdE8
         K0PC+izPJ+IffXVYwOgCMT7wPK2hLvw3Oa3GClDHjd5UGVQT1ynWhjvtsO+qG7oG34P3
         rMQPYnCzWUzy2HzW1TpKrRgwTN63f2behS2Cy4rDEnS9+bD1g8XSVbg2xlfDO3SXKeoX
         YqX0gyEcSyiTkggHqikcz/fefncItKkSMIgGyU4zu4MVh/5OiRE92kiHHvSKameDdXb/
         0ruHK8YLrv3Y1IiXYcgDR3+cYmcyVzUX1E6YhY+5G1v+TxtrL0UQ7D+owtARB+4Q0qiM
         RLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577924; x=1740182724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPAvKhgJ+unXUmEQvWMbvYBDHLwzjFI865XBH7Bpkw0=;
        b=PBEOzEImGIpvjU40zssX5JNPEEF8TOejdCDiut5AoDjdLphIcq/KIFQxYlC8HjCxQ2
         OqzSpjPcHkw4kF1gZdmPB1lZKi+ekmgbPU34iUjdGQYo6xgQOu/Dj9qJ9OjizbCR4M9z
         GBVqkGUJHfEr7DBSEDv6OyNmiDwCRUZeeZxQZxVeUmCg9+8d7Zp1r9m8mHFuwJcGPfQt
         Py737oD/LKhBeZN240iFnj28UF8PrmZYto0p00gOG2lnBIjxwmgdBRkAoKQGyqiRhOVY
         askxvV9X0VwTt9z8jGgcV9CyG8uiLB3IEDgF4w1vsLcICsbn8chk+kQg0KyR6XvbQ4hc
         Hfvg==
X-Forwarded-Encrypted: i=1; AJvYcCUSreZ6mrvIDZ7/iDKMgWmW644LYKnT4EzgdiznfXdO5i97dWGQ2tDoCONtoxG/wJnGHMwNUkmnjiX6kZ4=@vger.kernel.org, AJvYcCVKh1bH/ZiwRfhgE/YRS5IAnIxYmsPwjmgpynwcffmuUky01a5UwkMkHo6FvaOpKHZgSmQo4ZKj7QVa4LGl@vger.kernel.org, AJvYcCVme8UqkBwQ8pb5+3IGZWzwqerf/EKTP9fPYn4sWqcah3WrRP1n9d7bOU0YGSoTaIqFegVSfMMie4eE@vger.kernel.org
X-Gm-Message-State: AOJu0YznNK+XQDcUhmBmZojf+G3EtcC6/Um9XVjLK8TzQDSzfZEsRIiA
	C9JGeMDN42A3xL7TGQD4fO6dsVIES4XklLYTQe/Bi1ScrYFpdAdf
X-Gm-Gg: ASbGnctJVryXGOMB9tvfTUpOauJ7b1jvH2dICkzX1Q53GNeflsVJfAedhvWhcbr3QH6
	yqNS4cD/StMcTBFLmanxfmjG3RW0tHyZdibAvLplyTC0QATozJlM5JEv80vJVj4RqT3xn/YmAAp
	tfyN47uPrGkXXPNgZVq/LLRqJRVfvI7KxxlVdXTerd5HTJiC3i8KLhhCfXh96O4Pc27GqDELkIB
	hrRk9H8F+5E89ZwyFxxrCJBDShMFP9cwdm8uvDovaW2BmzadCatXO4N296vNp3aVmLuBmRv9+aD
	nCzF/EPKYH18UpZY1Mm0pSY3/lTOVA4l8ESjoy61VeQ3DayXB3lyzgJb+nGIPNe5FgbLPlcA8g4
	rdSUD4TLxmg==
X-Google-Smtp-Source: AGHT+IE2U5MfC5cyLipBN6ucmrk0jb7ckRvkKlZt2Xu8sC+b1Rf5rhMYgR2LfKt6UQ8SB3C9VHTyMw==
X-Received: by 2002:a17:903:230f:b0:220:efc8:60b1 with SMTP id d9443c01a7336-221040a9a41mr17749045ad.39.1739577924131;
        Fri, 14 Feb 2025 16:05:24 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:05:23 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:52 +1000
Subject: [PATCH 19/27] ASoC: tas2764: Fix power control mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-19-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=760;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=D+chifTYrDMRWra/nhQ1ySkrrKfrOuvxSuOgUrZtH+M=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb26/M7t88aVFTBWv8u7+E7/A6S+z6XzCUuvUTR8tt
 65lYr+m3FHKwiDGxSArpsiyoUnIY7YR281+kcq9MHNYmUCGMHBxCsBECg0Y/lntnvflUwy72oGD
 57dILDv8SWG2pMq6o8vZmOJXsv5Z8SuF4a/ExblF+tKJV2TiP31lq6i/NeVbps257ik73786vc1
 37TwmAA==
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index dbe3f7fa90187919b017eb2d59a67cfffc222735..786d81eb5b1e71bad094ef94e4b56e8f7c910285 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -25,7 +25,7 @@
 
 /* Power Control */
 #define TAS2764_PWR_CTRL		TAS2764_REG(0X0, 0x02)
-#define TAS2764_PWR_CTRL_MASK		GENMASK(1, 0)
+#define TAS2764_PWR_CTRL_MASK		GENMASK(2, 0)
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)

-- 
2.48.1


