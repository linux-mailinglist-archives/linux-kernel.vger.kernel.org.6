Return-Path: <linux-kernel+bounces-365967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C2D99EEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D741C21642
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D51B219C;
	Tue, 15 Oct 2024 14:06:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612DE1B219A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001181; cv=none; b=UDXlBT6/lZIz9oGCIefqaFlKKGsuIqD3P0zviInXl3jWKcj+XXsjK5LpwPD/9hoiHmsUa7yHugStJP8UF7Tfe9eedLG/2NOPvTTe1RSDWFUddaotq9m2EoeV3N2qA6+mbRiKNZOk7/JLdje2MJGnVl2iwIHxggYyjfrWm8ZkS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001181; c=relaxed/simple;
	bh=GDyftvXopT+cv6kx5gYTqJO0DdX4M+l0jMnqMQooPmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJJ+4iAl/Tf45u/oIkWF4t25MBpiHqI0+fp9z/Qf5p0Lwk0F5sXjTzajYOazuXurhAgpv4HLeTB7s4xywTb8ZyMhhy/Go5Polj6XqxHp5AdKJ9XqBq+EIcAtgUWL8qEdy/GyMkW/+eoFuQ5ZP+iOq2T9v83eH1ZA/NhDORjZ1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t0iBb-0008Uc-5g; Tue, 15 Oct 2024 16:06:07 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1t0iBY-0022xx-RN; Tue, 15 Oct 2024 16:06:04 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t0iBY-00ChNx-2O;
	Tue, 15 Oct 2024 16:06:04 +0200
Date: Tue, 15 Oct 2024 16:06:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>, thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: Fix out of bound for loop
Message-ID: <Zw52zAqcvtFL29z2@pengutronix.de>
References: <20241015130255.125508-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015130255.125508-1-kory.maincent@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2024 at 03:02:54PM +0200, Kory Maincent wrote:
> Adjust the loop limit to prevent out-of-bounds access when iterating over
> PI structures. The loop should not reach the index pcdev->nr_lines since
> we allocate exactly pcdev->nr_lines number of PI structures. This fix
> ensures proper bounds are maintained during iterations.
> 
> Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

