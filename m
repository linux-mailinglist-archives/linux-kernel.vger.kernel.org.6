Return-Path: <linux-kernel+bounces-243404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A78929295D4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315F9B21DE6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6AE6BFB0;
	Sat,  6 Jul 2024 23:14:01 +0000 (UTC)
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1012E62D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720307641; cv=none; b=S0+B1AQw72PNkXMR4VljuNuYjMl48IYtJPoXSbGEd6QCykyUdJmLqM2mcOLQL0oPjRDsMHZ5pMhOZtGmIZvbQusnkuIkN7UtmJT4Whit2rzet9Nj5WCSUolPTet29NnYzjFtoL3C++bu3eCcvOwz5vXWS2tbN5zVIBIjhx7ZwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720307641; c=relaxed/simple;
	bh=nEiFOK7ChlcBknrN/z0O9/jd31w7uK1R7R4TCNyBydM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cmZrHjr3crEswQaeKsseY27ZKJy1JDs9FzlpOZVTzZAjyLkEm3KMLIenQAVdBtQ06Gzym+YWf0gzzcEwVFiVQSxZJdjDxjzz7oO6oUcdCK19Iw0i2z0tycY3MZfhd+oebxA3dLgJILdNsKRsb7HwPNt00Te6L7Fwht1Sdo8qhrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.88])
	by sina.com (10.185.250.21) with ESMTP
	id 6689CFA500003E18; Sat, 7 Jul 2024 07:13:43 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9931173408335
X-SMAIL-UIID: 0FC830728DAE46DFAF5BCF6000BC4C4C-20240707-071343-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
Date: Sun,  7 Jul 2024 07:13:32 +0800
Message-Id: <20240706231332.3261-1-hdanton@sina.com>
In-Reply-To: <000000000000aa1dbb061c354fe6@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git  1c5fc27bc48a

--- x/net/netfilter/nf_tables_api.c
+++ y/net/netfilter/nf_tables_api.c
@@ -11552,9 +11552,10 @@ static int nft_rcv_nl_event(struct notif
 
 	gc_seq = nft_gc_seq_begin(nft_net);
 
-	if (!list_empty(&nf_tables_destroy_list))
-		nf_tables_trans_destroy_flush_work();
+	nf_tables_trans_destroy_flush_work();
 again:
+	WARN_ON(!list_empty(&nft_net->commit_list) || !list_empty(&nf_tables_destroy_list));
+
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (nft_table_has_owner(table) &&
 		    n->portid == table->nlpid) {
--

