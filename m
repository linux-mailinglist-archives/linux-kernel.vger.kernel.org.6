Return-Path: <linux-kernel+bounces-569979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F34A6AA66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0CB3B2E48
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512D21D5B0;
	Thu, 20 Mar 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvYwY5Zb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B014B08A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486136; cv=none; b=H8PQxRjLC/1+AxhB2dQ98LNCo2Vd8ov69dRR6nI/HChGkkAx93ddsAqtlLpolJ202N6cxLaND6e5rNdbei8hUWcsVrdrJNHWazdIE8pXuzd0iOinaXZQBkcQBCgPIEQbvgyLO5uS+DwLX76CY+KyL7WBzcu7MFzE0AKMB2unBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486136; c=relaxed/simple;
	bh=qHblWF5s6agJpW1/Ww3Q3XRJ07nX0qydsx4dQZQOPjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CChInwk/t/iJUaKRR05t7IOUl14Hf5grG0jYfCXSNpO+tnpTPb6CSSCqhsYc/YkrKRnP1STOQZfU4sm04wKIK38cKoPKPedVaP0KaFj3tUae9WonCXj2hLvAgpgzsmWKIACpa5+wFhvg42KKMw33swGK1QAHWF6jr2NBl0mZ8Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvYwY5Zb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742486133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cO369ouDwk5uJcpCSv4cMwU1pZ/QUnSGagNby31H/Qk=;
	b=TvYwY5ZblZHfG/WzIDG5IH5JPicQ0NVBKkJZwqJsowsbPzPnDEBdn3n5CImWS9vadOkHko
	/gTyhj1e6F2thmc3BUjT9ViHZ/5K+VWAmUg/eRzHS4eRnAqFVqodj/k5zrbbq1/jFdZszF
	nikPoZ+c3D9YmkgIMNyTVfpFEVluyJY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-0T64-u7xOD6nTRHKnDHrfA-1; Thu,
 20 Mar 2025 11:55:29 -0400
X-MC-Unique: 0T64-u7xOD6nTRHKnDHrfA-1
X-Mimecast-MFC-AGG-ID: 0T64-u7xOD6nTRHKnDHrfA_1742486128
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E10B519373DB;
	Thu, 20 Mar 2025 15:55:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9E2E19373C4;
	Thu, 20 Mar 2025 15:55:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.14-rc8
Date: Thu, 20 Mar 2025 16:55:13 +0100
Message-ID: <20250320155513.82476-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Linus!

The following changes since commit 4003c9e78778e93188a09d6043a74f7154449d43:

  Merge tag 'net-6.14-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-03-13 07:58:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc8

for you to fetch changes up to feaee98c6c505494e2188e5c644b881f5c81ee59:

  MAINTAINERS: Add Andrea Mayer as a maintainer of SRv6 (2025-03-20 15:49:00 +0100)

----------------------------------------------------------------
Including fixes from can, bluetooth and ipsec.

This contains a last minute revert of a recent GRE patch, mostly
to allow me stating there are no known regressions outstanding.

Current release - regressions:

  - revert "gre: Fix IPv6 link-local address generation."

  - eth: ti: am65-cpsw: fix NAPI registration sequence

Previous releases - regressions:

  - ipv6: fix memleak of nhc_pcpu_rth_output in fib_check_nh_v6_gw().

  - mptcp: fix data stream corruption in the address announcement

  - bluetooth: fix connection regression between LE and non-LE adapters

  - can:
    - flexcan: only change CAN state when link up in system PM
    - ucan: fix out of bound read in strscpy() source

Previous releases - always broken:

  - lwtunnel: fix reentry loops

  - ipv6: fix TCP GSO segmentation with NAT

  - xfrm: force software GSO only in tunnel mode

  - eth: ti: icssg-prueth: add lock to stats

Misc:

  - add Andrea Mayer as a maintainer of SRv6

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexander Mikhalitsyn (1):
      tools headers: Sync uapi/asm-generic/socket.h with the kernel sources

Alexandre Cassen (1):
      xfrm: fix tunnel mode TX datapath in packet offload mode

Arkadiusz Bokowy (1):
      Bluetooth: hci_event: Fix connection regression between LE and non-LE adapters

Arthur Mongodin (1):
      mptcp: Fix data stream corruption in the address announcement

Biju Das (2):
      dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties for R-Car V4M
      can: rcar_canfd: Fix page entries in the AFL list

Cosmin Ratiu (1):
      xfrm_output: Force software GSO only in tunnel mode

Dan Carpenter (2):
      Bluetooth: Fix error code in chan_alloc_skb_cb()
      net: atm: fix use after free in lec_send()

David Ahern (1):
      MAINTAINERS: Add Andrea Mayer as a maintainer of SRv6

David S. Miller (1):
      Merge branch 'xa_alloc_cyclic-checks'

Felix Fietkau (1):
      net: ipv6: fix TCP GSO segmentation with NAT

Gavrilov Ilia (1):
      xsk: fix an integer overflow in xp_create_and_assign_umem()

Guillaume Nault (2):
      Revert "selftests: Add IPv6 link-local address generation tests for GRE devices."
      Revert "gre: Fix IPv6 link-local address generation."

Haibo Chen (2):
      can: flexcan: only change CAN state when link up in system PM
      can: flexcan: disable transceiver during system PM

Haiyang Zhang (1):
      net: mana: Support holes in device list reply msg

Jakub Kicinski (1):
      selftests: drv-net: use defer in the ping test

Justin Iurman (3):
      net: lwtunnel: fix recursion loops
      net: ipv6: ioam6: fix lwtunnel_output() loop
      selftests: net: test for lwtunnel dst ref loops

Kuniyuki Iwashima (2):
      ipv6: Fix memleak of nhc_pcpu_rth_output in fib_check_nh_v6_gw().
      ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().

Lin Ma (1):
      net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES

MD Danish Anwar (1):
      net: ti: icssg-prueth: Add lock to stats

Marc Kleine-Budde (2):
      Merge patch series "R-Car CANFD fixes"
      Merge patch series "can: flexcan: only change CAN state when link up in system PM"

Michal Swiatkowski (3):
      devlink: fix xa_alloc_cyclic() error handling
      dpll: fix xa_alloc_cyclic() error handling
      phy: fix xa_alloc_cyclic() error handling

Oliver Hartkopp (1):
      can: statistics: use atomic access in hot path

Paolo Abeni (6):
      Merge tag 'linux-can-fixes-for-6.14-20250314' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'for-net-2025-03-14' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'net-fix-lwtunnel-reentry-loops'
      Merge tag 'batadv-net-pullrequest-20250318' of git://git.open-mesh.org/linux-merge
      Merge tag 'ipsec-2025-03-19' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'gre-revert-ipv6-link-local-address-fix'

Russell King (Oracle) (1):
      net: stmmac: dwc-qos-eth: use devm_kzalloc() for AXI data

Sven Eckelmann (1):
      batman-adv: Ignore own maximum aggregation size during RX

Vignesh Raghavendra (1):
      net: ethernet: ti: am65-cpsw: Fix NAPI registration sequence

Vincent Mailhol (1):
      can: ucan: fix out of bound read in strscpy() source

 .../bindings/net/can/renesas,rcar-canfd.yaml       |   2 +-
 MAINTAINERS                                        |  11 +
 drivers/dpll/dpll_core.c                           |   2 +-
 drivers/net/can/flexcan/flexcan-core.c             |  18 +-
 drivers/net/can/rcar/rcar_canfd.c                  |  28 +--
 drivers/net/can/usb/ucan.c                         |  43 ++--
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  14 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |   4 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  32 +--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |   2 +
 drivers/net/ethernet/ti/icssg/icssg_stats.c        |   4 +
 drivers/net/phy/phy_link_topology.c                |   2 +-
 include/net/bluetooth/hci.h                        |   2 +-
 include/net/mana/gdma.h                            |  11 +-
 net/atm/lec.c                                      |   3 +-
 net/batman-adv/bat_iv_ogm.c                        |   3 +-
 net/batman-adv/bat_v_ogm.c                         |   3 +-
 net/bluetooth/6lowpan.c                            |   7 +-
 net/can/af_can.c                                   |  12 +-
 net/can/af_can.h                                   |  12 +-
 net/can/proc.c                                     |  46 ++--
 net/core/lwtunnel.c                                |  65 +++++-
 net/core/neighbour.c                               |   1 +
 net/devlink/core.c                                 |   2 +-
 net/ipv6/addrconf.c                                |  15 +-
 net/ipv6/ioam6_iptunnel.c                          |   8 +-
 net/ipv6/route.c                                   |   5 +-
 net/ipv6/tcpv6_offload.c                           |  21 +-
 net/mptcp/options.c                                |   6 +-
 net/xdp/xsk_buff_pool.c                            |   2 +-
 net/xfrm/xfrm_output.c                             |  43 +++-
 tools/include/uapi/asm-generic/socket.h            |  21 +-
 tools/testing/selftests/drivers/net/ping.py        |  16 +-
 tools/testing/selftests/net/Makefile               |   2 +-
 tools/testing/selftests/net/config                 |   2 +
 tools/testing/selftests/net/gre_ipv6_lladdr.sh     | 177 ---------------
 .../selftests/net/lwt_dst_cache_ref_loop.sh        | 246 +++++++++++++++++++++
 38 files changed, 560 insertions(+), 334 deletions(-)
 delete mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh
 create mode 100755 tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh


