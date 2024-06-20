Return-Path: <linux-kernel+bounces-222353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6DB910038
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054771F2130D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096219FA90;
	Thu, 20 Jun 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YYNzqfb3"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38144AEE9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875533; cv=none; b=gSINTJj1mDnPry/vxjHAo4BSCv6AaPTU8IdTPLRzqP1mDmF04gQBJ+sxQj8b0Gp3q3oyvfCmHHUGEsT51r/ISjqBcIxpmoaAS7Se8amneB83Bp8drLsIr/OT5BGTt9Z2GutZetwsKTLKvEjk/G2b5IaOK/gdooI2bxnEs/XjjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875533; c=relaxed/simple;
	bh=TKqkzUYhhfD22w9CKigg9XXTwlv5RIY3tN1qm51ilwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6njKY8LAcwhNHHmP8IlRFB8UGUw8xX8s7MenRInPO/cgn46ELkTlqflQJRRi8+rvBbnE3tyTk0ebS6f5Dhtu8TXxkJzLfv1IXtnwi0uOGEtB4zbdRflF0QwQ58pZFDw9pLjEoV909Dn15AISHax525IkEcnoA04eL3H6afZMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YYNzqfb3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70435f4c330so645287b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718875531; x=1719480331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDZlI2yZ4wi+UH3k0wT+hmOJJKg/VzbaB//Srify4c8=;
        b=YYNzqfb3xNsuGedxo9sPQod2U9yJ5Be+G8kMVn5YfQ8cgDqFQQjFuMr4rcy6olzb2E
         opqut3MdF6A6pl/hmAIr3fSJzPG0JiWjDvyPCxy5pMWQx0xDXLDONzLXZuXXayZC/Eu/
         zS1igSBSVsEFA1VDYq1tK58wNSjGtM44DwC08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718875531; x=1719480331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDZlI2yZ4wi+UH3k0wT+hmOJJKg/VzbaB//Srify4c8=;
        b=qslhSDpCZ8w844a+zFvMARFRk57jrGgfaiZzrCk1N1Gt8O8L34pScklUetRwVhSsNx
         m2BXlOjfwxB/ZLfOvfrVTRWrSpx4IgQtbfFx1kYU+OSBUc4PhNHDDm4SVfcxCTcmcb3Z
         ghrrYyA/NMmEhhQiIKbkLymSj6w6X20MJeYWy9GXI9ca/h5Prr9PI6AC19GZmk37sijo
         rVf0A33vq8ffVhFAuwAc0RxZTiHyugsQMYpA9RRvBnYIfXkfOAMxO50KxGDG0ycf0Z13
         SE3uZif2k2sDxx7au7tAJaq/39Y+mbjW/XA1xN5vCl/54wrK/He/riF9CBcQmaYRuaHM
         XkOA==
X-Forwarded-Encrypted: i=1; AJvYcCXqchHa94lV5S2FfDSQuOfDVmtxUVdNfvz2fu1IpNFJdi6FO/YIOyBAwjGcY/SqdS//beVLxulnIrTBlQoKBjoo5oUYh4XpUySEkqFE
X-Gm-Message-State: AOJu0Yz1TUzsc7DogsfQtSJn75NaOAtvmrxMhsIHs3SLofEp4+ZyaENh
	Iw8fPY8UYrn7CoB6Mb94KQxgkSNto/cQhdxp/NGAX8rt+41H1nFy48mry+1sbA==
X-Google-Smtp-Source: AGHT+IFjLrlNvst0OTexBZLhq72UApS8umR+VI7cUlAbt/0YeIqLW8EGKxs24IIss6Yf64ZG7G1XCw==
X-Received: by 2002:a62:f90e:0:b0:705:964e:d9f3 with SMTP id d2e1a72fcca58-70629c34f80mr4334277b3a.11.1718875530972;
        Thu, 20 Jun 2024 02:25:30 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c53a:5326:7f72:759f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ce168be0sm11866412b3a.28.2024.06.20.02.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:25:30 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Trevor Wu <trevor.wu@mediatek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8195: Re-add codec entry for ETDM1_OUT_BE dai link
Date: Thu, 20 Jun 2024 17:25:24 +0800
Message-ID: <20240620092526.2353537-1-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This partially reverts commit e70b8dd26711704b1ff1f1b4eb3d048ba69e29da.

Said commit removes the codec entry for the ETDM1_OUT_BE dai link for
some reason. This does not have the intended effect, as the remaining
DAILINK_COMP_ARRAY(COMP_EMPTY()) platform entry becomes the codec
entry, and the platform entry is completely gone.

This causes in a KASAN out-of-bounds warning in mtk_soundcard_common_probe()
in sound/soc/mediatek/common/mtk-soundcard-driver.c:

	for_each_card_prelinks(card, i, dai_link) {
		if (adsp_node && !strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")))
			dai_link->platforms->of_node = adsp_node;
		else if (!dai_link->platforms->name && !dai_link->platforms->of_node)
			dai_link->platforms->of_node = platform_node;
	}

where the code expects the platforms array to have space for at least one entry.

Re-add the entry so that dai_link->platforms has space.

Fixes: e70b8dd26711 ("ASoC: mediatek: mt8195: Remove afe-dai component and rework codec link")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index ca8751190520..2832ef78eaed 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -827,6 +827,7 @@ SND_SOC_DAILINK_DEFS(ETDM2_IN_BE,
 
 SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
 		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,
-- 
2.45.2.741.gdbec12cfda-goog


