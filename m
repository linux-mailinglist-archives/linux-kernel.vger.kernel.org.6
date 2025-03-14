Return-Path: <linux-kernel+bounces-560829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C42A609DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C017ECAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D5B1FCCF9;
	Fri, 14 Mar 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha4z8w8I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D41FC7DF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936411; cv=none; b=rkxmVp682xAIAmYuEpEpD3hjxfprHeJgUgbP/79Y74dDwjUKVq1gefM/xlVKkRSKHq2o5tNU1aw01ZQpkOTTqNmNfemqoWMqlKM1ThKnctFcwdFcr/qwluDeOGOeHV2eWggo6+yLd9DDpM7uIrGJvgtaY4dA3YfyQliX685CglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936411; c=relaxed/simple;
	bh=NScUTvqdEVdw4ot7XhAHJw0HPUofLS8V64DuTYSuLuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWeUEAKzpy/Et7uRJh0eAMyl5BN6L8gT/TbmVii7IvzrLUzjfJGAFY28fej+rL6OR89Dq4pkz7Plb+yXP8ewMbvJeJRx+h6aoT0Ng2iqu/RQtEo8GOhxMyihdS9VFeMLgSyRSD2BU4l/BPH1PuhTardWCeaW3B+v/pckvOIA6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ha4z8w8I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJA/vIQPU2sfCgCaSqOtMt76smC5XY61sR3OGsGoH+M=;
	b=ha4z8w8IovkQoHv7marKL5zHibs+BDbvkN3IKe8a9sZ2kkdbLf2cF1OcIHZSk09cDzxKRC
	E2rR9nLEnC6DKfDw2Nsrt7OWHmKV2M73K4Ke78hX/OMYqhNZFuQTBmOy8EgwRrGpdYG72W
	rhhzflc3TGnaKu+fOUTPtmauqT/7Tx4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-ttNDL78BM2GaAamgs_mB0Q-1; Fri,
 14 Mar 2025 03:13:21 -0400
X-MC-Unique: ttNDL78BM2GaAamgs_mB0Q-1
X-Mimecast-MFC-AGG-ID: ttNDL78BM2GaAamgs_mB0Q_1741936400
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA1601956089;
	Fri, 14 Mar 2025 07:13:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5ED318001DE;
	Fri, 14 Mar 2025 07:13:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 40/41] scripts/dtc: Update fdt.h to the latest version
Date: Fri, 14 Mar 2025 08:10:11 +0100
Message-ID: <20250314071013.1575167-41-thuth@redhat.com>
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

Update the header to this upstream version to change the
__ASSEMBLY__ macro into __ASSEMBLER__ :

https://web.git.kernel.org/pub/scm/utils/dtc/dtc.git/commit/?id=f4c53f4ebf78

Cc: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/dtc/libfdt/fdt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
index 0c91aa7f67b5b..a07abfcc71089 100644
--- a/scripts/dtc/libfdt/fdt.h
+++ b/scripts/dtc/libfdt/fdt.h
@@ -7,7 +7,7 @@
  * Copyright 2012 Kim Phillips, Freescale Semiconductor.
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct fdt_header {
 	fdt32_t magic;			 /* magic word FDT_MAGIC */
@@ -45,7 +45,7 @@ struct fdt_property {
 	char data[];
 };
 
-#endif /* !__ASSEMBLY */
+#endif /* !__ASSEMBLER__ */
 
 #define FDT_MAGIC	0xd00dfeed	/* 4: version, 4: total size */
 #define FDT_TAGSIZE	sizeof(fdt32_t)
-- 
2.48.1


