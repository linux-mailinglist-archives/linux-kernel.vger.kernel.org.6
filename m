Return-Path: <linux-kernel+bounces-282045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E5094DEDF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31906282179
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244BD14374D;
	Sat, 10 Aug 2024 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="odtIilGn"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FF813698E;
	Sat, 10 Aug 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723326940; cv=none; b=OBrC8GHQrsHAJL65UvVG9tOjFhzmy5glGG0s69mDDhWO7CpteNP1DjskJqlvYC3f9ZUQX14JpAz9q70oSKoH+cj1nsuF2caTds1m/LWt4C5iVBWlESJ/J+PPEle5mDN+lSG4Oxfil9yxVzkojrfqVMjfbNQqpRudNoucOGjtJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723326940; c=relaxed/simple;
	bh=F5mbExSO0dCKsn3DSvEd5rpr3bEqPzn3aeGGkmFpwvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZZ5LLS3L+UA/ByXAg+4SjqFGAPANQ1Vv4zxx/V1ZuHhyHCzRnVutFtkWGc/VF2X/4SNHdbko5JPq56QwQFD2e5zT/nLPXqR38F2bMy6vu3nGCxXxFeskFUFbwuXhdzOuQ8npqpvtCTIpcTIEmeCWYXH+Q+Ha7ShgY3SmV8JIK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=odtIilGn; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 60DC4C0000D8;
	Sat, 10 Aug 2024 14:46:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 60DC4C0000D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1723326379;
	bh=F5mbExSO0dCKsn3DSvEd5rpr3bEqPzn3aeGGkmFpwvo=;
	h=From:To:Cc:Subject:Date:From;
	b=odtIilGnfMhlQnA0zVWxh7JqiEdMH/V+aO9iOLVgk/6aamr47tgNvlMVuo0Vmn7YH
	 RN4qQcsekZceV8Pum8shCqclosMwnW9Hl4LC0akiXkiwi5xC+zK1Bj4RGK4f5ciDHj
	 7LIt58xhirDOovLRCGHBJnrvElNmLGjxCzu7hTMk=
Received: from 7YHHR73.igp.broadcom.net (unknown [10.230.29.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 04BFD18041CAC4;
	Sat, 10 Aug 2024 14:46:15 -0700 (PDT)
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
	arm-scmi@vger.kernel.org,
	james.quinlan@broadcom.com,
	justin.chen@broadcom.com,
	kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 0/2] Support for I/O width within ARM SCMI SHMEM
Date: Sat, 10 Aug 2024 14:46:19 -0700
Message-Id: <20240810214621.14417-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.25.1
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

Thanks!

Florian Fainelli (2):
  dt-bindings: sram: Document reg-io-width property
  firmware: arm_scmi: Support 'reg-io-width' property for shared memory

 .../devicetree/bindings/sram/sram.yaml        |  6 ++
 drivers/firmware/arm_scmi/common.h            | 14 +++-
 .../arm_scmi/scmi_transport_mailbox.c         | 12 ++-
 .../firmware/arm_scmi/scmi_transport_optee.c  |  7 +-
 .../firmware/arm_scmi/scmi_transport_smc.c    | 10 ++-
 drivers/firmware/arm_scmi/shmem.c             | 77 ++++++++++++++++---
 6 files changed, 102 insertions(+), 24 deletions(-)

-- 
2.25.1


