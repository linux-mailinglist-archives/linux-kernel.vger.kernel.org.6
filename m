Return-Path: <linux-kernel+bounces-229346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AAF916EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0631C230B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8806C175567;
	Tue, 25 Jun 2024 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLWBeabL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E99715746B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334744; cv=none; b=GxTf33kwfekLH0WkKRoOOxdw3sDm2b1azsXQsPDy+2xRaSIrsZqhyBOm54pC+J6OLLaEBu99zG0Q8BmVZZEXHMqY02n6c2XcmaIAlIfamZkTKzXMo776pfpkHq6TsDYI4DBSiRZ2KivuJbfkQv/+E9cT2FbNb3ITR25RHyOD4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334744; c=relaxed/simple;
	bh=0vBGYw+FS13AvBeDigAqz04da28vVKpsvEKRngqhcFc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U56xAG5uC2wHn4dckaMcjYtRRI1lWG/UKjvSdXYpLma8rUfIyl7XF5GOqc2ygvdWTL4podE63sSVOMI8awnYZsPEeubqjpkegK2IHco2QuMXNeaMY1GTzpsXnUCbw0Gz+8CclWFN97EMwXNTfC0DY7qaF6LJ15gvE4HkXXzSoic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RLWBeabL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217136a74dso46809855e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719334741; x=1719939541; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wYBu4PobMIgdfTY6h2udvW8/PZ7jirC6Sa9duUD35vA=;
        b=RLWBeabL90AgnrFICN90Gd21oN8YJVDu+0YJWzl5bfGBIgzYyoGGFyTqv6j+wAA/dY
         kmA6MHIeC46spN8g2beDRLUkgLRHbfCGpjWeE8Xt0SIM1lFB+ZSoBJbQBsjR5AALrl97
         jOWhkxmPmGzHZ5tekEdpb9R0mJDfXdxOFvy1LXVQncFIS6eJmXpgU4XZP1gXttmamIgp
         A9uEyx9IP1WO/CmPhErqx24NygNGoq9TRyUmMc1z5QMR8tOWFDctjFtVArtd0WP9JCAa
         IOSwG4ZyFizTCoEQVU6R3bEEMp1BQVTE92ALgkG2StuExlEwFB/U+jtuLf9cO8nxEhun
         /MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334741; x=1719939541;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYBu4PobMIgdfTY6h2udvW8/PZ7jirC6Sa9duUD35vA=;
        b=GZ+bcOpp6hmr47CLrdNBJQ4w7VyYd+pPbZvL7m1TqTnrFMHA9tTCifW3RsUY8/YNTB
         oBd3M3RkNYgGwOGmgMWdxO11fiR9WJc/ra4EUo952j1luc5ZnWqYoSFO/XdraKh1B+Lu
         4beCmcYn+2tPQHrQZSOFOZe/9+sknHf4BBFO4B+08Mk/zyE7xWP3zQjBvETmqkZMbcKL
         Y7BFLHOL1PV63CB5VfzMOxT4rgdE1qtabQAVvrlANMJABbIsNI5KDacOHUR1DIYxfLNl
         E9E0wupaQwLl0FbdY5Sq2eMxi4TSgeNmVG47fgiNJ3fJFMB2lJ50NQGOD+efONCv+arX
         KQqg==
X-Forwarded-Encrypted: i=1; AJvYcCUYFwZ8PDUsHfmK5TqZNtCLUqD+bRzplhkwBgITjHlMZKfoCoA+YGAPKEFQKX4qxFYSVncymnvWENcgPhmAYyNN0hoA5EhV4nA/GiJ8
X-Gm-Message-State: AOJu0YzNr89ip8ZtGMhPjp96eqLQRLfVjPBHwr9uOIpdOeywdIsnoxzF
	L0unnCZU0dUPM62YZCt+FcDXIe+GWiXXEJWLld7krAthzKVlCf2le0BsBQzXbvo=
X-Google-Smtp-Source: AGHT+IHUaZ4mU5uGRN6j2ODv5sXzv2DRzpZrCreP4h6HdLbJU4FVwUS3Cc230v3XgR70R7RUWfR18w==
X-Received: by 2002:a05:600c:3589:b0:424:8f97:8069 with SMTP id 5b1f17b1804b1-4248f978134mr44997055e9.30.1719334741557;
        Tue, 25 Jun 2024 09:59:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d211881sm217969785e9.46.2024.06.25.09.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:59:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] ASoC: codecs: lpass-wsa-macro: Add support for newer
 v2.5 version
Date: Tue, 25 Jun 2024 18:58:44 +0200
Message-Id: <20240625-qcom-audio-wsa-second-speaker-v1-0-f65ffdfc368c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAET3emYC/x3MQQrCQAwF0KuUrA20wVbwKuIiTr4axJk6oSqU3
 t3B5du8lQLVEXTsVqp4e3jJDcOuo3TXfAO7NZP0su8nGfmVypN1MS/8CeVAKtk4ZugDlYFBRxO
 T6XChdswVV//+/9N5236ZDh7mbwAAAA==
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=0vBGYw+FS13AvBeDigAqz04da28vVKpsvEKRngqhcFc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmevdNqq0tv4A+3jbslGVS16UU0/GvICniNq4Ei
 PT5Vap/DYeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnr3TQAKCRDBN2bmhouD
 1zi8D/915nG8Gwp4TP87gu4KBRwPlUmNpiWoj8gHPtuVIS6jh0QBpQUTXzQ/C2S32sF8UdLdKMe
 hqlquS0dgTs4d8Msz37Lzhp5DI8a+zi+mNJBebnjG0AGyh4hXsqKkfkoq3kTWmohZL8/0mw4gCY
 4FnM/Ao2ntzbtIMO2gfC9JtMVJ8nPidHbg1OInc/sWRe0ikvPbD2adiEhc6L3SW5obK11AYD5vL
 /HE55KcB/ydOrf757QTvSzWxL7FD5Y7YAZVuvFcJg1W7GY3SzpXSh+ErCqark2aXyE05Srxxpnz
 SGtz+QlKxmtm8oVWBJCr3jgVAFaJmlQauDTyHQQ0xQb6SBmgrWhp/T9jOGeo6WCNldslTfdv1r2
 VE+eYW9n8o1ZeXJSMnNNJVbg2lymCoih3s2llEFmiAyfDXQAXL37ZEE/hfugAL1LbI8UMuzOcB9
 oPzkfAFYaFcGiz9Z8troMAfdFYF1q/r77UIykqtc6YMh2JMt/s9xpwFC4cRa/kuZILsUo25CmTa
 sUzeC031pmeLAmZpTYt+R+mzcwiNsPGF1BdtySfpqDaUkaH1PHPr8+3cMPUvjr56Io+Df2kapX3
 cLryfj737fFANY/ogpfPY1WKIT3pRwsGmHDadYdO5E2wQl/LMN8uaMU2ehbD2rOHCmLtdTfkSjC
 8l/6EQbkEtTj3fA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

LPASS codec v2.5 and newer have differences in registers which we did
not implement so far.  Lack of proper support is visible during
playback: on SoCs with v2.6 (e.g. Qualcomm SM8550) only one speaker
plays.

Add missing bits for v2.5 and newer codecs.

This is similar work to already merged:
https://lore.kernel.org/all/20240612-lpass-codec-v25-v4-0-f63d3676dbc4@linaro.org/

No dependencies.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      ASoC: codecs: lpass-wsa-macro: Drop unused define
      ASoC: codecs: lpass-wsa-macro: Prepare to accommodate new codec versions
      ASoC: codecs: lpass-wsa-macro: Correct support for newer v2.5 version

 sound/soc/codecs/lpass-wsa-macro.c | 644 ++++++++++++++++++++++++++++++-------
 1 file changed, 521 insertions(+), 123 deletions(-)
---
base-commit: d585065ee5b64c60496a2403bafee1540cb319ec
change-id: 20240625-qcom-audio-wsa-second-speaker-ee1a5d2d267b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


