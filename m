Return-Path: <linux-kernel+bounces-320754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904DE970FDC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6351C21F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77601B1436;
	Mon,  9 Sep 2024 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnVV2TUF"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF71B1511
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866956; cv=none; b=GIl62kjL97gbR7Yfi0t+yhDMXAcjtjtVW2WEppskd3Dnin1t5yqzJuXaZAZWhMdkl/FvBGQMWMbpsIcBjS4kY5vNUMOYS56SA6iS1ppc17HgIv6NNgCV+bFr9TmePIoLDXXp3/4YFUnSYYMLInOEDACO15S3b5+TT11PwYoyFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866956; c=relaxed/simple;
	bh=OCv2tbQ5uWR4HBuQxss51m8LOMkRw5UOdnztcLZ7t10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHJowo9h+cWiUXBRSLqusJgtXZvs8ZhZkr/eZtztugirEAhrFHtNCeu0IuCVO4gelLrosR7rLT7+acr7BuUClGwL/F/+j+gSG5CDKpw3WhlZ9eONUVNv3S1scgoGffdFnMN5Z1nGygak69e3jNpOV/ynL8vl8VGuPlIyqPvwuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cnVV2TUF; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d88690837eso3090893a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725866954; x=1726471754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pM8txHWCWm2GJm5rpiUSna+befFEZvb0Ph4a1zYyG00=;
        b=cnVV2TUFKFQgde8wuKGBRrmoMbgBo2d1W6iyL4lIcaHI0Uo+/cVbkcg0x5foUl6H9H
         65LKFAMMYOLt8gcp7NgXl0Jn3AyuGlYIaZQUAtCICCvxByEtAqtknl8NNle5G69mG0rG
         5pBgXDQalSakTRKrkmq85O6liyxVFWhmyU7s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866954; x=1726471754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pM8txHWCWm2GJm5rpiUSna+befFEZvb0Ph4a1zYyG00=;
        b=a1DsQDnFEnDaILcS3Z3bTGXOYfU3Fzi9+kzg2Z1xUb+pZawgZk0eRZp3GkvyoJjiZs
         zbSsoxVkVmKlbDs58dPT0+FjkeVvol1hM/t7wxCB9e32N3WQuhgj7QmERoAkcpvUoLub
         5gzX2QOPIvCGhuR19UHjjqup+HJc915yUuUtUqYHSMvNAZmrSwx2iFDRofhuPbk1kJFJ
         YhKi95zm0MxyRffYWbPBWUNgwRFxQBSp5AeVawmTqd0tWQPLTmf2hVEjsRj9S0hx1ZFu
         f0vRXTZxLqlFriUUrBiOgwN6j78GOLXcJ/sbYn3N3uJT4H3v8EUEa9gNLQ/jG0aty/s7
         jGlA==
X-Forwarded-Encrypted: i=1; AJvYcCVv8Ye2ZHa9dIZIoU43CkrGl0r0wunZrn/yZyJGa7+WnLmgxbKGDgNvHHz6hrT7fS1uCWOfSqb//crtD9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyay1IbTxa6LKpnUquEkJ8lPK2Qz2F090ZN7jVaS7tcYaoviSJb
	rcFqpMCgNe6mc7QI0/I4dVyJEIJSDlfOhcVh+C3FR7j+nkTPFIGXYVBPuSBAEQ==
X-Google-Smtp-Source: AGHT+IEbTOHDb3hQFJmEAFiA5/NZjRgBdCrO8hmFdHehHIQt4lO8vgj12wqm+tEvF2kI0aM1EP9upQ==
X-Received: by 2002:a17:90a:983:b0:2d8:ea11:1c68 with SMTP id 98e67ed59e1d1-2dad50e8827mr8779270a91.31.1725866953932;
        Mon, 09 Sep 2024 00:29:13 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (30.191.80.34.bc.googleusercontent.com. [34.80.191.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c3c51sm3841065a91.21.2024.09.09.00.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:29:13 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 09 Sep 2024 07:29:04 +0000
Subject: [PATCH 2/4] arm64: dts: mt8183: burnet: add i2c2's
 i2c-scl-internal-delay-ns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-i2c-delay-v1-2-4b406617a5f5@chromium.org>
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

Fixes: dd6e3b06214f ("arm64: dts: mt8183: Add kukui-jacuzzi-burnet board")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
index 19c1e2bee494c98c0db87308494713a26e304cd2..20b71f2e7159ade7e7d2135aabe6587c8f8d64de 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
@@ -30,3 +30,6 @@ touchscreen@2c {
 	};
 };
 
+&i2c2 {
+	i2c-scl-internal-delay-ns = <4100>;
+};

-- 
2.46.0.469.g59c65b2a67-goog


