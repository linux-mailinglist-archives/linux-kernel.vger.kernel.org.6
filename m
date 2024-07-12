Return-Path: <linux-kernel+bounces-250091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4C192F426
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F23628339E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4261BE68;
	Fri, 12 Jul 2024 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="lz8yYnWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1B8jHJ4"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B179D0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752310; cv=none; b=XT5+IXpbw6RHanZUbOSJD9yFkLwQPn0G24RSCPCkGVkSt1C35PWGVv74moQCImz+FbNTYg9OT4JrlPqKx67yjtrIPWEOCvzba5FizPOiUCAF7R2QiOKwbV7dmT6t8qhaH8edNzyz14QcrNMfOFkNM9LS9QaRSx1DqhnKJlwFxiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752310; c=relaxed/simple;
	bh=nbvpJQzFIg23rNR8yhUFc2jwjZR2DQm8DGNmSgSF76A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo1P1hvTqMfjUjMGDm1q2iFXkvahELH60ioEXP4280xUJSXHQdX6J+okKrKFvGTH9+pYm78m0U2+Z2hw/R0lsSOdynPXzlXi6LSJf+0k+ILq12fpdhy4RGkUKgLYJsNezG/CBFKPI9ydv8plVX413IrU+UHgv/3C7vLLdtnGIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=lz8yYnWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1B8jHJ4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5CDE01388638;
	Thu, 11 Jul 2024 22:45:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jul 2024 22:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1720752307;
	 x=1720838707; bh=jNGroiyo4BuTb3hCWpWux7PfCpk0jLOtvpYsdbCWP/I=; b=
	lz8yYnWlO09wfHb83ln8BKkBoq5gRUQUwFV6dKkRSNHwT4rFIM9zWzLIqahj4zcY
	nIKYIY0qBuykHnAcw9kWMVsgUcfpGapKaEEYwFcjePBPb9J+vOKMqVWSuhQdCUgi
	X/ywcj41J/8GmeqbecKCObHP2Gl3Zr1ZqExtA96VyEde9CU/pdggiB24rp7Ynkr3
	KmvsfUc7zb0dwxGPPC5RGBYlTmzbvDgrDGjuoYWCIjKEyIi2CsDuZ8gZCHfRMDAy
	iA7+METH6x27l+qkdLRd79V01z1npc7+W91QR4PbAE2opafwTdtzGiAXOodyqxH/
	P+RcVgx5iCn98RjXD2Wk8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720752307; x=
	1720838707; bh=jNGroiyo4BuTb3hCWpWux7PfCpk0jLOtvpYsdbCWP/I=; b=F
	1B8jHJ4ViBoTClRPWsQtEFz8ORDTWX/HBWUZXJMc/mK0/CscC9ecK2cnFdnms0Be
	Di/RSin7dfh9ANGM62MH/uM50t0aqSb1MHPuEYdPLltOQ15RQGlK0fnZVZGRt97l
	VE31CoxTR5wQr+uQojH/Oy1DWxLiiC80wUV7S7nzO3hbRu1IXbvqTq2JlXFJd5de
	aGcgLCth+TsO3jtZOGz0cqf/9IFDBzNrZP83iQ5jAddkb2UXrMHU0OurI1IE7twH
	t/zF5WbD9PIw2WTeQ2QEpLUvG8j901OJkltRg91Lsk1qggqlaE5i2tb4TNhXt3Ru
	ZojyNMaWjOD7ZZ300CnuQ==
X-ME-Sender: <xms:spiQZtiaZFgz5zC_lyuyIh32684g0gz93_7tpze3zqnLUjt2vCCOYg>
    <xme:spiQZiAaCl2OFB-x7KQWTGcB9weIHlyX3y5sammra34VDDAe3pg2oTCHKTYE3TrdT
    vRLV6XyJYYCM_kZxg>
X-ME-Received: <xmr:spiQZtE3pn28pCJP32hU44h1tOKro7qWY3dZz3XwYS3qSOq3BCrzRpLICdUh1jPKnUD6HXpc2WnmhLb4bepgstnmgMroTNr4-4eTyfwqt_phk-GFsFnS0mU5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepudfgfe
    elhfekiefgtedvudfghfduffefieefffejvefhlefhhffgkedtfeevhfevnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:spiQZiT2es1XWHRLfeyb5XkpgXgwccW9RnhcGrMCsec1uplwkrPdug>
    <xmx:spiQZqzp8lOv2x0ruNX1kAlJjfFO0-3TaW3Ab9-NO-GJzMldc9677g>
    <xmx:spiQZo6i1A__HUnyePtFOlA40GtjJ22MjfgDWeVFDV9ZVoT4d8MEbw>
    <xmx:spiQZvxbGjm0oyAcSJjhEXFxX2JS8jyPQXcHwurTWdkqehz7EQuCpw>
    <xmx:s5iQZlxsrnzbmaaLgsJXf39fF2rrIvDM_eySAZEspemSHBfn39q3ZrIt>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 22:45:05 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] memory tiering: read last_cpupid correctly in do_huge_pmd_numa_page()
Date: Thu, 11 Jul 2024 22:44:53 -0400
Message-ID: <20240712024455.163543-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712024455.163543-1-zi.yan@sent.com>
References: <20240712024455.163543-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

last_cpupid is only available when memory tiering is off or the folio
is in toptier node. Complete the check to read last_cpupid when it is
available.

Before the fix, the default last_cpupid will be used even if memory
tiering mode is turned off at runtime instead of the actual value. This
can prevent task_numa_fault() from getting right numa fault stats, but
should not cause any crash. User might see performance changes after the
fix.

Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d7c84480f1a4..07d9dde4ca33 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1705,7 +1705,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (node_is_toptier(nid))
+	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
+	    node_is_toptier(nid))
 		last_cpupid = folio_last_cpupid(folio);
 	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE)
-- 
2.43.0


