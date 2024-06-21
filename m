Return-Path: <linux-kernel+bounces-223996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB75911BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994D31F250EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1CB14D2A4;
	Fri, 21 Jun 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgAMF+LQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50E1339B1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951118; cv=none; b=Zp8FH0Bae/ogVwIPi1027lMzsGr+d/t5lk9mZlj4w8ZYobxZjdxzWhTB/EEFOo/BD0yTwURqbOsyCaTrZCs2gMeIlOfFoyrScz02Ind9Z8Rgd3XboHUuHAihgOayq2HGTyLRFUqvm0H/43ooHtnX95jP5G0p2vJraU6NFzNXEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951118; c=relaxed/simple;
	bh=vluQpXFRuEsX4CzotufWS3BiU3gXU3CkyNzrm5f7P00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quVLRxxuqTnN06hkAz8u8Uvt4hrRMLhlDZc7itJIU0eByvInIGNjekUsdYcMQGnJG4Ax0z8Nri6/6iDs6cCnyd4I6J7N+Lo9e+RtIQ7JcQTq/rTyVKH9kiM9msPq1kF9AcNHhLOR8r/i4d7NBIr6mDTJmjHiWKtWR3w6DzhhoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zgAMF+LQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cc5d5179aso2262479e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718951115; x=1719555915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StWMYOsCh6FPtaum53yX6NippyLiUpGWAFV7rmRXSlk=;
        b=zgAMF+LQh4PdOXgsMM8+YcaWu+uWt0KMdMMI3d3WZNjRvR0FlmVhD+NpSpvosX5l+d
         6cPNUgsjjrfxFRDJE3uKruWrFDcvRp5pceAItMP41HydIL994o6crJMKDF1tqn6cYZp4
         62Tm4E8vcEPgLl+q2q9HUq8Q2UwLYfOyOYxDHlhTzIiLpU1jlqjD4BsvpPX+qTEXn7XG
         maDRjoAPvLlOAabIx4P/f8K7X5PnlJuI9MD12wUMpw7935ZmKMN030ecgJCSqRsimw6J
         56KPTr7sK+zjz15vAlp5SUIYFj02vfDVzjjkSfQ/NWd5fvA4QV3jsSsawBU/dKR8v16w
         0l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718951115; x=1719555915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StWMYOsCh6FPtaum53yX6NippyLiUpGWAFV7rmRXSlk=;
        b=wXfzsfqzyqIendk1aGvkF8dp2CeKs1Y0APpmMJNQetUxsoDWycdebScvUJpfahaMNK
         KsbhpgbKRirYAKHibE+nhf71BLOIXfOl9nC6Vzykn2cTaB9pF6OdWbKoubIAVIHTtClV
         ynGohxRh0tF09zoitEo4ir1oyljVeX18Vl5xCpqrJ/mmg4nEwVXYEa0u55eb1uJ93CLV
         OC5Z0ACu6gUukIZ/W6MhUIiTmnNIEgj9w1IsPuoyHP7zN1hxEJdraOnWlH0IJM+NiSXw
         JPGz/bGoPpfkARef2IsVCQcc1LeAeDKz6eP0MI7IeHwJs45mrpmqSL7QRxOgvj7K+Ax8
         4THA==
X-Forwarded-Encrypted: i=1; AJvYcCUrELnFvEMtgyP9vA/IlILDCWSm5dFOEIiVk/gmRFf8m652jHNm9ZfDCAuFdB+IxRM6ZdFdoZDK92ryL3p61I96MdM2nBHaM7nLrlVG
X-Gm-Message-State: AOJu0YxmP5wpoTH8VkDl5FhPiLN1srMK0LBOvyroCNADBVHNQb+qUec4
	oBDvw0KHjI9vhf4kTR8RKxpx8/oim1fkxKjGXE/RA3U2B/KqCkJdgBFBUVyOj7Y=
X-Google-Smtp-Source: AGHT+IGOvQBVeOVRfT9OeleaCwxcfWuwyKp0KoQmrSi1Y8cbFK0mqlmwonfKGGA/D0j7pSuym3kIpA==
X-Received: by 2002:a05:6512:3988:b0:52c:cb8d:6374 with SMTP id 2adb3069b0e04-52ccb8d6456mr6536347e87.11.1718951115118;
        Thu, 20 Jun 2024 23:25:15 -0700 (PDT)
Received: from hackbox.lan ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a8ed3sm14463675e9.13.2024.06.20.23.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:25:14 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: imx@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 00/15] clk: imx: misc update/fix
Date: Fri, 21 Jun 2024 09:24:59 +0300
Message-Id: <171895105697.3608188.110944709510140108.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 07 Jun 2024 21:33:32 +0800, Peng Fan (OSS) wrote:
> Changes in v3:
> - Drop two patches
>       clk: imx: pll14xx: Add constraint for fvco frequency
>       clk: imx: pll14xx: use rate_table for audio plls
> - Update 8ULP PCC check to not return Error
> - Update commit log and Add R-b for
>   "clk: imx: imx8mp: fix clock tree update of TF-A managed clocks"
> - Link to v2: https://lore.kernel.org/all/20240510-imx-clk-v2-0-c998f315d29c@nxp.com/
> 
> [...]

Applied, thanks!

[01/15] clk: imx: composite-8m: Enable gate clk with mcore_booted
        commit: b4c91df8118b5d4efdc9732206de81ac620f53d2
[02/15] clk: imx: composite-93: keep root clock on when mcore enabled
        commit: 90d91ce8e20e0df9806ce7f7c49f8ef05471b5ce
[03/15] clk: imx: composite-7ulp: Check the PCC present bit
        commit: afd1247ce838b4a06fb0c24e522687475583035d
[04/15] clk: imx: fracn-gppll: fix fractional part of PLL getting lost
        commit: af218f2d935e118582d43cbd89c81ef6f26be286
[05/15] clk: imx: imx8mp-audiomix: remove sdma root clock
        (no commit info)
[06/15] clk: imx: imx8mp: fix clock tree update of TF-A managed clocks
        commit: 6bc3d1e264ad5bace5d1980997abcc7ad5308181
[07/15] clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
        commit: 68a3e49a2a5e75a2e1511ff75ca24b584a0f12f4
[08/15] clk: imx: add CLK_SET_RATE_PARENT for lcdif_pixel_src for i.MX7D
        commit: e2d956067b0b3c9a9ba5acde655bf6fc708c3ab0
[09/15] clk: imx: imx8mn: add sai7_ipg_clk clock settings
        commit: 40cfc8c2fccf5440fb192aa80a84bff9f3288b2c
[10/15] clk: imx: imx8mm: Change the 'nand_usdhc_bus' clock to non-critical one
        commit: c7f85fc3dc2facacc1851db992d485a89acde8ee
[11/15] clk: imx: imx8qxp: Add LVDS bypass clocks
        commit: ecee2c870be1776c483b3d1a40e3998c7cb7eb1b
[12/15] clk: imx: imx8qxp: Add clock muxes for MIPI and PHY ref clocks
        commit: 385e7c90bdb571677c4d16d97e8809427dc4d8d7
[13/15] clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
        commit: 9cf2310e4845006f72c959d38bd1300863432194
[14/15] clk: imx: imx8qxp: Parent should be initialized earlier than the clock
        commit: c69e0dba43e63862ec95cbd91a2daa28e3e87a9e
[15/15] clk: imx: fracn-gppll: update rate table
        commit: 747cf5fbfc4326ab2ad9cc73cde8eb7776f3ba53

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

