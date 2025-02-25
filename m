Return-Path: <linux-kernel+bounces-530587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62B5A43565
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFF13A6624
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB52256C9F;
	Tue, 25 Feb 2025 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QjV336V8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300A254AE0;
	Tue, 25 Feb 2025 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465422; cv=none; b=VnMxBRfMtLMcgdoX99UCI4L/0Y00shcPy8gwhnyMnE2AELaXizNiMpoYhLN4K9Hwc9yrLIte3CDidBNqe9ZKm9JnolfVy4vO4hazBMKQ7Vm2i+HimNQSEePL14BJX22BPrVyujUf2YTTf5fjO4dA73dHc3Ci9JK+YGB9hpfLayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465422; c=relaxed/simple;
	bh=zmf1BVxC0a6BVEtBTXrRMRPg+UxzEgS6AlCS1ZVuRak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mubv/apBKz2HvEYmO5bGsk5ORtiTUGQOGjXgVT25DqyndDtbE866FURL5Eyfo/7MevYVNcX+9lSYH9amNWNe7X5YEQHa91auOXDvQpbE0RaMVwENDaMKQDxtQngQwu3uCGmrt+843/2NoZhIWr49ap4w941J0t2DcUDgbt0MFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QjV336V8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E8DC4CEDD;
	Tue, 25 Feb 2025 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740465421;
	bh=zmf1BVxC0a6BVEtBTXrRMRPg+UxzEgS6AlCS1ZVuRak=;
	h=From:To:Cc:Subject:Date:From;
	b=QjV336V8aed5lDhxO8cUVwtntyqcr17IdLVODRAxYbp5v0JuOgK8HNvnfJoLuNsgJ
	 MCOay4oN3xUHGXEkDW0fY5sHQzmfiRd6ucGVUxVEfJHS6VFjKW01SbodTNfWRcKmDO
	 fZ3YaQVXCqoX37tiMqRMWXTkz9OQuW4O2HsVLrTM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kurt Borja <kuurtb@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] driver core: faux: only create the device if probe() succeeds
Date: Tue, 25 Feb 2025 07:35:46 +0100
Message-ID: <2025022545-unroasted-common-fa0e@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 49
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=zmf1BVxC0a6BVEtBTXrRMRPg+UxzEgS6AlCS1ZVuRak=; b=owGbwMvMwCRo6H6F97bub03G02pJDOl7Uw6K3Fzz7VTbLGv5pMb4N2HeLG6Guunf5xyfzf5L8 u7vC/rLOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi+4IY5qk0/3imaHw2IjNX ZIcl+zKdxhghO4b52Z9PZcbIWp4z3xq3PWxJ8HqvsrefAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

It's really hard to know if a faux device properly passes the callback
to probe() without having to poke around in the faux_device structure
and then clean up.  Instead of having to have every user of the api do
this logic, just do it in the faux device core itself.

This makes the use of a custom probe() callback for a faux device much
simpler overall.

Suggested-by: Kurt Borja <kuurtb@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/faux.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 531e9d789ee0..407c1d1aad50 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -102,7 +102,9 @@ static void faux_device_release(struct device *dev)
  *
  * Note, when this function is called, the functions specified in struct
  * faux_ops can be called before the function returns, so be prepared for
- * everything to be properly initialized before that point in time.
+ * everything to be properly initialized before that point in time.  If the
+ * probe callback (if one is present) does NOT succeed, the creation of the
+ * device will fail and NULL will be returned.
  *
  * Return:
  * * NULL if an error happened with creating the device
@@ -147,6 +149,17 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 		return NULL;
 	}
 
+	/*
+	 * Verify that we did bind the driver to the device (i.e. probe worked),
+	 * if not, let's fail the creation as trying to guess if probe was
+	 * successful is almost impossible to determine by the caller.
+	 */
+	if (!dev->driver) {
+		dev_err(dev, "probe did not succeed, tearing down the device\n");
+		faux_device_destroy(faux_dev);
+		faux_dev = NULL;
+	}
+
 	return faux_dev;
 }
 EXPORT_SYMBOL_GPL(faux_device_create_with_groups);

