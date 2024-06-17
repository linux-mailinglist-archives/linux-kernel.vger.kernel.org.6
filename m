Return-Path: <linux-kernel+bounces-216992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A7690AA6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD95B2775E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1793719148E;
	Mon, 17 Jun 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1Q1oNn6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004D190682
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616119; cv=none; b=CbyFNjlBBfoDT3aPk+nvFnCRcw4vu4Rx8zwnPt54rdo1so7Ulm4tJ/yqOTOiB6vJ8xiD4Fk2EO1LTxS82CTv3hF0soamypXmMG/WFhx6nQ/wEMTskTT1F0QPrEPds+iGzsxsplDLh+aYaJf3woVzsCSSf1R9K8v8FQWmreV7+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616119; c=relaxed/simple;
	bh=xervD/akNAn+3bajOSvxHM3QVMxTAKhY2J5D0oWTDdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMdhxGwNSzt5CfwfZV610wzzVUH88JcAO/Uwwu4KH5c4p/5xYSsExyMiMTctveqBACjrA6Ns1dvl3BZHibh7rQhcukxWJ+OJaN8hereofqPaUJu3/hrf6koT7c+WyBTtwXOvcppR3wgU1Wx0RlLR7ZbbI8QQ/2tLJ2zY5rbl/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G1Q1oNn6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso723123766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718616115; x=1719220915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AL9vCWb26ggkgGLF0K/9fugVAtzgFV6EBJsc+Ci/VT0=;
        b=G1Q1oNn6T/Jaqo5wZp9huewBbTTqQ5sgGK5mtxFu/23kNNGA/qAyAOvKf5kRG1d/ID
         uTVt5qGULWTyBuoCd32RTaH460iyNEajbivXwA1dWdd9rHwZO4Scc2BYcwsUb/U5KclO
         6bA3g9p2LEb+4Oil6gB2DfPsY+V8W8LKYVmJB3mAm+Y9ySUk4g30AAQOSSBfkC1SZ7qf
         tAIA4eEP4hlbV99AKa+v6SO5YtkjYW70vYosdmRl/bAwLleUHwTFcaT2aOl5QfMMIsl3
         JSsnWl6khA+BPiSzrcSlrm/TzIXPiddKGqXe0edOoHAkU74+w6I5hhBsr9EYJBhNARp9
         jNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616115; x=1719220915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AL9vCWb26ggkgGLF0K/9fugVAtzgFV6EBJsc+Ci/VT0=;
        b=Qx5J3tzh0SVrr6ZTTSGLeedCPbPkr539HtnT4mUwjtk+1HvNkGRieAXyhobjcZezXv
         ARoPue3a5BC7qVLRcIxWSsrlfDR7ZB5p68c1KNt0Vy8MMQCAMZwCUIWT1ix5TJ26VzK8
         T/7udqi4UaD4p3S5lG10dWMZL6r6DVbhqBU7ovZL1MPOYPmOwTU/+7VdjVipFXwg5Q5G
         SYwXnYxxs0jBF/i+OineAAmC3JVyWFGhQ6RwXTkBxqwnaoBQm4TB02yY4wi9h0LAL///
         3/lPSND+45PpFBy08GW4Z7nrCjw3hIU+gDk/gw6R9kh/NlOhWYIrHrJUyJnHyO+vAwDC
         s36w==
X-Forwarded-Encrypted: i=1; AJvYcCXnCj3NIGVF4Rr0NiPmGjTk4M9VYDx1XXu2g5zuOBOIUNZucJvzvMgeBUkWPq5QWTCbM7LFlSRyGFG9cSmtwToe7y/rP9hpDL9byWgc
X-Gm-Message-State: AOJu0YyYACAaHXiOshILBxVKyzX4/Jt8ujQnrjRB+TRx5Lk/M1uYNzWC
	h2Dsw2acirZYVMrdYsBogRLw5BuyUyeit5n9anvYfQdaQzMWrnXfUsBU1n2iP6c=
X-Google-Smtp-Source: AGHT+IFLPbl4cACD6B5wyibfTQu8bh5NfSr1rfSOwZYEb5WkGOlYQmmuS5S7vCodWDvRJd2pyBRJcg==
X-Received: by 2002:a17:907:b9d5:b0:a68:b159:11ee with SMTP id a640c23a62f3a-a6f52403808mr813822266b.12.1718616115319;
        Mon, 17 Jun 2024 02:21:55 -0700 (PDT)
Received: from krzk-bin.. ([78.10.207.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed359bsm497944966b.137.2024.06.17.02.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:21:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ASoC: soc-dai.h: Constify DAI ops auto_selectable_formats
Date: Mon, 17 Jun 2024 11:21:51 +0200
Message-ID: <20240617092152.244981-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core ASoC code does not modify contents of the
'auto_selectable_formats' array passed in 'struct snd_soc_dai_ops', so
make it const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/sound/soc-dai.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 15ef268c9845..279223c4ef5e 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -361,7 +361,7 @@ struct snd_soc_dai_ops {
 	 * see
 	 *	snd_soc_dai_get_fmt()
 	 */
-	u64 *auto_selectable_formats;
+	const u64 *auto_selectable_formats;
 	int num_auto_selectable_formats;
 
 	/* probe ordering - for components with runtime dependencies */
-- 
2.43.0


