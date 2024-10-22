Return-Path: <linux-kernel+bounces-376878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFEA9AB700
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D26B248A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66961CCB2E;
	Tue, 22 Oct 2024 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFdcJ2aJ"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE11CBE81;
	Tue, 22 Oct 2024 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625784; cv=none; b=pkTU5Y/gMY9yG8vZkRGoztnXRCoYtpBaZSKFl0/reEYf2QsTYUE4pqCE1Hgy4kbX2rw9L5mOhPU6J6wv7BSK3L9GhYqbDOoaCP2jcLKHxg4S9WYj3ZLXAQILqZWGXPCNmlkNGvqKndvhX86WnjtO9c82wyLRK/d7bRPIQvOP99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625784; c=relaxed/simple;
	bh=QHXi3kubkLT3UcKZqx+ZWaQgpkFse+Jk0x9EFt0I2RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdTaPeRVW2AxTKtsCh5TaEl87mrw2TOowpQF6p2VjB53gcoROEy1fgDO+pGqui2WLq7mRvrJ1FWrLbkTd3gxpCynpyWvNriPNVsABW4Y7aAM4yOMxFWuxa530NUDM/6Fi4fVDlCYfxJpcbVYXzptwA9iQykXML6YmVybGJc/jkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFdcJ2aJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so120196a12.0;
        Tue, 22 Oct 2024 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625782; x=1730230582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX3rGRTXjTnfbyh3jkkVkK45Jb1/cfnPyM7MP3Mq4nk=;
        b=PFdcJ2aJ5leGkt5pDIb+XKvra2Ei86mqG0pZYQFLoZ9pxI2kWk1lCG87ZMq78mdKT6
         HFtsKoYAue4wcuboNEH4FguYu2eI3Hsth5Q9VjoJg/1LkDKjeOzANgPErbhrYDvF7+WV
         DN7GoQO/Prt4HvrqEbZw8nF2dOrIXBd1qUDsVUErL69Ti4UH5VIJgPgSTcOEFD7FHIf5
         0TefjukDzQLyM6lwVtQLtavSdPgCyovceHVcx0TPRyVQGPrZWmjAUEKgZ4TuIUintrAy
         gO+PlJ2s3pWGQ9dWZjzEe2/jTXcWYvjNwRKJzTocrNgLGyBgx14Bpp+0BThEvhOVFPC7
         1TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625782; x=1730230582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OX3rGRTXjTnfbyh3jkkVkK45Jb1/cfnPyM7MP3Mq4nk=;
        b=fuHJgvPgLwQegtUkN28Ai/coAUXU751jMoVCOIic0Z2TpF//mit0+WaijG1YwRnquC
         pII6IbzO7wXl/igEz9mklAcEmIexC4cPPFJeJ3qwxnRi4zq5lCnAzJeCwjY4Jf7c7sZE
         b6Nwzqv7GTPBgD8PS2163x/HEV0oXMLBXFv55LW4il406fbsCPVYaZSlhiNKYX3r7ujt
         FMtyzMPRcKBnEq+H+O/hjTGkPza9UV8t9Q2WcvGsPRFY2uAZ+12KIq2rgx99eE5c9SX5
         u481pWnfIU7e65PE/q+jDbzjzfDbftakK0w/2VFDlxW9Lj/ErFR14NHSde421rD504Sq
         Wk7A==
X-Forwarded-Encrypted: i=1; AJvYcCWOLv8xdR/b0Q71+NTvvVkVjNZdHNqf2a87b8GUwWzerripH7agw9GGKkoAOQ3m9WedbH4+cssY9Ia6L/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGL9TiM8+F4oec/6WOIdBa5o3oTbNwccQnz/odSS+h/3+LzbC
	mtm3qTXrkgr0VKz4dcKDTqVvYBsvqtP+XQ/Hq5CBUliCMM+Uhm+V
X-Google-Smtp-Source: AGHT+IGxChW/ByuZYjhL4nrxVUwxoOienwQqLSub4S6jDZ1mxsfZoXM4s4/2IaaNf54eWRFhDaDgpw==
X-Received: by 2002:a05:6a21:7747:b0:1d8:a9fa:f7fe with SMTP id adf61e73a8af0-1d96c29621fmr4948174637.10.1729625781417;
        Tue, 22 Oct 2024 12:36:21 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:4d65:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafb1e0sm5467316a12.3.2024.10.22.12.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:36:20 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Tianling Shen <cnsztl@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
Date: Wed, 23 Oct 2024 03:35:29 +0800
Message-ID: <20241022193537.1117919-5-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022193537.1117919-1-cnsztl@gmail.com>
References: <20241022193537.1117919-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is required to boot from eMMC without additional patch in u-boot.

Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
index 243574f8da78..03a2f90f6217 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
@@ -491,6 +491,7 @@ &pmu_io_domains {
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
-- 
2.47.0


