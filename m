Return-Path: <linux-kernel+bounces-380829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A458F9AF6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505F01F228A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3439502BE;
	Fri, 25 Oct 2024 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc3a5qD4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492614500E;
	Fri, 25 Oct 2024 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819360; cv=none; b=HPtexDwmJt2P+Zwec6Nph93OKNTtkSosIcw7fB9x7/ln6B73Efe/dDbsGhe71lMYmYYs74qv/qRjSnV8+/Qvos20a1qVx/H6LsbmqIrx1SDwIsKpZLuAXtPLlqs0M4XoalrbEnO43WLGAPQMKt5hgEIAZFGb9vN2RfPN56mC8y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819360; c=relaxed/simple;
	bh=PHk+f02gxxCH78JZbRAia+WbVbQ0AJGC2OCKGNTcjio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW71+Sca8fKZWF7SLf/zpDev8XkiySYXRbsXZthvy1HlcKD09/87q6wITgW0s1C8Q5o5JyL++/m2KtBddcUUnkcVjxuF6kv3fgBA29AoGwdAVwk7hpdg4slyU51ugsUISBo1bdfkmvden3OWRcpm6pBpURAJJCy//gvl9kNMt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc3a5qD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E6DC4CEC7;
	Fri, 25 Oct 2024 01:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729819359;
	bh=PHk+f02gxxCH78JZbRAia+WbVbQ0AJGC2OCKGNTcjio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bc3a5qD4OqjSXdFp0YC/YQR9lx762k8SHCwE/zwZhxpyXyv48dUIt717zB96aKR7+
	 SbtSj8MwlVbEqKW6C26c2Gv6o2zrqmo5IcAdf9trqDWBrMN/JvUjo92s26V3q3ucWi
	 SwVTMP6SfuQ2T5YNj8O3yup9tLtPg6g55ljJSSSjBxw7k6gXkQa7QfiMG9awCkDHQD
	 4gwwY+qWszL0lQR6wpzSm5d2Y2wu3LFG30dKdvTnS3bFB7J/TTDGEYJ3awBZVLKiC5
	 ccRmySNrAF1EkoMB+XET2jpjv2HIDPApBSDm1XnR6mUqYlDl43boiMQwrU+Fj4sUuh
	 LLqYU6N14X0ow==
Date: Thu, 24 Oct 2024 18:22:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: clang-built-linux <llvm@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: powerpc: clang-nightly: fatal error: error in backend: Trying to
 obtain a reserved register "r2".
Message-ID: <20241025012237.GC740745@thelio-3990X>
References: <CA+G9fYs2G_4jyv-V7f85oE53rw5rX0Tnf2V8RQ=O9CuPcbfb2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs2G_4jyv-V7f85oE53rw5rX0Tnf2V8RQ=O9CuPcbfb2A@mail.gmail.com>

Hi Naresh,

On Thu, Oct 24, 2024 at 08:35:11PM +0530, Naresh Kamboju wrote:
> The powerpc clang-nightly version 20.0.0 build warnings / errors noticed on
> the Today's Linux next-20241024 tag.
...
> Build errors:
> ----------
> fatal error: error in backend: Trying to obtain a reserved register "r2".

Thanks for the report. I reported this upstream earlier, it should be
resolved now but it will take a little bit for that to filter into
clang-nightly from Debian.

https://github.com/llvm/llvm-project/pull/112603#issuecomment-2430709704

Cheers,
Nathan

