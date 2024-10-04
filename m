Return-Path: <linux-kernel+bounces-350202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D5699016D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD5BB2810F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54E14EC5B;
	Fri,  4 Oct 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ev3e1w6G"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997014AD3F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038113; cv=none; b=eYXiVSkII3b2DpNAgM6jlGekGcwHvMSPsamcGAyS/wpggTRpVoADjCbnGwS7ENpaUZmwe/Sl9dAH2OmyeIghMUZ+HaX0rQymnUltIvk9/SC4I86DAysmzyOWSxR2ljNrHbQ6r9L0bHRGLctSGaTbfJ6aCv/zpgRNx2//yybuLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038113; c=relaxed/simple;
	bh=SuF/CKg4ArRFGzpN9GbluKCZT8Lb3br4emItDvkolTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lY+31MvCU+Odc32yXyQGDLpmsQNavJlmp5zuAz9WgaqpDG4Xn0C1cpKowO4z7BHBb91VqCdwtb8cr/OaaWyzwTYbSrCIVphCVqLLFstkfvdRRbvfs1i54WXMRQr4fZOe2KhAVaeZsy0rzhOd+6ZG981NZTSaHY6ytafTHYpPcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ev3e1w6G; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728038105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mTAiB8+ZVj0RLS2l7wtRzh1RE6CNPyuyxF0o+AKlZOg=;
	b=ev3e1w6GM4potEi+8XUeQ14W1vtbCjfiAQbLF5uqFB1pRD+NNab+6PsehNXT1pdjRj9rZu
	mZIRFBrB44SWu418Kw1VlH+7hQThH5u/BVXmbLgJ/e35VwYv78eBaC33Se6tLUGBgC5wcL
	lxdNqsYS5goqxEMMpQdOaibkfQsgr+M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] acl: Realign struct posix_acl to reduce its size by 8 bytes
Date: Fri,  4 Oct 2024 12:33:57 +0200
Message-ID: <20241004103401.38579-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Reduce posix_acl's struct size by 8 bytes by realigning its members.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/posix_acl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 83b2c5fba1d9..e2d47eb1a7f3 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -28,8 +28,8 @@ struct posix_acl_entry {
 
 struct posix_acl {
 	refcount_t		a_refcount;
-	struct rcu_head		a_rcu;
 	unsigned int		a_count;
+	struct rcu_head		a_rcu;
 	struct posix_acl_entry	a_entries[] __counted_by(a_count);
 };
 
-- 
2.46.2


