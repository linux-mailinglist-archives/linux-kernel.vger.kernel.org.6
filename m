Return-Path: <linux-kernel+bounces-573813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D81A6DCD1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2693B1E40
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36BA25FA1D;
	Mon, 24 Mar 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QoSagH/J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r8vrE73v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74D25FA23
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826068; cv=none; b=OI1B0L1wMo/k9/yKgDT9Qt242SOHgnPiWm0mPUs7y2TgdSR1JTDjy2CYM/iH912GEuDHL5unZ8cfp5II0eCJoON5AHrOwhRSk81dJQyObzLS072b4mV1ajMvPzRbcKnyRERHINqhgLfehPSwuiuNED8mbqoS3sVTh9m62mhuJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826068; c=relaxed/simple;
	bh=Ushz4JR4gBXwlY3rF7uYB5PnO6rgziwqmj7rQX1GkQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UC72xNV/2TdJDoo3wIHxDPUraE4bAPMe2CJUIoZ7QS272mML/xUNcrOtC+7Y5Waivu8aj+XgFjzkY9+QP75Egz8B3IyAEjSlVzOrGkL5GU8IKUbVqW53MOJeYXynxrYOyPmBz5GCkg3NxH69nHfr0ISXKmbLdGWnRYDYzh2ZhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QoSagH/J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r8vrE73v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aVpvhv/pT52r13e6wll8TyOiNsXUS27/wMFfsB28/g=;
	b=QoSagH/JK2scReYVNHEH86huVoOXEw2kvSWIPd2zmW8YYsSwUCfVNSHspATuIZryxzXTcp
	zeSp8f/S+DhH6yTVbQn78e5NOswTEaE3ldYBce8BMt8PjARaQDDImwfMw8ZhgdrnJ5GlPj
	7gsh7FdMhjketvL1bhwrbYaTfYFAdDivkhkTRWndkZp0COjJaU7Cf8BUsYc2oyFPk04PYo
	u9/BmwbgluddHea536ZT6OYnSbpjAAsFy9YiZsRJ4S8hKsVq8Ng840PAY/t6+Rh+Yptd3e
	e7/WcjqDbtQYQxpCyxl8o2qh7hu4JtJ3caNstS21Gqo0f9rrjwhr0x/dUdMsFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aVpvhv/pT52r13e6wll8TyOiNsXUS27/wMFfsB28/g=;
	b=r8vrE73v2MKfpOJsLjsdsR6pyFxjlys1eHeYar5/Z2G+WENFeNQwsCSSMMNeuqgrkdHfUj
	qyPHZz1xAzkx05Dg==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v3 06/20] tools/x86/kcpuid: Remove unused local variable
Date: Mon, 24 Mar 2025 15:20:27 +0100
Message-ID: <20250324142042.29010-7-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local variable "index" is written to, but is not read from
anywhere.  Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index d518a13e4386..a89da2af98e9 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -181,10 +181,6 @@ static void raw_dump_range(struct cpuid_range *range)
 
 	for (f = 0; (int)f < range->nr; f++) {
 		struct cpuid_func *func = &range->funcs[f];
-		u32 index = f;
-
-		if (range->is_ext)
-			index += 0x80000000;
 
 		/* Skip leaf without valid items */
 		if (!func->nr)
-- 
2.48.1


