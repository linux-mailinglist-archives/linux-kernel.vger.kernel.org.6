Return-Path: <linux-kernel+bounces-350013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C89A98FEAF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3C128332F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FDF13E3EF;
	Fri,  4 Oct 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LmeB0Dk7"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7EC13D28F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029571; cv=none; b=mxpKPvKwQyuvWGvBrsl52aQxvM0xR/fPq9lNC8zvSzGOq7nHpR5gqG4yVIOdYHgNaR9QrU6rri9j2PdgDiOSnCktRwLViOY58SulAG12AR/GK/DY73v+LVSNoTSuphibb0AJHaQib1DnTLhVfIBSa9CsVdB50EosSM39EnTbdOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029571; c=relaxed/simple;
	bh=2FE5Szrtx2z+QOK/4TmvKwIbSBj3Q+NVD/05cUMaC3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qn4Iq9jzwN5nEKfNRna2d78O/Cbrf/5Mi2Lk0s3500dLrpf4TDD6G2sj/9Kn1OVMfa5JXqrqyGzlOS/0bXWtpSqoVRCIZ45tcLOJmtOPlp5ShpK7Jm2ociHSpTwOtwKjfq22HlpXgF/IT1lDVsk3qxNy5QMfhgHdMOF06lS4Tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LmeB0Dk7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso2094694a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728029568; x=1728634368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gil00WTRUs28RjwOxxPhf1SQACB/MVsyKZW95qYNQ4=;
        b=LmeB0Dk7Uelv18Fa05kmyhREI5GaJ4zazzEXAJioIPGE1I0kte5XInJHnk8SjOvVk5
         qYeC4BJvAlCFAXpNlAmZyis1dChFguXnwW79/3QU3yFOtrPlnfKBK+rV6IcZHQqr/3vc
         0Z//qkEWXJ1DePesa/3aM9N2J+J96O1K6zS90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029568; x=1728634368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gil00WTRUs28RjwOxxPhf1SQACB/MVsyKZW95qYNQ4=;
        b=gHGVWnAZBUURgWeWiv7i9u52/BkuIIg8UxG7SaM6rOuNXSsZyJi1tH9FWs+b/wL8Ng
         SAoMLxnHwt+wCQvd2UAd5ImK5k0GBUWyRuxDwg3cLTQm44qSivIlT/eij6APTaWP9fDD
         bpSfF8sSs6YXCmWcY9F0jHylRHVKkKiCIszDoqhT0WGpUrnl/CeCeX7jrbmN8CLt8HWK
         2d5wRDY1kyGHmAguJvWvgMpxUdyVPUS+IiYoZWu/UAQfHMtWV/vFl5bP9pMqBnbJ+t1C
         sqhkh9cCGmu12J6OpH+BGHmeRZk/MrMJDN6gusmLqi7l8AXGpyiC4jtk1aZR43p8f3h8
         dABg==
X-Forwarded-Encrypted: i=1; AJvYcCXEYqZ2rBniyp4zOAugTwrzq/Q6u2gpS3X1bFZv4FbqeyMHcZdSz9eU6s5NB4XQk9yL/7uPyWin73zXPQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5KIPRAU+iQklXr6hPZRbUBzDbP2Cm9ShSVCOiw2Sj+BFo2mQ
	oyGIbme0eMlHbyKhTvufj0MTIM33HLwKfZqJZcMfPygTiZb/xUuRHsheJmafRA==
X-Google-Smtp-Source: AGHT+IFn9dbv1FKSmefLnlaSAgdh6flAWmhvi+pxqutep67yPjijwY7klZoIY7dKHPFmh46np4cNkA==
X-Received: by 2002:a17:90a:a004:b0:2c9:90fa:b9f8 with SMTP id 98e67ed59e1d1-2e1e5d62794mr2987730a91.10.1728029568545;
        Fri, 04 Oct 2024 01:12:48 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:73bb:cecf:e651:2ce6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefad264sm19401305ad.205.2024.10.04.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:12:48 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/9] arm64: dts: mediatek: mt8188: Assign GCE aliases
Date: Fri,  4 Oct 2024 16:11:53 +0800
Message-ID: <20241004081218.55962-2-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241004081218.55962-1-fshao@chromium.org>
References: <20241004081218.55962-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create and assign aliases for the MediaTek GCE mailboxes.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index c02a93c1663f..e216a0b40b9e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -23,6 +23,11 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		gce0 = &gce0;
+		gce1 = &gce1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.47.0.rc0.187.ge670bccf7e-goog


