Return-Path: <linux-kernel+bounces-297465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A414395B8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D221F24153
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7041CC160;
	Thu, 22 Aug 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Dc6p/5Kw"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E416D4EF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337474; cv=none; b=miQsl7SQS6eMW0LO+PFxdMdF5mrmuVfvqHyWe0jlLcAHprvSNrOY+VoBMTQ5ldcNSYqEzxYB/1Kv6tVGe78WO6ig8Kt/2G8z58okSyWV7vvbqa9AZWgG//CQUo6AF2H5AkyUtOiceD1GcdD3zB39zwDi3To9pMkxQbVJ3X5ox5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337474; c=relaxed/simple;
	bh=K/iU/g6l0igkow1JOZaDsLnHrDU+uC6StsWRBQp+jTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/vh3ogJzKYJ2/m0j9rJy1QDWGVby1F6FOizy6BDRJXgzJRGox41nFrdaKg+fDbYbFNBtIP/NnMHhexgrtux3yV4YRnPzWLPaZ7/1xqsnyf53z4LZYA3st6gHhwQ/blOsqQyc/5G2rnoggqPNrLycLTgfYuyDs9FsitNr9KFdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Dc6p/5Kw; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so12910961fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724337470; x=1724942270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6rRlivbA70V6yYRpa9fO76GA/Vkt/ypOIx6egRXZvw=;
        b=Dc6p/5KwAXwD7JzsMNExkCX8JWmPGTX8wMfDzZ3I/pR5hAa81R+dIAkQSQEaJGfHQ8
         83vIqaARLZ4I6CslpapzVWcYANHum58r3dyXux1Tg9INOk3GZ69Wp4bAIsksrQ0RrQ9M
         x/Kvu2hRxrmopvVXVxlWBQjBH3tloJPUcpvsu4tgsrfYaUNMqALJYGNFJbOJ2RYo8wUb
         POtLEv7aMxCtBoeG2HLoa4UWhGJIjwsE0A5HYqZVnJIQVjm5OlPeSju1/SQ9uDqMxvXn
         ajF+vh1rv7ks7qrHl6aYABwDZWoeboa58eYG0h8ucWo62yllYs31gMANTz5FhKSAaQLq
         I/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337470; x=1724942270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6rRlivbA70V6yYRpa9fO76GA/Vkt/ypOIx6egRXZvw=;
        b=LhbEHKb1S2YDxaVw1sjyhJSiXUcOa/4k6SBoHominma6ohW2s/jV910BEQ9jZWmWli
         8G+QKpBZFIJXO9ckBsUDOXcO3hFqSRLzhPFXYzHHhstBq+LTojYXZhyWBtuf3+r6MhpA
         KBjAcEbLyBrGQtKc4GZx0550rSI4BioFso8uJIzLoG0VkZUwjsiHtnuqitNcIEgff7Bj
         qPc7xmguWxqrd61fXkwFT2minJAXu6SHgGoP+3AggDN4qS6C+f7L0M+7RfNu59xVz8uy
         PUi/SzGugVqEDY2B97Wfp7a8YGdrqcencfOfZl43WnO0KpRVvO79+LPOPMhAIP1AlE93
         wC+w==
X-Forwarded-Encrypted: i=1; AJvYcCWqyjDiH0F3jrnLhXIuyX6KPn6RLz9Haueeb+LSylzsY1JiblOR74TAOURaN/zLnNvDM9tnC3gtikz57q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Mi8ZVmrY6VN53UDtw295+LaxXWF7yviwYZ9Fqlkn7IC1d8QG
	G5w43G92p+FpHP89sidRIbFLkwPUa8KUciBBjqktbJrVuyv4gpBf+agAlr8Dv5s=
X-Google-Smtp-Source: AGHT+IFj3aSYNP0nLcrfL9brV2tn65QQ1ilt1g5IPhiw6/OOitRwTB+Sde2sEPYqnmhuJ5kegpaAdw==
X-Received: by 2002:a2e:7c13:0:b0:2f1:67de:b536 with SMTP id 38308e7fff4ca-2f405da95c7mr16767431fa.24.1724337469419;
        Thu, 22 Aug 2024 07:37:49 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2adc55sm127276066b.71.2024.08.22.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:37:48 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:37:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v11 10/11] octeontx2-pf: Add devlink port support
Message-ID: <ZsdNO2_Q9jTHLBEH@nanopsycho.orion>
References: <20240822132031.29494-1-gakula@marvell.com>
 <20240822132031.29494-11-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822132031.29494-11-gakula@marvell.com>

Thu, Aug 22, 2024 at 03:20:30PM CEST, gakula@marvell.com wrote:
>Register devlink port for the rvu representors.
>
>Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>---
> .../ethernet/marvell/octeontx2.rst            | 39 ++++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 91 +++++++++++++++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.h  |  2 +
> 3 files changed, 132 insertions(+)
>
>diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
>index 1132ae2d007c..33258cc18f45 100644
>--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
>+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
>@@ -393,3 +393,42 @@ To remove the representors devices from the system. Change the device to legacy
>  - Change device to legacy mode::
> 
> 	# devlink dev eswitch set pci/0002:1c:00.0 mode legacy
>+
>+
>+RVU representors can be managed using devlink ports
>+(see :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>`) interface.
>+
>+ - Show devlink ports of representors::
>+
>+	# devlink port
>+
>+Sample output::
>+
>+	# devlink port
>+	pci/0002:1c:00.0/0: type eth netdev pf1vf0rep flavour physical port 1 splittable false
>+	pci/0002:1c:00.0/1: type eth netdev pf1vf1rep flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
>+	pci/0002:1c:00.0/2: type eth netdev pf1vf2rep flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
>+	pci/0002:1c:00.0/3: type eth netdev pf1vf3rep flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false
>+
>+Function attributes
>+===================
>+
>+The RVU representor support function attributes for representors.
>+Port function configuration of the representors are supported through devlink eswitch port.
>+
>+MAC address setup
>+-----------------
>+
>+RVU representor driver support devlink port function attr mechanism to setup MAC
>+address. (refer to Documentation/networking/devlink/devlink-port.rst)
>+
>+ - To setup MAC address for port 2::
>+
>+	# devlink port function set pci/0002:1c:00.0/2 hw_addr 5c:a1:1b:5e:43:11
>+
>+Sample output::
>+
>+	# devlink port show pci/0002:1c:00.0/2
>+	pci/0002:1c:00.0/2: type eth netdev pf1vf2rep flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
>+	function:
>+		hw_addr 5c:a1:1b:5e:43:11
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>index 5f767b6e79c3..aab1784b5134 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>@@ -28,6 +28,90 @@ MODULE_DESCRIPTION(DRV_STRING);
> MODULE_LICENSE("GPL");
> MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
> 
>+static int rvu_rep_dl_port_fn_hw_addr_get(struct devlink_port *port,
>+					  u8 *hw_addr, int *hw_addr_len,
>+					  struct netlink_ext_ack *extack)
>+{
>+	struct otx2_devlink *otx2_dl = devlink_priv(port->devlink);
>+	int rep_id = port->index;
>+	struct otx2_nic *priv;
>+	struct rep_dev *rep;
>+
>+	priv = otx2_dl->pfvf;
>+	rep = priv->reps[rep_id];

struct rep_dev contains struct devlink_port. Use container_of to get it
from port pointer.


>+	ether_addr_copy(hw_addr, rep->mac);
>+	*hw_addr_len = ETH_ALEN;
>+	return 0;
>+}
>+
>+static int rvu_rep_dl_port_fn_hw_addr_set(struct devlink_port *port,
>+					  const u8 *hw_addr, int hw_addr_len,
>+					  struct netlink_ext_ack *extack)
>+{
>+	struct otx2_devlink *otx2_dl = devlink_priv(port->devlink);
>+	int rep_id = port->index;
>+	struct otx2_nic *priv;
>+	struct rep_dev *rep;
>+
>+	priv = otx2_dl->pfvf;
>+	rep = priv->reps[rep_id];
>+	eth_hw_addr_set(rep->netdev, hw_addr);
>+	ether_addr_copy(rep->mac, hw_addr);

You save the mac, yet you never use it. To be clear, this mac should be
used for the actual VF. I believe you are missing that code.


>+	return 0;
>+}
>+
>+static const struct devlink_port_ops rvu_rep_dl_port_ops = {
>+	.port_fn_hw_addr_get = rvu_rep_dl_port_fn_hw_addr_get,
>+	.port_fn_hw_addr_set = rvu_rep_dl_port_fn_hw_addr_set,
>+};
>+
>+static void
>+rvu_rep_devlink_set_switch_id(struct otx2_nic *priv,
>+			      struct netdev_phys_item_id *ppid)
>+{
>+	struct pci_dev *pdev = priv->pdev;
>+	u64 id;
>+
>+	id = pci_get_dsn(pdev);

Is physical port using this switch_id as well? If not, it should.


>+
>+	ppid->id_len = sizeof(id);
>+	put_unaligned_be64(id, &ppid->id);
>+}
>+
>+static void rvu_rep_devlink_port_unregister(struct rep_dev *rep)
>+{
>+	devlink_port_unregister(&rep->dl_port);
>+}
>+
>+static int rvu_rep_devlink_port_register(struct rep_dev *rep)
>+{
>+	struct devlink_port_attrs attrs = {};
>+	struct otx2_nic *priv = rep->mdev;
>+	struct devlink *dl = priv->dl->dl;
>+	int err;
>+
>+	if (!(rep->pcifunc & RVU_PFVF_FUNC_MASK)) {
>+		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
>+		attrs.phys.port_number = rvu_get_pf(rep->pcifunc);
>+	} else {
>+		attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
>+		attrs.pci_vf.pf = rvu_get_pf(rep->pcifunc);
>+		attrs.pci_vf.vf = rep->pcifunc & RVU_PFVF_FUNC_MASK;
>+	}
>+
>+	rvu_rep_devlink_set_switch_id(priv, &attrs.switch_id);
>+	devlink_port_attrs_set(&rep->dl_port, &attrs);
>+
>+	err = devl_port_register_with_ops(dl, &rep->dl_port, rep->rep_id,
>+					  &rvu_rep_dl_port_ops);
>+	if (err) {
>+		dev_err(rep->mdev->dev, "devlink_port_register failed: %d\n",
>+			err);
>+		return err;
>+	}
>+	return 0;
>+}
>+
> static int rvu_rep_get_repid(struct otx2_nic *priv, u16 pcifunc)
> {
> 	int rep_id;
>@@ -339,6 +423,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
> 	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
> 		rep = priv->reps[rep_id];
> 		unregister_netdev(rep->netdev);
>+		rvu_rep_devlink_port_unregister(rep);
> 		free_netdev(rep->netdev);
> 	}
> 	kfree(priv->reps);
>@@ -381,6 +466,11 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
> 		snprintf(ndev->name, sizeof(ndev->name), "p%dv%drep",
> 			 rvu_get_pf(pcifunc), (pcifunc & RVU_PFVF_FUNC_MASK));
> 
>+		err = rvu_rep_devlink_port_register(rep);
>+		if (err)
>+			goto exit;
>+
>+		SET_NETDEV_DEVLINK_PORT(ndev, &rep->dl_port);
> 		eth_hw_addr_random(ndev);
> 		err = register_netdev(ndev);
> 		if (err) {
>@@ -402,6 +492,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
> 	while (--rep_id >= 0) {
> 		rep = priv->reps[rep_id];
> 		unregister_netdev(rep->netdev);
>+		rvu_rep_devlink_port_unregister(rep);
> 		free_netdev(rep->netdev);
> 	}
> 	kfree(priv->reps);
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>index 0cefa482f83c..d81af376bf50 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>@@ -34,10 +34,12 @@ struct rep_dev {
> 	struct net_device *netdev;
> 	struct rep_stats stats;
> 	struct delayed_work stats_wrk;
>+	struct devlink_port dl_port;
> 	u16 rep_id;
> 	u16 pcifunc;
> #define RVU_REP_VF_INITIALIZED		BIT_ULL(0)
> 	u8 flags;
>+	u8	mac[ETH_ALEN];
> };
> 
> static inline bool otx2_rep_dev(struct pci_dev *pdev)
>-- 
>2.25.1
>

