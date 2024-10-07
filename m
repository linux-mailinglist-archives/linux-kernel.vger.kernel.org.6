Return-Path: <linux-kernel+bounces-353509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823E5992ECA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481B5285209
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B876E1D7E5C;
	Mon,  7 Oct 2024 14:17:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCAB1D47D4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310653; cv=none; b=HjpJ5JbJV/hlMLD87/GRsKC5uymHBDu8p/kxVMVPlYbGvI/5dwB2qa04PeiVfSwK70gFuLe6jgOfA221wYxI7f2c0TqnVNFpeEtBK6AvNT/Zq6pW9eZdk0ZDbraEoGTEc1rGSAYyCUTh1GGJuS6BevfCuF3PUAn7uQehM09060c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310653; c=relaxed/simple;
	bh=9c6RrjNGOG4XZv7JW3ZCZzhn7dUc8ULtYyQgSmm/Rk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p79ToDzcGztmcohnmntvGtrmI8p12U8nY4evJhG41R1AFHt3PwZQCCPFgGw+RfRS9+T3Tct8gVl0/px6TAgrNbjZWY5VFtFAlNHAuED4TVPDTVyVmvzij8QID0f3V7QNHUdAbM3VDYBfspaWbftl5+Xh4magEnQfCWfGCi8hClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1sxoY4-0008LN-Rj; Mon, 07 Oct 2024 16:17:20 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH 0/2] improve multicast join group performance
Date: Mon, 07 Oct 2024 16:17:10 +0200
Message-Id: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGbtA2cC/x3OUQqDMBCE4atInrs1kVJrryJ9iOuoCzWGrJWCe
 PfGPv4wH8xuFEmg5lnsJmETlSXkcJfC8OTDCJI+t6lsdXPW1iTjHEkj0H8iVewt113jHk1vMum
 8grrkA08n2u5XZ8t1icJlwFoOCVD2b9DMXleKSMOS5jzHqWPCIN//mfZ1HD8rGxiEnAAAAA==
X-Change-ID: 20241007-igmp-speedup-2ca0c7b9189d
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Madalin Bucur <madalin.bucur@nxp.com>, 
 Sean Anderson <sean.anderson@seco.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series seeks to improve performance on updating igmp group
memberships such as with IP_ADD_MEMBERSHIP or MCAST_JOIN_SOURCE_GROUP.

Our use case was to add 2000 multicast memberships on a TQMLS1046A which
took about 3.6 seconds for the membership additions alone. Our userspace
reproducer tool was instrumented to log runtimes of the individual
setsockopt invocations which clearly indicated quadratic complexity of
setting up the membership with regard to the total number of multicast
groups to be joined. We used perf to locate the hotspots and
subsequently optimized the most costly sections of code.

This series includes a patch to Linux igmp handling as well as a patch
to the DPAA/Freescale driver. With both patches applied, our memberships can
be set up in only about 87 miliseconds, which corresponds to a speedup
of around 40.

While we have acheived practically linear run-time complexity on the
kernel side, a small quadratic factor remains in parts of the freescale
driver code which we haven't yet optimized. We have by now payed little
attention to the optimization potential in dropping group memberships,
yet the dpaa patch applies to joining and leaving groups alike.

Overall, this patch series brings great improvements in use cases
involving large numbers of multicast groups, particularly when using the
fsl_dpa driver, without noteworthy drawbacks in other scenarios.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Jonas Rebmann (2):
      net: ipv4: igmp: optimize ____ip_mc_inc_group() using mc_hash
      net: dpaa: use __dev_mc_sync in dpaa_set_rx_mode()

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 20 +++++++++--
 drivers/net/ethernet/freescale/fman/fman_dtsec.c |  1 -
 drivers/net/ethernet/freescale/fman/fman_memac.c |  1 -
 drivers/net/ethernet/freescale/fman/fman_tgec.c  |  1 -
 drivers/net/ethernet/freescale/fman/mac.c        | 42 ------------------------
 drivers/net/ethernet/freescale/fman/mac.h        |  2 --
 net/ipv4/igmp.c                                  | 26 ++++++++++++---
 7 files changed, 39 insertions(+), 54 deletions(-)
---
base-commit: 8b641b5e4c782464c8818a71b443eeef8984bf34
change-id: 20241007-igmp-speedup-2ca0c7b9189d

Best regards,
-- 
Jonas Rebmann <jre@pengutronix.de>


