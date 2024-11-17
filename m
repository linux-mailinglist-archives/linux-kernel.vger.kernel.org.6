Return-Path: <linux-kernel+bounces-411941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F769D0186
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A596C286308
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847AA6125;
	Sun, 17 Nov 2024 00:18:37 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004523D7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731802717; cv=none; b=VTLTe3n+irFi4zn+gE0h+DPAzjkBvsbw4T/KqM2AI8jiuLP383LBZ/WiDbfeimq3giUh+LxN7sWcFPvMP1IBlmS0kJCnNs9DHfW/7lGDnwPn3y8dDqNm0mnn/g0ben7eNHHo5qigsP69XIHkoKBjIN5Bo9E1kWZI8D+Pd5dHmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731802717; c=relaxed/simple;
	bh=yD2Vmmus/smWZk7r38f6S6wCd9/wefM9h7PNXex1GG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NspGesc8IiEl/4R3wS7aLtvmKzPLa7OMDa4Baj3Sow9NfSuqsG8Dj5X81LScG4snsy7a2zIJb3jovtEete/wbuOJqKAN1JUHq9OHwY4U0lw2dSAaChUVHjk6hRqak87bEaSd8LLqBr2itg0yRl3qREhjJ7sV0LGfB9fAsIsbPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.242])
	by sina.com (10.185.250.21) with ESMTP
	id 6739364C00001F79; Sun, 17 Nov 2024 08:18:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5946093408406
X-SMAIL-UIID: 360E1FAEDF094B9DB0659D30865D9E79-20241117-081824-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference in filemap_read_folio (4)
Date: Sun, 17 Nov 2024 08:18:14 +0800
Message-Id: <20241117001814.1342-1-hdanton@sina.com>
In-Reply-To: <67392d6d.050a0220.e1c64.000a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 Nov 2024 15:40:29 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    3022e9d00ebe Merge tag 'sched_ext-for-6.12-rc7-fixes' of g..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159f8ce8580000

#syz test

--- x/mm/filemap.c
+++ y/mm/filemap.c
@@ -3781,6 +3781,8 @@ static struct folio *do_read_cache_folio
 
 	if (!filler)
 		filler = mapping->a_ops->read_folio;
+	if (!filler)
+		return ERR_PTR(-EINVAL);
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
--

