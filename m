Return-Path: <linux-kernel+bounces-564223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C183A6509A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6FB188CB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C744D23ED66;
	Mon, 17 Mar 2025 13:20:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57E23E34F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217628; cv=none; b=pMQ1moploXRcHcILK8uiIrFppO88YaSLg5Mab8WyzqsXXfYCCRlhqHjuiK/yAtbUQHM7sX+Jqey5zPDb0KuBHO2+9GADQZOj7beHNgzeJj83cI7yFQ0+K3Ue2LBs9tkoknbIr+N5XgiySKhAgZtE2SuEt+sXvJzyEYoF63prP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217628; c=relaxed/simple;
	bh=KETlwWnjuUVgAlxuyR5Vs6IKJQ7UVTK2S4CiSKVsqZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1G9kCAL6wzK08Qg88uamLf089x7LrnAQ5LZdXjppViQFrL9vm9Q/UtNUV1P2wmSyw3JoIOGcN1lGIhxSdYE44YXTX7KNeJNjei+WtQ4LoyaGv9yCXlQrPUw1n7C6pw0QohHMi35kyvWoojq+JLbQef2GqWMzpNlhq5DCddD0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuANv-0001jC-Ho; Mon, 17 Mar 2025 14:20:03 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuANt-000GAp-2a;
	Mon, 17 Mar 2025 14:20:02 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuANu-001CQB-0C;
	Mon, 17 Mar 2025 14:20:02 +0100
Date: Mon, 17 Mar 2025 14:20:02 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 08/12] net: pse-pd: pd692x0: Add support for
 PSE PI priority feature
Message-ID: <Z9ghgq8zlXKsVjOW@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
 <20250304-feature_poe_port_prio-v6-8-3dc0c5ebaf32@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304-feature_poe_port_prio-v6-8-3dc0c5ebaf32@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2025 at 11:18:57AM +0100, Kory Maincent wrote:
>  static u8 pd692x0_build_msg(struct pd692x0_msg *msg, u8 echo)
> @@ -739,6 +755,29 @@ pd692x0_pi_get_actual_pw(struct pse_controller_dev *pcdev, int id)
>  	return (buf.data[0] << 4 | buf.data[1]) * 100;
>  }
>  
> +static int
> +pd692x0_pi_get_prio(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
> +	struct pd692x0_msg msg, buf = {0};
> +	int ret;
> +
> +	ret = pd692x0_fw_unavailable(priv);
> +	if (ret)
> +		return ret;
> +
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_PARAM];
> +	msg.sub[2] = id;
> +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +	if (ret < 0)
> +		return ret;
> +	if (buf.data[2] < 1 || 3 < buf.data[2])

if (!buf.data[2] || buf.data[2] > pcdev->pis_prio_max + 1)


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

