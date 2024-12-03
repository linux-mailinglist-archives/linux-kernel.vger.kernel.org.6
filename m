Return-Path: <linux-kernel+bounces-430121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9389E2CA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BF828A5D0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D670E20E006;
	Tue,  3 Dec 2024 20:01:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB97204F8E;
	Tue,  3 Dec 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256070; cv=none; b=lfs7vHH+d4T7p/kKHRyKFfX3T1u7WUHnUdHapCdNwbfgc0C7MvSDVzrUtSfNYl/Y7HP71J72DLUifarDErj+iQ6JJBiGAxTSDIjflmRmChLHdLUZiZTFkxwS4VL22FNj8bnKY5DrHciUlfC6M8L2mJDHYBnzSldpqtkcS8CiPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256070; c=relaxed/simple;
	bh=QQnGl49LYdyAEW/QAiHWfZsffZgxKlREAeZaTDNK9iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKB2xrIfCihybIZLt1dlzsj5fq4jZqAhQEzQbq23R8kvg7CCE9GsiWzeHDNAWQRXWVZC6t+DKQSMwT5wvS7rhTNVBJHmHTbNVGZYpN6etOANF9eMX80abTiiLoo5afhVGLNv8/LLN4JV/KE+cEhJIuaBmSa99rbzzEXQZ8xPDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67E7BFEC;
	Tue,  3 Dec 2024 12:01:34 -0800 (PST)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7D5A3F5A1;
	Tue,  3 Dec 2024 12:01:03 -0800 (PST)
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
Subject: [PATCH 0/2] Add SCMI Vendor module autoload support
Date: Tue,  3 Dec 2024 20:00:36 +0000
Message-ID: <20241203200038.3961090-1-cristian.marussi@arm.com>
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

Thanks,
Cristian

Cristian Marussi (2):
  firmware: arm_scmi: Support vendor protocol modules autoloading
  firmware: arm_scmi: Add module aliases to i.MX vendor protocols

 drivers/firmware/arm_scmi/driver.c            | 56 +++++++++++++++----
 .../arm_scmi/vendors/imx/imx-sm-bbm.c         |  5 +-
 .../arm_scmi/vendors/imx/imx-sm-misc.c        |  5 +-
 include/linux/scmi_imx_protocol.h             |  9 +--
 4 files changed, 57 insertions(+), 18 deletions(-)

-- 
2.47.0


