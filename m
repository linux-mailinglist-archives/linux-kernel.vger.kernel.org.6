Return-Path: <linux-kernel+bounces-532114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DBBA4491D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F753ACF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E9A19ABD4;
	Tue, 25 Feb 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvJ06lCY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424AC16C854
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505509; cv=none; b=hhAl9dOB5rP8B/pHjvz8gPwJCFAi/CsfE/GhACVoKXpLxdZeb9a8Rr1aymZUVJVOr8pHR23Z7TC1glKSJOHG2JK2edgJZep9Vrctz9Y3+fxYboeTE8ZpFdlK7aWhXCmXzOh7mgMOi+/1Iu9EZbPN3nEvOi5E7ammITgavKvT+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505509; c=relaxed/simple;
	bh=qMC1G53B0kgt+Y+HqfFOiFmpS48OD+5yN99/y4z/p/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaLBy1R63cWQx8VJewAOtIRIX6qmM04sNTMajE3OXsFRORAUgtvEzqdAla3ldIJ2K+u8WmScByMiB0U6iDzMbqgET/XdmpGGIOfFE3CoHRY7YB5gmZIVwWsF3TgYv9orUr/l2BnX1f63ti0VnVCAgjnW7xLV5/EL3DeTM7fx6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvJ06lCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CD0C4CEDD;
	Tue, 25 Feb 2025 17:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505508;
	bh=qMC1G53B0kgt+Y+HqfFOiFmpS48OD+5yN99/y4z/p/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvJ06lCY2QLsqwR9gAgU3Xrd8x6HhB50EUa2w5OijAOTxOGWvQaN36P6lMXHRJdND
	 Tq+n5ENHC0fzOyfqnQpL3xixFELT+RM1NwxwWo1zbfkuJtTHtADpMLGIWX6ZZQodDD
	 xGQ+q62ZmB3crKPE0ynEDYMAn+61kL+fcoQbQLwzww3BVsLoOeR+OIVASivL3fwT6B
	 TQZUwCZUMdHaon2m0ND/ujChCsHyMwBEn2mjCMaqBWLRPc/tLwoD8fvy29RNnGyASV
	 Uzknjh2mHv0zHBx0JE2/jPIaYb2jtp17ALl0Dc72p1VRcW6lUn5TWRrMslF2CkqRHQ
	 Ih3pbqAyFm4xA==
Date: Tue, 25 Feb 2025 07:45:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.14-fixes] sched_ext: Fix pick_task_scx()
 picking non-queued tasks when it's called without balance()
Message-ID: <Z74Bo8PEbDLiQYWm@slm.duckdns.org>
References: <Z73pjysZYNEIbkiy@slm.duckdns.org>
 <Z736Z48iRdjGgzK7@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z736Z48iRdjGgzK7@gpd3>

On Tue, Feb 25, 2025 at 06:14:15PM +0100, Andrea Righi wrote:
> > Fix it by testing whether @prev has SCX_TASK_QUEUED set. This makes
> > $prev_on_scx only used in one place. Open code the usage and improve the
> 
> nit: @prev_on_scx?

Yeah, I don't know. Some people use @ only for arguments and $ for
variables. Others always use @. I flip flop between them.

Thanks.

-- 
tejun

