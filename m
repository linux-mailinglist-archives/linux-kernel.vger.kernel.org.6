Return-Path: <linux-kernel+bounces-365128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E73A99DDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026D12818A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA091187856;
	Tue, 15 Oct 2024 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DC0kyElX"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17113C3F2;
	Tue, 15 Oct 2024 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972375; cv=none; b=Y7mP9qGSqWWoHpp7eN5UGMD3S5KbnUzd0Ze7GGwydNFtHb0t5WZ4lDdONTke0fuqFuzNVYM09eVCsVwF8C7x84FeSlNSVuqZI00UCFCku73+rW7n4tOUgOlABNUHZOMhShBttC55HC4wwOtwI4WnQZqSUr+OF7Zjy0mLXorXT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972375; c=relaxed/simple;
	bh=UOc2GMt219Ucp2LEz8uG4xfOIHYym8Fi6q68FxagS38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTP7OhFug9g2B+K5e9JmFN9Ddw8GfM+mm6SBOH12FxKl0bvZS5Ql8vWQzEs/QEb8fC4ovvGi+ueN1VUDDXbW6Y63EtT6J3/BZvseycOagm90ACNn42pFgxuMRJ0hQifxJm0uqz09n1GfecPFFHhuK0+327WlWGJQo6EZ5tiGVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DC0kyElX; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ASuBcpLVRHwqVESDWXGS90dfdjQqRtTA3nVmTt7XIHM=; b=DC0kyElXnIAgTkVIE9Yb6zwK8M
	Sq02nthbwrp3zH3WKRRKi3FnyYVvFGtVyNJ94Az8FiXPCSGbpDX5pI7S8+mQAGeqDfiPVtM/vKVbK
	MS5WXh2DxoGT5pGXL452jG70HztHWIrcdp0oB1iaczCTAkgQQ/8uyEwB3DdF/BhwRU2ZY1bxnf8ZL
	JEbrM6P63miqJ43+Qw/8rpFa8kHdx4DC6njoCL8pP/FT7awk4ymNuLlFwdCaQrCdTtSGFSmQ5y+rU
	qXDgy5b8GAmioztzwXyoPh+MWIOHzdqlh++3KK1pG1k8ILGjyG+vnSO8a7eY0B6DiyxbBvDiULG+x
	9nvlPh0g==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t0ah1-0006wa-AN; Tue, 15 Oct 2024 08:06:03 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: rockchip: add rk3576 compatible
Date: Tue, 15 Oct 2024 08:06:02 +0200
Message-ID: <3315048.aeNJFYEL58@diego>
In-Reply-To: <20241015013351.4884-1-frawang.cn@gmail.com>
References: <20241015013351.4884-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 15. Oktober 2024, 03:33:50 CEST schrieb Frank Wang:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Adds the compatible line to support RK3576 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



