Return-Path: <linux-kernel+bounces-263115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9DA93D13A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A2C1C2170F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01B178CC5;
	Fri, 26 Jul 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KMjS9/mx"
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29917176240
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990014; cv=none; b=uNoOG9KjWhouFKRFAd17cDdlBspGie2Y28GQ2aatzJYhUdcMccY1KMgXA4tMUsW01BT4G6itn6rUcrr5L1F6RhbXQoyPixnFmmZeZQ3kmDamFH0KFvV1oaAPQVBswI3rEIo0Ud4Pjd8+YZW2ipdmJGIiE/VfY0dO/4CkF1KVRqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990014; c=relaxed/simple;
	bh=RxWumu0oIwwPHw3jy1vH97aogpV4LBSRuz89meyOe2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qk9MV9O312j7mV2TuinrfdqU+nOFn/y8CoWSfQq2I+qcDXzBxZS4agOMy8v+uyZacFrYj8lcCk0yrAqX4WQWDRjdGiaeosoSC6owBHOtbSwC2ClUIY4g6zdum6r9SOV3wYVt3RCrvYEgAFiAdnLfg4WM/S+cBRBbd3KlKclXvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KMjS9/mx; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sXIGN-00E11Q-Hm; Fri, 26 Jul 2024 12:33:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=goJFPj17qtf6+rJZeKUxZFyNY2X52xEaOpTesohcJIw=; b=KMjS9/mxgqtGvAE4Iznnk/d0/z
	O4/Apwwz3PdoTE5Oe85q+jT2of+/gi2gsY7kidm7AWsvpnFoA8WjWhpjnNbaKbl0F14gWqtf7n2Wt
	3z3EqZQFhIvKqLE1WZxTjcCsun5vyh4HGLBxRZ3/Jw8c0jUgPZa7VFtBPfAuQVsLcL4gHAY7kdZvy
	h29HhexBW5hCjAE22b2Zn3PSDfhA7Fb0Qos7F3qdHrzjNERAsZYKTdY7EI30XNJAdEQrvwSEKi+Gx
	cL4l1KSxVgG3+r/eSJs+50ctl17MGGXQW2eqt279Xg/4aWII03XAsOSmDzduxWuS+E/e0w5w5x78N
	IOcICpHQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sXIGM-0007lV-L9; Fri, 26 Jul 2024 12:33:26 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sXIG5-003NNh-LH; Fri, 26 Jul 2024 12:33:09 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 26 Jul 2024 12:31:55 +0200
Subject: [PATCH] scripts/sorttable: Handle mmap() failure gracefully
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-sorttable-fix-v1-1-8b5ba4c4471f@rbox.co>
X-B4-Tracking: v=1; b=H4sIABt7o2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNj3eL8opKSxKScVN20zApdA4sky+RUC8OUJGMjJaCegqJUoDDYvOj
 Y2loAp50/ll8AAAA=
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, Shile Zhang <shile.zhang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.0

When mmap() fails, don't propagate MAP_FAILED as the return value. Caller
expects NULL on error.

Fixes: 3c47b787b651 ("scripts/sortextable: Rewrite error/success handling")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
...
  LD      vmlinux
  BTFIDS  vmlinux
  NM      System.map
  SORTTAB vmlinux
Could not mmap file: vmlinux
scripts/link-vmlinux.sh: line 200:  2688 Segmentation fault      (core dumped) ${objtree}/scripts/sorttable ${1}
Failed to sort kernel tables
---
 scripts/sorttable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 83cdb843d92f..2ffdf580caa5 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -101,6 +101,7 @@ static void *mmap_file(char const *fname, size_t *size)
 	addr = mmap(0, sb.st_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 	if (addr == MAP_FAILED) {
 		fprintf(stderr, "Could not mmap file: %s\n", fname);
+		addr = NULL;
 		goto out;
 	}
 

---
base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
change-id: 20240723-sorttable-fix-08b9ce81db32

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


