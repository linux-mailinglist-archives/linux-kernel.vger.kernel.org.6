Return-Path: <linux-kernel+bounces-187776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D98CD830
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7341F22BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A07171AB;
	Thu, 23 May 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJbyz/5v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E6AD32
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480939; cv=none; b=LI2RwQNRfkaCK0nsEPJ9umxCg92SISgOMUyh/c9WiMbNkD/zQenDD1eQQYb9xQtENe+xc5VdMamlDKxbQFGfVqJ1roJBN5paC+ADJMsXX8fJm5lVcTmrVl1QIkmEvIFR9jlYEW7elc+5KT8Vt7JowxxZHELR1xC8noLH1wmPOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480939; c=relaxed/simple;
	bh=HUiDqIKcPkxhqgCqrdX+3V1XatPUGmKPVoXNFSP6NiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pqR84WDv2OXD3bAosKEAzZCZCva959q5HP0qe8L89w1ZQeQskghS50KC4sHsr44bHfoXzP2RL6YL/448xlkZzcHpcf7Q0KdoEGGDYKPenA5unnTqsk8nz77DT5UgyscE15X0meQazAl/YAOMlhnx4X3GVjOXFghnlryhRsYo7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJbyz/5v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716480936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7vbV4Zxk6Uer4VyYr9J8Op0OojWbWcBoS2aEeh+QoUo=;
	b=bJbyz/5vjRKpVdzcxGSu0Yuz9eUfgah7q85bruGPMbJt43kgmzyhwnmZKwWTVOIWbuzBfm
	oPheSCra03PxKJCOLw/9NMXwrDdFbD5SA6sJUfOUocCEiZWYNmAsIJJMb+q4FU0AJLaU8z
	efczt14FG+rdaaOuCjkXzGhB4x5lPCE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-8yVaMe1qOl2XhKSKAknzwQ-1; Thu,
 23 May 2024 12:15:35 -0400
X-MC-Unique: 8yVaMe1qOl2XhKSKAknzwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 952343C025C8;
	Thu, 23 May 2024 16:15:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.237])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61B6E2026D68;
	Thu, 23 May 2024 16:15:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.10-rc1
Date: Thu, 23 May 2024 18:15:24 +0200
Message-ID: <20240523161524.82511-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi Linus!

The following changes since commit 4b377b4868ef17b040065bd468668c707d2477a5:

  kprobe/ftrace: fix build error due to bad function definition (2024-05-17 19:17:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc1

for you to fetch changes up to c71e3a5cffd5309d7f84444df03d5b72600cc417:

  r8169: Fix possible ring buffer corruption on fragmented Tx packets. (2024-05-23 15:45:32 +0200)

----------------------------------------------------------------
Quite smaller than usual. Notably it includes the fix for the unix
regression you have been notified of in the past weeks.
The TCP window fix will require some follow-up, already queued.

Current release - regressions:

  - af_unix: fix garbage collection of embryos

Previous releases - regressions:

  - af_unix: fix race between GC and receive path

  - ipv6: sr: fix missing sk_buff release in seg6_input_core

  - tcp: remove 64 KByte limit for initial tp->rcv_wnd value

  - eth: r8169: fix rx hangup

  - eth: lan966x: remove ptp traps in case the ptp is not enabled.

  - eth: ixgbe: fix link breakage vs cisco switches.

  - eth: ice: prevent ethtool from corrupting the channels.

Previous releases - always broken:

  - openvswitch: set the skbuff pkt_type for proper pmtud support.

  - tcp: Fix shift-out-of-bounds in dctcp_update_alpha().

Misc:

  - a bunch of selftests stabilization patches.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aaron Conole (1):
      openvswitch: Set the skbuff pkt_type for proper pmtud support.

Andrea Mayer (1):
      ipv6: sr: fix missing sk_buff release in seg6_input_core

Dae R. Jeong (1):
      tls: fix missing memory barrier in tls_init

Florian Fainelli (1):
      net: Always descend into dsa/ folder with CONFIG_NET_DSA enabled

Hangbin Liu (2):
      ipv6: sr: fix memleak in seg6_hmac_init_algo
      selftests/net: use tc rule to filter the na packet

Heiner Kallweit (1):
      Revert "r8169: don't try to disable interrupts if NAPI is, scheduled already"

Horatiu Vultur (1):
      net: lan966x: Remove ptp traps in case the ptp is not enabled.

Jacob Keller (1):
      Revert "ixgbe: Manual AN-37 for troublesome link partners for X550 SFI"

Jason Xing (1):
      tcp: remove 64 KByte limit for initial tp->rcv_wnd value

Joe Damato (1):
      testing: net-drv: use stats64 for testing

Ken Milmore (1):
      r8169: Fix possible ring buffer corruption on fragmented Tx packets.

Kuniyuki Iwashima (3):
      af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
      tcp: Fix shift-out-of-bounds in dctcp_update_alpha().
      selftest: af_unix: Make SCM_RIGHTS into OOB data.

Larysa Zaremba (2):
      ice: Interpret .set_channels() input differently
      idpf: Interpret .set_channels() input differently

Michal Luczaj (1):
      af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS

Paolo Abeni (3):
      Merge branch 'af_unix-fix-gc-and-improve-selftest'
      net: relax socket state check at accept time.
      Merge branch 'intel-interpret-set_channels-input-differently'

Romain Gantois (1):
      net: ti: icssg_prueth: Fix NULL pointer dereference in prueth_probe()

Ryosuke Yasuoka (2):
      nfc: nci: Fix uninit-value in nci_rx_work
      nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()

Souradeep Chakrabarti (1):
      net: mana: Fix the extra HZ in mana_hwc_send_request

Taehee Yoo (1):
      selftests: net: kill smcrouted in the cleanup logic in amt.sh

Wei Fang (1):
      net: fec: avoid lock evasion when reading pps_enable

 drivers/net/Makefile                               |  4 +-
 drivers/net/ethernet/freescale/fec_ptp.c           | 14 +++---
 drivers/net/ethernet/intel/ice/ice_ethtool.c       | 19 +------
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     | 21 +++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |  3 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      | 56 ++-------------------
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  6 +--
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |  2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  9 ++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       | 14 +++++-
 net/ipv4/af_inet.c                                 |  4 +-
 net/ipv4/tcp_dctcp.c                               | 13 ++++-
 net/ipv4/tcp_output.c                              |  2 +-
 net/ipv6/seg6_hmac.c                               | 42 ++++++++++------
 net/ipv6/seg6_iptunnel.c                           | 11 ++--
 net/nfc/nci/core.c                                 | 18 +++++--
 net/openvswitch/actions.c                          |  6 +++
 net/tls/tls_main.c                                 | 10 +++-
 net/unix/af_unix.c                                 | 28 ++++++++---
 net/unix/garbage.c                                 | 23 +++++----
 tools/testing/selftests/drivers/net/stats.py       |  2 +-
 tools/testing/selftests/net/af_unix/scm_rights.c   |  4 +-
 tools/testing/selftests/net/amt.sh                 |  8 ++-
 .../selftests/net/arp_ndisc_untracked_subnets.sh   | 53 +++++++-------------
 tools/testing/selftests/net/forwarding/lib.sh      | 58 ----------------------
 tools/testing/selftests/net/lib.sh                 | 58 ++++++++++++++++++++++
 26 files changed, 243 insertions(+), 245 deletions(-)


