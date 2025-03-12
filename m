Return-Path: <linux-kernel+bounces-558212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597FA5E2D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDCF3BD16A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B81E8325;
	Wed, 12 Mar 2025 17:30:27 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC8156C62
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800627; cv=none; b=Ur1TXdOq8dl0P1hFaXc2cVcI7PqpLdDEsfYatsY0D9l5ki8hd5wMFtMzb/iWlaUmdE10BY17KgeuIus1+auu9WjTGr/NkdMhks+m5T7CrboIhR+KNEhukOE3HSw26GmZrEMBP6H4VeQbnz7c6f0Ste9l0QOmRH/3vHEC9L5aKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800627; c=relaxed/simple;
	bh=KxWDkPWGnHmqMDQnBBo7Yerq9+ImTLxqJPNlp9Sr11s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZhCwwPUdi3MdRzC4SQN+WkaycF/RKapWrPajwlgqzqTskPyULo+z749Hz4JHAdEZO2IFMFah681F+pUfhWLSd3tiaLYlwROpPcgPcc9lLqhg5RhlIWJ3p06TQpCvUJm30sjYbM+KMln+Y1IqCWQqm8ry0vR/wF8LfUgF/wbNue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tsPk0-000000006zq-1rZn;
	Wed, 12 Mar 2025 13:19:36 -0400
Date: Wed, 12 Mar 2025 13:19:32 -0400
From: Rik van Riel <riel@surriel.com>
To: Corey Minyard <corey@minyard.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: [PATCH] ipmi: fix suspicious RCU usage warning
Message-ID: <20250312131932.44d901f7@fangorn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

On recent kernels this warning fires:

drivers/char/ipmi/ipmi_msghandler.c:1238 RCU-list traversed in non-reader section!!

This looks like a fairly simple lockdep trigger, where
list_for_each_entry_rcu and list_for_each_entry_srcu are
functionally identical, but the lockdep annotation in
the former has an extra check.

That extra check is whether the RCU read lock is held,
which is not true when the code uses srcu_read_lock.

Get rid of the warning by using the properly annotated
list traversal macro.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 1e5313748f8b..a2823763fd37 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1235,7 +1235,7 @@ int ipmi_create_user(unsigned int          if_num,
 		return -ENOMEM;
 
 	index = srcu_read_lock(&ipmi_interfaces_srcu);
-	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+	list_for_each_entry_srcu(intf, &ipmi_interfaces, link) {
 		if (intf->intf_num == if_num)
 			goto found;
 	}
-- 
2.48.1


