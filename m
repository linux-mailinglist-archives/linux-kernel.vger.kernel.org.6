Return-Path: <linux-kernel+bounces-195073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB5C8D473F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0D3B21445
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D112176186;
	Thu, 30 May 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KOKixVyj"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A46F317
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058139; cv=none; b=IhSNsMCkhhOHCWBBVao8ONA5xBcGf1PUrNOCFpEQpWadVV4Ero1lykdbWfTjWToPJr0cHqJTwAoehB5ayX/GUXP9wwf81tVrbfjJyb3JNROfpxfIeYwQHzlhc5i/vNASjiZ843rwsjNA4P5ySKBN3PUFYE6mmWfxUcSQ6RZzwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058139; c=relaxed/simple;
	bh=3pvDzOqGauCPupjcFSsY1hPMvPhsIclEecQbEFRd8VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdAGKZUPPI6vhkyavFAUy8kFcJGC8r6/uNXDn1+Jc0sOA/PYg3dEaVIJd6WwsfT3zw8e2rNTENje1SiGRJIZOaZ6C7ZNCkKQMNPajgo6d3DRuqxdGHInnyrHoDA/d8Bg1fg2Kdc++ZIq3StUs+VCaohhOBvQoHdhIm0M9+p+w+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KOKixVyj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f62217f806so2071605ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717058138; x=1717662938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmWglR2Ij5/TGj5MHHzWjORF1jpZWpClgT/eZSAiwmw=;
        b=KOKixVyjJyxXE/zGv6pVX+zYl6HzS3mUlRy1hUupdMnTF4Lq0/PM7kFcWgGO3XRIoR
         x4VFaFRmweMuNeZBuUG1G+Tcas3eXDdflTmELrEPqjYBOFl/XmEeKjjMh7w/sGwC1/Sq
         I9Rhxoe8nqyJAUzDVhazgmtcPfEMkvHFCzO84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058138; x=1717662938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmWglR2Ij5/TGj5MHHzWjORF1jpZWpClgT/eZSAiwmw=;
        b=oCwvu/itIX7GtVBN6s59qP/3qG9I8x5aghPfy3rbH6gHmfXiBRRRj5ooDDO4T2iuKM
         AInsFJK2Up+iA5jw5sbzxj1RC9Ck79IIyZ29QzIbJXWiSEFf+qj20KkhQ9+TCbEdHpkX
         919jXbiPdeYYkRwwukGTmHAK2cwK202vl+1bOaw4vrVQT0Ga8PiBgmqqcQ23mB6uFUgq
         rdzfugq4SthwFxglpRniZbQbFRSZEz73sAm8+f7HhzSWpL2iOsAxkoe/Vqf+l8H1hobc
         MvLU9gtrk0glo1GT+iWezAn3tzfhYGXfb1erXhkM8/avmbtLgETd/SiHCKlU3YQLyPi5
         u3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXBHpx/F2F9HG76LzRW4yyrfYaeCecBNuPerd2TpsyH/r5iZjeBhmlDtjGXxPWfCQ6TXYlFZc8io/5wk5que4hwgigyEN6doiZKtssk
X-Gm-Message-State: AOJu0YzfnrEwXhtrJ2vuF+/xBDCzBOMQ7VDu5nhoVpSh/hF3DVa04dgr
	4o1hoQboHyMuxInPKEo1+iZCU7vhTMq7xK6e4EFiXEWc/MZRMGO+Rpt0opA3Kw==
X-Google-Smtp-Source: AGHT+IFpzoyjS8oEHpsPco6/0czovfTG+BgxZDwOvkJUGlKruUTXsaiUOVp8Alhb12YxLjpScrPXfA==
X-Received: by 2002:a17:902:74c8:b0:1f4:7f18:6d7c with SMTP id d9443c01a7336-1f61a4db927mr16665575ad.61.1717058137709;
        Thu, 30 May 2024 01:35:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:65f0:63a9:90bb:50b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f617390fe7sm10950635ad.146.2024.05.30.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:35:37 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
Date: Thu, 30 May 2024 16:35:04 +0800
Message-ID: <20240530083513.4135052-6-wenst@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240530083513.4135052-1-wenst@chromium.org>
References: <20240530083513.4135052-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MFG_ASYNC domain, which is likely associated to the whole MFG block,
currently specifies clk26m as its domain clock. This is bogus, since the
clock is an external crystal with no controls. Also, the MFG block has
a independent CLK_TOP_AXI_MFG_IN_SEL clock, which according to the block
diagram, gates access to the hardware registers. Having this one as the
domain clock makes much more sense. This also fixes access to the MFGTOP
registers.

Change the MFG_ASYNC domain clock to CLK_TOP_AXI_MFG_IN_SEL.

Fixes: 8b6562644df9 ("arm64: dts: mediatek: Add mt8173 power domain controller")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 3458be7f7f61..136b28f80cc2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -497,7 +497,7 @@ power-domain@MT8173_POWER_DOMAIN_USB {
 				};
 				mfg_async: power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
 					reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
-					clocks = <&clk26m>;
+					clocks = <&topckgen CLK_TOP_AXI_MFG_IN_SEL>;
 					clock-names = "mfg";
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.45.1.288.g0e0cd299f1-goog


