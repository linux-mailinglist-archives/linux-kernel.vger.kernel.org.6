Return-Path: <linux-kernel+bounces-314629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429CE96B607
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7571D1C24650
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C5E1C8714;
	Wed,  4 Sep 2024 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBcHW+oD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L42TAbbY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AFE146A71
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440912; cv=none; b=hCQTelqF1936KKsJHx3mKf7Inhq1icpRKcLzs55sY8UwlP/PBasmrO98D/1Wcf1HbHiI+8d1e+4gTZTUP4vKaQp9wIEt7DZNESzvPnc+gWHhTaBkAbOzZXIEVNT7ir4ZFbEJC3cfT3HHQX3c2GkbrZ75riYD4YzSMF7zPO0U+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440912; c=relaxed/simple;
	bh=p7pNCuPpKDCXVtxaExb3Lr9xzgpJTpw8IDDM3rV4Krk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZSdvxsRaeFNu9T8By1s2YuIb1io1Co7cp3HF6bUCSYp15w0O/RlZKoW1nvr4yoEK6beYm5b959tkVC4maL6Lx0ALLYIaWUFSaV6nnOFF55A9NUDVlGKkfGVLRnsKytHCRWblFHdPiX9ErVm92ntwWeLCLPNas8i0l4Aj9jsySX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBcHW+oD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L42TAbbY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725440909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uy18TExcyJ/OIxfpjPwO8pEkLF8Qsrw3+kh+VwbQSRw=;
	b=DBcHW+oDKafRo+xFsStoAFXeXdXZKCa9Q71ksX/kzYzT410/FTka4ORB7h3R4lGR+6qvCr
	gQFLP7SaZHqjpV3V7SpTXm4CTQgkKPi4IhRyTxHn/3CzuSD96lD8NAsqYv73ehWh/1jVbp
	EUm1iUAutacsmmNaXaqPcN+6ZaUU02zc41LLNILG/x5sQr1r9uJv2Dnxh6kBzrYP0JbPXs
	94RhstPbdtq+SP83/CLpENKoh246EwBV+fETgtCMF4HuTJm8d0sV2Ko0cYrC8L8McC2zVL
	z7MEFo0FlOX2j3/MshqTqChOOW6t/0ZfxiKILZS2sG/HOV7R4AgB855Ge6Zd+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725440909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uy18TExcyJ/OIxfpjPwO8pEkLF8Qsrw3+kh+VwbQSRw=;
	b=L42TAbbYrwnzuVUp+ygF5GE3DTBC3KWLHAPqiALOpbOs+sdZdCf/ZUUQ1rlF3wiuPLDLP5
	Vo012la7EaQ80oDA==
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf
 <jpoimboe@kernel.org>
Subject: [PATCH] static_call: Replace pointless WARN_ON() in
 static_call_module_notify()
In-Reply-To: <20240904081743.GF4723@noisy.programming.kicks-ass.net>
References: <87cylj7v6x.ffs@tglx> <87a5gn7sqz.ffs@tglx>
 <20240904081743.GF4723@noisy.programming.kicks-ass.net>
Date: Wed, 04 Sep 2024 11:08:28 +0200
Message-ID: <8734mf7pmb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

static_call_module_notify() triggers a WARN_ON(), when memory allocation
fails in __static_call_add_module().

That's not really justified, because the failure case must be correctly
handled by the well known call chain and the error code is passed
through to the initiating userspace application.

A memory allocation fail is not a fatal problem, but the WARN_ON() takes
the machine out when panic_on_warn is set.

Replace it with a pr_warn().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/static_call_inline.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

