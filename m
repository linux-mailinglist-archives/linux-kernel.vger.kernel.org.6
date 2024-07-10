Return-Path: <linux-kernel+bounces-248253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32D92DAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131C41F23427
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15AF12DD9B;
	Wed, 10 Jul 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3SNf1DPz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SgNIEhqk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A547839F3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646621; cv=none; b=cuCppCzzUE/4C5eXuGr5oFndy02G0xzJv5AbFKT5vv3CEJPwGOYzC62rHLwtRaLJGOaReBCga+xknkqN1aVX2ERh2UliOAdZ8W4qgtDQvuwZP3YN2dRlv0KuC0vOoarhiJDLdXvuTBYIdkz4V/2ujxlPvrf1A1LxgJH0PW5V204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646621; c=relaxed/simple;
	bh=A55kOLavbsaksNe5+Uo8WbZYGi5CKsD8jDpeWIrf2hU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fHxWuq8Hmfo9vWzhnbCceqgzQGCuJjz4RVCK7HAC6D3Lsjxnx1xBSkyO30WEQ2VHtltWSVmHIxK9ykp8bHSUBGsIEJmySLQDRS0BlVTijYA9iofUz+6a+iXUGv1UpRP9eJ+q5lO09dMpTwjiwxfjiD/Bg4Dz41+tulPrLe5vQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3SNf1DPz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SgNIEhqk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720646617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qai35pVbZsCAlYx5gSFWwKAMlp16eBVHMbaSLM6FB6U=;
	b=3SNf1DPzgEJgZmpZ2nucmsni1Fu85jhLmse9zFpUyhJ9kprXRwHQMZBXfiehSrAIiZxUw2
	Y847QVXEQUq2hKD+edB7kdCGj/uffL+wba6UgJf6oZ/JQHX8bdCqOFvtE5P766kgfg+Sd/
	c+u/CxGOCvmcbYN2nNHwN0fXm3JUc8pDbAu8KKawkoxsPdJsVDBDg4/WJqgqnmPcSsU+kY
	g1llbm1fy1Ak/3CQeXdPjhJzTg5vx0WiVLMaUcG7oD1LTSCgIGP1UruI+5fyNrqOrALJyV
	n+CgaixR+G/E8/oKtSxaXB6ae00IViezu8PfsfGBNqeySknUmk3866rWdK/jPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720646617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qai35pVbZsCAlYx5gSFWwKAMlp16eBVHMbaSLM6FB6U=;
	b=SgNIEhqkevv98PI65/+TIxgjlypqbHQCLZUkUGV8EQrTij6oa2dQT+9R3NImTDlv441B2E
	rXsyFnrtBkDBv2BA==
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timekeeping: Use min() to fix Coccinelle warning
In-Reply-To: <E601C587-4432-472D-A13A-6C03E88BDD59@toblux.com>
References: <20240624062411.321995-2-thorsten.blum@toblux.com>
 <87jzid7cmc.ffs@tglx> <E601C587-4432-472D-A13A-6C03E88BDD59@toblux.com>
Date: Wed, 10 Jul 2024 23:23:36 +0200
Message-ID: <87h6cxuejr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten!

On Sat, Jun 29 2024 at 16:12, Thorsten Blum wrote:
> On 24. Jun 2024, at 23:36, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Mon, Jun 24 2024 at 08:24, Thorsten Blum wrote:
>> 
>>> Fixes the following Coccinelle/coccicheck warning reported by
>>> minmax.cocci:
>>> 
>>> WARNING opportunity for min()
>> 
>> I'm fine with the change, but not so much with the change log.
>> 
>> You cannot fix a coccinelle warning. You can only fix the code which
>> triggers the warning, right?
>> 
>> 'Opportunity to use min()' is nothing else than an opportunity, but
>> what's the benefit of replacing correct code with it? What does this
>> fix?
>> 
>> It fixes nothing. So calling it a fix is confusing at best.
>
> I think it's pretty common to "fix a warning" -- there are thousands of
> commits in the kernel using this wording in the summary alone -- even
> when the change doesn't actually "fix" anything other than removing the
> warning.

Following the lemmings does not make a technical argument.

> However, how about 'resolve' instead?
>
> timekeeping: Use min() to resolve Coccinelle warning
>
>> What you want to say is something like this:
>> 
>> Subject: timekeeping: Replace open coded min()
>> 
>> Replace open coded min() because $GOOD_REASON
>> 
>> Discovered by minmax.cocci
>> 
>> $GOOD_REASON is not 'coccinelle emitted a warning'.
>
> Removing a warning can be a good reason in itself to refactor code,
> because fewer warnings make "real" warnings and potential problems
> become more noticeable and thus more likely to get fixed. In short, it
> improves maintainability.
>
> To me this is obvious, but I'm happy to add something like "refactor
> code to remove warning and improve overall maintainability" to the
> commit message.

Again. The code _is_ correct and replacing it with min() does neither
fix nor remove a warning.

What's wrong with saying:

       timekeeping: Replace open coded min()

       The open coded min implementation is correct, but triggers a
       Coccinelle warning in minmax.cocci.

       Replace the open coded variant with min() to reduce the noise of
       false positives.

That does not sound as spetacular as 'Fix', but it reflects the actual
technical reason for making this change.

Thanks,

        tglx

