Return-Path: <linux-kernel+bounces-429542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E89E1F4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3B7B27432
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D91EF0A6;
	Tue,  3 Dec 2024 13:28:57 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B219A297
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232537; cv=none; b=CPEstW8h5xsHlePzcsFQ/zzwocKvZr3erNw/L2ZnHxE70StbxG1xGghlkJwYhB1M+cSBqYGGBqTypMr0ObYAShpmlFVl/+2tB412iNRdM9UImxu5feChAsBrD/GmtOiAEoVz3kLVX/QcnPMSQOAWUnx319UwzRxkv6y9Q+I9OYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232537; c=relaxed/simple;
	bh=pRjhf2Ka/V0lakXwM7BNa9baS7Tn+JzqTO0O0o0NwwE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UBSB1SlNk6+22WNKK8j8DASCAtUI0WEzxeexrhRhvg95GhXeRdRpZ+oGgycJJGugwtH7w6PxxJNvTnHn7iiOYtGdYujHrFFEjBhUvDbQa6H1lrA6E5M0rwCeABt5padae4Hsrn5Gp5xVKMjySTwEEovjBW3E+r3UdWjmVdHQwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a77a0ca771so39351525ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733232534; x=1733837334;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpOhvann8v6cfjJBUe309C4fInbf8Nc00R+1ZjGvUeI=;
        b=SAGRWAij/qmeQ7aK5qIgf7NstCZSSAv9J5WlFk7yzuP0AyfkfjGws6qqsGc2ZA1h1N
         EHwaqQqn9wyYUv3uEJ3d4sAQ3MchDcznC5ECSDtKS3KvmOqvf5x9+oTNXoPJsbAE9noF
         cJUXvKbX4MCeLnFdS59SrRsyfa0/Ne14xxZ2Y/etP704IPab9R9CG1EFsUZqDuZKUN/P
         pe2ccVaj4bdMOfSRsri3dcimgOUgI+l2+2V3SBF/d3nAbkwWYGonRH56oD0CPA7c5X1v
         F5x06gHkgEGx8pHeIXM1edJKOZ/yjPXd73xmRKwE/qJTHb5uARooI6VTsSp1eb4W+38U
         HX2w==
X-Gm-Message-State: AOJu0YwVI3CdZvPnxEcRrcLB6evure+8vOeHilGa6u6MQf38FhGfMjTK
	OFPG7lfWj6YfySlfMktHpctoR1hpctjHZKHgf19Glc8zbJIVNlTTWaHamMqUrFtdBlL/mDm8YnW
	ogUL4vrDN0EaDPUXKK118mgmLDSoC3QAWfpe/ymTvwnuG1PBqv4gYqn0=
X-Google-Smtp-Source: AGHT+IE5Fu9DD0aCX6k/12w3cDpl9/A44Z/cBJI3u/bPnyTd9vJOqj+AzaedvYBneTGgfPV8FxlIEtmz+EpXbl0myKbqoBhi2EkJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13af:b0:3a6:ad61:7ff8 with SMTP id
 e9e14a558f8ab-3a7f9a56d35mr26198605ab.12.1733232534625; Tue, 03 Dec 2024
 05:28:54 -0800 (PST)
Date: Tue, 03 Dec 2024 05:28:54 -0800
In-Reply-To: <67409854.050a0220.363a1b.013f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f0796.050a0220.48a03.0038.GAE@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in ip6table_mangle_hook()
From: syzbot <syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in ip6table_mangle_hook()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cdd30ebb1b9f36159d66f088b61aee264e649d7a

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 48fd53b98972..00840249554a 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1224,7 +1224,9 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	    (skb_cloned(skb) && !skb_clone_writable(skb, 0))) {
 		struct sk_buff *new_skb;
 
-		new_skb = skb_realloc_headroom(skb, max_headroom);
+		new_skb = skb_copy_expand(skb, max_headroom,
+					  skb_tailroom(skb),
+					  GFP_ATOMIC);
 		if (!new_skb)
 			goto tx_err_dst_release;
 

