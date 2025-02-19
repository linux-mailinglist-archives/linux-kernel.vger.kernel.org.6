Return-Path: <linux-kernel+bounces-520976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C162AA3B1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F7016A62C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0001C07FE;
	Wed, 19 Feb 2025 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XphNSzuM"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006802AE95
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739948777; cv=none; b=vGA2ED2DFb/8LSVhjFrjXiJTCCr7TqDrvkFtAxEjO3OxRYNwh1YIFMulaeDh697/ThnYs4HDVuQS6awYSOsczPDL6eYJhkwlkBKVEXCCLRgQT+dkDM4zctxpmHS6Aeer/4KoyS0alL4GKMos9/vJKllHLfxaCyAmXdIG6CVAHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739948777; c=relaxed/simple;
	bh=cv3hCe4BuBG14Kjuep4L778ZA7qPBrSRnDpuZRfu9MU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mnZfTdv/yLbGMEMgX5K/4djerjnmsjW4rTpNjfyM773h6udepwHlCWdwtidA8LlVOsUQaCmow+IZpwD3tbpcWtD/gU3FiOUu5gdmP8fb4HTb/tYdsAMETk3+68/q+Qu+Q97BE3jfeTQIWiS07HE9jJK0CFKwjLbSHs23yHRgeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XphNSzuM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221050f3f00so74956485ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739948775; x=1740553575; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbSwhSK8ZTFU53yoJhkN3FQ31dlIF5Rf10aKcQvqhsk=;
        b=XphNSzuMTezC/G70n80MM8IS2aTOHkHmK8IfvFttz9e1GZQzeGvP25saipwePT/P2x
         uqs5/6zjtRsGMtCDc9vhFGehTK8X6ZTVg3H9bgn+0sSMe+bVbz9hVDxgExjXPztcF2TR
         uLbjzPu2RVOO5NH+ZbumBITwiVeRTAqabtfbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739948775; x=1740553575;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbSwhSK8ZTFU53yoJhkN3FQ31dlIF5Rf10aKcQvqhsk=;
        b=gt1HZi89UJpMNS3UVWbaE8df/xC2ejWKRoCqYrg84yTctXSvPLxI7wXE5KuSnjystk
         riMd6zaRpVVT6/t1XF338FCzH5lmQR4XiZPyja/SEiCEr8ZbU0u8pjTcHLoHeqFQUepm
         EtdGhhfRrVEeinw8hDJvGCnImn4a3h7sigyt8D9MIKA2nfHCVPe5zu5NOWVoMM68GRih
         SQVnzm6DmvMaAjKajc/DWA4681u2Ow3hDldTVHJS8e29I5vb1zIj3nX6j50cSWpJnuJF
         kf9NY8V+lJDr1+kFDiw6cCEW9+kpglgtSRjxiatgvF9EiiJh46b6pVZ5Y9nyD/Vnv+YZ
         LVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJA0zsLpFSJYjZJP/LZ8hN9g5QJOOMRD+/y1MDGpMaxQhwVEXw+D2sq0RGNIFV2e6pNXACCUXIUeLsLmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMeCgl7yafNDhk41CgCIeVKH5lbcGUHKfE5VHNIWQCqC0g6AmX
	lxL1PfrVuIvHhBzBowo3w1JqKh5sIEvlIzGDgKUFIEMhp7p1vV7zzXKt85424A==
X-Gm-Gg: ASbGnctQUrYUdgfkTEcFxqYTrFyj2hI29kMC5trk64b7MNsZcC5Bfav0+pGXCapG0nc
	CacjwzSA6VnE6ELncWR0gaEth4sBh3cMeihseQ9Q05BRboX1ui42DMe0Z6ccOOZe3dfKmMMULCO
	4sfWI1bStptSvJEzV6IOPyFCBKZwZcrkbxpeyXj5Ksixq2XMWcpPWWLERbtWTF4LPbyLSBZxFP7
	CN2PWGotAI8uGOkDvOkF3xtfSax+x2Uss9fe5BsvNjtFzh2mK2EgO0CW4kKZzoClfFk9W5G6sxR
	ZttzaFTGS/lz4xsw/OhkpBMTOtNrL9f4vyw=
X-Google-Smtp-Source: AGHT+IFF70Ep2+kZNZBAW5v+lfMi3f7HgzuKvf31SQmVgrU+IbV3fzArna+RG0S91JC0hM/gYW+80Q==
X-Received: by 2002:a17:902:ea11:b0:220:ea7a:8e63 with SMTP id d9443c01a7336-22103f19fc8mr260207975ad.17.1739948775287;
        Tue, 18 Feb 2025 23:06:15 -0800 (PST)
Received: from giver-p620.tpe.corp.google.com ([2401:fa00:1:10:224f:3294:90fd:ad2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5584dccsm97702795ad.205.2025.02.18.23.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:06:14 -0800 (PST)
From: Yu-Che Cheng <giver@chromium.org>
Date: Wed, 19 Feb 2025 15:06:01 +0800
Subject: [PATCH] thermal: of: Fix logic in thermal_of_should_bind
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-fix-thermal-of-v1-1-de36e7a590c4@chromium.org>
X-B4-Tracking: v=1; b=H4sIANiCtWcC/x2MWwqAIBAAryL73YJKYXSV6GOttRZ6oRFBePekz
 4GZeSFxFE7QqRci35Lk2AuYSsG40D4zylQYrLaNtqbFIA9eC8eNVjwC2tp5ZzzrQAQlOiMX4x/
 2Q84ffqwEn2AAAAA=
X-Change-ID: 20250218-fix-thermal-of-247b71be0faa
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chen-Yu Tsai <wenst@chromium.org>, Yu-Che Cheng <giver@chromium.org>
X-Mailer: b4 0.15-dev-42535

The current thermal_of_should_bind will stop iterating cooling-maps on
the first matched trip point, leading to subsequent cooling devices
binding to the same trip point failing to find the cooling spec.

The iteration should continue enumerating subsequent cooling-maps if the
target cooling device is not found.

Fix the logic to break only when a matched cooling device is found.

Fixes: 94c6110b0b13 ("thermal/of: Use the .should_bind() thermal zone callback")
Signed-off-by: Yu-Che Cheng <giver@chromium.org>
---
 drivers/thermal/thermal_of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5ab4ce4daaeb..69c530e38574 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -312,7 +312,8 @@ static bool thermal_of_should_bind(struct thermal_zone_device *tz,
 				break;
 		}
 
-		break;
+		if (result)
+			break;
 	}
 
 	of_node_put(cm_np);

---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250218-fix-thermal-of-247b71be0faa

Best regards,
-- 
Yu-Che Cheng <giver@chromium.org>


