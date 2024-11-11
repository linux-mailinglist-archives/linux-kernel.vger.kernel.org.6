Return-Path: <linux-kernel+bounces-404535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409D69C44DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0699B285438
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D01AB503;
	Mon, 11 Nov 2024 18:18:15 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644C1A725A;
	Mon, 11 Nov 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349094; cv=none; b=YVN+uEKcWd/tkCsVurJqKD3MLhDR8j/rXtggG4d+fL6egILJOJZOeITjWuu2tDd09TpRxMsb1A+GdRU/KFrBmUQNBFAoskg3l3v2MhPHI2eSjyp/4BJKCx9mOhBw2pKmPZEWXkXrz9iAOTYe1Yo2LvgFLj+2OvB8URiEoO3s4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349094; c=relaxed/simple;
	bh=yTs7KTjUDt5ZSEbXiAV+is8iqZRaWxwQQTH5hdn0iIU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t4flbV8fJWN36+WzKZa8CbCrcM0rHUJb6CMh5n1qf7mxMBJvOvgksofm9L1SjffsVxLpyAGPKypyj9U4nuunPd9hm8UTbiyFQ2hF4+/1WlK4KTAMhaihFoKCPu/WDdzwwa8bc7G6Tz1V/mpIt8mYlma+go1v6f14xmuBgw0Bguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99eb8b607aso707242166b.2;
        Mon, 11 Nov 2024 10:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349091; x=1731953891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuZnyXBdk3QHcPbZuZ4wdiQBJmOvaPtia/X0YSXMhqk=;
        b=sBzEAEd8WtwMcplC8H9r+9DPN5uFdZ0wozfl96V6HU8Opcdblmn/5Z6dNt1GwoXjPK
         xYaENLKbYeZfqTBSrVuuOi3sEnwCo15cuoE4XC7a5FXNdxcaguE0fM6sA4uDRUj4AzVR
         sPkJxs1ALsPm9MGemZbqxX098eig5TAzL5MQy8A5s4vrpoCWOpC3pXEFteJNTP3b/lHS
         aa4XsuPXSiWpQLo5ro3uqcM++asKqr50acpXjmRbEBH83ygtykIt8zVo6jWha4z8R26P
         Kl83w10oIzmigdfJyX1CVkxd3lrkAksNj0rhaX4NqAfgtRgt6MuHyt8Zc4dq07qPTWvZ
         s2dA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ViRlpJgxnwti198Z62STaNxnLRYqQTujze6QFozxaaTbqrom5y8zhJ+dnNjx9VSTR8kp0Qn5IS5D@vger.kernel.org, AJvYcCXlXA3pLm6tO0/l/BSwLKmquMp/aBkvbisnX43LimQbexHndEUbIMHwN2K1rlJaSyRyyn/+sKuU6oM/9C5G@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqwZmfItuVOHenl2PrpLJqM0pZV8w3VBWtNJcxA8tBRuLhZTH
	WLnwyhh8PjLsTKi/2doySyuNabb1LaklOXFPShdS8TKlMmwi6IrU
X-Google-Smtp-Source: AGHT+IGFs+veCOYdFl4AbDVCq/r8ZyxcC4t3ag3b+QKAnXD58wwk8c8uG5tNU8vrFqoP3DjFTYY2kA==
X-Received: by 2002:a17:907:368a:b0:a9e:8574:e154 with SMTP id a640c23a62f3a-a9ef00216fdmr1422727866b.59.1731349091087;
        Mon, 11 Nov 2024 10:18:11 -0800 (PST)
Received: from localhost.localdomain ([193.142.191.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17b64sm617868466b.39.2024.11.11.10.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:18:10 -0800 (PST)
From: =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@linux.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@linux.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Dragan Simic <dsimic@manjaro.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: rockchip: rock-3b TF + M2E updates
Date: Mon, 11 Nov 2024 19:17:24 +0100
Message-ID: <20241111181807.13211-1-tszucs@linux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Changes have been tested on an RK3568J, with an emphasis on DDR50 and SDR104 at 200 MHz.

Kind regards,
Tamas

Tamás Szűcs (3):
  arm64: dts: rockchip: Add supported UHS-I rates to sdmmc0 on rock-3b
  arm64: dts: rockchip: Enable sdmmc2 on rock-3b and set it up for SDIO
    devices
  arm64: dts: rockchip: Enable UART8 on rock-3b

 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.45.2


