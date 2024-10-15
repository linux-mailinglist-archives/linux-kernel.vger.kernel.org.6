Return-Path: <linux-kernel+bounces-366585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8C099F75A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEC22840BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560171B6CFC;
	Tue, 15 Oct 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ64rKWm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEAD1B6CE0;
	Tue, 15 Oct 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020920; cv=none; b=uTCHMwm5wNpqLLVtqTZSiqjDexOlY221LuiqKPEKnIRxcxcEgYC+ClKaaI2uSaA8Jv7WgBUViTPRg8vS4I8ROtxn6d3EH8beoNgv7yHOAW3jDfy3e6j/7DQ02WnY+EGHiPB0hd+RAGMS9whhuZdQZwOKwOm1UnksVbpKAh5qPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020920; c=relaxed/simple;
	bh=jOjFKGS53qFoaG9aUQaYD/4l0QUQo48mL3m+gNWF7uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qunhSiEDKaCwaC9Jpo+HqXyCQVy1YZzYBOk34B5ehAGj3jZVn75qrnHS3xpQBk9cpvVi26nSUQs8j1L3w8Clk1Idr5Gw1rygtxYb4xPtk3UOv51chPP58RLRrLm8PEdMHrjFpyZ6H8Sr11XnyK+q72J7E02bBcqlqqv5AKFRJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ64rKWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2CC4CEC6;
	Tue, 15 Oct 2024 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729020920;
	bh=jOjFKGS53qFoaG9aUQaYD/4l0QUQo48mL3m+gNWF7uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZ64rKWmZPuZ6rtgBYNVcwXy9tHMv0sKC+W1mMtdGvSGPvOE4mv1T2ADROai8dShi
	 hRd7dAFmeArfB/NE3zMMXbwxDvmjtjzyWy6OOx2AeEYB+KICjDqvLmI21pSrZQjMvz
	 Bo1LoCIT1Sd6H7ft8DrNgAPBvdF8wtsvMFFXnamv4Wrom+DaLhztkbW4nqBkuiCqCB
	 Tg7QwWXPath5g1DUvFUjr8N2lR6vXrBRjwdHve1YWwD3htnd5OMFNiI3J1hro2Q6a0
	 0Px2uYZAHLQ24Aa1uDeGLc6/PU51KB18na/B7QPgP+E2qqlDYUqsmzimvEQgr5BZ/Z
	 cmtyQmzciWmDw==
Date: Tue, 15 Oct 2024 16:35:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Howard Chu <howardchu95@gmail.com>,
	ndrea Righi <andrea.righi@linux.dev>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, james.clark@linaro.org,
	alan.maguire@oracle.com
Subject: Re: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature
 in clang 12
Message-ID: <Zw7D9HXBanPLUO4G@x1>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
 <Zw61TUe1V97dKWer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw61TUe1V97dKWer@google.com>

On Tue, Oct 15, 2024 at 11:32:45AM -0700, Namhyung Kim wrote:
> On Thu, Oct 10, 2024 at 07:14:00PM -0700, Howard Chu wrote:
> > Changes in v2:
> > - Resolved a clang-16 build error pointed out by Namhyung Kim
> >   <namhyung@kernel.org>

> > The new augmentation feature in perf trace, along with the protocol
> > change (from payload to payload->value), breaks the clang 12 build.

> > perf trace actually builds for any clang version newer than clang 16.
> > However, as pointed out by Namhyung Kim <namhyung@kernel.org> and Ian
> > Rogers <irogers@google.com>, clang 16, which was released in 2023, is
> > still too new for most users. Additionally, as James Clark
> > <james.clark@linaro.org> noted, some commonly used distributions do not
> > yet support clang 16. Therefore, breaking BPF features between clang 12
> > and clang 15 is not a good approach.

> > This patch series rewrites the BPF program in a way that allows it to
> > pass the BPF verifier, even when the BPF bytecode is generated by older
> > versions of clang.

> > However, I have only tested it till clang 14, as older versions are not
> > supported by my distribution.
 
> > Howard Chu (2):
> >   perf build: Change the clang check back to 12.0.1
> >   perf trace: Rewrite BPF code to pass the verifier
 
> Tested with clang 16.  And I think it's better to change the order of
> the commits so it can fix the problem first and then check the version.

So, I tested it on a RHEL8 system and it gets built with clang 17 but
then fails to load, the verifier complains about lack of bounds checking
for the index of the syscall array, with or without this last patch from
Howard.

I also simplified it to a more minimal version withour renaming
variables, so that we see what exactly fixed the problem, its available
at the perf-tools/tmp.perf-tools branch, I've talked about it with
Howard over chat.

Song Liu reproduced the problem (unsure with what clang and kernel
versions) and couldn't find a way to fix it using the usual tricks to
coax clang to keep the bounds checking for the verifier to get
satisfied.

More generally I'll use virtme-ng[1] to test with a wider range of
kernels, not just clang versions.

- Arnaldo

[1] https://kernel-recipes.org/en/2024/virtme-ng/

