Return-Path: <linux-kernel+bounces-417524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A9B9D5524
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A591F23741
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEFA1DDC2D;
	Thu, 21 Nov 2024 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArQcT4SL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674A1DDA37
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226582; cv=none; b=HNgtyzF9EJA/qbuxEcbKhpDUTTrXMttSLdyEWM/nKzuEYIQKBzKMKcR4K/mVA+UrEyHyRyB/J72qeQnFDuTsErILXUdUZggJHtRIS1tZXG6QkLhngObNBs5wa60kdz3DUyu513m0l6JxTnNUzIkx1Iz5icjFL1JMiSN2d8K6so0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226582; c=relaxed/simple;
	bh=5QZQjErElj3y/LB+QkqUnurQSzrENiSCuB1glqrxbhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rP/GyV/rxJ8zfZ5DqebMC4uYJLanFRP/AD25wzlwt05dCTu8GU/Hsc/NTVFWPvwEg9EJwLza3jAw7ynRu4PCCrVCbdSQrzhzB5OnwSuhqsD+G5rZRGEsCCH19yKROoI9pUWm2/OHB6lwTk8aM6RCQKpoibeKhy0hwXCsWyUaex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArQcT4SL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732226579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mF3+KWvgLxl5U2zTG2GYl36cA4R4ZAKeJVmHOspWrlw=;
	b=ArQcT4SL2Uxtami2dmh1o72bKn/wh7X1pRFOp4kBAhI6nMheiVJfe9tigUw4o3TLtngF/M
	dXrZWbQIc3Ac5C2/1DcLfY/yxB+Nh2n1oN73c+G6D9UNRxF2DiTs2FoVe6ktVuByb9YFFo
	aIFzsn72z5wFxXgcrIfony3gbOc/lyk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-5HqZUzsAP3-yRf4VSj2Lvg-1; Thu,
 21 Nov 2024 17:02:56 -0500
X-MC-Unique: 5HqZUzsAP3-yRf4VSj2Lvg-1
X-Mimecast-MFC-AGG-ID: 5HqZUzsAP3-yRf4VSj2Lvg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE30719560AF;
	Thu, 21 Nov 2024 22:02:53 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29D21195E481;
	Thu, 21 Nov 2024 22:02:49 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	mpe@ellerman.id.au,
	naveen@kernel.org,
	maddy@linux.ibm.com,
	kernel@xen0n.name
Cc: jmeneghi@redhat.com,
	bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>
Subject: [PATCH 0/1] nvme: remove CONFIG_NVME_MULTIPATH
Date: Thu, 21 Nov 2024 17:02:35 -0500
Message-ID: <20241121220235.40576-1-bgurney@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Device-mapper multipath will no longer be operating on NVMe devices,
so the nvme.core.multipath module parameter can be removed.  This
series also removes the CONFIG_NVME_MULTIPATH kconfig option.

This was tested on the nvme-6.13 branch (currently showing version
6.12-rc4), with particular attention to tests nvme/033-036, and
nvme/039.  These tests still passed after the removal of the
CONFIG_NVME_MULTIPATH parameter (the tests use an "rc" function,
_require_test_dev_is_not_nvme_multipath, that checks for
"nvme-subsystem" in $TEST_DEV_SYSFS, so they do not check for the
existence of CONFIG_NVME_MULTIPATH).

The blktests test nvme/005 checks for the module parameter value of
"nvme_core multipath", but this test gets skipped after this patch.

Bryan Gurney (1):
  nvme: always enable multipath

 arch/loongarch/configs/loongson3_defconfig |  1 -
 arch/powerpc/configs/skiroot_defconfig     |  1 -
 drivers/nvme/host/Kconfig                  |  9 --
 drivers/nvme/host/Makefile                 |  3 +-
 drivers/nvme/host/core.c                   | 17 +---
 drivers/nvme/host/ioctl.c                  |  3 +-
 drivers/nvme/host/multipath.c              | 10 +--
 drivers/nvme/host/nvme.h                   | 97 +---------------------
 drivers/nvme/host/sysfs.c                  |  6 --
 9 files changed, 7 insertions(+), 140 deletions(-)

-- 
2.45.2


