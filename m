Return-Path: <linux-kernel+bounces-225879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB0791369F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00121F22433
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3556770F1;
	Sat, 22 Jun 2024 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YI0w9F/4"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A94206C
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719095628; cv=none; b=DNJivuR8z76e1Hh+9Wmk/FNuvpkXCO5T4dAUb84UZtP5NDxlm43dQxbWwOaUO2KQm3EoDFeg8jz+jeXPsmx9CAoSe43YJBs3PCcNW+S2YEhmUjOfVgZsxesXqcJQQAHwgvCYN3XKpy3Au6GFYI3vv6vkYiv6RcgkJZPNHxDSWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719095628; c=relaxed/simple;
	bh=5tyr8IBa1XwvEjvQMi3KDeyuY+EG410ppTE3ZhlCP70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdo6N2gVc/Dqq0z+lxot0AAaNDPHXxxVBUXSjQosjREDMou71N7U1gS4fN/pBe+O3Cvx9WPcqAV2qshwDQyJS+9vaUzNUFVJmtKjsH9nXH6PrYcUZrU58nRVlb4WZN65wHl++y9cHw/XEMCVVRB/DHVVcHTojAEDGLgTzJaWevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YI0w9F/4; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2C82240004;
	Sat, 22 Jun 2024 22:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719095619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LU2ICDL4fp4IsPfmkBKqQ0+h5x4H4+vh585u8iwlvKQ=;
	b=YI0w9F/4+gsDXJxti2JhDcfgtEYK23ABTaOePkV+6My8LiUYPCcF1NopzoKL407rOdX3Qc
	8bL+aEbUhnUnB/OFB5gaGcxwwFRDZ4i/yu3dBlOFlzmgqfDnPtgdr3/XHhEkXmzOLcLcQq
	3v/Fane+HIJ/pVN8wHHWBDHlCfbevmOori/P+Nthm5fK4ijHp+f8Ey3IabvoTsqWkP6jnG
	zDewbhMwG2fgLOgFTQbnsGzY8ig11OK9OP3jWKSXxOoNTy/KhOQY+/3Vz4eD5xcjL6RLUz
	6H5b4+dtcnYu5Lo96dy6DPGG7DXCr+U/mzir6Y6vS5ev6vXvlOaVF6soZg9K1g==
Date: Sun, 23 Jun 2024 00:33:37 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Aniket <aniketmaurya@google.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i3c: dw: Fix IBI intr programming
Message-ID: <171909557751.2164405.7866528644975058275.b4-ty@bootlin.com>
References: <CAMmmMt2guEx1jajb2NC0iBnMGpkd2vaSiXg_BqgZhwrA=FARLQ@mail.gmail.com>
 <20240607072030.2618428-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607072030.2618428-1-aniketmaurya@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Fri, 07 Jun 2024 07:20:30 +0000, Aniket wrote:
> IBI_SIR_REQ_REJECT register is not present if the IP has
> IC_HAS_IBI_DATA = 1 set. So don't rely on doing read-
> modify-write op on this register.
> Instead maintain a variable to store the sir reject mask
> and use it to set IBI_SIR_REQ_REJECT.
> 
> 
> [...]

Applied, thanks!

[1/1] i3c: dw: Fix IBI intr programming
      https://git.kernel.org/abelloni/c/76fb85b86b40

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

