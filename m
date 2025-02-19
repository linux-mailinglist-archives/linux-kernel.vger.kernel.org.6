Return-Path: <linux-kernel+bounces-521383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3121FA3BC83
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E1B1888A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E566B1DE8A2;
	Wed, 19 Feb 2025 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hu5kFdvD"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3871DE4F0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963710; cv=none; b=n8F+NtOUFihvxB8O8jFAqRl7OTsy5oOXEkltJI6ITkZixg85CN8pmkYPuEkeGUt0ku8HsvXmmFK/NUtix+aSzeH78B4oSrb0I7O5fSuolrykiJWSuPL5hRVRVxP0JD668xpZ3DJEaEBD4XYmCNyFWDvlizmgP7NNPEbNy2MvIms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963710; c=relaxed/simple;
	bh=SbEg9ujffYzr0gx1pPWv+ah2bdR4bEO480NJoJMsF38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRQ9Eiyhkq4FPTnxeXrBUVClc5W+w/xTS1tnv/ll/Negdg/atVi+REPLqsdSnRkElJUdQLi/WTh/3EmQrhEAsqSLRfPURYHFQJwNHUCJ4cE/uUZHFPn1Yf2TBpElZx8fQVA3oYgNd32uePEBi1F3VQZXE1bqAFStLJ8jyOSQhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hu5kFdvD; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739963705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V7J6bjtaJTUd2K3lHUzfdRkSYg0oGbnN7LsQbAU/9XM=;
	b=Hu5kFdvDAl32MVBunidKz0lAaU+XD+kJfkL4Cw+vHuYkNw4YLkqIORjg824bxqSwl28IkG
	B7EMVX+KJFYNsnHnGg8R60lwGEB+rdEY6Lw5HbGMS8oz751Bme1exo81wBvwzpgDB+zw3c
	kkaUKDbj7EeQsujtqYSMAFns28sKWRc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] powerpc/ps3: Use str_write_read() in ps3_notification_read_write()
Date: Wed, 19 Feb 2025 12:14:45 +0100
Message-ID: <20250219111445.2875-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_write_read() helper function.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/ps3/device-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 61722133eb2d..22d91ac424dd 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/reboot.h>
 #include <linux/rcuwait.h>
+#include <linux/string_choices.h>
 
 #include <asm/firmware.h>
 #include <asm/lv1call.h>
@@ -724,7 +725,7 @@ static irqreturn_t ps3_notification_interrupt(int irq, void *data)
 static int ps3_notification_read_write(struct ps3_notification_device *dev,
 				       u64 lpar, int write)
 {
-	const char *op = write ? "write" : "read";
+	const char *op = str_write_read(write);
 	unsigned long flags;
 	int res;
 
-- 
2.48.1


