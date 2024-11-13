Return-Path: <linux-kernel+bounces-407155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448E99C6978
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6E1285DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073117C98C;
	Wed, 13 Nov 2024 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tFE39T5S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D92C9A;
	Wed, 13 Nov 2024 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480569; cv=none; b=FIJ92WgMRI+Q/6w+AYXbdDCMWq2fqBh9M50T2IyV4omVi8hzJ0KJztyaNEBlQDaDqhtim4lce/CoZ0rK8dLFcjCwJQ8JcGbgbPtQBcw21+C+Tr+kJZtnaSbWzp8idnoegp5KmrSyfANQG+a+BY1RUuXF7gf1KFQiBSM68kfdgp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480569; c=relaxed/simple;
	bh=vViNnuiwAtSi3uAv82vBeSDQgkaNqoZeWaQlsnzDNvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJPwbdGIlEdgJxuvXiROjhgQFhegms1ip555dnxW+Ar9+0sataAkwcZdtAOp+7SvKS4pzNExg8nx6Y/W9p1wQBS4RlWjpVlDBGTn8GWHnRNLlsZqknYlnvN0fNLa3t0WmpD5oNcjNu3kwakBN4IOlvfCTHqbInem/03GlPxBtOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tFE39T5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F68C4CED7;
	Wed, 13 Nov 2024 06:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731480568;
	bh=vViNnuiwAtSi3uAv82vBeSDQgkaNqoZeWaQlsnzDNvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFE39T5SAveICCnZvwIu57J8dciLEJe78hpFhvsPmXFOvNCwZD8Ek0YWWB4JaRuf0
	 q9ayFlZgq/ijrrZIGPFyN+RSyeWBxWmNbatreTjUb+9FqQ7S3qQgwUgnh34PGjjlUp
	 f9VrDXY8FS9+ScfTISdiwegQOzpXbeGMjanekrnc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] USB: properly lock dynamic id list when showing an id
Date: Wed, 13 Nov 2024 07:49:23 +0100
Message-ID: <2024111324-tubby-facecloth-d4a0@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111322-kindly-finalist-d247@gregkh>
References: <2024111322-kindly-finalist-d247@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 28
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=vViNnuiwAtSi3uAv82vBeSDQgkaNqoZeWaQlsnzDNvM=; b=owGbwMvMwCRo6H6F97bub03G02pJDOkm3l8E6v0+brj9pVFg58o3vf3cOjVaz3Vnf70ef4ovz WpL0aX7HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRmd0M80yXR5bfvBy0xqj0 xG+7P6+/xIS03GZYsP140uy29ZV8seUe++0Wsu1hfNUyHwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

When walking the list of dynamic ids for a driver, no lock was being
held, which meant that an id could be removed or added while the list
was being iterated.  Fix this up by properly grabing the lock while we
walk the list.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2. - new patch in v2, not in v1 series, based on review of v1.

 drivers/usb/core/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index bc3c00580238..9ea955a3d115 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -116,6 +116,7 @@ ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf)
 	struct usb_dynid *dynid;
 	size_t count = 0;
 
+	guard(mutex)(&usb_dynids_lock);
 	list_for_each_entry(dynid, &dynids->list, node)
 		if (dynid->id.bInterfaceClass != 0)
 			count += scnprintf(&buf[count], PAGE_SIZE - count, "%04x %04x %02x\n",
-- 
2.47.0


