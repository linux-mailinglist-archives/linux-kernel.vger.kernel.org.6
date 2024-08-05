Return-Path: <linux-kernel+bounces-274603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99816947A96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58451280BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C6155C91;
	Mon,  5 Aug 2024 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HR4s3jic"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45B6A01E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858720; cv=none; b=nI+wV7tGNqZpek/CB+SQoBUiui+kV3/O1RL8XQQEADBbBz1cAn2bU1xjwcHsUaXizsvJKtDx045s7jBA/JDfksAYaT2v4Hb4ZO6C5A5/GlAeDXMlRzRdh97qRhGfZRPVUoMHL1iojaU1Lv9h3/jeOr6GXrc05zCUk+6ho2pDFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858720; c=relaxed/simple;
	bh=39ikGAUgN7yBzbqmm98MctXQRiVLr6garTIzfzcO3M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFHVeIBabAbcZzk+PeFSIdRnBwn0JBtka4kG+zrEDns5X4hsezz/KQh+WyB80RCQSOeZVxURGpuGHIR+Md3AhTLNQPEX2Ig3qBgEqi2LQbISspslUcb3VOlqdBlX5I00K1L+YoAITMWsuwBNnXf9NltcufZvUHRJapEhmF3LeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HR4s3jic; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722858715;
	bh=39ikGAUgN7yBzbqmm98MctXQRiVLr6garTIzfzcO3M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HR4s3jicEjalCsCG3xzaKW8RXOBRiFrVZgje1Rk4kAHMuMrpeGsOGSZQ6Q+ulxWCS
	 b7ivl+9drYPC28sLlxUe02t8+pPHv+EnlIcBRXc8S6OU6o8VWQrLGqxhhH7R0Wso5/
	 uD8XuvlV/9EZlBDp9I5EZORr/ugwNA8z9dCoYVIs=
Date: Mon, 5 Aug 2024 13:51:55 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] sysctl: avoid spurious permanent empty tables
Message-ID: <4baef4a5-6b02-4e2f-870a-810c615a59ce@t-8ch.de>
References: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
 <20240805-sysctl-const-api-v2-1-52c85f02ee5e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805-sysctl-const-api-v2-1-52c85f02ee5e@weissschuh.net>

(trimmed recipients to only sysctl maintainers)

Hi Joel,

On 2024-08-05 11:39:35+0000, Thomas Weißschuh wrote:
> The test if a table is a permanently empty one, inspects the address of
> the registered ctl_table argument.
> However as sysctl_mount_point is an empty array and does not occupy and
> space it can end up sharing an address with another object in memory.
> If that other object itself is a "struct ctl_table" then registering
> that table will fail as it's incorrectly recognized as permanently empty.
> 
> Avoid this issue by adding a dummy element to the array so that is not
> empty anymore.
> Explicitly register the table with zero elements as otherwise the dummy
> element would be recognized as a sentinel element which would lead to a
> runtime warning from the sysctl core.
> 
> While the issue seems not being encountered at this time, this seems
> mostly to be due to luck.
> Also a future change, constifying sysctl_mount_point and root_table, can
> reliably trigger this issue on clang 18.
> 
> Given that empty arrays are non-standard in the first place it seems
> prudent to avoid them if possible.

Unfortunately I forgot to include the following trailers in this patch:

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408051453.f638857e-lkp@intel.com

They will be part of v3 if it comes to that, but if you end up applying
v2, please do also add those trailers.

> Fixes: 4a7b29f65094 ("sysctl: move sysctl type to ctl_table_header")
> Fixes: a35dd3a786f5 ("sysctl: drop now unnecessary out-of-bounds check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  fs/proc/proc_sysctl.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 9553e77c9d31..d11ebc055ce0 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -29,8 +29,13 @@ static const struct inode_operations proc_sys_inode_operations;
>  static const struct file_operations proc_sys_dir_file_operations;
>  static const struct inode_operations proc_sys_dir_operations;
>  
> -/* Support for permanently empty directories */
> -static struct ctl_table sysctl_mount_point[] = { };
> +/*
> + * Support for permanently empty directories.
> + * Must be non-empty to avoid sharing an address with other tables.
> + */
> +static struct ctl_table sysctl_mount_point[] = {
> +	{ }
> +};
>  
>  /**
>   * register_sysctl_mount_point() - registers a sysctl mount point
> @@ -42,7 +47,7 @@ static struct ctl_table sysctl_mount_point[] = { };
>   */
>  struct ctl_table_header *register_sysctl_mount_point(const char *path)
>  {
> -	return register_sysctl(path, sysctl_mount_point);
> +	return register_sysctl_sz(path, sysctl_mount_point, 0);
>  }
>  EXPORT_SYMBOL(register_sysctl_mount_point);


Thanks,
Thomas

