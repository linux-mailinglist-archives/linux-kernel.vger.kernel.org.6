Return-Path: <linux-kernel+bounces-233080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD45091B203
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6631C1F23BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7D1A0B12;
	Thu, 27 Jun 2024 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YmyHvdPa"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB8146D6D;
	Thu, 27 Jun 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526352; cv=none; b=QuPMAflwiB5aJV47yLRmGsIZG2+Hrnzs0RrKnmInpxZs12FRmPI+dr6Fss+ypHjTo8QyXkeMFYOIopoW3fPzcl8iq2Ux1ipxZuZT2Zvnv5AFTaNdhA/CXKVTYRs35qCtfmOa3FvPobnVKksFcdGCqfFcCRT0LTSG6bMEAnf7WTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526352; c=relaxed/simple;
	bh=HdBxQ46+P6eutUUkVuadiYIuHIQ1lkuJpOaAKGy90Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpnZwa4PdpMuVGJG2Tmk1111TQnRjMXpfOSwTyMK7AGIvcEF8cX7z3anSeA6IZZArS+pxOaKV4kddAdX0c32pPXyFc94TWJ2OySgCpScuO/DKCiPRYi85yibXlJNA+hhp7kxAtb/JFAL/g0HUX6quUQRMZatqjx0NoEFtC0NfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YmyHvdPa; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EC1EFF802;
	Thu, 27 Jun 2024 22:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719526348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=An5BEZM8QiDYdH3dqXe26yVMRNsjCS+5IhvPPev7uZU=;
	b=YmyHvdPaAmHd7NJs13uHNr7BxKk062IYv679uc9DFupHoLmaWhpNE2NEksbOFnj7sezzHK
	R9QjGgMkYh0QbEZTpxXSbxWVIw8S4i9KyPL6fe2D5NLclX6dxZYBVAYPJclzaNGvIRi9xb
	48uuN21ntvZgZlhW8uFI2w2lBb8/SxPzj9r2M28iMe2pFHntkaxdd3jo1cbLm1X3qPSywL
	/pxrhR/AfZUcoKlDCtQLdfu2zffwwGv3g40vY/+D3BHIXsXs8Vey8uKgWXIrZWmjmmXQtX
	D1dSPfcCUDOeapGfOUCQ9sria7xvA6LTbmkrA7Ecn0aW66GA6fyoAK+fSelFYw==
Date: Fri, 28 Jun 2024 00:12:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Aniket <aniketmaurya@google.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] i3c: dw: Add apb clk
Message-ID: <20240627221225e3517e4e@mail.local>
References: <20240611171600.1105124-1-aniketmaurya@google.com>
 <20240624052851.1030799-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624052851.1030799-1-aniketmaurya@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 24/06/2024 05:28:48+0000, Aniket wrote:
> These patches add APB clk aka pclk to the dw i3c driver
> and the binding doc. Also move to _enabled clk_get APIs.
> 
> Aniket (3):
>   dt-bindings: i3c: dw: Add apb clock binding
>   i3c: dw: Add optional apb clock
>   i3c: dw: Use new *_enabled clk APIs

You should reorder your patches to have 3/3 before 2/3, else you
introduce code that you immediately remove.

> 
>  .../bindings/i3c/snps,dw-i3c-master.yaml          | 11 ++++++++++-
>  drivers/i3c/master/dw-i3c-master.c                | 15 +++++----------
>  drivers/i3c/master/dw-i3c-master.h                |  1 +
>  3 files changed, 16 insertions(+), 11 deletions(-)
> 
> -- 
> 2.45.2.741.gdbec12cfda-goog
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

