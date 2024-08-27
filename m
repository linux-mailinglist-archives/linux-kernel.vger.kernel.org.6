Return-Path: <linux-kernel+bounces-303929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF82961708
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA051C23056
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE781D1F55;
	Tue, 27 Aug 2024 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="alWX8iss"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0191D27B1;
	Tue, 27 Aug 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783584; cv=none; b=SypZTzkVIJm9hnxjVej88mifywR2lfIya1afnBOjlf+SEoSHmckavYzLyp8BOI716xYENuWQzPirb/IgMELhRvtTpxK17nDObgomhmmKsq+LKM+4cFFsB2D6R5eaBbw8Ic/lNEbda4tCvh84eazvUeWUwtBAwNh9N056DwqfiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783584; c=relaxed/simple;
	bh=1386lGTMB6WCcSqsjLJUMCrOsAbXFeBuQL4kGvdYOLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ltyr1+VLLoIhsXhoH+POAq7XpYOrv3OOfUPMLnCMcukTNh8fKVPRFjVWwJWkiNI1+om+zE80/jH16ejQ1535pWmNbKq+KI/7tVwaEjqtn3U9Eg5SUq3S4EgSPe9kVH0xhBg+7Rm5JkLGWYnVK3TKih0RJ8oZ7hF70nC3RCHtwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=alWX8iss; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 40E0AC0000E4;
	Tue, 27 Aug 2024 11:24:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 40E0AC0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1724783094;
	bh=1386lGTMB6WCcSqsjLJUMCrOsAbXFeBuQL4kGvdYOLQ=;
	h=From:To:Cc:Subject:Date:From;
	b=alWX8issrocCy8Fbnb6qTjBa1LKsp87QC9xvBRCelEPXvz00Fy66v0ajMCipefx+w
	 O74Q76fWS9tmOW3wAfv94aMnF7LZ8JzsEeMPUbYLIDhBW+n9sipw8rAkpwJlKEFUcj
	 TMIgDW/ZoQeXTBCq1itZlXWMGBlpj5YjP9tQbIFM=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id CD45118045E7C9;
	Tue, 27 Aug 2024 11:24:53 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	arm-scmi@vger.kernel.org (open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	justin.chen@broadcom.com,
	opendmb@gmail.com,
	kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 0/2] Support for I/O width within ARM SCMI SHMEM
Date: Tue, 27 Aug 2024 11:24:48 -0700
Message-Id: <20240827182450.3608307-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We just got our hands on hardware that only supports 32-bit access width
to the SRAM being used. This patch series adds support for the
'reg-io-width' property and allows us to specify the exact access width
that the SRAM supports.

Changes in v4:

- added alignment warnings in case the source/destination/count are not
  a 4 bytes multiple
- switched to __ioread32_copy/__iowrite32_copy per Sudeep's suggestion
- dropped volatile qualifiers to permit that switch

Changes in v3:

- added missing documentation for the structure members being added
- removed the use of a macro for the 32-bit only operation, this
  gets rid of a number of checkpatch warnings
- added missing trailing barriers
- corrected binding indentation

Changes in v2:

- fixed typo in the binding and added reviewed-by tag from Krzysztof

- determine the correct I/O operation at the time we parse the
  'reg-io-width' property rather than for each
  tx_prepare/fetch_response/fetch_notification call

- dropped support for 1 and 2 bytes 'reg-io-width' as they do not quite
  make sense, if we can support such smaller access size, then we can
  support the larger 4 byte access width, too, and there are many places
  within the SCMI code where ioread32/iowrite32 are used

Florian Fainelli (2):
  dt-bindings: sram: Document reg-io-width property
  firmware: arm_scmi: Support 'reg-io-width' property for shared memory

 .../devicetree/bindings/sram/sram.yaml        |  6 ++
 drivers/firmware/arm_scmi/common.h            | 32 +++++++-
 .../arm_scmi/scmi_transport_mailbox.c         | 13 +++-
 .../firmware/arm_scmi/scmi_transport_optee.c  | 11 ++-
 .../firmware/arm_scmi/scmi_transport_smc.c    | 11 ++-
 drivers/firmware/arm_scmi/shmem.c             | 78 +++++++++++++++++--
 6 files changed, 130 insertions(+), 21 deletions(-)

-- 
2.34.1


