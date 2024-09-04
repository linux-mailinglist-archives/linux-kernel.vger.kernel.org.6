Return-Path: <linux-kernel+bounces-314469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896CE96B3C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E42288D29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C916F85E;
	Wed,  4 Sep 2024 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LSV3HidD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZS68tWje"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B31474A2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436856; cv=none; b=Bl83di7wM6ctrn8OorOnfQ8gy2kCVEa+XU1qx9gXvO5Bzf0F9NdWcYKc1k6SQ1fmqnf/q9+M9UWZKvY3hjKdfiA7TwsHARVHPZvc7pUa12bIyviSgkQI/3HC04R/kOtN+18JvKAqLsP40kyThRsGfSLvytwPa26/bcBdFZ3xxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436856; c=relaxed/simple;
	bh=Z7uIF6w3yUstTPr4Rbu7KZFLS1exSQffbPULP2NuoZ8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WuywlJ9DSceKQK4lhL+I9n+ulf6aw2PT7t969z07hK2KFI2iOMXHAye8qdNfvNGc8lIbmtWtsy0iOi61JUAYjtTm44x+uZwXWm3nU9CtBJ/tpBnq/R5d2fLaBvYtDA3bofIURd8kUarOfJe5J8hKFnkhM2kicSEqDGe08+FJ8F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LSV3HidD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZS68tWje; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725436853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+DpkJn/OOsAXyzlzYTx5V2Qn6sJwGJgtwQcTJi1mdU=;
	b=LSV3HidDKoak5VKv8WDwhi5Lincw6lzS+kxmbOrVruewwliuEk0AM7BvWGwtbobRL9FZmZ
	q+AToT/zHJNF32S2D9KCUFdUJeUAmEF5TV0/EMzB8nbEFMG7leNWoACcdJKjFi/cfTUQTg
	gj5/toe5Ja7iuMEQsJxoGNAvqEIlDEMGNhUQszV39lkV/sHWPQPWSW+yaWCxf9eFrlK/6L
	0ZCoh2f+dkL7zuB7MeQ01vbkQz3P/PbGESCNSh8NL0YxO8UaUvp/iXgLgiUT3id9zszcZ1
	4K29dADWsSsAPuEaf+eqljXA6QmZubzyYhmLtFnxAvDXKbsKszPbIEpQwzu1xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725436853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+DpkJn/OOsAXyzlzYTx5V2Qn6sJwGJgtwQcTJi1mdU=;
	b=ZS68tWjeQQ0A5tcO//VQdYzuwEq43yyY+WtO9mlS4Jy6ZKvJNE6+RXH1kKJ+wfx6tPUPAX
	AlnBPKkAg8mftfBQ==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
In-Reply-To: <87cylj7v6x.ffs@tglx>
References: <87cylj7v6x.ffs@tglx>
Date: Wed, 04 Sep 2024 10:00:52 +0200
Message-ID: <87a5gn7sqz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 04 2024 at 09:08, Thomas Gleixner wrote:
> On Wed, Sep 04 2024 at 11:32, Jinjie Ruan wrote:
> So the check must be:
>
> 	if (!static_call_key_has_mods(key))
>         	break;
>
> I missed the module local case completely in my analysis. Can you please
> modify the condition and retest?

That said. This code is pointlessly noisy for the failure case.

Allocation fails are not a reason to warn about. -ENOMEM is propagated
all the way to the caller, so it's sufficient to emit a pr_warn().

Peter?

Thanks,

        tglx
---
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -453,7 +453,7 @@ static int static_call_module_notify(str
 	case MODULE_STATE_COMING:
 		ret = static_call_add_module(mod);
 		if (ret) {
-			WARN(1, "Failed to allocate memory for static calls");
+			pr_warn("Failed to allocate memory for static calls\n");
 			static_call_del_module(mod);
 		}
 		break;

