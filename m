Return-Path: <linux-kernel+bounces-350878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCBA990AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AAC1F24421
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EB98249F;
	Fri,  4 Oct 2024 18:06:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F351DD89F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065169; cv=none; b=JBDKu7C0W+gZGv6/uhmzw5Q3Ts3Fyxq1OmYfp/kqt6XduhWnBbqbEkkcy538uIeA9umA+Vka6Yvdi1JSi7TB21zM0bVLwCXwmNNQX97t08PFrhfS9VGU0Fhv5WzZt3fFJNyqKfm2j4QyZDtzrXabslLpFbqkDbu/t2UOK982gFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065169; c=relaxed/simple;
	bh=37ISiWEXashHyDqQQLiBkUZK1Nnd8g2zCOKb/TYBc3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rvcae/efJ7aAgqEequysSnWiuyLhYYR13iXTzL49hut/jmsrsnD4NPBG7DCNZxP5VM0cUia/Z/+jsAoTzrcAGK0Pc7ZtXdkkRva3NzGw0GUmVmKecRoI3MT27Ec2xLbHT92BQNNz9Xart28YK+mRqPHWXok4tW1l5mJSREWeTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 559E1339;
	Fri,  4 Oct 2024 11:06:37 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96D7B3F58B;
	Fri,  4 Oct 2024 11:06:04 -0700 (PDT)
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
	Dave Martin <dave.martin@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v5 20/40] x86/resctrl: Slightly clean-up mbm_config_show()
Date: Fri,  4 Oct 2024 18:03:27 +0000
Message-Id: <20241004180347.19985-21-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>
References: <20241004180347.19985-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'mon_info' is already zeroed in the list_for_each_entry() loop below.
There is no need to explicitly initialize it here. It just wastes some
space and cycles.

Remove this un-needed code.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  74967	   5103	   1880	  81950	  1401e	arch/x86/kernel/cpu/resctrl/rdtgroup.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  74903	   5103	   1880	  81886	  13fde	arch/x86/kernel/cpu/resctrl/rdtgroup.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://patch.msgid.link/6be685f7-e99d-42af-b26e-d5e542f597fd@intel.com/
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7ed295225da7..9294bf74f3a8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1624,7 +1624,7 @@ static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info
 
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
-	struct mon_config_info mon_info = {0};
+	struct mon_config_info mon_info;
 	struct rdt_mon_domain *dom;
 	bool sep = false;
 
-- 
2.39.2


