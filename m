Return-Path: <linux-kernel+bounces-445764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F092B9F1B49
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BBB7A0378
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6182DBE49;
	Sat, 14 Dec 2024 00:18:03 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4478366
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734135483; cv=none; b=Z28Yu1sdCzKKhGeIwIpRRSZXiiHcJfk8aN6IHiBlKGrEp7dSiENe/xk6anLC4VBLjoEVYxL+Nqlre1wCJDQDOVkFRg7ABLNFBKSTTU+oIlsrd5s7yoWOJgA8anJ7InHmQ2ypbpmxp1sxkUZJVwCf8ysl/S25JKzaFLkyAIzuj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734135483; c=relaxed/simple;
	bh=sc6tBbjm4hJQ59776ypHTDr6CwfbIqwP/8EtsIyOCRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZFAPv8PcemOOovRSZhEoeNVkGo4z84gRnqc4fmerOSXtUlPBUbN1k3g/hUWSUs6llM3OucHoWR6K5N1xDc4teBZXbZrV54xd+ofytgXf0MwhN3byhQnFM1yJkMgzdbEeO6DIZm9+Uv9mB/mU/CygKqsmrGg0Aeiohc3pMyLYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.238])
	by sina.com (10.185.250.23) with ESMTP
	id 675CCE1C00005AE0; Sat, 14 Dec 2024 08:15:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5076748913264
X-SMAIL-UIID: DD8743349B9A4099A0762B4A6FEE918F-20241214-081527-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
Date: Sat, 14 Dec 2024 08:15:14 +0800
Message-Id: <20241214001514.734-1-hdanton@sina.com>
In-Reply-To: <675c5e51.050a0220.2875e5.0049.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Dec 13, 2024 at 9:18
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    f932fb9b4074 Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14654730580000

#syz test

--- x/mm/filemap.c
+++ y/mm/filemap.c
@@ -871,6 +871,7 @@ noinline int __filemap_add_folio(struct
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
 	folio->index = xas.xa_index;
+	BUG_ON(mapping_exiting(mapping));
 
 	for (;;) {
 		int order = -1, split_order = 0;
--

