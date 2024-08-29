Return-Path: <linux-kernel+bounces-307272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B113B964B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6430B1F2705C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8BB1B29D2;
	Thu, 29 Aug 2024 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxQMC6M2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C41B0132
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947999; cv=none; b=dctwJYw04jInzFeUlGGlxidFn8KuppBbdWIQJN+Dt9oPXKAruBDyDQBwiSn4gleXU30ZiuqbTrR+WnloowqdQCoiQu+XC2baWo6S4yJE5xG/9fxr8M970B80azLj9SCi+UsI7s7w9GwcTE/+UmLHoAzqGtTrAZage+sh0+JP1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947999; c=relaxed/simple;
	bh=kkmk67njSj3RYt5xQQFMEzZ1Ur9x+vmFtoczjMZFm9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmkPsiwg2DkElkeqrvhEr54X+cjX/f1naq7ScK4s7mIby2/mFomeoF2xR7IJvcMR9Q8ISemyvPlScc3ZgkT+I0Nupr5VZNXWaPrwe6AzOvCiMfZdg/fdSx6O7OpuANQEWltxlffc55k9I4iU9s8G1KIldN8OmQtht72CBPXAfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxQMC6M2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724947996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=COFAXD9yJzZM407zOzOxKIdk87f2SuuzWb/JWLyEDEQ=;
	b=HxQMC6M2KeYOcAEnm4drUXxUnL/BbBX7Ecjm1+d3G2YuU6onMtELNLVW0oja2jVPOyxS/T
	7xarifghFP7H69q3UtwxPSGkvYQthjU2tKkeg6tgEWPS2lVJ/seWZgRQ5S9QuAbkjdZw6T
	wkAllD99tNBT6yOyTO0JWgngbsCi3Zk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-OabU_tjOOj-RCPzIQMtzlg-1; Thu,
 29 Aug 2024 12:13:12 -0400
X-MC-Unique: OabU_tjOOj-RCPzIQMtzlg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E07301954B1F;
	Thu, 29 Aug 2024 16:13:10 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.194.81])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A448A19560AA;
	Thu, 29 Aug 2024 16:13:05 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com,
	eric.auger@redhat.com,
	treding@nvidia.com,
	vbhadram@nvidia.com,
	jonathanh@nvidia.com,
	mperttunen@nvidia.com,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	alex.williamson@redhat.com,
	clg@redhat.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com
Cc: msalter@redhat.com
Subject: [RFC PATCH 0/5] vfio: platform: reset: Introduce tegra234 mgbe reset module
Date: Thu, 29 Aug 2024 18:11:04 +0200
Message-ID: <20240829161302.607928-1-eric.auger@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

We introduce a new vfio platform reset module for the tegra234
Multi-Gigabit Ethernet (MGBE).

This reset driver is more complex than previous ones because some
resources need to be prepared and released (clocks and reset). The
existing infrastructure was too simplistic to do that. So this series
extends the original single reset function to an ops struct enhanced
with optional open/close callbacks.

There the reset and clocks are handled. the functions are
called on open_device/close_device callback. That's questionable
whether this should be called in init/release instead but memory
regions cannot be ioremapped at that time since
vfio_platform_regions_init is called on .opendevice.

The actual reset toggles the mac reset, disable mac interrupts,
stop DMA requests and do a SW reset.

The reset code is inspired of the native driver:
net/ethernet/stmicro/stmmac/dwxgmac2_dma.c and
net/ethernet/stmicro/stmmac/dwmac-tegra.c

This series can be found at:
https://github.com/eauger/linux/tree/tegra234-mgbe-reset-module-rfc

The qemu series to test with can be found at
https://github.com/eauger/qemu/tree/tegra234-mgbe-rfc

Best Regards

Eric


Eric Auger (5):
  vfio_platform: Introduce vfio_platform_get_region helper
  vfio_platform: reset: Prepare for additional reset ops
  vfio_platform: reset: Introduce new open and close callbacks
  vfio-platform: Add a new handle to store reset data
  vfio/platform: Add tegra234-mgbe vfio platform reset module

 drivers/vfio/platform/reset/Kconfig           |   7 +
 drivers/vfio/platform/reset/Makefile          |   2 +
 .../platform/reset/vfio_platform_amdxgbe.c    |   7 +-
 .../reset/vfio_platform_calxedaxgmac.c        |   7 +-
 .../reset/vfio_platform_tegra234_mgbe.c       | 245 ++++++++++++++++++
 drivers/vfio/platform/vfio_platform_common.c  |  78 ++++--
 drivers/vfio/platform/vfio_platform_private.h |  43 ++-
 7 files changed, 358 insertions(+), 31 deletions(-)
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_tegra234_mgbe.c

-- 
2.41.0


