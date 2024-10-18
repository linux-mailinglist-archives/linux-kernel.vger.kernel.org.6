Return-Path: <linux-kernel+bounces-372148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318169A4512
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E8C1C235FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B917F20E034;
	Fri, 18 Oct 2024 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVS3FBKS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6120CCF3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273092; cv=none; b=TxKdmUOD9YIXZa7YH5tnseV8PWlf+GPnDK5n8yESnQVfA0JU6pWeiiqCz2+IgOYJDdTlttBogewrRU8USAVG+g1tSZ3H6W7lvRyV/pNQORbZkLl2/rcgJQ+F4I3kJueElb+bcBS36T6RBx/+N6uQq0it1uXkqA8YMa9edCo4TDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273092; c=relaxed/simple;
	bh=/WwG2nBKitX+1RNzik1QeAOTYQ8xT2tp7zM2eg3iCr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM7yjjdTvmPM25XPcyO/uKy3p9q/Q7QVPArLgSC4jZ3/50P0z24nM28BABncsi4BKr6SO5fusk2+PFfbQRKgnSaVaczP82OyGcyo+eHZwisrgHsnJ+h0nQHxe5FlFJY9psI3NZoqJCKbWxh4K/Mb5FcA1PaKhIxX9OteAic3Kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVS3FBKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F90C4CEC3;
	Fri, 18 Oct 2024 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273091;
	bh=/WwG2nBKitX+1RNzik1QeAOTYQ8xT2tp7zM2eg3iCr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVS3FBKSjAKPrfS7xbi6zr7BoMXxXukk29ZdCNnCwGUHT/qA1EmUTsu4wMbHFIpFh
	 wx/2r9O4D0/AIw2ZAMOLNrGGwlNdlxmSdhXxh0MX+ZxuhvGGK1R2ODZRw15wge7BwV
	 svy5+I0wOa6wGVEJmsZgqVHNCurKxQxcvYsdradit7v1sdW0DUsmDATPTA+qk6Waeo
	 +nbYYq4+CKzQVoc8V9Bnvexs9EQVaRz/0t7gOR+tFzkSbH8tnpKDMVcW1HvAzTdU/f
	 mkRKmXV1Z/mhE3Mvoqz/RPw1oz2aQplWw0EgVpdIImZ5WPWbMCsIsCJY5F5RDScd9Z
	 Z6Iyqc0yHGvHw==
Date: Fri, 18 Oct 2024 07:38:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: improve WAKE_SYNC behavior for default idle
 CPU selection
Message-ID: <ZxKdAvnLOmzPH4in@slm.duckdns.org>
References: <20241018094033.160188-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018094033.160188-1-andrea.righi@linux.dev>

Hello,

On Fri, Oct 18, 2024 at 11:40:33AM +0200, Andrea Righi wrote:
...
> +	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
> +	 */
> +	if (wake_flags & SCX_WAKE_SYNC) {
> +		cpu = smp_processor_id();
> +
> +		/*
> +		 * If the waker's CPU is cache affine and prev_cpu is idle,
> +		 * then avoid a migration.
> +		 */
> +		if (cpus_share_cache(cpu, prev_cpu) &&
> +		    test_and_clear_cpu_idle(prev_cpu))
>  			goto cpu_found;

Shouldn't this do set cpu to prev_cpu before jumping to cpu_found?

Thanks.

-- 
tejun

