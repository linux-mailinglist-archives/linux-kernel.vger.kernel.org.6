Return-Path: <linux-kernel+bounces-442298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D2F9EDA57
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FE11884B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F6A1F2390;
	Wed, 11 Dec 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jqhFX5Xj"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685FF1D934B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957169; cv=none; b=ktMbbq5a64rAiJ3o1E3MhvXA4FmswoUuzRZeo3oaQ6lYKkfJ34DMbElc7ZTI4J3fwhnHeDSUb7IvXEnPd0qpTpHwTQ848UWh3YRV4xMisnFhRVuDaMp3bCgKChVs7tk0ZFt9lF2q3jAfUGC4y9t/l9XxgcmJkPlAgg91fQVGBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957169; c=relaxed/simple;
	bh=FcSfuk63zX4e+IOlVIn6NBUThr7+axWMhxL5rCaztjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q58RCNW4KzAKLmDtQ17VSy9leGC42nNg/+QgjvRkf3M3/esq5q45Uhdh0iIGVR3AzZ8iDwouOmVSAMtDwwLEVDphf/cngQn6vP1oxGsx0gA+DnVoQXamO2YDA5ELhbk7rEFe/DtJWbC20cKDbtG8w0c0XOJbM7aaz+lNlI8N0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jqhFX5Xj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J4uMrsFePi+DBZGlK5bC9jVrtcVa4XLjgvOYdofBgAk=; b=jqhFX5XjB/uFDDyAKv3HRztSoj
	04+EpIK8Wy8R0kLFcrvEvVJ3CXHLSU4O0LAzyunfRuJTWluoX/By3EFoPcR1z+HTClA9Sla1E2W4h
	JWKcWX1fnjsXPpGHTyHDyd2M/Yx/bYbpNupYoPe08Jv+P+Dp9LCxfwFu6Ack0xgu9YahDdG9eb3WZ
	MGMPBlrNKG4PCMnNdQowdxBMIgyd4mtcGg0ddjfqI5i4hx3MaB/cGLcqmGvDfFNE7WI0JLCH0S+y/
	oWuBcILHtr7MSRIvvKSAIdLPlrWh6dVemfTyjv308c+UEiGlXh5V2LdtrzOucZgrM/kRiV3Sn16Qx
	sneBq5Og==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tLVSi-0000ON-0w; Wed, 11 Dec 2024 23:45:44 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: dw_hdmi_qp: Simplify clock handling
Date: Wed, 11 Dec 2024 23:45:39 +0100
Message-ID: <173395708761.2509957.6810456712864653104.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202-dw-hdmi-qp-rk-clk-bulk-v1-1-60a7cc9cd74e@collabora.com>
References: <20241202-dw-hdmi-qp-rk-clk-bulk-v1-1-60a7cc9cd74e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 02 Dec 2024 22:27:34 +0200, Cristian Ciocaltea wrote:
> Make use of the recently introduced devm_clk_bulk_get_all_enabled()
> helper to simplify the code a bit.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: dw_hdmi_qp: Simplify clock handling
      commit: 19851fa2ba9824bede16f55234f63d9423897c3d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

