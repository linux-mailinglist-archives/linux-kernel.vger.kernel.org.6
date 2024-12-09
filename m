Return-Path: <linux-kernel+bounces-438042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040CF9E9C1C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EED22838A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9DC14B087;
	Mon,  9 Dec 2024 16:50:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B93145B1B;
	Mon,  9 Dec 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763024; cv=none; b=Wa5W4yZqoHeiigWSHi6nQ/QDvBOpbc8OPwTnAm4zE+H9xCxJCC5EeVF0nElM8slkfr/CrtYeCYezhkl3lTLCOKWerQLQzDd9+XQ5hs+swE0wGb0YuQzWiQCHZcAFNwT65ZmA7uGIUBtQHhSBZGvixbmjktXyZ22unM6a2uofoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763024; c=relaxed/simple;
	bh=9JCHFqvsDfco+WkYYgPFOsQ1zPwH0yDqAVM+3zIEfw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5n1yNWCGN3t58nzY8NP2Lfri1OyiWdQaVKa6MfApk3mDQEEWAdmOkKj8fV5eY1jUUyDWp+gcQbk+HFrfA5ogzTjmXQEq6Dxq9pMB/i0FZgHChM9PGPLMVjVt+IYaBI+TPnOfSoHLpfRppPUbPIPexMnAF/HNadERHYFpCwhcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE39F113E;
	Mon,  9 Dec 2024 08:50:48 -0800 (PST)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4682D3F720;
	Mon,  9 Dec 2024 08:50:18 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	johan+linaro@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/3] Add SCMI Vendor module autoload support
Date: Mon,  9 Dec 2024 16:49:54 +0000
Message-ID: <20241209164957.1801886-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

a tiny series to add the capability to automatically load the proper
vendor protocol module when an SCMI driver tries to use it; while proper
vendor protocol selection is already provided by the SCMI core, automatic
loading of vendor protocols was not.

Lookup is now based on module aliases following the pattern:

	scmi-protocol-0x<PROTO_ID_NN>-<VENDOR_ID>

In [2/2] proper aliases are added to existing i.MX Vendor protocols...
...could not find a better way to build the alias string automagically...
...any advice is welcome in these regards...and any feedback too !

In V2, an additional patch is added to simply add the proper/required
MODULE_DEVICE_TABLE to SCMI transport driver to enable autoloading also
for those.

Thanks,
Cristian

V1 --> V2
- added tags
- added Transport aliases patch via MODULE_DEVICE_TABLE

Cristian Marussi (3):
  firmware: arm_scmi: Support vendor protocol modules autoloading
  firmware: arm_scmi: Add module aliases to i.MX vendor protocols
  firmware: arm_scmi: Add aliases to transport modules

 drivers/firmware/arm_scmi/driver.c            | 56 +++++++++++++++----
 .../firmware/arm_scmi/transports/mailbox.c    |  1 +
 drivers/firmware/arm_scmi/transports/smc.c    |  1 +
 drivers/firmware/arm_scmi/transports/virtio.c |  1 +
 .../arm_scmi/vendors/imx/imx-sm-bbm.c         |  5 +-
 .../arm_scmi/vendors/imx/imx-sm-misc.c        |  5 +-
 include/linux/scmi_imx_protocol.h             |  9 +--
 7 files changed, 60 insertions(+), 18 deletions(-)

-- 
2.47.0


