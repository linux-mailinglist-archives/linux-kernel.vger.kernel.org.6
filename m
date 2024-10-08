Return-Path: <linux-kernel+bounces-354875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D39943DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800761F2454B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6FD17C992;
	Tue,  8 Oct 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ElnNKxrl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86623A0;
	Tue,  8 Oct 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378819; cv=none; b=EtjOniQNwrj95S76XO2umGNphquPPHEz/M4LQ8GGYBCLZYZzSgq2AkTElvkF7C20KuKBgDq0KXBMj7ZwFGRgzzII/tNBD738HdRGZKDgKVLRmFDNu/jJ3PZslEDT7eOib7UNjIx3xEcPFmRArcSXUJ2FHFdXdw1eghKgxCfAJi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378819; c=relaxed/simple;
	bh=c+jWkPxmT1WA6o6yZy0Mhglmn6anGcBrRkNRbzmbQ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEtBS2nXvRcZl0ReWCqVhJjqdJL642CaJ1Iq5jjRznU7SUUokFbyIi8r8WP1rLLzV+dsbdH4hM5A6gv69L5L2vmGxFoUMD/Cd04C4RB+ix2AKe+5J8tmFCis0rOCIc/upEe91O3tsR0ar87boo3UX3MijW2NnJx3rnqEI1ePcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ElnNKxrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E766C4CEC7;
	Tue,  8 Oct 2024 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728378818;
	bh=c+jWkPxmT1WA6o6yZy0Mhglmn6anGcBrRkNRbzmbQ1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElnNKxrlOn+Tb0tS4/wpvCVfYoiI9sFWvCaKDTMBy6e9KXu/QkQ72ESObQy7i7ZhI
	 fx8P3tUoex32YxGOtKwHOFggUmXsigz7H5C0dm7PhlTWYj1CXcK+JNPAkx6hkrh1xp
	 Vf6ycZ1a67oHsM4nzNivzl76ZSXGJywRuuekFwu0=
Date: Tue, 8 Oct 2024 11:13:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mihai Sain <mihai.sain@microchip.com>
Cc: richard.genoud@bootlin.com, jirislaby@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] tty: atmel_serial: print the controller version
Message-ID: <2024100822-mantra-customize-cab1@gregkh>
References: <20241008083459.51249-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008083459.51249-1-mihai.sain@microchip.com>

On Tue, Oct 08, 2024 at 11:34:59AM +0300, Mihai Sain wrote:
> Add support to print the controller version similar
> to other at91 drivers like spi and twi.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 09b246c9e389..5f93974918c0 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2970,6 +2970,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
>  	 */
>  	clk_disable_unprepare(atmel_port->clk);
>  
> +	dev_info(&pdev->dev, "AT91 USART Controller version %#x",
> +		 atmel_uart_readl(&atmel_port->uart, ATMEL_US_VERSION));
>  	return 0;
>  
>  err_add_port:
> 
> base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
> -- 
> 2.47.0
>

Did I miss patch 2/2 of this series?  I don't see it anywhere :(

