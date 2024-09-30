Return-Path: <linux-kernel+bounces-344876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21998AF2B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5219281361
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DBC1891A3;
	Mon, 30 Sep 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl2M+oS7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DF188CCF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731833; cv=none; b=Dj1a3hC4PzQfsrzgoRDx2o/fhuYR1s31zzAuxn82CnAHw/wE2z6AOUTgBjdC7APhG6BURzTm/NTCAFlqLJ8KhPhZRwKvHvMhqIiFNaAgt3JcDDaYEkNoTkjzLxpYPQAiFRosLh8X1MY8NR/MxdGhu9+/t4O4+HfAoQXH06mQU/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731833; c=relaxed/simple;
	bh=PvyrHgDlcPtj8A8k2Bxlvq5PVfwglWYq1YXuUAmVh48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9atqW2SvxrYKKP9B9hj05HyPDgB1Ig1fYf8Wg8ZjhRX4fdEfIyqsvojga5J1M1HW5GmLBZcPWsoWa82aVLXRc5D5+Y2t2HsOaUzJ7d5HASRCfXTjDp7HmBd5rZMp9QvgWhCiKH6HNSxNqx1PNmcSZbSlNMgWmbpjvxJWgfqDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl2M+oS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EA4C4CEC7;
	Mon, 30 Sep 2024 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731832;
	bh=PvyrHgDlcPtj8A8k2Bxlvq5PVfwglWYq1YXuUAmVh48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jl2M+oS71F4bxWsAUqULhE+3ExNaVJSCd+joKv80PFCN72vwOMxug3gH9N9Kt3Xak
	 xJIDsvD1Bq4XV4hCTRoJ+NeaALiAftkKy7XFdkF25x7KR7oRp10aQpL+1ZOsBIQQax
	 jP5exEM6X1NWtdiHmrjvcaiAGmOWrLTNf4Um813hq1UCrU5yIYXLNOPbjc8yAhJK8G
	 QhGmyKxoRYU6vm5SVweog5AxLkZH76Qas4OEavXQVl5YqdP8cU1d5oifmyzGy5/Red
	 Y4uGAwOZZiiMJemhJK+j80/XUMxiyTn1x02y+bpXMnqLZmxL8pM6oRxsNeIMuobZoQ
	 gn4XOtVVv0d3w==
Date: Mon, 30 Sep 2024 14:30:30 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 13/14] x86: BHI stubs
Message-ID: <20240930213030.ixbsyzziy6frh62f@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927194925.707462984@infradead.org>

On Fri, Sep 27, 2024 at 09:49:09PM +0200, Peter Zijlstra wrote:
> +/*
> + * At the function start, launder function arguments that are a pointer through
> + * CMOVcc, this will create a write dependency in the speculation flow.
> + *
> + * Notably, the CFI preambles calling these will have ZF set and r10 zero.
> + */
> +
> +.pushsection .noinstr.text, "ax"
> +
> +	.align 8
> +SYM_CODE_START(__bhi_args_6c1)
> +	ANNOTATE_NOENDBR
> +	.align 8
> +SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
> +	UNWIND_HINT_FUNC
> +	cmovne %r10, %rdi

IIUC, this works because if the "jz" in the CFI preamble mispredicts to
the __bhi_args_* code, "cmovne" will zero out the speculative value of
rdi.

Why use %r10 instead of a literal $0?  Also how do you know %r10 is 0?

-- 
Josh

