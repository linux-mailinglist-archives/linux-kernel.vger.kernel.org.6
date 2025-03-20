Return-Path: <linux-kernel+bounces-569709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0A3A6A66B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8044189CE25
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0FF9EC;
	Thu, 20 Mar 2025 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HiOL4XFV"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD8A923
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474838; cv=none; b=MSXJfUbaX++8NdTil4Lt0zeYkTtpYks7x1agTjSTgyvUKi48UyR8/epBlkOvQfj4IEO5NEcjl5TORJBxbn/fh3COXbSoZ8KYKxNXxwfySbzgcVUV3EoX3Ken/QGIAN6j8FDyalzhFuQSDNzd8wcznXEesYqIT9W0XXoHy+HtPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474838; c=relaxed/simple;
	bh=Kv6DgyEwXT4LlaYHVxd/YFFj4oxV7X45VzT1+nxkLTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KcwjP1uidcytbc0Dbzb9WOnR8tNhHJc/M2FtsegDL7qSqKC2xFznXT1NhQFTUetVR/PQBNarJiJ7QA3IxI9doA6+RG5P0CkEmonc+PX85N2mlJdodElj27aBSotEEV8AWB4/c7JaPjeTZX7ZX9qcLxISdchr64U3L1qy+gaiQEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HiOL4XFV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso5346525e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742474835; x=1743079635; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdG/4GC9LsJW2kwZwtzr2yUeLZyKqxiHIgM4hbUYaLU=;
        b=HiOL4XFVJj6eSxPIhWv3ATksITq9NgPHTpmWRYV6jB30zazRNXKJtVzBZZbtiAcE+d
         d4IM/XKiqsaBI9BYkSbofN9G2FZ0v2PBqLPEpGD7HNF62CSxeaILkXht3xXYQx84Zm/p
         PT9uvAvmXKptNjknsU8d/7LEX4LWojaxtNJkDnj6QslO4WDbgtLsZREpaAPo+fsmUE1J
         Ja/g2Aq4FgneQMNTKjw7mD6ZVi3lfJfPxW/p8FRU4pq/00TQaaMz6kKnNnQbXprhNAW0
         yuKAbtcxyes9a3q4hBEm+V0dlIskoD9nLPcF2b70Z2dVSq9GKKtqXEj7cvnTTdppl4Em
         B9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742474835; x=1743079635;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdG/4GC9LsJW2kwZwtzr2yUeLZyKqxiHIgM4hbUYaLU=;
        b=MgQECuVFPxhY2zwyZ7NtHl2ws1xRX8f33RDacANbXreYXAiVNVxqoR48wWu1eMtzqk
         8PLg/qL6fwCxptyWszzreJN+XnzLK3cLB0f81YLmMw/SrUeE8rJTsuqjoCKP/VPJeJ3+
         8p1GgE8PzMhoaFi9H0vwKuxvLGHR113uM81bPjufebaiwvy0RtaVsCbmbVSwAMXOfoi4
         LMjJ18Kfuv1/If2jGhTYqZQwkMprGyA/08yakVl7FjaoqRYbbz41C8n/eQO82gQUPeGy
         txcWcH8PGJu/jgIgCuLM57NmMzSqs/eo2osG007jdSfQcrIXoNEtFNgvR2SanUJfzpB1
         bG0g==
X-Forwarded-Encrypted: i=1; AJvYcCUlwELR6RVC2SSzD8V1wn32B0C5jX9RzuJROmxAkFY87NcId/RIFzHRuowijCh70FuAg+6avfzsWAEU8zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXlNchcYFEZUJ+O7poP4SFl8eZDetKhFAeUhfdvAJO/vqYt0o
	h379fLxjmqUchx+MkVTA6pWiuekRnb53g0HvdGmUoEAhrW78wlv5FQqAGZHWIXU=
X-Gm-Gg: ASbGnctprNrVCw+t9ehQXuMlA7wxPgw7/Gu+g6U2qZs0GZC/E/gnQ0DPVQEKPrH5HsI
	GmQw5X9ffjsbyJ1hYLAYFF84sqGd/oH6TQWho9TfkgFhto9bpem6TeBN3wEB3yNbYndPQcVNIv/
	dyMRI7dN8hRh1jHthKqSGtgDRuEHomK/D3ApB748o3gL6BypAojB0VFVhJc4LKh5SapWefulxDB
	nCBjNB+n4XKlYQ38lmUyng4SGRJeTG236xzQjAkIFlbScBWununUy3kmpDc1IVdVngE732DPQk2
	2Ev0Ibujn3P3lbEW1axiGx9OnrNyHefg1eSyZWvJqBqol1ljq/ErPzf7
X-Google-Smtp-Source: AGHT+IHax25gLGxpdHS3niMwhikkYrx+VMfus6GYJ2qGjlQ79/dfHY3I2/Q3s00DhfenLy4B+ToVjw==
X-Received: by 2002:a05:600c:3c87:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-43d43869a27mr42567655e9.28.1742474834948;
        Thu, 20 Mar 2025 05:47:14 -0700 (PDT)
Received: from localhost ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d3ae04a94sm38388815e9.0.2025.03.20.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 05:47:14 -0700 (PDT)
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Thu, 20 Mar 2025 12:47:09 +0000
Subject: [PATCH] drm/panel-edp: Add panel used by T14s Gen6 Snapdragon
 (OLED)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-wip-obbardc-qcom-t14s-oled-panel-v1-1-05bc4bdcd82a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEwO3GcC/x3NQQqDMBBA0avIrB2YpLYFr1JcJJmxHdAkTUori
 Hc3dPk2/+9QpahUGLsdiny1aooNpu8gvFx8Cio3gyV7pYsl/GnG5L0rHPAd0oofM1RMizBmF2V
 Bfx9mYWv4RgQtk4vMuv0Xj+k4Tlq6s9VyAAAA
X-Change-ID: 20250320-wip-obbardc-qcom-t14s-oled-panel-b74fed21d600
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=Kv6DgyEwXT4LlaYHVxd/YFFj4oxV7X45VzT1+nxkLTA=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBn3A5OmilO6wVWLD2IchkPEH32d9GORju2oow2K
 GHkUWav6caJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCZ9wOTgAKCRBjTcTwaHBG
 +KzXD/wKeZCjsO/kY3JRX16qfzcTBitBbnvq2L1FdNOkEtd6psctULBRORgPXNuitGOyIpek+aS
 PApwfKhgyDAztvUmYZ4Ns04HXwsqzIG+4Yw0q1/JH/lTILreZN0GJwxpTtpy/QQLdL9+d/iQzjB
 vM825x8v/gkOcmSTsJp/2qeYc1IFSpFwdiqM0Rmr50m1ZjLfYgxCx6X2jd7uhOwRN5mEK8FfiTE
 pZrx3Gs3hYd3S+uUyQ6U3kOBUDjIGF+DcALlWWZNhvtthl4zO7xmfIHdVu/k3vKGfO4pq5vWVmm
 EpsdZ83oJdQv04z01/r6bzczYpB9qcVX6mBR9n78StzLa1EhQjyq/Wic78SiYLuftGweT9P9Njd
 Q6kNOpT+BYDG6uR9ZjIQDPR9uUPW8XzDqRSwShy9rMD1JVrKSXAK/2bc3ha8qDInThOYcdxOFY/
 Lq/puf9W0tq7oxA2vrZkkcepFxymvACTM8nbhk7RuX2b3NDNzUF/f8zySvXkp+yW4XhbHBxGGxi
 q7fNS+twmdUMNFnN2K8qFhc1ERo/V2PPCtPuehwwOwjF6kRzRubLFseC6JOBbX5f/putOKW0+MH
 PCs8mHg9JGbiTlLKBRV9x6qcOMs2VzN/pDbAKSbZZXZ59BZPilgIIAP2rh8sV8tX17BU57hCTE4
 PrExDZ9VjoVaLRA==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8

The Lenovo Thinkpad T14s Gen6 Snapdragon OLED model has a Samsung
panel. The kernel currently prints a warning due to not having the
correct timings.

This panel appears to work with the default conservative timings,
so add the OLED panel to the list of supported panels with default
timings.

The raw EDID is:

00 ff ff ff ff ff ff 00 4c 83 9f 41 00 00 00 00
00 21 01 04 b5 1e 13 78 02 0c f1 ae 52 3c b9 23
0c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ca fe 40 64 b0 08 18 70 20 08
88 00 2e bd 10 00 00 1b ca fe 40 64 b0 08 38 77
08 20 88 00 2e bd 10 00 00 1b 00 00 00 fe 00 53
44 43 20 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 41 54 4e 41 34 30 59 4b 32 30 2d 30 20 01 cf
02 03 0f 00 e3 05 80 00 e6 06 05 01 74 60 07 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 b7

Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 52028c8f8988d4b771bd2604256aea4cde4f4020..56eb57c8023fbbb5ba39f5fdbfa8e577400f751a 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2008,6 +2008,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, "134WT1"),
 
+	EDP_PANEL_ENTRY('S', 'D', 'C', 0x419f, &delay_200_500_e200, "ATNA40YK20-0"),
+
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),

---
base-commit: 707bd8cceaac1af31d3eeeee166687bdde580fd3
change-id: 20250320-wip-obbardc-qcom-t14s-oled-panel-b74fed21d600

Best regards,
-- 
Christopher Obbard <christopher.obbard@linaro.org>


