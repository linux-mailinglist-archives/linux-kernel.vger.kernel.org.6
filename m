Return-Path: <linux-kernel+bounces-409341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC209C8B83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A70284C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632E1FAEF3;
	Thu, 14 Nov 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="CPGk9jca"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6521FAEF1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589889; cv=none; b=pXBGP6cSrhd/GsMraJsmqSOytndzHHRJY4E94+5ZHjOfydc15VdqZRzrJD5cHolcVaOaG9d54ioHb0mXfGgCaHECr21EN7+m3pQlQnWm7TJzN4ArTo8nDCRD+FsLdn323Q1yeYwdE1CTO/wwayQ3TOiX2n7VAB9LsxcIgNtIQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589889; c=relaxed/simple;
	bh=LZlTQmSPiYX6bdxLoWLAU/vDHU84bFxr2RFClb1YHm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCQBAM8V4anQt6Tlv0PWt7DksH8Jz/u2iwJTiA7LIeYlkG6wFPw4S0sq+beC0rrDjdAyWkYNR7fzfX+Pv4t8x2GPA1ewwDd2iqTmYDvVjRQgBMZIbHlySJis5FwQAVbu8IZAhZxDfs2C3OEvFhsm+VwFaB6Iv9JXwzKuxEfW3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=CPGk9jca; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731589883;
	bh=3HHrt9JXL4ThP5wuiQcz7NG0VDFUaMnu1vJNfkoLS80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPGk9jcab/LjC6fZuuxvf7PVwqwG+3YzYu1vbbFEQaQfGssdt+WRmRND+41nYFWFb
	 AG3EOaS3eIW8h0dg1KTCyBCtQg7R15988vsqT2JIDa5k7swkHIN2rnEL8ATQQUSyUP
	 n1DcyoPMuqrOdlxi/quzX4yPblLFGzhRYffo7q05v0iMrnkUp1lvwVDoa9JwRwCegl
	 YN1c4XJSF+HeQiaX26UsJCCpzwSwCkfJozVRXOUKnO16xDa57eyj9NiaZCFPrE9i32
	 QxUwfWzAF/xmEIkukH3pCrIxkJzn2YmOz3Cb2c2MEEko9Aa/u8whyRB68BelD9ZfIL
	 y6kzJm2H6C/hQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0sR4bDKz4x8H;
	Fri, 15 Nov 2024 00:11:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<geert@linux-m68k.org>,
	<arnd@arndb.de>
Subject: [RFC PATCH 05/10] powerpc/rtasd: Remove machine_is(chrp) tests
Date: Fri, 15 Nov 2024 00:11:08 +1100
Message-ID: <20241114131114.602234-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114131114.602234-1-mpe@ellerman.id.au>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the chrp machine has been removed these tests can never be
true, remove them.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/rtasd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 9bba469239fc..ce039c187156 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -502,7 +502,7 @@ static int __init rtas_event_scan_init(void)
 {
 	int err;
 
-	if (!machine_is(pseries) && !machine_is(chrp))
+	if (!machine_is(pseries))
 		return 0;
 
 	/* No RTAS */
@@ -545,7 +545,7 @@ static int __init rtas_init(void)
 {
 	struct proc_dir_entry *entry;
 
-	if (!machine_is(pseries) && !machine_is(chrp))
+	if (!machine_is(pseries))
 		return 0;
 
 	if (!rtas_log_buf)
-- 
2.47.0


