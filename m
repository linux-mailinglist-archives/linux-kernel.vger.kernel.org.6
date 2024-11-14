Return-Path: <linux-kernel+bounces-408898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A049C84D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2A7284883
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07A41F7576;
	Thu, 14 Nov 2024 08:28:06 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A23DA1F6690;
	Thu, 14 Nov 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572886; cv=none; b=ATCPuExbIVBbVUOJ3aWfeFDjX5rYRnm4yT4wJ2SUfJr/lNz/XhoxrCbUmbhodebQ+5lhcz18Rr/RbwerwXALponl3Je9C+3/45cZBArkR5XUqG/UxQXCzRxAyGR4dIHWFzQkuyRIGLwJnGN7o8FizMl+lEFYC066XSSOpPr0zdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572886; c=relaxed/simple;
	bh=qKMb5xp9vO7tdpEHfSewFvW5Y/lht3/Q9AKSeYi1qPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l75MwUJf2+nxJjdQqG0/KFv0K7r87VVJSBES6wegGszLNuYYhAAkBScMZ15PO08VGHawFoFuDBqoq4/Qs3uKRT74yUFsfHH77tek5JlYd+Kkaii0i649kVZB+RGthdnDb0gFp3/zqEOUE4SvIPC7IT2c18YYGG0XDFS16aoWjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 2ECD86123B6DA;
	Thu, 14 Nov 2024 16:27:57 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] bus: fsl-mc:  Fix the double free in fsl_mc_device_add()
Date: Thu, 14 Nov 2024 16:27:52 +0800
Message-Id: <20241114082751.3475110-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clang static checker(scan-build) warning：
drivers/bus/fsl-mc/fsl-mc-bus.c: line 909, column 2
Attempt to free released memory.

When 'obj_desc->type' == "dprc" and begin to free 'mc_bus' and 'mc_dev',
there is a double free problem because of 'mc_dev = &mc_bus->mc_dev'.
Add a judgment to fix this problem.

Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 930d8a3ba722..8d2d5d3cc782 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -905,8 +905,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
-	kfree(mc_bus);
-	kfree(mc_dev);
+	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)
+		kfree(mc_bus);
+	else
+		kfree(mc_dev);
 
 	return error;
 }
-- 
2.30.2


