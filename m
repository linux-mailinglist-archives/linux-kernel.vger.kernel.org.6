Return-Path: <linux-kernel+bounces-536365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA6A47EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8977A4990
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467F22F388;
	Thu, 27 Feb 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qkUHwjoT"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09822837F;
	Thu, 27 Feb 2025 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662089; cv=none; b=KkKDfR2ievTb4ha4VVfBDaKal1YNQphpoRCpf8ORtRMFqYF4VsCq9wux+dX2kbCWDYpEcXDThpvZEEELTLuWLM5WjwJsk0xcVrBthjDFBWrdqSigo/4YjNoP+hlJJ/QP3GQpzLJDvKT+0NG8UjknnVBehpuiBTFJZKTo9iw2g8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662089; c=relaxed/simple;
	bh=pAGwoLGy19ERx91E3s8uY3Qlpj30AsEFTFiRPpMIYV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGZaW0ClXxl5lO78NJGaAQhZy+A6gzJZKmsxiuyQJ9DwE360Cg69dEVIWMzS6YWlPs19zAGCKxWsop6fw6mePgQaJOG86MBf4ovWeCDc21VINz6jf03x8IBXMVcq3zqo+MHe66Tv6YtA+7kWlR99x4/SCuqvyLIY5+vu1lMDD/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qkUHwjoT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9Fr71GDo1am/Op8h/SXIAkrUghbPA9DQZOi1Gai4x2w=; b=qkUHwjoTumYUWrOUJU6/Ndn4Gg
	vOGDCdAV907lnL4DY1bEQMqAp0UD6zJxgpDIivYN4kQxXSWb2JZBJMxWVX9zZVoloCVhhzw8z4NKu
	M2y1MyVlKesoG1OxsbC4yRXw4cosagKDLZW/MPKWg88l5KrL1ndPVF3IJZ7GHbf/KXuWmfcNupF1P
	Zhe5i5XgVrvbgHPRA27iEVe+yIaSd9e20bD0xuW2UyoBemodrlqK1ZHzqZWpPZK6oyncDbeMdkmZs
	qRBd6AXvqLLVBCMXPS1TBFJMiaeKfrsXTnPEBpGu/Vybtra6744cc7mGre89HQ6apFUdzFzMNbtuN
	OnCr8wyw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tndit-00011o-GV; Thu, 27 Feb 2025 14:14:43 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 Re: [PATCH v3 1/2] dt-bindings: power: rockchip: Add support for RK3562 SoC
Date: Thu, 27 Feb 2025 14:14:42 +0100
Message-ID: <2045951.zToM8qfIzz@diego>
In-Reply-To: <20250227105957.2341107-2-kever.yang@rock-chips.com>
References:
 <20250227105957.2341107-1-kever.yang@rock-chips.com>
 <20250227105957.2341107-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 27. Februar 2025, 11:59:56 MEZ schrieb Kever Yang:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> According to a description from TRM, add all the power domains.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>


checked the defined power-domains against the TRM and they match

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



