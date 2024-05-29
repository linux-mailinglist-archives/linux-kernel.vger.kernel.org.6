Return-Path: <linux-kernel+bounces-193401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918778D2B68
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153CC287A27
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F3915B55E;
	Wed, 29 May 2024 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KccwjPFN"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916115B141
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952904; cv=none; b=Ib3dYgpJa/yXBr7/B9atKJnce9FBJaoP1a+C+7B42ALcrrjvq3fmZo75aE3Ab43dcvpvlAKS1NHSADO8wU6BFQiqbGqNWfXPVOut4TRuqrCOTImoueJ359opdos4CSfUpkakzeDNc2Yjh8XIi6ae8EcoSxcsMfzvXba8E+TNsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952904; c=relaxed/simple;
	bh=m8bKLa73OzMCzi3WLOjKLcqJCAf+OffQfYOTGQPxorg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIeecIIE/IfY8sRTaGutmzBum5+D2vuSYQ5LUrgmLf+Rj2XvmHNIo2OLsiv77xIC3SRfI8O9Y9sMGTbaHmmFqXSjIg7WJAuL9eyoSNVDaTze2g39LM+6vP48J6NeLnNb88TNOW4ZgSKYHoIEhzAh9NmODZw45PyUkzvy1EfyuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KccwjPFN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tglx@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716952900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrhujbtPk9e49X1l/DEpQBISHiUUgj3l+3hQb2zUhaE=;
	b=KccwjPFN2WngIea8B+MtJvUV19C2SfptOCP30aLegsV8bKaBpHA0vbzWnbFqZWeJJsItSY
	Im7kv0NMHRP0XSHHp4nNndWX4/91spMAOrO6AKexeqrITDnEPkNSe/eDA0b5VYb6RA81VR
	YPxaYJrVYdxXAe+ZT3jIhH+CmQTtfLw=
X-Envelope-To: mingo@redhat.com
X-Envelope-To: bp@alien8.de
X-Envelope-To: dave.hansen@linux.intel.com
X-Envelope-To: x86@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: mjguzik@gmail.com
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 2/2] prefetch: Add ARCH_HAS_PREFETCH definition when the architecture is not defined
Date: Wed, 29 May 2024 11:20:59 +0800
Message-Id: <20240529032059.899347-2-youling.tang@linux.dev>
In-Reply-To: <20240529032059.899347-1-youling.tang@linux.dev>
References: <20240529032059.899347-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

After commit ab483570a13b ("x86 & generic: change to __builtin_prefetch()"), the
__builtin_prefetch implementation will be used by default, so add its definition
to return to a state similar to before commit[1].

Currently prefetch_range() will be empty implemented under the x86_64 architecture,
there was a concrete implementation before "x86 & generic: change to
__builtin_prefetch()", so fix it.

No similar changes have been made to ARCH_HAS_PREFETCHW at this time.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/include/linux/prefetch.h?id=8e4f2fd31bf737abb392e694898a1496157623b5

Fixes: ab483570a13b ("x86 & generic: change to __builtin_prefetch()")
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 include/linux/prefetch.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/prefetch.h b/include/linux/prefetch.h
index b068e2e60939..162b7105e37c 100644
--- a/include/linux/prefetch.h
+++ b/include/linux/prefetch.h
@@ -36,6 +36,7 @@ struct page;
 */
 
 #ifndef ARCH_HAS_PREFETCH
+#define ARCH_HAS_PREFETCH
 #define prefetch(x) __builtin_prefetch(x)
 #endif
 
-- 
2.34.1


