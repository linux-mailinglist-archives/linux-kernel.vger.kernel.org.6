Return-Path: <linux-kernel+bounces-271821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105F945395
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA4C281385
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4BF14A62E;
	Thu,  1 Aug 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ao8k8DKO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E3K/7i//"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315C14A4F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542154; cv=none; b=YKF6NNi58akpQ99v22ciyRuakw+VAi+ha2bjjz/iNUgqQYnXdDTWFdf3nGL0dulUtoR8/n+SWFMJEe9lTvyepzzOxrWU+YkU49vj1uJ8ZL4NczgASCW6EPcEkaZAmn4GhE0/kBePjLy9LgpBuDu90gwJFRiqKrXGnEwJHP9OT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542154; c=relaxed/simple;
	bh=Xm+RIH3o/oAev6b3ur+FbTQ+m5+zrNQ+kKqfyeqO5Gs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rOxcIYnPcGzSnlCR8HF8Vbzv3BxGGPvNNElaKkvmaTz3X04tk2SBTmdc1POsBDnzxqARs23iKUwei34AjeFEMbeg+xCTwH/j9U4a5buOXsrbc5DGWHHBUqSyKRR6EEtW5U+qxSPAIsrgkkRGacXLf4xpb4rIvq+O8SWMxuDyVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ao8k8DKO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E3K/7i//; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722542151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXlr2Hk/7CZiJk17gyVFRfPqgP74hvjJ1UM0KwpwIOo=;
	b=ao8k8DKODblAhmvrQeoqDNvoyEZQGSk3Of62vW9o9NK/jO0+8Gy0ncv6fjcOaYLB0YlPFy
	ejXUeWyOuYH2MUgMmUkWwAOrhdp0XItKdXWlatw1z2Oi/r24+JpLbrStzuAAtXD/ZHj95N
	vvuT0KFdxXBxOkSrlWBpKGUwNpWYCz/mWGJ1gIONExc9rtQa3SGfP9zNTnvlcigzIPtQyD
	zVgzcShHMDGI20jWFxOEfJk800LW9pC4BGmxeNL4692czYLdxMABYkh42Hvsx4CdKS31BN
	2qfzR2wwx59PinRVPRsjX5cniN/FFgBuGN8m0HCbxl3AXTmcH9xrOIKBJZY2mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722542151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXlr2Hk/7CZiJk17gyVFRfPqgP74hvjJ1UM0KwpwIOo=;
	b=E3K/7i//DnvyCw6hAyu5sZJn/RYEYMdX+3a4bm62Uf6U2Jpf0zOkvkYpuDR0HFlR+So/Cf
	2vVhSnFNjY53ubDA==
To: Andi Kleen <ak@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4] x86/mtrr: Check if fixed MTRRs exist before saving them
In-Reply-To: <20240607194437.52939-1-ak@linux.intel.com>
References: <20240607194437.52939-1-ak@linux.intel.com>
Date: Thu, 01 Aug 2024 21:55:51 +0200
Message-ID: <87cyms2f20.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07 2024 at 12:44, Andi Kleen wrote:
> MTRRs have a obsolete fixed variant for fine grained
> caching control of the 640K-1MB region. This fixed variant has a
> separate capability bit in the MTRR capability MSR. Most of the MTRR code
> checks this capability bit before trying to access the fixed MTRR MSRs,
> except in one place. This patch fixes this place to also
> check the capability.

I don't know how many times I have told you that "This patch ..." has no
place in change logs. Just in case you can't find the reference:

  git grep 'This patch' Documentation/process/

While at it you might also hit the format shortcut in your favourite
editor to actually make the above paragraph properly justified.

Also the content of this "changelog" is close to word salad. It's not
that hard to follow the documented expectations of change logs:

  "It=E2=80=99s also useful to structure the changelog into several paragra=
phs
   and not lump everything together into a single one. A good structure
   is to explain the context, the problem and the solution in separate
   paragraphs and this order."

It's irrelevant whether most code checks the bit, what's relevant is
that a particular piece of code does NOT check it. It's also interesting
what the resulting problem is, i.e. reading gunk, #GP or whatever and
why this suddenly matters and did not explode in decades, but that's
nowhere explained. So why does this patch matter?

It's really not rocket science to write a coherent changelog.

Thanks,

        tglx









