Return-Path: <linux-kernel+bounces-439480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261609EAFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228ED16AB13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D078F4B;
	Tue, 10 Dec 2024 11:27:37 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD4210F7F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830056; cv=none; b=nS8DYrTXoqlzlbY+vxpqX+5jksOnTs0ebktI8aJ8vssVm+e8jRQZD2C3fVEAQpW5ZFxY3bUClYuG+DxukM5tL4TC7mhitoZ9HzxXq3pAB9G1x+pYCJhFE5kqp18PBwIIqTjWV8aDccceUKGgbpDZvVwD3Q1/Bpb1A4hRpETxtoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830056; c=relaxed/simple;
	bh=2Y7GVKRzjAAFsQPZMxgdnplWp/oE3wrhu6tsKdoFzfo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MxniYoxJhfuBDifznLL+kAiCP3EuiM886VQAL0L+sUeUI+TDnzPuOoLof6lmdXgT6uH7jjSFA9Vg9M/EIkmELwPY/yr3QUauK+7M9zQ3ebUhDFuandApXwZ0WsNn732qV/nHSwY6M2EWMODIGtIK4Fqeka304ZYyzgxHpllSfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a81570ea43so46093965ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830054; x=1734434854;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQa5zy5h3PxdT2631sH/nB7PCqJN8CEm2Sf9btMgmq8=;
        b=pheoEAGu9guMvexPIBE9KOw1kkzsCnLl+3V2P4BDhQMnYfFTNmrJawBcfMDdzzBq1g
         YYD3DlYzVN2vEOowDGbgkRQ4BYzvZcRPf+8FwnneSkFVQIB5w9e/vBSVEFsqzPkGtfbJ
         cAYpplX5xvbeLl+KvDXpFAUaSWwaW7ndXp1nzfKlJBqwdWuvUA2KFMz8/Gm1vFHRILOp
         RIdqjdrmzLy8x+JP2tPj+5hy3MnuftHAPH6QoV65Rjhy/9OIzx/hNJLWCcKLnTxU6t74
         CEew6iHBTwhAJoc8vWMXYhMWEmH3yGoSdXy24swVkPz4FqpgXW2AegjlA9o5HDOP+x/E
         sZwg==
X-Gm-Message-State: AOJu0YxJWD1nTO6aE+38lBV8Km8Q58sKREP9zZi8oJJphRDsmYMljjOa
	MPcD+FmCXXPRGnMrXfO5U04zVU+vgiCVWnh1Iylgb/5PKSSLLWX6voZiJ0HrHF7cSxSCqTUfMDN
	bVza2S2Tksda/VpVClwXM83gExHZpQ1M7ezup1pvoeL/ssoibb4vznCs=
X-Google-Smtp-Source: AGHT+IFBSx/ipR6YW+NvBh1tN0HJDYP1hTEJVQ1j3sYY3oln2HZixK2K2fxsBIVQtBS11mZOuCY54tS39Ww6MRTTq9aJhKfLoabX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168d:b0:3a7:c5b1:a55f with SMTP id
 e9e14a558f8ab-3a811b87e70mr160772235ab.0.1733830054437; Tue, 10 Dec 2024
 03:27:34 -0800 (PST)
Date: Tue, 10 Dec 2024 03:27:34 -0800
In-Reply-To: <67577778.050a0220.a30f1.01bc.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675825a6.050a0220.a30f1.01cc.GAE@google.com>
Subject: Re: [syzbot] Re: KASAN: use-after-free Read in ocfs2_search_extent_list()
From: syzbot <syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KASAN: use-after-free Read in ocfs2_search_extent_list()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7cb1b466315004af98f6ba6c2546bb713ca3c237

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 395e23920632..841135341898 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -770,6 +770,10 @@ int ocfs2_search_extent_list(struct ocfs2_extent_list *el, u32 v_cluster)
 	struct ocfs2_extent_rec *rec;
 	u32 rec_end, rec_start, clusters;
 
+	/* Do not search over an invalid extent list. */
+	if (le16_to_cpu(el->l_next_free_rec) >= le16_to_cpu(el->l_count))
+		return ret;
+
 	for(i = 0; i < le16_to_cpu(el->l_next_free_rec); i++) {
 		rec = &el->l_recs[i];
 

