Return-Path: <linux-kernel+bounces-176812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381398C354E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 09:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D65281B67
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E627168B8;
	Sun, 12 May 2024 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sWF2dRQo"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F914265
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715498540; cv=none; b=UpFSAQqHBI65wJuTY/mw1JOH3yOjAFhb+moYtyE7o4F4Ul9Ei2cgIGpvjhIAUAMJXrVVItuHFM9TbX5dYClCR6Zr7tRSmrsoyH5QM4u9wN73wmCPOr8hY++f9jjmKbXdz0N3aEwd3uv7lB+NHFD02V/81SEYLPpkuqYW9A+IXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715498540; c=relaxed/simple;
	bh=9ioxjcM/LgA4IkV8XhTL6DxF8jZt95CIPT9t08Xev7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTo6ncjyNcPLlAm6YxT4/gsITDzca0Uc3czB9m0/Yoi33qW1lWf/oIRAcxuu6DcSDVLe9OxE0NgcwWUkLs67X3laEkZdo0gfgXHoVGgoA6sqpLB1mvrDqE3gfrLY582S6jedX2k6KZXmcPmQu1745B7nrcX28X8WRlsKiParyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sWF2dRQo; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715498534;
	bh=9ioxjcM/LgA4IkV8XhTL6DxF8jZt95CIPT9t08Xev7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWF2dRQoLhbcsauQ5Dt8C5bj0ol9Xy0i7+eGP0/uVDcI9dDDLQIYD24wgrUgxHEwJ
	 KVh9Mbg/XEUfdk0INhTwPIsEhei46xkJZ2JXPIg5QzhJxkBZzMTpSE0lf3cSCxGwK8
	 gqCS7Wf1Pc93cZ6XChOZxIuwlkVp2hb1sVgShlEU=
Date: Sun, 12 May 2024 09:22:13 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: linux-kernel@vger.kernel.org
Cc: Joel Granados <j.granados@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] ucounts: constify usage of
 ctl_table_header::ctl_table_arg
Message-ID: <dbd64d52-977f-4229-9f36-82a45d65fbe7@t-8ch.de>
References: <20240511-sysctl-const-table-arg-ucount-v1-1-a00ad8f6f233@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240511-sysctl-const-table-arg-ucount-v1-1-a00ad8f6f233@weissschuh.net>

On 2024-05-11 21:28:10+0000, Thomas Weißschuh wrote:
> The sysctl core is preparing to only expose instances of
> struct ctl_table as "const".
> This will also affect the member
> ctl_table_header::ctl_table_arg.
> 
> Prepare for that change to "struct ctl_table_header",
> and already constify the usage of ctl_table_arg.

Please disregard this patch.
Apparently Dave already picked it up as part of [0] through the
net-next tree, which makes sense the ctl_table_arg changes are in net/
for the largest part.

See commit bfa858f220ab ("sysctl: treewide: constify ctl_table_header::ctl_table_arg").

[0] https://lore.kernel.org/lkml/20240418-sysctl-const-table-arg-v2-1-4012abc31311@weissschuh.net/
> 
> No functional change.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Motivation
> ==========
> 
> Moving structures containing function pointers into unmodifiable .rodata
> prevents attackers or bugs from corrupting and diverting those pointers.
> 
> Also the "struct ctl_table" exposed by the sysctl core were never meant
> to be mutated by users.
> 
> Process
> =======
> 
> * Drop ctl_table modifications from the sysctl core ([0], in -next)
> * Constify arguments to ctl_table_root::{set_ownership,permissions}
>   ([1], in -next)
> * Migrate users of "ctl_table_header::ctl_table_arg" to "const".
>   (in progress, this patch)
> * Afterwards convert "ctl_table_header::ctl_table_arg" itself to const.
>   (to be done)
> * Prepare helpers used to implement proc_handlers throughout the tree to
>   use "const struct ctl_table *". ([2], in progress)
> * Afterwards switch over all proc_handlers callbacks to use
>   "const struct ctl_table *" in one commit. ([2], in progress)
>   Only custom handlers will be affected, the big commit avoids a
>   disruptive and messy transition phase.
> * Switch over the internals of the sysctl core to "const struct ctl_table *" (to be done)
> * Switch include/linux/sysctl.h to "const struct ctl_table *" (to be done)
> * Transition instances of "struct ctl_table" through the tree to const (to be done)
> 
> A work-in-progress view containging all the outlined changes can be found at
> https://git.sr.ht/~t-8ch/linux sysctl-constfy
> 
> [0] https://lore.kernel.org/lkml/20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net/
> [1] https://lore.kernel.org/lkml/20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net/
> [2] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net/
> 
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  kernel/ucount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 4aa6166cb856..d9e283600f5c 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -119,7 +119,7 @@ bool setup_userns_sysctls(struct user_namespace *ns)
>  void retire_userns_sysctls(struct user_namespace *ns)
>  {
>  #ifdef CONFIG_SYSCTL
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
>  
>  	tbl = ns->sysctls->ctl_table_arg;
>  	unregister_sysctl_table(ns->sysctls);
> 
> ---
> base-commit: cf87f46fd34d6c19283d9625a7822f20d90b64a4
> change-id: 20240511-sysctl-const-table-arg-ucount-75027ec3fbf4
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 

