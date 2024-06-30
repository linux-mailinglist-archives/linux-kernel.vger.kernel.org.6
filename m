Return-Path: <linux-kernel+bounces-235350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186ED91D46A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2751C208B8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F101F77F1B;
	Sun, 30 Jun 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="5IdRy5iU"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AC3C092
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786579; cv=none; b=gTNrewcq5CnYAxJItERHQNbDzyKMhMjwq8o0o+Us6fYYIZRO91NmCMkaRDJ6sgz3ptakwoGssWKMr34bELmZs7/3fkRJoMn9MmNbUMV2qqerlWRoWtapznRHgmrzi/8V3oFeQYGjgNyI2Bv3WvU0XYPqjjrhaM8rp1BvjQOmcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786579; c=relaxed/simple;
	bh=Cq+4sWNnSF5Wwpo+JnRAVuu33kX9Y7YBwUOWrI81JAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SP8GNSozmRLIJh5+Cl/z5gC+CNNHIFulJVSVaYyRE/McQvU4WiQGFNzlhHj7dmmVZJznqI2nGnoxNkXgFF5UzTUzUTny7Lky1byswdLuYD83HJlAk63rLCrGA4fGsZlCw3zuIvIXI2/KLQdH3vRLvTn6I0KzcSNVudBtYi5DHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=5IdRy5iU; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3kg2RFdzll9fK;
	Sun, 30 Jun 2024 22:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1719786567; x=1722378568; bh=J+n0B7rRFzUjAtFXrRfyRNlbqruLIjMEnHM
	f3m/4HNg=; b=5IdRy5iU550Rz98OZd++RJ7nqHgev9Ad8v4PYYcdRPGNs5HlL1/
	zNa1RMG6HdpXI+wYQUBZjb5nDjq8N2fnqN6rUbGYWjqo/eMVCys97CuAhhZjCOOf
	1pBsIx2uNqQ+vy1bU9gL4+LWWiHfwkiru8fDs5Rgu965Ak+dEmEgjOTHOp1D0jcF
	uGYuuGjJsYevMhCPwoGJqwiQgWRHlucqJP8Ed6g6VrrdVYESM+aB2Z4HDvpUt/P+
	kDGdHeJGP2z8OQ3meaihaWX0Pv/QA8HkW85N3eXGQQCkVoFU8G+9NIiSaUzicaWL
	1/6XD/Vw3+hXwj3d8lNkizGNNYfOsijVPqA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dcHp36B831ug; Sun, 30 Jun 2024 22:29:27 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3kY5yGkzll9f8;
	Sun, 30 Jun 2024 22:29:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/53] Let create*_workqueue() accept a printf-style format string
Date: Sun, 30 Jun 2024 15:26:18 -0700
Message-ID: <20240630222904.627462-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

A significant amount of kernel code formats the workqueue name before it
calls a workqueue creation function. This patch series simplifies such ke=
rnel
code and modifies the create*_workqueue() macros such that these accept a
printf-style format string and argument list.

The approach of this patch series is as follows:
1. Introduce the create*_workqueue2() macros that accept a printf-style
   format string and argument list.
2. Convert all workqueue creation calls that might pass a name that inclu=
des
   a formatting character from create*_workqueue(name) into
   create*_workqueue2("%s", name).
3. Convert all workqueue creation code that is preceded by workqueue name
   formatting code into a create*_workqueue2(fmt, args) call.
4. Convert all create*_workqueue2() calls into create*_workqueue() calls,
   remove the original create*_workqueue() calls and rename the new
   create*_workqueue2() macros into create*_workqueue().

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (53):
  workqueue: Introduce the create*_workqueue2() macros
  dmaengine: idxd: Switch to create*_workqueue2()
  drm/amdgpu: Switch to create*_workqueue2()
  media: i2c: adv7511: Switch to create*_workqueue2()
  media: cobalt: Switch to create*_workqueue2()
  media: dm1105: Switch to create*_workqueue2()
  misc: bcm_vk: Switch to create*_workqueue2()
  net: amd-xgbe: Switch to create*_workqueue2()
  net: atlantic: Switch to create*_workqueue2()
  net: mvpp2: Switch to create*_workqueue2()
  remoteproc: stm32: Switch to create*_workqueue2()
  mm/z3fold: Switch to create*_workqueue2()
  usb: typec: tcpm: Switch to create*_workqueue2()
  net/qla3xxx: Switch to create*_workqueue2()
  sfc: Switch to create*_workqueue2()
  wifi: zd1211rw: Switch to create*_workqueue2()
  power: supply: mt6370: Switch to create*_workqueue2()
  remoteproc: imx_rproc: Switch to create*_workqueue2()
  scsi: hisi_sas: Switch to create*_workqueue2()
  scsi: mpt3sas: Switch to create*_workqueue2()
  accel/habanalabs: Simplify the workqueue creation calls
  crypto: safexcel - Simplify a create*_workqueue() call
  pds_core: Simplify a create*_workqueue() call
  net: bna: Simplify a create*_workqueue() call
  net/mlx5: Simplify the create*_workqueue() calls
  net: lan966x: Simplify a create*_workqueue() call
  net: sparx5: Simplify the create*_workqueue() calls
  net: mscc: ocelot: Simplify a create*_workqueue() call
  net: qed: Simplify a create*_workqueue() call
  net: stmmac: Simplify a create*_workqueue() call
  nfc: mrvl: Simplify a create*_workqueue() call
  scsi: ibmvscsi_tgt: Simplify a create*_workqueue() call
  scsi: libsas: Simplify the create*_workqueue() calls
  scsi: mpi3mr: Simplify a create*_workqueue() call
  scsi: qedf: Simplify the create*_workqueue() calls
  scsi: qedi: Simplify the create*_workqueue() calls
  scsi: qla2xxx: Simplify the create*_workqueue() calls
  scsi: qla4xxx: Simplify a create*_workqueue() call
  scsi: vmw_pvscsi: Simplify a create*_workqueue() call
  scsi: myrb: Simplify the create*_workqueue() calls
  scsi: myrs: Simplify the create*_workqueue() calls
  scsi: stex: Simplify the create*_workqueue() calls
  scsi: fcoe: Simplify the create*_workqueue() calls
  scsi: snic: Simplify the create*_workqueue() calls
  scsi: scsi_transport_fc: Simplify the create*_workqueue() calls
  scsi: core: Simplify the alloc_workqueue() calls
  serial: max3100: Simplify a create*_workqueue() call
  scsi: ufs: Simplify the create*_workqueue() calls
  usb: typec: ucsi: Simplify a create*_workqueue() call
  cifs: Simplify a create*_workqueue() call
  mac802154: Simplify the create*_workqueue() calls
  nfc: nci: Simplify the create*_workqueue() calls
  workqueue: Rename create*_workqueue2() into create*_workqueue()

 drivers/accel/habanalabs/common/device.c      | 25 +++++++++----------
 drivers/crypto/inside-secure/safexcel.c       |  4 +--
 drivers/dma/idxd/cdev.c                       |  2 +-
 drivers/dma/idxd/init.c                       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  2 +-
 drivers/media/i2c/adv7511-v4l2.c              |  2 +-
 drivers/media/pci/cobalt/cobalt-driver.c      |  2 +-
 drivers/media/pci/dm1105/dm1105.c             |  2 +-
 drivers/misc/bcm-vk/bcm_vk_dev.c              |  2 +-
 drivers/net/ethernet/amd/pds_core/main.c      |  7 ++----
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      |  4 +--
 .../net/ethernet/aquantia/atlantic/aq_main.c  |  2 +-
 drivers/net/ethernet/brocade/bna/bnad.c       |  4 +--
 drivers/net/ethernet/brocade/bna/bnad.h       |  1 -
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 12 ++-------
 .../net/ethernet/mellanox/mlx5/core/health.c  | 10 ++------
 .../mellanox/mlx5/core/sf/vhca_event.c        |  5 ++--
 .../microchip/lan966x/lan966x_ethtool.c       |  7 ++----
 .../microchip/sparx5/sparx5_ethtool.c         |  6 ++---
 .../ethernet/microchip/sparx5/sparx5_main.c   |  6 ++---
 drivers/net/ethernet/mscc/ocelot_stats.c      |  6 ++---
 drivers/net/ethernet/qlogic/qed/qed_sriov.c   |  9 +++----
 drivers/net/ethernet/qlogic/qla3xxx.c         |  2 +-
 drivers/net/ethernet/sfc/efx_common.c         |  3 ++-
 drivers/net/ethernet/sfc/falcon/efx.c         |  3 ++-
 drivers/net/ethernet/sfc/siena/efx_common.c   |  3 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++-----
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c  |  2 +-
 drivers/nfc/nfcmrvl/fw_dnld.c                 |  8 +++---
 drivers/power/supply/mt6370-charger.c         |  2 +-
 drivers/remoteproc/imx_rproc.c                |  2 +-
 drivers/remoteproc/stm32_rproc.c              |  2 +-
 drivers/scsi/fcoe/fcoe_sysfs.c                |  7 +-----
 drivers/scsi/hisi_sas/hisi_sas_main.c         |  2 +-
 drivers/scsi/hosts.c                          |  9 +++----
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c      |  4 +--
 drivers/scsi/libsas/sas_init.c                |  9 +++----
 drivers/scsi/mpi3mr/mpi3mr_fw.c               |  4 +--
 drivers/scsi/mpt3sas/mpt3sas_base.c           |  4 +--
 drivers/scsi/myrb.c                           |  5 ++--
 drivers/scsi/myrb.h                           |  1 -
 drivers/scsi/myrs.c                           |  5 ++--
 drivers/scsi/myrs.h                           |  1 -
 drivers/scsi/qedf/qedf_main.c                 | 17 +++++--------
 drivers/scsi/qedi/qedi_main.c                 |  8 +++---
 drivers/scsi/qla2xxx/qla_os.c                 | 10 ++++----
 drivers/scsi/qla4xxx/ql4_os.c                 |  5 ++--
 drivers/scsi/scsi_transport_fc.c              |  4 +--
 drivers/scsi/snic/snic_main.c                 |  5 ++--
 drivers/scsi/stex.c                           |  6 ++---
 drivers/scsi/vmw_pvscsi.c                     |  8 ++----
 drivers/tty/serial/max3100.c                  |  4 +--
 drivers/ufs/core/ufshcd.c                     | 13 +++-------
 drivers/usb/typec/tcpm/fusb302.c              |  2 +-
 drivers/usb/typec/ucsi/ucsi.c                 |  9 ++-----
 fs/smb/client/smbdirect.c                     |  3 +--
 include/linux/mlx5/driver.h                   |  5 ----
 include/linux/workqueue.h                     | 15 +++++------
 include/scsi/fcoe_sysfs.h                     |  1 -
 include/scsi/scsi_host.h                      |  1 -
 include/scsi/scsi_transport_fc.h              |  3 ---
 mm/z3fold.c                                   |  4 +--
 net/mac802154/main.c                          |  7 +++---
 net/nfc/nci/core.c                            | 13 +++++-----
 66 files changed, 135 insertions(+), 223 deletions(-)


