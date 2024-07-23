Return-Path: <linux-kernel+bounces-260479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6E93AA03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D101F233DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A345E149C69;
	Tue, 23 Jul 2024 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gqf0pAxX"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E434F615;
	Tue, 23 Jul 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721778666; cv=none; b=aXRvBQUteuNlnZv17mkI1OQiNZdTj7FZBEhIfTXE7mmMPkb+86wqpF1ckm0RFB4Pv1SsZukUeWA1NsDFNCJ+xyGQKhFEsmwPZOgryo/VSXUG/IydcS6ATlXl83lnuNTV1cWMp3FhopWdKw3u754W2PXS/mmFRIFxFSYBF7Ff82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721778666; c=relaxed/simple;
	bh=L6oYn6cBDwIVAtBgOT10pEatJKNKbH3iX+8CEzbzI0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNHJAAx/8wN7iXxJ03BXH3mb+bGkw+gksnXxYjR4GG0g9U31JqalpAytA0ceaGSzfDfkmejBcS9THmZ+3kX0LF//7lI7WJoWZGavis/SIBH7E0M3gKY5Ts6V1Xh3z7OzS1bdmB+QNS6SSXkSuRcxGlF0CqnUtDgz/jzY1W5P0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gqf0pAxX; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DFAD240004;
	Tue, 23 Jul 2024 23:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721778661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiIOw1r8yhLx71uC/aS7jn7kaBhroeWFkE1IfyX8uGs=;
	b=gqf0pAxXRpI71rY/aTbw5S4YJ7ugrB6d4uVFI+ZcC4T/OHC0bPEgEibI4LhMEhP16yxWb6
	BXcN3/tE+q8GA23f8xkWLsr6dtZ7pmedM+hA7+Ny4lotozr5wiT1AXplpKScfHDwPAH3IB
	kv0p+gU8WOJUIII30EZ9vRS2dXNJnrUOU74SLnpwIsu651ciWiv4Og4TcJ4detAA99WQny
	dtytKdjw++fX4k7D1hLMiHR1NxtMkpgORV/1wA/oBciRYTsuOrHh7sSVqSnH07BF83v/XX
	ZQ9G+pM4rDsn+gwFqkeRUeJM0EdmZJQZW6CtGhc4KIU9F2YwVEOJxbDHoNVfVA==
Date: Wed, 24 Jul 2024 01:51:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: Fix error code in
 svc_i3c_master_do_daa_locked()
Message-ID: <172177859262.478132.18174529033943976070.b4-ty@bootlin.com>
References: <e017edfc-da64-496b-8516-958bec27cd9a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e017edfc-da64-496b-8516-958bec27cd9a@stanley.mountain>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Thu, 18 Jul 2024 13:30:22 -0500, Dan Carpenter wrote:
> This code has a typo so it returns positive EIO instead of negative -EIO.  Fix
> it!
> 
> 

Applied, thanks!

[1/1] i3c: master: svc: Fix error code in svc_i3c_master_do_daa_locked()
      https://git.kernel.org/abelloni/c/82a8702d94fd

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

