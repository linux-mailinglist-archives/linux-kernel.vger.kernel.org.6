Return-Path: <linux-kernel+bounces-308202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A79965898
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F514287F07
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E481581EB;
	Fri, 30 Aug 2024 07:31:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6713632B
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003087; cv=none; b=sQG+btx4ySi+oU9xAMqn7z14C9BROXmvI53hVSE7xI2dha5EUC+FV6H7PqX2LaUxlS8Jm/VZT8m8L5qD+NMyV5kqpmLbe3LtOBUqsSRZzS3OAmQnPfuZz3azNsv86IKwlg5Gkt0KcYGWJKqa0gizwoD3sfwB2ubMkwm4vhM+B4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003087; c=relaxed/simple;
	bh=f2CXaZ7kFJEKY/8Eh5PZaP4Xu3ad0gz/EM/05oCdOk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkV/qZ4U5JD0SG4fy5hUN+uEQNxOxyzAS/Sm/zTrOR29pY8jh3iAgADIMr43owIwIoW0DcuyFIg1pW3LmngKoV/7HUP0jpzjkPg2+1GR0kq0kH53JYLoc8z6Dhz6mHe3WE1KegOj5Zt5My9o2Qd3X7rHQbKVmaM5oE7xB924r7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sjw6D-0004kD-R1; Fri, 30 Aug 2024 09:31:13 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sjw6C-0046AF-Fm; Fri, 30 Aug 2024 09:31:12 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sjw6C-00EQow-1C;
	Fri, 30 Aug 2024 09:31:12 +0200
Date: Fri, 30 Aug 2024 09:31:12 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: kernel@pengutronix.de, andi.shyti@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, Frank.Li@nxp.com,
	francesco.dolcini@toradex.com, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2 2/4] i2c: imx: separate atomic, dma and non-dma use
 case
Message-ID: <ZtF1QBjbBtN7N4Oh@pengutronix.de>
References: <20240819072052.8722-1-eichest@gmail.com>
 <20240819072052.8722-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240819072052.8722-3-eichest@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2024 at 09:19:08AM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Separate the atomic, dma and non-dma use case as a preparation step for
> moving the non-dma use case to the isr to avoid rescheduling while a
> transfer is in progress.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

I would prefer to rename i2c_imx_start_read() to i2c_imx_prepare_read()
With this change: Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

