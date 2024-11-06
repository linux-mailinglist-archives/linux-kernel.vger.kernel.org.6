Return-Path: <linux-kernel+bounces-398638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 367F99BF3FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E27B226EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92B2064E4;
	Wed,  6 Nov 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4vfBNAD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB72064FB;
	Wed,  6 Nov 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912895; cv=none; b=szrbionO6vuN2kzbJ0RB9pj8W4OP/QNTqZHh0GbjZTDYsY8kyKOnAfh8dbfkqP6/xfHuItuH6s5qZ8ZD9kXycStbMwr8avfi3lQ6VrlB+bsump+jkBsUPSXdfr5TeSp+UcRwSwxKSAdFC7HAV9UIYbjSASDekO4i5mjVH1Jmg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912895; c=relaxed/simple;
	bh=pUYkLg+G7KLaAY9aCiiGAzu9EW9W5zVLNsTbTO5Ljks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nlb50YjkDRTHPuIwBhtrWsLmgj468eMlCdaPiH7Na/9CN13F7lh280gH7zM3yx7XCFDcqoPuz403v+zubXR0VGakw+aUX2vwnuUga/Ejb2eS1ICTC8YkebxzQ5piFTYfjnLGCfQ7teDiNWQCXLJPG8ZhFBTfHarp717nK3YE5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4vfBNAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2652C4CECC;
	Wed,  6 Nov 2024 17:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730912895;
	bh=pUYkLg+G7KLaAY9aCiiGAzu9EW9W5zVLNsTbTO5Ljks=;
	h=From:To:Cc:Subject:Date:From;
	b=P4vfBNADblD7j1alhLNaEOT/tMszPj1erIsShjcZr3fmeDW5addHB+D5Svy5FtFRc
	 ZZo0AlSYjr+U233wIgMK1yKJNvABVz2irggmUatlfPCHWbsQ2pj64ZF3mhP5QQglYP
	 G5jn2ATLSdOvEK375OfXiWo297TfEE4IS+emU9iY1eCT4D5/tXxmngoAcUHs7OE1EV
	 LuCaKwEW82cKpvm6Gt9zEWUEJoEHe0RG45t2PUhUKreuq0dAX92xt+BrUFSxDo+9wY
	 K0r8lkFAHTW0GsTOigENfRErjK5Hjte9fHCEizTXc8DQqCew5MgTno66PeyD3glCfE
	 TwvwYgkuTBbPg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of/fdt: Don't use default address cell sizes for address translation
Date: Wed,  6 Nov 2024 11:08:07 -0600
Message-ID: <20241106170808.3827790-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FDT systems should never be relying on default cell sizes. It's been a
warning in dtc since 2007. The behavior here doesn't even match the
unflattened code which will walk the parent nodes looking for the cell
size properties (also deprecated). Furthermore, the FDT address
translation code is only used in one spot by SH and for earlycon which
was added 2014 and certainly isn't used on Powerpc systems.

Returning -1 values will result in an error message.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/fdt_address.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt_address.c b/drivers/of/fdt_address.c
index 1dc15ab78b10..9804d7f06705 100644
--- a/drivers/of/fdt_address.c
+++ b/drivers/of/fdt_address.c
@@ -55,7 +55,7 @@ static void __init fdt_bus_default_count_cells(const void *blob, int parentoffse
 		if (prop)
 			*addrc = be32_to_cpup(prop);
 		else
-			*addrc = dt_root_addr_cells;
+			*addrc = -1;
 	}
 
 	if (sizec) {
@@ -63,7 +63,7 @@ static void __init fdt_bus_default_count_cells(const void *blob, int parentoffse
 		if (prop)
 			*sizec = be32_to_cpup(prop);
 		else
-			*sizec = dt_root_size_cells;
+			*sizec = -1;
 	}
 }
 
-- 
2.45.2


