Return-Path: <linux-kernel+bounces-169645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C48BCBB0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A8E1F2361E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD2142642;
	Mon,  6 May 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POa9s/Iy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454EF4205F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990221; cv=none; b=kYE61dgo/0FV/eLqkFrR9R+/g5hupgu3CO/x03cJyjnWDiY06IqKyDzsCL2AVOADa8GJGtsWBlm30nufHm2wb8A3RFno6ERcHBQvSHNBIzmtk6MoG4wihy91mGUL3UzOByVD9K9kN7X447Oc7v/6lOBwS8ZKJ4l8QWuXXIqwQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990221; c=relaxed/simple;
	bh=UabQAUK3En/3LuQtSYQlzotWfnD5PxaHVAmlM/KgexY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZh2+7Ednr/lf+1yjPHiwtZ/Zoml5j7zraBrzatWCfnybVUT2GxHe8M7y9jW27ggp0OBVoyRuypeQ1P8LfCCsF22YQmgV7u6ljRQZNguEOffGLQ18ngvN9s6IHoxIosaweb7+lqB68zvjPHZmAPyuXnNMckP6HTIQ7Z93/h1H8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POa9s/Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A86AC116B1;
	Mon,  6 May 2024 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714990220;
	bh=UabQAUK3En/3LuQtSYQlzotWfnD5PxaHVAmlM/KgexY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POa9s/IyH2KONdMog2F87clkt9RkLiiCEbUFSlSahXaf9QNTa+Hkb3NbnY6BpWXR2
	 4TtYfDmCpBm6qw8u1tWr6ae/r+ygOO9g43wmf/e3txPtg3X5xtt1c2P5sL6uD6/Ivg
	 HoLt91aG6hn64wU3Vm5c/eKtrwdhylPC+jQoYeiUPu9lUeNCN4965w70yg4jDCbrm+
	 yD9BAKypIRpRKvIKzyMVJgF1Bd5xNitokhPRsgHEgzcErKx/yLDgx8BNqmCro2Z0m2
	 jooiRUOkbq//YgQiYv0lZ/r23KlLgjNM5CMJzH07Dy8UNQFZ3ZgTv0rKM7zdZKmwpl
	 WWxK0YwHUYOpQ==
Date: Mon, 6 May 2024 12:10:18 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Levi Yun <ppbuk5246@gmail.com>
Cc: anna-maria@linutronix.de, tglx@linutronix.de, Markus.Elfring@web.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] time/timgr: Fix wrong reference when level 0 group
 allocation failed
Message-ID: <ZjisiuqiR9p76YcJ@localhost.localdomain>
References: <20240505085709.82688-1-ppbuk5246@gmail.com>
 <20240506041059.86877-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240506041059.86877-1-ppbuk5246@gmail.com>

Le Mon, May 06, 2024 at 05:10:59AM +0100, Levi Yun a écrit :
> When tmigr_setup_groups() failed level 0 group allocation,
> wrong reference happens on local stack array while intializing timer hierarchy.
> 
> To prevent this, Check loop condition first before initializing timer hierarchy.
> 
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
> v3:
>     - Fix typo.
> 
> v2:
> 	- Modify commit message.
> 
>  kernel/time/timer_migration.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index ccba875d2234..84413114db5c 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -1596,7 +1596,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
> 
>  	} while (i < tmigr_hierarchy_levels);
> 
> -	do {
> +	while (i > 0) {
>  		group = stack[--i];
> 
>  		if (err < 0) {
> @@ -1645,7 +1645,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
>  				tmigr_connect_child_parent(child, group);
>  			}
>  		}
> -	} while (i > 0);
> +	}

Looks good to me. But let's wait for Anna-Maria's second look. The group setup
is not my favourite area...

Thanks.

> 
>  	kfree(stack);
> 
> --
> 2.41.0

