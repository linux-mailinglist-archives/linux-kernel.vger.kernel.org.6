Return-Path: <linux-kernel+bounces-558012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC2EA5E064
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15680189A453
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC8252906;
	Wed, 12 Mar 2025 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMim7oGN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8EA2528F0;
	Wed, 12 Mar 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793559; cv=none; b=d2rD02Gwskz81f/IxFNoQO/Y/Qk+3j4asIsZMKGIbbmLCv68QsgjvnqXHjhuGTMJpagrd23OAcyOSNYErD1x7gIZEXejYNtl0UzBu1uq7W1aqQckVLHzXgcVLHB2y0WCHGYfsJV/HPSGG+2dgsJq2e0Ey+uO9NuC1nj8hWh2jV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793559; c=relaxed/simple;
	bh=DPkHhXdmc1Ex0eIT3pPVrXpW0SQqIV7TulD/jal7s80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sy4rsTa0ZsCjioBw1FbwUPIiqJ0iCXI7vb/beRJbxMToNhpHha87WVhF0LxA78NFT008U+SAZZLwsjTE/IPvik+seku6FJtMhMHXR/CQq9QjD6PoQxJRlsqOpsWF9fF/n1DepBiS+aBKKa5LIiDyHwwQG/kbtPykPNg+VlI2RLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMim7oGN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741793558; x=1773329558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DPkHhXdmc1Ex0eIT3pPVrXpW0SQqIV7TulD/jal7s80=;
  b=RMim7oGNx5DdwauwQoxrPLXM0F+y7UcS2CItk69BdciRWnmLJgSNajit
   zd1KKyCPZuCF1Od/yOHHLouZ2h+1mc217Qrj9AD9thkWXtejsNqbFLvSr
   +qc0ci0r7xm55UycYGInUm6BOGxs3OdxWWzgN2hAcK8BlMTu0HSjtJY4/
   3MRI1PqYtKWvTJL8DGugC0U79eY41/jWrUveP2NIV2wQU0PeS4lk8HqWk
   Ava9dvSsph1V9kELy9hYkxFDAPB1S8WToZCEVwNZxavijcfEsry0fUlCz
   eKFcfm+bFBLKbRJrhsbm4E8pdHVJkmITYlaWeqAx01uB/KPfIwZ6t5vR5
   A==;
X-CSE-ConnectionGUID: mJIrHYWFReOzqvcJgsQz7A==
X-CSE-MsgGUID: +dR2mw1BTqi3dazYZ7hEvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42045977"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42045977"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:32:37 -0700
X-CSE-ConnectionGUID: 5+T74bOBT7WtS6+QGxos0A==
X-CSE-MsgGUID: /ToOYdKaQMW8umNS+QTbGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="157843522"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa001.jf.intel.com with ESMTP; 12 Mar 2025 08:32:35 -0700
Message-ID: <7da4cb5f-dccb-4a98-9518-5659c6c4d985@linux.intel.com>
Date: Wed, 12 Mar 2025 17:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] usb: xhci: Add debugfs support for xHCI port bandwidth
To: raoxu <raoxu@uniontech.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangyuli@uniontech.com, zhanjun@uniontech.com
References: <20250306071015.30366-1-raoxu@uniontech.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250306071015.30366-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6.3.2025 9.10, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> In many projects, you need to obtain the available bandwidth of the
> xhci roothub port. Refer to xhci rev1_2 and use the TRB_GET_BW
> command to obtain it.
> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
> Changelog:
>   *v1->v2: modify the patch subject no code changes.
>    v2->v3: separate files in debugfs for each speed (SS HS FS).
> 	queue one command for each speed not queuing three commands on one file.
> 	print value from context not array on stack.
>    v3->v4: Fix compilation warnings for W=1 build. Delete unused variable
> ---
>   drivers/usb/host/xhci-debugfs.c | 93 +++++++++++++++++++++++++++++++++
>   drivers/usb/host/xhci-mem.c     |  8 +++
>   drivers/usb/host/xhci-ring.c    | 14 +++++
>   drivers/usb/host/xhci.c         | 26 +++++++++
>   drivers/usb/host/xhci.h         |  9 ++++
>   5 files changed, 150 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
> index 1f5ef174abea..5751065d199c 100644
> --- a/drivers/usb/host/xhci-debugfs.c
> +++ b/drivers/usb/host/xhci-debugfs.c
> @@ -631,6 +631,97 @@ static void xhci_debugfs_create_ports(struct xhci_hcd *xhci,
>   	}
>   }
> 
> +static int xhci_port_bw_show(struct xhci_hcd *xhci, u8 dev_speed,
> +				struct seq_file *s)
> +{
> +	unsigned int			num_ports;
> +	unsigned int			i;
> +	int				ret;
> +	struct xhci_container_ctx	*ctx;
> +
> +	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
> +	ctx = xhci->get_bw_command->in_ctx;
> +

xHC might be runtime suspended when this debugfs file is read.
We should make sure xHC is running here by calling pm_runtime_get() or similar,
to make sure command can be processed.


> +	/* get roothub port bandwidth */
> +	ret = xhci_get_port_bandwidth(xhci, dev_speed);
> +	if (ret)
> +		return ret;
> +
> +	/* print all roothub ports available bandwidth */
> +	for (i = 1; i < num_ports+1; i++)
> +		seq_printf(s, "port[%d] available bw: %d%%.\n", i,
> +				ctx->bytes[i]);
> +
> +	return ret;
> +}
> +

...

> @@ -2490,6 +2494,10 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>   	 */
>   	xhci->cmd_ring_reserved_trbs++;
> 
> +	xhci->get_bw_command = xhci_alloc_command_with_ctx(xhci, true, flags);
> +	if (!xhci->get_bw_command)
> +		goto fail;
> +

I think its better to create a new command structure with context for each time
we read port bandwidth instead of allocating one shared.

The port bandwidth won't be read at all in most cases, and sharing has
concurrency issues.

I'd suggest adding support for a new XHCI_CTX_TYPE_PORT_BW context type to
xhci_alloc_container_ctx(), which allocates and maps 256 bytes, 16byte aligned,
like xhci->small_streams_pool dma pool.

Then we could do something like:
(pm_runtime_get and put missing)

+static int xhci_port_bw_show(struct xhci_hcd *xhci, u8 dev_speed,
+                               struct seq_file *s)
+{
+       struct xhci_container_ctx *ctx;
+       unsigned int num_ports;
+       unsigned int i;
+       int ret;
+
+       num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
+
+       ctx = xhci_alloc_container_ctx(xhci, XHCI_CTX_TYPE_PORT_BW, flags);
+       if (!ctx)
+               return -ENOMEM;
+
+       /* get roothub port bandwidth */
+       ret = xhci_get_port_bandwidth(xhci, ctx, dev_speed);
+       if (ret) {
+               xhci_free_container_ctx(xhci, ctx);
+               return ret;
+       }
+
+       /* print all roothub ports available bandwidth */
+       for (i = 1; i < num_ports + 1 && i < ctx->size; i++)
+               seq_printf(s, "port[%d] available bw: %d%%.\n", i,
+                          ctx->bytes[i]);
+
+       xhci_free_container_ctx(xhci, ctx);
+       return ret;
+}

and

+int xhci_get_port_bandwidth(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
+                           u8 dev_speed)
+{
+       struct xhci_command *cmd;
+       unsigned long flags;
+       int ret;
+
+       if (!ctx || ctx->type != XHCI_CTX_TYPE_PORT_BW)
+               return -EINVAL;
+
+       cmd = xhci_alloc_command(xhci, true, GFP_KERNEL);
+       if (!cmd)
+                return -ENOMEM;
+
+       cmd->in_ctx = ctx;
+
+       /* get xhci port bandwidth, refer to xhci rev1_2 protocol 4.6.15 */
+       spin_lock_irqsave(&xhci->lock, flags);
+
+       ret = xhci_queue_get_port_bw(xhci, cmd, ctx->dma, dev_speed, 0);
+       if (ret) {
+               spin_unlock_irqrestore(&xhci->lock, flags);
+               goto err_out;
+       }
+       xhci_ring_cmd_db(xhci);
+       spin_unlock_irqrestore(&xhci->lock, flags);
+
+       wait_for_completion(cmd->completion);
+err_out:
+       kfree(cmd->completion);
+       kfree(cmd);
+
+       return ret;
+}

Thanks
Mathias


