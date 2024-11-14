Return-Path: <linux-kernel+bounces-409315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CC69C8B55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA17B2BCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A858C1FC7F7;
	Thu, 14 Nov 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MweNg4/K"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB81FB8A7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588693; cv=none; b=CNenVMMMUJj2hzqpOE3n4xEl/Zf22yeIdm4bdJY6LNxH4Hw4ssm/FBk/faDoDXbEXt59kpQMyacAkSH46gu77YEPnsP10hWeBqVUGmhi7n1u8IyLJbwl5lzSfF8BAUz7TUEQowNE2LaHvLq8vgcoyUO2TUO1/mmx7udE4jvpbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588693; c=relaxed/simple;
	bh=u0yNhaeKck1mhyq2VIAd5lmVFTSwLwmmqNy+P2eTIsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQFW3DY2XWisnQjnpofDqog8k1K4wUniiFdSg8qbWOBTdg/i3WQPh7+1Id34L2+kzrhXRdq/ntqBK3stU21ndkUNSC+YwivAc6ypuXnmztS/d72YR9Ma3VSCroLAzFPWSHte8a3N1Tf7bEKghjVgnxeGWyjgxXu6p7nbS60o3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=MweNg4/K; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588686;
	bh=wa8kkMFSI7eeE5/UlhqUXcjhe3HJUAryRv831YI9duo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MweNg4/K+DSyryUNs/7J2WK0Vt0Q1Zhaw3vU1r6ja9Yuca4yZ9TK4JXNj5Jfx8+Eq
	 LawQYA9By0CQTPIEgU2UCgJkA2JdIpvxgoEaumCzfHNQEHoA9vzC6/ybJqV5+IT+7l
	 aL3vF2qM6F0IELyhLnaXOlWo0ykPrBCEwRgU70q1/S4k3rJHPvquJ/e7vf7h55hbat
	 apHY/0dstRW3JrvwZOF3TKCgV3CWBLU4N4BtvduGWoH84u+/2CoKqF5fDG+LICGmSo
	 7jNPF/wLJG9IvzpxpgJhGDXXgHKYa8DjYbJMbinZnDdJSd4YzqBrCJhaWJnw7pyaaO
	 UjRGz71eRYQ3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QQ0NY2z4xcY;
	Thu, 14 Nov 2024 23:51:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 19/20] docs: Remove reference to removed CBE_CPUFREQ_SPU_GOVERNOR
Date: Thu, 14 Nov 2024 23:51:08 +1100
Message-ID: <20241114125111.599093-19-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a reference to CBE_CPUFREQ_SPU_GOVERNOR which has been removed.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/admin-guide/kernel-per-CPU-kthreads.rst | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index ea7fa2a8bbf0..ee9a6c94f383 100644
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
@@ -278,12 +278,7 @@ To reduce its OS jitter, do any of the following:
 		due to the rtas_event_scan() function.
 		WARNING:  Please check your CPU specifications to
 		make sure that this is safe on your particular system.
-	e.	If running on Cell Processor, build your kernel with
-		CBE_CPUFREQ_SPU_GOVERNOR=n to avoid OS jitter from
-		spu_gov_work().
-		WARNING:  Please check your CPU specifications to
-		make sure that this is safe on your particular system.
-	f.	If running on PowerMAC, build your kernel with
+	e.	If running on PowerMAC, build your kernel with
 		CONFIG_PMAC_RACKMETER=n to disable the CPU-meter,
 		avoiding OS jitter from rackmeter_do_timer().
 
-- 
2.47.0


