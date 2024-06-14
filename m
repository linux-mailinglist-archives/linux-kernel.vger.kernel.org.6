Return-Path: <linux-kernel+bounces-214843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BBA908AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438D71C21F28
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54129195F2D;
	Fri, 14 Jun 2024 11:42:23 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF8190477
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365342; cv=none; b=n1TwlqYSBBLdQPGxBWpoqQSyc7Cku5HTOWR9DcYZpy0jL9IgY6oe6Kk5DybbcCszdVW2ud9RQRxBsfiKzmpdCRmwlKoVi05WEK1BRsFlSYB09uO3sIgmHJhnfvjIAypVRyJ4evMx8nE1W459FyGesZPZmkZGiaEvRxv6+DzXKBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365342; c=relaxed/simple;
	bh=0UTkU+vYGKrKshHTiLb2eb8RpUdyMf0Z4mUfmam9F9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XreBlk9oOQZ2Var6dzZKxz3EjsGrrl9Y7yKN6NmO/T2+I+aHIWi/8t4hv2GXsjBDbXk633oQ48McjEoTeL09mVVHOl0Uvk460Izygv7DLpsoaHeNLlKHFZsP6zJZaQSwFMXMDsrhfM5UxSfY0FPiQeNcJbwlIlBqp/g0meJq85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.97])
	by sina.com (10.185.250.21) with ESMTP
	id 666C2A5000007E81; Fri, 14 Jun 2024 19:32:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2455453408535
X-SMAIL-UIID: FE2C5B6C01774354B9191BDA55061F6F-20240614-193234-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
Date: Fri, 14 Jun 2024 19:32:24 +0800
Message-Id: <20240614113224.590-1-hdanton@sina.com>
In-Reply-To: <000000000000cae276061aa12d5e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Jun 2024 11:10:20 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    83a7eefedc9b Linux 6.10-rc3
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c645e2980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  83a7eefedc9b

--- x/mm/truncate.c
+++ y/mm/truncate.c
@@ -418,6 +418,9 @@ void truncate_inode_pages_range(struct a
 		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
 		folio_batch_release(&fbatch);
 	}
+
+	if (mapping_exiting(mapping))
+		lru_add_drain_all();
 }
 EXPORT_SYMBOL(truncate_inode_pages_range);
 
--

