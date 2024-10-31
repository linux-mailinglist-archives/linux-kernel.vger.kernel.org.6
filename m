Return-Path: <linux-kernel+bounces-389896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EC19B729D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F1F1C2209F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612213C906;
	Thu, 31 Oct 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nF/vI4jO"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA741332A1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342671; cv=none; b=j8xc86Ns+XzWn53qvsjad/uJ+xmMRDgV7rmAUJGqpMTHrsBGNRGXGuluGfc64N7l2Sly05kp3qOXcC4LrtaOCAqL+uXJn8Inx6Ql4hyxK8amwhMNCy0G69J+AcGsUNGDTyMSwnkfOauojLjv4qC0mNc86c2i/vT4OK/X7e9PYdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342671; c=relaxed/simple;
	bh=zDhPVchfMys7HnsVtwZsrXjRXhl5fZsRZ1XGARPtegE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irRIGTMkIyYO7EkPsKuMJClgQ42+q2uGgef5fpvaEKk+fs2zNf1ON5AxJhEK9EnHsTtyUboUpCxkfzDtP4Xt9KtKrKoTN9n6jM09/phoZgQ9RCBq1MJJmvi83ZkeUoRJ7gJnMWw4LJJU3DTRpoHM2/4S98I+NxN8BAzRlY12bGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nF/vI4jO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342666;
	bh=zDhPVchfMys7HnsVtwZsrXjRXhl5fZsRZ1XGARPtegE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nF/vI4jOoNK4bsUA1uXozLwZNamxvLoWdm3DBt/vN2RlE8HCKyfhj/C4NIyaC4Muf
	 ky7SIbCnrf3Bejyx+omQl03OowNEJuxhgs9LJrlcXk/b+QA6XcaswcTbWBXwpHzRlz
	 /mCL/qPDUGX3uZ3sMaef5G1nxxBKhKNv0ZNpmYTg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 31 Oct 2024 02:43:53 +0000
Subject: [PATCH RFC 04/10] nvmem: core: calculate bin_attribute size
 through bin_size()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-sysfs-const-bin_attr-v1-4-2281afa7f055@weissschuh.net>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=1407;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zDhPVchfMys7HnsVtwZsrXjRXhl5fZsRZ1XGARPtegE=;
 b=py0ESqotq+DRkCZXpG3Al8GwMMmbL12JSSs4zJ1sWJWNsihxUzqeHp+RZRJqZ56y4Qjt4o7s3
 /rn2qm/HpD1CFlbGh0xVV5ZU4SqbtQ1lGCf0HRhxROhOYJB8TgqMLnH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Stop abusing the is_bin_visible() callback to calculate the attribute
size. Instead use the new, dedicated bin_size() one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/nvmem/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 33ffa2aa4c1152398ec66b8dd7b30384c5346a6e..63370c76394ee9b8d514da074779617cef67c311 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -303,11 +303,19 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
-	attr->size = nvmem->size;
-
 	return nvmem_bin_attr_get_umode(nvmem);
 }
 
+static size_t nvmem_bin_attr_size(struct kobject *kobj,
+				  const struct bin_attribute *attr,
+				  int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+	return nvmem->size;
+}
+
 static umode_t nvmem_attr_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int i)
 {
@@ -383,6 +391,7 @@ static const struct attribute_group nvmem_bin_group = {
 	.bin_attrs	= nvmem_bin_attributes,
 	.attrs		= nvmem_attrs,
 	.is_bin_visible = nvmem_bin_attr_is_visible,
+	.bin_size	= nvmem_bin_attr_size,
 	.is_visible	= nvmem_attr_is_visible,
 };
 

-- 
2.47.0


