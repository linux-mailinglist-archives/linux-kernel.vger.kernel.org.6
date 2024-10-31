Return-Path: <linux-kernel+bounces-390732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB43D9B7DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC151C21914
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B427E1BBBC5;
	Thu, 31 Oct 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOt3HyqI"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D21A3020
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387590; cv=none; b=kKqWTZxq4vDnyFPshx55ZUoENpTdzoQNz87bNddNjrlzso+CkmBo67Zmhnjp1QbLvox8Cc283hyp1Nhqksl2vuyzZJFLbXbh2TG7bd4bY0eG7Jw2XUfHZZYk0iPgi6QNgTvRXMQnE0rHdoZUhNut76oDxlPRP4lZIChlIsvok2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387590; c=relaxed/simple;
	bh=Rn1RYLNCY+va9n7q8LPSyO8/hYLl0U5QTd9LaR9C9cQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q0DqF7PhaUSs7uBQBSDIQXqoFtuFZe++xHKeM5l75x0X6gjRqGQz8MBaEOU5q62Cb6xNHLCYTxCUE2jQuQgs4Qg6In0N4ywpRP/T3M0kaCwQH5FzJUSLCxDpJL5LN90aVsUMQKd1K25MVvQY9geTQjDF6HLRFPw9+/vUV7ahYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yOt3HyqI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so769240f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730387586; x=1730992386; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QK6XObohq4uefX4FllQNUsdSLzEjHl95slKcZ/jajZE=;
        b=yOt3HyqImB+2bN6y8TD3zso/DBw1yC4puIrPcvwZP4HGkb/pJ/RWXssuQrp9bhhznb
         Gtv7Yv7HkD37MEgP9bPg3JYsc8KssZZMYW5b56au52aemNvhwlAfoTtGtUWsrdcLHYZm
         9gemitG0+SC3H3b1Ua9kh0e7eBXwfliX9aV1IcTPqZL2Ikt1iRuktM7teev0CfyCSYRq
         ArRdpoIPG/nitOTmdTLsbgediA88x/aCvKNTmAI5wXdJxn2xmjX+touw88xi8C0IB39D
         NGmbbgfdngWTh2UvaevsZF4Y60vYymoS/7RhwlDnznL3+feRLtRHpjvlWnpzxG2pxVXO
         khmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730387586; x=1730992386;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QK6XObohq4uefX4FllQNUsdSLzEjHl95slKcZ/jajZE=;
        b=J+MJKg9lFdn9FefO3bf/H7G5R6mx6cy9aACvLb3gH3VmRRBb9qgGVhjHAPuu/xLHOK
         zJNKfgyWVwtJdMEgFV1Hrf6wzvvDbPcrIzUZZLotHo8gq2qaU3HXpOe87Kw5IjwJC83y
         496qffA+acJx9nxSik3BLu25dembVvobD3t04+C+2KttUw0dayqnFrLMFNYVjcZ86aUG
         W0F2Fjohs5v5LB3XFFDYLvb5GhqoxgcyUuWfiYtQR8XR5+zw4E4jLzhHP3mGyIrarXaM
         c7tSLLdP6VoTCyjvCB/pokrloF4joQeGB+x/bwmQleybLazQ43zzSSeXwbbmjf4G9Za4
         eEOA==
X-Forwarded-Encrypted: i=1; AJvYcCXtY8Rl4RIluMhSo687FZmU3q2CM2W1BvemOpvpb7zEyyUyHbyrKqNoT9ulkaDsg8DyhKWfc86hyTe+q58=@vger.kernel.org
X-Gm-Message-State: AOJu0YywSbveRrEa3uPoCQtyT0T3mFuTY0XxG8lr0FoMkro0EFr7LdtJ
	DxeNbpqNPzGeNKbGlMwE9H6oYEj85RJBvOnrxiv0pSCXCHM42PRvi8WvxYWBUkg=
X-Google-Smtp-Source: AGHT+IH/XyinT4aMIAmYRz/XaV52NMVVzbhuefR97ibNrrBU8D+UOohufjTYAz8u3fZprURgTQGTFQ==
X-Received: by 2002:a5d:64c7:0:b0:37d:4cd6:6f2b with SMTP id ffacd0b85a97d-381be7c6d38mr3172585f8f.14.1730387586155;
        Thu, 31 Oct 2024 08:13:06 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e734csm2418920f8f.60.2024.10.31.08.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:13:05 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH RFC 0/4] drm/dp: Rework LTTPR transparent mode handling and
 add support to msm driver
Date: Thu, 31 Oct 2024 17:12:44 +0200
Message-Id: <20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-0-cafbb9855f40@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGyeI2cC/x3NTQrCQAxA4auUrA3MtP6AW8EDdCsuxibVgDMdk
 iBC6d0dXH6b91YwVmGDc7eC8kdMltIQdx1Mr1SejELN0Id+H8MQkTQjVcyWMRHh270quqZiNSk
 Xx7wQo7FjHI4THR4zcThB61XlWb7/1w3G6wXu2/YDCFEeP4AAAAA=
X-Change-ID: 20241031-drm-dp-msm-add-lttpr-transparent-mode-set-136cd5bfde07
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Rn1RYLNCY+va9n7q8LPSyO8/hYLl0U5QTd9LaR9C9cQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnI55w2gGvSWDHYern33C/bnQFSzNPqE4J8vopZ
 EoyMlfQF8uJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZyOecAAKCRAbX0TJAJUV
 VgJcEACbGTPeHw0+Q/6YIPqnU7F3yFTCeTLPbJVrwZN2m/7kCuENAobZov43TD5zZG18pIx7ch2
 ecQLN/QlgWU6g0oll1X0ody4i6kKCsREC8ACcaSt6HhxFCCmY076kxQjU2B7VV3r0zLfl6Gy3ZW
 L7O86IZVvUTASSYBy3rrdbkhGi6JqUVJf7p3VM5ehGeuc/cdqH25LpQecwfOmq16OC6520DIFqH
 mch27QHafcyo+lBH4FqwaW+OE84jHhWHUUSPtOnJkj5m/nwNirepSoykqv0gT+YU0plToBHtFBF
 7xshbfaEdzDD5Y73PdB01xzcYWKJcBFd0Z7syDG/INa1w8xb3WclLBZNOP08LnITbDtMKqAJiyt
 Olv27jx+HU2H55J972oIw7rVhUbW4crjCHmrOfQOjHtASg3ZeY6cekuSSNU/em34/+uLs7P2OIQ
 UJg4BXEvOKhfc1+72APJ++dH+765KrsKLDoV1/LQ1Bh0LRbEWG26PkxuZbvA8ARQafNsFuWyyXe
 gca3pn4JJqcYzFUNHZS9vNChOotfgbe0DS2q8XeoQiH6w5CkgnAHJl7AP2DatujIiymGr8jzxEL
 Emzm22xV2yTlsIi0Ze2itmEIg/8E7n0HPhQOqDSYCdZU41Dsh8/wNITpjfCiP7Q0iCeg4yPBshb
 9qM/ZQtKSkxXFjQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Looking at both i915 and nouveau DP drivers, both are setting the first
LTTPR (if found) in transparent mode first and then in non-transparent
mode, just like the DP v2.0 specification mentions in section 3.6.6.1.

Being part of the standard, setting the LTTPR in a specific operation mode
can be easily moved in the generic framework. So do that by adding a new
helper.

Then, the msm DP driver is lacking any kind of support for LTTPR handling,
so add it by reading the LTTPR caps for figuring out the number of LTTPRs
found on plug detect and then do exactly what the i915 and nouveau drivers
do with respect to toggling through operating modes, just like the
up-mentioned section from DP spec describes.

At some point, link training per sub-segment will probably be needed, but
for now, toggling the operating modes seems to be enough at least for the
X Elite-based platforms that this patchset has been tested on.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (4):
      drm/dp: Add helper to set LTTPRs in transparent mode
      drm/nouveau/dp: Use the generic helper to control LTTPR transparent mode
      drm/i915/dp: Use the generic helper to control LTTPR transparent mode
      drm/msm/dp: Add support for LTTPR handling

 drivers/gpu/drm/display/drm_dp_helper.c            | 17 +++++++++++++++
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c                | 25 ++++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_dp.c               |  9 +++-----
 include/drm/display/drm_dp_helper.h                |  1 +
 5 files changed, 47 insertions(+), 7 deletions(-)
---
base-commit: 6fb2fa9805c501d9ade047fc511961f3273cdcb5
change-id: 20241031-drm-dp-msm-add-lttpr-transparent-mode-set-136cd5bfde07

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


