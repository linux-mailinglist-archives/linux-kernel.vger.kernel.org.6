Return-Path: <linux-kernel+bounces-374874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8708D9A715F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B11F23076
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752951F708F;
	Mon, 21 Oct 2024 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="db1PrNBl"
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57051EF0BD;
	Mon, 21 Oct 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532987; cv=none; b=gXFrdhWjrxFWYm6M5YbLDg3C6dtiHptuRMqE2KucE/ADAkSDmQ523X+Cmtc6Al6Kc6nompjucKMb9b0QZ4U7k+7sstrAjoOqvm+0gWjo8s3wNevS4kDkEHItIdbSBRV28kKI9pSawYEn0ru/qBnaBSrXo+K4pNcEpbseD+dLb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532987; c=relaxed/simple;
	bh=wWqJweXrmpxu1ytmO1zT3vDpyOrJGE0phQ0vxF0cl/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5YGFOrHsQf58YbzZfJe6rJ0b2cZoemf9Mxc4AXT8EBHJzXzeyw6zYbvqnmaduLMmNs0RouSDDkp9RrU2OxgVhsXFqPM+qJtt2EQ1Cw8tDcfMJzq1dn4xPXY9k11R/aW48/i6lypNX8R7LMAktMOpBluaKlzkzKoRFzoUKXlAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=db1PrNBl; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8D522C0000F4;
	Mon, 21 Oct 2024 10:49:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8D522C0000F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1729532978;
	bh=wWqJweXrmpxu1ytmO1zT3vDpyOrJGE0phQ0vxF0cl/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=db1PrNBl6My9AGaPaALrN+gIk9+YOkaSnQ1/IaaDMBqX1W8TWY2nnM+QbpeqVYtiV
	 a7CDXzPcS+gF5SHCYzQKWyEdj9gBuasqZTpZTd5hCTUBfBT1VwpYgxw0SB4UtpErbN
	 5zN3RczhvlUJQOq+kdblwp0L9hbuF5QHIXx9P7jk=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 2AF2018041CACA;
	Mon, 21 Oct 2024 10:49:38 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:)
Subject: [PATCH net-next v2 1/2] net: systemport: Remove unused txchk accessors
Date: Mon, 21 Oct 2024 10:49:34 -0700
Message-ID: <20241021174935.57658-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021174935.57658-1-florian.fainelli@broadcom.com>
References: <20241021174935.57658-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vladimir reported the following warning with clang-16 and W=1:

warning: unused function 'txchk_readl' [-Wunused-function]
BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

warning: unused function 'txchk_writel' [-Wunused-function]
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

warning: unused function 'tbuf_readl' [-Wunused-function]
BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

warning: unused function 'tbuf_writel' [-Wunused-function]
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

The TXCHK and RBUF blocks are not being accessed, remove the IO macros
used to access those blocks. No functional impact.

Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 0b7088ca4822..9e42b5db721e 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -46,9 +46,7 @@ BCM_SYSPORT_IO_MACRO(umac, SYS_PORT_UMAC_OFFSET);
 BCM_SYSPORT_IO_MACRO(gib, SYS_PORT_GIB_OFFSET);
 BCM_SYSPORT_IO_MACRO(tdma, SYS_PORT_TDMA_OFFSET);
 BCM_SYSPORT_IO_MACRO(rxchk, SYS_PORT_RXCHK_OFFSET);
-BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
 BCM_SYSPORT_IO_MACRO(rbuf, SYS_PORT_RBUF_OFFSET);
-BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
 BCM_SYSPORT_IO_MACRO(topctrl, SYS_PORT_TOPCTRL_OFFSET);
 
 /* On SYSTEMPORT Lite, any register after RDMA_STATUS has the exact
-- 
2.43.0


