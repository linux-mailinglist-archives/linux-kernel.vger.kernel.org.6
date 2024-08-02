Return-Path: <linux-kernel+bounces-272930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C6994628D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6850D1F24C83
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2015E1A9C15;
	Fri,  2 Aug 2024 17:31:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629FD1A9C0B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619904; cv=none; b=Y0jJm91AobBp4vsscY+/Xdf1gMij10f0+iM8UQkkEWw7Iwg/m+TLaT1bfN6WtW7lCFWGXAvfdOa9Tc3v7K6C8BLK7kitt4AphNW0zN3MVjI4D5KCpiAvKOOTejZ94zR29GrDxul4S2xgVqP6I0Q/9/pbuDFtMSoGfaoSHPCqL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619904; c=relaxed/simple;
	bh=6c58T8m4eSIeZW5BpcOcXXXN3OGV4VLMYLm95bgTGw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Br+21cLJsdE/gLY1m/qEJKRpGgw8oncJh02AB3J1d/PnZ3U+OPEG892+qyLylwNAxpVVaUFGwpnOfxe0hhzMWw+h8XU3BLHpJkt75aybA3wHimi5krYagzwe8ADGT63LCyx4jFBIJK6QJNCosH6l1Rum/Kqx7VjamVxjuOeOCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B009D1042;
	Fri,  2 Aug 2024 10:32:08 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11EA93F64C;
	Fri,  2 Aug 2024 10:31:39 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v4 31/39] x86/resctrl: resctrl_exit() teardown resctrl but leave the mount point
Date: Fri,  2 Aug 2024 17:28:45 +0000
Message-Id: <20240802172853.22529-32-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240802172853.22529-1-james.morse@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
resctrl can't be built as a module, and the kernfs helpers are not exported
so this is unlikely to change. MPAM has an error interrupt which indicates
the MPAM driver has gone haywire. Should this occur tasks could run with
the wrong control values, leading to bad performance for important tasks.
The MPAM driver needs a way to tell resctrl that no further configuration
should be attempted.

Using resctrl_exit() for this leaves the system in a funny state as
resctrl is still mounted, but cannot be un-mounted because the sysfs
directory that is typically used has been removed. Dave Martin suggests
this may cause systemd trouble in the future as not all filesystems
can be unmounted.

Add calls to remove all the files and directories in resctrl, and
remove the sysfs_remove_mount_point() call that leaves the system
in a funny state. When triggered, this causes all the resctrl files
to disappear. resctrl can be unmounted, but not mounted again.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8610a7e01f52..19f852bbc8b0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4327,9 +4327,9 @@ int __init resctrl_init(void)
 
 void __exit resctrl_exit(void)
 {
+	rdtgroup_destroy_root();
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
-	sysfs_remove_mount_point(fs_kobj, "resctrl");
 
 	resctrl_mon_resource_exit();
 }
-- 
2.39.2


