Return-Path: <linux-kernel+bounces-326741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EDD976C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB58C285E93
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB81BA88A;
	Thu, 12 Sep 2024 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HZ1LgLP7"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22D1B9858
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152286; cv=none; b=A8Vzth7scTtxxzu7MvNeS2P/Povk+KX3AREYnsRMnKdkJVJEAimijPQWsYqQXaxP/4rPSso9AnKRTgRrjjfuUDVcSPNPEX4tnZebpFTKuaNo74ABpRAlYMKgHdmBpkyex4twJbY8rB45TEVsHmXJ4hpXhvtUv1XYJKTZhEcjvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152286; c=relaxed/simple;
	bh=RDZTD0ddsCBrpFPbbEm78JMGTuO/C6UMRKc4Ag2Bbuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBOvths65JEzJy6s1glNW/kFc9WmbZ7Wg5iXeNjnhbIEKxqOzNySLRzUKU4yiV9gVvpATtPYI+SBG/x3E/AP0EwPTqBIcHbv7dO4HsBHWH9xWtNubyBuxlwdC332WLKb2V/ebLSKH7WdPpM4KF+z3yhtjXjCP3hOBLWMB1EqNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HZ1LgLP7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so908100b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726152284; x=1726757084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENHzAa0J3LYULKcETMFEp8gDeg2pft3wUA50kLkpahc=;
        b=HZ1LgLP7UdZsQNPUhIlXvYA4TG5bUeY7ACIWFkStsfUddDyQZ2z8pxtoPeKikBp2Ml
         as2+Vf1UdEzgRPCuIc/DAIkTn1Dm/el9iUcV3jIbgU0uefT0HprmUge9TQ77bwXtlVI3
         y15lGNAmOxWX6T4K6XOicbV7i1AaUqZao07bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152284; x=1726757084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENHzAa0J3LYULKcETMFEp8gDeg2pft3wUA50kLkpahc=;
        b=H6B2LDqlPijLPzYLlMyStTHfBkkAOdYY3DMqRkmf6jVqerIzUEq9P+emnnz9amXJeD
         LOXb9gioY6fG/YAr3y+1Y7xe5GMLEzKezOaGhKj/fFyYqeRXFZCbxIWXq1Lt4jlG026w
         0YFatxQ925AEoHFoXjgNwkjjZGorLikDAavqyKPfNfbfmFysO4cTPLkXgy3htFaIbQe+
         MAUTXQpuBgQ4uQkelLTsQq4iAfHKHMDLKZ99/Mvdyoz7IVWLQG0ulv55PAhhEq6kCucM
         yzXFA4GFiN7QDajswBKYzSRx8ptInlbgsJWxAlMAl5NgV2+xqLWsldtcdsA4BuBE7xcl
         LvXg==
X-Gm-Message-State: AOJu0Ywo6IxcuJrVpBQc2UaBuLEo67TxOYFezDsyYTx5BdOgqC01ZGwK
	NjuNy4p092AXl+3itT5sEd3KcLYjuPvxenaw5L2jzCzFbI/BnEqM/MKd9A+Wwg==
X-Google-Smtp-Source: AGHT+IGmocmHhOdJqPoiASVWIbhrUvuzbyP0frIxr5SqJiWxgxpjRkvqPtBS2tOxjv28s+maVvPRJA==
X-Received: by 2002:a05:6a00:1790:b0:706:a931:20da with SMTP id d2e1a72fcca58-719260654f6mr5526880b3a.3.1726152283924;
        Thu, 12 Sep 2024 07:44:43 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:8638:897f:b6cd:8c44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fdee186sm1826269a12.85.2024.09.12.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:44:43 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>,
	Fabien Parent <fparent@baylibre.com>,
	Jitao shi <jitao.shi@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] arm64: dts: mt8183: Add port node to dpi node
Date: Thu, 12 Sep 2024 22:43:59 +0800
Message-ID: <20240912144430.3161717-3-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240912144430.3161717-1-treapking@chromium.org>
References: <20240912144430.3161717-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the port node to fix the binding schema check.

Fixes: 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409110843.Hm5W9upr-lkp@intel.com/

---

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 266441e999f2..0a6578aacf82 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1845,6 +1845,10 @@ dpi0: dpi@14015000 {
 				 <&mmsys CLK_MM_DPI_MM>,
 				 <&apmixedsys CLK_APMIXED_TVDPLL>;
 			clock-names = "pixel", "engine", "pll";
+
+			port {
+				dpi_out: endpoint { };
+			};
 		};
 
 		mutex: mutex@14016000 {
-- 
2.46.0.662.g92d0881bb0-goog


