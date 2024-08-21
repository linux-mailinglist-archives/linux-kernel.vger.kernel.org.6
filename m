Return-Path: <linux-kernel+bounces-295497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63179959BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3E71C21D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79B217A590;
	Wed, 21 Aug 2024 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tHRbgVNn"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD916631D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243481; cv=none; b=ZyYHkoJQ1B7z3IFlJFUHItQDVXs31J7LlL9XXD5E1CABun2dfA1ZZfzJTv2xc14vWuxsPLN9TUntkH3QmwB9v+tdDLLewhE9r3LhONWJdO9DHau5Y1D7oV0r7sDx3eY2mnnac+b4b6YBcBkPCs38rq3tgNdyxuNYtW/4WKMluuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243481; c=relaxed/simple;
	bh=4X3Hju3HoOl6PDeRyRc+tz2GJbmu9cG46OqJIb2z1aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gid4WFSS4RA1UefvmRDSviDs7aGNKiCqk6O8z1coInZFeBS99gVuHtg2eDIHulTLmcdQ5U5JvskraTfpN6DPWi370VpID1imJs970cKHc7kkMgkxh1ZcNEjtkOUaW2Yf+vUlmpzVKdsUE72+9+L+ug8RIXGEG1oLdvmMmxuQbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tHRbgVNn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iY99HQ7d/goFyW/y/HVSACQ2NBsAnAybrbNrmlecvhk=; b=tHRbgVNnoAkdfaSr0B2e1WqjPX
	/wkmQi05zDoCfPhTHUJn4QgbkFyB8JMq7UR7G8TQLndzNuh5bL8NmHEBKTIz824zQqGdQAtXL6lsf
	+s/y488E/cZDm9LQRodSvq3JU2d0txeKDDaIen8eaDYo/FEofI4ex6yF72FrrP19R5ss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgkUd-005K4V-LM; Wed, 21 Aug 2024 14:31:15 +0200
Date: Wed, 21 Aug 2024 14:31:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yang Ruibin <11162571@vivo.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers:bus:Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
Message-ID: <babb0086-2299-4905-89dd-59e30e1f3c36@lunn.ch>
References: <20240821112131.6004-1-11162571@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821112131.6004-1-11162571@vivo.com>

On Wed, Aug 21, 2024 at 07:21:30AM -0400, Yang Ruibin wrote:
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.
> 
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  drivers/bus/mvebu-mbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index 3c99d72087eb..42621838ba75 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -995,13 +995,13 @@ static __init int mvebu_mbus_debugfs_init(void)
>  	s->debugfs_root = debugfs_create_dir("mvebu-mbus", NULL);
>  	if(IS_ERR(s->debugfs_root))
>  		return PTR_ERR(s->debugfs_root);
> +

You are not supposed to check error codes from debugfs, since it is
optional. The code should just keep going, independent of failure or
success.

>  	s->debugfs_sdram = debugfs_create_file("sdram", S_IRUGO,
>  							s->debugfs_root, NULL,
>  							&mvebu_sdram_debug_fops);
>  	s->debugfs_devs = debugfs_create_file("devices", S_IRUGO,
>  							s->debugfs_root, NULL,
>  							&mvebu_devs_debug_fops);
> -	}

I'm surprised this code compiles without this close braces!

	Andrew

