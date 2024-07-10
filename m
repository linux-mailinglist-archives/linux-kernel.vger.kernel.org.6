Return-Path: <linux-kernel+bounces-247705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E892D369
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8011F247E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BEB193067;
	Wed, 10 Jul 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z30DtUh9"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D6193074
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619564; cv=none; b=DtkD0XrmI0Z0BtPIU6Xlc8nvZkIX8YDRODxAE3W0mrYV7IPNoHf8ndUD3YhbEbn20tMyGPq1Ga17TpAm5vt52f6uBW5E+NLHi5tF00dJzpsGh5cE6L0LV0VIbnRaOXMWLZRWJx1Oc71DJrJvV5r4A/wdZ+oU2jXlQ5tVzcxb9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619564; c=relaxed/simple;
	bh=xCLRTG7ipn4tiGh+nXkgwfMZfAsmNK9dFGTdCsvf/7E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qAR4GpVrnCMHL17Zr5H4Cqx/AOyKZE8hI/WRgGprFMEM2XZK6yW+HFQKoH++J5vBVdRITebkh7cPdoJh62qM4+/6hu17DYXbeyaiNJyfmsANyNOaFFac+5noc7dtsMSfvm90KzUtoKXpQ3/3FjBYspOI6RFpq6LRzsnvDLvkIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z30DtUh9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea929ea56so8880755e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720619561; x=1721224361; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eG+Sr5tcj4iLYaVgjAszjSri4jbIahacA3U2hkyfLzQ=;
        b=Z30DtUh9N6QdpXwDi9fRAFVXM5278EZUIjTiilVZ64Kr3iW5kngSc/zAcEa/iXvwPn
         SKl10LTI+QrUb6Gz+jY+oHQ4sEHXVMw18T6Civ5C2GXUL08SgBEk7Du5MlVbbP+9k9xo
         VDjRACERs3JfRO4ctVMoQPqMv3QCyPgZtq63k1R9xXn8SPU0Ki2NYnp3u6G1ZCEoa/H3
         a0CwcPFD2uM+BI4kvzFi2Lgy4ahTHowTVNOtCcYOcb6HgVHg7r+TXg6czMuBWUweF5XW
         ni6F2pEZ9/rJ1M/63a8axS14IcQ4ZmbCKUFimjOCgKGga14SHs4sz3Omb6D33iLPZ2wI
         epLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619561; x=1721224361;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eG+Sr5tcj4iLYaVgjAszjSri4jbIahacA3U2hkyfLzQ=;
        b=CEyc6ueS3pVC9EZasHlj3e2104VudaL0kSTHIMYyI2S4barFpIEx8lkuUmC0v5bTHU
         45mJ8yUxHz6FUc0hkTXypgmO3+WUaDlrlCaDlWogb/57K56Sx38SEmIDxfDoyUR9FYB2
         Y4P1ypcE+IIt26JsRD1vtIqmdLLO7hGIaaVODGik6Kn9nwv07w1GTg733kJFJa8C3bIu
         zAaq+5vSlc1kQijZxnB4PGLOWcUwhyAUxO4KDAoVk0wy8XiMr6O9crEBQd8t3p6laH8f
         nATD1r14XtV4TexpIE/tk6JrK8mXagFGRqaBSKMxmir07Q/TwGOYCf/GZmrE6dNs6kid
         piuA==
X-Forwarded-Encrypted: i=1; AJvYcCUtyNTOtfZMhRftoE4eHl9vxFFqqL7j+PC15cGQIPABLcPVQZfKDwrp9eABIhS4WA+XjBvkE373S/s/gkDZUJYS018Nwx3u24ydOGXw
X-Gm-Message-State: AOJu0Yx9YhmbFGuD5Pdf3TsRzLvk6iEeyJGwcL5af3MRX5xwGvwW1VZC
	cRJpTuNU4Gj/SqSiiIO+yF+2KyN+EKXJlwZSytAlzFOx2Tr8cCiWcTdNCNajdyQ=
X-Google-Smtp-Source: AGHT+IGI74Tkk+bMOUOiLt7ShAbiFrBfr/fOEAEBbMRa7tJDzVxniq8rJ4ZAffl1kUcxrWh4qs60mQ==
X-Received: by 2002:a19:7708:0:b0:52e:9921:6dff with SMTP id 2adb3069b0e04-52eb999c2damr3844744e87.26.1720619560886;
        Wed, 10 Jul 2024 06:52:40 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a8551afsm160440366b.166.2024.07.10.06.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:52:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] ASoC: codecs: wsa88xx: Few cleanups
Date: Wed, 10 Jul 2024 15:52:29 +0200
Message-Id: <20240710-asoc-wsa88xx-version-v1-0-f1c54966ccde@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB2SjmYC/x3MPQqAMAxA4atIZgOx/nsVcSg2ahaVBrRQvLvV8
 Q3fi6DshRWGLILnS1SOPUWRZzBvdl8ZxaUGQ6aitiC0esx4q+26EPBi/wF0jqjsTVObqoZET8+
 LhH87Ts/zAvQQhONmAAAA
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=735;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=xCLRTG7ipn4tiGh+nXkgwfMZfAsmNK9dFGTdCsvf/7E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmjpIgOoSVr2Zwu1wsDHRIcZrveKRJRSIuDq8nt
 RPtif7BrGWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZo6SIAAKCRDBN2bmhouD
 1wh/D/9lsgACXVjSoXDNyKh/50MNApgsGUF1FAG7hSEA8wgGCwfXTAlF+T6iLK/CwOAkjjYnr/X
 cmNfVrwGDq8BVLYIMRKbC2HNV2obW+l+Ujo07/fLa+g9aQUhC7ZEP4tHAm8qrlY/m3aK5hPDBuf
 z6IZTOW4byybU0zESW2OFb82RYXE1kt2ykvp+Q10qcYohOJloV/KKrC0YByHeLAv1/58adeBjeo
 gcSIsfPleSMx29G2WjbpQ7tXT5wWDIANzMl4+PkUGgZrbd27unoL+xYm+0NqyGqis0G/BXI4JqH
 +yErT3gQKDJaI4RNI8edaxLj3mkY5KYSQbSiQ75wklEz+xLdGmiQ7hdduSwxr+JagfZNuKIeaZe
 jEuRBkbyQ4lQGu4kzyMJkXOWgFTWo1gDOSBVIvc0HcWvRtWs+Xtw3jiNjg7EJVGEnxyAy36AjBq
 f2hQCZncbX3Kz85G7x/ARpGU79aXANhLFec/a/mWVqG5sqowgfvYq4Yh4Jax9Vyzfe1DODtHWLz
 Y+Z39HzUJqBiosEnlz/+5ptF4y+/rUSDig+76co81LY2E3B6BzDxg7II0oZtO8pwoVfS9ivMuzv
 C20tQU+/QOyG+ZDA2TVW688bOr4jgRDpAGFngu4vigPD0N5Of9bXOj5fnwQQWS1reYa49NMsF2u
 B8nHm7ztuwmkKjA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Few cleanups around wsa88xx codecs.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      ASoC: codecs: wsa881x: Drop unused version readout
      ASoC: codecs: wsa883x: Handle reading version failure
      ASoC: codecs: wsa883x: Simplify handling variant/version
      ASoC: codecs: wsa884x: Simplify handling variant

 sound/soc/codecs/wsa881x.c |  2 --
 sound/soc/codecs/wsa883x.c | 33 ++++++++++++++++++---------------
 sound/soc/codecs/wsa884x.c |  5 ++---
 3 files changed, 20 insertions(+), 20 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240710-asoc-wsa88xx-version-dd0039265245

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


