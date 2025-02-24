Return-Path: <linux-kernel+bounces-529887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 598C1A42C31
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26803A62C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4482E266B54;
	Mon, 24 Feb 2025 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1pcJe50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A3158525
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423565; cv=none; b=sOcJKcfKLomcO/PB9R4Jv/QOutKw92nr2lVQQHqjMdxOAIK1D9cAmtWDnXHxmgcCguk65Cd1qYprntAIq7kqo/VE1HczXTwQ09nVUv6+e6K0/X4oCcCRjQNER2ruMkkuktemTJhkrf8/2GzHrGNAKBFkd3sn3CefbBO9ri6haxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423565; c=relaxed/simple;
	bh=JJspDvn3Om6/b3J6tK43rmnfodLxeOlvIcFvMczfx+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFKG5oo/m0EAzo16AMJCy82PMECTDUMs+6NfM/5iX24rtEniORAc22o3ZQ/GaNCT+4MOeNq1+CEILuRYj8au3P8lawCyx294iAc7vutk5QKinFaDBOslpd7PAyyrNLF5XdfNT1zJwqI4G3etZpLtvIk/WEU3/Jm+A4v7LloKZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1pcJe50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6BCC4CED6;
	Mon, 24 Feb 2025 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423565;
	bh=JJspDvn3Om6/b3J6tK43rmnfodLxeOlvIcFvMczfx+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1pcJe507rOXd1lfSemRSxe23ULDV/xZUzsos6n4AAKC1CWcL3d1Sbfnfm3zEYJls
	 62EVZ5hzP63GGqeMdiW0+Z82Sb5bQIphMk/tDybrrgtBpNQfjDS69Fr/P4YRgBGS3a
	 dbJprje/9IjOASPLRdu/MND34JliCMjGBo8UJ49fr/BtLj/GMvh5W1VaXfoRZckjQs
	 XupX43A5DPnBjQqUDA5eJ7/xk+aQYik6EPETyoZ4DFX1+6MiKmKd12uinGeebXquMu
	 ciDjS6nwZti+7B3ZEzNPmd/WFgm5qYS49LWEff3VayZPR6dWuzU7iKp8YIQP72U5dK
	 WK8NjlU1fN1iA==
Date: Mon, 24 Feb 2025 10:59:21 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v4 04/10] x86/traps: Allow custom fixups in handle_bug()
Message-ID: <202502241058.BF06AF37C@keescook>
References: <20250224123703.843199044@infradead.org>
 <20250224124200.275223080@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224124200.275223080@infradead.org>

On Mon, Feb 24, 2025 at 01:37:07PM +0100, Peter Zijlstra wrote:
> The normal fixup in handle_bug() is simply continuing at the next
> instruction. However upcomming patches make this the wrong thing, so
> allow handlers (specifically handle_cfi_failure()) to over-ride
> regs->ip.
> 
> The callchain is such that the fixup needs to be done before it is
> determined if the exception is fatal, as such, revert any changes in
> that case.
> 
> Additinoally, have handle_cfi_failure() remember the regs->ip value it

typo above, if you want to tweak that in your tree.

> starts with for reporting.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks for the added comment, my future brain will appreciate it. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

