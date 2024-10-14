Return-Path: <linux-kernel+bounces-363575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2871199C42B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C8B1C22899
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10474154BE2;
	Mon, 14 Oct 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pWZ2f8id"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B11531C2;
	Mon, 14 Oct 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896062; cv=none; b=FPp/lOAXW7lqpcqhc7BtXQZijgJkBPil4VtokNy9xwk1V1nW0fVDQ71NKc5uD9A9mCNXip0ckU59iabq9DyHmJbf5/E9GKZWCQQC4EDj4vSVC+bqZ/14pGSfhpA7jsQRD6H7EXmgn12h1x+PWipqZeQZxOi5rcUSGRKNokV3z10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896062; c=relaxed/simple;
	bh=5fBgKpjbNCNaPjdtKKYViNGpeWKKViSdGxYY+QTp5zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uj8eH8HtXnSnO5giNEOtvho34iZvcjY5hregTM9M7An2cs8Qqsvm3TIfhjsT3MUqef+TQ4BKmGMLiINcqbS5mDi/fXUCVv45TwXbj3tqYkjcVM64J9NuYbZjiVbXE2m1/V8PC9xNnmYS3tBzaEjyGgo+CtiXUsA3pwjt+CBGRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pWZ2f8id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6A3C4CED0;
	Mon, 14 Oct 2024 08:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728896062;
	bh=5fBgKpjbNCNaPjdtKKYViNGpeWKKViSdGxYY+QTp5zQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pWZ2f8idaROXVMwY8bwG8o1nbaWe53XWITpJ0EtNQ86a2Rrx+rPx+jVMhAYI4wAOL
	 2rCB6jy17BxUhHJOrMFvPbnGKfs1ZOUDH4T/y+OCQu6yJNHiCAsTi5FJ3Nn1h8zjqC
	 cLUChLpbhvmyPWnJi/tlJRBfYfPk6B5LEiPRFLFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH] staging: gpib: mark HP82341 driver as broken
Date: Mon, 14 Oct 2024 10:54:13 +0200
Message-ID: <2024101412-outsider-icing-052e@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 29
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=5fBgKpjbNCNaPjdtKKYViNGpeWKKViSdGxYY+QTp5zQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDOk8d0zz721lNP4RfuPkLWnDE28Zguau2P/94Yln0t0Lv CQEOC+v74hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJdF9jmMXktbP8tI/6mmt1 6zcX5C79y3Iz8w7DHI4e5nOTbzEXm2krvfkZrTF9u8VfNQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The hp82341 driver uses the isapnp_read_byte() call, but it's not
exported for modules at this point in time:

ERROR: modpost: "isapnp_read_byte" [drivers/staging/gpib/hp_82341/hp_82341.ko] undefined!

So mark it as broken for now, it can be fixed and cleaned up later.

Link: https://lore.kernel.org/r/20241014162054.2b91b5af@canb.auug.org.au
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Dave Penkler <dpenkler@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/gpib/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index a628bc5240a3..9f337d57ce87 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -161,6 +161,7 @@ config GPIB_HP82341
        tristate "HP82341x"
        select GPIB_COMMON
        select GPIB_TMS9914
+       depends on BROKEN
        depends on ISA_BUS || EISA
        help
          GPIB driver for HP82341 A/B/C/D boards
-- 
2.47.0


