Return-Path: <linux-kernel+bounces-195331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42378D4B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEF1285E09
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478017FAD1;
	Thu, 30 May 2024 11:57:58 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B217FACC
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070277; cv=none; b=BjWuAh5GLxlIZfbI6aFj/6Q1wAmcYNvERQKwuJHJJxyGgBEywVP8Sf5MuXk5ywEkqvGl575L60M+f+FlOhbDuCjC/3UaCMf9yZ1AZmkK/dV871Pe0pljduZcOeNUmBjpiFuD/obTuW0MVebXAKGS210PrFw4qZyxCpWxtVy3Yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070277; c=relaxed/simple;
	bh=qM8jmV9rQExnfzLYmOc5G2jyjto1w9Z/eyBvilTd+aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pppTcCPzXeWIEsvWJJmxC01Fu+mvMhZg1Vtv48HIY5J1BKWAI6A+vfWS37LNJX8l8op7E6z9x4k6qo4wwQMimtxOOLzI6KxQsJLrixHkuqmX/PL6rag5UOEwywPg8RQyNy/P6NLPs19fxKQA2HORgmH1zQMTONJbyFFaWuUtm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.5])
	by sina.com (10.185.250.21) with ESMTP
	id 665869AF00005C02; Thu, 30 May 2024 19:57:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8080313408455
X-SMAIL-UIID: 008BA0A009C64C32BE6D3B37009A59D9-20240530-195737-1
From: Hillf Danton <hdanton@sina.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	radoslaw.zielonek@gmail.com,
	syzkaller-bugs@googlegroups.com,
	vinicius.gomes@intel.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Date: Thu, 30 May 2024 19:57:26 +0800
Message-Id: <20240530115726.3151-1-hdanton@sina.com>
In-Reply-To: <20240530003325.h35jkwdm7mifcnc2@skbuf>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 30 May 2024 03:33:25 +0300 Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> What is the fact that you submitted only my patch 1/2 for syzbot testing
> supposed to prove? It is the second patch (2/2) that addresses what has
> been reported here;

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git  main

--- x/net/sched/sch_taprio.c
+++ y/net/sched/sch_taprio.c
@@ -1151,11 +1151,6 @@ static int parse_taprio_schedule(struct
 		list_for_each_entry(entry, &new->entries, list)
 			cycle = ktime_add_ns(cycle, entry->interval);
 
-		if (!cycle) {
-			NL_SET_ERR_MSG(extack, "'cycle_time' can never be 0");
-			return -EINVAL;
-		}
-
 		if (cycle < 0 || cycle > INT_MAX) {
 			NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
 			return -EINVAL;
@@ -1164,6 +1159,11 @@ static int parse_taprio_schedule(struct
 		new->cycle_time = cycle;
 	}
 
+	if (new->cycle_time < new->num_entries * length_to_duration(q, ETH_ZLEN)) {
+		NL_SET_ERR_MSG(extack, "'cycle_time' is too small");
+		return -EINVAL;
+	}
+
 	taprio_calculate_gate_durations(q, new);
 
 	return 0;
@@ -1848,6 +1848,9 @@ static int taprio_change(struct Qdisc *s
 	}
 	q->flags = taprio_flags;
 
+	/* Needed for length_to_duration() during netlink attribute parsing */
+	taprio_set_picos_per_byte(dev, q);
+
 	err = taprio_parse_mqprio_opt(dev, mqprio, extack, q->flags);
 	if (err < 0)
 		return err;
@@ -1907,7 +1910,6 @@ static int taprio_change(struct Qdisc *s
 	if (err < 0)
 		goto free_sched;
 
-	taprio_set_picos_per_byte(dev, q);
 	taprio_update_queue_max_sdu(q, new_admin, stab);
 
 	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
--

