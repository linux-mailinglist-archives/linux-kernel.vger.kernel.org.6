Return-Path: <linux-kernel+bounces-514453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E6A35732
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BF516EAAE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAEE1FFC72;
	Fri, 14 Feb 2025 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/ow1BoQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D0204F66
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514932; cv=none; b=Vz2trF6HRwuej3rGXDHKM/xBz5k6NfQV1HDoYlAyKS1eoTdU04yUTkCDLCgSJmjRk+5EcqmX2IxtkOZAT8Ie/WN4iNET3hhpM5OBfn04cX/nQ8YgIE3OKyrZSUwPSGxfAzfYWqIr93XE1cLGrN6l5Yn4pM73osejSPq0zp29Wmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514932; c=relaxed/simple;
	bh=IJ6WKGaNb0TBTukUcN0vhdakTGrYmKPnJb690AYqXSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EuE/gSUkm8r7GctWGrDLl/qAzPhJbW0d7t8tqWa9xXzLePj9dAM2u2OFIzstTdgSF4vYIBOJR0E8Uwg4Hqqh9vG0GJKdD7bZMWpxGxMlYjj81FmYjo0O3rI6qpzBKL1hiIj+sq2ZJDfHwo2Vgau9aODu3C8E0C390CUH+FpQ6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/ow1BoQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739514929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sx6d6nmiay0PRStDDUNJ0RDey6GCh5MgqAtQDRntlcU=;
	b=Y/ow1BoQI1SbPV3msIvDQ+aL6RFH1hxNIIl4V+uTwG68wsI3RACz/YBnP2ecPh7dWDfIWn
	xIp0xkXx8Jx+3oEPuRQKHFDaLCHfjWCpm/2bPdRJOx1I75h7zRXzTBtUsWK2sMKlJRoXu+
	DL83IYfZzQ/cvlyLgH80B9+fx1CNJuk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-0p6vjkdQPnixM5mFpL7pcQ-1; Fri,
 14 Feb 2025 01:35:24 -0500
X-MC-Unique: 0p6vjkdQPnixM5mFpL7pcQ-1
X-Mimecast-MFC-AGG-ID: 0p6vjkdQPnixM5mFpL7pcQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DC551800877;
	Fri, 14 Feb 2025 06:35:23 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27981300018D;
	Fri, 14 Feb 2025 06:35:18 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH 1/2] drivers/base/memory: Simplify add_boot_memory_block()
Date: Fri, 14 Feb 2025 16:35:03 +1000
Message-ID: <20250214063504.617906-2-gshan@redhat.com>
In-Reply-To: <20250214063504.617906-1-gshan@redhat.com>
References: <20250214063504.617906-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

It's unnecessary to keep the variable @section_count in the function
because the device for the specific memory block will be added if
any of its memory section is present. The variable @section_count
records the number of present memory sections in the specific memory
block, which isn't needed.

Simplify the function by dropping the variable @section_count. No
functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/base/memory.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 348c5dbbfa68..208b9b544012 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -822,18 +822,17 @@ static int add_memory_block(unsigned long block_id, unsigned long state,
 
 static int __init add_boot_memory_block(unsigned long base_section_nr)
 {
-	int section_count = 0;
 	unsigned long nr;
 
 	for (nr = base_section_nr; nr < base_section_nr + sections_per_block;
-	     nr++)
-		if (present_section_nr(nr))
-			section_count++;
+	     nr++) {
+		if (present_section_nr(nr)) {
+			return add_memory_block(memory_block_id(base_section_nr),
+						MEM_ONLINE, NULL, NULL);
+		}
+	}
 
-	if (section_count == 0)
-		return 0;
-	return add_memory_block(memory_block_id(base_section_nr),
-				MEM_ONLINE, NULL,  NULL);
+	return 0;
 }
 
 static int add_hotplug_memory_block(unsigned long block_id,
-- 
2.48.1


