Return-Path: <linux-kernel+bounces-560797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F544A60998
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EDA19C4325
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425741C84C6;
	Fri, 14 Mar 2025 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvAxt0s4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD91C6FFB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936289; cv=none; b=I7u93Alm8AEgACO5KVCJqFBtUASSpJiBz87a+gvAl9oQ7vyl52bIZ8MySbrumLhGaO6TS+uTVfW4qOG+DuLqZThRpsrdvEcRuKOrILEiR/SzPm8ZHkUnCsafvTZUKVc6kyw3693V43FDpR8LkT/zGJ8bfm5QXr8ApttzXzT3Ap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936289; c=relaxed/simple;
	bh=o55pFbBKeqxHD3b1soefSqCbVwHw+HVgiSowtWeRh64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orXT0bnwMij6xCBIbgRatg3K46X+Hftukb16vXR3QitK9CKeICInKy35DWxCac6kCfwixJmQPgAn1RQd/FT3gDiIXUUFqHFToeVUqUmLcmGWAcq3SyQkWaGT43hY0bw9Ub58jU5pObYBAPz9Q27lmxaNQlhpn+k2m5inYC1Q5XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvAxt0s4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=te21+39xFgtn/zFXnP7rS+Zhsxf884DXL+6Yn2+hEu0=;
	b=MvAxt0s4BI19/4f8RhtZXY3/KGhMegTKPTZ3TfmuEnuZ4TkJSddHS264F4M1OoxpJzk9LD
	bdKz17lDvpU9CmkTZIU6BBA8rq3QXjOW91f7KG3SvQfpZzeunU8bg7Xz8yZmUYfs64IdsF
	CptU4LroLvrt15IzQJ3wGCeoR7HXGVs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-ejkJSGnZNk6h1TntptULXw-1; Fri,
 14 Mar 2025 03:11:22 -0400
X-MC-Unique: ejkJSGnZNk6h1TntptULXw-1
X-Mimecast-MFC-AGG-ID: ejkJSGnZNk6h1TntptULXw_1741936281
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC63D1809CA6;
	Fri, 14 Mar 2025 07:11:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D89E218001D4;
	Fri, 14 Mar 2025 07:11:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	linux-hexagon@vger.kernel.org
Subject: [PATCH 12/41] hexagon: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:43 +0100
Message-ID: <20250314071013.1575167-13-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/hexagon/include/uapi/asm/registers.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/uapi/asm/registers.h b/arch/hexagon/include/uapi/asm/registers.h
index d51270f3b3582..8f73d41651e87 100644
--- a/arch/hexagon/include/uapi/asm/registers.h
+++ b/arch/hexagon/include/uapi/asm/registers.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_REGISTERS_H
 #define _ASM_REGISTERS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*  See kernel/entry.S for further documentation.  */
 
@@ -224,6 +224,6 @@ struct pt_regs {
 	(regs)->hvmer.vmest = (HVM_VMEST_UM_MSK << HVM_VMEST_UM_SFT) \
 			    | (HVM_VMEST_IE_MSK << HVM_VMEST_IE_SFT)
 
-#endif  /*  ifndef __ASSEMBLY  */
+#endif  /*  ifndef __ASSEMBLER__  */
 
 #endif
-- 
2.48.1


