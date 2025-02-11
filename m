Return-Path: <linux-kernel+bounces-509991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB95A316F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A275168A29
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333232641CB;
	Tue, 11 Feb 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRe+uaTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A941CA84
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307322; cv=none; b=VVIH+IzqfkHQwgMDwXYzVZfjrD2uD4PTvTMH2I90fnvjA3WSrqwcb9EHMctStdOEvVDiR+nup7fxVfFKaKIqrcy2uDA7JSNZ2bXQHqHiRmTBUz+KO1Yi/9MDqjQCb/9NF4qkknjYD+jv0tvX6e2uFJHRj/8wQdU89AdgbDd78yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307322; c=relaxed/simple;
	bh=MAVRVwvKPz2MTsRCiP/+SknMX+X6PxyJk7h5D/wVeJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGLH9eh71LUV3gU5StFXkAR9O3i3VjFXsm4WREtqaWVmLVuL1F/oMj3N0ZQb3wwU/qpClifY6QIbPRiRabaU+/vOqRxximLcFJ5NTSGDTQOwIWxzNepPTUCeuILC05EPnkohG/t2fyd7oj9vCQHmQwBp0mz1w2QcG3t2u+cyezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRe+uaTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3764C4CEDD;
	Tue, 11 Feb 2025 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739307322;
	bh=MAVRVwvKPz2MTsRCiP/+SknMX+X6PxyJk7h5D/wVeJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRe+uaTpoNkO77iz4yUDQnTow/GlONddlvOVnFyupzlv4+EBLSA0PZVCqVdZfdObL
	 goakqDmCMwQmksT0PUHVm9tDyrsgIJOcrPRHNXHOMsrYUwzWrjfxnRP96MoHJBAu7W
	 qp3esDDaUVIay2Ctr997qxBcuPBL8NWaFSe/yNZilclqHl7ey1LbG4RldR8OIzzrYm
	 i8DAGnghfplMKzv8673Ky+yTuttOWcFIHa1RKFyeVWZvZ+Et27/vniahIveasChuVX
	 LF5AqK/1jfJ7xRsUvc9FmEoQLwEhdgbYC9NOqD2YtspIIdT/POla5BdhJAH+/SrwhC
	 m9VYMuCdxU9/w==
Date: Tue, 11 Feb 2025 10:55:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>, Filipe Manana <fdmanana@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Message-ID: <Z6u5OJIQBw8QLGe_@slm.duckdns.org>
References: <20250206122633.167896-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206122633.167896-1-mhocko@kernel.org>

Hello, Michal.

On Thu, Feb 06, 2025 at 01:26:33PM +0100, Michal Hocko wrote:
...
> It has turned out that iscsid has worked around this by dropping
> PR_SET_IO_FLUSHER (https://github.com/open-iscsi/open-iscsi/pull/382)
> when scanning host. But we can do better in this case on the kernel side

FWIW, requiring GFP_KERNEL context for probing doesn't sound too crazy to
me.

> @@ -2204,7 +2204,12 @@ static void pcpu_balance_workfn(struct work_struct *work)
>  	 * to grow other chunks.  This then gives pcpu_reclaim_populated() time
>  	 * to move fully free chunks to the active list to be freed if
>  	 * appropriate.
> +	 *
> +	 * Enforce GFP_NOIO allocations because we have pcpu_alloc users
> +	 * constrained to GFP_NOIO/NOFS contexts and they could form lock
> +	 * dependency through pcpu_alloc_mutex
>  	 */
> +	unsigned int flags = memalloc_noio_save();

Just for context, the reason why the allocation mask support was limited to
GFP_KERNEL or not rather than supporting full range of GFP flags is because
percpu memory area expansion can involve page table allocations in the
vmalloc area which always uses GFP_KERNEL. memalloc_noio_save() masks IO
part out of that, right? It might be worthwhile to explain why we aren't
passing down GPF flags throughout and instead depending on masking.

Also, doesn't the above always prevent percpu allocations from doing fs/io
reclaims? ie. Shouldn't the masking only be used if the passed in gfp
doesn't allow fs/io?

Thanks.

-- 
tejun

