Return-Path: <linux-kernel+bounces-211947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4080A905941
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7ADB250EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65541822DD;
	Wed, 12 Jun 2024 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kp1Z86ah"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDE1822C5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211464; cv=none; b=o7UR1ziXH6U0cMe4euJG/DP73sjfrJW0jNfeH+B5KiLr77OmkrobTVHQvloLeZbjA+k43NjWqyfF1rDOK5tSMF/eIIDQL5uHCuDHi7b6yABVrCP92UY4saly0E1xuiXB9PQS/eHWIuXWBjRUB+xyjNBB7kgvYJpNhgoqKyWE9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211464; c=relaxed/simple;
	bh=wN0d/8ELr/wL1/Cpgz+AM71Z3Ev6/U/uMM5xUQsA7zg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OE2sGnAIHqeraePJVJlnUfYK2P59X7clScBaq6qEq5vYCwXk29qK95hv2t8EEqkk0wCs4Ij4zL0zYnnGQ1Vv4hSbrr7Q+aGj9K8G9Japmmxj/qsRKTSXHamYGNnFIP4ZmnsOLnD4ytSElt1o7kqlfqZZxnjZAUUp1lc6tuUK/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kp1Z86ah; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so3596205a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718211459; x=1718816259; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++OGzFVcBm4uEhH5yU1JqM6E2MpRXisSlLqZSmtECO8=;
        b=kp1Z86ah6ErKtLpl6aWPqF201ry4AQeS8gtA7FAEMX0GX4jlaDQJdT9fpMu6Wdk1lI
         1chBo/KPM1//lBi+rcSSH/fFp+jd9KH8rGMlPNciZBuhHqJO7564qHWa2b6qU0y+Ocmz
         KLe2UfPr+/IcezEySdtfXPECohYJpGxcXmMKesH2TsOCTbuOWGw8KbBndsHQMcobjl/u
         iM6CqPE/nk2IR4OcvrU4uACOyU1lT+orR9TEqXHBPs6B+iNfGa4GJDAmBGJFDdaEJ3wG
         Wg0vZu+xuLzJYnVR3188Dex6nv6O9SR0aWszYWqXw0Ld2WrLWEkUjMNPFTWrSE4vrEpd
         N2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211459; x=1718816259;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++OGzFVcBm4uEhH5yU1JqM6E2MpRXisSlLqZSmtECO8=;
        b=U/CJFLOLbgFHwUB8D7m3AsAGiSAbDvbIN22xD9LbbsRzVYM68NMxrnER8VVZCs1zfc
         PlRP6cb5vZxYr2MBb587DpbEIcHY5pHTZbM+wCjImeYeClkii3biIcBJM3gebeMYc5lb
         tVGdVhxNCitXFgAG4xwXSH6xnWH5esFuheGyTJK7C2AkqE4me5xxjKdwQTpflRUBgylu
         ibqoWnRn0+zCU1ETD6QDoWYgvgW4ZRnAiodGGlNKFuzew0bAqeRx08ZrgfG+XTF1mRV5
         Vi0fAw6jSQMreet8lyJF5BVyOJnrwOWu4iKww70tVi/AbsQYfA88JppE1UVVG5V/RM/S
         o6cg==
X-Forwarded-Encrypted: i=1; AJvYcCX0EQL0bAxe+H+HrzR+Eszxroy3kB0lI4FN0X3R7rQyWFpSbCXiPAlCU/6O9nbnmN1kxYWuYOByGqUdSJZUbe6luv7qPhT/c6+tCd7z
X-Gm-Message-State: AOJu0YzR0cBuUetI62QAvYvbdoLXAureJZP04UdfKxG9QvP/LuAv+tA1
	uqpX6HzOBFojKjPjuf6ominLxGVzOap6ALCKuNunOCdU80HnCxTSdBjv1TLR2R4=
X-Google-Smtp-Source: AGHT+IF836A5i+me8GLcRRQJaRgp0OVmTJirfPxSvaoJYHrk64DZsC+Tv1+4VFubuAyRndBPcsBGRg==
X-Received: by 2002:a50:d6dc:0:b0:57c:748e:8c57 with SMTP id 4fb4d7f45d1cf-57caaae5c4fmr1629719a12.37.1718211459331;
        Wed, 12 Jun 2024 09:57:39 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57ca8caed84sm1564048a12.43.2024.06.12.09.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:57:38 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/3] ASoC: codecs: lpass: add support for v2.5 rx macro
Date: Wed, 12 Jun 2024 17:57:20 +0100
Message-Id: <20240612-lpass-codec-v25-v1-0-9f40611a1370@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHDTaWYC/x2N0QrCMAwAf2Xk2UBbZ0F/RXxI28wFtBuJFGHs3
 +18PI7jNjBWYYPbsIFyE5OldvCnAfJM9ckopTMEF0YXfcDXSmaYl8IZW7jgyNfoKJUY/QS9SmS
 MSanm+ejeZB/WQ6zKk3z/qzu0Mzz2/QfybOppfgAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, 
 krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=wN0d/8ELr/wL1/Cpgz+AM71Z3Ev6/U/uMM5xUQsA7zg=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmadOCosZkrFenGj0f4v6e63uCrImo/xB0NSFBy
 7MarRKB6YSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZmnTggAKCRB6of1ZxzRV
 N2ELB/425bmlrp+cAozeGyMGB7MzypQjhkcZfef10UJpMmk9KWUX9JXme1UsbIhEZQtPEd5lpkr
 UgTyqxnVH/ustTMcPyWH/HbBx6/5SLHpT0d39gxe4yuurbggrKwl0y2XRfeMsRqgpzOribmyl8g
 ZLRm+T/zMe944k4Hu5RtAZMW0G0EmodGZExlt69yl56iG2Zz/TMI2Ty3GuFEhRgrAw6ZZWXizPA
 0oCOUfIfkMewz5nl7HgV2oHhtGF/2XSUSWNMvwKcUOki8PepLl8T6OV52XgJo6N7GgHUAJQXu1J
 3Bx5zJDJlTeYe6bsPgbt8MB3irCMst43fiF6gAKgaxJcvpDV
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

This patchset adds support to reading codec version and also adds
support for v2.5 codec version in rx macro. 

LPASS 2.5 and up versions have changes in some of the rx blocks which
are required to get headset functional correctly.

Tested this on SM8450, X13s and x1e80100 crd.

This changes also fixes issue with sm8450, sm8550, sm8660 and x1e80100.

@Neil Armstrong  can you pl test it on sm8650

@Krzysztof Kozlowski can you pl test it on sm8550

Thanks,
Srini

Changes since v2:
	- added some locking around version variable.
	- split 2.5 changes to a new patch.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Srinivas Kandagatla (3):
      ASoC: codecs: lpass-macro: add helpers to get codec version
      ASoC: codec: lpass-rx-macro: prepare driver to accomdate new codec versions
      ASoC: codec: lpass-rx-macro: add support for 2.5 codec version

 sound/soc/codecs/lpass-macro-common.c |  23 ++
 sound/soc/codecs/lpass-macro-common.h |  35 +++
 sound/soc/codecs/lpass-rx-macro.c     | 555 ++++++++++++++++++++++++----------
 sound/soc/codecs/lpass-va-macro.c     |  29 ++
 4 files changed, 490 insertions(+), 152 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240612-lpass-codec-v25-4e960abd661f

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


