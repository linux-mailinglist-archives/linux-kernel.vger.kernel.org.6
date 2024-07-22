Return-Path: <linux-kernel+bounces-259083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DC99390F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A89B20A60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DB916DC1D;
	Mon, 22 Jul 2024 14:49:44 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7E16D30E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659784; cv=none; b=JsYMhbWp4RnIt6axBHwpLziwiFrkmrAqBTRJiWNg0qVPd9SaBzWjRh9XxoZCluqyBwXzIR7fpem5+9U/tKcF/hKFXlw1NoMQXsLn+z6a7WI6k4DJ+LpgYeyUN85BTSK3Qj5kBDe+4oFM2XSWcdGTrLqX3jj5yGC1xilf/uSSZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659784; c=relaxed/simple;
	bh=MdQ0sjsGubguiylnQyA86jpWmdO7skaXLjAm7b82ooo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XUin3e0z8D/8U+490sXuL7qVMEPQ4wnkHQYYNoQhLtraJSwbE/zBHW/KmvX5Cl3RzFIoY1iLVmnwhnJwSXLcQ667D0BzyrAYSp7Uj9LVPZQdOUzTnxc3HXpYxTmHdWYRZKACES9zi4fgqmZEDHOyaPGQCUafuwu0bm7CCv8dVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8152f0c4837so719814839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721659782; x=1722264582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anegiXYY2/T91WqfPR4oSIKRa/1toqw7Jv5BF8plEUA=;
        b=bIK9lxGu/oUucwjtiFtDfZA3mVB2YMvTQL4jnGkqRLx5g1kWyZCQB4HpZ8wlv3z0uj
         hckpyeWmCCNC/3mBvEvARjk+zadZ1AElRH3NIFGPGTuk8f7Jodhc+3k4LjMJquKm9Do7
         MP5P/r4bCuM1aZWKIYOTZyGWSeWDXkw3KPcygpjEFtrv6JQ7H4ohybvkf6DfT6Yqsbga
         Sk99+E5ab8ll+NStOyQVyqOWKi9Qpj31qaiegicRVAvivfZ6GGJyUVPZTsvkPZ1SMBah
         XDUUV9rSEMmd4DTvmrp2FFlQ25NEza97oraFcyBbJunHrAcusRGdJX21PW+BcchyZRCZ
         Re8w==
X-Gm-Message-State: AOJu0YzgxYL83tjhsMNqeCEMYNhlx5Q1za58oOFVpBvQIikndJPcRpAl
	Sv0bOgSxaTPZL+xaW6stc4Y2596x5esgdYVuTT2xZ20b2bt1wjSKq4vO5nRB8QriVBAlXAfaq54
	TQIcqGUIu94WbFJRcK1I5ieC5+GZpHre26/6KmVDjocTz7gOI8yyHJf0=
X-Google-Smtp-Source: AGHT+IEfrqKspqUNb6A0gXO3iINJJejJn0bTNzqPCvrMMTXTn4LmMVz6PIBNkyQ3OB0oZNR2GiVmgtnGBECp2mwIwDXkC3N5cjXD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8910:b0:4c0:9a3e:c24b with SMTP id
 8926c6da1cb9f-4c23fae1a3dmr558256173.0.1721659782184; Mon, 22 Jul 2024
 07:49:42 -0700 (PDT)
Date: Mon, 22 Jul 2024 07:49:42 -0700
In-Reply-To: <000000000000e8fcab061d53308f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdd014061dd727b5@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
From: syzbot <syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 include/linux/filter.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b6672ff61407..22691015d175 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -842,15 +842,15 @@ static inline void bpf_net_ctx_get_all_used_flush_lists(struct list_head **lh_ma
 	if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
 		return;
 
-	lh = &bpf_net_ctx->dev_map_flush_list;
+	lh = this_cpu_ptr(&bpf_net_ctx->dev_map_flush_list);
 	if (kern_flags & BPF_RI_F_DEV_MAP_INIT && !list_empty(lh))
 		*lh_dev = lh;
 
-	lh = &bpf_net_ctx->cpu_map_flush_list;
+	lh = this_cpu_ptr(&bpf_net_ctx->cpu_map_flush_list);
 	if (kern_flags & BPF_RI_F_CPU_MAP_INIT && !list_empty(lh))
 		*lh_map = lh;
 
-	lh = &bpf_net_ctx->xskmap_map_flush_list;
+	lh = this_cpu_ptr(&bpf_net_ctx->xskmap_map_flush_list);
 	if (IS_ENABLED(CONFIG_XDP_SOCKETS) &&
 	    kern_flags & BPF_RI_F_XSK_MAP_INIT && !list_empty(lh))
 		*lh_xsk = lh;
--

