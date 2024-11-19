Return-Path: <linux-kernel+bounces-414396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19319D275F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680382851CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFD71CEAC6;
	Tue, 19 Nov 2024 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2de1Jntw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016E1CEAB6;
	Tue, 19 Nov 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024329; cv=none; b=HS6HHjnV8nTmnJBMPP0vgvnX5TazYunNWpQmET18NmvFUkvuVufFA9Okd5NUSHySDmCd/3Pnfg/ap8p7w95ZXPg6WTmcgWVVPP33KvNH1oKKcaGTP+PNitMEjl3xChKLXKEmxLAWJTo6LDFhAnKUSKSUOOKxTBJ3kI4peudXRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024329; c=relaxed/simple;
	bh=LlQiMmQN7UbYtRfxa1QiatqRrYWSPu3wGYqKNrXoHQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9L/SoeH5z0slJNluG54mbJwY5S0lUdRQ8UZ/1XP8LtL/6KYWG1Od6GgHZX1neza2O6DH+odhMko5ckKx91rZ8cWuwLhQj+QFcx4KVDkZ4IW9+Mn8FqYmrC72zY2U/JQgpKLyuSgG8zp2bRL/S4mIQvTGgcxIeEH+KYGFERYC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2de1Jntw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wdskGiAKE5aPLX+jUFdMvBaqDF22aG0Vy96NCz1MBtg=; b=2de1Jntw/tTC85BNE2GliQMS+D
	BAWUVmGyNsHpfjl7okrvpe3K8Qfvxom16AzCvMLt/j/UYV1eUD+7ivtW3wjDxoLLVDlcyl8QJGNA/
	U8B8zjQVky155gqqSn0+LHA5j3H38O6j3jf3TU8jHKWwIa5LQrZJXYbBf/xV7V8bt9cV+yIZVIXJr
	V2SKemyBJqfmIAPsf1xhhSlHi/kpKg7Z5U9SjD2Mjw8TeOu4IiHWdB9E9t6GjuWZw5a7bRFx0jwh8
	6npMIu0a8DXTOrsz9E+KgXdRrsFRsbMZDvYFy7HEzUtBeE10tRZB9MCeIiEY9FYM6pCfWIRmDJ3bj
	1du4/OWw==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tDOe7-00079C-QT; Tue, 19 Nov 2024 14:51:59 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: srinivas.kandagatla@linaro.org, Diederik de Haas <didi.debian@cknow.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 detlev.casanova@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 sebastian.reichel@collabora.com
Subject: Re: [PATCH 1/5] clk: rockchip: rk3576: define clk_otp_phy_g
Date: Tue, 19 Nov 2024 14:51:58 +0100
Message-ID: <2989559.o0KrE1Onz3@diego>
In-Reply-To: <D5Q78ZOX5SE0.2SCB8FEGY7EFA@cknow.org>
References:
 <20241119132916.1057797-1-heiko@sntech.de>
 <20241119132916.1057797-2-heiko@sntech.de>
 <D5Q78ZOX5SE0.2SCB8FEGY7EFA@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 19. November 2024, 14:45:53 CET schrieb Diederik de Haas:
> On Tue Nov 19, 2024 at 2:29 PM CET, Heiko Stuebner wrote:
> > The phy clock of the OTP block is also present, but was not defined
> > so far. Though its clk-id already existed, so just define its location.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/clk/rockchip/clk-rk3576.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/clk/rockchip/clk-rk3576.c b/drivers/clk/rockchip/clk-rk3576.c
> > index 595e010341f7..029939a98416 100644
> > --- a/drivers/clk/rockchip/clk-rk3576.c
> > +++ b/drivers/clk/rockchip/clk-rk3576.c
> > @@ -541,6 +541,8 @@ static struct rockchip_clk_branch rk3576_clk_branches[] __initdata = {
> >  			RK3576_CLKGATE_CON(5), 14, GFLAGS),
> >  	GATE(CLK_OTPC_AUTO_RD_G, "clk_otpc_auto_rd_g", "xin24m", 0,
> >  			RK3576_CLKGATE_CON(5), 15, GFLAGS),
> > +	GATE(CLK_OTP_PHY_G, "clk_otp_phy_g", "xin24m", 0,
> > +			RK3588_CLKGATE_CON(6), 0, GFLAGS),
> 
> RK3588? 

darn copy-paste, thanks for noticing ;-)

At least the register and bit number is correct though ... according to the TRM.
So I messed up only the constant and did not notice due to the gate being
ungated by default of course.


Heiko



