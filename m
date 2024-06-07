Return-Path: <linux-kernel+bounces-206782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E649900DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D0C287E47
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C0155738;
	Fri,  7 Jun 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z9DKg3SF"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DC1552F9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796480; cv=none; b=MPy3MQBSzCnMMZlQxQkaz3mG4VzvFlysQo1/9/Ih4lRSbYOZFJZfaXyG6AernsI2/Lfjz3bevGrCerVnE1GAGoJEBxFXI/SVQa12xwiPoGuVWkU0zmwSh87jhFTtuhfRWpCcGqNuWpbse6g2zGLTjX/exIKTB3U4Vw3afqAUXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796480; c=relaxed/simple;
	bh=+zDHm0gqEYnNElTfpQqNXDS5sE+4HW2XfxQCpQQCbSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyQHtQf02d7HCLiK9d7994oV2xRtwK1dOu5UMmT4AwVERee3vBEfBKeAIUVWkY2NRQ142MbLwCQrYICtx8cslcmOkObl1mNrg+j33WYymt1Zv837JVwbUGnKP/fiBKyw2LmZ5QZ6lgMwDAhlXlvTL4HFWCXc2Mx0BFMUGsRAHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z9DKg3SF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f47f07acd3so24557195ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717796478; x=1718401278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6hr5Pgg5LYV8IvTkAUUqijfPi8ple/giWX7dtweBwU=;
        b=Z9DKg3SFZv5D/L1UQYIGoZFTmyjArQ+DavEzSWG/A77KkhIYYrzIKCXeChJFXL3HrI
         q0ocBiSI0p7j7VheYjrOKzdy91QRGaZSsGsZF+6Pa05N38HKd1k0NA6l+2MyX5ehLhhh
         uxYxtc/y64gC8zpMQUhC7YDDSQhWokBTiKfsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717796478; x=1718401278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6hr5Pgg5LYV8IvTkAUUqijfPi8ple/giWX7dtweBwU=;
        b=HIXjVrhgA9qqHxRpy6C1xlPUonTHNbwRKE8iJtkFfcAPOmtN/AsFCNyTaA0qFP+oN/
         wvttiJC3UNDZY5IEYR8W66f5GOCrcsT42wzsdRDVe44QwfcJbId4Gb47/Gry9KqgD6W/
         APlLirXXwQWYVAtJHALHgTZ7sfKFPJyDzGu5C67cCXYAxc6oCXEJNUbZq/oQZxcx8YQB
         5BpttBcck0WmQzacwjkMFA48RtAhsv+l6KrYop/Po1Dm5LKxIzxOK5kYW4rvDbbQeu5w
         dsrjFX8vifn3Y1bVeMlV2sNJ3eEJjx/v4/nlzZ/ipzMItYxvcKP23QJ26/Hw0yE/GijU
         ezag==
X-Forwarded-Encrypted: i=1; AJvYcCUo8zoQNMu9jO/++1oQfjalqtCdBNZ61Keg5pUAiROghpHBWC5yrswCOK89x0BDUvkwIWDzEfXRT2x3BzW8tjHhNeUZ9VrpNATqOajd
X-Gm-Message-State: AOJu0YywyqVi7Kkk9Dji3e33CnDVYNEPyaMGrJqmlYFzML9ji0Ujjv2J
	PtAn4XJiDChq6MGRXwVS+w7KjTP337EMJTTY3y7np4KnAGvXNnroLoXrB2PfmEdeOTI7ujW97CW
	L8w==
X-Google-Smtp-Source: AGHT+IGiZCcvwDTTBj7Ig57bQR4C0/0ASjRxvCbyRtjYCP4HgXPQ023nqZONfn0Hr6ef/ygn+LzbUg==
X-Received: by 2002:a17:902:c94f:b0:1f6:8a19:4562 with SMTP id d9443c01a7336-1f6dfc426d6mr27231345ad.24.1717796478156;
        Fri, 07 Jun 2024 14:41:18 -0700 (PDT)
Received: from ubuntu-vm.dhcp.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e189fsm38946805ad.215.2024.06.07.14.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:41:17 -0700 (PDT)
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
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Kuntal Nayak <kuntal.nayak@broadcom.com>
Subject: [PATCH 2/2 v5.10] netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()
Date: Fri,  7 Jun 2024 14:37:35 -0700
Message-Id: <20240607213735.46127-2-kuntal.nayak@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607213735.46127-1-kuntal.nayak@broadcom.com>
References: <20240607213735.46127-1-kuntal.nayak@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ziyang Xuan <william.xuanziyang@huawei.com>

[ upstream commit d78d867dcea69c328db30df665be5be7d0148484 ]

nft_unregister_obj() can concurrent with __nft_obj_type_get(),
and there is not any protection when iterate over nf_tables_objects
list in __nft_obj_type_get(). Therefore, there is potential data-race
of nf_tables_objects list entry.

Use list_for_each_entry_rcu() to iterate over nf_tables_objects
list in __nft_obj_type_get(), and use rcu_read_lock() in the caller
nft_obj_type_get() to protect the entire type query process.

Fixes: e50092404c1b ("netfilter: nf_tables: add stateful objects")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Kuntal Nayak <kuntal.nayak@broadcom.com>
---
 net/netfilter/nf_tables_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index de56f25dc..f3cb5c920 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6238,7 +6238,7 @@ static const struct nft_object_type *__nft_obj_type_get(u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
-	list_for_each_entry(type, &nf_tables_objects, list) {
+	list_for_each_entry_rcu(type, &nf_tables_objects, list) {
 		if (type->family != NFPROTO_UNSPEC &&
 		    type->family != family)
 			continue;
@@ -6254,9 +6254,13 @@ nft_obj_type_get(struct net *net, u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
+	rcu_read_lock();
 	type = __nft_obj_type_get(objtype, family);
-	if (type != NULL && try_module_get(type->owner))
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
-- 
2.39.3


