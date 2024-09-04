Return-Path: <linux-kernel+bounces-315798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1DB96C720
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12B21C247E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615761D6DD3;
	Wed,  4 Sep 2024 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BFrJavYx"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B6145346;
	Wed,  4 Sep 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476839; cv=none; b=Kr5t2XJz56ZDMnlowEwZZWEh3gfXknV6XZ8ebYBowl5CeB6/tVXY3Z+gN1WKw+lmz4h6cEwdK7+ZsIbJKfO8pcmBOIeLh8HEFBwJcnx7dtXqW5Q9ELrSWS+RDcn4ueehJVp5B23PeWAFjQS1jjzGCS/MhGKXRS7hqjDaUPE3rY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476839; c=relaxed/simple;
	bh=isWKMcqyY21NJn8E9x0r+PeNgHEfUUxt9OQJ2iFnNxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQSnGzDpyGRPq7zrx0/vxJFzBVtQp0tcfJTLSyE677kI6rcvXjWr8EcilDW+g+4hj+xQvXnMiB7UG31yj9sLXR53ipzlf39WlZXwXa1/4EaQl1CWOE60pq6CGOv7xfzqbfoRh4MAFHUob22Fpl5clF5diTwdKmRW3zoB/wBOkdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BFrJavYx; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NaiuGOuLjEcZvHvGqRCefrntjSu/WmLQe5fe+Gwnyc0=; b=BFrJavYxqG/Q2tQdc9VTFQA479
	glLt7MF5MHqZXSN8C4BeWwYjnsjzZg44KJ03yStUcNJ41lxxb2Oo8zal+hTw/9ViTiRtWyDmhOaeb
	4+Y+K0I2dk197KnEd+Jowcpo3lxDLC8EB4fyd/xPXX4hl3CeQnhxaCRCjOuq6tgPd9g5n/fZbmjKp
	8zLfetfYiXMfNCHKt4T5NLtYzlWml7spE999yctOT9sTYftc/N2yBsaHz7Ccwq6c0CrL+q+FRG7CA
	wCW0HF5VK3FidGNADO+ia3B0yQtMAH0VJByCN7VZjRFYNOJkUeLsejDrOPA18JNPTAOdzSxNatIMR
	FdHT7xvw==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1slvLX-0002Po-E2; Wed, 04 Sep 2024 21:07:15 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	lgirdwood@gmail.com
Cc: marcin.juszkiewicz@linaro.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh@kernel.org,
	linux-sound@vger.kernel.org,
	conor+dt@kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH 0/3] Fixes for the audio setup on the rk3588-nanopc-t6
Date: Wed,  4 Sep 2024 21:06:59 +0200
Message-ID: <172547678278.2721598.1373635152279792250.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830203819.1972536-1-heiko@sntech.de>
References: <20240830203819.1972536-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 30 Aug 2024 22:38:16 +0200, Heiko Stuebner wrote:
> The Nanopc-T6 board does contain some devicetree errors, that came to
> light with recent changes to the board.
> 
> clock and port properties need to be part of the codec-binding like used
> on other codecs already and one property needs to be removed from the
> board.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: rockchip: drop hp-pin-name property from audio card on nanopc-t6
      commit: 01c007567944913c29e6e19af241d0ba4e59ce24

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

