Return-Path: <linux-kernel+bounces-357077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432D996B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69141C24E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D43D199246;
	Wed,  9 Oct 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eCyq9Ti2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC461991CA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478797; cv=none; b=anQSOK6+l9lCH08TUbPRRZUTLkY8ZyAbglhtOWxlrwkIGy6OFLh0v0K91cZgCkBu5Bmplllth3nOkfR0/PtR3znuoSpPiKdpB7JHaWhMdp8cnh4WTn1SYvVCIFjrHUL6HvjJMYaE32/0ORIXG3duJ3vRqh3mF2jQXJXFQBR13ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478797; c=relaxed/simple;
	bh=pe+VpQKGMR8aKhUrM7Rl9h9Q4U2dC04E46OyljUkTvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CcgeB/lo5JF/DyuGU5Vv2DOTtDNKNUAyuBvNe4VL6OlUaCGF9WhOy4eJEkIhj6Aa01JDKjgfTgHrMfLkcMLH9V7WbV2OQuHnnjw8kCjhBGoBgsx+angFubf/q0J8wuxot9wtqp1CGiPsIBiGybYxgOlKmQ00ETQlv2qcR/ZlgnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eCyq9Ti2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c544d345cso7051715ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728478796; x=1729083596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW125rK1qMhe8tTkPohTVuXewXBf8N5Xg+9sFg27JeQ=;
        b=eCyq9Ti2TBrS40ZZgBs9daiE99FO6KPiXtL6yGlNIuA9O+MSWaNKM6heV0SeMCrnRZ
         bkZ72NTH/Eqhtbt1mJS1sNw5FExdfQNxguzH0iQfubC72xdbse+elRFVgVs5pu/E9+D1
         2P/YyczYCYJ2soY9fBCH3yaCt6bh8p6GetnPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478796; x=1729083596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW125rK1qMhe8tTkPohTVuXewXBf8N5Xg+9sFg27JeQ=;
        b=UHWbmswU/HLvDpciK7qiyrdx7GKnw9M7JezFQGrpJHmBgrw7tngXpLfUs66Gk3rKSz
         Cp9KK5DrvXlbU4UEFPsgLOnzGJrLShGBJ5Gwg5Kj3wF+wsQuzJXkpDqSSf47RK8wD2jU
         1GglRicfPp2QBJN3RLZK3Ad+FLhWqPO/1oTpod1pW2OdAyuQ6WP+94mdz1foMW8u4oeQ
         5b/PFhiMpOjSyAoRlP8kzwW27QsVBOboDy0t66YGee1UUx31CjkYi4+b4RFbLH41XHGr
         E1g9XbE8lj+clbYOPJGbmEkWJiTFo9I6+f1VusFji4augCjvGgk34vaESVoyHtQdbq1C
         CmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1ne2CdhR6DSXL4/kUQFpXWazL9OL7mQYvl9czQszPhXDmIFzHBSna29hXIZk0tCVezRMcChLgx8xNyO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgxs7rp8d4MoFU5GPQINshhuvaGYV8tl2O2OuRd/M0vHhdyfk0
	laoi/OIZCM/2AXVn7zM9G9pBb3XcREONJwvfl5i1OGvmrjGtg7J1uSUbnZW2jw==
X-Google-Smtp-Source: AGHT+IEeIV9JUMTLHFFYpP+b9sau6k/8F8xIc6y7xI2G5swJoYDmvi+4gA/+2cH27Bpzc7lxTAoyQQ==
X-Received: by 2002:a17:902:cf41:b0:20b:9831:9edf with SMTP id d9443c01a7336-20c631651abmr46041525ad.6.1728478795844;
        Wed, 09 Oct 2024 05:59:55 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:bfd7:eb4:8571:b3f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c51c21535sm27434005ad.216.2024.10.09.05.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:59:54 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 09 Oct 2024 20:59:45 +0800
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
Message-Id: <20241009-i2c-delay-v1-2-6cf59721c1d1@chromium.org>
References: <20241009-i2c-delay-v1-0-6cf59721c1d1@chromium.org>
In-Reply-To: <20241009-i2c-delay-v1-0-6cf59721c1d1@chromium.org>
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

Fixes: dd6e3b06214f ("arm64: dts: mt8183: Add kukui-jacuzzi-burnet board")
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
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
2.47.0.rc0.187.ge670bccf7e-goog


