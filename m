Return-Path: <linux-kernel+bounces-563736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DECBAA6475A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9D3172A66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB30022A80E;
	Mon, 17 Mar 2025 09:29:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32122579B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203765; cv=none; b=u5gJWtS9Waqh4PeLytqGSar8n5NooAaTTtqgprTZTNpeHqhFdXo93rXpUTEdtOZHJFch3VmS/Ko2zFS5t6oOxNDJs5ooehpSweAkDwM7HOJ0F0CRwFfwF3GA52M9MYWnQ/mL6fpJkIMgR57jNVffZczz+mbnRAHPkQVe/MIrDHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203765; c=relaxed/simple;
	bh=v6b1hOqA8LaA+3NZNe9pj0/6BawfIs755ND7o1Yr1G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgGKC0dA6EEIe6cLdePYEDdCoB00kK+4bR9YL99T9l0sJXXv8wmnuu78lG6K+YMRj7HlmW3Erui04jZlswCvsqqaLhLaNbr8icWlJ4byJEzX8wXksWFnjTp8lL1Vu9Q/pvcxPkH1MYbeDNrI2wM2WiTxNgaaoDREBqYYiz+e3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tu6mJ-00007m-3d; Mon, 17 Mar 2025 10:28:59 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tu6mH-000Dk8-2m;
	Mon, 17 Mar 2025 10:28:58 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tu6mI-001857-0S;
	Mon, 17 Mar 2025 10:28:58 +0100
Date: Mon, 17 Mar 2025 10:28:58 +0100
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
Subject: Re: [PATCH net-next v6 02/12] net: pse-pd: Add support for reporting
 events
Message-ID: <Z9frWsKESEaB9GcZ@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
 <20250304-feature_poe_port_prio-v6-2-3dc0c5ebaf32@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304-feature_poe_port_prio-v6-2-3dc0c5ebaf32@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Köry,

sorry for late review.

On Tue, Mar 04, 2025 at 11:18:51AM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
...
> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
> index aea0f03575689..9b41d4697a405 100644
> --- a/drivers/net/mdio/fwnode_mdio.c
> +++ b/drivers/net/mdio/fwnode_mdio.c
> @@ -18,7 +18,8 @@ MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
>  
>  static struct pse_control *
> -fwnode_find_pse_control(struct fwnode_handle *fwnode)
> +fwnode_find_pse_control(struct fwnode_handle *fwnode,
> +			struct phy_device *phydev)
>  {
>  	struct pse_control *psec;
>  	struct device_node *np;
> @@ -30,7 +31,7 @@ fwnode_find_pse_control(struct fwnode_handle *fwnode)
>  	if (!np)
>  		return NULL;
>  
> -	psec = of_pse_control_get(np);
> +	psec = of_pse_control_get(np, phydev);
>  	if (PTR_ERR(psec) == -ENOENT)
>  		return NULL;
>  
> @@ -128,15 +129,9 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>  	u32 phy_id;
>  	int rc;
>  
> -	psec = fwnode_find_pse_control(child);
> -	if (IS_ERR(psec))
> -		return PTR_ERR(psec);
> -
>  	mii_ts = fwnode_find_mii_timestamper(child);
> -	if (IS_ERR(mii_ts)) {
> -		rc = PTR_ERR(mii_ts);
> -		goto clean_pse;
> -	}
> +	if (IS_ERR(mii_ts))
> +		return PTR_ERR(mii_ts);
>  
>  	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
>  	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
> @@ -169,6 +164,12 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>  			goto clean_phy;
>  	}
>  
> +	psec = fwnode_find_pse_control(child, phy);
> +	if (IS_ERR(psec)) {
> +		rc = PTR_ERR(psec);
> +		goto unregister_phy;
> +	}

Hm... we are starting to dereference the phydev pointer to a different
framework without managing the ref-counting.

We will need to have some form of get_device(&phydev->mdio.dev).
Normally it is done by phy_attach_direct().

And the counterpart: put_device() or phy_device_free()

 
>  static int of_load_single_pse_pi_pairset(struct device_node *node,
> @@ -557,6 +560,151 @@ int devm_pse_controller_register(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_pse_controller_register);
>  
> +struct pse_irq {
> +	struct pse_controller_dev *pcdev;
> +	struct pse_irq_desc desc;
> +	unsigned long *notifs;
> +};
> +
> +/**
> + * pse_to_regulator_notifs - Convert PSE notifications to Regulator
> + *			     notifications
> + * @notifs: PSE notifications
> + *
> + * Return: Regulator notifications
> + */
> +static unsigned long pse_to_regulator_notifs(unsigned long notifs)
> +{
> +	unsigned long rnotifs = 0;
> +
> +	if (notifs & ETHTOOL_PSE_EVENT_OVER_CURRENT)
> +		rnotifs |= REGULATOR_EVENT_OVER_CURRENT;
> +	if (notifs & ETHTOOL_PSE_EVENT_OVER_TEMP)
> +		rnotifs |= REGULATOR_EVENT_OVER_TEMP;
> +
> +	return rnotifs;
> +}
> +
> +/**
> + * pse_control_find_phy_by_id - Find PHY attached to the pse control id
> + * @pcdev: a pointer to the PSE
> + * @id: index of the PSE control
> + *
> + * Return: PHY device pointer or NULL
> + */
> +static struct phy_device *
> +pse_control_find_phy_by_id(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct pse_control *psec;
> +
> +	mutex_lock(&pse_list_mutex);
> +	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
> +		if (psec->id == id) {
> +			mutex_unlock(&pse_list_mutex);
> +			return psec->attached_phydev;
> +		}
> +	}
> +	mutex_unlock(&pse_list_mutex);
> +


Here we should increase ref-counting withing the mutex protection:

    mutex_lock(&pse_list_mutex);
    list_for_each_entry(psec, &pcdev->pse_control_head, list) {
        if (psec->id == id) {
            phydev = psec->attached_phydev;
            if (phydev)
                get_device(&phydev->mdio.dev);  // Increase reference count
            break;
        }
    }
    mutex_unlock(&pse_list_mutex);


May be we will need a generic function for the PHYlib: phy_device_get() ?
 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

