Return-Path: <linux-kernel+bounces-259751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1317F939C95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374991C20A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0374014BFB0;
	Tue, 23 Jul 2024 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IVplmemt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZznuY/ke"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3B8814
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723190; cv=none; b=NF6XkGLw0edeUHj46QIkEUenI84m8M30nYswQpU2WKIJ9hcNeNOUI4TJgpiRVdoA9vxy7hmTxJxL/FextjJXOfNCYfOynTHyl44afaEicKFb0mibx44TH389OeI7D1w8lM7eFDNSVu9iU1uo8nDVrlu9Bift8PF+AFBDhOV0kYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723190; c=relaxed/simple;
	bh=uHOgyREunONN2WdKSyUBPYZn556t7dgT2zt8n2XiOdY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=TlvVHBCVrJvdQ0bZk3vMCJvVlyiOhHu742x5OzvseL6ytlj8eXVj1XSZxC3m00dIJNpTT8oEwJCJ8DiNQ3Fq6+RYGV8qYShOUDvhgZAkU+Tp9zB3mNInDlihT86uWjJWefxmUW2eyJ1cCuMeq/vQ2F8yW4tJ6TEdnmr3k/0N+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IVplmemt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZznuY/ke; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id ED885138065F;
	Tue, 23 Jul 2024 04:26:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 04:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721723186; x=1721809586; bh=dCLULAf5DM
	7KzrcLKJGqnXGq/p9IlqRjE7J/CfCWQcA=; b=IVplmemtYH4igdUBMKBz0D0Xhy
	5U2292lf9fzg6Yec44mX/7kCXYnKCvfaYY3NcrUgrMjK4auUsn2VoEd0zK5ah626
	JOT1+Iw5la+XUsOVz/XQRgB/fPFR+G6QxylZ59DSuS6asbFajrOfkPVIbOvHVfzg
	BqE6ne2SUTBASblTh0vvJAPFkeAxqhdsst2vgetcCprytFLT0CTSEekI9d/QwhVK
	cyIC+xiswBJ0AW+KjJv83UHKa6xuBxlkJ2Gq+cxeXbtXcLo8CzXHXk8qRERv7c33
	C2Hi0xygIAxef0rn4aRU58EDOQXBixTbjTj/R4nEJz34ZjOKWJEi5vQy9YHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721723186; x=1721809586; bh=dCLULAf5DM7KzrcLKJGqnXGq/p9I
	lqRjE7J/CfCWQcA=; b=ZznuY/keabxLarcJQ3rRT/7wWHs7xNmiBtrrvEIWU+00
	IsZR3NWzWhHq2HDkJ5TieS3I0BxrUrIXPdwSjnoMaWLYxRMVImSLMxBSXWCQTk9v
	Co1zP8Ndd27WYK7av2gm2BcF8RCTfMTa4FIl62+rznoJw5LHOFtvZjLu5jtKh5Ku
	LtULML878njmHRJDz1Gqk+cISt+U8x/wbQcStOjZKXXY69fER5SzQ6wId/uVGaEx
	ZI6E1eS6wll0hE0z0ioxntC0i5AeHa4ef8nC0Rd6QOFmCg1jo9ksjibA5E5ZmYLc
	4DGV4DZP5TuaOXl3nsYTd2eGi/jojBRoqh+U1vwCTA==
X-ME-Sender: <xms:MmmfZvK8s7eRPTwl3XzgY4LfQWZtCZi9bizrpcRIXmOoIK3Ae1_7cA>
    <xme:MmmfZjL7Vgaf0bc_okwA7sqtlTDlh3FEqmTuXrRL1DrXFoWOkUEzlhIl-fNbLihXi
    C6zq2n5v2eTkLhI5tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:MmmfZns4ML4_oMTgJ388MFn-y0aX8zuwJ-Dx4MgjulAOT20qsMfjpQ>
    <xmx:MmmfZob6jU360GpO48Nmqk4OB7x7lF75IiIa2Vm2iso6JhURDjrmlA>
    <xmx:MmmfZmbTU_j70lGUDlpnNvGPNukHdEh2eRRhHKL0LSx8VsJiisq1Zg>
    <xmx:MmmfZsBCjeLTja8LfEnOPLWwC3Wm1d7J6kIpzHOjQ-w0lEhnT_4cyA>
    <xmx:MmmfZiRb-etryviwu_V3yh7ofR8nIEZDfBXPkyQqXUrl_A_5kMS-MjOp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4F2FAB6008D; Tue, 23 Jul 2024 04:26:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2ce07fbb-03b2-4096-bd76-e7546e20a33c@app.fastmail.com>
In-Reply-To: <20240722094226.21602-16-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-16-ysionneau@kalrayinc.com>
Date: Tue, 23 Jul 2024 10:26:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yann Sionneau" <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Mark Rutland" <mark.rutland@arm.com>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>
Cc: "Jonathan Borne" <jborne@kalrayinc.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>,
 "Clement Leger" <clement@clement-leger.fr>,
 "Jules Maselbas" <jmaselbas@zdiv.net>,
 "Julien Villette" <julien.villette@gmail.com>
Subject: Re: [RFC PATCH v3 15/37] kvx: Add atomic/locking headers
Content-Type: text/plain

On Mon, Jul 22, 2024, at 11:41, ysionneau@kalrayinc.com wrote:

> +#define ATOMIC64_RETURN_OP(op, c_op)					\
> +static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
> +{									\
> +	long new, old, ret;						\
> +									\
> +	do {								\
> +		old = arch_atomic64_read(v);				\
> +		new = old c_op i;					\
> +		ret = arch_cmpxchg(&v->counter, old, new);		\
> +	} while (ret != old);						\
> +									\
> +	return new;							\
> +}
> +
> +#define ATOMIC64_OP(op, c_op)						\
> +static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
> +{									\
> +	long new, old, ret;						\
> +									\
> +	do {								\
> +		old = arch_atomic64_read(v);				\
> +		new = old c_op i;					\
> +		ret = arch_cmpxchg(&v->counter, old, new);		\
> +	} while (ret != old);						\
> +}

These don't look like they are ideal because you have a loop
around arch_cmpxchg(), which is built up from a loop itself.

You may want to change these to be expressed in terms of the
compiler intrinsics directly.

> +#ifndef _ASM_KVX_BARRIER_H
> +#define _ASM_KVX_BARRIER_H
> +
> +/* fence is sufficient to guarantee write ordering */
> +#define mb()	__builtin_kvx_fence()
> +
> +#include <asm-generic/barrier.h>

mb() is a fairly strong barrier itself and gets used
as a fallback for all weaker barriers (read-only,
write-only, dma-only, smp-only). Have you checked
if any of them can be less than than
__builtin_kvx_fence(), e.g. a compiler-only barrier(),
like the SMP barriers on x86?

> +
> +#include <asm/cmpxchg.h>
> +
> +static inline int fls(int x)
> +{
> +	return 32 - __builtin_kvx_clzw(x);
> +}
> +
> +static inline int fls64(__u64 x)
> +{
> +	return 64 - __builtin_kvx_clzd(x);
> +}

The generic fallback for these uses __builtin_clz().

If that produces the same output as the kvx specific
intrintrinsics, you can just remove the above and
use the generic versions.

> +static __always_inline unsigned long __cmpxchg(unsigned long old,
> +					       unsigned long new,
> +					       volatile void *ptr, int size)
> +{
> +	switch (size) {
> +	case 4:
> +		return __cmpxchg_u32(old, new, ptr);
> +	case 8:
> +		return __cmpxchg_u64(old, new, ptr);
> +	default:
> +		return __cmpxchg_called_with_bad_pointer();
> +	}
> +}

With linux-6.11 you now also need to provide a single-byte
cmpxchg(). You can use cmpxchg_emu_u8() or provide a more
efficient custom one based on the 32/64-bit versions instead.

      Arnd

