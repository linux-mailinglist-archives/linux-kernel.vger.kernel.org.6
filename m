Return-Path: <linux-kernel+bounces-427058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E19DFBBA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5A5B23056
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865DA1D89FA;
	Mon,  2 Dec 2024 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A3UmPTew"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC91F9A9F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127393; cv=none; b=oHdPQacKCwTIlWTTi2T0QgdbK4rKdKX4yqawW3GGNpW/1Xj7OsN6ijYzYIFyCbP8/0766ZfwlewkR46LnTsyJcOjgtHjSFJpPkcbM/49lp2K1/+N0TpB5ZOAxHWPKBj5UsiZuPiBCV7JrhnGCMTUH1M45q9AXPQFgtE3/ick6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127393; c=relaxed/simple;
	bh=z6lWNIu1GGYkQCaqJ/kxgszC+2/1aMZsx7ZC0zPdLBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3VW4vrvut3PeKY/gUNbWHIGs1/2GyM1f3qnxqIx0vkvSvScGpAprvndVkczgJh0gEW4wV2OeIHov4OZEQVL2g4knyqSxvVfP4YzuXv/GDkOFWL1kZqmONl8NHJ+YuUMdlE8cNtGUue+UwkKwTw4Ugrd2W9USoLJXalL4d0A1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A3UmPTew; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so2706020a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 00:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733127391; x=1733732191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pg3Yz4At6rILnrTbhiFAD+QZrbg9FZ7kQ3hH3sJqcUI=;
        b=A3UmPTewMQoHi53IeBVTU1qXWEDG+XKJCvWwK838Rlcga3cLWPUihpOBqB1o4/vwPy
         0Y15MD+egSxg0LQY3BISVR0FhvdzSYQ8YxuJ/+T82ik/mgp+qn0/gXbWF5XvDo/gu9eI
         LfiCjCltsO5Z8zMQemwWGaiVTXsx8MtfeYC90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127391; x=1733732191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pg3Yz4At6rILnrTbhiFAD+QZrbg9FZ7kQ3hH3sJqcUI=;
        b=Bhyo2bc55DLGylVIlJbyBdAm7rkkRy1CypyoVpSCJWA5oGIHMeiSASWhaWqiReb5Ez
         Hk0SyXfFD3sitoOC+td7jqG10keU5POVrRc4GYWpi48MqLko2Mxok36jZfLHTJWWwaK0
         U4bPOGkM1UK7EawM+vHxaKmu54mTRkI0b8cYE2pA9jYkuFJKk3XMUDsasZkB+FzjdE2g
         vdQoX9MWuqIuj5vfpjfoDBJHG4eIYAKvAtn4oyRl6oooQcxABRvIvxWIy7Nx0rhFdjWe
         6h+59c3VsQTwvNnvjF7XIrE8pTa2Jfyu0o3o03n3kBz+TxSqkopJtUFozBKCmIoiwHTE
         puIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZBBoRpPwVJ+tdhI6g7nI+jtqeFrNLnIlnxlzH1RV0aKGUInxfDNvYQ7/0XVHvuIkCgcB7OYNqrdXWqQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmvJd+9N2wNn2t8hYdC+gdSzPvF4lZM9DOCC3lkAXMTpfB3QM8
	YB8D4L4C85RkIUjG37Jb0KutjiTeTIHGwtH0yg3qOLnLh3iShhhy1WboB8Kinw==
X-Gm-Gg: ASbGncs4ViIevVeVwiAYdcqZaGFpNSt/inPP50EN5RDJu5EZKb6JJQn7Opl7kNPyun9
	v4mv4ZfnNMp3Wt964r5wL8uR8M48cHeYyJGJKOnqX/jAYxp1NdugV1/qnfPNr9WyoOaLT6Ii7We
	IWHN5VNt+52lyRlpSkAtAAUQe7XI78P1ex/8T3jHHMQykmc9PrHWkSIlvDFBF1qVM6je4KYm5xn
	tbYw2vt03TEHdNKgEvIQhXnKmkirT4uNkT+WvFcAvDqE7C8xLR5TAsySuB9Fpmg8RgH
X-Google-Smtp-Source: AGHT+IEyKQIaeusGCCWVxa+Pk5NLnro9d/aITgSeBa7Kg6kcWmmYAuoWP7vfPPAfBDvpL5S8TRfv5Q==
X-Received: by 2002:a17:90b:1805:b0:2ee:b0f1:ba17 with SMTP id 98e67ed59e1d1-2eeb0f1bc4dmr6645889a91.37.1733127390703;
        Mon, 02 Dec 2024 00:16:30 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:94c8:21f5:4a03:8964])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee488af41dsm6312844a91.28.2024.12.02.00.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:16:30 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Koichiro Den <koichiro.den@canonical.com>
Subject: [PATCH 6.1 1/2] Revert "arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled"
Date: Mon,  2 Dec 2024 16:16:21 +0800
Message-ID: <20241202081624.156285-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit edca00ad79aa1dfd1b88ace1df1e9dfa21a3026f.

The hunk was applied to the wrong device node when the commit was
backported to the 6.1 stable branch.

Revert it to re-do the backport correctly.

Reported-by: Koichiro Den <koichiro.den@canonical.com>
Closes: https://lore.kernel.org/stable/6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw/
Fixes: edca00ad79aa ("arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 39e4f6a560f9..9180a73db066 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -922,7 +922,6 @@ &xhci3 {
 	usb2-lpm-disable;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
-	mediatek,u3p-dis-msk = <1>;
 };
 
 #include <arm/cros-ec-keyboard.dtsi>
-- 
2.47.0.338.g60cca15819-goog


