Return-Path: <linux-kernel+bounces-261906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5088693BDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E468F1F247AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E728172BDA;
	Thu, 25 Jul 2024 08:05:46 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B6C249ED
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894745; cv=none; b=VHYRzM2kUkpq3/dUE/WoPUuzhzinzPEnltZt5MR+yaRfRTmEUKWfaEYS1F7C6isi8F8NfbULVUhaM5J9GtTErWcPKBxJlRDaXrVSqFaSQNmSLCFgg2pF/pMY+3F1mJW0qFgXY7lesOtss89XjpbIp6yu3R3BnHSMFEpctqAcwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894745; c=relaxed/simple;
	bh=juiRPFb3ysJvYNyEc/viUX0sORvuirQqenTgO4aqjLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DEZc/8fRiJTZlg2joWUAqRweKcD78NE7NFAKIiWyV1IqDoW4GrR368P0kQbmri+p1M16Bt7vROqqUKJjx0/FtgF+aj28F21EPqblIyF25sW/KhLoEcHglne6wDtKW3rYVCTNXnDbh/QbbwQ1um1lIJz0hoGGkt0IiEy1TXREJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:9697:b0ae:59fa:9dc8])
	by andre.telenet-ops.be with bizsmtp
	id rk5b2C00730uYn301k5bjA; Thu, 25 Jul 2024 10:05:35 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sWtTO-003PCh-6H;
	Thu, 25 Jul 2024 10:05:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sWtTj-008liP-5u;
	Thu, 25 Jul 2024 10:05:35 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] netfs: Fix dependency of NETFS_DEBUG
Date: Thu, 25 Jul 2024 10:05:30 +0200
Message-Id: <20240725080530.2089573-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The configuration symbol "NETFS" does not exist.
Its proper name is "NETFS_SUPPORT".

Fixes: fcad93360df4d04b ("netfs: Rename CONFIG_FSCACHE_DEBUG to CONFIG_NETFS_DEBUG")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 fs/netfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index 1b78e8b65ebc142d..7701c037c3283f27 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -24,7 +24,7 @@ config NETFS_STATS
 
 config NETFS_DEBUG
 	bool "Enable dynamic debugging netfslib and FS-Cache"
-	depends on NETFS
+	depends on NETFS_SUPPORT
 	help
 	  This permits debugging to be dynamically enabled in the local caching
 	  management module.  If this is set, the debugging output may be
-- 
2.34.1


