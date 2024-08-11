Return-Path: <linux-kernel+bounces-282088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4C794DFA0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A600B2104C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB0BA47;
	Sun, 11 Aug 2024 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="f6uEAHWN"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F7EAE7
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343114; cv=none; b=NfAgepPNrNrziRV6b/krQFwRspWQymwSE+CvgumnJ37CdEjX6pVDurVc2G8ti6htucdEqOZTkarQpOkVHnOIF7nHtXKopfX0HLIcmDSe2cDawp7tILorYgHMJ6TpCiihRU/bxfhkkbOcmkje78HxxKFF8vd/GVgO8oUJ0/Ors2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343114; c=relaxed/simple;
	bh=GmRrKYHvoE0Yc+oOxii5OGtpXQiyv+LofdluVeD0YgE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DMAhRFPIo3r/OBV2BgFXXuGRNcN2iM85kZjdaVMoSIcNzdHswYrjfssXLjBsB17+3ZVg27X+QkWIYapTTwMJ7x8adFO1CZIkjfOVYlklZXExYqA/NvwAc+9z+mHvwBR43is2Mh0KdeJj0/SBAHz6DSZ11C/9H0T3sZl8TnqMedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=f6uEAHWN; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343112;
	bh=KuDg9rPPhbQ0YbsPaWZZ7OF7lmt1csmuicUQjKcRCbA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=f6uEAHWNSvXMYNCy+8+nPHnfshFaYy8Ali9kkiyzq93eOlcHLkq4sTjrgTGAPZJBm
	 8jYESpKMUfQEHLFjDtTxxOkRuufbccuIy4yQ1JrlKJLZPMig/mhotFhPox27A9SijG
	 RiKgy/L6HodlucI2ZfQfOOU//pCJGN3z3K++vKH9CclFCatziPAxKjrFGf3aN1i7wu
	 WOmxl5QSF7RyNZYUq7RnNuZsC3dqPvRw0+lIdtUvOnY2qIwY9F7fpegL4YJrTtBFLE
	 ZIIQ6cv4A+HP9iwfZ+7Css0CJPsT1NP/2XB8DP+Vza3FconMPwS9xBjoxuCaboQV2o
	 /YL8/VfacL1zQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id ABDA21349B99;
	Sun, 11 Aug 2024 02:25:08 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 00/27] driver core: Make device_find_child()'s match
 function take a const pointer
Date: Sun, 11 Aug 2024 10:24:51 +0800
Message-Id: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPQguGYC/22PS2rEMBAFr2K0jkCS9bF9lTCYVqs7o4U/IzkmM
 MzdI+JNAlm+hiqqn6JSyVTF1D1FoTPXvK1t6LdO4B3WD5I5tS2MMlYNWkvc1nrMiXFO20oSHRr
 lfXDoo2jQXojz14/w/XbtQo/P5j2uo4hQG7YtSz6mLjI4C2HsI4RA7MdmctF77gEtJaUwJG3sI
 H73TN1Vo7RMdM4LHHifYc/SageNZ2SO02n+hf680Op2KCR7ZtOjd+NAbjq1uL1e31F1+JEaAQA
 A
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: vsFROq6PlYGwXdgsNzEznQBESOi783bR
X-Proofpoint-ORIG-GUID: vsFROq6PlYGwXdgsNzEznQBESOi783bR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to constify the following core driver API:

struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
to
struct device *device_find_child(struct device *dev, const void *data,
				 device_match_t match);
typedef int (*device_match_t)(struct device *dev, const void *data);

It mainly make various device_find_child()'s match functions take
const void * as match data type.

Why to constify the API?

(1) It does not make sense, also does not need to, for such device
finding operation to modify caller's match data which is mainly
used for comparison.
(2) It will make the API's match function parameter have the same
signature as all other APIs (bus|class|driver)_find_device().

Previous discussion link:
https://lore.kernel.org/lkml/917359cc-a421-41dd-93f4-d28937fe2325@icloud.com

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (27):
      driver core: Constify driver API device_find_child()
      Bluetooth: hci_sysfs: Make device_find_child()'s match function take a const pointer
      serial: core: Make device_find_child()'s match function take a const pointer
      usb: typec: class: Make device_find_child()'s match function take a const pointer
      gpio: sim: Make device_find_child()'s match function take a const pointer
      slimbus: core: Make device_find_child()'s match function take a const pointer
      scsi: iscsi: Make device_find_child()'s match function take a const pointer
      scsi: iscsi: Constify driver API iscsi_find_flashnode_sess()
      scsi: qla4xxx: Make iscsi_find_flashnode_sess()'s match function take a const pointer
      pwm: Make device_find_child()'s match function take a const pointer
      media: pci: mgb4: Make device_find_child()'s match function take a const pointer
      range.h: Make range_contains() take const struct range * as parameter type
      cxl/region: Make device_find_child()'s match function take a const pointer
      cxl/pmem: Make device_find_child()'s match function take a const pointer
      cxl/core/pci: Make device_find_child()'s match function take a const pointer
      sparc: vio: Make device_find_child()'s match function take a const pointer
      bus: fsl-mc: Make device_find_child()'s match function take a const pointer
      block: sunvdc: Make device_find_child()'s match function take a const pointer
      firmware: arm_scmi: Make device_find_child()'s match function take a const pointer
      efi: dev-path-parser: Make device_find_child()'s match function take a const pointer
      drm/mediatek: Make device_find_child()'s match function take a const pointer
      nvdimm: Make device_find_child()'s match function take a const pointer
      libnvdimm: Make device_find_child()'s match function take a const pointer
      rpmsg: core: Make device_find_child()'s match function take a const pointer
      thunderbolt: Make device_find_child()'s match function take a const pointer
      net: dsa: Make device_find_child()'s match function take a const pointer
      cxl/test: Make device_find_child()'s match function take a const pointer

 arch/sparc/kernel/vio.c                |  6 +++---
 drivers/base/core.c                    | 11 +++--------
 drivers/block/sunvdc.c                 |  8 ++++----
 drivers/bus/fsl-mc/dprc-driver.c       |  8 ++++----
 drivers/cxl/core/pci.c                 |  4 ++--
 drivers/cxl/core/pmem.c                |  2 +-
 drivers/cxl/core/region.c              | 19 +++++++++++--------
 drivers/firmware/arm_scmi/bus.c        |  4 ++--
 drivers/firmware/efi/dev-path-parser.c |  4 ++--
 drivers/gpio/gpio-sim.c                |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 +-
 drivers/media/pci/mgb4/mgb4_core.c     |  4 ++--
 drivers/nvdimm/bus.c                   |  2 +-
 drivers/nvdimm/claim.c                 |  4 ++--
 drivers/pwm/core.c                     |  2 +-
 drivers/rpmsg/rpmsg_core.c             |  4 ++--
 drivers/scsi/qla4xxx/ql4_os.c          |  3 ++-
 drivers/scsi/scsi_transport_iscsi.c    | 10 +++++-----
 drivers/slimbus/core.c                 | 11 ++++++-----
 drivers/thunderbolt/retimer.c          |  2 +-
 drivers/thunderbolt/xdomain.c          |  2 +-
 drivers/tty/serial/serial_core.c       |  4 ++--
 drivers/usb/typec/class.c              |  8 ++++----
 include/linux/device.h                 |  4 ++--
 include/linux/range.h                  |  3 ++-
 include/scsi/scsi_transport_iscsi.h    |  4 ++--
 net/bluetooth/hci_sysfs.c              |  2 +-
 net/dsa/dsa.c                          |  2 +-
 tools/testing/cxl/test/cxl.c           |  2 +-
 29 files changed, 72 insertions(+), 71 deletions(-)
---
base-commit: bfa54a793ba77ef696755b66f3ac4ed00c7d1248
change-id: 20240811-const_dfc_done-c5c206675c6b
prerequisite-change-id: 20240801-dev_match_api-415a755fcffb:v2
prerequisite-patch-id: 475b810c1ccacab955c654c223d5214f70c4f6c8
prerequisite-change-id: 20240811-const_dfc_prepare-3ff23c6598e5:v1
prerequisite-patch-id: 81a5ccaa144a7732cae29fc5ea1a13426becee5b
prerequisite-patch-id: 9b77254186b7366809f949f5643f9437fa2528a0
prerequisite-patch-id: 95308bb3eedcf8c4a5e30aa3071116148495329e
prerequisite-patch-id: ee643a52674e2aead02f7be3d011d88507970436
prerequisite-patch-id: 0625de1f03ef4350b1828f0faff7a9d9bdebae94

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


