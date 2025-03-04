Return-Path: <linux-kernel+bounces-543233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344FEA4D30A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08927A11E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAA1F4284;
	Tue,  4 Mar 2025 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lCzzth2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3479F5;
	Tue,  4 Mar 2025 05:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066438; cv=none; b=JMyKuH/d5T0LwipmDZ4Z+ocO0vann5uH4F7HrqRSEauaigP220GRInGfyAXqGbonI//Pxn0gj6uSau5Tk6r893mXUjmjU9gQpqq7yLCnbqbc/LKtQtx6K1EYW6zg4wRzTQ1n2RBS0EDtQydhhtNGIlHvFkeOs4lUonEss0JchEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066438; c=relaxed/simple;
	bh=U8ZJKFlPKmCGOrRJxcbg8oU2vYDjOpDoX6L8eKXkbBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p248z3gSH46Od6kGx3VjIs06I5sp35ougtswdr9F/zTQsl4q5Y0Dw3Aqd9hnICz1WJtIpVO9b4YNp30HYM+2wrsotm1jifUD62debedEtZdWnQsyYgV1e7rLphpYrEuBxlcIrfAX3DiJztUMExFoR5gIBw5CrqUt9BpynVAbmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lCzzth2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55480C4CEE5;
	Tue,  4 Mar 2025 05:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741066437;
	bh=U8ZJKFlPKmCGOrRJxcbg8oU2vYDjOpDoX6L8eKXkbBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCzzth2ulUaJHyByN3IlXy01lOytIfbih0MH0PLj8nr9tOEgkGPjkeDTFtMq0MSb+
	 Hzo0ID/ngEUSejKwf87vNiFy7DyQYyIGNXGC+tFB5yrUe5K2rELRQPgo0J1IUM2cKT
	 Z2/EyOFM/FkzFYQWp61nzas/1/KB0IUUcqAXG5Nw=
Date: Tue, 4 Mar 2025 06:33:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: raoxu <raoxu@uniontech.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyuli@uniontech.com,
	zhanjun@uniontech.com
Subject: Re: [PATCH V2] usb: xhci: Add debugfs support for xHCI port bandwidth
Message-ID: <2025030442-deafness-oboe-7319@gregkh>
References: <20250303105635.21290-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303105635.21290-1-raoxu@uniontech.com>

On Mon, Mar 03, 2025 at 06:56:35PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> In many projects, you need to obtain the available bandwidth of the
> xhci roothub port. Refer to xhci rev1_2 and use the TRB_GET_BW
> command to obtain it.
> 
> hardware tested:
> 03:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raven USB 3.1
> (prog-if 30 [XHCI])
> Subsystem: Huawei Technologies Co., Ltd. Raven USB 3.1
> Flags: bus master, fast devsel, latency 0, IRQ 30
> Memory at c0300000 (64-bit, non-prefetchable) [size=1M]
> Capabilities: [48] Vendor Specific Information: Len=08 <?>
> Capabilities: [50] Power Management version 3
> Capabilities: [64] Express Endpoint, MSI 00
> Capabilities: [a0] MSI: Enable- Count=1/8 Maskable- 64bit+
> Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
> Kernel driver in use: xhci_hcd
> 
> test progress:
> 1.cd /sys/kernel/debug/usb/xhci/0000:03:00.3
> cat port_bandwidth
> /sys/kernel/debug/usb/xhci/0000:03:00.3# cat port_bandwidth
> port[1] available bw: 79%.
> port[2] available bw: 79%.
> port[3] available bw: 79%.
> port[4] available bw: 79%.
> port[5] available bw: 90%.
> port[6] available bw: 90%.
> port[7] available bw: 90%.
> port[8] available bw: 90%.
> 2.plug in usb video cammer open it
> cat port_bandwidth
> port[1] available bw: 39%.
> port[2] available bw: 39%.
> port[3] available bw: 39%.
> port[4] available bw: 39%.
> port[5] available bw: 90%.
> port[6] available bw: 90%.
> port[7] available bw: 90%.
> port[8] available bw: 90%.
> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/usb/host/xhci-debugfs.c | 42 +++++++++++++++++++
>  drivers/usb/host/xhci-ring.c    | 14 +++++++
>  drivers/usb/host/xhci.c         | 74 +++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci.h         |  7 ++++
>  4 files changed, 137 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
> index 1f5ef174abea..573b6c25f3af 100644
> --- a/drivers/usb/host/xhci-debugfs.c
> +++ b/drivers/usb/host/xhci-debugfs.c
> @@ -631,6 +631,46 @@ static void xhci_debugfs_create_ports(struct xhci_hcd *xhci,
>  	}
>  }
> 
> +static int xhci_port_bw_show(struct seq_file *s, void *unused)
> +{
> +	struct xhci_hcd		*xhci = (struct xhci_hcd *)s->private;
> +	unsigned int		num_ports;
> +	unsigned int		i;
> +	int			ret;
> +	u8			bw_table[MAX_HC_PORTS] = {0};
> +
> +	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
> +
> +	/* get roothub port bandwidth */
> +	ret = xhci_get_port_bandwidth(xhci, bw_table);
> +	if (ret)
> +		return ret;
> +
> +	/* print all roothub ports available bandwidth */
> +	for (i = 1; i < num_ports+1; i++)
> +		seq_printf(s, "port[%d] available bw: %d%%.\n", i, bw_table[i]);
> +
> +	return ret;
> +}
> +
> +static int bw_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, xhci_port_bw_show, inode->i_private);
> +}
> +
> +static const struct file_operations bw_fops = {
> +	.open			= bw_open,
> +	.read			= seq_read,
> +	.llseek			= seq_lseek,
> +	.release		= single_release,
> +};
> +
> +static void xhci_debugfs_create_bandwidth(struct xhci_hcd *xhci,
> +					struct dentry *parent)
> +{
> +	debugfs_create_file("port_bandwidth", 0644, parent, xhci, &bw_fops);
> +}
> +
>  void xhci_debugfs_init(struct xhci_hcd *xhci)
>  {
>  	struct device		*dev = xhci_to_hcd(xhci)->self.controller;
> @@ -681,6 +721,8 @@ void xhci_debugfs_init(struct xhci_hcd *xhci)
>  	xhci->debugfs_slots = debugfs_create_dir("devices", xhci->debugfs_root);
> 
>  	xhci_debugfs_create_ports(xhci, xhci->debugfs_root);
> +
> +	xhci_debugfs_create_bandwidth(xhci, xhci->debugfs_root);
>  }
> 
>  void xhci_debugfs_exit(struct xhci_hcd *xhci)
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 965bffce301e..af1cd4f8ace9 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1867,6 +1867,8 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
>  	case TRB_NEC_GET_FW:
>  		xhci_handle_cmd_nec_get_fw(xhci, event);
>  		break;
> +	case TRB_GET_BW:
> +		break;
>  	default:
>  		/* Skip over unknown commands on the event ring */
>  		xhci_info(xhci, "INFO unknown command type %d\n", cmd_type);
> @@ -4414,6 +4416,18 @@ int xhci_queue_configure_endpoint(struct xhci_hcd *xhci,
>  			command_must_succeed);
>  }
> 
> +/* Queue a get root hub port bandwidth command TRB */
> +int xhci_queue_get_rh_port_bw(struct xhci_hcd *xhci,
> +		struct xhci_command *cmd, dma_addr_t in_ctx_ptr,
> +		u8 dev_speed, u32 slot_id, bool command_must_succeed)
> +{
> +	return queue_command(xhci, cmd, lower_32_bits(in_ctx_ptr),
> +		upper_32_bits(in_ctx_ptr), 0,
> +		TRB_TYPE(TRB_GET_BW) | DEV_SPEED_FOR_TRB(dev_speed) |
> +		SLOT_ID_FOR_TRB(slot_id),
> +		command_must_succeed);
> +}
> +
>  /* Queue an evaluate context command TRB */
>  int xhci_queue_evaluate_context(struct xhci_hcd *xhci, struct xhci_command *cmd,
>  		dma_addr_t in_ctx_ptr, u32 slot_id, bool command_must_succeed)
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 45653114ccd7..84092fe981e8 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -3088,6 +3088,80 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
>  }
>  EXPORT_SYMBOL_GPL(xhci_reset_bandwidth);
> 
> +/* Get the available bandwidth of the ports under the xhci roothub,
> + * including USB 2.0 port and USB 3.0 port.
> + */
> +int xhci_get_port_bandwidth(struct xhci_hcd *xhci, u8 *bw_table)
> +{
> +	unsigned int		num_ports;
> +	unsigned int		i;
> +	struct xhci_command	*cmd;
> +	dma_addr_t		dma_handle;
> +	void			*dma_buf;
> +	int			ret;
> +	unsigned long		flags;
> +	struct device		*dev  = xhci_to_hcd(xhci)->self.sysdev;
> +
> +	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
> +
> +	cmd = xhci_alloc_command(xhci, true, GFP_KERNEL);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	dma_buf = dma_alloc_coherent(dev, xhci->page_size, &dma_handle,
> +					GFP_KERNEL);
> +	if (!dma_buf) {
> +		xhci_free_command(xhci, cmd);
> +		return -ENOMEM;
> +	}
> +
> +	/* get xhci hub usb3 port bandwidth */
> +	/* refer to xhci rev1_2 protocol 4.6.15*/
> +	spin_unlock_irqrestore(&xhci->lock, flags);
> +	ret = xhci_queue_get_rh_port_bw(xhci, cmd, dma_handle, USB_SPEED_SUPER,
> +					0, false);
> +	if (ret < 0) {
> +		spin_unlock_irqrestore(&xhci->lock, flags);
> +		goto out;
> +	}
> +	xhci_ring_cmd_db(xhci);
> +	spin_unlock_irqrestore(&xhci->lock, flags);
> +
> +	wait_for_completion(cmd->completion);
> +
> +	/* refer to xhci rev1_2 protocol 6.2.6 , byte 0 is reserved */
> +	for (i = 1; i < num_ports+1; i++) {
> +		if (((u8 *)dma_buf)[i])
> +			bw_table[i] = ((u8 *)dma_buf)[i];
> +	}
> +
> +	/* get xhci hub usb2 port bandwidth */
> +	/* refer to xhci rev1_2 protocol 4.6.15*/
> +	spin_unlock_irqrestore(&xhci->lock, flags);
> +	ret = xhci_queue_get_rh_port_bw(xhci, cmd, dma_handle, USB_SPEED_HIGH,
> +					0, false);
> +	if (ret < 0) {
> +		spin_unlock_irqrestore(&xhci->lock, flags);
> +		goto out;
> +	}
> +	xhci_ring_cmd_db(xhci);
> +	spin_unlock_irqrestore(&xhci->lock, flags);
> +
> +	wait_for_completion(cmd->completion);
> +
> +	/* refer to xhci rev1_2 protocol 6.2.6 , byte 0 is reserved */
> +	for (i = 1; i < num_ports+1; i++) {
> +		if (((u8 *)dma_buf)[i])
> +			bw_table[i] = ((u8 *)dma_buf)[i];
> +	}
> +
> +out:
> +	dma_free_coherent(dev, xhci->page_size, dma_buf, dma_handle);
> +	xhci_free_command(xhci, cmd);
> +
> +	return ret;
> +}
> +
>  static void xhci_setup_input_ctx_for_config_ep(struct xhci_hcd *xhci,
>  		struct xhci_container_ctx *in_ctx,
>  		struct xhci_container_ctx *out_ctx,
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 8c164340a2c3..a137097b0404 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -999,6 +999,9 @@ enum xhci_setup_dev {
>  /* bits 16:23 are the virtual function ID */
>  /* bits 24:31 are the slot ID */
> 
> +/* bits 19:16 are the dev speed */
> +#define DEV_SPEED_FOR_TRB(p)    ((p) << 16)
> +
>  /* Stop Endpoint TRB - ep_index to endpoint ID for this TRB */
>  #define SUSPEND_PORT_FOR_TRB(p)		(((p) & 1) << 23)
>  #define TRB_TO_SUSPEND_PORT(p)		(((p) & (1 << 23)) >> 23)
> @@ -1907,6 +1910,10 @@ int xhci_queue_isoc_tx_prepare(struct xhci_hcd *xhci, gfp_t mem_flags,
>  int xhci_queue_configure_endpoint(struct xhci_hcd *xhci,
>  		struct xhci_command *cmd, dma_addr_t in_ctx_ptr, u32 slot_id,
>  		bool command_must_succeed);
> +int xhci_queue_get_rh_port_bw(struct xhci_hcd *xhci,
> +		struct xhci_command *cmd, dma_addr_t in_ctx_ptr,
> +		u8 dev_speed, u32 slot_id, bool command_must_succeed);
> +int xhci_get_port_bandwidth(struct xhci_hcd *xhci, u8 *bw_table);
>  int xhci_queue_evaluate_context(struct xhci_hcd *xhci, struct xhci_command *cmd,
>  		dma_addr_t in_ctx_ptr, u32 slot_id, bool command_must_succeed);
>  int xhci_queue_reset_ep(struct xhci_hcd *xhci, struct xhci_command *cmd,
> --
> 2.43.4
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

