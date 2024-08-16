Return-Path: <linux-kernel+bounces-290410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87539955375
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42802282898
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE83C1465A5;
	Fri, 16 Aug 2024 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="kI/loyTB"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E070145A1C;
	Fri, 16 Aug 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723848153; cv=none; b=kBMZpIuFh7ZfUDYal3p/KzueAEK246HBo94CUSXSkeTyEmdsiF99MfCYWjCGlHXF6cjxW+1Gi6IpjPv4BDV3qI6fzmaWlCY+mqAnGfY0kBCZU+htkKUiN4YeiggdySRKgd4l6NptETtLzdcQqymrfRPcR8sZVZK9JPvTMOjcZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723848153; c=relaxed/simple;
	bh=WRbliPKlVatjmY9WoO49bTw+Tpuioxe/sdDsJOlGUBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dp/MsZTVreoiXmjnr7oySIC9aNjq/3ufVYW1JfJ3t8mRoYaY15ACPeihec2s1Y+WYpc/RM9hxceZJW9ytlzaULsgdJ7XvhA7p4eh0tlqCX9Ee+yc9yZNk1SepbuIiV9Jz4sN/Wo3URajYTLANe1zSSoU3cZ6Oo+PEQBiF7ZYVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=kI/loyTB; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7E064C0000E4;
	Fri, 16 Aug 2024 15:42:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7E064C0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1723848143;
	bh=WRbliPKlVatjmY9WoO49bTw+Tpuioxe/sdDsJOlGUBE=;
	h=From:To:Cc:Subject:Date:From;
	b=kI/loyTB/yUl5GOVheNi2Papl7piKaJ2uRx3/5CUiZz/Xt8bbPA3qY9jSWGj+uFvI
	 pcuPb+hgFJwMONxt+unL7OOot/39s7ItgnHgFGRBCITceVSJwEToo9ljLwI5Ahb13x
	 IYtd+oFQY56u4pqqaGWK/zPzve3P4HpULm9k/IB0=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id A091018041CAD3;
	Fri, 16 Aug 2024 15:42:20 -0700 (PDT)
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
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v3 0/2] Support for I/O width within ARM SCMI SHMEM
Date: Fri, 16 Aug 2024 15:42:19 -0700
Message-Id: <20240816224221.3256455-1-florian.fainelli@broadcom.com>
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
 drivers/firmware/arm_scmi/common.h            | 32 ++++++-
 .../arm_scmi/scmi_transport_mailbox.c         | 13 ++-
 .../firmware/arm_scmi/scmi_transport_optee.c  | 11 ++-
 .../firmware/arm_scmi/scmi_transport_smc.c    | 11 ++-
 drivers/firmware/arm_scmi/shmem.c             | 86 +++++++++++++++++--
 6 files changed, 138 insertions(+), 21 deletions(-)

-- 
2.34.1


