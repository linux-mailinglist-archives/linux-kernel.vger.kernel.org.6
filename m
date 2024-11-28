Return-Path: <linux-kernel+bounces-424496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3809DB4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848C3168A07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB43619ABCE;
	Thu, 28 Nov 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="THE9Y7Tt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D18158534;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787050; cv=none; b=Hd+MdxcYbAccgfFA41tKFgUXx7T18wbvYafRBrDhrKB618ciOQ82ATDZAF2Rl9T4Ap4rQ2fcdr68IAoZzeKw61V48G844LPMlsyno2ESn8bQPZ7TbvS4vVGqszsaaTgZPavXhnC1Cz8CG1BGEQnRUMw06KMv63j6YftxXH8WW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787050; c=relaxed/simple;
	bh=rUzQRY4Upk9ByEG9JLJSw+zikD2MXdRxtqUBIQZFLPc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sOJo3ajKKqyPlRWkUF/vVg0Ej+QOrLLVJyuEUe1K6qYGxRjJApiRs3wU173R6JrvUNX9j9GEfXs/SdIwXiC8H/zd8fFJPRm08TFXuOXr/zcLRrDgZQ2NiBRy81ixqE0eGhi8XK8Qw2kp39+mD9g7AdVcHkshDmy3ANHItdtC7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=THE9Y7Tt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=TyR7Y3IB+rDfjHmcbI/1IKsZPSstvP5IWO/FJAgpT78=; b=THE9Y7TtDSYNrZQVeNFMZXILJm
	Ejq8U+pKWx8vhUjkODIhdToP/qshojJaMK4lQVsOJgiQsLjHnZTu9isXR5n8M2nzHBGM9ee43lB9x
	boMBtifFpjmPNYg/hrK5T9g2Q28MgHrXj1W1YLTcy10ymNP8c0FtLJkxGvSPzHjEi3KsAdBZLMe8a
	QzUgTBKveyPzadCf/jfrZ/89U7euKsl6Wqs/k+JikWAa9gqLrlg/wT4bsnCynfujFjt90RdKZRq5n
	gGJ3Z+4t0DvayMZf3XwDwJom3+SL540XOIvKQ43kRuNSWV/vj8abqQSUbxoNZBlYy1YziZ9ycGqk+
	tRz0CsZw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb48-00000001a8A-42bR;
	Thu, 28 Nov 2024 09:44:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 38AA4301D03; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094312.611961175@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:39:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/16] objtool: Warn about unknown annotation types
References: <20241128093851.469225872@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2335,6 +2335,10 @@ static int __annotate_ifc(struct objtool
 static int __annotate_late(struct objtool_file *file, int type, struct instruction *insn)
 {
 	switch (type) {
+	case ANNOTYPE_NOENDBR:
+		/* early */
+		break;
+
 	case ANNOTYPE_RETPOLINE_SAFE:
 		if (insn->type != INSN_JUMP_DYNAMIC &&
 		    insn->type != INSN_CALL_DYNAMIC &&
@@ -2359,11 +2363,20 @@ static int __annotate_late(struct objtoo
 		insn->unret = 1;
 		break;
 
+	case ANNOTYPE_IGNORE_ALTS:
+		/* early */
+		break;
+
+	case ANNOTYPE_INTRA_FUNCTION_CALL:
+		/* ifc */
+		break;
+
 	case ANNOTYPE_REACHABLE:
 		insn->dead_end = false;
 		break;
 
 	default:
+		WARN_INSN(insn, "Unknown annotation type: %d", type);
 		break;
 	}
 



