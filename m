Return-Path: <linux-kernel+bounces-196113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7D8D577B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC70C1F24085
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6AED29E;
	Fri, 31 May 2024 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNPUYaOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD847483;
	Fri, 31 May 2024 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117416; cv=none; b=JboSYGK8XXab+gm5SdEmlzg1TXdeDJEr7zTF1FWH5ZKnCDlqLU1h1Hp9O9Ne7pBfbPt3wu3j/OSC7NADTsyTyIi1MKltnuGMaTFQiwdCqxs8fI57bHfzUPbRfIxpeNaPVo/GPclYhERTFimShYsn9Ox9pXQWNTAa0Vw7Aut8/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117416; c=relaxed/simple;
	bh=MhZFv6QxVQ1ubVbKQDF07E67+FwUvci9ncljfLMfprc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgZMWiciCJK9dGLK0xt491eOpgeQwhyYRD1BRoYBl7bEcm95rD91XJ+MCMtv/a+3L5ghEIieaRTI+c3lbUibYSopy3t9ik1ysW6l6h6S6PIYyc9Y3GIeFR311+hpAZ8HglrCRsPBJ0RLOBIeBLiT514ejI5L1mIN0YHAtjeRwHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNPUYaOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C31C2BBFC;
	Fri, 31 May 2024 01:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717117416;
	bh=MhZFv6QxVQ1ubVbKQDF07E67+FwUvci9ncljfLMfprc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HNPUYaOPXEaNmxKOw0i9msGwW9I1KiIe95rvYMFVLnIcKLz0HDfZmgui6n3GuoNNO
	 irs6OXRqyVteiTco2B0B1uKn4AuD8JXh22ScXG76/dk+t3njEUKloytgansoyzxitb
	 CaJ5otOo4ixz7op7Pqvdi5Oq16auxhc1w10iJXEOaBmabVaVwNLRQlIlHtrNaLfBmD
	 nPPT2xVILLc6PLEuWEBHNjTb7YwvjKDi38no6GyZXMadtr3wxQWFO3vSC/f/ivDds4
	 QGqn0ktcCsRNfApu8CHaEqLNjmS+YYPyNvmFCLIEq8qJaWFySDiWJE1jRSiXzrchMk
	 3eF07m6eVIT9Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 30 May 2024 20:03:27 -0500
Subject: [PATCH 1/3] of: Add an iterator to walk up parent nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-dt-interrupt-map-fix-v1-1-2331d8732f08@kernel.org>
References: <20240530-dt-interrupt-map-fix-v1-0-2331d8732f08@kernel.org>
In-Reply-To: <20240530-dt-interrupt-map-fix-v1-0-2331d8732f08@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14-dev

Similar to other node iterators, add one for walking up parent
nodes. The iterator starts on the current node, not the immediate
parent as that seems to be the common case and starting with the parent
node can be implemented like this:

for_each_parent_of_node_scoped(parent, of_get_parent(node))

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 include/linux/of.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index a0bedd038a05..c322802dfc2b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1482,6 +1482,11 @@ static inline int of_property_read_s32(const struct device_node *np,
 	     child != NULL;						\
 	     child = of_get_next_available_child(parent, child))
 
+#define for_each_parent_of_node_scoped(parent, node) \
+	for (struct device_node *parent __free(device_node) = \
+	     of_node_get(node) ; \
+	     parent; parent = of_get_next_parent(parent))
+
 #define for_each_of_cpu_node(cpu) \
 	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
 	     cpu = of_get_next_cpu_node(cpu))

-- 
2.43.0


