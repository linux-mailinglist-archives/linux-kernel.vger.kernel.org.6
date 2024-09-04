Return-Path: <linux-kernel+bounces-315800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF196C725
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FF72831CE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7938D1E4109;
	Wed,  4 Sep 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GzCZHVpu"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BABF1E201A;
	Wed,  4 Sep 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476844; cv=none; b=bK6CElSSolwd6xlNCs/r5d8gXl6WGhd1hjClQoGPZWBrJ79nyl6ZNDbQJLD3zs/leLm5vzN+gdSVbI1jWbkgJziNt4yA2byNqW3AHwUNcnGQVa6IvgyeodOAzrjcta4zsEasOkCXAxUXYpRJt/KDagwBCKHm03GdY09VrCrkM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476844; c=relaxed/simple;
	bh=suuFoSlJy/m1m+WFtsVM8ZhpOUX4HW/08t9CYcvGY5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEIqs0TFRYjpsK3FzL1d1abFW5ce8SYJMp9iil4MGdmVS3FWNQHLxm0iju/Pc1IEYYaFPF+iwp5ZqS9oWGmb7ux45NX+nkq3JQXPTiSGlWTJYl/AQUy83ZUay/qXZXX1pcvn36ctF80RQlVvkePfVlwCGSBTmXl9LHD8XxGhwfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GzCZHVpu; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qDbDeffccdTvMnyEUAukdNKpihI+nsZJmqSh07WNyx4=; b=GzCZHVpunDdUNYrijWEx+6ZSxE
	Rxfean/2o5KOhQ/IKmSJX7Yn4uDb8fIRr48TDbNg+/WzqZd3Yh1Omq2UDE4j5qWyaTrwKpekhxqZ2
	+d3TCD5Iw+/PNGnyKFzY7hYXfH61CBzFKQKkqD0iSRTfc2zAhyHsF2OivpDjLaMlQTW4sx/UJe53z
	ZFCnJQrETQN4BuE3Phxfdpz1Jlj/pmqIsVbYOafTTYluSrE2iNO48QZ6pzHoGaxiTd7KosewxA652
	J6CNCvFfitTuWm2vDtNAzOJcoCtAH5G74HPaXQQ34cyvy3+kNGYKFRMLH/S5PIYHDEpyrS8r9h9EU
	P9t8WCrA==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1slvLW-0002Po-Qk; Wed, 04 Sep 2024 21:07:14 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add missing tshut props to tsadc on quartz64-b
Date: Wed,  4 Sep 2024 21:06:58 +0200
Message-ID: <172547678275.2721598.9166695984529942192.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240831112949.60091-1-didi.debian@cknow.org>
References: <20240831112949.60091-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 31 Aug 2024 13:29:23 +0200, Diederik de Haas wrote:
> Add the missing TSADC properties `rockchip,hw-tshut-mode` and
> `rockchip,hw-tshut-polarity` to the Pine64 Quartz64 Model B.
> 
> This fixes the following warnings:
> 
>   rockchip-thermal fe710000.tsadc: Missing tshut mode property, using default (gpio)
>   rockchip-thermal fe710000.tsadc: Missing tshut-polarity property, using default (low)
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add missing tshut props to tsadc on quartz64-b
      commit: 93f5fb809b8336143a6668c38dba1f4c7ffe5cab

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

