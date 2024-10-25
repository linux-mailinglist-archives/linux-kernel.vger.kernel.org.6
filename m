Return-Path: <linux-kernel+bounces-381208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D9F9AFBF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3400FB2471A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C967B1CBA0D;
	Fri, 25 Oct 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zs8wWcOH"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28D1D270C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843445; cv=none; b=TyNcx/K1s7d3OtaOMLkX5Vd2Kt/oNL/kIxq46+Lu0MjwQZ5/I/IQq3caUQ3Ha8jqG9CIq3nhQeXyIC3p18STyX4tyrkE8aOr0pVz3nLFexlE/a0MpWrfIbDuIiFD7NZ3fR4pvpULgwA4yC+/VI2ZFhjrIzT4lQMQYe/kic4lx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843445; c=relaxed/simple;
	bh=MKqyrRZYWKubYCITWw8Q5TrxroLI8BPgUsq2cs2pJ68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aurzu7pFixWVdnF/y14M3gzVBobLV464rAxKN2d1+KNFGYtF1tNWSJlfmgzxvnW17dTdhBPq6fA0mJhez1t/qDvnGwcQbUtymeRMCKA6CQaJF2JdHUxLjRElwsZNb4mrdVtehkSxxYVTzozRgJJKCl974TzgVJhcMHfXoGrAIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zs8wWcOH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e5130832aso1249784b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729843443; x=1730448243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FboZURjVUcmqOH+JZsWis9+u/grJQW0lknJr+SkmBQQ=;
        b=Zs8wWcOHh/wbG33ETLzeDo1sJbtdUm1l9JaeuNLdwKJFaNAOEIGWVU4uQFmdlxMDvC
         10MPWyFrjhZjLOCKd5fhL0YrDj1KK3kgys4AcGRG0AZ5YigtxJmD0HiCrvKph8j3bTnH
         vQtx9oWaoaWD/TOTa7smxcTN8uVcNYso3b320=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843443; x=1730448243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FboZURjVUcmqOH+JZsWis9+u/grJQW0lknJr+SkmBQQ=;
        b=VHQszOaG8GlmgqZQhNMSF8CnhbP4+yxJv+UEZ77u9xc7yqUnhKeIK8M9B/x4ouexm4
         8XCXsmV8W1Xrehtsxipe2PBr5bDPaTF0iPDxtEOfn7zlGXFOnnktCDSycE34RM+IY5Pl
         txk0+vLbQz/WqRbCUIXUb56yhbNOJ3DqEF8VFXuxvyyFPfOO0cLsGdxB3rkhFju0/88U
         1ymNdsfk/qrqYOAGZPB08Z2ZEB/AXRO7KImr1IOFzyG1ITqFaGsVcZLQzyOzQf2jsWzK
         IXmYj1VUr7SuyaaAOU5YILLwuHyM8G/jWn3WThi8YMK2FpnFF2UK4WhU6G6sVcmLSQlo
         E23A==
X-Forwarded-Encrypted: i=1; AJvYcCXMRnjiK2+cAgotrvxlmf+8vjEq/pcDMIAX/dGIjFhpCEfgOz7XrvuONHVgQ1Z07zedVImDNTvtAkO3p7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwF9uVZoxVGL4amanAXVjLt6E3gB5ES+HIIZf0m2hT/N3cBdD
	5C9j3HuZVGq8hWQ8Ydt1qmkLfjixcOEJ1wH8JHvzT6Qx3hhGu7hIrF4/nJC+WQ==
X-Google-Smtp-Source: AGHT+IE6aEDXPX7OUJEeP1hZS11M8BkJO1fdRVMhfFCbU/94VFdBQ35TBYN0pnrZfslaJJDKjmK1Ug==
X-Received: by 2002:a05:6a00:84c:b0:71e:410:4764 with SMTP id d2e1a72fcca58-72030ba9e6cmr12403053b3a.8.1729843442771;
        Fri, 25 Oct 2024 01:04:02 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:5a9f:16cc:8d5a:55e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d025sm558120b3a.101.2024.10.25.01.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:04:01 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 25 Oct 2024 16:03:50 +0800
Subject: [PATCH v2 3/4] arm64: dts: mt8183: cozmo: add i2c2's
 i2c-scl-internal-delay-ns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-i2c-delay-v2-3-9be1bcaf35e0@chromium.org>
References: <20241025-i2c-delay-v2-0-9be1bcaf35e0@chromium.org>
In-Reply-To: <20241025-i2c-delay-v2-0-9be1bcaf35e0@chromium.org>
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
X-Mailer: b4 0.15-dev-2a633

From: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>

Add i2c2's i2c-scl-internal-delay-ns.

Fixes: 52e84f233459 ("arm64: dts: mt8183: Add kukui-jacuzzi-cozmo board")
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
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
2.47.0.163.g1226f6d8fa-goog


