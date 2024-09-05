Return-Path: <linux-kernel+bounces-316700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CAA96D2E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B651F2240C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0A195F04;
	Thu,  5 Sep 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1vIOUHBj"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1D3F9D5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527675; cv=none; b=CNgYcpiPSMAsDgZtmCBZKdHhr6E/McZUkw18qu4Im4p7HHVyXNp1KQSDlhwnI3xWlWHe7DwbG98onoO0rGA7oMFVbOjYqPhChoH3VyLBUjiBPZsWr0HGh3dLYbpxcbckz22z+fCZOn24mgOVijwm9jwCfz8Au/wz8+xQDCYZgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527675; c=relaxed/simple;
	bh=nn3JyUhNUivdZca+s5Neou0E/YqV4jTtmLtRAp5r0tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouZAmhyO/aGhNDcHyNncKJnBYKNi7VxmdHvn8CCHdH4872i7nYd6KhoM8Hvl8HnKwePHJcfWFlk44io3USmCHiMyD3txnFxXEO3TmjjGqktj0EiLR+i8BI3HkIM8IL8UdpUmK/K++0zteF9Q/Ctcwh1Xi8wUx+5A329f5tlxpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1vIOUHBj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=426bdfUS0yLzDDEMRETm4lejCxOLDPe8UCSeDV1MoL0=; b=1vIOUHBjgZCq8hx63cc2Udhyy+
	McKNgrN3AQWLiLTMtL529ntG8aDRIPk+dYEZ9wtaezfhCOTArigkBDks9dhD7oHzvJVD7JZDBWtsr
	/NvPIxMNcC/E+zdHcfAHFwyytt0lfXsJjcdhjuHAOwSnIO8CtTQ32vWFwc5kwixtLpn/+DeyQhul5
	LGp+2Ui1h9p/+koB7j/2cjOyHm3UsWeYAMaAff2R6ht+1/7kqeLz+e1ocXHUl/cwIcWASGaQj5VSP
	12JmoLs1EvhLz3chIZpyn1drpkkeWHq90SZF61vnENNqiW/LDNnHFXhakifqcyVpSth24GZwK4RZJ
	KOjOkDMA==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sm8ZE-0008Be-6j; Thu, 05 Sep 2024 11:14:16 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 3/3] phy: phy-rockchip-inno-usb2: Use dev_err_probe() in the
 probe path
Date: Thu, 05 Sep 2024 11:16:08 +0200
Message-ID: <3681742.qqrk5fENW1@diego>
In-Reply-To:
 <d4ccd9fc278fb46ea868406bf77811ee507f0e4e.1725524803.git.dsimic@manjaro.org>
References:
 <cover.1725524802.git.dsimic@manjaro.org>
 <d4ccd9fc278fb46ea868406bf77811ee507f0e4e.1725524803.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 5. September 2024, 10:28:24 CEST schrieb Dragan Simic:
> Improve error handling in the probe path by using function dev_err_probe()
> instead of function dev_err(), where appropriate.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



