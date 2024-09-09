Return-Path: <linux-kernel+bounces-320755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D530970FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A621C21F53
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3DA1B252B;
	Mon,  9 Sep 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MZa6ALjS"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762B1B2516
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866958; cv=none; b=d/9/N4pWIIpY1aUeOQY4Nd5g6WNQzv2pq+KLrC9dpPqxSDGn579ZcylkmQjb7pbXw2gaRQRADDLQHcRWGM7Nmrq4EJ1aU06NNyA/xM/uouroREyyvI47fyEK5azjuuVFIDz+1ZyZ50az+Ygcglr9oWo/J4o/5l80c7Kn9FLLmTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866958; c=relaxed/simple;
	bh=8UibZ3uXYG2UBfk3N3nLRgW5LTyv1BfVUDlFslh7MIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MTX5+g+imIx9uQwrhum1TBmVIDEuA+DieOYLvZhK0iF2J0DCTaiIoxCf9+DqiNMCBzYXBGRfszwxQKd0gL4/S7FTcgnXjgDQvJJ+P5pNV9gfjsqkbYsdWNXb+8vI2M3omjCrXiJtmDKbRIcVPg/CL278ARVJoh6EnUhxObbgswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MZa6ALjS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206e614953aso30246775ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725866957; x=1726471757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EbzoF2CIeQ13tOfcxQzqTx9tox0wQ/Af1PggQmUsF0=;
        b=MZa6ALjS65jB3ky8rIm1rIfqdu3x5N2UAWEU3tY22W87gRIw8EcZbHMrwH2BX9wr2h
         G+Xc559qm/iAgThUv0MSVhXucnwQJJmFuYNSyp0oeMIL0mMAb1JTYjT5Uhum6a1mUvr9
         753dGYEwAtvZUS53liRNnY1EElgSL3uNJfeJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866957; x=1726471757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EbzoF2CIeQ13tOfcxQzqTx9tox0wQ/Af1PggQmUsF0=;
        b=O6wscAHHJqKxxf3NV+8kjVIy/fpQAVdkjgwKS6mV//1Cz88Izw/olt4VxzldHYQ7Gy
         VEGhoPWirGU+iFw9QlL/5jWmFryXAyr3kF3gt9HkYiUqI679cRgWJtpmobMnbkIG1kw8
         YUApAx92XgwCHzHPzPLhswhqk36x/TBA2gO3+AWyC/QKKbW9nB7fw5Zm3IZz7hI1dE67
         z6yXPxnRqMWV2Ys7BGgEm4SnEVbo/so8xbiWGBaXXoxxACUKZ3y8DXT92Pabr0l5ZFZm
         bnlBpK0KgpkXYxbpRj3S36HkWNkiy3VZ7TOLaGTBfBker9dwDNDbaf8+ZHHYPtKb+qSY
         +VRw==
X-Forwarded-Encrypted: i=1; AJvYcCUolQwmv+M0Z4Zb8ei/GRmE42gyiPmeo0r7YVKN3jOGNK2bZaChJ/lmNarWG6KM31HIZPPU6pJRxixaiiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM94HqwUaWXWBNoBUfMUPCLVzBB893Gj0482CLLyeil+89MH9n
	1eCNvjnIki9wJh13QLW1MI031A0Yz1mEHAM/tWfOl1vjIDCms2gXfgmSDDjG6Q==
X-Google-Smtp-Source: AGHT+IFjL7b062+is93Jx29/CRZIbtK03YhVGX1Pg1wS2Fwc/CY8oz/ekfV7ybVyzECSpb0riIOWOQ==
X-Received: by 2002:a17:90b:4a46:b0:2d3:da6d:8330 with SMTP id 98e67ed59e1d1-2daffa3a743mr9135392a91.4.1725866956638;
        Mon, 09 Sep 2024 00:29:16 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (30.191.80.34.bc.googleusercontent.com. [34.80.191.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c3c51sm3841065a91.21.2024.09.09.00.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:29:16 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 09 Sep 2024 07:29:05 +0000
Subject: [PATCH 3/4] arm64: dts: mt8183: cozmo: add i2c2's
 i2c-scl-internal-delay-ns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-i2c-delay-v1-3-4b406617a5f5@chromium.org>
References: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
In-Reply-To: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>, 
 Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
X-Mailer: b4 0.15-dev-7be4f

From: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>

Add i2c2's i2c-scl-internal-delay-ns.

Fixes: 52e84f233459 ("arm64: dts: mt8183: Add kukui-jacuzzi-cozmo board")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
index f34964afe39b5353de7b17e82d14d1fba88551ab..83bbcfe620835ab6d34cd2f4c2183fbdf11d0909 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
@@ -18,6 +18,8 @@ &i2c_tunnel {
 };
 
 &i2c2 {
+	i2c-scl-internal-delay-ns = <25000>;
+
 	trackpad@2c {
 		compatible = "hid-over-i2c";
 		reg = <0x2c>;

-- 
2.46.0.469.g59c65b2a67-goog


