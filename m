Return-Path: <linux-kernel+bounces-366633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5737299F807
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39111F225B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FFD1F76C1;
	Tue, 15 Oct 2024 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cEEtw6bH"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ECB1F583C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023739; cv=none; b=jNRF1UH1sqgeW4B5COSJwOurJLhlYxsjP+cMmJtN4HUYpmE1heQzH0coBSfll8qoRq44qR9UKXCxRzSvnvqWR96JG3zI6Q9S59apuTDYSFmvWP3ALzkC7BA/DFyI/8l3A/mMpNPOESlSHPqyCS1BDz+5i7QrG0n4xAX1gItqg18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023739; c=relaxed/simple;
	bh=MruDsXSYs5epqdQoFkPCxcb0C0OECF7EAfkLF0bkjWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PiqLapVqC3vTcRFSHVEY48C3GXLxBsRArJGF9r06hgQAu+b5LU+2KI5hdn9hqaPzpnGtmQZ0jYP6jtaI061wxMzRFKoM+rTFZGRz5cAZShg6NkT0m17W5HRpMdHzD05WWK8EkJaKcibTHIJTof4hswDSBpwJmTybJQknS9ZzllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cEEtw6bH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729023734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UkOp2VFzKqR5KSM9GrNp9rbVyhtVjE3dDi0NiICiOVU=;
	b=cEEtw6bHLG1T90jYEJQ9gM40BGGSy+VbmAtf4dFSf/fhP1SFZ6fGv5DoOPJskjvmkXHC2r
	zFJGQ4zHu/wxzfS7dWTBfYdvCmcODzG76qUG0On0QYfeBslhMeXVphbzRYYKZNtYi/FihS
	XofFQ1scTcy8NWvepZ0MfvxZRlEYKQI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jan Kara <jack@suse.cz>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] acl: Realign struct posix_acl to save 8 bytes
Date: Tue, 15 Oct 2024 22:21:54 +0200
Message-ID: <20241015202158.2376-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Reduce posix_acl's struct size by 8 bytes by realigning its members.

Cc: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/posix_acl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 0e65b3d634d9..2d6a4badd306 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -28,8 +28,8 @@ struct posix_acl_entry {
 
 struct posix_acl {
 	refcount_t		a_refcount;
-	struct rcu_head		a_rcu;
 	unsigned int		a_count;
+	struct rcu_head		a_rcu;
 	struct posix_acl_entry	a_entries[];
 };
 
-- 
2.47.0


