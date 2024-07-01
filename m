Return-Path: <linux-kernel+bounces-235746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F291D92D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7975A1F2224B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7575275804;
	Mon,  1 Jul 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJuSJFzT"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F58287E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819594; cv=none; b=is/kwTgyzRDZhajWfpuoGKCtDJcAeLTyIAh7MXfLKtkTCWEjcOta3//QVpcrqIP6yYi0SsuYxIxx6j5PYyH++6r/Hb1W2V4W6TXZ8peIpEazd3EjOkUVZuak/lOZz+xe4rBJMpTeuTF3FIu3NMCcGKie5K/48U8okk9O5/keDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819594; c=relaxed/simple;
	bh=Ad+uKCGSDe8rakMGGeF23SfGPaAfcaquc5R5IIxLKwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMg4TESw8PJ+Qv3FqqFOkdaJC6qZMTdFUFalp6kh6oyhwK7cO25EyA+nQGHt9XAgLhVnd5LBSH+bxw/i32JsDq33xwEa5hhvsFbIhN1vyD2jqku0z7S7P8lP3fJM/z6psp8JhxNy2x8WFtODrbj30aVaa1sCqjRNrMY1jwXm7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJuSJFzT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-364c9ec17d1so1551933f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719819591; x=1720424391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PicI/VwwrTj8z258jc72WwlXuJ32jmr5AxPeFVRGEyg=;
        b=qJuSJFzTuSfXuQIm0kUXjQPkUiGSo5ftpaBxXO/YKOCEBum1awxnhvYkGBgzRRRj5c
         lvezGssTBzOu0GULxM9dyEx1e8aHeDE2Pshm2mc72Bdjea6F/xdyUang68DguUAjTP0r
         Z7d2qTCXHoc5Ex09SDAzJJIhDV1WaKhHyHQXPixfK3yzTcvDxS8vriB10QUNTnim5cBf
         yGs6tO0OM52+PIDRc9dX5cCc5LQmc3qq7SrkjC9kuyKDY/WHcWdZbsTEXDIEZXILLKhW
         d72n0ZipgQgucwqPduoP4FrhPgTXvnG5zGjLyRp7Dhz4y+fKGc3viUQV6POyGXZTYfJ/
         9oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719819591; x=1720424391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PicI/VwwrTj8z258jc72WwlXuJ32jmr5AxPeFVRGEyg=;
        b=FhiLt2jU5g32SeVZeCI3JOhbefZX85GdxhZukysppEI9pJjKkJILzqfzfs8ZsS9X5O
         3dIzP5Ki51lzmfMZ8IOfmL9kD6D5QKUs8dCBZET6Ta+lvWcALSDpTNzmjlcj1GwTo9aI
         LsQRMg5dDBwz4PvqiSK5G8alQBX3b3uCrICdnMHJ23DHPSolcpUlVMPAYDF4wmpEZOL6
         z9JQLdDH/xaxlg+2DABYo79fCTkdtzAao83dlM46RgIHbFW9Q7k+mEyIDfOQRV6UDfEN
         7rQTHJ76rZcZba7OkoTjpVDSiitmmLCm6f0wkO7gZhujZOzdeupNYmPtjK2tLQAOZ+8R
         76Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXdw4iXp98RbuH2lv4DDUFWWXGQ3EJg66h620DO0mMkUe6LH5OZaP9xbYi6Zyj1y3pE8hzb1QG5xDglSqthte15/80b03AIrCyMOgzT
X-Gm-Message-State: AOJu0Yy7uFcML3rz8POGQWhP/j70rlWskM0bRFPYyfB+oe5U7yOVaQ8N
	4mh0Imp6WLeVLjUuRrlJQBJJDtmPSTB6rvFVUxfEGI1i9hRG9FvgRdu8CAWZOXA=
X-Google-Smtp-Source: AGHT+IEbIUXccj8XAr3Pi+HR8BNf+tQNrJrtODvTWFS72V0zOXk9wxPAEE6XniRcWyYY2+RnDUWHiA==
X-Received: by 2002:a05:6000:400c:b0:364:d2b6:4520 with SMTP id ffacd0b85a97d-367756233bbmr4242423f8f.0.1719819591373;
        Mon, 01 Jul 2024 00:39:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb9absm9279936f8f.80.2024.07.01.00.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 00:39:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 01 Jul 2024 09:39:36 +0200
Subject: [PATCH v3 4/6] ASoC: dapm: Use unsigned for number of widgets in
 snd_soc_dapm_new_controls()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-qcom-audio-lpass-codec-cleanups-v3-4-6d98d4dd1ef5@linaro.org>
References: <20240701-b4-qcom-audio-lpass-codec-cleanups-v3-0-6d98d4dd1ef5@linaro.org>
In-Reply-To: <20240701-b4-qcom-audio-lpass-codec-cleanups-v3-0-6d98d4dd1ef5@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Ad+uKCGSDe8rakMGGeF23SfGPaAfcaquc5R5IIxLKwU=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGaCXT6gS/qmIwhhz3JQvaEtkfOrO61QWr5ln39pMYOi8vd+e
 4kCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJmgl0+AAoJEME3ZuaGi4PX1c0QAJl5
 DR2okgESZi49MoN1Ws63ZWEeEn6VoZVEJIgmLYJqu4xMAtfgzvHKeFe7GnlgFOmu2GKIualxJc1
 tzvu+9iOUyYkxvUojTVjT4obSTdZSPt9VJ3rIpzjVb4rdHhl7KWJZH4wYjBdAeydnGVn6KfDrpd
 enKKdUpVAQqwA43A5iZjoYYAq8E2UXS7swMDEEEAhRrAgJMoGDQOAijNlXhllzpVg8g0LfmVIMe
 UG8mSyzUSvUSyTe6dXhqjxsyxmnIPfJbPoqJF2+O2gE4Gktz/mQgcoCApFJ1GWdcGX1vxyO1edS
 Lamz3HAGA4xqNxzZdM3ByU02sOh6C/d8vCy8VZlmkVvfjOiZrIVmSFHmWsEUEUtDsb9HOnOytIQ
 edwPxJ5xtvHfCiTVib0RmgWEaOmvpouSSS7LTBNG5swGHpKbXB3VugNyxCTLR7LQavVrFf8IKC7
 Vbyd5YTkrXrBjGYk8rC0DLlYxwepXDkOqsa0POpgjUVQsXAUIjZqPzs7xUx5pQh1CMAuPLq2u7W
 iA0WvmVzvWJ6YvUY89jXfYfSJ2dEnzPZ8hNqYO4cEX6+5oABVfL2FLtz099Y0cIc7m27rTy1+Zt
 EJoAegi1dzQhXviE9pWxufxXV3Ryb98d8lEtauqgWVgJ4uvCm7EmT/onJU24R7dUcIcFyAhBikV
 YpnPf
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Number of widgets in array passed to snd_soc_dapm_new_controls() cannot
be negative, so make it explicit by using 'unsigned int', just like
snd_soc_add_component_controls() is doing.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/sound/soc-dapm.h | 2 +-
 sound/soc/soc-dapm.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 667ecd4daa68..12cd7b5a2202 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -457,7 +457,7 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
 int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
-	const struct snd_soc_dapm_widget *widget, int num);
+	const struct snd_soc_dapm_widget *widget, unsigned int num);
 struct snd_soc_dapm_widget *snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		const struct snd_soc_dapm_widget *widget);
 struct snd_soc_dapm_widget *snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 16dad4a45443..32cc90d09bc2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3857,7 +3857,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
  */
 int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
-	int num)
+	unsigned int num)
 {
 	int i;
 	int ret = 0;

-- 
2.43.0


