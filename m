Return-Path: <linux-kernel+bounces-534015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3ADA46183
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851BF3B36FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF52206AC;
	Wed, 26 Feb 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxeTb02k"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0621E0BD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578352; cv=none; b=H4MvP1UuPjLYxv9AnL6PenTw1XT7ZckksAU98BfUbhCG1MmF+5RM3fkHdJP6MZQG80w3V0Tdo73Bzq2oTA0ppYb3vgwM5nR6BqWsSWAZMwgRAZL/GI5YM/en3Au/b/LZZh/uVgpSLFhmTLJuqMyKVh90+3HSlyqeEnrpdei9x8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578352; c=relaxed/simple;
	bh=dpudgvnbUcleNul+hZceK0VKC5IVn5ot1Wf/pV1Rlms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nTl/uy4EtxyQ4Oi1vrxv//641FfbPwxbXmc+VMK87m9xnrprElV7itEo94ZPIpjHQbGhdRwmpsFArvR/VgY37E0ktF6R4f0FL0dTncb7Af9pubKO5v+Q3GnFbmrTYxT2t/j7Btl3JB0h0hbs9ITIzStSQTWIVqGid+87dP+GQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SxeTb02k; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so516859766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740578349; x=1741183149; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCyJrcyE+zDY5d7yM/G99bmmgj+BdOtnhD+8xJaSKWs=;
        b=SxeTb02kHoSSzQYEEo0ZFmiAoqNFxVtrLnSK9axuXLqcl36BedEIM2uRzrUXr0ckeR
         fLWFjSk+aW04wjRCa59FLIc4B51Yf35QGj4uVL7BAhFZXFN5vrbOCknjH0TN+n4En0O2
         fWMxPVCe0vgffOTdq7FGMHYmp6GkwP15d7RHgYaEz2UmkWcmO3RGxk3xkaDROqLL4KIZ
         7IxRqEJZxsyxqt9qWLTRb6MjqK80AwXy0187MVPFiSwAHm/XzTS9peTjVSux+djqaKCD
         KrhzV9xRqYDC5P/X1arny4/qdi4HmphzhtHzedKwxV/d97cNr1HWUYKCVdXVMzHXv/ck
         pYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578349; x=1741183149;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCyJrcyE+zDY5d7yM/G99bmmgj+BdOtnhD+8xJaSKWs=;
        b=JAKEn/DRKkjuHlaWz9uj1vkiD5n+xyxcM3tgyNoO5z+cvbzgEjwhsNo7V5hQYmuhUc
         kTYnsxzdmojVoJOvn1uKFm6UBZlvSrR6ZKu6qFmRiSzp+TDu5KOagzC6zIK1ZHMuhr3C
         qGDkY6gsR1mXjhAR36GvyCrYz2LPbLTjxZT+QrQ5TTzd97ufjRu6m/u/6wv6tKXGHyMC
         v2pc5QTdNT9orswjnKst4oL1+8udAGZGMm7TLUK1buo5wygDY3Smx0D4G9Ct2ZeZyXsq
         yKu0WM4Iu4xm20YeyZEg3U3Sb6yFTYG9pvelvK/7WhyQ7cG398u0fIECOoZhFHnTkGfh
         x2dA==
X-Forwarded-Encrypted: i=1; AJvYcCXZzaBCM79D/3R4K7jkPadcjYXgnPiUJpfoejhNQ5VVA3loUtiHP1yNDGOxnx7f4YuBH4oxGJEdLh4r+ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhwLQRNK6Ht59BTok0XXliWTQRof7+Y7JBKbW9EDhoc8Ov4DA
	0U7gq+4dm5ZT8wv4D3l/DFYDB8dez/wGFaLB8NZnZc9/7W4pIhbGUKObWuNfhMM=
X-Gm-Gg: ASbGncucCRKbDBHjZta6MHMexFELCoN+BMuwJWe9o2C854dXYhKQCSN8SD4wQvkKlnC
	APn14X57VH9OX2lLbLyAPANredI0SN1uzYbLDj5GCppesxtep+GHka0fT18t9y5xjF0DY+ILetm
	FqtJ8RiZRgzWnvUuzwiRgPqNdpYzkrUgnbThCqZIVnMFwbd5Bc+03yTyG0XC/f9S/rRqoxfQ1EI
	E5zbPjOMMqC7RlB4kZ4yZMWYsiaFiVjOulZQMT8yDU/kO3xoRq8Ysy1o23zQnpvOAyV2NQS4gFo
	3wiYNKL1sYwikwzzNOg59fX1
X-Google-Smtp-Source: AGHT+IGq1MD2BDjxaTNyMW9AYMWQfWuRsIcBB0Qs6fRE/nNI8ikyhvYQIfVztbGPD1jUdmJkn3n44g==
X-Received: by 2002:a17:907:c407:b0:abb:c647:a4bf with SMTP id a640c23a62f3a-abeeedd14c4mr424666866b.23.1740578348617;
        Wed, 26 Feb 2025 05:59:08 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm335378766b.56.2025.02.26.05.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:59:08 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/2] leds: rgb: leds-qcom-lpg: Fixes for Hi-Res PWMs
Date: Wed, 26 Feb 2025 15:58:53 +0200
Message-Id: <20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-0-7af5ef5d220b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB0ev2cC/5WNQQ6CMBBFr0Jm7Zi2CRRdeQ/DosIIk0ALU1Mxh
 LtbuYHL9/Pz3gaRhCnCtdhAKHHk4DOYUwHt4HxPyF1mMMqUyhiFI3URlzZMOM49PnnFya04vyc
 MHgdGoYiqslTb2jh7eUA2zUL5eFTuTeaB4yvI54gm/Vv/8yeNGp2uNLWVVeTK28jeSTgH6aHZ9
 /0Ljx58x9cAAAA=
X-Change-ID: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <quic_amelende@quicinc.com>
Cc: Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=dpudgvnbUcleNul+hZceK0VKC5IVn5ot1Wf/pV1Rlms=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnvx4f+K5OoGjex7nW/4xpB3UQMVg2ciOnq4MZt
 AtkYDMMfzaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ78eHwAKCRAbX0TJAJUV
 Vr0OEACaW6bstCuhhC51Fa4BY2tM329x00NpUmyHEZEHxBIZse/iKDaEO/WV6VUbrmq/X03T434
 NnIhP8ysLwmkeEv9WWhs8zMq5a9J/EyWwlFdjaVfZ48BljECe29OdcyKHECnjL80XELXXGmlrVM
 BuSMsfb6tfeDAThAy5DzGtix4gsfI02MxRNevm4m0M5O2Hcy3lOMuDJrHuvO/hYQFexC/jcCopZ
 kE4Kg2UOcvYzRF1ybaqrKkNG+Qvb498LI/Km9cgsxnzPJG9sIaLvN/fJua0b5gBm9PNMLBakZ/q
 GZ+aYOrUgf6gQq3derUoneVLK5ULDArBDqnzmVeqHwXiYxNiNWJKvPuY+K3AbcnwQIBFG7FK7Qg
 nu2yLM9/w5oT+P3keIPs/2oJ/bs/8Jn5vOxKEfAVsMvS3qsr0cvXenDBkcCurgrnYzCSpCAsl9C
 Hxs0mY8SNPdBqmN8MftLsPYdmFumvMnE/illVRHx5ZcDkReetHIfhXmwp6GgwD509Xk5ajL2wLn
 SmdEtJ65L2fyETHmOtpf8sMAsxAq3EdtUJpmPjz5QfeNahRY0nKOiTEl6IvqhDeR6xcD0f+4xj6
 6oeI1+fs95RP9IcOxYMPmszqMlB47Iaii/3nnkiIZvEBjgs9LgvtJT/c48sUOC8xu2qVXoirPbC
 jMi/DoM2CeEg2Aw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The PWM Hi-Res allow configuring the PWM resolution from 8 bits PWM
values up to 15 bits values. The current implementation loops through
all possible resolutions (PWM sizes) on top of the already existing
process of determining the prediv, exponent and refclk.

The first issue is that the maximum value used for capping is wrongly
hardcoded.

The second issue is that it uses the wrong maximum possible PWM
value for determining the best matched period.

Fix both.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- Re-worded the commit to drop the details that are not important
  w.r.t. what the patch is fixing.
- Added another patch which fixes the resolution used for determining
  best matched period and PWM config.
- Link to v1: https://lore.kernel.org/r/20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org

---
Abel Vesa (2):
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for Hi-Res PWMs
      leds: rgb: leds-qcom-lpg: Fix calculation of best period Hi-Res PWMs

 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad
change-id: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


