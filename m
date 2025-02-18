Return-Path: <linux-kernel+bounces-518887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E6A395AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6821897800
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1435022D7B4;
	Tue, 18 Feb 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED0XMRBE"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F7234998;
	Tue, 18 Feb 2025 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867897; cv=none; b=CIoLIN1Aa3JyKe+oM31E5MEScEadZ8WZ0Ct4VLErWUyiVRDP/Ci5jQ3XfjDGiTht2mmNAT/iOJiVIJSBxVo8DSSFGNg0mu05oG4mccZkjqCo0vLUBHL6MUGjDxHNSWlAAoG355KCFOn0zHSijFFbl2+szeeIKt4BFXb0T+AH+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867897; c=relaxed/simple;
	bh=kn1APRcCA/v8AjoA1R9fU9HzEdKU9YfUWCYBmEG2UzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sV5cngB53RxAPvcFXJ1ktm+Sx4sZz3HRZPSEz4jvv33mdtWYEco043U2QaWvJ6hhi7MCJox51RH0svYyI7+LccHT/ZrN8F2F7Xuxuo+wjLq4MOGBVoo/E1j3yCSBMwjRj6JpnUTAsjJr41RlTfYllIIeyCbcQVIamfEKB+WPVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED0XMRBE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220f4dd756eso64616535ad.3;
        Tue, 18 Feb 2025 00:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867894; x=1740472694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vIiixkZLusvVLSOkYQ4pzXKIcBetiV0WHv/MyWa9HI=;
        b=ED0XMRBEkhn88iNQb+vs8ZLfxSnCxuDmjWvlGnZkUzx6TcuAa8OvtJGoNFXEyy9rwA
         8wMKBw+ED4iswBZQrrYo283x21UnrRwdAgmxwnmxXqAAEIO5NnUyuZ+Lm/rX5JJTq7gn
         OKEZovZWq6ekdB7EsorsGBspdLkeUTKgR0x1Nj9E+uRgSp66YZzxoMSwZNXpRU5FBOGP
         Z7cSqO9rm0sL37r5DKqLcihLvWHtNWQR/PfDoKU9hA1J0Dv8kSkc8lBpxqM5rubgpS2J
         2INTMcGV8zaqtHFVl41+1INuMzs10MPHdq48/t1XkUA8991sEbCknCJSfEgdF/ltN/1l
         5mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867894; x=1740472694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vIiixkZLusvVLSOkYQ4pzXKIcBetiV0WHv/MyWa9HI=;
        b=Dnt24e2b4dLHYu4ZFlAOngCHITjEwrPVDv1NkBz8Sebub6/8/4tAF3AfSSV6/waCWH
         phztY/+vbrogeaHOOiGrG86R+G9iiFoTN0trfuiyPa40s6O57nW++UX+y2X+WhRHifLl
         b+5pHsmffVhrMlk+y9xYz4+R1Wct7Ur9uURsvWHYoby529YpZ5C4ROgTBsScEellXot3
         35QDOHsxbgx3JDuUcO89Y1xxmHv8dIkxCBO4ATr4bDN4rwH7u6ZtbzT9mWFnVi/LK2Ue
         LTL6WP2F7Dj9tDbPQzkxe+1DGGLIQQ9ejZNlldsK5Ea5BPOuRCpheqnGhNylePW++7M0
         QlFg==
X-Forwarded-Encrypted: i=1; AJvYcCVJiwjtr1CA7u0xWnKS3QBG0Dr8QuzbM4NPy+NxnGEhOeMf2h0JwnjsqG/9MBikQ0spzq6pxd+rsiWDe6s=@vger.kernel.org, AJvYcCVMZVQcXGqjGDVOMotPVMxSA35y8hSo9bEq1LbecCB7hLjW4/yyS2xHgzHOLhfnwf79mJ3qGePFdRqo33g=@vger.kernel.org, AJvYcCVziyLR2IUcIdwKmzwAM8hxIfU5UsnUU2nDb9rPDYPKrH/Ua4vg51/GQZ2QGCwvVDMa874QwE89oiHD@vger.kernel.org, AJvYcCX33qhuPBRevQmSjcnH+KgpsrETNhvt0Ok3FH+vc/zWGzWFIPi4CZu4moHNG+3FLahd8v83Wg1xPIKUx+2k@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDXNtxTvIB7ECwRRJCTSvHmlTfRPZnlZ6M+3CqbFLc3nncFmT
	fhUJYNPf78bIs41DF+O1/96JWo45lkwsvUTyf2Buta+PpfP0ZMZ4Ju+P9Qma
X-Gm-Gg: ASbGncuXvNsipdATlxMRjny7pXSCkornRKOBOiPiKd5FplaprlIyprlQuu/4tK1mcDt
	/6i7stiIiTQSB8ACK+YPKYNCPelfIVP2PMA5aTb3HicoBVycNg4SuTQ/oll6lnQYacAv7X02Llp
	BPaj4HvtqLDhNLDKS0+CgykfN+ldRAph4KUBGTUCIWzez1K8349sYiCai6BSwEFHsCNpK2IwhKY
	HhVVQk8mRhy09+bFksYaRtNv472aeNu05rFh0cOCYazrQ7fMc/C0yXoVRK2P4suA3k+URvJwhyr
	2Fsy61CwJgC4+u8blfRVKIpNEu06GwZmd+5xJtcg0KrDzI9I6giYXUGnSMQPo8+XNJB6iaJs2Qb
	Dt9yrwdI1jA==
X-Google-Smtp-Source: AGHT+IE9l5ZWDLZ4Snb5g8buV7sgmajvA4jmUg5Vk/mBb8OxfNgwoLh3SgWN+mfYVulRQJ7/jQm3XA==
X-Received: by 2002:a05:6a20:2591:b0:1ee:69db:b0b7 with SMTP id adf61e73a8af0-1ee8cbf9ce8mr26100366637.32.1739867894577;
        Tue, 18 Feb 2025 00:38:14 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:38:14 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:52 +1000
Subject: [PATCH v2 18/29] ASoC: tas2764: Enable main IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-18-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=865;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=nGf66/Eflq8MFfFqSEUJwOcDBRVpqoelx/A3yfhUSUo=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BJlWO/riC+cb5nJmq4er8uSPmXn9V3ex+6aFS30n
 Vp/+2xYRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABNxm87I0D4p+c0lef/m/VLs
 ktGSf0PfTWi7rvtD1Wim5DadWLtkO0aG77v9BafJvMh79Fk7bS7zk7jkJOF/+w8IhsTafHm5cFo
 BNwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 39dc466bfbca35d50a5a93507260d59d30affab6..16df453190961b8ea6809cf4e6a9c588f41b5a82 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -716,7 +716,7 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	regmap_reinit_cache(tas2764->regmap, &tas2764_i2c_regmap);
 
 	if (tas2764->irq) {
-		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0xff);
+		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0x00);
 		if (ret < 0)
 			return ret;
 

-- 
2.48.1


