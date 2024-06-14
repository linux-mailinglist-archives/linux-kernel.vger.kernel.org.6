Return-Path: <linux-kernel+bounces-215611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF029094E4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35560B21303
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E675433E1;
	Sat, 15 Jun 2024 00:00:53 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AB4804
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 00:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718409653; cv=none; b=EIIHNKsOybbFewJ+uzbzy2iioWCP6HuXkA1oJBXU8uk4K+M4fiPD4QfeOT9BHZ9P8kM7lQ9fkjtzvsFBkYW0uyEL1MJXJKLIsZmSiUwPDVePtoJ5Rv3EaNg0isv1at5kxFn4ofWxEyjRUHUO/hJ6gfAnyBPity8WguMgrVoVDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718409653; c=relaxed/simple;
	bh=XWy94UHytwkAYZOxRaYqUcZpB9owwhT9FBOXBUsAJjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVs6ik7SWNYonV6Ibz7idScv7Z64x4snEeP3MgsMZpj9lqbr9cLHTRhtnGMsQUQv+hnd0TEOxxgXkpcGcqJCkRmm7RArqx+fEymIsuEg6L/VHY6EHDgr8DngEgjmBpmnD1lKhoSQ4p47NVPylhCrIKvzPDcqmn4qZyXscXffrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.75])
	by sina.com (10.185.250.21) with ESMTP
	id 666CD98000003A4C; Sat, 15 Jun 2024 08:00:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1066623408363
X-SMAIL-UIID: 2E1E691E2F6547F8A4F5B059AF586E9E-20240615-080005-1
From: Hillf Danton <hdanton@sina.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] mm: truncate: flush lru cache for evicted inode
Date: Sat, 15 Jun 2024 07:59:53 +0800
Message-Id: <20240614235953.809-1-hdanton@sina.com>
In-Reply-To: <ZmxIvIJ3YSZDwbPW@casper.infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Jun 2024 14:42:20 +0100 Matthew Wilcox wrote:
> On Fri, Jun 14, 2024 at 09:18:56PM +0800, Hillf Danton wrote:
> > Flush lru cache to avoid folio->mapping uaf in case of inode teardown.
> 
> What?  inodes are supposed to have all their folios removed before
> being freed.  Part of removing a folio sets the folio->mapping to NULL.
> Where is the report?
>
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
https://lore.kernel.org/lkml/000000000000cae276061aa12d5e@google.com/

