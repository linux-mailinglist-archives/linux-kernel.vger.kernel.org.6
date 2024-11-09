Return-Path: <linux-kernel+bounces-402966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA019C2F13
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8251C20CBF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1868519FA8D;
	Sat,  9 Nov 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Aa0iroWy"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5529CF4;
	Sat,  9 Nov 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176855; cv=none; b=dCp8LeUirDXGymgoAklxg3cSYTEZ/2HPgOFoJ5zcvLq+q+Ul4CpEW2WnQK19l5UT3vM5ZNvlLZIufkyV11aDKcB1CXEoof/B7OF2VZrX8Ead3OSCWAeaWZrweBzHvM0RM3DnOEk5lb4zgbjXKc5LBAE/KPNhkTbyXuWHODn3MF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176855; c=relaxed/simple;
	bh=KZd61uct5PufcA9pe1EvblTIuxz3bTaA8lt5EJS1M94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWEs3CWCtDyjddnmC8/TkIWT6L9eWPWkprly3EqvxVdI8c0Y3RH3U+W9CJX1u1mLCEySPOW8Zc/91bOnT9yuW7GJQO6PJj35bIFRa5hLDHqkf6XpwzFtoPRtQhk4h/dKCBeKHMvfyLtFEsQacl5/oiUJi7dlEcr7IioMYH4ug/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Aa0iroWy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8OT/9xhzsuunennS7C104FhK0rCK8MTqKWihkPOvx/k=; b=Aa0iroWyzMYGB3rTtRj/3LHgXy
	ZQu1saWGK6eKDThzgVEgOknBNIYlUjGxT5UB3oi4qvwWQxg+Dc6X/h8V7TJa0vC//BHc4sPkRiZZz
	+sKEYV6eC41dKGoA3VvUPPZs2uC+QyEV54x3woGDdVI9AiOb/gCZkdlw47T2Jffohx+rnBc54qcbs
	/hY4tkW/+gEX6x6x8QGRDivWJ0FOOZdp0PmAesj9f49aLPTzto/tEWaVTfsAxbgkPsvt6bMiyceAW
	3v93UJ+8OvrAWriINBXBElEPFDBLZGgUlzzh4dgrkTgonHuxcTC+JGqKDHRF4WLtgeJ1mt/xXx2/5
	uklga59g==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9qBG-0007Km-7i; Sat, 09 Nov 2024 19:27:30 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Weizhao Ouyang <weizhao.ouyang@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Andy Yan <andyshrk@163.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH] dts: arm64: rk3576-sige5: Remove non-removable flag from sdmmc
Date: Sat,  9 Nov 2024 19:27:09 +0100
Message-ID: <173117675954.1131306.9520031721535619598.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108213357.268002-1-detlev.casanova@collabora.com>
References: <20241108213357.268002-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 8 Nov 2024 16:33:57 -0500, Detlev Casanova wrote:
> The sdmmc node represents a removable SD card host. Make sure it is
> considered removable so that SD cards are detected when inserted.
> 
> 

Applied, thanks!

[1/1] dts: arm64: rk3576-sige5: Remove non-removable flag from sdmmc
      commit: cfa3d63c8b4c8e14a5a0059407969ffa92fbbb04

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

