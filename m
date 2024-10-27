Return-Path: <linux-kernel+bounces-383803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AC29B2060
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B669E1F2180C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A21C17C9A3;
	Sun, 27 Oct 2024 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LpOh5+xe"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709B762E0;
	Sun, 27 Oct 2024 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061077; cv=none; b=W74gi51SyQ76x6TxtYpuEOJ4pxrx0QAzH89M42uPQWmYc3cr60wKYnrimhLIj15t1RyJKImF9m1G97StwPm3m7e/Rrt5NHqC/MTcNpVe84mn/X9siWv51HmAlcwbsE6f/VQ4FoG7qkzJEkfWO9ZQDQMvSdyh7FKBVdygVpv40ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061077; c=relaxed/simple;
	bh=+9/tsT20xhxLnrdJdyttijaVQbIMOZmgoyqru7Wo9/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vixn5z7vmXvDsEBUJqC8sagVd1yjAs2qlGDU0mTX4CGODS2zcXzZ5QsWVIRl6hb1sglyjrG3WV4DYlnIDKR62rlocMI1kvQLBIl6tifsEchkSWRbaTj7/6jGZgxHfIwGQlXpefJArDvHJpJtFxZlO9bxgbY1yQAyH/RgtVznPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LpOh5+xe; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YhE6OJbE4zVQRfI6WKab0cFThX0KUKxVPvY6gL/TaCQ=; b=LpOh5+xeN/inEL/dPQJp4tRodC
	na18rzgLHD4nM95QO7Z2L2Of7swBgX1hQAurCzrKqdY1Sibvl+M+9GRZxIcWIo3Gs2rwXSiYPYimN
	v5YhLFFkSKAxZpyePrbZdvq7vzFrm1cCVjIo+1LbwvgJevfOHV1f04Q3lQKrPRpU8O5zfz4wW15Q7
	9n+W7hMh8Vw+TnpGv4vnqbGWNfYiCo9hjZiZmSBjJOYPQt5A19vpGkY5CFsW5kceWM7EEe0cY5sIe
	+CYygv1SM5J+3rffbOjfsvPpvcMeMWgDZOO93sWQCTj/FPURSJJNxnj7AkvYV0O9itGmobBU/kg1I
	/MAgZ0qg==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t59ue-00068h-3G; Sun, 27 Oct 2024 21:31:00 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	robh@kernel.org
Cc: linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	andy.yan@rock-chips.com,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: rockchip: add rk3588 mipi dcphy syscon
Date: Sun, 27 Oct 2024 21:30:56 +0100
Message-ID: <173006096669.97564.15899385543058068813.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240506124632.3621378-1-heiko@sntech.de>
References: <20240506124632.3621378-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 6 May 2024 14:46:32 +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> RK3588 CSI and DSI support requires the GRF for DC-PHY.
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: rockchip: add rk3588 mipi dcphy syscon
      commit: 22e027cc74488dba49f19f943c2da02726261f08

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

