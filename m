Return-Path: <linux-kernel+bounces-337678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF82984D67
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67526284796
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4391A725B;
	Tue, 24 Sep 2024 22:09:10 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E613D89D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215750; cv=none; b=au+UiMFCcYt/TMmbvh5PgTKDZ6FTAFSVt+66ea0Ea0B4Koz3Rhgx5OZa5b9rxqZY0kmDe1kmu9/fSMWKYovZSzsVfrmIkBpAe1fJkoK1a6abwJ47+pUDImcZiN3N5fqWDkLHB7LVDrBYi/z/eKlj2O+dQksnjbpXbOVa0zjMnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215750; c=relaxed/simple;
	bh=3vyFvdQLgIjxw0/sDJE5bvn2Yxn9LGTBZ4XqEBV6bfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XDWm+XplnyCp/EXjUjdPzeRHIajOKV3VDnyb6uFEovNkFFaU30Hsn5pSSZTDjQPPik/9tNbdKCZTO1e3410qi/Juv0BKfkd2AAT04bkJhiMe//9CVYQiEYfq5rO+x6QFbj07agXctuOgTmWPOZvCAGc5zXMi0U1UQM8pFwWHdBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1stDZx-000000003hY-3pp7;
	Tue, 24 Sep 2024 18:00:17 -0400
Date: Tue, 24 Sep 2024 18:00:13 -0400
From: Rik van Riel <riel@surriel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH] x86,cpu: add X86_FEATURE_INVLPGB flag
Message-ID: <20240924180013.388c1699@imladris.surriel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

Add the definition for the X86_FEATURE_INVLPGB CPUID flag.

Tested by booting a kernel with this change on an AMD Milan system,
and making sure the "invlpgb" flag shows up in /proc/cpuinfo

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd4682857c12..9a98cc7ded39 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -335,6 +335,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* "clzero" CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* "irperf" Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* "xsaveerptr" Always save/restore FP error pointers */
+#define X86_FEATURE_INVLPGB		(13*32+ 3) /* "invlpgb" INVLPGB instruction */
 #define X86_FEATURE_RDPRU		(13*32+ 4) /* "rdpru" Read processor register at user level */
 #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* "wbnoinvd" WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
-- 
2.45.2



