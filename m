Return-Path: <linux-kernel+bounces-446915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B89F2AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B5C7A27B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE611B85E4;
	Mon, 16 Dec 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R7W2QzWI"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10D191F99
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333991; cv=none; b=STf69Z9NH2N9xAKHjoCgRGuPURPk81naCSKTwJweoJFzendUfC1z/JiQ8EdFn3qt+uHMIuEXZQ5h7bIexNVRUYrIFRlZbDCgAMuYwHwtXrUwCeQyPyoXFQeJe5SbEbb97VUhBfLy2uNRBDO0kynWHe8jB37HrCv20G67ga6889M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333991; c=relaxed/simple;
	bh=rLSJg2JrpZlRnXGH9HbQj1M1iRYrYUMMMlnYd0b+EAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0SeaDMdfbTMrFj0C+MPaOhEYqmxWM6Lh0rBwuKBhagRogzG68X5vBHQy3v5U9E/Li37U98KijejEBYuEhCiUeTwET+9kd4Yc2BLx2pyMBL49rjoop4EjCJm4DNwpq9UpTjoCHGLGVDee93ZpK9HI1R06ar5TSA33KWrHPt35Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R7W2QzWI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 982992042FCC;
	Sun, 15 Dec 2024 23:26:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 982992042FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734333984;
	bh=e7OPwgujG1Ww2j6KGJH0VsSab1jwpxe1YQcQWFQ9/7U=;
	h=From:To:Cc:Subject:Date:From;
	b=R7W2QzWIukk+FHO3Qf4AqpmXRxh0R7fkIZilcIYvqXcgf2NwEbhSU81F1QKy8eoCy
	 5h8PelxOmZpvkx88vhbDQ2ryhOMc6zVq+LeAHuqwIL6lHs2n6VPdZkAdkMX+tx7rM9
	 6IiwbHTyA4VLlyu8+1sWuDQdzd4isya8puTaQaQw=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] init/Kconfig: conditionalize GCC10_NO_ARRAY_BOUNDS
Date: Sun, 15 Dec 2024 23:25:38 -0800
Message-Id: <20241216072538.33280-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC10_NO_ARRAY_BOUNDS is a GCC option and should only be enabled
if CC is GCC.

Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index c1f9eb3d5f2e8..52bb1419d6c0e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -905,7 +905,7 @@ config CC_IMPLICIT_FALLTHROUGH
 # Currently, disable gcc-10+ array-bounds globally.
 # It's still broken in gcc-13, so no upper bound yet.
 config GCC10_NO_ARRAY_BOUNDS
-	def_bool y
+	def_bool y if CC_IS_GCC
 
 config CC_NO_ARRAY_BOUNDS
 	bool

base-commit: e25c8d66f6786300b680866c0e0139981273feba
-- 
2.34.1


