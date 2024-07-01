Return-Path: <linux-kernel+bounces-236584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB5D91E454
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9391C217DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB2C16D308;
	Mon,  1 Jul 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbqxQsNP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B853AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848421; cv=none; b=Cor7uk7epfNfvzaHR7s+SHYqd2gmJiRc9d/Xkb7LJTVng+b/QHKAA+zjABdhuCRY3bT5z2r0GsmVCbCoxbHVqUm904vjleMrnD/AYQ72Q2OHnJqre6sl8M8Gh1LRn8MdFcMpvpZOdKM2De9yawq8YJNWQcE9fAaHT7uk1ufUp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848421; c=relaxed/simple;
	bh=jzZ8xQY7eDm6paSkzdj5TLzcQV7wRCSr0mNrUY+RcFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUAgtd4AKDeUUisw2rCmegaEFAtf88aPnkCiCaEfZsr3Dq7mmxiRmFQ5+ktawkzBzr6szcn+cjNp8SwlVPy2vYGIIEeWsHBIgskeXKRX+yCjhvlosKIi81a6M/ScFqONynzWhOPBO3owkEyTLgicjgE2pJJ4wt946CtpciiqTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbqxQsNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73776C116B1;
	Mon,  1 Jul 2024 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719848420;
	bh=jzZ8xQY7eDm6paSkzdj5TLzcQV7wRCSr0mNrUY+RcFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbqxQsNPRL84pLMtwOYiIBqCdPxk+tbjUAUx+CXdTLUxDGXLqsBVDPtq2qjkTeX1z
	 QG9Bhz/Pf1HdH2lzwk1tLLqI94CkHRDuXMJpIa/J5CpQt9niePFr8r7nc3Q5fWV/o5
	 Z+i/bOmAYJTtaKFvo1i0W4+WRCYJWz6Pd1gUTqqvIY/aDfuTbs2MtvTprn4dhN15fv
	 AwMh4VYz+sc+OK3VQCl9RQcmJnFoMVrXmoRdqm5jv5Ir8z7n8n0VQR4Vi2lzbPhIBP
	 geh51ewBqrpDt6wXAuheehLmkaWwpN2N4mNx/4fAcqkRVVLWIC0BblIl99EEQQFU1D
	 I+EKdMaZ8q3zg==
Date: Mon, 1 Jul 2024 08:40:20 -0700
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	wad@chromium.org, rostedt@goodmis.org, arnd@arndb.de,
	ardb@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
	rick.p.edgecombe@intel.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64: entry: Convert to generic entry
Message-ID: <202407010839.125126F@keescook>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240629085601.470241-1-ruanjinjie@huawei.com>

On Sat, Jun 29, 2024 at 04:55:58PM +0800, Jinjie Ruan wrote:
> Changes in v3:
> - Test the MTE test cases.
> - Handle forget_syscall() in arch_post_report_syscall_entry()
> - Make the arch funcs not use __weak as Thomas suggested, so move
>   the arch funcs to entry-common.h, and make arch_forget_syscall() folded
>   in arch_post_report_syscall_entry() as suggested.
> - Move report_single_step() to thread_info.h for arm64
> - Change __always_inline() to inline, add inline for the other arch funcs.
> - Remove unused signal.h for entry-common.h.
> - Add Suggested-by.
> - Update the commit message.

I didn't see the mentioned feedback from tglx in any of the threads. Is
lore busted or is there discussion on this series happening somewhere
else?

-- 
Kees Cook

