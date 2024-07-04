Return-Path: <linux-kernel+bounces-241578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35010927CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EFF285DDA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710D130A5C;
	Thu,  4 Jul 2024 18:01:39 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E139FD6;
	Thu,  4 Jul 2024 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116098; cv=none; b=ZRtijdX5c33wfsENuAeGmUz/7osEu117UoKa4voP69i4F1K1dVoEv5d/JcnaWbg6oDj2sQIr3xyiPKN6IlA2otqyLz0Vulxe2g7ajX5CPThZ74ah7I8OAPwQek+/MV+u9a5hvX/FpRWEaLQnCntycG6S+Gg9uCUjC5pTOMneI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116098; c=relaxed/simple;
	bh=s5g2oKzUbnUhfk/IkhBNq7odBOHQVLv2kPEmzVqdBbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWlk0WRHOIDFD/ov6vpyMv0I5wHNiARh53fjJfByfaWexdhk2ejW0JoqS/bjcnRrHi5N/0l6aeeGaD9pfIwYpb8PKYKhXIkBmIALTzj6fyapQT1EjJPI/2ohmAkLTWLDG6Ye7a/k7+mtkFPiaXtC1nYW3ajpXekVyeAKXX+wVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPQls-00049m-5C; Thu, 04 Jul 2024 20:01:28 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add missing power-domains for rk356x vop_mmu
Date: Thu,  4 Jul 2024 20:01:22 +0200
Message-Id: <172011606366.897267.12834973782810902236.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702-rk356x-fix-vop-mmu-v1-1-a66d1a0c45ea@collabora.com>
References: <20240702-rk356x-fix-vop-mmu-v1-1-a66d1a0c45ea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 04:12:52 +0300, Cristian Ciocaltea wrote:
> The iommu@fe043e00 on RK356x SoC shares the VOP power domain, but the
> power-domains property was not provided when the node has been added.
> 
> The consequence is that an attempt to reload the rockchipdrm module will
> freeze the entire system.  That is because on probe time,
> pm_runtime_get_suppliers() gets called for vop@fe040000, which blocks
> when pm_runtime_get_sync() is being invoked for iommu@fe043e00.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add missing power-domains for rk356x vop_mmu
      commit: 9d42c3ee3ce37cdad6f98c9e77bfbd0d791ac7da

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

