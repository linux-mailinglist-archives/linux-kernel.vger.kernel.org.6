Return-Path: <linux-kernel+bounces-556082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E8A5C0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A107C3A733D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45012258CFC;
	Tue, 11 Mar 2025 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SceEL864"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005E2586CE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695367; cv=none; b=m8Vk6bbzcPG9CH2Yg3jbV9lnpJQifCpDCl6e4CYalT2HcQnloFbzYE2UrOHcujm7kG0w9Ay/mCJiFWwbwodCPKBO4TJqsQO9Qc+Y3DE//6u05/0u18YFsSkbtEKIgLG0om10IW4wNo+sg/qEUR7DCdFw45Tu9TicJj7RmK8oktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695367; c=relaxed/simple;
	bh=g/7/Pp470FP6TgvwycWV0eB4gqoj4CMPEawr7QEOXdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuJzdvAle91ckYMBwZGWCKGZZnlOENpQOuIrNldPsz8wxl81XEuDQMq4WEJNr7NYjGzgMpAx6p857x/uafGD6v6bH/klE3Q/t6FKOtYtJ9Vp6HzTOz9uBnVywXfj393LCUAPgbQMGWF6e1vQoBJU8qtbbpwA33pelEzD+3RuFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SceEL864; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741695365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q00eFPM3hzXmp5e1a+Kka7caZYWvITiN2SgftwFNp7I=;
	b=SceEL8643lzgfe5UNnYbYz1eQLDersf8yvlM2jyuKtKGkUtetCKqdN3oDmAvkwgY1/haZB
	bYIDU5AUx1FAErelgZIfMRKsgDYLmG0U/eUUXET3NlOmupv/tuPBNW1ZJ42owLM3RpYk0E
	xvMWzQOfGnSJ4GgMICoIyupVVpQyN38=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-SFvWvBGfO_OUsVZznUwA0A-1; Tue,
 11 Mar 2025 08:16:02 -0400
X-MC-Unique: SFvWvBGfO_OUsVZznUwA0A-1
X-Mimecast-MFC-AGG-ID: SFvWvBGfO_OUsVZznUwA0A_1741695361
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 171E7180035C;
	Tue, 11 Mar 2025 12:16:01 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B46B71801751;
	Tue, 11 Mar 2025 12:15:58 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/4] Documentation/rtla: Fix typo in rtla-timerlat.rst
Date: Tue, 11 Mar 2025 12:49:34 +0100
Message-ID: <20250311114936.148012-3-tglozar@redhat.com>
In-Reply-To: <20250311114936.148012-1-tglozar@redhat.com>
References: <20250311114936.148012-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The file says "rtla hist hist mode" instead of "rtla timerlat hist
mode".

Fix the typo.

Fixes: 29380d4055e5 ("rtla: Add rtla timerlat documentation")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/rtla-timerlat.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
index b334fb00ba0e..20e2d259467f 100644
--- a/Documentation/tools/rtla/rtla-timerlat.rst
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -17,9 +17,9 @@ DESCRIPTION
 .. include:: common_timerlat_description.rst
 
 The **rtla timerlat top** mode displays a summary of the periodic output
-from the *timerlat* tracer. The **rtla hist hist** mode displays a histogram
-of each tracer event occurrence. For further details, please refer to the
-respective man page.
+from the *timerlat* tracer. The **rtla timerlat hist** mode displays
+a histogram of each tracer event occurrence. For further details, please
+refer to the respective man page.
 
 MODES
 =====
-- 
2.48.1


