Return-Path: <linux-kernel+bounces-393580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4ED9BA29E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E454DB22836
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FFE1ABEA0;
	Sat,  2 Nov 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dUbpU3Oq"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945D1AA7AB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730584668; cv=none; b=RmkVO9SGKlHmnzMwpAHDj+IKhoLm88CRybGXU147tr+OhJOeuxR/oFBfICnZl3KlkkVZk/qYpLKfY5NBfOBaG7a5e9Xkmodsd1mc3TJ9Qo2tpRqIBM5osf18alNFFz97zEn+89SRDZAQ+Gv32/Tp/JYy4Raf4lmgR32usw+j/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730584668; c=relaxed/simple;
	bh=T1KWqA2mQphX03EbLrEOx56VxIhK3se8lNKZYT+3gDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnk8G6K+fAGdfdYnS4m5TXE53o40Fli05Qc3HjjaMIEhUfNa842umIuKUTXd635UF2fdy1NzRVfHsIl0LnXmQ7SDiMyKa8IXDu/uZIb6CzdgxPp1fKvAG6LCnxHXp6dXGUD61u/gPEMwOF0UraNO3SQw9fq0rV49XgsPkOasCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dUbpU3Oq; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 654DB240002;
	Sat,  2 Nov 2024 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730584657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXexRIqonxXbwwjZfWS8TncvThZ06Lgb4mpHYQaEmuo=;
	b=dUbpU3Oq0gFXPE0fErNip2xqgc8AZUmJauISfT7RXm8IX4u5e8TuTm1QDi968KnLPtt4PB
	TEK/o1bYCaE/3O/Mb+rS+6GJdGBfIEByt5XlNrhX65H/l7PTYg3w06G5pblBoUzV88NO3F
	3Fgru1H56+XKHI7Fy7MLtXrCkFPcQp/QuOqa8IEsWOnXUcNYcs2EgXiB4vVlUkzaA7FOMK
	z4NQdD6Bg7E+zaEWsakUUYEvsvD9rCedySmm2BCXbxYfePeLj0XMyu7jc4R0/xpaHp7dlu
	8etAPkFRAfsuBpnlFoul3m+rLdRVLNTxAcqyuyH7JJYGSf5ypR9D5zjfgeVKCA==
Date: Sat, 2 Nov 2024 22:57:35 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor.culhane@silvaco.com, imx@lists.linux.dev,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com, xiaoning.wang@nxp.com
Subject: Re: [PATCH v2 1/1] i3c: master: svc: Modify enabled_events bit 7:0
 to act as IBI enable counter
Message-ID: <173058462779.2458498.8277709682001410265.b4-ty@bootlin.com>
References: <20241101165002.2479794-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101165002.2479794-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Fri, 01 Nov 2024 12:50:02 -0400, Frank Li wrote:
> Fix issue where disabling IBI on one device disables the entire IBI
> interrupt. Modify bit 7:0 of enabled_events to serve as an IBI enable
> counter, ensuring that the system IBI interrupt is disabled only when all
> I3C devices have IBI disabled.
> 
> 

Applied, thanks!

[1/1] i3c: master: svc: Modify enabled_events bit 7:0 to act as IBI enable counter
      https://git.kernel.org/abelloni/c/25bc99be5fe5

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

