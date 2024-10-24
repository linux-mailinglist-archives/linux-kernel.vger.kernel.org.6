Return-Path: <linux-kernel+bounces-379477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F509ADF23
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5D5282BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF51E1B0F35;
	Thu, 24 Oct 2024 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DM0nZADy"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A326F305;
	Thu, 24 Oct 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758666; cv=none; b=c85JJ+E/+AuzKCkOBxzKs6AuJ08r8GOUgoLNDYYhNCeZ6/tVxgBYF7s+htXakTFuItdyoJodRgLKuGO5hafs/VtA68/VMop2Y4aj1ML3gvq8kEdUCbNCHFlad5VcmM4dJYZQaHWbGUqZoiWyU5yp4SB5cLRR0j3eyDT63tvNCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758666; c=relaxed/simple;
	bh=a2Kd4akzAvLKWHNdCdv1/7joDD39XPGK9JQs0pzyD+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJyV7wQ9ch57JXezKHoK4MUKpooYjTcTvcHVX6zMOvgyTL/jlZQgKuTQS3AIj8PkagxoZNiZYFDQRypHG1gPlutVpSCedLOLZrHdzgs+aABmVTI34Q99jpiiQCW6+/POpKaBEqCdG8x1w8Qj9YmFooS59yh1kMCVzgZES387RqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DM0nZADy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QhASEzqWkSQ2maC6/lvcxAC1VPsOBizvjq6mLRso0ZE=; b=DM0nZADyLQ2iVDPGwcedB/C3cl
	D+TqlBMIOSc9MzYfchaiQsZ2yZGRwPnyVMTLgakXqEhEvmRIo+K+KuYyV1bKmbfwAid9/SKsQMCwz
	ZkiZw1IRMjy4LJHUWCI2ZsOGZGFq11HWqhfjOda2vJwEaFHxay/tXNoUCjGWCTbysFaSxJ5sT7Ian
	qzTaVxpRRwcw8MQpcbV1JLi6s4LrqC3VozTeLWbHJtz5YlmhtTi3amE8TE/5KASQX3tDThqWXOiDc
	mUgRBVEj/xti9JoAYMm2tv4Gm5Nd8oWVDvGGgYY8UIL5iJqLskP8SpGOTKVpHgCRwDhKyt75JmAcW
	VATMc1Zw==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3tF5-0002iS-PU; Thu, 24 Oct 2024 10:30:51 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v3] arm64: dts: rockchip: Enable HDMI0 on rock-5a
Date: Thu, 24 Oct 2024 10:30:45 +0200
Message-ID: <172975863601.1671562.16763365060415840002.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022-rk3588-hdmi0-dt-v3-1-3cc981e89afb@collabora.com>
References: <20241022-rk3588-hdmi0-dt-v3-1-3cc981e89afb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 22 Oct 2024 19:04:42 +0300, Cristian Ciocaltea wrote:
> Add the necessary DT changes to enable HDMI0 on Radxa ROCK 5A.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable HDMI0 on rock-5a
      commit: f57a8daf6bbd8e71f16693ad6d8421cb881c7fe0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

