Return-Path: <linux-kernel+bounces-529290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA12AA422A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C8419C02CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0449C2C6;
	Mon, 24 Feb 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xjys1v/w"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF013AA2D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406178; cv=none; b=I/9jTgznb7OhU6qU7BXM1GrsmDpI/VaOWowlMkvnAMCxE1VAPuQE7gvwXgjdhVO5ERoDNQvNtLB/AkUeTFV1om4hHcmChJS2Cg0t2lPSclm83ICbdTRL3V+xo9pKQVD8zc68YhJJW9rTReVVMBhkhCtbCXuOYmobAAejmV/eumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406178; c=relaxed/simple;
	bh=iR+ZRm8Rf4CcWzzHJUgQJE++fFjiHr0jVOTIRynNSds=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rmNPfGXrc85hJIPv1ny6/RPdYQBhPkfX4peFEhbVEBLNrdyjC1Uln78LPHLMufJiCItjlRo2fdarG8f/TpwbLVgwbLH0HEWEmusmLBPrTszVUzTnaaGIZlms6Ex8ViYatrJWj2nZ3izMcbote4PLuBTjIQROi+Y3q6nl/50HReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xjys1v/w; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740406172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iR+ZRm8Rf4CcWzzHJUgQJE++fFjiHr0jVOTIRynNSds=;
	b=Xjys1v/w08YouEoOoiycof9pS9nLTNmUMcP5eJjFxL1liBMyt860Zi2OQMxCbmDidA7+cc
	rHTN/4sRVP03ZxzzAZ+hBeydNhtZ00yawJRwzzftT8mx7zue0sNEqwnyNCZeAiu0yyrsap
	fIt4CwSxAYrHoFGewHHUvQS+3diFLK8=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] powerpc: mpic: Use str_enabled_disabled() helper
 function
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <f872c2ef-4adc-4daa-aa12-769e3108abc8@csgroup.eu>
Date: Mon, 24 Feb 2025 15:09:19 +0100
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>,
 =?utf-8?Q?=22Ricardo_B=2E_Marli=C3=A8re=22?= <ricardo@marliere.net>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE3E083C-D554-449B-9C67-81556D06FD35@linux.dev>
References: <20250219112053.3352-2-thorsten.blum@linux.dev>
 <f872c2ef-4adc-4daa-aa12-769e3108abc8@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Migadu-Flow: FLOW_OUT

Hi Christophe,

> On 24. Feb 2025, at 13:56, Christophe Leroy wrote:
> Le 19/02/2025 =C3=A0 12:20, Thorsten Blum a =C3=A9crit :
>> Remove hard-coded strings by using the str_enabled_disabled() helper
>> function.
>> Use pr_debug() instead of printk(KERN_DEBUG) to silence a checkpatch
>> warning.
>> Reviewed-by: Ricardo B. Marli=C3=A8re <ricardo@marliere.net>
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>=20
> When you resend a patch, please tell why here (below the ---) so that =
we know the reason.

A "resend" is meant as a "ping" and the patch is always unmodified.

=46rom [1]: "Don=E2=80=99t add =E2=80=9CRESEND=E2=80=9D when you are =
submitting a modified version
of your patch or patch series - =E2=80=9CRESEND=E2=80=9D only applies to =
resubmission of
a patch or patch series which have not been modified in any way from the
previous submission."

When a patch is not in -next yet or when it's been a week or longer and
I haven't received any feedback, I eventually follow up on it by
resending the same patch.

You're the first one to ask for a reason for resending.

> At the time being I have several duplicated patches from you and I =
don't know what to do with them which one to keep and which one to drop.

They're the same - feel free to pick the original patch or the resend.

Thanks,
Thorsten

[1] =
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#don=
-t-get-discouraged-or-impatient


