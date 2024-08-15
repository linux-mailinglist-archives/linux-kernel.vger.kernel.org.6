Return-Path: <linux-kernel+bounces-288533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B4F953B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B961C214C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14D4149DE8;
	Thu, 15 Aug 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QEJ5IlNg"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842827DA73;
	Thu, 15 Aug 2024 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753136; cv=none; b=rexNjRXkKhY0FSv2MPflzF+K0jeANtEgaWBZfeShFoMw++N5rOM41dhvuQIrjwNwJNiXiNNvOeq8eQexy8SMgbqb9m98R4B9vMInRfpkOwdqj4NzwIXvszb0fCB8bngyzce4BMtA/rX+1RxUd/HlVXwkyk0iZvtZ57JizYrjcgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753136; c=relaxed/simple;
	bh=uaNdt+hpv2FmjG906CcUrr4B6V5GwWfTrsRopf/5ysk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3YOCNa3ZaLvyQaTaETGfImexAhicQsKLc0I+Vmv1kvp71AkSI+jk859ua5Jnkrv7UBM5PXaAIBrL2kNDP0dTN4aqO4LY7jowhWkceJ+cfckPvWoDPoS6CXfUE1ReOv+cXWASsebjf4CH/c0wdpIfVnpVJi2Vos1YMeItQIdULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QEJ5IlNg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zavrgUuGoZiQN+TaC/9Ck+8FAd7WWCutstTDtJB0+HU=; b=QEJ5IlNgZ8GcN8d2zsnuXYmEtX
	zWwr1orepoLdQ4+ZUfL3G7H2EWCINV46iLpZSEYEiGyfKWp/fq09Yw2hQHhPA2cuug3DqfDMFB0z2
	drMyjduGFyVfBUOYatWkDjU3hOyDOrLwytZjZ0JpzUEg20WROxHkjz8lOgPko13eXDB1DzgkBFqy4
	c+/Nld1p5D7vNZQ1kAuE8TsXBeU33VIOKnxGq0wkWJI/tTjnPKbKLPocLHjNdJ8qKooxpXPInotqN
	02hYHSisBSHWpOPyyDH5zhfBhcQ7//0G8s//NNqbjh5jkZpCXqnV2xAzpAXfsWUDPH6Wi3k8IsQ+S
	IRHFxrLA==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1segvo-00089v-9Y; Thu, 15 Aug 2024 22:18:48 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sergey Bostandzhyan <jin@mediatomb.cc>,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Add DTS for NanoPi R2S Plus
Date: Thu, 15 Aug 2024 22:18:45 +0200
Message-Id: <172375308156.820196.16689328819690192699.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814170048.23816-1-jin@mediatomb.cc>
References: <20240814170048.23816-1-jin@mediatomb.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Aug 2024 17:00:45 +0000, Sergey Bostandzhyan wrote:
> 
> here is version 3 of the NanoPi R2S Plus patchset.
> 
> * a commit which adds mmc-hs200-1_8v in order to improve eMMC performance has
>   been included
> * the licence header has been updated to the newer version, anw now includes
>   optional MIT licensing
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus
      commit: b8c02878292200ebb5b4a8cfc9dbf227327908bd
[2/3] dt-bindings: arm: rockchip: Add NanoPi R2S Plus
      commit: e68b29cb711e80b1bd50366c5cdf8310c9ac24f3
[3/3] arm64: dts: rockchip: improve eMMC speed on NanoPi R2S Plus
       ... I've folded this commit into the first patch

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

