Return-Path: <linux-kernel+bounces-251479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA29C930554
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C0283893
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339A60263;
	Sat, 13 Jul 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MHxueTaC"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AF1E4A9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720868637; cv=none; b=pk8+Vx94AkpEYMp7n+74NhiZ5oC3yYOJ9azcQrpYKJTnCwMdPsVFJtUTrFzZgUY/TZSWucgzN9b8H1CjxIztVMhllvW0IMXoJJ0FkezIlowjq3NtFbSWJX0xZbwmYdir3SUS0DfcloF6z3uOB4cU1t/qeALcaPIoSPzHAu0b97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720868637; c=relaxed/simple;
	bh=uD7ddHPNCv9re7jh+GgSVnOkNYW3iWVk5/d0ybro+S0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USC3nxONqwL4IV63JTdDTqtUKbzzXkF9BD5eVvn8gxT6WVU58KB7l2I5DSfjPunZItK0QJORFtMMm23T3QGE1JcEXHS4stWgANJpquuMYZHwaFlqK2ArRbPhYC2DqchUP/leVnmmPVJsqKeks/4E1KWPyQzSL6M4RlIGqHOytFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MHxueTaC; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id SaWWs33AVt4p9SaWXsZPUe; Sat, 13 Jul 2024 13:02:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720868564;
	bh=+95BoV2zMSWhEXD4+8PYZ6sPnem7u4o6Qt+9aNjgw34=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MHxueTaCXcUv0jTgyKWZKCmJIlffD84NUjpqOZ8OqbEnwBJtH5V+rF7Punxk7IET6
	 ZqMBhWXqQP7kq7CQGxPkxMxlDTdoMR0CBspSjjmGf/++DcXfsHNS2+HMbwXa0v2V59
	 k3+Qhl31MEpm+YZB5BpEw6XqGoEAsOBETdt7v78+M7xGJnRqaWWRJlYNkrEFaY94OX
	 08oZW/s3KQPBgz5/xdfz9H6tiH10TWu4gltfYNFEm7SBUunqBcmYGuWWAX+vpmISxc
	 eQSszVUtEfW64RlVeY1eJ4UbqKI/vOM8JvR1mfrhF6dgVoFiNFlZI7NODVRLzeixJv
	 Im1okBIi0e6eg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 13 Jul 2024 13:02:44 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] x86/resctrl: Slightly clean-up mbm_config_show()
Date: Sat, 13 Jul 2024 13:02:32 +0200
Message-ID: <b2ebc809c8b6c6440d17b12ccf7c2d29aaafd488.1720868538.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7163b764c62..d906a1cd8491 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1596,7 +1596,7 @@ static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info
 
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
-	struct mon_config_info mon_info = {0};
+	struct mon_config_info mon_info;
 	struct rdt_mon_domain *dom;
 	bool sep = false;
 
-- 
2.45.2


