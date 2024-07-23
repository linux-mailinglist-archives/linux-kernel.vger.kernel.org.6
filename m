Return-Path: <linux-kernel+bounces-259888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE673939EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB58283683
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA014EC7C;
	Tue, 23 Jul 2024 10:43:26 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC614E2CF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721731405; cv=none; b=UsEaXU27L4t31qa4Z0W3YmX7wgFLCtu8ubkLDSaTxgOQbcCFw1iN+nhmmfbakI5EczEAzZQf+KHOSm1DI6l3ofss6koBiSVxfynKtS03Copge9588bWKbsw7XZCs+S77B+FJBfhFahYeJxt1NqN96i9zf4SCII3DVX7eTatAO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721731405; c=relaxed/simple;
	bh=86oHMNuISqQQXamX/H529QhJoJhx+fdXv0v5DNMDNP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QLbU6j2nDR9Efdlqu+PqMCk6BHiZSG7PG/F1nrHBr4K2IkgILASgq1XGgXl+5DFpcIOK0IBDf0CjJZMghUKWW5v266gJIU5PYRhknshg6JjN57GptwboSOurY1S8alrWd/S4knLQQt1kU2j6cx30sQWBTEgGjAHgdVBbnqiZ4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.8])
	by sina.com (10.185.250.24) with ESMTP
	id 669F87F70000748C; Tue, 23 Jul 2024 18:37:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 34118110748447
X-SMAIL-UIID: F224F4CF36FA4CA0A8B192AA797BAF97-20240723-183746-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
Date: Tue, 23 Jul 2024 18:37:34 +0800
Message-Id: <20240723103734.1909-1-hdanton@sina.com>
In-Reply-To: <000000000000341f5f061d8d6bcb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Jul 2024 15:51:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    4d145e3f830b Merge tag 'i2c-for-6.10-rc8' of git://git.ker..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1366ab85980000

#syz test upstream  4d145e3f830b

--- x/mm/rmap.c
+++ y/mm/rmap.c
@@ -1466,6 +1466,7 @@ static __always_inline void __folio_add_
 void folio_add_file_rmap_ptes(struct folio *folio, struct page *page,
 		int nr_pages, struct vm_area_struct *vma)
 {
+	BUG_ON(!folio_test_locked(folio));
 	__folio_add_file_rmap(folio, page, nr_pages, vma, RMAP_LEVEL_PTE);
 }
 
--

