Return-Path: <linux-kernel+bounces-365140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987A99DE14
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98065B216F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A3189B84;
	Tue, 15 Oct 2024 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bR4d6afx"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B146B8;
	Tue, 15 Oct 2024 06:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973160; cv=none; b=Gux/eOVqBj1syUsJojxhaDVQXLTzTazwjv0f9MAXq/tSdi+7euHSigsp58izXtjU1JVsqnkBmDbexS6ZwRekVkdLznU/kuxqX5xKCmQFh/V9YcR+IQOPdftWiwBhMq58mgrwXy55ISetxplqctD5KzuDEJq+yz4PHXu+VDuH2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973160; c=relaxed/simple;
	bh=HniKCQAw6FewQ8py49dSviepDWPoZrSpPw2jk8oQFUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMfzYHRvUxiO29wEay6ba634aee3DF5Wu6HpdV4cnQY0mK2qwQ1LGjMjQhh5OR27ruZn6oN31PrU0Vi/mOfhnlXA183yKIeIIfSrAkm/tuONkIsfQh/RBjjWl6oVl5guHwvFac/8iERBA5AJTNv0Kdkx8vu+ajQNs9nzfC0q+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bR4d6afx; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pbGxIxApaT188ztxWowHhsxXWg/UWKzfailGZ9HOj6k=; b=bR4d6afxtSfPiBL9RUQQh6ZQbv
	n6XgBrDTA+9vyrG7hOeNF3EBFDmjXqit8eSLnucBpOOgoum6e/h3anebDZr7RFEvAAnrhHPiBf7BP
	ecjgwneMqhgGJKd5y/kjP9b06aeYtGtQDuuoIvGZ24E1BEvVK7ehNraRjOozHyKH44MtbJj31NCJt
	nZDvHzkrKrlR4h2oq0nI8F5dWzjNlcLcVGKfhP15qvjaDU6+u7M+y8LK3vfwIMKZkYA692ZdT/MdX
	Kj7Jhq7i2bZazszUH56sPviQx2fTSl0hBpXSkxydGfjLyrIWA4kM2z4+wrjK7WYnY/pq6eoGLv2e7
	wBwjOjSw==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t0ato-00074m-Kc; Tue, 15 Oct 2024 08:19:16 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
Subject:
 Re: [PATCH v5 2/3] dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
Date: Tue, 15 Oct 2024 08:19:15 +0200
Message-ID: <3589922.iIbC2pHGDl@diego>
In-Reply-To: <20241011065140.19999-2-frawang.cn@gmail.com>
References:
 <20241011065140.19999-1-frawang.cn@gmail.com>
 <20241011065140.19999-2-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 11. Oktober 2024, 08:51:39 CEST schrieb Frank Wang:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
> 
> This change also refactor the clocks list as there are new clocks
> adding used for the USB MMU in RK3576 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



