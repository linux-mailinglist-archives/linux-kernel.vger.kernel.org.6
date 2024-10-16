Return-Path: <linux-kernel+bounces-367592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0490D9A0432
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D5028329C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6131D1F5A;
	Wed, 16 Oct 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fc+pDScL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5F18A95E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067253; cv=none; b=Mw49xTXoLGanawLSjtC1fqIqXGRw12Lm2uFOWutkfYi6dhCOt9J+qIydQBg1DK+uSQpJALvG7yGelPas7i4UOsx0Pbrk4573bSbcTi33gzIN3/q2T+3eIU1PIjO3NZkQcm85BMoL8UWV3nJ7R0+nmXLzrVAwi4fnbQaob1AYlXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067253; c=relaxed/simple;
	bh=PVa+FJXTDWZeoxAqKHBZCp7maASc8TfoL8hAtOc6GlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xuayw/LOFjzOOVJmcXYvfSqq24ueFI68DXHDLW2FmfWQ75jzZUE5bfERETXD7zu+X1XVDwYgSq1zectAV1vgZ8YKqCLH8s9ZMYRZ9WXn/1yjMe9SSp28w224gxARDt+ZHeUtYTQ2S2pBtpeJ1X9YNbTFVtyZ+TKFLmeWyrW96AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fc+pDScL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43124843b04so37270575e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1729067249; x=1729672049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g28iCX0O5SYkdDCU+JsYvIfeHBkuIrm9r0ykt0NO+9k=;
        b=fc+pDScL3abGiXe83W+w8fg/MkPF/zYvLkGkdEFW8s0DJVKIpsI0bTh64Mg1Jc5aSX
         I3ixyF+LXBqW29D/5LFFfg19X6AXgQCowmDzsibLrowdCexaA3Bjoq9aM30grWFMVoAa
         83MCYg/Tt/+NH04tX7iqt5GSk/uLyMut0HTvWIhvQL3+qE6tcYCk3UP/arzHiboKEKfI
         ZnJnHuMJvHE0kvJP9aJ6o6Xj75b4PwIV2znhtUw4ZKd67RFPjshlLglLrIBifhzaD8xb
         5Si4taiAfCOXgGcfEqPkzDS0fNRpMeHc/N77Vp5AQmvCWNc2erADVjGaMYjcWyYDTlXr
         QAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067249; x=1729672049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g28iCX0O5SYkdDCU+JsYvIfeHBkuIrm9r0ykt0NO+9k=;
        b=RJIlykHIx5xia7fFsNbwmPfAoiFN/ykYvV9NmeybD+NkV2KAc4Ya2Mp9sqbAfUgypA
         WII+2roR5o3ciTQvw9P56B43Qf5tg77HO4tnr2TnD+k6C3mQuA/dhKiLeYOTi/6ofIGK
         gBnFOL/tCq+Ffm+wjKcJQNdE2zHZ1vFdjifNsDp+o+09Z8QqcKIVStcs+zgMftCfIJoM
         uNRJyzZXR6kSN6ZfeAE2MBq1RkndeGnLRrhmqgG+OQvVmfU++f4KM8VPv+Q3CH6VDuYt
         7jb6r/c9Y2oSqaBerFsRXg8uCcA6jSBbStZCxwSIY5rZ/mnwVoq7QFQ3nO9ywyEBIoGG
         +Kjg==
X-Forwarded-Encrypted: i=1; AJvYcCWSXE5BtdQSx+ca/qSCnm/1/+gxPsq9i10kfk3i78XMiYFamnSXWJGEUfRVYb/mqLOmvsa0GRJn3dJ5Hec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO0jZIce7XXa4EuDdLavtn09opquvbw4P62qXoopA4lPGEjom7
	ulezVTW/TG9IJVamutzoErNDjU1a6APkN6hLNNdfq+hbO1kmm++zvbph7XLOxvA=
X-Google-Smtp-Source: AGHT+IERexqRaMF2wo6pgIqzaWfNekkvkAvO40P+daGklxVCAETU0FoDFC6Q5O/KGhVi2SAiAuuztQ==
X-Received: by 2002:a05:600c:5122:b0:42f:8d36:855e with SMTP id 5b1f17b1804b1-4311deb5f47mr177561545e9.5.1729067248934;
        Wed, 16 Oct 2024 01:27:28 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314bf60fc4sm24841625e9.38.2024.10.16.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:27:28 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:27:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	openvpn-devel@lists.sourceforge.net,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 04/23] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <Zw947Jb637o-I4RV@nanopsycho.orion>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
 <20241016-b4-ovpn-v9-4-aabe9d225ad5@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-b4-ovpn-v9-4-aabe9d225ad5@openvpn.net>

Wed, Oct 16, 2024 at 03:03:04AM CEST, antonio@openvpn.net wrote:
>Add basic infrastructure for handling ovpn interfaces.
>
>Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>---
> drivers/net/ovpn/main.c       | 115 ++++++++++++++++++++++++++++++++++++++++--
> drivers/net/ovpn/main.h       |   7 +++
> drivers/net/ovpn/ovpnstruct.h |   8 +++
> drivers/net/ovpn/packet.h     |  40 +++++++++++++++
> include/uapi/linux/if_link.h  |  15 ++++++
> 5 files changed, 180 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>index d5bdb0055f4dd3a6e32dc6e792bed1e7fd59e101..eead7677b8239eb3c48bb26ca95492d88512b8d4 100644
>--- a/drivers/net/ovpn/main.c
>+++ b/drivers/net/ovpn/main.c
>@@ -10,18 +10,52 @@
> #include <linux/genetlink.h>
> #include <linux/module.h>
> #include <linux/netdevice.h>
>+#include <linux/inetdevice.h>
>+#include <net/ip.h>
> #include <net/rtnetlink.h>
>-#include <uapi/linux/ovpn.h>
>+#include <uapi/linux/if_arp.h>
> 
> #include "ovpnstruct.h"
> #include "main.h"
> #include "netlink.h"
> #include "io.h"
>+#include "packet.h"
> 
> /* Driver info */
> #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
> #define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
> 
>+static void ovpn_struct_free(struct net_device *net)
>+{
>+}
>+
>+static int ovpn_net_open(struct net_device *dev)
>+{
>+	netif_tx_start_all_queues(dev);
>+	return 0;
>+}
>+
>+static int ovpn_net_stop(struct net_device *dev)
>+{
>+	netif_tx_stop_all_queues(dev);
>+	return 0;
>+}
>+
>+static const struct net_device_ops ovpn_netdev_ops = {
>+	.ndo_open		= ovpn_net_open,
>+	.ndo_stop		= ovpn_net_stop,
>+	.ndo_start_xmit		= ovpn_net_xmit,
>+};
>+
>+static const struct device_type ovpn_type = {
>+	.name = OVPN_FAMILY_NAME,
>+};
>+
>+static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
>+	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
>+					    OVPN_MODE_MP),
>+};
>+
> /**
>  * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
>  * @dev: the interface to check
>@@ -33,16 +67,76 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
> 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
> }
> 
>+static void ovpn_setup(struct net_device *dev)
>+{
>+	/* compute the overhead considering AEAD encryption */
>+	const int overhead = sizeof(u32) + NONCE_WIRE_SIZE + 16 +
>+			     sizeof(struct udphdr) +
>+			     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
>+
>+	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
>+				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
>+				 NETIF_F_HIGHDMA;
>+
>+	dev->needs_free_netdev = true;
>+
>+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
>+
>+	dev->netdev_ops = &ovpn_netdev_ops;
>+
>+	dev->priv_destructor = ovpn_struct_free;
>+
>+	dev->hard_header_len = 0;
>+	dev->addr_len = 0;
>+	dev->mtu = ETH_DATA_LEN - overhead;
>+	dev->min_mtu = IPV4_MIN_MTU;
>+	dev->max_mtu = IP_MAX_MTU - overhead;
>+
>+	dev->type = ARPHRD_NONE;
>+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
>+	dev->priv_flags |= IFF_NO_QUEUE;
>+
>+	dev->lltx = true;
>+	dev->features |= feat;
>+	dev->hw_features |= feat;
>+	dev->hw_enc_features |= feat;
>+
>+	dev->needed_headroom = OVPN_HEAD_ROOM;
>+	dev->needed_tailroom = OVPN_MAX_PADDING;
>+
>+	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
>+}
>+
> static int ovpn_newlink(struct net *src_net, struct net_device *dev,
> 			struct nlattr *tb[], struct nlattr *data[],
> 			struct netlink_ext_ack *extack)
> {
>-	return -EOPNOTSUPP;
>+	struct ovpn_struct *ovpn = netdev_priv(dev);
>+	enum ovpn_mode mode = OVPN_MODE_P2P;
>+
>+	if (data && data[IFLA_OVPN_MODE]) {
>+		mode = nla_get_u8(data[IFLA_OVPN_MODE]);

Some sanity check perhaps? "validate" op is here for that purpose.


>+		netdev_dbg(dev, "setting device mode: %u\n", mode);
>+	}
>+
>+	ovpn->dev = dev;
>+	ovpn->mode = mode;
>+
>+	/* turn carrier explicitly off after registration, this way state is
>+	 * clearly defined
>+	 */
>+	netif_carrier_off(dev);
>+
>+	return register_netdevice(dev);

[...]

