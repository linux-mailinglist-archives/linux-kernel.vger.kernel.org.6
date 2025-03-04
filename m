Return-Path: <linux-kernel+bounces-544944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EAA4E6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA60189F051
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB9D294EC0;
	Tue,  4 Mar 2025 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xCLtv+33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F9927EC83
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105386; cv=none; b=Qwaobti7lWeoZ1xB0XSSdw4sPLj9ligqyKZXQifHQV7bANJ43j/mPfn2faVbJgTdinZlZzEw2hbMYLsDI3ZvNw0J/guGzBrXoN3MqCKpHStOXj+qwgA7qvKCY3GT6Pc3aqzn0to9A96d2bG2S1wQc3k9M5GGMeDNWr5LsYc4xgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105386; c=relaxed/simple;
	bh=rAjJcLnO0KyiSNHwIq9oegnuDgZQjl1pSszoUPWh8wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJPGr7FSr4bDmsAkRq1oZ80CqxWsmNoWicwPYQCpCxy3RP1mCWGAi/5jxHDkBa9F40iYPFgWSi2PG68QDuSw1vnFO3HchHt3vHQAjWxojvpxJdew9yWxzw1mPpEVb6rC6ZU5cgOJ0FT10XORwkQConcJhQQPLJsi2Ndkv9I23/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xCLtv+33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031EEC4CEE5;
	Tue,  4 Mar 2025 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741105385;
	bh=rAjJcLnO0KyiSNHwIq9oegnuDgZQjl1pSszoUPWh8wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xCLtv+33o4FfrOymcp1I6954RyVQMW13Ux/N22WzjTa529mKYLCQ/an2qMCQUQsmM
	 rdc6LmxKHkbg96KhaP6X3iQ6d6E4AIyB4T02zEBU1uwZ6YxrCtjbR1shBM3OiPht72
	 VLhxfMQpd5cmDCC6Yxln/c7h8OzjAnPkeLhQgG/k=
Date: Tue, 4 Mar 2025 17:23:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zxyan Zhu <zxyan20@163.com>
Cc: broonie@kernel.org, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: debugfs: Fix name collision without atomic
 operations
Message-ID: <2025030437-copious-irrigate-1b63@gregkh>
References: <20250304142452.3521828-1-zxyan20@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304142452.3521828-1-zxyan20@163.com>

On Tue, Mar 04, 2025 at 10:24:52PM +0800, Zxyan Zhu wrote:
> The `dummy_index` global variable caused debugfs file name conflicts
> during re-entry, leading to creation failures. Use atomic operations
> to ensure safe and unique debugfs `dummy%d` naming.
> 
> Changes since v1:
> - Replaced atomic_read + atomic_inc with atomic_inc_return.
> - Added atomic_dec in the error path to maintain index consistency.
> - Updated the commit message to clarify the fix.
> 
> Signed-off-by: Zxyan Zhu <zxyan20@163.com>
> ---
>  drivers/base/regmap/regmap-debugfs.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
> index fb84cda92a75..60c8d9a673b8 100644
> --- a/drivers/base/regmap/regmap-debugfs.c
> +++ b/drivers/base/regmap/regmap-debugfs.c
> @@ -20,7 +20,7 @@ struct regmap_debugfs_node {
>  	struct list_head link;
>  };
>  
> -static unsigned int dummy_index;
> +static atomic_t dummy_index = ATOMIC_INIT(0);
>  static struct dentry *regmap_debugfs_root;
>  static LIST_HEAD(regmap_debugfs_early_list);
>  static DEFINE_MUTEX(regmap_debugfs_early_lock);
> @@ -549,6 +549,7 @@ void regmap_debugfs_init(struct regmap *map)
>  	struct regmap_range_node *range_node;
>  	const char *devname = "dummy";
>  	const char *name = map->name;
> +	int index;
>  
>  	/*
>  	 * Userspace can initiate reads from the hardware over debugfs.
> @@ -595,12 +596,13 @@ void regmap_debugfs_init(struct regmap *map)
>  
>  	if (!strcmp(name, "dummy")) {
>  		kfree(map->debugfs_name);
> -		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d",
> -						dummy_index);
> -		if (!map->debugfs_name)
> +		index = atomic_inc_return(&dummy_index);
> +		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d", index);
> +		if (!map->debugfs_name) {
> +			atomic_dec(&dummy_index);
>  			return;
> +		}
>  		name = map->debugfs_name;
> -		dummy_index++;

Shouldn't you just use an idr here if there is a race condition?
There's a lock built into it that should solve all of these issues.

thanks,

greg k-h

