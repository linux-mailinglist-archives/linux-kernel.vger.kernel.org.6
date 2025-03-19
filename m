Return-Path: <linux-kernel+bounces-568925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC0A69C25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA675189BF97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB721C18D;
	Wed, 19 Mar 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2nVXPF7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5021859F;
	Wed, 19 Mar 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423758; cv=none; b=M1emcHG48w5fApxPr7tefI81FJRbVMvWRxrD5y9Ih4Zlh1WpS98/NfHs86ksHhls9CFX1jmSduJKb6bgRZgSmUrbNjjMZIj/JUebyApT9MF4Zyt8YX8FOOx0TPAHRORwlSbZnXH8gWsOQ/MSIVQnMtodMMXKj+tcN0IGGPzyUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423758; c=relaxed/simple;
	bh=t9LrwQm4+WnBdqI7kdntfnIZkPemuCuJkq5GcZA0rEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcbLUu6Cn+Zws+5LjUI11FfslEzw5HmbTE7TsxFMY7IKlS8tze6gzgkz2qinBVJ3fIOVvKd25Gb2UvOIxlBPWbx2zKx4hzlfdnTTVX4dpiawv1d+COsA3gZeta9P/Aul98RHjRczwUoDlZKQpwh41ZGT3jy7B0uveq/de9QG9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2nVXPF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD031C4CEE4;
	Wed, 19 Mar 2025 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742423758;
	bh=t9LrwQm4+WnBdqI7kdntfnIZkPemuCuJkq5GcZA0rEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2nVXPF7Az9vWUVSb2Pgi6VDuTdIxF/TzuQHVblnN8JkeUZgmyFDWXgRwXrBwl0o+
	 685eZQ+jtppKo7Xbv7paVc20Rjb3YYsrHNudGj6ti/QCVh/1O0GufxADLENwZqoGjk
	 7zwUTTLqBf0C4Z+RvDMMaItk3Vx4lgfQ5fTTkGbnNsF4RAoFLDYk4Juz4vtXzpW6Jh
	 KNOHmY2lfA/Gyyv7wbhRrWzTVfYtgnlrMPtgHfYXb0lZjBIktjK44Qb0xtMBm/wgTi
	 TuSk2gEOjLIP3UHSVV4epJ8C9wpSY/qz66PzjvXk4DAXoRSVai11y5wMWJQKOhpsn3
	 qfrD03uMGqc8A==
Date: Wed, 19 Mar 2025 15:35:55 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-toolchains@vger.kernel.org, live-patching@vger.kernel.org, indu.bhagat@oracle.com, 
	puranjay@kernel.org, wnliu@google.com, irogers@google.com, joe.lawrence@redhat.com, 
	mark.rutland@arm.com, peterz@infradead.org, roman.gushchin@linux.dev, 
	rostedt@goodmis.org, will@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] arm64: Implement arch_stack_walk_reliable
Message-ID: <yrqgoc66te54tuffkrc74clsosiid2giw3gpc3kd3ddl4662tb@kiqh3ncfxwnl>
References: <20250319213707.1784775-1-song@kernel.org>
 <20250319213707.1784775-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319213707.1784775-2-song@kernel.org>

On Wed, Mar 19, 2025 at 02:37:06PM -0700, Song Liu wrote:
> +noinline noinstr int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
> +			void *cookie, struct task_struct *task)
> +{
> +	struct kunwind_consume_entry_data data = {
> +		.consume_entry = consume_entry,
> +		.cookie = cookie,
> +	};
> +	int ret;
> +
> +	ret = kunwind_stack_walk(arch_kunwind_consume_entry, &data, task, NULL, true);
> +	if (ret == -ENOENT)
> +		ret = 0;

Is this check redundant with the -ENOENT check in do_kunwind() which
already converts ret to zero?

-- 
Josh

