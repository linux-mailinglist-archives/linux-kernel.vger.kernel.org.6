Return-Path: <linux-kernel+bounces-216724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA2590A50A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9374B28A7B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E90118629E;
	Mon, 17 Jun 2024 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4foI/jl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979B18628A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604547; cv=none; b=kAyBX81gHmQaXrDabbhUGfC+8haCjT7nmlUCFA2SqZHBPVpXvA2A5EaUdbNRbSxX0OoXtJkCa7I1sy1lxIAZ3pxHIxWf4If0dyo5AlMJ89b+gUMOUJF3a2yOyybUvv0PzNQEJCXYNLg/2A4StF7J8+sZ8fwtD18xXnKkcR9PubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604547; c=relaxed/simple;
	bh=hDS17+qsNPNNXUV82rej7BO7Xc0Qy2N2DhSjAXLBNYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Db36TYeoFEF4GG+U6XnEyYafAHd3cP1qIq7DYzopJ4+lCNh2glALvX7NuByMKUessPbBNu0I69CSwn8dQaQ+yv/7frW15ZH6OZTJyPURoNAAsP19PDJFzsPQPnAq+STQUvlEhJ6MA2a4IB9JA7N9cbE3av7zhh9Ksf5uflSZqr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4foI/jl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718604544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SJWLUmdGlAVRxpPGtNzAhFQ8b0B895zkZS1r5Cdi/us=;
	b=Z4foI/jlh90SlHjmC7i/ciYRabOR/Kq0gJRe6vnZUu4xtuXkqbrNZFARfPQPKnIlbuUbwU
	AnGSwjV74WRqOZ551ybOYkn52apXDlX1mjN0XOLZfTahe9YeiPz0D+S3SoPjuumbCfDXVM
	DJD4VG2TBz9ffqMPc83jcZuCgKxK+ag=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-j0aGtohiNXCPdVwPt9CADA-1; Mon,
 17 Jun 2024 02:08:58 -0400
X-MC-Unique: j0aGtohiNXCPdVwPt9CADA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2232419560AA;
	Mon, 17 Jun 2024 06:08:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.120])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DA9919560B2;
	Mon, 17 Jun 2024 06:08:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-doc@vger.kernel.org,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Subject: [PATCH] Documentation: Remove the unused "topology_updates" from kernel-parameters.txt
Date: Mon, 17 Jun 2024 08:08:48 +0200
Message-ID: <20240617060848.38937-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The "topology_updates" switch has been removed four years ago in commit
c30f931e891e ("powerpc/numa: remove ability to enable topology updates"),
so let's remove this from the documentation, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f58001338860..b75852f1a789 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6600,12 +6600,6 @@
 			e.g. base its process migration decisions on it.
 			Default is on.
 
-	topology_updates= [KNL, PPC, NUMA]
-			Format: {off}
-			Specify if the kernel should ignore (off)
-			topology updates sent by the hypervisor to this
-			LPAR.
-
 	torture.disable_onoff_at_boot= [KNL]
 			Prevent the CPU-hotplug component of torturing
 			until after init has spawned.
-- 
2.45.2


