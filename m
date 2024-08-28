Return-Path: <linux-kernel+bounces-305341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B6D962D37
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477041C2383A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090011A3BBF;
	Wed, 28 Aug 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiJ6jJ7w"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD21A2C20
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861031; cv=none; b=Q4/ymYJCDYaQO0IwXGNpqv8w5Z5FPuhYmt/FIStl/4EAsuWfarXXxJpCAN9C29lWzHtQLY3lWR0HitI5TpZABw8OEDh0KispUkfedrI3BH6CJx5hTCUyXcmF0x4YZMdY6w6uTvRmltr1o+ARxbAW6sbSUSI3ctWRtNEUQ8h+3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861031; c=relaxed/simple;
	bh=ujwNTQtf+AJwJFlFp29hT/8lwBb/S99JhAGeM1B2rQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pd+82UbxCezfXtMTNtGOBaXeXSNpBZ2OCjVk1O1MsxBtSNTDsoNltxaS1bSDsfz5bU/PrPSoA69AjahqUqLqBLOtuGHXKgDf0FZtI9LxJqPzvsxWO7gYsUkdpePJXZ1fDnmBpl5VAIHEZWMhQ4aTNyeQKwZXTiCF2jCsfaUHjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AiJ6jJ7w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428101fa30aso59640405e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724861028; x=1725465828; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6KaeAtS4w+qmZprwWGkoTcR3oRoqE544x0VrIYID4nI=;
        b=AiJ6jJ7wGBtrfQdnJleEMTVoC9oQ6rB7J239p8udRIgAZ9m/DP6krJc5o1qML8UdcJ
         tsuz3a32A1kHn7Thk4M7GAeifj8WtyFx6m7v/lx4LaolukoKr3oZlQ1+LKb++j5Z/uPg
         8sssAOR5P9GHr1QyhelOTSaSc6IWfygkRBJSU+a/R7YjNUAlt3FHeJLlRAnpC1TnqE5c
         uK82cCK6Qh/AtF+VTHuIYjYt2VErj8DQjxFVT+BHfp8zEszA+wfiM9pC0n1Y9U+dbtmT
         RV9EOYSOVVuG7F9ulNL/Mz2Auz51A9VEOgVeg3sdYbHLPPN1jVZF2M08d9iej9FaoADg
         t1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724861028; x=1725465828;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KaeAtS4w+qmZprwWGkoTcR3oRoqE544x0VrIYID4nI=;
        b=TqT5OmthYstmwoBmjtkzFZtxyNBLBkiWWWue5oL31GOnEZaTKHeHk/RMdjA1ZY77b+
         pYqscwhha5xNT0H3XiKov8JdQ50gKDXl5n9ShjtOc9ph2Ie3kIqyI+9Xo5o3A0n6Yzd3
         Zfp4t0cB2Fdq7rjb18C+kvFTu3PQBdtSYb2UIo57KpWnV3CGCGdryGF60nXLF98ZA7tA
         duLg+7bqBFiKB+dBMdnfBDzCAp7s518nx+emMyzxcUylkNoD91eNRz9jzkL4joBmc8g8
         CrmjG/9B8WoY0FwgiFTVjhCo97++qCYtrnHFhKI1gGSoHKM7cJwUCKAPneX+cJuzbvtb
         3T0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPUkIp9k9iU6dX6e5P2HWmLvhR5Pb8SbbHFXhXoKfx8hbgsgoc2vl++OYp40PuOXcHT3asTincO8PdkTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Jx8LxXXJF4xoH3ixe7QcBaJHmU6XJlFqm6Lp9Hmw54c9FHBk
	C0Fhl+Q+yMv5UfKC0hGbgJxmwsFNnXbdOwXUlkMGmnjYZ4dySo6Czl5Q1HiRYNs=
X-Google-Smtp-Source: AGHT+IFNJLAVMcwNXPymIxJQq/HRMeAHgttyxGUyXJwWLcd/lnfaTpuOrUwquFYyUe5TQgAbz9ln/g==
X-Received: by 2002:a05:600c:3b11:b0:425:7884:6b29 with SMTP id 5b1f17b1804b1-42bb0306e86mr1038505e9.19.1724861027270;
        Wed, 28 Aug 2024 09:03:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749b22da51sm153232f8f.15.2024.08.28.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:03:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] drm/panel: annual cleanup of visionox vtdr6130 driver
Date: Wed, 28 Aug 2024 18:03:38 +0200
Message-Id: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-0-0cae20d4c55d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFpKz2YC/x3NQQqDMBBA0avIrDswSYzEXqV0EcxYBxoNSRRBv
 HtDl2/z/wWFs3CBZ3dB5kOKbGuDenQwLX79MEpoBk26J6cd1i3JhCW60xLuqdTMPuJRQx6UIYz
 7twoGNZOxo/Vm7KGlUuZZzv/m9b7vHyCKubl2AAAA
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=641;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ujwNTQtf+AJwJFlFp29hT/8lwBb/S99JhAGeM1B2rQU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmz0phjtvSHrOFyrGNgGpv2xzzDkjRzWePNy62W6N6
 LmPXbn+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZs9KYQAKCRB33NvayMhJ0T8GD/
 wPUgWXXX64GlG0B+hfYGPmDrSlFLTtJ/b3t/QnO+W4vJDitrQ5J0dTrN3b2bj+xzCYNBxBsY6ijiul
 yI8blOZIpENltMyfKhBRxrIeTsPOqZGPDFw6QsF4b8Q0JDJbGurAFwf32yls1QZ5NMmfmPCIQ8+mML
 a7S1v0E9NCRFxKdjgG6h9UaiDTOz5x3W9seglemykWh/I72IoxoUZtVu0kc7T4JQNn6XltvI5N+tqj
 YxW0Fd8AFnkRRuoCyIpo+ji84HuuiKaiEQYxMGFAL30xzr3Q71D8rRXnHP1IF1YmPd7fLVhIbsTeKQ
 O+eHQAnmA035BrbiimrdMbpr0m1fRT1T939ScJnhyDtNxq6oST2bRBhMPIt6ynUKL5iyUUSsK/f5Nw
 Uc2yi60EUG+MBxfiDQQrOsXm5gjCQRvTupX0iydpfexBQXqfZbAf9AcFZC+efdCFQiYdud1drOCPGl
 JHRBfJ11Ml1ku5rQ34og8FeyW6/brafbvWgXA6xV0FBQ77yLgr3BI/KyWGewR2E5zjSN7Ohu2ClbTo
 GqsuTmDsKij4Fi2lV2AIGs1H6WKTYxaFA1Uq/g+fWcflu36Em6avP8aGioTtZJux5z+8YVtHIVTvq6
 BrwDoj8wcvJP1SOUURriQOmoVKh6eAOsgL0alIOvmUlDSHcr4i96GaMXWrwg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Switch to _multi() dsi functions and devm_regulator_bulk_get_const()

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      drm/panel: visionox-vtdr6130: switch to mipi_dsi wrapped functions
      drm/panel: visionox-vtdr6130: switch to devm_regulator_bulk_get_const

 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 212 +++++++++++-------------
 1 file changed, 98 insertions(+), 114 deletions(-)
---
base-commit: 195a402a75791e6e0d96d9da27ca77671bc656a8
change-id: 20240828-topic-sm8x50-upstream-vtdr6130-multi-d1f03595a394

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


