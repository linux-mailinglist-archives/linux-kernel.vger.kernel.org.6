Return-Path: <linux-kernel+bounces-566656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE6A67ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3309E19C3173
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640EC2116F7;
	Tue, 18 Mar 2025 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="H5N4r0lr"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DB1D8A16
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318678; cv=none; b=JT32SSWhcdzNnhgm6eJegIa30VQBALM5+EUT+L+rnihOc25By2KMhZDGFddllcgyAyvGuGFZJSoSrF0ANB/GJ8ueOysa5+5EaJm+vPtOIl0xFE1ycAXeWODYCWScGOUwLMqmeiex1M6yu++DTeP9nJoTOEOgdCoia5r6u0/uU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318678; c=relaxed/simple;
	bh=puQWqXKZUZWydEqrwSNmh1bgOWVgNZ7m05mFyOV4z8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADGljUYxb0YIiBg+yO5Ecu0m2nIwJ7wNC1Pm+lEJfgun75DifpLMAqPqUMF9ZL4+/HhmzB1N9ndX0HRJt6CCc6ouBZMeVBsXOmocNKifISrnk1yTmhgDhVzLZRDovFiimBUPEiHbpx8nl4FsbQKt1anTb387y/BzWS5rTscWpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=H5N4r0lr; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8PPMTqFnHWaluWgAu7vm2qVJC0SfqKqu9UInCp27HcE=; b=H5N4r0lrNdFOYBz4LHGQg2EVYl
	/coJvCy4xe/cJqXnW3HwnISTKY4YPZkKXuJqxlEMJqemudluvCSCBEhLDYbgP7k2YtIhZeEJk2CqD
	EqLPiKWH3Gna869L2old5QoF674DKYxXVl5H/XsSUbUPgzrKMJMRJm0oXV9F3kkYEoFyC2yZaEz+t
	KA4O6iKTg3XcQAgN2oBufakbYGsUfo7wJr2RV79GkO8norViDFlbJmS/MLyI7ribtplOz1EhVzPjY
	PXctJdgqxrxTIYyMzfteirwVYENf6VyI9TmF8hESud7yW1g6Jlik5lfMFQ6V938SZJP0iw0HTNEbG
	k8oEunoA==;
Received: from 179-125-64-250-dinamico.pombonet.net.br ([179.125.64.250] helo=[192.168.67.187])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tuafx-002qwX-4s; Tue, 18 Mar 2025 18:24:25 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Tue, 18 Mar 2025 14:24:18 -0300
Subject: [PATCH v3 1/2] char: misc: restrict the dynamic range to exclude
 reserved minors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-misc-dynrange-v3-1-5c6507cbc2e2@igalia.com>
References: <20250318-misc-dynrange-v3-0-5c6507cbc2e2@igalia.com>
In-Reply-To: <20250318-misc-dynrange-v3-0-5c6507cbc2e2@igalia.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>, 
 Vimal Agrawal <vimal.agrawal@sophos.com>, linux-kernel@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.14.2

When this was first reported [1], the possibility of having sufficient
number of dynamic misc devices was theoretical, in the case of dlm driver.
In practice, its userspace never created more than one device.

What we know from commit ab760791c0cf ("char: misc: Increase the maximum
number of dynamic misc devices to 1048448"), is that the miscdevice
interface has been used for allocating more than the single-shot devices it
was designed for. And it is not only coresight_tmc, but many other drivers
are able to create multiple devices.

On systems like the ones described in the above commit, it is certain that
the dynamic allocation will allocate certain reserved minor numbers,
leading to failures when a later driver tries to claim its reserved number.

Instead of excluding the historically statically allocated range from
dynamic allocation, restrict the latter to minors above 255. That also
removes the need for DYNAMIC_MINORS and the convolution in allocating minor
numbers, simplifying the code.

Since commit ab760791c0cf ("char: misc: Increase the maximum number of
dynamic misc devices to 1048448") has been applied, such range is already
possible. And given such devices already need to be dynamically created,
there should be no systems where this might become a problem.

[1] https://lore.kernel.org/all/1257813017-28598-3-git-send-email-cascardo@holoscopio.com/

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/char/misc.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index dda466f9181acf76564b5e41ed6e858928e56182..d5accc10a110098f7090dd0f900bc5fae5f75f74 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -58,9 +58,8 @@ static LIST_HEAD(misc_list);
 static DEFINE_MUTEX(misc_mtx);
 
 /*
- * Assigned numbers, used for dynamic minors
+ * Assigned numbers.
  */
-#define DYNAMIC_MINORS 128 /* like dynamic majors */
 static DEFINE_IDA(misc_minors_ida);
 
 static int misc_minor_alloc(int minor)
@@ -69,34 +68,17 @@ static int misc_minor_alloc(int minor)
 
 	if (minor == MISC_DYNAMIC_MINOR) {
 		/* allocate free id */
-		ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
-		if (ret >= 0) {
-			ret = DYNAMIC_MINORS - ret - 1;
-		} else {
-			ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
-					      MINORMASK, GFP_KERNEL);
-		}
+		ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
+				      MINORMASK, GFP_KERNEL);
 	} else {
-		/* specific minor, check if it is in dynamic or misc dynamic range  */
-		if (minor < DYNAMIC_MINORS) {
-			minor = DYNAMIC_MINORS - minor - 1;
-			ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
-		} else if (minor > MISC_DYNAMIC_MINOR) {
-			ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
-		} else {
-			/* case of non-dynamic minors, no need to allocate id */
-			ret = 0;
-		}
+		ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
 	}
 	return ret;
 }
 
 static void misc_minor_free(int minor)
 {
-	if (minor < DYNAMIC_MINORS)
-		ida_free(&misc_minors_ida, DYNAMIC_MINORS - minor - 1);
-	else if (minor > MISC_DYNAMIC_MINOR)
-		ida_free(&misc_minors_ida, minor);
+	ida_free(&misc_minors_ida, minor);
 }
 
 #ifdef CONFIG_PROC_FS

-- 
2.47.2


