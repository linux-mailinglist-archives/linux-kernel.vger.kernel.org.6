Return-Path: <linux-kernel+bounces-543097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73321A4D167
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E879174BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B8E34545;
	Tue,  4 Mar 2025 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RzjK5Bnb"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F722F46
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053992; cv=none; b=SMld0zNVAVJ/fOtScrQ4BqV7itM1GBgtte6mMS5YGoPgV3ZWIqtBweVqHP2XnUkU4JgmxBF9Vf63sSgnJ+NEunI/RRT8h9Q8A7yAg9ZMFMsjn/ia6OIBJEYBH1wPUo1tpM0lx2pQeCxowROVQebOFmaJ6Cp5nSgp9AteZiGB0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053992; c=relaxed/simple;
	bh=q8YHmyNgMsvW2HeGh3/5I4724NkslUAW7U5qEQXZbHI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=W7UWhKonFnpsLlStV87EfnImvaXql2K8O5Leo2KUjo2ye9SR9aF5kIfEQUlZOgeW/c0xcvtTzKOVYWS7+btSkwCQIe5pUacBZdYQQD6o6c9DW29KlvR0RlDk4zJa/+VAUq8gUD1EF+n82b3SMrOe5L34bPN/2lI4C3Y7Eg4JfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RzjK5Bnb; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741053684; bh=OcErTu24xHtuc2/X1k3Y3noIn3GmgUak/szKDbzJK94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RzjK5Bnbc5rUtX8Wo89xAqsGtJbtWbVFYTxhU41Zian1V2Bte3vv4vLuI51sK9uwf
	 VucaZuT1mQ5Vl4qv3YVvwqSEO/O11IfrPX6bJ0q68WWxFvEop51y5WOj0bb0HU8SCS
	 h8VlxYAqQ3+tdjIHhV9F4RCk8h77o1hEQQssCeww=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 56A4E8B; Tue, 04 Mar 2025 10:01:22 +0800
X-QQ-mid: xmsmtpt1741053682th7lkwn20
Message-ID: <tencent_B976976066C3B3690374096D23B1845F3705@qq.com>
X-QQ-XMAILINFO: MOpJcPT3Yy24PzqN7pwAGZcYvgjIDjsOGD5UhdudKpdVtjaw+8hCW9Om9l/NbT
	 0eFJ06xnEwlxN36YQICa/RxdZRY3YEhKV3NSZDXGEB4pmu2H3GNMgYYRvwLKPS4vcMWQMatSp/tN
	 YE7JTZ64KwxC/7i7SuwY8nbu8UC2tg0TtbbjBPhWRBw/wFk6fwT99we0gFNcdtWemtwap6wR2Fvc
	 NZCbhSkTYkeBt6JLiuNcc01pxbwvB87XGV3XDHGf+slN+G9rKjuLjO0Cms6/zr852h0oJ+miV55j
	 ZeYbuozqncnVDiZ4TdIQJ/TQN4yi2HFIZgm5BnBBqM46XxOSAGo7H3gnBH6iU85sux0OkgG12KrY
	 M4W6m6gQJVz/c0E3pY3AJFOSZb3sp4yZv3AWMOkxFZ9IU7DzCVuO0WMtirfdzwTUk4c/rJeUghx0
	 sIpnpbG+KKZzFtCZORYL2hFv/9dpYeuSzFUv8jCPMg8hBRXE3631P7Cc3MWMKSxuaWm9yOgISgUA
	 9oEo8KrZfxl6pG2GgMHqEeMcMM+BWcp5RzruFGBqE65lgPzLbgVZK+TAInZrLtR1MpBZ+6Z5j6jq
	 E1oMrA/hwPtHc1KY+TsiMjWJkUhDuRvZ3SReuyFOo+GrYxPTbOlE/Z1ZCnDnmO8u+FxQD2eb6heP
	 zwQ0SOJcgymUVDwndQuRRFmZVFkENK6iFyMFe44/oFzMjM9m4gf5j9+M58D5gCbKCOgrK/FUQHKg
	 rNY0lLD9IAVJz760hSyYa3OXBaNEubNKq2hdP8WqbvOdLvEzoPUcjnItTtcoQog1VNuprpsTCcoK
	 rBlbBA0Lf0vvpjHmQinhz+k2pirGZr7Q0uK6S6n1LUU+7V9qga134LwYmJ+0Wh2kIEZGEsrTkV9o
	 DZYZ/xsYE6YuG1MO/jFBMXAttF78rNnTF+H9oPNKgLM0Noj71jsyZ/kk8zXrhW1jZhJbbC3Y/73R
	 qBp3XKRBhKvt4hmk8fO8XReN0Zg2l+
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Tue,  4 Mar 2025 10:01:23 +0800
X-OQ-MSGID: <20250304020122.5256-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67c49230.050a0220.55417.04d5.GAE@google.com>
References: <67c49230.050a0220.55417.04d5.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/mm/gup.c b/mm/gup.c
index 3883b307780e..4caa7c635320 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1998,7 +1998,11 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	struct vm_area_struct *vma = NULL;
 	int locked = 0;
 	long ret = 0;
+	static char poping = 0;
 
+	if (poping)
+		return 0;
+	poping = 1;
 	end = start + len;
 
 	for (nstart = start; nstart < end; nstart = nend) {
@@ -2042,6 +2046,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	}
 	if (locked)
 		mmap_read_unlock(mm);
+	poping = 0;
 	return ret;	/* 0 or negative error code */
 }
 #else /* CONFIG_MMU */


