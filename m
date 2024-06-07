Return-Path: <linux-kernel+bounces-206781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF85900D9C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EFF1F230C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F315535D;
	Fri,  7 Jun 2024 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="er0iEPlp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F20155341
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796474; cv=none; b=d6TmfeH+Yjw9cYliEMT+W5I6nnK9B2xJaS56Gdpg8TYDSYDPs9plJuYTb+80WfBJvRyOc0i8jX2mhrW/+NoILLApLmLuQnMPVtpsqt9qfIw3sfDO4hmk9R9p+6XwMMX8vpzr+y5hdAhYfdCTbJtBO0yG1CXxwHs4wyWHRbArCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796474; c=relaxed/simple;
	bh=9ZiKY8Epob/6giwpHNtQhhAEigUlPvpphA0MlyV4bx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QenVTXZcS3E4WCKu0CEhEqZHbNX16sHPYHNcwOO6e/2LcYu1RJqdE2C9xJ6ssYMLcG7Ri0xT/XhQJqy2tsABMD1zhdqojDkGx2mLeVJyxAPjtMTI7Op0Z1/Ie/QbvOJJ1GF3Len+C83z4PY6zNDwGuWxtD1bdoatk7udrLSVPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=er0iEPlp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f4c7b022f8so23956585ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717796472; x=1718401272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6rtEKQFLHrlHDJmkNDb3CDrkqX4wEACzExxiz6etLTM=;
        b=er0iEPlpZMNIBW8yqVIQvtdvxVeH9Ipzh8fKrdBbx0kxHxED+GTqHjqOemrJVujUgw
         3IH/mwSqQxblNbLPGqANcSo4UFCPV0Tr12JvIuWW6Vw1rC/0Lqi7XF8zwdQ5peKbY75u
         XyQ9biIegTACFMKoheCF1DnTgIREyfallX2Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717796472; x=1718401272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rtEKQFLHrlHDJmkNDb3CDrkqX4wEACzExxiz6etLTM=;
        b=bJ0cmNg5EAb/pQYjVYkrmPoceWYmnbnJ7nu/NrRCNbFEKPIehWbAibByl5TeHVDDwy
         3jhSKm7A8Pw/q/5JMvjsZaOCwoCdfKqwOFwYRMEBI1YHHkLckkcFfcSd69c252IwKNa3
         kdtMunhH8gusRl6HWZdQWFEPGKZ7uPXxaTBfy/d3woem42AhjcnuocBU3YH6Bw8pPKp1
         K9NG0G75T1vNYM/e7kADVG8D+J7yXUIheP3TzoVZn4ULqPi6AlphxCkVVQrEwGVDKTP6
         OSlZ+PIjs7UZKX2Y5SorJR7VWRwwqWl7CpiPWO4mp8b6DQH3ske/znLrx3+8o52Ed099
         pJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNGdhOCWssSPyz/BuH/HPIfV+jjoh4Lu6/D/MzXwoqm1Ap0zZXJoU7gw8nlCxFPoFY6NxEeIYTw3L3HG4rAzC5y8qBPr2x4FbbGBde
X-Gm-Message-State: AOJu0YwCDcbfNGb68BhWrzOg64uGBwcDfkClGY574JR3pbefiwWx3SCE
	K+ocqjui4bdfJif66hqOa+gsTs2KqiDWfjARqKXm0WF6ZM1+V0aJP9OvDTAe5Q==
X-Google-Smtp-Source: AGHT+IEhB0e/xeVbB/SJ0/O4X/sDV0ptLoLnyUoA1V/jZ3LOegzIrzlkFMAUJeY8ot2co/j616uTcw==
X-Received: by 2002:a17:902:ea12:b0:1f6:70d6:d49a with SMTP id d9443c01a7336-1f6d02c0563mr46888165ad.11.1717796471979;
        Fri, 07 Jun 2024 14:41:11 -0700 (PDT)
Received: from ubuntu-vm.dhcp.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e189fsm38946805ad.215.2024.06.07.14.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:41:11 -0700 (PDT)
From: Kuntal Nayak <kuntal.nayak@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	kuba@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Kuntal Nayak <kuntal.nayak@broadcom.com>
Subject: [PATCH 1/2 v5.10] netfilter: nf_tables: restrict tunnel object to NFPROTO_NETDEV
Date: Fri,  7 Jun 2024 14:37:34 -0700
Message-Id: <20240607213735.46127-1-kuntal.nayak@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ upstream commit 776d451648443f9884be4a1b4e38e8faf1c621f9 ]

Bail out on using the tunnel dst template from other than netdev family.
Add the infrastructure to check for the family in objects.

Fixes: af308b94a2a4 ("netfilter: nf_tables: add tunnel support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[KN: Backport patch according to v5.10.x source]
Signed-off-by: Kuntal Nayak <kuntal.nayak@broadcom.com>
---
 include/net/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c     | 14 +++++++++-----
 net/netfilter/nft_tunnel.c        |  1 +
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2da11d8c0..ab8d84775 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1174,6 +1174,7 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
  *	@type: stateful object numeric type
  *	@owner: module owner
  *	@maxattr: maximum netlink attribute
+ *	@family: address family for AF-specific object types
  *	@policy: netlink attribute policy
  */
 struct nft_object_type {
@@ -1183,6 +1184,7 @@ struct nft_object_type {
 	struct list_head		list;
 	u32				type;
 	unsigned int                    maxattr;
+	u8				family;
 	struct module			*owner;
 	const struct nla_policy		*policy;
 };
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 858d09b54..de56f25dc 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6234,11 +6234,15 @@ static int nft_object_dump(struct sk_buff *skb, unsigned int attr,
 	return -1;
 }
 
-static const struct nft_object_type *__nft_obj_type_get(u32 objtype)
+static const struct nft_object_type *__nft_obj_type_get(u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
 	list_for_each_entry(type, &nf_tables_objects, list) {
+		if (type->family != NFPROTO_UNSPEC &&
+		    type->family != family)
+			continue;
+
 		if (objtype == type->type)
 			return type;
 	}
@@ -6246,11 +6250,11 @@ static const struct nft_object_type *__nft_obj_type_get(u32 objtype)
 }
 
 static const struct nft_object_type *
-nft_obj_type_get(struct net *net, u32 objtype)
+nft_obj_type_get(struct net *net, u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
-	type = __nft_obj_type_get(objtype);
+	type = __nft_obj_type_get(objtype, family);
 	if (type != NULL && try_module_get(type->owner))
 		return type;
 
@@ -6343,7 +6347,7 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 		if (nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
-		type = __nft_obj_type_get(objtype);
+		type = __nft_obj_type_get(objtype, family);
 		nft_ctx_init(&ctx, net, skb, nlh, family, table, NULL, nla);
 
 		return nf_tables_updobj(&ctx, type, nla[NFTA_OBJ_DATA], obj);
@@ -6354,7 +6358,7 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 	if (!nft_use_inc(&table->use))
 		return -EMFILE;
 
-	type = nft_obj_type_get(net, objtype);
+	type = nft_obj_type_get(net, objtype, family);
 	if (IS_ERR(type)) {
 		err = PTR_ERR(type);
 		goto err_type;
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 2ee50996d..c8822fa81 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -684,6 +684,7 @@ static const struct nft_object_ops nft_tunnel_obj_ops = {
 
 static struct nft_object_type nft_tunnel_obj_type __read_mostly = {
 	.type		= NFT_OBJECT_TUNNEL,
+	.family		= NFPROTO_NETDEV,
 	.ops		= &nft_tunnel_obj_ops,
 	.maxattr	= NFTA_TUNNEL_KEY_MAX,
 	.policy		= nft_tunnel_key_policy,
-- 
2.39.3


