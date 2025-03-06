Return-Path: <linux-kernel+bounces-548788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D640A54960
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C3B18955AF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20EB20E00F;
	Thu,  6 Mar 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mHPGusaw"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058120D4E8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260645; cv=none; b=dDP7LURJVKwF6I4RA2ExTYsuUMLQVsPd0V/qVQZXftqi2pmo0OPb45PnKqqoP3xsLNGS4KQHOAjuq8Rh/L4FMal0IdXNXGkz/ZjLwseIICQhnjD1gf3aDAR/nG15lhJBDSH/FbcHzM3Q/m9Wb3AaPvkYj6eDbK5AveiGUGsAFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260645; c=relaxed/simple;
	bh=4JJzIfTPYd1xwS7ML8LLTZkwdWqlo3aofGz7RuYx0M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhMNKRgu1mj59Omx9RS4FBhH0Xfukd+Bdd0ljvq7GSuXG6AyphO5V+72cUKFhf4P7oKssuNI1iZpDvzBRf3UuNxLobzP5U/js8jssIFDMtdiJyiAOz3O5N5R/qeJU7HCETIcYPJpBO1JqizZRiA+ZKmrlDS4EdgciUtyct8esWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=mHPGusaw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390f69f8083so521371f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741260641; x=1741865441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOYk7rkhvjRCnvuEcjwAqfr4aBzSa8a4sxHUvLuLnTs=;
        b=mHPGusawRxmWmtxIQ0Y/xzNuZaGQ7odvmnXCBkyupA3+71Bn/oPSSdoLpZWbSTxrQY
         ECeqUr3yQ1Pb6q8Rdzn9UhxVhtbz4qMmbwPBI27s2OsuL8pDQvy9mZJ6ihuM0yOac6B3
         bSaSUy3tGqHQKKeeXqx11WJXDGlsPR6E+YvJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260641; x=1741865441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOYk7rkhvjRCnvuEcjwAqfr4aBzSa8a4sxHUvLuLnTs=;
        b=v+ohVa8dd6XYzMbpem2O2jRlNnSUMejhjG4hx2TCKusdZdh3ScECOX6UhW6OvzZVum
         ctp5NAGyVqEq5Vw4nHbLyha12hI2CBf2GdzjvT0pwSHetXognCN3itSgWsfWiHuYdqMa
         VyIUzfpL/YUWuA19ojUYfVW7siHMKjfnBG3KbqnDH9PrQTqDpR3oGm5fMBIloDvdOdbX
         apR5evGcg5ShXSMI2hRzjbaMI0aeKVXDOGvbI9Bq+HibEY6+JzQXwAnZKH8jbYnuqAPw
         2ZobgtJsBAlfl7ko1E4DKqSm7s1llmRAPpk/I4DhEPVC6E/4eb3bv47BpG4aM0ZmxkHD
         OSlg==
X-Gm-Message-State: AOJu0Yw1LVWT8PasXrI/KojDwl1wOP/3US3QBZ/t9z3C3y90/l2jPk7+
	VWc+ciOEmRNRROCi49f6il6oQUN5WQY677XyxxipjKGbancTwKoQ7s10sWf2SlV4maL4lzYlhct
	Q
X-Gm-Gg: ASbGncs5zL8/v5+xu8i8tATQ6/vy2maZrpq1ZVVoQoTyPMYf3rHPFJY9rxlvE91Hn/d
	LoP3whQB6ZDXz4XYhTWHlvGQEqco4ipNf3Ax7p9kXjB1pM/HJrrzgKv/dtZhL5LyRUMbhU/YIJx
	NF3ePdqKY/IjBomSQkr8AAqu3jWjuSHbh1pEohA0OdZ8/Cf4cdZEJK2gtGN7w8Ti1mjFOZT9ELD
	uS59R2E6u4RS4u4QNP+aZ3vqWWlsWa0RDsbFr7Z+YHygxMf/WS/StpXWCxRlMBWwI1fCOs4fihs
	7j8m6Tr26uEZJNnHrH7BSjr4MJXAAoQ6PFbad074CXr7TaOcxHiMncC1EfGl7D3BpTfvkU4iuL+
	aqtBn9A==
X-Google-Smtp-Source: AGHT+IF9wWpzzMPt0CHbMykHM/8iRPLGJDIu7l0jbjUlhGcWSWneZbVlhN0tXEjKICQJwrYTnSq4zA==
X-Received: by 2002:a5d:59a8:0:b0:391:23e6:f08c with SMTP id ffacd0b85a97d-39123e6f191mr4148028f8f.47.1741260641317;
        Thu, 06 Mar 2025 03:30:41 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:4703:aa8c:6eab:8161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1749650f8f.3.2025.03.06.03.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:30:40 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 06/18] arm64: dts: imx8mm: add anatop clocks
Date: Thu,  6 Mar 2025 12:27:55 +0100
Message-ID: <20250306112959.242131-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clocks to anatop node.

Add the bindings definitions for the anatop node. The patch is
preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- New

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 4de3bf22902b..597041a05073 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -600,6 +600,8 @@ anatop: clock-controller@30360000 {
 				compatible = "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
 				#clock-cells = <1>;
+				clocks = <&osc_32k>, <&osc_24m>;
+				clock-names = "osc_32k", "osc_24m";
 			};
 
 			snvs: snvs@30370000 {
-- 
2.43.0


