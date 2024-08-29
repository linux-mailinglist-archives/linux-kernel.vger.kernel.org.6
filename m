Return-Path: <linux-kernel+bounces-306563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2165F96408B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E517B238F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5774918DF73;
	Thu, 29 Aug 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Jyaaq3X6";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="SOEHxjYN"
Received: from a7-43.smtp-out.eu-west-1.amazonses.com (a7-43.smtp-out.eu-west-1.amazonses.com [54.240.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841B18CBE9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925032; cv=none; b=j7Z6TwxUktDLSk5cU+BjB+D9c+gJHdqd8uLZHc5YcFPQ2wAIi77AwcomrjaD9MSo2X3Rnc4/1t+KPQOCarBUDrd9aD8fWsIZqk1ijrJvCfPr45pgSI3cNCHKJI9ZNQVRvviL/nQjEmtosZ5ObdNyO3txIm3MjHqtrbMXDYfK3RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925032; c=relaxed/simple;
	bh=1r4ayiwAvXVwfa9sqGT1kuxN3TvylajxJIFXvCiow5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auK2ByrH3+U+m4G8buu3RMh8x/oUbjbzQulS1pZsfK9rHuA0bd2CERA6TaiYaZPtw231i44vJtRz6m0ulU+rlZxYcbBsa6vs9pIlXL2D3zixEqIW01TQxvRRblZ575GHFw8r/9RpNqZTjNsOVU75jDbU+PaqhKKmEWlkdN51mTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Jyaaq3X6; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=SOEHxjYN; arc=none smtp.client-ip=54.240.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1724925028;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=1r4ayiwAvXVwfa9sqGT1kuxN3TvylajxJIFXvCiow5c=;
	b=Jyaaq3X6QFAkpx7f4VAPibPs4bE696EGWvJuvEthEY8UDn2O275Uh9rS0JXd2gPG
	XuGwaKe8Opu9PKSQVRlz4IaX9IS5Q19FLOKSHBI0jvWcSdmjqQxBM6HpVZJqGCjLMe8
	UImIM5Jpv7CXARuM4AkexUceGYaiX07vOYdQJwbv5hNR+aUAP1OwnBdwQALSIvZCFPb
	O5LE3zjOU3Iaev+lKWS8u5X1P6SALaxRgZISB3RlefFv5yqPvEYE/ayvcwZFuAsGGnv
	eM4IiGIZWemAGeJ0kEk4pEcaKkD43glbIcDhNlT1nmi7CwShbLPjw/mkEWnXDGyYwnq
	q8G9BFLlQA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1724925028;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=1r4ayiwAvXVwfa9sqGT1kuxN3TvylajxJIFXvCiow5c=;
	b=SOEHxjYN+Y0GemjHF9KPQtYDRdVa4sIOL67YvoHuIldwV/v1MrjkiWKiVfrYRv1K
	s4SyI5AD8aMWELv7kglqIYQaojTC38KsOYtE7ZrCaCWXLeXFcm9uCpmwCRDIICob/U4
	lE8vDwANzKq2mgESiCTOTPF+uNMJsRgDezkgzMU8=
From: Martyn Welch <martyn.welch@collabora.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: omap: Enable COMPILE_TEST for OMAP2+ Mailbox framework support
Date: Thu, 29 Aug 2024 09:50:28 +0000
Message-ID: <010201919d8b298f-dd1585dd-7c4d-4865-9483-ff6cd7399a90-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.08.29-54.240.7.43

The commit ebcf9008a895 ("remoteproc: k3-m4: Add a remoteproc driver for
M4F subsystem") was added with `COMPILE_TEST` as a dependency. It has
been reported that this is causing a failure when running allmodconfig
on x86_64:

  WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
    Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
    Selected by [m]:
    - TI_K3_M4_REMOTEPROC [=m] && REMOTEPROC [=y] && (ARCH_K3 || COMPILE_TEST [=y])

To resolve this, either `COMPILE_TEST` needs to be removed from
`TI_K3_M4_REMOTEPROC` or added to `OMAP2PLUS_MBOX`. In the interest of
maximising testing, and as `OMAP2PLUS_MBOX` compiles fine on x86_64, add
`COMPILE_TEST` to `OMAP2PLUS_MBOX`.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 4eed97295927..ecaf78beb934 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -73,7 +73,7 @@ config ARMADA_37XX_RWTM_MBOX
 
 config OMAP2PLUS_MBOX
 	tristate "OMAP2+ Mailbox framework support"
-	depends on ARCH_OMAP2PLUS || ARCH_K3
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	help
 	  Mailbox implementation for OMAP family chips with hardware for
 	  interprocessor communication involving DSP, IVA1.0 and IVA2 in
-- 
2.45.2


