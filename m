Return-Path: <linux-kernel+bounces-527512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA38A40C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A37A7ACC18
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51128204F77;
	Sat, 22 Feb 2025 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="YMDFzjDC"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735C6FC3;
	Sat, 22 Feb 2025 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740268111; cv=none; b=shabPUvPIq5ETGHMJk3iZZKzh9XQxbEwo0AnBLEV3kAjWQr98mqDUKKg76piOf6+MBhCBsoS7pwqBu2nToVRLSn/9UahxUBGRSQEzRM6Bd/YiWt72s1tqnVDGFUlFfpo+JVZ5S6c2OJjEVw6mrnGDtDUVFwfXI6Qyseb1awdlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740268111; c=relaxed/simple;
	bh=IiW0o7gLIfcy8NSl9dChBQdMqqABoR96je5IOl+bRbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlwLybvdtshywyjp3p8mMy6VuajZwwK6SCvY+qVaedQT2YuYoZnWTeFcHhLV/g79CQdpY2Y8/XzvrPcIXhxg1RehMN/1CZEAhrZM5S2ZDNgcxcahu2MxWZC368FULlxnP0i7Nih7rV7Bl1DeuwBQUp3MeN3NJsP0ECx5iYYyOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=YMDFzjDC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WTZIz+bjsAte8JJ9M5T1Q+oMG2EjP+1wiuG1Z9WAeZU=; b=YMDFzjDCtPNHKPfjD/cNfEf636
	84W1kMpOZOP5nbWjlevNiBa8085bYYJ0Z2+VJEFe81xxNVGXFHXAjlGG52Sthrj5l/cAIa1c6URSn
	jhWkclGst0ohgIrQ52Vv71oXayU+++0EEucHfyf81XQ8fCWy/LEz8byruA4qHqM0PkVOrMpRG59Sf
	eqyp3s095mH87oglfc2XYkPTwwcpRN4dckhK9s8keUCYnZOHuvsHwhXjhjW89kFXzhfpqKWnzB1Xs
	Dg8B1xtx3MnWVN25ZUbI67O/8CwJhWE6lL2grxA5LYpAuFCNh8lCLO849tDsx6aIIXiqjEzyQfe4c
	85Z08TnA==;
Received: from i53875a10.versanet.de ([83.135.90.16] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlzEP-0004TL-AM; Sun, 23 Feb 2025 00:48:25 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: srinivas.kandagatla@linaro.org,
	Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	detlev.casanova@collabora.com,
	sebastian.reichel@collabora.com
Subject: Re: (subset) [PATCH RESEND v2 0/6] RK3576 OTP support
Date: Sun, 23 Feb 2025 00:48:19 +0100
Message-ID: <174026756675.3008209.3013516959407224193.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250210224510.1194963-1-heiko@sntech.de>
References: <20250210224510.1194963-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 10 Feb 2025 23:45:04 +0100, Heiko Stuebner wrote:
> This enables OTP support in the nvmem driver for rk3576.
> 
> I expect to pick the clock patch (patch1) and the arm64-dts patch (patch6)
> myself, after the nvmem-driver and -binding patches have been applied
> (patches 2-5).
> 
> But kept them together for people wanting to try this series.
> 
> [...]

Applied, thanks!

[6/6] arm64: dts: rockchip: add rk3576 otp node

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

