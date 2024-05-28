Return-Path: <linux-kernel+bounces-192996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CE48D2569
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF241C2784C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FFF173349;
	Tue, 28 May 2024 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E21Ct1tV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9A17838E;
	Tue, 28 May 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926607; cv=none; b=AeAlm14Q40mnqriqtrDVQYNG8XoGyWMKh2t+FY8UkBenAunQY+ZRCRUuChl8oSBX0X+37aw085lHeHnIG4E4NvYZ8M1HKvJpkpX68BesVZ54SbhgDpLcB5VWimKFhjaQHH2erp1V4fpE34Ki2m2YOdQGoRPETo9I3jClo8ogGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926607; c=relaxed/simple;
	bh=GAX+4DxMOBaXQxskI6jsbm3aDcBHEhA6V34iGhZ3FI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mjtd6TsFzSW09uPfAvLKwfI09lST3YbpPLFRDfRtkSmDSFwT6F/RtByAJNf3JqU2dP6JAy+t045PrS9YpclFFwSx3f+nv3g3b/mrgQP/I8bSmRz8Byo1wxFzf5xBfV5qqFRUElcQBr9hd3cHvyUkZxWoF50EKl6pscJUhaVQz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E21Ct1tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E67C32786;
	Tue, 28 May 2024 20:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716926606;
	bh=GAX+4DxMOBaXQxskI6jsbm3aDcBHEhA6V34iGhZ3FI8=;
	h=From:To:Cc:Subject:Date:From;
	b=E21Ct1tViP9RMBjfbfmBrqQOe7dYJDJ65CW2626+quVfcMw3FhP0GxHO8xqISNLYu
	 vZ1VKcOeljVot3/6wNJrgCM06vRadywsik/YA6uzQ7SGF90AHNxc37o22AfmQRmBDF
	 Th9WHV438CCTOl1KWQtboUuAGK2cOW+uOIaE+HRvjal3IfcFbQbB9yL79t6aDGPqMl
	 BCv/Q3SXzUScRrcZmte3hNC9wK8ObQJk/MxwwMZyeyJM9DGr/SH+Ywv3O0F0cAW1Mm
	 IdIy8pC3oPr326vcFY/JGr+vzRGw6UYZFfvVv4vrPmQRbte+VOtvh1bPMNFtIGWcG6
	 naCqVwoHlZH0Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: kbuild: Fix dt_binding_check on unconfigured build
Date: Tue, 28 May 2024 15:02:32 -0500
Message-ID: <20240528200231.1548800-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'dt_binding_check' target shouldn't depend on the kernel
configuration, but it has since commit 604a57ba9781 ("dt-bindings:
kbuild: Add separate target/dependency for processed-schema.json").
That is because CHECK_DT_BINDING make variable was dropped, but
scripts/dtc/Makefile was missed. The CHECK_DTBS variable can be used
instead.

Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Fixes: 604a57ba9781 ("dt-bindings: kbuild: Add separate target/dependency for processed-schema.json")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 scripts/dtc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index a18657072541..b47f4daa4515 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -3,7 +3,7 @@
 
 # *** Also keep .gitignore in sync when changing ***
 hostprogs-always-$(CONFIG_DTC)		+= dtc fdtoverlay
-hostprogs-always-$(CHECK_DT_BINDING)	+= dtc
+hostprogs-always-$(CHECK_DTBS)		+= dtc
 
 dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
 		   srcpos.o checks.o util.o
-- 
2.43.0


