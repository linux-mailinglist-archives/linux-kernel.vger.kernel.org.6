Return-Path: <linux-kernel+bounces-559642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D90A5F715
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C9C3BDDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF9B267F4E;
	Thu, 13 Mar 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="fShdanW6"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFDE267B8D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874178; cv=none; b=PaaZcbeQ/RKMVPQCbxosBOdde9Imhu2dzAzELBjo/wRPPcF+zQoGHI/U2XvBVu81Wc5MfziyBjp96Z7qqH0SvXrn1FXCuiIAm45ZIyO87mZ54J9Z6Q4qQ/IjvBDnaGXaKHd0f4UIJxoJNSYjU/U7Unsyj0om84x3DKLiXFN+IY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874178; c=relaxed/simple;
	bh=qlYjQkndD+jN2uSnFaoEaumU1+kID5pARueOA2oTUyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgoPzvw2QZyLMATFJLzlsnSFnac4ibVzGKXVGTgBVFjlh0dVv8EgL2seFKAPJQ7ULs6HUjBrR0OHYFb6zFyinbjroIrlRBvgxcgiPWTQfEIt35gsaL6/kuc+OX/HCjIls27g6wCCkD/3inHZp+78sWQRgTxtbTXEus0hBPCCROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=fShdanW6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=lM0g+et7+koHvwD3M6Xbjrzfe2Oj1PGsMfiK3GoCkb0=; b=fShdanW6PbvuMFwP
	d1KJgdHaBd9oqatJIw5wA440G9mE87T9T7pcZPbqnEr/U25jvEF/fb9jkBiIllm6yjUBaGXMMQJgQ
	3riEx4T9FqTUlLmZiGaj/BphArEk5qjlRF7Rd32O8Nk5ugQp+6Rs6nNZ3MgczTvCMMeJf/PhJqqk1
	M1DTti6LAUeCZ3X732q2w44mc4TrghGxiJFwWclX5/WpD3EcVD9ZBRndSnT32MSTRfq9BaZ/R0ZiT
	LPvwKn/OT/+x1DBiy/Bku+Tk0CNowUwiHyCcmqWlK7X42Gp5xocQUlZ9yqWJJfN55QiR9kbcqmAIZ
	R8pIkXl1jwJioPNI7g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tsj2d-004e9J-1n;
	Thu, 13 Mar 2025 13:56:07 +0000
Date: Thu, 13 Mar 2025 13:56:07 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: gregkh@linuxfoundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, stuyoder@gmail.com,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: Remove deadcode
Message-ID: <Z9Lj9_yM1EK5pKee@gallifrey>
References: <20241115152055.279732-1-linux@treblig.org>
 <3f9dbb7b-6527-48e1-9028-b46e5a0c58ce@csgroup.eu>
 <Z9LbwRUsHwFLpBZA@gallifrey>
 <362f9392-f891-4a15-9ffd-5f5a6cac41b8@csgroup.eu>
 <oz65tdekf2ywyzadbntuxntwxulcdzyo33se54qqdsddkogquh@bqnmsmqijfvb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oz65tdekf2ywyzadbntuxntwxulcdzyo33se54qqdsddkogquh@bqnmsmqijfvb>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:54:58 up 309 days,  1:09,  1 user,  load average: 0.13, 0.07,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Greg,

* Ioana Ciornei (ioana.ciornei@nxp.com) wrote:
> On Thu, Mar 13, 2025 at 02:37:56PM +0100, Christophe Leroy wrote:
> > 
> > 
> > Le 13/03/2025 à 14:21, Dr. David Alan Gilbert a écrit :
> > > [Vous ne recevez pas souvent de courriers de linux@treblig.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > > 
> > > * Christophe Leroy (christophe.leroy@csgroup.eu) wrote:
> > > > 
> > > > 
> > > > Le 15/11/2024 à 16:20, linux@treblig.org a écrit :
> > > > > [Vous ne recevez pas souvent de courriers de linux@treblig.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > > > > 
> > > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > > 
> > > > > fsl_mc_allocator_driver_exit() was added explicitly by
> > > > > commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")
> > > > > but was never used.
> > > > > 
> > > > > Remove it.
> > > > > 
> > > > > fsl_mc_portal_reset() was added in 2015 by
> > > > > commit 197f4d6a4a00 ("staging: fsl-mc: fsl-mc object allocator driver")
> > > > > but was never used.
> > > > > 
> > > > > Remove it.
> > > > > 
> > > > > fsl_mc_portal_reset() was the only caller of dpmcp_reset().
> > > > > 
> > > > > Remove it.
> > > > > 
> > > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > > 
> > > > Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > 
> > > Hi,
> > >    Can someone pick this old change up please?  I see the PPC patchwork says
> > >    'handled elsewhere' but doesn't say where.
> > 
> > MAINTAINERS file says where:
> > 
> > QORIQ DPAA2 FSL-MC BUS DRIVER
> > M:	Stuart Yoder <stuyoder@gmail.com>
> > M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > L:	linux-kernel@vger.kernel.org
> > S:	Maintained
> > F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
> > F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > F:
> > Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
> > F:	drivers/bus/fsl-mc/
> > F:	include/uapi/linux/fsl_mc.h
> > 
> > FREESCALE SOC DRIVERS
> > M:	Christophe Leroy <christophe.leroy@csgroup.eu>
> > L:	linuxppc-dev@lists.ozlabs.org
> > L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > S:	Maintained
> > F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
> > F:	Documentation/devicetree/bindings/soc/fsl/
> > F:	drivers/soc/fsl/
> > F:	include/linux/fsl/
> > F:	include/soc/fsl/
> > 
> > I acked the 2 line changes in include/linux/fsl/mc.h, the main changes being
> > in the C files which are not under my scope.
> > 
> > Stuart, Laurentiu, can you pick up the patch ?
> 
> Stuart and Laurentiu are no longer at NXP. Even when they handled the
> fsl-mc bus driver, they didn't have a tree themselves to pick patches up
> but rather, historically, patches on the fsl-mc bus were picked by Greg
> KH.

OK, copied Greg in.

Dave

> Ioana
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

