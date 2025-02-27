Return-Path: <linux-kernel+bounces-536494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17673A48077
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDF93B2193
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA37234963;
	Thu, 27 Feb 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bQZIi9oE"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CDB230D1E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664965; cv=none; b=iuCwF6SFdT2G8cX1KLDaRQHXAAyOFus8hrXOTHiOGyqaOV2rK/LlddsLKt5YK1xVQgWxTUobLl9ua5j9PJpMgVD7+Lw3/bEksiXqfrvRDEo6VZkJCx1O8nMD3yL44lUuul8WcsdeAmaqdhr3isYTIrHE29hPCCskEWZYFOoh7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664965; c=relaxed/simple;
	bh=7Mtd9/Yxt8lpDuuGh0/4GEf8UCjUnnf4jauT9MPoaAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ghr4nK5pFyJG6iCPViX4PdLogwspdHIBOyDriW3DLjMwdB/9JCEjfHpG8/2gIx6v8xnCzUebDdmLvjVVsUGd2eQZqJW9TXRsXqFPYPuLmEzNH/yom1gYgqLXiyxVOUuEbrJnomcXU5JRIohO+5K8RJjZ6L8FMfh8OSieHkRx6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bQZIi9oE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gl2YGr8BLw/wNus1iEMG6KY7DRu+t64YQRFArFZ0uP0=; b=bQZIi9oEBCJISZINLmrQvKI0d7
	4NQ27FI0uRR5OcXcSNQ4h4j7WAHVabJpGI0/LWHCO9fqwIqcG83F0XHpL0blaiLZNtl9BBdBMJNg6
	68lTa1OULh4hvJVJZlfl20dg6uqkW0M1lL9hvuSAtabL8hgXBGcjbkAus+lLVSEroIo+ZPQEgawvV
	E8GEXGgC/AnEVaegAG8vy2YomFZmgTNCc2EH70JpZTfBeCS5biT9jm7J+KxE0ytXPrNxWycTziuYk
	+nLf6HQi2SSmPQjzBvvf9fb27jpD1mG+ll37fXeKxo7vksc8A72irQdCR+z4F26gcU6buiQ7LHlzf
	WJABAuNw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tneT4-0001In-99; Thu, 27 Feb 2025 15:02:26 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: gregkh@linuxfoundation.org,
	Heiko Stuebner <heiko@sntech.de>
Cc: rafael@kernel.org,
	dakr@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de
Subject: Re: [PATCH 0/2] Fix the shutdown callback of a drm component device
Date: Thu, 27 Feb 2025 15:02:15 +0100
Message-ID: <174066492648.11813.12373419424939960288.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220234141.2788785-1-heiko@sntech.de>
References: <20250220234141.2788785-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 21 Feb 2025 00:41:39 +0100, Heiko Stuebner wrote:
> Probe deferral can cause the platform-data we access to be freed already
> causing ugly splats on system shutdown.
> 
> Fix this via a small component-helper and adapting the rockchip-drm
> shutdown handler.
> 
> Heiko Stuebner (2):
>   drivers: base: component: add function to query the bound status
>   drm/rockchip: Fix shutdown when no drm-device is set up
> 
> [...]

Applied, thanks!

[1/2] drivers: base: component: add function to query the bound status
      commit: a6ba2dad0aa4f623ab0def8b6e6888ac00639055
[2/2] drm/rockchip: Fix shutdown when no drm-device is set up
      commit: 4444e4d789d64f053435713e5984f0ef31a7633b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

