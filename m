Return-Path: <linux-kernel+bounces-405726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AD59C5646
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA0028FAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5FD213ED4;
	Tue, 12 Nov 2024 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LQlbDh8U"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865B20F5A6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409395; cv=none; b=AuVlwU/WhIJ9oKyL5kZb0ieBETxDfd7EWHuNk7j53t+krpO2qVeqcv9wb9uPv/nhf9EROvKBImWCaQPtNLkP2okG8fg27CJkdVj59Efmb8nvF99b/yO9UCABmb3DTQtUzPY4OqDqdNmfOZqV8o/0wARusN0VloY98qcujqazpUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409395; c=relaxed/simple;
	bh=Vv5i86Bhi+cXijbPFXpcx+qezOy//E0TI/gzzWoY/V8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IC5Ekzzm8/VLNy9H9GQUfNhblGOypliWZD6Zw8bnvRJ0mAaDRFEImlarNyEwvBS3pSpsEZ1kXceYF8ktRnPet+LzFyza7/whhi57/xFOOcSTnA91NbTa/G9mHfYhGvybHfY5/ariyd0hQ49sFl9srpfww238udFFcmGV5vGfSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LQlbDh8U; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731409080; bh=VigVfp0gG8uLiX5hQPvsyW47OjWvGoQyzRaVbH0GVcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQlbDh8U3ZGSzUL6vXMFyOGqHKBF+uJZXAlztwPQEUBxG1aWdTlvgp9l78uI7oPT6
	 P13MRkzgLK2NRm51XBsoGhRXQYEcAuziHezqWHNWIPOrBK00N+5EbMtnigVHrJQw9P
	 rinh0j2pOfNlNCuiGFTwZ2oucIbx98ImrHhSZEmg=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id E7A9A695; Tue, 12 Nov 2024 18:57:58 +0800
X-QQ-mid: xmsmtpt1731409078tkxan4rvn
Message-ID: <tencent_93E4C66AC993AEC56EFA0CBB27DBC6CFD206@qq.com>
X-QQ-XMAILINFO: NonMLXQbqcUbSg032T6j9wOSplDqWad86YlU3X9s/CBLG26jQUxeIaR6RWLMih
	 JZLx+VDCX8ifWutv2vFlto/zVE/xMYQxUuD00/bqVkYaobXoKpavQ/K3H80o/233M+ij9jAtkKYQ
	 GCKfCMonzBsEuHllwFuReXjKPIY/g5Ee4CfZr0kQvSyKqgi0rSirVep8tX57zgQrBqxxYbOBhEGF
	 Ztfq+FuAs03TwyHDNfMyQMOc3KoOaIyqOxNmWDcYIPcGp87RnRkCbBmvPUynsM35OG0YR5dgz3AJ
	 +mpMCxEdO4OkFjwCIQLjoCuewIDnhjDLknznZapWk/hGrVaCEdLS1tzILTOGl9RWdCi6mUAgWRM9
	 /DJgtTn9Aix/tWH5jHbZ8MM+WNrDalWJo0f8Qu4S0DjT0U+fcxltk2In0J5M8gFQS+3ZyjRXUY0u
	 9ULTNAXdjqgPt/mTIUD05Xe0Gf6gq7mw2xtQKCH7XorbLp5I4RhfB8XsWn1YDBUYSQJO+mfe5HZV
	 tzziFXDzbBvG++YwookT6zAcE6z7whl+QS4ND73/PUkM5hxpQ63vE9UEwVfsJ/WuzX6L1NXpsaBW
	 wfC9EemXoQau5LGoBvZGyEmZP+fBw5l9Lb+YZhcgKrRvplClf9o9/HH0+dZ6dOSBC9X+Nwap8wYy
	 au2tceSs6G+UEjweQcbtX9rfKrVFCrrqV8gpTo6xlUzvX/Hhh/zwS2SqPePR84fXA9OPUB9fX18d
	 m083xbb2guHewL8th8JYjQehPYCgObhpX5NX9YbLi5M1+5tBtzOKn8QI68nlg6gz8CjeUqLiFHO8
	 YNscfgYA8W+6g0a27jSw8DiTwtVxJKqS7msiWIWLsVnUKQKsScI4lbcgQ/ZweJhJAjd+Z4hqy9/8
	 NqbOx0CpIk8UaLBmd3ZAtZVWYR9sFtVv+JG3rS6P7Htb3Nzk/NzSQjINcJ49m9ajL5+FoKE1mwyi
	 +J4d4isTI4mGs3JYz8zA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+58c872f7790a4d2ac951@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-out-of-bounds Read in bitmap_ip_add (2)
Date: Tue, 12 Nov 2024 18:57:59 +0800
X-OQ-MSGID: <20241112105758.1541811-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6732caa8.050a0220.138bd5.00cf.GAE@google.com>
References: <6732caa8.050a0220.138bd5.00cf.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the value of first_ip or netmask are incorrect ?

#syz test

diff --git a/net/netfilter/ipset/ip_set_bitmap_ip.c b/net/netfilter/ipset/ip_set_bitmap_ip.c
index e4fa00abde6a..0fe17fba3b86 100644
--- a/net/netfilter/ipset/ip_set_bitmap_ip.c
+++ b/net/netfilter/ipset/ip_set_bitmap_ip.c
@@ -183,6 +183,10 @@ bitmap_ip_uadt(struct ip_set *set, struct nlattr *tb[],
 
 	for (; !before(ip_to, ip); ip += map->hosts) {
 		e.id = ip_to_id(map, ip);
+		printk("mnm: %u, firstip: %u, hosts: %u, id: %u, %s\n", (ip & ip_set_hostmask(map->netmask)),  map->first_ip, map->hosts, e.id, __func__);
+		if (ip & ip_set_hostmask(map->netmask) < map->first_ip)
+			continue;
+
 		ret = adtfn(set, &e, &ext, &ext, flags);
 
 		if (ret && !ip_set_eexist(ret, flags))


