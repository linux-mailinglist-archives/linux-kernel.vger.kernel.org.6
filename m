Return-Path: <linux-kernel+bounces-405468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA09C521B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF742B2B30A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF3820BB44;
	Tue, 12 Nov 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kCqDKm1P"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8420C01C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403274; cv=none; b=ZpROPA4J7ACemncpatUdT9B5hzeFAHEotekmK3nKXjMbv3pOmeVgDBZ869PfUU2Io6AgVfbAUa4oPZjmShZr30bxkgwvKkjryG91YSY8k6tc5473LEzLI+nuVewG5KDEOvPOgnql2w3lSSL+JlP/D00xFuxA0uivsVioNMtBjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403274; c=relaxed/simple;
	bh=ZjyTIbMHIERz38+Y/2yfYFVVH68TddlAdYyZaGDvKsY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=a9oWOVRwN0w0+C0vl7e1rMRTEQdpSZc7suZYSZ6d+mJRUGZBOfG3lhclz690sOUXoBjbnvW3gbwcKCf0POvY1J1EQzFUXT4V47me9bRIWQdBXwzw059OePHt0QxfvhifKk5uDGcvDvD4ZJJQU9u3qCrQqsb8cTwSv9ex92dpn84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kCqDKm1P; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731403258; bh=AzBNZ4IJqPocACGqWdYRaoEB4ztwkej/YaY3ChMxMkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCqDKm1PJSQ8b5p7+RAl/FKCYhGPNjCiQIRckULYlwBTTPtuX3QexTO7Er1FXzF2d
	 cfqy+dvsjNmXB4LLP5xyDDOFvbkvPgov93KVffzoSxXPjShNhnkO79mgU+H/KEBZex
	 wI3zvpV01ZlLFgfCi9nV278rS/6ZuINxEhFZX4KA=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 4E99F03D; Tue, 12 Nov 2024 17:19:41 +0800
X-QQ-mid: xmsmtpt1731403181tpp1m17n1
Message-ID: <tencent_3DDDF3704370896A63A8845A977C3767A605@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeG6JtRWKoTqnmTo85maefyFj2RFPHeUY+TO38WBNwlJOX7ihRbp
	 yDiupY6bKVAem4Auq6mACuGypJPWI2jR5Toq8at+5Lw6vh5nugBIFtiZjyYVZPkqnOVkYMJAj6B6
	 oh50QLzeY5LvbA5jclEJNruvT7b4AvInnEmyg8CoNhNtIaQqRI3neFh77cdretzWvpmUckg6UZce
	 qJ43/lYzRbqhZoiOgX2aFVvbHTuPGrc/Pvt7i8H28WtGCpjQGSUk1qZz+PNaDVTcIK6Da6iYONX0
	 4vX/5pct+EvDLUM36CSSIimDF3SmpOihFsnHCD179w+1HFM4eaWWL3RTRI6fzPnPkoEo0ehpdE5d
	 esioYqmMN9a6mwXlcSSEQMH63oO6mM7joRLlfXQRXXe6qbFRtsOjt+CbahFD1dlNRMaplQF6mv19
	 sdsgFkpAb60hANpB3VXPAsIrkf2/ZW5WdESKTQGCEmYeCWDw5jCUyJokOAihsKohkBMbyUSNWmz3
	 ToIXSwfTKc27X9ZgBH1+qldcvEyxfQbmKZXAmuwRTY0aqhwHxbETmDzDMywrMR8YNvCXC/7ZTDkQ
	 +TT7GG54tKUUDVLiBD2+CBejC8U81xuGUkx1HjC0jpCDBycsnM/3ZhjwvuNgaBa4tXa1Jd87a+4u
	 O2l+rBukF81A4PpNOckC64wQFMR7lzvVeuQII3FhXvGbA25ZO9nWbswBEXBnGzv7oSbZRQJTM6W8
	 DJtZ2vz/MFflm4RVZBCnHhoEDtFlofFMztpwBrPQNqH57gEL4Ps6ZGLgEE2VbPC3pCxUm5fPlKa9
	 HxSdQZUBIJ78Tqjv5AIMwTFQNLqDY1dqB5EbozRF2ySONQ/F6joNtY8XHQStRUdP82bLVKATqh0D
	 sGKINECYYHrGUpO2eNinsr367lBTorz8hP3yot0Amm
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+58c872f7790a4d2ac951@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-out-of-bounds Read in bitmap_ip_add (2)
Date: Tue, 12 Nov 2024 17:19:42 +0800
X-OQ-MSGID: <20241112091941.1452135-2-eadavis@qq.com>
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
+		printk("mnm: %u, firstip: %u, hosts: %u, id: %u, %s\n", (ip & ip_set_hostmask(map->netmask)),  map->first_ip, map->hosts, ei.id, __func__);
+		if (ip & ip_set_hostmask(map->netmask) < map->first_ip)
+			continue;
+
 		ret = adtfn(set, &e, &ext, &ext, flags);
 
 		if (ret && !ip_set_eexist(ret, flags))


