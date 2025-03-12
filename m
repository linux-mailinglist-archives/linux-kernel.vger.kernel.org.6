Return-Path: <linux-kernel+bounces-557913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA131A5DF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8AD3B79D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0606256C99;
	Wed, 12 Mar 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="HoHVNj/I"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEE22528FC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790513; cv=none; b=AhsTublhcGVFonjeURRYmenslQIfHssVdhNgrutU8D33SkJoUClO1EtPMDrfJW7jmD/LTbS9FS617JnesrKPlaLunNgRzAuZp+cyezy2OSXQU9Ha1NMWsGDXp4gv3EtB9HJ5X0qBbjyR+ArAJ8FirC8oIXYGpL+M5zHl+v422oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790513; c=relaxed/simple;
	bh=0qIK11Nxc/qG99PcihtfUwWqc93REynnXKH4VFL31IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdGrjag70tctrQK+0G3yi4Ns+4l5w0zd1sDVvQkLiHaaJpiWJTiyWybuMX9fO99mVpzaQt5qDtoy3+BT+mTc693vvmX3ABEGWkfVAN6sf6l+4hfRwOVoI1ppXxkSaoPyCK+/u6zTlrhZuzs7khs2Hh5FiFNEhdgvbWp5OSoJv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=HoHVNj/I; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from cap.home.8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7C8AB457E8;
	Wed, 12 Mar 2025 15:41:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741790503;
	bh=0qIK11Nxc/qG99PcihtfUwWqc93REynnXKH4VFL31IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HoHVNj/IbAvBuNXjpXmXmZXhmi/mV9g31NXzx+Q8ymiP69hnKc+IMTFmtlSR7OcaM
	 ZtXOQpRSuosn2dXeWEjxB0NcIW4Nq6o/gEtvf2HlAYMUuy14ZbQn7M2q6Pma82s8ML
	 65/qsWECVTDUw8hFjewyv9iNMoAjH+dvO98mQOXxemny9oelR+0fTEqmYJzWNkky9J
	 8EGBIBN6nppdcsdXQqJW1PJqlwGM6riy9e+GvAg4VTtzDWTiarRmaWO+4meYLT73Tz
	 Chd9fB+OaiKp99CKAMdYGZ2aKQmB+CLbtJI1pWlDV5Q24BD9vVkoKaRqq/hZb2gYpe
	 CeFcDthvl4zSQ==
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Cc: hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Larry.Dewey@amd.com,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	kirill.shutemov@linux.intel.com,
	alexey.gladkov@intel.com,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 2/2] x86/sev: Make SEV_STATUS available via SYSFS
Date: Wed, 12 Mar 2025 15:41:07 +0100
Message-ID: <20250312144107.108451-3-joro@8bytes.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144107.108451-1-joro@8bytes.org>
References: <20250312144107.108451-1-joro@8bytes.org>
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

Instead, provide an file in SYSFS in the /sys/hypervisor/sev/
directory to provide the value of the SEV_STATUS MSR to user-space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 Documentation/ABI/testing/sysfs-hypervisor | 5 +++++
 arch/x86/coco/sev/core.c                   | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-hypervisor b/Documentation/ABI/testing/sysfs-hypervisor
index aca8b02c878c..54c80899c19c 100644
--- a/Documentation/ABI/testing/sysfs-hypervisor
+++ b/Documentation/ABI/testing/sysfs-hypervisor
@@ -1,5 +1,6 @@
 What:		/sys/devices/system/cpu/sev
 		/sys/devices/system/cpu/sev/vmpl
+		/sys/devices/system/cpu/sev/sev_status
 Date:		May 2024
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Secure Encrypted Virtualization (SEV) information
@@ -8,3 +9,7 @@ Description:	Secure Encrypted Virtualization (SEV) information
 
 		vmpl: Reports the Virtual Machine Privilege Level (VMPL) at which
 		      the SEV-SNP guest is running.
+
+		sev_status: Reports the value of the SEV_STATUS MSR which
+		            enumerates the enabled features of an SEV-SNP
+			    environment.
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 51a04a19449b..3e834ce9badc 100644
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


