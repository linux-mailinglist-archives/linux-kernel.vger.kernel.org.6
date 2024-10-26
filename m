Return-Path: <linux-kernel+bounces-383261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7BD9B1923
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248FBB21862
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBEE3526E;
	Sat, 26 Oct 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JMw10nE0"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3E725762
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956810; cv=none; b=sQ7MB4ND7SFJIBTXO9hU1jb1nyLzPwqRLKQX3eGZwIChvmriohecz3DXKtzfXg6SEVezfLdQpgujy+5xA14gvjeV0GAI7uYxGZKht8RD26veys/IMn7J0hIJ/AP/r16c6eHw5ABSJ5FoDs7hO0OoHkBUkpi01kR4pfxdIB0EaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956810; c=relaxed/simple;
	bh=ES/cqD2p2o1AaKt3Q0m3rWlXqZh0LWoI/Ob6e/dSvXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpEOfO4hjsjG6/aQThCowMHmld7dHSc75HY3Mnj/qN35oa9kdSLRzvhONLptNAkkhG3SRYLDT/HoEKM++r3qi3WbIcov9zo0azDp7OrJIaBqwgqvdXogyn9xlJV02aT6H9i4TBnfmlTngMnqD9g7BsOd5mLHj25fKATWSzewdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JMw10nE0; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729956804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K481PHE5yLkfGo1x9EhvwPjmRSOJ6yqeciPBZ8LxanM=;
	b=JMw10nE0UBbHTOdIKBDYOgtbTxvgm8KbfLsVTnybQqRvHcqNwFN5GeoAjhjpW9we71W1Px
	xUKP2cT44ozS/9F4qjsE++d9n/ptpjKl9eQNq5jmUnsasT2p7ek1ALl6sQvCwjBR69wllT
	tllQjh6zxqw4Ih7Lk4SVv6ZsiwFfiwc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Gou Hao <gouhao@uniontech.com>,
	Mina Almasry <almasrymina@google.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: Use str_yes_no() helper function
Date: Sat, 26 Oct 2024 17:28:46 +0200
Message-ID: <20241026152847.133885-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use str_yes_no() instead of str_no_yes() as suggested by Willem de Bruijn
- Link to v1: https://lore.kernel.org/r/20241026112946.129310-2-thorsten.blum@linux.dev/
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 039be95c40cf..f753f87d0715 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4140,7 +4140,7 @@ static long sock_prot_memory_allocated(struct proto *proto)
 static const char *sock_prot_memory_pressure(struct proto *proto)
 {
 	return proto->memory_pressure != NULL ?
-	proto_memory_pressure(proto) ? "yes" : "no" : "NI";
+		str_yes_no(proto_memory_pressure(proto)) : "NI";
 }
 
 static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
@@ -4154,7 +4154,7 @@ static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 		   sock_prot_memory_allocated(proto),
 		   sock_prot_memory_pressure(proto),
 		   proto->max_header,
-		   proto->slab == NULL ? "no" : "yes",
+		   str_yes_no(proto->slab),
 		   module_name(proto->owner),
 		   proto_method_implemented(proto->close),
 		   proto_method_implemented(proto->connect),
-- 
2.47.0


