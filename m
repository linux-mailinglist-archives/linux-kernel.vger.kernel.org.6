Return-Path: <linux-kernel+bounces-440858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20519EC584
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6728E2851C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE251C5F10;
	Wed, 11 Dec 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL9hKZZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240FE1C5F00
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902075; cv=none; b=JBJg+ivpx5R8LBmftZsPdFSaRvG0jnFxlhOJj1TSBINg3H9J5B2L5Jg0uK0OCNzZSIZC+iTgBOzb6XzQyAC2TZJMEVIY+3dUqGpGAuPZo3mGBJFre2Z5Rmjc1CAkXBLYZ5eBU8zKYzqV7ha4vvDiydNpghRO71BsEh2gZT6YqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902075; c=relaxed/simple;
	bh=VwvathRKpZR7sNLqziBMOuaT44TXv9VMLztB/oCKC64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F513AUZCtAYM1D2eJbWtDd+JFNe6duj7spmA4YWf702kf7ZOAza52u3IOUsGXrGKjWRaJz/YwJ8fYcteE3ZmRVxniUoleodX2/mUYjWvA9l9YrIKJh15lQipQAA7fDuhQCQYsfhaFbhOuUlddcNqWTfH5C/qp7EA6JCska/u1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL9hKZZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1B7C4CED2;
	Wed, 11 Dec 2024 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733902074;
	bh=VwvathRKpZR7sNLqziBMOuaT44TXv9VMLztB/oCKC64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OL9hKZZi+BQ9apLiCQZ/VafTdW3WuWnN2bW1usu014riCU1wJHj3tM1zkKey1O0Il
	 xMLXs/KhxniZ6RNcA7ulZA/nMo8lGyrnw53sbAqLQBTfOixgZMFkyRvW9yE2cuIDbz
	 EzSJ7tu09lj5Qsk/Rr/jTraxQD411nKfB4iFiES7QTKFyOBqNFN529mzrwn41yluBF
	 Nkpf4NF0MMDSs9CIdZD0ojqpCsKazMgP0yomRW43wLM9+Dj43CNRU/ozNc7t6p6/ym
	 19dGsWqHgbR/RZ0G/KmKQ550OC5fUyyEgFVm2QYEVh07chK9eKtRaa+Ok8gPu4rUbN
	 wMZWZ4KCoAuJQ==
Date: Tue, 10 Dec 2024 21:27:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] sched_ext: Relocate scx_enabled() related code
Message-ID: <Z1k--b0f1RLARJ65@slm.duckdns.org>
References: <20241209061531.257531-1-changwoo@igalia.com>
 <20241209061531.257531-2-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209061531.257531-2-changwoo@igalia.com>

On Mon, Dec 09, 2024 at 03:15:26PM +0900, Changwoo Min wrote:
> scx_enabled() will be used in scx_rq_clock_update/stale() in the
> following patch, so relocate the scx_enabled() related code to the
> proper location.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/sched/sched.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 76f5f53a645f..440ecedf871b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1717,6 +1717,19 @@ struct rq_flags {
>  
>  extern struct balance_callback balance_push_callback;
>  
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +extern const struct sched_class ext_sched_class;
> +
> +DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);	/* SCX BPF scheduler loaded */
> +DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
> +
> +#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
> +#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
> +#else /* !CONFIG_SCHED_CLASS_EXT */
> +#define scx_enabled()		false
> +#define scx_switched_all()	false
> +#endif /* !CONFIG_SCHED_CLASS_EXT */

I wonder whether a better place for the above is include/linux/sched/ext.

Thanks.

-- 
tejun

