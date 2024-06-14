Return-Path: <linux-kernel+bounces-214578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B19086B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FE11C2264A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BB919147A;
	Fri, 14 Jun 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL5n5S2u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034B190667
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354809; cv=none; b=aGSIcveTjyQWIvs37Tk4g5jh3YQ0UEdOaJILJmEF8DJpe2m1cFdg9XHY/2zsXPQZkw7+IgjXZTO00tHLfVFf8BsAVF7bB6FUCxqxphMwgJpXaeI1Y2tGHMyA3c6Sp30iWBD8nnV5haKbqdQj6tORVXx90gt2hTXYE5PyHhKDLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354809; c=relaxed/simple;
	bh=qNoQFmqsQmMD+5AhPYE6VqPgaswfpIH8+ACcFxL/gLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1H58pJCwOmRSWlfEXnFu27zvIpUqXiM5Mks1UUgPqiaNOc931Gr2FPEnKMD987yYCJyQseb91ognleWv9HzzAmmm8dzkiDRNk9bq7D4XyKdfD1hcIAPxiiE+CMh/NOodqCqB54oOcxtkPYz+y+2h9Kzu34AG+bvij3EoIeB+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iL5n5S2u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718354807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8utKZ9NbJQXHi/9loh5+wQeBJ6pZphNl5y/Zt++GLds=;
	b=iL5n5S2uQVWF4Lh08bBt+SPjwiqxX5HkrV7D8A1e/J/BuNPWFwAwA76DqM53i9cLe8tv2k
	hCYwoSH72WFH/HLUaTPgRdugbsv5+FSFJ2y7osDC1RITYKI/qZObYGq8jKK1QxrH/nj7nN
	nXQr7o49r2MrorLDbdiqJBv4BW8oTiU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-bVL9uVtgNOSUB7oqBjhZ8g-1; Fri,
 14 Jun 2024 04:46:41 -0400
X-MC-Unique: bVL9uVtgNOSUB7oqBjhZ8g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31E6219560AB;
	Fri, 14 Jun 2024 08:46:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.73])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A734A1956050;
	Fri, 14 Jun 2024 08:46:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation: Remove "ltpc=" from the kernel-parameters.txt
Date: Fri, 14 Jun 2024 10:46:33 +0200
Message-ID: <20240614084633.560069-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The string "ltpc" cannot be found in the source code anymore. This
kernel parameter likely belonged to the LocalTalk PC card module
which has been removed in commit 03dcb90dbf62 ("net: appletalk:
remove Apple/Farallon LocalTalk PC support"), so we should remove
it from kernel-parameters.txt now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 423427bf6e49..a9b905bbc8ca 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3184,9 +3184,6 @@
 			unlikely, in the extreme case this might damage your
 			hardware.
 
-	ltpc=		[NET]
-			Format: <io>,<irq>,<dma>
-
 	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
 
 	lsm=lsm1,...,lsmN
-- 
2.45.2


