Return-Path: <linux-kernel+bounces-274244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F9947595
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785DE1F21729
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA71482F0;
	Mon,  5 Aug 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ba9lHxrz"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0013F43B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722840667; cv=none; b=oGzyTh2eNB/Q58moaEPcrjX2BuaUX5h7iQjbaBNz8+E5rXcb6LucikPnG1F3RGbeF5foiUnS8QlpyoDx0+OL+EIJWSi+xXvNsjCA08B93T9OsxwSpHf5PmBBcSKWJMb2PMoaXCjw/w0ORPA3WLaOFnr1m32XrHd6kGttxjq9dWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722840667; c=relaxed/simple;
	bh=nMoB8Z+kiuOwF83wBj6rCYQpxQQX9hZyF8J1qa/VqZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6BbjhkmR6ahDCDClw5LFvenlyRC3TPGYHVbSuhvCpaHg+v6vxqcKDsWT7jAVJbFEEgg6j2wlhd4uVuVChf3akKeiSDQKX2l9DAG5VnEBm8WhcryBcoZIB20kTZgxkwlDbmlW4BergvAlopKLPsQZdJ8j4+fsakc+bSRHNFfozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ba9lHxrz; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3daf0e73a5bso7003650b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722840662; x=1723445462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6p/MeCAGJmUZEzkpiAKS5tn4Lz8oeVbtRys6Pcnb/O8=;
        b=ba9lHxrzwj/5O7EZT2xKXWXhSwmzwaLM+ZK+mNXWUhe3dQmhtqRtRgt1YzijjVY8Sf
         lRBIynywoyos1GtTBEekjfgt2Ilsls9YrEOKaM4Jj3vmoD5XECFUPIaLdpvhOx2Z+bJU
         XY1046nXmYltu+2no8ZhzCmqi9HyiU5OcUTiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722840662; x=1723445462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6p/MeCAGJmUZEzkpiAKS5tn4Lz8oeVbtRys6Pcnb/O8=;
        b=uClKPOiN9a43rqNpja+P1BOEB0kzu5j5kOFFQiw8KpVzeY3eDqGcT+1mqYlQyHJOXj
         Gujdi+Lz/53pkVA8YItpwjQFYih3BfHmI5g3snogZ1zFtz+fysaggy/LNadEVJAWkoGg
         MFClldtuyWBY8ZEJcQJWf0Vdtk1bDg56A1eMDc7BmcfkCZwsKrvp+AEWlW+L75GMXuoW
         3UqYFMg1exPqDgckwHbtE5FkH5/hwMtkxLJy8OAXqOxR6Kw+Y6M7AaP0Ykp2zQ2wESkm
         d07YgexJ74PMcmhzse/6yRhS7/hPujQhFMLsAFi8OBYhUDPUgV0DVMuCZgq8iDChX/CR
         0J+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf8pmA1V06i9nDuAHM+/DgnviSxFAnnNIDjzefFj2Qn3n9XwnhchwUrL1ClcvM9A6uvnL6Eju3bbe6bjIZPC5E7G2sauhvWKHMvk13
X-Gm-Message-State: AOJu0YyIy/x+/7cMLzsVxgZFSy7/h0uWmGaItSh9IDwMQwh8G+lL+fk9
	bYyYywGwSt0hQfPQbyVqrRYzqDq54zCWf99qDFtTNxzzmUQZx1Ky7oZURvDVYw==
X-Google-Smtp-Source: AGHT+IFeX6wpUnZrmWE5aZV2NCgOET8WAh/Xbg6xnvw90WG92Ej9Zh6Sd8ao06GrQ3VZ/X84x6+vsw==
X-Received: by 2002:a05:6871:582a:b0:268:880c:9de3 with SMTP id 586e51a60fabf-26891a9aea9mr14453542fac.14.1722840662294;
        Sun, 04 Aug 2024 23:51:02 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:b430:a369:61a6:ec2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdffe4sm4779788b3a.128.2024.08.04.23.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 23:51:01 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh@kernel.org>,
	Kiwi Liu <kiwi.liu@mediatek.corp-partner.google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] arm64: dts: mediatek: mt8183: Remove clock from mfg_async power domain
Date: Mon,  5 Aug 2024 14:50:23 +0800
Message-ID: <20240805065051.3129354-1-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This clock dependency introduced a mutual dependency between mfg_async
power domain and mt8183-mfgcfg clock, and Mediatek has confirmed that
this dependency is not needed. Remove this to avoid potential deadlock.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Fixes: 37fb78b9aeb7 ("arm64: dts: mediatek: Add mt8183 power domains controller")

---

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index fbf145639b8c..267378fa46c0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -872,8 +872,6 @@ power-domain@MT8183_POWER_DOMAIN_CONN {
 
 				mfg_async: power-domain@MT8183_POWER_DOMAIN_MFG_ASYNC {
 					reg = <MT8183_POWER_DOMAIN_MFG_ASYNC>;
-					clocks = <&topckgen CLK_TOP_MUX_MFG>;
-					clock-names = "mfg";
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


