Return-Path: <linux-kernel+bounces-352695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEACA9922C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 04:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B652817C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC21173F;
	Mon,  7 Oct 2024 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pcyo0awU"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC89EEC9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728268731; cv=none; b=c60o7LFExxoF60Va4CPTqxXBfyZnmyOVQ4L/10xXyx0fENsb36rgptTrSa8NLZtUB/c0/iK/sArlIMM32LAnNzOvGGrny5ynT/Q6q0pfI72wkVMR4TxtwYq07oYuYoqjrrnOBvOxZ0FBZjT9RYImXC+bQvTSx9y6DhDFi/f/E4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728268731; c=relaxed/simple;
	bh=BF+CvxEEzIKBnqImTSchULaCqND2KyS0RX3wB2EUzOY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TjBd7nFRdZ7WEKzc59UnOwni7GUUWHHLbZj0xxrdjSkdbIuueNmHS8NlxoQpf99UiZVzgZmvV9Ua0X4p6mdFGqAVWSAn8HsgG6WmMmiGzodkx4Wl7AymBJMe5PZp0etddA7Jd5/5hBgpZwPf54qqVO2yyWJcIFmfibcjY02W+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=pcyo0awU; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1728268420;
	bh=4HNlod/GQAKS0TpjmtDwCN2HAMVVUR6BW+VdZTEeWBU=;
	h=From:To:Cc:Subject:Date;
	b=pcyo0awUTXbmOiJ9xU95BClM+fXAyfSBDvSRJydI8aAflQen/EpM3k2B3M6+mSbZR
	 AI6l2stII687U5ojKeuZBVw87w8H6KLs+CUOGMF3rG1Whmy4t7ztl4JeFKhpvDFmfQ
	 cgku1Y/54/lf2YZWur45dNhD9IW3ExiCHxBXC/SA=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 51E23C76; Mon, 07 Oct 2024 10:20:30 +0800
X-QQ-mid: xmsmtpt1728267630thsxldi9h
Message-ID: <tencent_4B24C93D2D36F13D40BFA8A5D22919CE3E0A@qq.com>
X-QQ-XMAILINFO: NsqkKhjtZjetOnCa2PejkiGuLYOSTB97ZBazDYG9WFrGYlMEZAHjyp9itfI0Vw
	 9hYovwyn1HVe8CJsSkrKxP1ZKJv3U4DEoXjkzm2Z+Y1KeZCLS0OzJfEEX3CQwooHr8UypXutNv/F
	 lvZmew6WEoGQHGDxuuvXfowOtlxvNthFWTgefFHr/Ug9oCx3pHyvB5gJoVDDnTkAHZjj3JvTKguv
	 dqla0nlfk2CrUEqQhl/qrpQGjAiyz84emV3EuI2HH72QOEamX3jekEepc1eMfPJYXUkjNzttTyNM
	 iMtk6ejnbYz73qle3+Ew/r9AC6ZctYeP46GXBTBF6n8HFRonutj5juyqJmPzLx7JPxeNYOGYMrJd
	 rbsrs5M6IT/sOQLazAipHa7rQnEh/HeFCa44OxXn4j93JcJHAHIoOq+rpSqrXNICxdbWLiiHjyQI
	 rb27G+qs5KVqDj0/thmtYLu4QcyAMvMbaAEXom3EJzEAUYo6ErlAE+AuvX+vfmylu9B0ULGHPwBh
	 sfD4nMKjhfw1BgN8kQjdSDPDhnlg9/wx3TCYZAqspr25UAyEY1K+fT7pUAmg5dowQxomBeinjv3O
	 yiWYqq0xaEag34a9MDq9b9JDBcjv/DonLnSnCOHx+dVoIPrYxCDXQq/xC/65LWLzXyT/TBtG+QX5
	 ZqpLD06K34yrLLQvjoILDZixjlwISlPbZCrDPLGlse2BiMkBHLlH/LeAYb+gzh8TWHpT706Gz1+9
	 g2ini5CyzzaKLrt7JWQ5iIuv4lLzfFE4t5XtkgYNoQJ6MOqMjKbXgmmmFtyJp2fgvE4pn1hxYIEj
	 hIlHM1t0EEU+Yg+lTlvEqQxrO+N/bqe8Vj+mFqGhgLvWHJcZdft3fELJ+cztgynsZI39Kuw1cFOT
	 lcTrXxVV5FbmV1qiPl3gjq4f4rOrPcVJDQ2iASUy+Y5acY0BJPjE4QCANV6TtPKiDTJrudnOIbU0
	 4Q1esHHWn5mw0bqsxOfI44Xqe3l8M30IPbPvAPqfuCJHQHHOGAgyo85fcRDuqlqbQ8wP2mthsxMq
	 TLfAmED72eGiMN8kLlXPqwLQUSO9j/G/bE73iGog==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: Fix incorrect unlock in error path when using SRCU
Date: Mon,  7 Oct 2024 02:20:30 +0000
X-OQ-MSGID: <20241007022030.368955-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the handle_read_event_rsp() function, after switching from RCU to SRCU
for accessing intf->users, the call to rcu_read_unlock() in the error
handling path was overlooked and not updated. According to SRCU usage
rules, srcu_read_unlock() should be used with the index returned by
srcu_read_lock(). Using rcu_read_unlock() instead is incorrect and can
lead to unpredictable behavior, such as data races or synchronization
issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To address this, srcu_read_unlock(&intf->users_srcu, index) is now called
in the error path, ensuring that the SRCU lock is correctly released
using the proper function and index. This prevents potential
synchronization issues and adheres to correct SRCU usage.

Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e12b531f5c2f..3ef46df78cdf 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4426,7 +4426,7 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 
 		recv_msg = ipmi_alloc_recv_msg();
 		if (!recv_msg) {
-			rcu_read_unlock();
+			srcu_read_unlock(&intf->users_srcu, index);
 			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
 						 link) {
 				list_del(&recv_msg->link);
-- 
2.34.1


