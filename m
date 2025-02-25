Return-Path: <linux-kernel+bounces-532344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204FEA44BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D003B5B34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8B20D4FD;
	Tue, 25 Feb 2025 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORcc6eDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8E3D984
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513424; cv=none; b=J5NLeeE386DbMp8gkLVijQbE3F0q8mGFZ2cIc0fic0Xv/seYEt1nD4qJs8ae9WnlSIj8DbLXPU+An46XkfqVTJucPPRRdzh/S+0YIthnydJOz4+1lHca26wTHJBXWKJjPayHiO2FMtM8mkhilEYM8uTa/9xcBGTW4+i954l6ORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513424; c=relaxed/simple;
	bh=iKbp9uj0JQ9IjKLYp8W5mIcrFvgTECrDYD+VacIcHAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzxz+enSF6O1rGl2VXVQYysWabZxemAvqcG7k6au6yglxiQcFzxi+ex0VIdoiUc408+dZleSTkNVEMNSVuW3WTYVJ0Rg7y9c9QdnV4Oa8aYhs4NhyqqvWrWbjDyNKQS7wWpF8258Dl67XNnKN0MDhHCWxDR9kE2huWneyh4Zx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORcc6eDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643C0C4CEE7;
	Tue, 25 Feb 2025 19:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740513424;
	bh=iKbp9uj0JQ9IjKLYp8W5mIcrFvgTECrDYD+VacIcHAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORcc6eDM2HfvruiFgNFRCnOmDncjNIkrnIqCLpukKgfvzvAALiRCJsdzt8YnHyosF
	 Ecr2g23ThrHQUloMM6TBl/EziMCbaOpgIBPamsHfQpGGiSYxSQg8jkxoLqgcUzZNIV
	 6lb9/u1KEk7eSjY0GE8o+8R2mZbHP4MAW+ctawOR9TVZm92BzA9K0jK6H6ccYb6fhw
	 tSSAuvEHsl2jzy7pLBNwKxT17OGXoQID5NA1WEjaVdhWmqaMjSSO1QaHvNmrarZ0jk
	 AAomTfHwuKMF3wqiFQOT/eL2SRLS6QfDU+/jiImVZha6NuCaz6vk4m/0ecp1dtk1GS
	 xXj2nR7oSLsew==
Date: Tue, 25 Feb 2025 20:56:56 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rseq: update kernel fields in lockstep with
 CONFIG_DEBUG_RSEQ
Message-ID: <Z74giMre3SJo-3Zw@gmail.com>
References: <20250225153536.711012-1-mjeanson@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225153536.711012-1-mjeanson@efficios.com>


* Michael Jeanson <mjeanson@efficios.com> wrote:

> With CONFIG_DEBUG_RSEQ=y, an in-kernel copy of the read-only fields is
> kept synchronized with the user-space fields. Ensure the updates are
> done in lockstep in case we error out on a write to user-space.
> 
> Fixes: 7d5265ffcd8b ("rseq: Validate read-only fields under DEBUG_RSEQ config")
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/rseq.c | 85 +++++++++++++++++++++++++++------------------------
>  1 file changed, 45 insertions(+), 40 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 2cb16091ec0a..88aa780f8cf4 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -26,6 +26,11 @@
>  				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
>  				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
>  
> +static struct rseq __user *rseq_user_fields(struct task_struct *t)
> +{
> +	return (struct rseq __user *) t->rseq;

Why is this wrapper needed?

task_struct::rseq is already of that exact type AFAICS:

        struct rseq __user *rseq;

Thanks,

	Ingo

