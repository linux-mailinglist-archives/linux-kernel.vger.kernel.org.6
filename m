Return-Path: <linux-kernel+bounces-432796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0FA9E506E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECA3283D50
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791E81D5AA0;
	Thu,  5 Dec 2024 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oP8OJjsW"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD21D515D;
	Thu,  5 Dec 2024 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389175; cv=none; b=Kb1IrB8l35X+LdrWWsLjd7UBYgD3UyBFRrwze7TFJaEeifHnFaFAsKj861hmT4g1rjX9uLeAdW43IkdTNBsaBiomNVaBAgklm/PIf6VAF9xrsl/ArHeatKo3dhCSjHGp4Z9YzDhhCEy/w6UoGBbO80HZZCRzDIIMLvZeISFVj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389175; c=relaxed/simple;
	bh=aDWgYQBwKAkBmU8mqem4U1vbpJlKGSSLkLEYV7hJT08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8rCGm2TUTtDM6ylCk2ASZ61Gw0GyXdYDTn53cv3RIxwfOSwyDXdKAugsiEOD4aWM12wHQOVR94gbfmvTr4+BWMCi+/65s4FKj4GOh996FEIlogIuXtLD1z5suE7CRoX2KyaeExuuEvzWOcBsyNl1u75oSag1osVuhPHgSP4bOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oP8OJjsW; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aDWgYQBwKAkBmU8mqem4U1vbpJlKGSSLkLEYV7hJT08=; b=oP8OJjsWLoKfVicRB2LCXen8Vl
	wH0npdneX8nZoBc05jmy+wn01h/O79FQyoNgPNcTc8jghL1U22uxnxEpjIlQpY4AagQwBuZtxNAno
	hkG5CHYLT4yA4bZTLhJzflIO4ZR8LVMwJdLym5YbBZgHkS1FxoVpgSBzyU9aEsEhUApUUvJeAlMoA
	WDvYf6r2yPGQyZMRcP9AbgqR3pViyuS5kGpBLgl+P71FeW+ZbX9pX/EcXIoyUlXlMl4A49AFSpztn
	6PTFygzbmF1nJhH8VpI4V1LuETGyxsRLGGFIZ8hSZOxjg72rCjkhy83WoBzXpHI5VOWqWeSFfqfL4
	ERYaTxqg==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tJ7Vv-0001iq-2o; Thu, 05 Dec 2024 09:47:11 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Frank Wang <frawang.cn@gmail.com>, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Kever Yang <kever.yang@rock-chips.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
Subject:
 Re: [RESEND PATCH v3 2/2] phy: rockchip-naneng-combo: add rk3576 support
Date: Thu, 05 Dec 2024 09:47:10 +0100
Message-ID: <5541205.29KlJPOoH8@diego>
In-Reply-To: <e853b62f-2ebd-4520-8dea-15d8102f25d8@rock-chips.com>
References:
 <20241106021357.19782-1-frawang.cn@gmail.com>
 <20241106021357.19782-2-frawang.cn@gmail.com>
 <e853b62f-2ebd-4520-8dea-15d8102f25d8@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Kever,

Am Donnerstag, 5. Dezember 2024, 09:21:07 CET schrieb Kever Yang:
> On 2024/11/6 10:13, Frank Wang wrote:
> > From: Kever Yang <kever.yang@rock-chips.com>
> >
> > Rockchip RK3576 integrates two naneng-combo PHY, PHY0 is used for
> > PCIE and SATA, PHY1 is used for PCIE, SATA and USB3.
> >
> > This adds device specific data support.
> >
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > Signed-off-by: William Wu <william.wu@rock-chips.com>
> > Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Test on rk3576 evb with pcie port.
> Test-by: Kever Yang <kever.yang@rock-chips.com>

nitpick: the tag should be named

Tested-by: Kever Yang <kever.yang@rock-chips.com>





