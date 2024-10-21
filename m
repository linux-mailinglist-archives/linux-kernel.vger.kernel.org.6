Return-Path: <linux-kernel+bounces-373879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A29A5E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100E11F21C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2F1E1C31;
	Mon, 21 Oct 2024 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K8A3XPin"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F21E1A34
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498424; cv=none; b=LXZuZU5L5M/mqMf+drc7heFpjjVxBr0XS2fVhTaATsPZhiqDiD6b1dBErCtwWhDPzp2cOUE9hBldAQl54F0+bxRzcoxQVo2FFszpjPoCVb1vwia0OQx99vCCZ39T09S1fYBaEByo99iMoQbJ/ZUG2CWH0nbzmxXhvrvy7oTxyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498424; c=relaxed/simple;
	bh=Au4bEQICCx4ikxrtnMJ+NLrW9YgB5XolPwwuPIaaXdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aad0uwkhYuiG1slFn2r4D2eeKs2+rQcDswS7rr3DnO3rJV/fR2//JVMp4dD/oHIhy3U2Nc748gNPbOD6xMJDr9ZoZvQ9f878QJDpwCSQA90XEzvb08bqpEVY2s4wFpr/nC0OMMKFNyb+F8OeQMJYGzYnSWjseQrdgf1XyMUDiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K8A3XPin; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71ea2643545so2424884b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729498420; x=1730103220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnvHyOnj93OGsSuS3Yy5YdOPX+qDA4+kJEwXl0YhTUg=;
        b=K8A3XPinCNIVZLYIMLGW8+r+I7ZBguBm+4mlRebMqDz0IzF5HQX9xITIpAg3Xo+V0/
         RbRR/2cx8cBaJIIZIkLrmxfdEVPBryFc4Hzo5RZZ1Br3Aqp+hvXxPEbt+Ylx9Bs65ZIg
         UP5lDZnvrH3G/cQNwovv14JErKCEYUNshlx+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498420; x=1730103220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnvHyOnj93OGsSuS3Yy5YdOPX+qDA4+kJEwXl0YhTUg=;
        b=unJ3TlP6wFZR3fBmen8fTNon8RS3tdmXTR3v29VCafyHzqsYogshY9348GpIgpy7Sl
         HDV7i7FyInix2iSmICJAGBSc97+rqfz5zC8GKOv2n4RD4M2YkwOFRY6vv00jSWUh2N2P
         6O4d557ipNq2k7us5n+45qfyx8k6WFKf2PT82mLyJpzdo8/rr7yNGqvB29aA8k56Lp7e
         GKWQj6jXb/10jFcUojhn/FFFHtbv32qcfeOX4cXmFb28lqt6/NptgYkxB3dePZU4ZR5L
         0Q5D12OjNgO1oZNE98uA8w7w/HxYm3U61q535TjAPWoZHVvKDw1I8L6DcZmPuzUHSauA
         /6mg==
X-Forwarded-Encrypted: i=1; AJvYcCVmyfXADKWwZ2XLa+W6a7EY4Rjb7G2gH7Z9jT5dBocOfjPH+fCZe4fslrcpq0T4YO/oJnT0Z8wHIVOKaI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQZdmCjohS+LZtwKSocBKWVNxOS5jp0/V0BrXYdiZkZw2QksQ
	Qpux4nPHY7mgRFqiVV4N6EGOVKcYVmOiRyXNOYku3Wmk9t+ZaGHrFvRAIlMOng==
X-Google-Smtp-Source: AGHT+IHTst4CzwxlMo6qckbiC0esr8PkpKeIcvOCjqA/wtxgMHgUKyWplxQGBAiUUbJyZZiGDF4Cxw==
X-Received: by 2002:a05:6a00:2e1d:b0:71e:744a:3fbd with SMTP id d2e1a72fcca58-71ea31d3048mr14987728b3a.20.1729498420532;
        Mon, 21 Oct 2024 01:13:40 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:66d2:3298:fcb4:c6c9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13336f1sm2291945b3a.81.2024.10.21.01.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 01:13:40 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mediatek: mt8188: Fix USB3 PHY port default status
Date: Mon, 21 Oct 2024 16:10:47 +0800
Message-ID: <20241021081311.543625-1-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T-PHY controller at 0x11e40000 controls two underlying USB2 and USB3
PHY ports. The USB3 port works normally just like the others, so there's
no point in disabling it separately. Otherwise, board DTs would have to
enable both the T-PHY controller and one of its sub-nodes in particular,
which is slightly redundant and confusing.

Remove the status line in the u3port1 node, so it's ready to be used
once the T-PHY controller is enabled.

Fixes: 9461e0caac9e ("arm64: dts: Add MediaTek MT8188 dts and evaluation board and Makefile")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 2710e18ce696..3d11a989f39f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1961,7 +1961,6 @@ u3port1: usb-phy@700 {
 					 <&clk26m>;
 				clock-names = "ref", "da_ref";
 				#phy-cells = <1>;
-				status = "disabled";
 			};
 		};
 
-- 
2.47.0.rc1.288.g06298d1525-goog


