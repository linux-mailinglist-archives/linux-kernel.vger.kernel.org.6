Return-Path: <linux-kernel+bounces-247622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A17992D216
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1A2B21548
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B5192468;
	Wed, 10 Jul 2024 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kUdBf+WZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9251922FB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616286; cv=none; b=XIcbVVgBIzd1eZ1HcfGKXJdtdDImV3rfTOlzDhsjj+ATI1DlvjBgZGkVZGHL30b1yIoNAqw2gzQ+vPTk2Le1QSZFiaP2JMMqeB6cNmE081V1Wd+sOtQDY9uSEfZyko0l6ND93ONtZEsHv+XrkUsBI2pZOq/kyYs2AewvFqX8K1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616286; c=relaxed/simple;
	bh=/9dbr/ZMzd+2Y1Pu/m88atrinru0VFdTLZbOXOQyKyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOvqvHdkbYRfH8a9TGKWCOt0wfzv7XzGkHbUAO96s92SmITM8yQLwGMG5KPcvVp0vcqGIDa3DDstOiplvZgVbGASjjZjHCupLmpAYKXsmk+UtRQ/4YCQthLjEBEtBSh1ovutVeJoTKEB2kd2DoyqyanEb70RgIRAjaTxUdIUhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kUdBf+WZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91319C32781;
	Wed, 10 Jul 2024 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720616285;
	bh=/9dbr/ZMzd+2Y1Pu/m88atrinru0VFdTLZbOXOQyKyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUdBf+WZ5hksGvGyL609KZ5GLPRoWCJ+S0A1c6xwWf13J+VG6hT2JJLcB2Tc4BfNS
	 LnPHXa5XgH5i6DCSfgzPKVwGiD+wyzK3hZNNMBP5kBq2+l6LdgKUD0aXQNErsXZJ5p
	 iwppN8Yfb/E/NSg84j/0bWzcMpeklJR+ajBpDOYU=
Date: Wed, 10 Jul 2024 14:58:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de, jerinj@marvell.com, schalla@marvell.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Message-ID: <2024071026-squirt-trustful-5845@gregkh>
References: <2024070333-matchless-batch-57ec@gregkh>
 <20240706153009.3775333-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706153009.3775333-1-vattunuru@marvell.com>

On Sat, Jul 06, 2024 at 08:30:09AM -0700, Vamsi Attunuru wrote:
> Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's physical
> function which initializes DPI DMA hardware's global configuration and
> enables hardware mailbox channels between physical function (PF) and
> it's virtual functions (VF). VF device drivers (User space drivers) use
> this hw mailbox to communicate any required device configuration on it's
> respective VF device. Accordingly, this DPI PF driver provisions the
> VF device resources.
> 
> At the hardware level, the DPI physical function (PF) acts as a management
> interface to setup the VF device resources, VF devices are only provisioned
> to handle or control the actual DMA Engine's data transfer capabilities.
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> Reviewed-by: Srujana Challa <schalla@marvell.com>
> ---
> Changes V9 -> V10
> - Added checks to ensure reserved fields are set to 0
> 
> Changes V8 -> V9:
> - Addressed minor comments
> 
> Changes V7 -> V8:
> - Used bit shift operations to access mbox msg fields
> - Removed bitfields in mailbox msg structure
> 
> Changes V6 -> V7:
> - Updated documentation with required references
> - Addressed V6 review comments
> 
> Changes V5 -> V6:
> - Updated documentation
> - Fixed data types in uapi file
> 
> Changes V4 -> V5:
> - Fixed license and data types in uapi file
> 
> Changes V3 -> V4:
> - Moved ioctl definations to .h file
> - Fixed structure alignements which are passed in ioctl
> 
> Changes V2 -> V3:
> - Added ioctl operation to the fops
> - Used managed version of kzalloc & request_irq
> - Addressed miscellaneous comments
> 
> Changes V1 -> V2:
> - Fixed return values and busy-wait loops
> - Merged .h file into .c file
> - Fixed directory structure
> - Removed module params
> - Registered the device as misc device
> 
>  Documentation/misc-devices/index.rst          |   1 +
>  Documentation/misc-devices/mrvl_cn10k_dpi.rst |  52 ++
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |   5 +
>  drivers/misc/Kconfig                          |  14 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/mrvl_cn10k_dpi.c                 | 676 ++++++++++++++++++
>  include/uapi/misc/mrvl_cn10k_dpi.h            |  39 +
>  8 files changed, 789 insertions(+)
> 
> diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
> index 2d0ce9138588..8c5b226d8313 100644
> --- a/Documentation/misc-devices/index.rst
> +++ b/Documentation/misc-devices/index.rst
> @@ -21,6 +21,7 @@ fit into other categories.
>     isl29003
>     lis3lv02d
>     max6875
> +   mrvl_cn10k_dpi
>     oxsemi-tornado
>     pci-endpoint-test
>     spear-pcie-gadget
> diff --git a/Documentation/misc-devices/mrvl_cn10k_dpi.rst b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
> new file mode 100644
> index 000000000000..a75e372723d8
> --- /dev/null
> +++ b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
> @@ -0,0 +1,52 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================================
> +Marvell CN10K DMA packet interface (DPI) driver
> +===============================================
> +
> +Overview
> +========
> +
> +DPI is a DMA packet interface hardware block in Marvell's CN10K silicon.
> +DPI hardware comprises a physical function (PF), its virtual functions,
> +mailbox logic, and a set of DMA engines & DMA command queues.
> +
> +DPI PF function is an administrative function which services the mailbox
> +requests from its VF functions and provisions DMA engine resources to
> +it's VF functions.
> +
> +mrvl_cn10k_dpi.ko misc driver loads on DPI PF device and services the
> +mailbox commands submitted by the VF devices and accordingly initializes
> +the DMA engines and VF device's DMA command queues. Also, driver creates
> +/dev/mrvl-cn10k-dpi node to set DMA engine and PEM (PCIe interface) port
> +attributes like fifo length, molr, mps & mrrs.
> +
> +DPI PF driver is just an administrative driver to setup its VF device's
> +queues and provisions the hardware resources, it cannot initiate any
> +DMA operations. Only VF devices are provisioned with DMA capabilities.
> +
> +Driver location
> +===============
> +
> +drivers/misc/mrvl_cn10k_dpi.c
> +
> +Driver IOCTLs
> +=============
> +
> +:c:macro::`DPI_MPS_MRRS_CFG`
> +ioctl that sets max payload size & max read request size parameters of
> +a pem port to which DMA engines are wired.
> +
> +
> +:c:macro::`DPI_ENGINE_CFG`
> +ioctl that sets DMA engine's fifo sizes & max outstanding load request
> +thresholds.
> +
> +User space code example
> +=======================
> +
> +DPI VF devices are probed and accessed from user space applications using
> +vfio-pci driver. Below is a sample dpi dma application to demonstrate on
> +how applications use mailbox and ioctl services from DPI PF kernel driver.
> +
> +https://github.com/MarvellEmbeddedProcessors/dpi-sample-app
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a141e8e65c5d..def539770439 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -362,6 +362,7 @@ Code  Seq#    Include File                                           Comments
>  0xB6  all    linux/fpga-dfl.h
>  0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
>  0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
> +0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              Marvell CN10K DPI driver
>  0xC0  00-0F  linux/usb/iowarrior.h
>  0xCA  00-0F  uapi/misc/cxl.h
>  0xCA  10-2F  uapi/misc/ocxl.h
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aae88b7a6c32..2c17d651954a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13477,6 +13477,11 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>  F:	drivers/mmc/host/sdhci-xenon*
>  
> +MARVELL OCTEON CN10K DPI DRIVER
> +M:	Vamsi Attunuru <vattunuru@marvell.com>
> +S:	Supported
> +F:	drivers/misc/mrvl_cn10k_dpi.c
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index faf983680040..965641017a62 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -585,6 +585,20 @@ config NSM
>  	  To compile this driver as a module, choose M here.
>  	  The module will be called nsm.
>  
> +config MARVELL_CN10K_DPI
> +	tristate "Octeon CN10K DPI driver"
> +	depends on ARM64 && PCI

Why does ARM64 matter here?  I don't see any dependency required of it.

I just tested this, and it seems to build find for me.  As I had to
manually fix it up to get it to apply to my tree, I'll leave it only
depending on PCI for now, thanks.

greg k-h

