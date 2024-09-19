Return-Path: <linux-kernel+bounces-333569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54EC97CAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D6A1C22187
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239D19D098;
	Thu, 19 Sep 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leFwDVN+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F71E520
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755422; cv=none; b=ssFhHXyBsD0Jby29xnNwQOGkXW3S6mq4a8DxmJQvkIX9+UdBsY+Skyt5w+2vYQXF/K5kNBeFAWmDsn7W40y1CRsJN88TFr8d8dl5ELaF4I4lFup2u32eSHofm0kgNb0j6MqLMlUrLpKhkx6VZgUCKPI1UwupCHxtkKlCJRtx0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755422; c=relaxed/simple;
	bh=FlNDW5bPW8BWDMVEN7jqfSs7j6g8jfrFGDuO3tlJ0wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSNued4R6FxiyTuGwuaSSX/fUo2TszlNZp6871xrb5gJOWvdhUOrkqCIYlZ51sXSlHFVVddP7rzTIBu5Lidc8TqvSbIZYEmL3Xcnmh8iZDm4zquKnmi1T6SkoEy5Z7PsMkSOd6GHJpzoHG50zyw/EUgqQhZMdfbKJ3oZkekoy+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leFwDVN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D68BC4CEC4;
	Thu, 19 Sep 2024 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726755421;
	bh=FlNDW5bPW8BWDMVEN7jqfSs7j6g8jfrFGDuO3tlJ0wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leFwDVN+4OMZdlwlSETl2m2UU/PWNkHzMhnM2FmP/ysAXV601rdZuZpNd0pp/s+Hk
	 2jOQZw8XwYcHULhIunASNjnbXbYnnSKv6H46YK9Rm++SHtHeyy4sOteR9Upj4G61G5
	 yWfuhK7w1vHfq82YA5NPDjJKBt+oLJdHNhl6xcAfFG1zI5uKxIbzBeI8JT4qjuzaA4
	 MFEmsH96oNPD+JCfS/qaVKSdRpjvtWTu5jOZ9jxtLFcBZBb9WeHacQpgXb+4sVpCEc
	 aOKjyxYwRvrOk0kqIi+qA3W2sd7sqR+GhyGtawF6QN8O6h2FhIzEj296AXXhYpQPaK
	 k/Pg8BWSEICsQ==
Date: Thu, 19 Sep 2024 07:16:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Jan Kiszka <jan.kiszka@seimens.com>
Subject: Re: [PATCH] driver core: fix async device shutdown hang
Message-ID: <20240919141658.GA3737785@thelio-3990X>
References: <20240919043143.1194950-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919043143.1194950-1-stuart.w.hayes@gmail.com>

On Wed, Sep 18, 2024 at 11:31:43PM -0500, Stuart Hayes wrote:
> Modify device_shutdown() so that supplier devices do not wait for
> consumer devices to be shut down first when the devlink is sync state
> only, since the consumer is not dependent on the supplier in this case.
> 
> Without this change, a circular dependency could hang the system.
> 
> Fixes: 8064952c6504 ("driver core: shut down devices asynchronously")
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

All of my virtual testing seems happy with this change.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> The patch this fixes is in driver-core-next and linux-next.
> 
> Please let me know if this needs to be a V2 or if it needs anything
> else... it is the identical patch I sent in yesterday, except I added
> a "Fixes:" tag and the comments.  Thank you for the help!
> 
>  drivers/base/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b69b82da8837..76513e360496 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4898,8 +4898,16 @@ void device_shutdown(void)
>  
>  		idx = device_links_read_lock();
>  		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> -				device_links_read_lock_held())
> +				device_links_read_lock_held()) {
> +			/*
> +			 * sync_state_only suppliers don't need to wait,
> +			 * aren't reordered on devices_kset, so making them
> +			 * wait could result in a hang
> +			 */
> +			if (device_link_flag_is_sync_state_only(link->flags))
> +				continue;
>  			link->supplier->p->shutdown_after = cookie;
> +		}
>  		device_links_read_unlock(idx);
>  		put_device(dev);
>  
> -- 
> 2.39.3
> 

