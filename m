Return-Path: <linux-kernel+bounces-304576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F0962206
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA791C22AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBE715AD90;
	Wed, 28 Aug 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="YAmMxwrz"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032BB67A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832598; cv=none; b=hc5jC7l8aGwxez0dqkUwFB8CzVPRwUvAOjICnlW6QaRbMD+/o3H2WDGJZdkg5MrNPH2ImdI1C2G6zvabmodJpUtJfmqyQXAjwZYmXetvV42cKhfKftXfOLqRrdAgu/Z/y69a7Z11GMesTd75Swxyy1ntIU50rgP94foaVJakK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832598; c=relaxed/simple;
	bh=ATXfuluc20kh0bIFPsBJzv7W0cPh4Z6+eJWI+VK/c88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTf1v0E5uwnijtzd6lKmZFHaR+21EH6b9v0eJMKbitt/jh8WfuVWchAh/bOiYNEAYpcXMvtVXoKPIjN/bSNrOOEFAe4CO/J+Sg/2yTLSo7HtvKJTbnj0ohEFd3oKSQVLU4m4cYzYICN23B2XWe3BMUlUqoaRW0y6lJAi9ZGNiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=YAmMxwrz; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B03A1483480;
	Wed, 28 Aug 2024 10:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724832593; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MF2XTM8R20QlpXwyM/fJMmMeJw92/M+79MgDKWPVo+8=;
	b=YAmMxwrzKT4TBODgiDE8BAxQQGlrqcmFj3RbqrTQpUAiqZno08Ncl6Iw+w+wZp6dPCPtiM
	yT5KaO/PJ/HVil2J1lmCPTxf1ojudcdOuMzc0EJ8RhAmADptD+qyvQkqyPJkJR2XjKMML+
	WfcPFS7MssncF/k3+j7JL5KPoJtqtGDF7us7Kh58Zm7fW/hQklne/IXxO2eKWiJ2ALQh9e
	tA1ddQrE6+AJitFltGmK7EceRy0h9QwvgT3ZxIfNZJt6yvlcbD39JUEYCRKBck3fenOt2a
	/WxllIt1vigiJRdNhiMhSlo2VnwW1H4hM/d1WXSH4TIhqINzRdViHmfkXtduFg==
Date: Wed, 28 Aug 2024 10:09:50 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Alexander Dahl <ada@thorsis.com>,
	Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	"moderated list:MICROCHIP OTPC DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v1 04/12] nvmem: microchip-otpc: Add SAM9X60 support
Message-ID: <20240828-unworried-borough-b5738c8216f6@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	"moderated list:MICROCHIP OTPC DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-5-ada@thorsis.com>
 <6a234b6b-ac4c-4fa8-8809-df56327f7b9c@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a234b6b-ac4c-4fa8-8809-df56327f7b9c@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Sat, Aug 24, 2024 at 06:53:53PM +0300 schrieb claudiu beznea:
> 
> 
> On 21.08.2024 13:59, Alexander Dahl wrote:
> > Register layout is almost identical to sama7g5 OTPC.
> 
> Can you please mention some major differences?

- SAMA7G5 has an additional bit SECURE in the OTPC Header Register
  (OTPC_HR) not present on SAM9X60.
- SAMA7G5 has an additional register OTPC Secure Custom Address
  Register (OTPC_SCAR) not present on SAM9X60.
- SAMA7G5 has an additional field SECDBG[7:0] in OTPC User Hardware
  Configuration 0 Register (OTPC_UHC0R) not present on SAM9X60.
- SAMA7G5 has three additional bits (SCPGDIS, SCLKDIS, SCINVDIS) in
  the OTPC User Hardware Configuration 1 Register (OTPC_UHC1R) not
  present on SAM9X60.

All are currently not used by the driver.

Is adding this information to the commit message sufficient?

Greets
Alex

> 
> > 
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > ---
> >  drivers/nvmem/microchip-otpc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> > index bd3383eabdf6..b8ed7412dbca 100644
> > --- a/drivers/nvmem/microchip-otpc.c
> > +++ b/drivers/nvmem/microchip-otpc.c
> > @@ -271,6 +271,7 @@ static int mchp_otpc_probe(struct platform_device *pdev)
> >  
> >  static const struct of_device_id __maybe_unused mchp_otpc_ids[] = {
> >  	{ .compatible = "microchip,sama7g5-otpc", },
> > +	{ .compatible = "microchip,sam9x60-otpc", },
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(of, mchp_otpc_ids);

