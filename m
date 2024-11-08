Return-Path: <linux-kernel+bounces-402474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826659C281E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA05C1C21BC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66651E22F8;
	Fri,  8 Nov 2024 23:29:28 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7E81A9B5D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731108568; cv=none; b=GG/r/vW9xvbmZgaGR0TvlwWbqDX9AjTJ7cDMePo1j+DFFWcd/vIwovC9cyt1zMctGV793D3+Cnp9Shzcbdo8kQcNGCdXi8FyzEpiBrjil5KVzGDsTG4N87aFoRRI+/umw6zCZD0VtcdozUO02sO2PNDzSBIULaMlIBDem8Nfnec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731108568; c=relaxed/simple;
	bh=4ywU9b9z/sMfwWqnaVzKjZq2lVo605h7mWL+ApSPlXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAYXTPCL/dvgg9Lzxmhjoxpvz7J1fNWKaFkljuHJLZZc2f8eD3JO2eepwQEbZgSqb+k6oWgUhpQ8T1LMu4Uy0mHD7FRJs9Not7iYxWMWpjjhuTrg8+jtY9ekm5QgVwqGYyDCjMUerHNDwADKJKy5jGTdkY4DxVHoJg3VBLr/twc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.37])
	by sina.com (10.185.250.22) with ESMTP
	id 672E9EC500002876; Fri, 9 Nov 2024 07:29:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1008147602647
X-SMAIL-UIID: A42BBD2DC59F46A78B6BCC9E5FA1A1AA-20241109-072913-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	Kairui Song <ryncsn@gmail.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [syzbot] [mm?] general protection fault in swap_reclaim_full_clusters
Date: Sat,  9 Nov 2024 07:29:01 +0800
Message-Id: <20241108232901.3631-1-hdanton@sina.com>
In-Reply-To: <20241107142335.GB1172372@cmpxchg.org>
References: <672ac50b.050a0220.2edce.1517.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 7 Nov 2024 09:23:35 -0500 Johannes Weiner <hannes@cmpxchg.org>
> On Tue, Nov 05, 2024 at 05:23:23PM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    59b723cd2adb Linux 6.12-rc6
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1076c740580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b77c8a55ccf1d9e2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=078be8bfa863cb9e0c6b
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167aa1f7980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110d86a7980000

#syz test

The syzbot console output indicates a virtual environment where
swapfile is on a rotational device. In this case, clusters aren't
actually used, and si->full_clusters is not initialized. Daan's report
is from qemu, so likely rotational too.

Make sure to only schedule the cluster reclaim work when clusters are
actually in use.

Link: https://lore.kernel.org/lkml/672ac50b.050a0220.2edce.1517.GAE@google.com/
Link: https://github.com/systemd/systemd/issues/35044
Fixes: 5168a68eb78f ("mm, swap: avoid over reclaim of full clusters")
Reported-by: syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com
Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 46bd4b1a3c07..9c85bd46ab7f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -929,7 +929,7 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 		si->highest_bit = 0;
 		del_from_avail_list(si);
 
-		if (vm_swap_full())
+		if (si->cluster_info && vm_swap_full())
 			schedule_work(&si->reclaim_work);
 	}
 }
-- 
2.47.0

