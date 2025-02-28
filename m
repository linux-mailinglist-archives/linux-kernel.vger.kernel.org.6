Return-Path: <linux-kernel+bounces-539526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A6A4A585
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7945D189BCEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8441DE4F3;
	Fri, 28 Feb 2025 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="PlrK+k96"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145611DE3AC;
	Fri, 28 Feb 2025 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780109; cv=none; b=QyZZ1m5AdALlf2q1vLs3X89F3LCjZOWg9hLp6cETXGi3c/uh4HHJbzTq39AQTgfmmSNBnj2EDzeWs/UpVUiEwr/jMTQvuxFsmuxP/EA5FTcIiKgy+utPzlYBL2IQCjcxxupZ3c75MGx0irNvu/fgnGRtmJYGeMoP6boryxFGZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780109; c=relaxed/simple;
	bh=bptAosu4Hf5tTe2iT9ogZm4r71+NoVNpH6bM6roQczQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASzRsuCflUpwLgsS5DJ2qAyuN4VBsYteLXFAw++j16G5yKBtHFb1dv7+SbXoDNkofzLfS5zUBszIJXFj9TyBCyA+vTHdf1hJ+oMbcFw4rrjfLjBdNCndF/KzccpHvv5bBvtVSSLyPnisI8fCLic3edRr3JFyTwVuavxEH7sxnbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=PlrK+k96; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NgYHhAZVJRwm5Z/EQR+PLrb0QmEddFGRe/Yn6CQfksM=; b=PlrK+k96DuLGQzw7NjEpVOUJ6v
	JoBKzGgZivPTZRUDGlag6YiWjnaS9iYUxblEtP+7YPmx+NkrxeMHOEmbBnogoUUSeF09G7DNHw4QW
	7HzCi+sYdkh0QdYNKwAmbmapLHevXgwnTF8c0hgLa4yAwAU8q4KpTKV49Gc+cfi6hjf7vX/gwpxbQ
	OquPlSitgcLDgCYKWm14l1THW+FyWWeob+EOgwkafmXg9uI37gTMw5QwIZOeR2Ewrk7SC6IrWEUiW
	BagJAa4Xfe8SW2w+7C1S27HpG61Ia5h4KYkeSaUyrQ6w5IuaWLFqpe0cy9KPKFtuInszvCR1aG2tb
	H/3hsMDw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1to8QP-0003wY-FO; Fri, 28 Feb 2025 23:01:41 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Wenhao Cui <lasstp5011@gmail.com>,
	Yuteng Zhong <zonyitoo@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Remove undocumented sdmmc property from lubancat-1
Date: Fri, 28 Feb 2025 23:01:29 +0100
Message-ID: <174078008222.501190.8063852889534506568.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250228163117.47318-2-ziyao@disroot.org>
References: <20250228163117.47318-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Feb 2025 16:31:18 +0000, Yao Zi wrote:
> Property "supports-cd" isn't documented anywhere and is unnecessary for
> mainline driver to function. It seems a property used by downstream
> kernel was brought into mainline.
> 
> This should be reported by dtbs_check, but mmc-controller-common.yaml
> defaults additionalProperties to true thus allows it. Remove the
> property to clean the devicetree up and avoid possible confusion.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Remove undocumented sdmmc property from lubancat-1
      commit: 43c854c65e47d2f3763345683b06257b4d12e4e3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

