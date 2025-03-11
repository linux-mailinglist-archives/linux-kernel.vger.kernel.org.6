Return-Path: <linux-kernel+bounces-556083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A1A5C08A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DAE7A7487
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDEB25A2A4;
	Tue, 11 Mar 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyq43f0q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39CF259C83
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695371; cv=none; b=E346DetecZ6tupAifCj9rfH90o1fJJzs1oxmmoWBJAv35j7dSY74jFPpDNrAnm0AJlHhuzEdeR2KxtGLmSZmz8CyX0RUF2oPDE0R+9OI9qVZC9iKKkn9RY+A8kh547H+k5KEplC4qJCo/j3vBiA9pvgG2/kvT44Q9vHGY/qF0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695371; c=relaxed/simple;
	bh=fRHs3Ff/W5kbzg5bD6e6vpqb2FQAcxBWnsIFeimddFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxHM+iWrGr49DbRfkLJnCAPQKNdZ3gsV8lFYYzlC7Yk+akZ1/1VhMe3KfigEsGwQBcbnqPDXcUWOHthE7/3G+AKqv2AegTBcR5qnxDBxCOmg83SXUFU4NyNdGqCPXs6vcL4egpjDJdMo0TkIO/lwJOkYvP+xh4WdNW5BsyV47wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyq43f0q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741695368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e09hgAlOvONQaqsisKrmeO4/k1qVQ0bCEc0kyllMp+M=;
	b=dyq43f0qMglRoeF39GB9a6/ndkq0QcUYLCYVRWNM3sjCseUwu0bNupiCniYjlK1n0dVMpl
	BN9L4qaiC/BoVk0gREKH57S0W9OtBDYU+qo0xQ9b7242q6hyOqt97XUKQVTIDozg3UD0pt
	Vw1y6/nbjRRctgM2obAS3jyxPoDnxGc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-LOPHxXFpN_CQvU1-ymhR6g-1; Tue,
 11 Mar 2025 08:16:05 -0400
X-MC-Unique: LOPHxXFpN_CQvU1-ymhR6g-1
X-Mimecast-MFC-AGG-ID: LOPHxXFpN_CQvU1-ymhR6g_1741695364
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCDD01800361;
	Tue, 11 Mar 2025 12:16:03 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DC71180094A;
	Tue, 11 Mar 2025 12:16:01 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/4] Documentation/rtla: Fix typo in common_timerlat_description.rst
Date: Tue, 11 Mar 2025 12:49:35 +0100
Message-ID: <20250311114936.148012-4-tglozar@redhat.com>
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

Fix "it enable" to "it enables".

Fixes: 29380d4055e5 ("rtla: Add rtla timerlat documentation")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_description.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_timerlat_description.rst b/Documentation/tools/rtla/common_timerlat_description.rst
index 321201cb8597..8cd3e717baa8 100644
--- a/Documentation/tools/rtla/common_timerlat_description.rst
+++ b/Documentation/tools/rtla/common_timerlat_description.rst
@@ -6,5 +6,5 @@ debugging of operating system timer latency.
 
 The *timerlat* tracer outputs information in two ways. It periodically
 prints the timer latency at the timer *IRQ* handler and the *Thread*
-handler. It also enable the trace of the most relevant information via
+handler. It also enables the trace of the most relevant information via
 **osnoise:** tracepoints.
-- 
2.48.1


