Return-Path: <linux-kernel+bounces-546614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAFCA4FCD0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C81E16CE2E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678AE2147FD;
	Wed,  5 Mar 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wbSRnUMx"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1844820E009
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171970; cv=none; b=g3sAUq8RTkDp1M9xup7iuJ/i9DVmYyUChZMJoSUYBwUTK5AgYsrl8RH3Q+G8a3p1z2oaDKiVDf5yb5OHQnqyH43t3NlFqPNYg1FcVedsrc9dwGp+6HEEgR6Jcy0PnRqMwklmywNJ/k1Iaom3o3DZHRktYcbNbqL0peY80q94AnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171970; c=relaxed/simple;
	bh=w7lqIxbMOb/XZMjCMxUDe380EqScfIsQ4WtaSXtSzok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZI//Mgq6aEDMBcvfKOvGJawnli/9SMODeFe1+jP6gWHg5KqTSIkgXrjG9UdMmYu4oULExbeOKsOIYVEuN2kLK5uCemKMKVgRoqzgMIy2g0sIs9/h6NdMgsZPOX36NhIyXpHJkQgCp5RROR0CC/3yUpCguX4VFWoHhrYHW29tAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=wbSRnUMx; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from cap.home.8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9150D446D1;
	Wed,  5 Mar 2025 11:52:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741171966;
	bh=w7lqIxbMOb/XZMjCMxUDe380EqScfIsQ4WtaSXtSzok=;
	h=From:To:Cc:Subject:Date:From;
	b=wbSRnUMxhlJ4wZM6aIMq/n3rSXAfPkQvGbsRSYa8TG3aePC1Q/jTsWDobEXu+w5fi
	 R7p+/h7XPGhmwzIR5boPIzraeQUhnC6mFDrdO7N64lhtH+FW5yjO2Qhdjm4aEU6PYY
	 CWkAWoVEbP/lhZxWqfIUpxuKh5ubFFHvd+AGr28FwjER7xPeecVHgY147zGZ1upG41
	 f3GcDsVjN3rggAL2j0gegA9ubZdeofvHseJ8qGL27Ef8u81xQ0jgCM0ls47dxZ4Ogq
	 GolwBvUT85GfqkzxVuj/xnBvOKS6A9SSi9BdLXf7udHyB4cuGWQeuNPrR9SlRCRt7B
	 twwvRW0yvztvQ==
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Cc: hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Date: Wed,  5 Mar 2025 11:52:34 +0100
Message-ID: <20250305105234.235553-1-joro@8bytes.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

Current user-space tooling which needs access to the SEV_STATUS MSR is
using the MSR module. The use of this module poses a security risk in
any trusted execution environment and is generally discouraged.

Instead, provide an file in SYSFS in the already existing
/sys/devices/system/cpu/sev/ directory to provide the value of the
SEV_STATUS MSR to user-space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/coco/sev/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492efc5d94..7b23fb803610 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2678,10 +2678,19 @@ static ssize_t vmpl_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", snp_vmpl);
 }
 
+static ssize_t sev_status_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llx\n", sev_status);
+}
+
 static struct kobj_attribute vmpl_attr = __ATTR_RO(vmpl);
+static struct kobj_attribute sev_status_attr = __ATTR_RO(sev_status);
+
 
 static struct attribute *vmpl_attrs[] = {
 	&vmpl_attr.attr,
+	&sev_status_attr.attr,
 	NULL
 };
 
-- 
2.48.1


