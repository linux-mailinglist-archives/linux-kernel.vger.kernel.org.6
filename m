Return-Path: <linux-kernel+bounces-426340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592FF9DF1E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9776AB21562
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2541A0AF1;
	Sat, 30 Nov 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="EUuWDkGn"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FAF156257
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732982698; cv=none; b=H9QQHzEAFfPIfKDUp/0KxT2PfHx8peQnSGp6XM2oasqc1rTQXiclBWWmdsvzE9LwT5QAbFZvUcZuTkbU6RhgY2GR4LMgKQr5QeGX9xHpoMYIw3D0G6RQ5u3WDhHfBM3Griz+ps+5MJ2fl7/ru8MrBr7GONNkMNGo63USx0sQKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732982698; c=relaxed/simple;
	bh=Ib0eMIHq4Tud5T3QYMT+FKlg8p3RZjvIuyuFfrCD4Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnHCfWxiPEyzTlPyL8pUlsdEcK/aLYuWE2m5y5oV1OvWLO7Xfghfzwtw8pMys2qDpcUm8dY+H62xnEwmLAQC69kepfjB8cjA/TeVuVvjpBD+eu+5+Tur01lc4b9IEvSHY6a4wjmIllRI1tSwnYOzsanMBbxrfzhHtPEEWyD3JOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=EUuWDkGn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de771c5ebso3180411e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732982694; x=1733587494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CU8Ha8lvwzrUL3wklZxNnby9TbqM0AQPddb/sVDz+Hg=;
        b=EUuWDkGnkYH+zjeVXwJu30Jx69vHNSu8mOpdyl9FqGq5g/IpMJTbZ5lzq0OwsZdaaF
         bNEn28D+bhIV/b+bkbcHbLjnAPWia3WSLUe5t3QjkBe2P8wXoITaZAOtvtIfHbUXbf8m
         2fi/w+tsq0S7YQtF8flHHWuE3u33YDrL80oBGqTOmoIHmJXPSxSs5ubNFkIvRtul8Fy1
         2mI0F0E40qWKB9qIQTj9nXMU0Z/MKA8pUvHFnHdkZeHGJBNX+Kip2u1IdKcPemkhkeUh
         UbpALvPU2EjvXBB7NojclL5iHvAvvYO6HKRT+H0i8ZenzOd6/fHtbPA4avNKx9jdR5Lq
         k2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732982694; x=1733587494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CU8Ha8lvwzrUL3wklZxNnby9TbqM0AQPddb/sVDz+Hg=;
        b=UbYf1nQkSazhvH9B7iP2cRG0OsoJAwjifRDeBsvzJoN6CfTGvhgmQynNPt3E99KlPa
         yxMxQQbErU+0YZqvu0XEFzn9vMOm0KHkxiAdZkLm9c8FnBM6eITIjaEM0ALe7Jy80RDa
         86Bl9Ud+kPJ2s2hJA1Qahu6gEoR3yrC2DuQhwpNd8kiQ6vGjHClnKxlni5E6glxZPt3X
         LvNOmdch4fTxvNKMdqyCpC3DkvtO3Dh4sBCrcV+57wZ1Za8ULxY5JTq2+eySrDLaLvmN
         QYOZqF3K61+hLp9o2SFdgcfkbtGITcruncnveBwT9ceDq7+ZfZMp1rPFIhXruapns+S+
         CTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUK5LyAYs0cFLvv8WdFZ/2qwezIgWbdkai60/e301cigTtAekFcMxnUk3iI0lVlxhghZOTPexjRFQk5vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmKRCCHuQmHJ+gXzQGYjYkQpxHYUE1qFqR5ShRAFDXH4bK60E
	qwF3+I+oQEzBvtFv0h0Ryj7h7VCB9v3eaC57pFRNKVlZRfsnIQn2VORuYDTpz8k=
X-Gm-Gg: ASbGnctviQn8XYcWA1qFAZyp+kVWHPdpiJIBfs3GGmryYdO03YXe9q5QiZFInOV/W3h
	3hj3olgLGPRM8/hgycFdrP1virkZLa9s9S5IS0bkkb1vJS993RnId1q6dVjQx7bwxo5Ux/k3Fm2
	Ef5735lBZcmxdJRGOm9qppscDZK+oU7qbjT4pgqcC1RhFI65K1naDPLzsMf0kdgB0kA8WwDDB3V
	kMT1pXcOxz8J7cyiv7u1fIYRNzW77lFJF6ZTUPmdWv9HFc=
X-Google-Smtp-Source: AGHT+IHL4oeMU03kLmQ2L0BR3qVJKTiAVIsSPE3HICpdb/3DuaV9c9TIe/hHbGxSndbZ9+FTqZL6rQ==
X-Received: by 2002:a05:6512:3990:b0:53d:eefc:2b48 with SMTP id 2adb3069b0e04-53df00dc9bamr8384254e87.33.1732982694015;
        Sat, 30 Nov 2024 08:04:54 -0800 (PST)
Received: from localhost ([217.199.122.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f2adsm808857e87.114.2024.11.30.08.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 08:04:53 -0800 (PST)
Date: Sat, 30 Nov 2024 18:04:52 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Andy Strohman <andrew@andrewstrohman.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for
 Q-in-Q
Message-ID: <Z0s3pDGGE0zXq0UE@penguin>
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130000802.2822146-1-andrew@andrewstrohman.com>

On Sat, Nov 30, 2024 at 12:07:57AM +0000, Andy Strohman wrote:
> 802.1q networks with IVL (independent VLAN learning) can
> tolerate duplicate MACs as long as the duplicates
> reside in different VLANs. Similarly, IVL networks
> allow for L2 hairpining where different VLANs are
> used for each side of the hairpin in order to not
> confuse the intermediate bridge's FDBs.
> 
> When these types of networks are inter-connected
> using 802.1ad or Q-in-Q, only the outer VLAN tag is
> considered by the 802.1ad bridge during FDB lookup.
> 
> While traffic segregation by inner and outer VID works as
> expected, the inner VLAN's independent VLAN learning can
> be defeated.
> 
> The following example describes the issue in terms of
> duplicate MACS in different VLANs. But, the same concept
> described in this example also applies L2 hairpining via
> different VLANs.
> 
>                  _______________________
>                 |  .1ad bridge          |
> 	        |_______________________|
>            PVID3|      PVID3|      PVID3|
>                 |           |           |
> TAGGED:        7|          8|          8|
>             ____|____  _____|___   _____|___
>            | .1q br 1| |.1q br 2|  |.1q br 3|
>            |_________| |________|  |________|
>          PVID7 |      PVID8 |      PVID8|
>              HOST A       HOST B      HOST C
> 
> The above diagram depicts a .1ad bridge that has "pvid 3
> untagged" configured for every member port. These member ports are
> connected to .1q bridges, named 1, 2 and 3. .1q br 1 allows VID 7 tagged
> on its port facing the .1ad bridge. .1q bridge 2 and 3 allow
> VID 8 tagged on their ports that face the .1ad bridge. Host A
> is connected to .1q br 1 via a port that is configured as "pvid 7
> untagged". Host B and C are connected to bridges via ports
> configured as "pvid 8 untagged".
> 
> Prior to this change, if host A has the same (duplicate) MAC
> address as host B, this can disrupt communication between
> host B and host C. This happens because the .1ad bridge
> will see the duplicate MAC behind two of its ports
> within the same VID (3). It's not examining the inner VLAN to
> know that the hosts are actually reside within in different
> L2 segments.
> 
> With this change, the .1ad bridge uses both the inner and outer VID
> when looking up the FDB. With this technique, host B and C are
> able to communicate without disruptions due to the duplicate MAC
> assigned to host A.
> 
> Here is an example FDB dump on a .1ad bridge that is configured like
> the above diagram:
> 
> root@OpenWrt:~# bridge fdb show dynamic
> f4:a4:54:80:93:2f dev lan3 vlan 3 inner vlan 8 master br-lan
> f4:a4:54:81:7a:90 dev lan1 vlan 3 inner vlan 7 master br-lan
> f4:a4:54:81:7a:90 dev lan2 vlan 3 inner vlan 8 master br-lan
> 
> Note how duplicate MAC f4:a4:54:81:7a:90 is behind both lan1 and
> lan2. This FDB dump shows two entries with the same MAC and
> the same 802.1ad VLAN, 3. Prior to this change, only one fdb entry
> per MAC/VID would be possible. As such, the bridge would have
> issues forwarding. After this change, these entries are understood
> to be distinct as they pertain to different inner vlans, and
> therefore separate L2 segments.
> 
> Signed-off-by: Andy Strohman <andrew@andrewstrohman.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |   4 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
>  drivers/net/ethernet/intel/igb/igb_main.c     |   4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   4 +-
>  .../ethernet/mellanox/mlxsw/spectrum_router.c |   4 +-
>  .../ethernet/mellanox/mlxsw/spectrum_span.c   |   4 +-
>  .../mellanox/mlxsw/spectrum_switchdev.c       |   2 +-
>  drivers/net/ethernet/mscc/ocelot_net.c        |   4 +-
>  .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |   8 +-
>  drivers/net/macvlan.c                         |   4 +-
>  drivers/net/vxlan/vxlan_core.c                |   6 +-
>  include/linux/if_bridge.h                     |   4 +-
>  include/linux/netdevice.h                     |   6 +-
>  include/linux/rtnetlink.h                     |   4 +-
>  include/trace/events/bridge.h                 |  20 ++--
>  include/uapi/linux/if_link.h                  |   1 +
>  include/uapi/linux/neighbour.h                |   1 +
>  net/bridge/br_arp_nd_proxy.c                  |   8 +-
>  net/bridge/br_device.c                        |  11 +-
>  net/bridge/br_fdb.c                           | 107 ++++++++++--------
>  net/bridge/br_input.c                         |  22 ++--
>  net/bridge/br_netlink.c                       |  18 ++-
>  net/bridge/br_private.h                       |  25 ++--
>  net/bridge/br_vlan.c                          |  34 +++++-
>  net/core/neighbour.c                          |   1 +
>  net/core/rtnetlink.c                          |  58 ++++++----
>  26 files changed, 227 insertions(+), 143 deletions(-)
> 

Hi,
This patch makes fdb lookups slower for everybody, ruins the nice key alignment,
increases the key memory usage and adds more complexity for a corner case, especially
having 2 different hosts with identical macs sounds weird. Fdb matching on both tags
isn't a feature I've heard of, I don't know if there are switches that support it.
Could you point to anywhere in the specs that such support is mentioned?
Also could you please give more details about the use case? Maybe we can help you solve
your problem without impacting everyone. Perhaps we can mix vlan-aware bridge and tc
to solve it. As it stands I'm against adding such matching, but I'd love to hear what
other people think.

Cheers,
 Nik

