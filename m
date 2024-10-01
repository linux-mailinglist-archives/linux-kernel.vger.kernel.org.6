Return-Path: <linux-kernel+bounces-345793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A7A98BB33
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5591C231C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3771C461A;
	Tue,  1 Oct 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SjrHo4TX"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C71C3F30
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782297; cv=none; b=SnOWCtNLANZ2XgMyoF5i4U/nNoh5a7XGaNonsKDx7dgp/tfOV76fUCOwxpW3+BF2JnnZH3F/7cL/KyjJgZ0yoUCDqU3PS/8wC2v+oQrLoFRbRWl2jFaU9m0HkDVhDn5U/4aGbxMLSiXXdIXXLNDBo7762s80vJBuf0U2EDMYlik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782297; c=relaxed/simple;
	bh=b34JZVV6rdDrOo+1IYKEQWK5fMYmoadwt0ke1JkYRDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZ9z2JvhatnQS9PUOqdG7cJCyDm+EjsZsGfi5SPBshPStmQyw8ilVKuGHer7wxQepOdK0ng+t2L3ghBrEWtp4pT6NjEjY7VUyjVKTYHnVpNwOdd73IeB8iwana7FCTrSjbUeNSM/FrwkfZmemnlYl7Yc0iZ5iOco0HSU9tKn97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SjrHo4TX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d7a9200947so3645853a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727782295; x=1728387095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7arz2GOR4HIAXAfbaFzx9rN3NGNRkgqXFpAbKN4p48=;
        b=SjrHo4TXvDvAx+bqzf8aKACdV938CHcq6Re1w8RYNZSR2Q1pMi5nYjuMjGm116fJW0
         E/1Hy9oWkbXPdsiW9SHyPZHoYpTmEq6Ci/Bxqn0qwtrIlZpvStyuri3IKDVlC16laU0F
         xWoATYIYTvMOSrJpMyZnj/vHqFWrr71g4IF8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782295; x=1728387095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7arz2GOR4HIAXAfbaFzx9rN3NGNRkgqXFpAbKN4p48=;
        b=uKKYTi70JP42th/xZvePB5Q++NXWQy7Xo1I20KxCIvHfrdqD2zOcpSp7Sl0DuEYrrb
         jV8f5YpF/whqM0iKTuCnY8OUl4dcGGdjybfgQ99X4mBrhMedHj00IiyM7s2YSyvs3i/7
         3VhxjVIS8QYxlMGNJ2wQU8Qi/O8O+Wu+1t7cDBSTXoCKhwlFUSzCZU3X10Pf9KBZZOd0
         PbpIK6O+fs4wv4cpmrsNrD8/V5N569XLan3GrWBIp4AB0jdsS3auqSN2lAQFd/shOe2u
         TyinjwKBo9b4/q0hHH4EcPeZx+oGu0QLpueYJt7Ufm2NxbByy0cJoaxkqyjDt/J5Fb1z
         Bi+w==
X-Forwarded-Encrypted: i=1; AJvYcCV7WbIewTaFUySTwffg3O71KYY4UDrettr6SsPuBxlz1SZrfExpfsUGXsEZpbj0BGZySlI+AdwXM/bcVfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLusCYvyNj7WqfsFSQmvQnBMYZgXver8Q39iIi26ToYcqI2qiX
	/9NZwcryeOJ8k4xBvX6/1SgAEQP2LllHNYHEm/bRxrE0MgsXPDPjM+RLxZZ/QqB2T2/rIXjFz7c
	=
X-Google-Smtp-Source: AGHT+IHdeJ+m2YdxFmcKkDEUnn9huq/Q65T1UQKcTtMSHmlkaYTIq2vIz4YB7usbL5TVj+ABMTIHsA==
X-Received: by 2002:a05:6300:668c:b0:1d2:ba9c:6d9f with SMTP id adf61e73a8af0-1d4fa69ed6amr22343842637.17.1727782295442;
        Tue, 01 Oct 2024 04:31:35 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e044:f156:126b:d5c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b63d9sm7810646b3a.52.2024.10.01.04.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:31:35 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 6/8] arm64: dts: mediatek: mt8188: Update vppsys node names to syscon
Date: Tue,  1 Oct 2024 19:27:24 +0800
Message-ID: <20241001113052.3124869-7-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001113052.3124869-1-fshao@chromium.org>
References: <20241001113052.3124869-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek mmsys is more than just a clock controller; it's a
system controller. In addition to clock controls, it provides display
pipeline routing controls and other miscellaneous control registers.

On the MT8188 and MT8195 SoCs, the mmsys blocks utilize the same mmsys
driver but have been aliased to "vdosys" and "vppsys", likely to better
represent their actual functionality.

Update the vppsys node names and compatibles in MT8188 DT to reflect
that and fix dtbs_check errors against mediatek/mt8188-evb.dtb.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 69390da9cfe0..790315c1bdb3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1779,8 +1779,8 @@ mfgcfg: clock-controller@13fbf000 {
 			#clock-cells = <1>;
 		};
 
-		vppsys0: clock-controller@14000000 {
-			compatible = "mediatek,mt8188-vppsys0";
+		vppsys0: syscon@14000000 {
+			compatible = "mediatek,mt8188-vppsys0", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
@@ -1797,8 +1797,8 @@ wpesys_vpp0: clock-controller@14e02000 {
 			#clock-cells = <1>;
 		};
 
-		vppsys1: clock-controller@14f00000 {
-			compatible = "mediatek,mt8188-vppsys1";
+		vppsys1: syscon@14f00000 {
+			compatible = "mediatek,mt8188-vppsys1", "syscon";
 			reg = <0 0x14f00000 0 0x1000>;
 			#clock-cells = <1>;
 		};
-- 
2.46.1.824.gd892dcdcdd-goog


