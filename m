Return-Path: <linux-kernel+bounces-359933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4119992B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD331C221BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFC1D0146;
	Thu, 10 Oct 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH4ye3CD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80251CF7DC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589109; cv=none; b=AH8P4Yd3yM4sD67tX7hftJHL6wUO3R5FYgotu0sM+xx3p5MeS5FgzNHObn9Kx+AgumK3n0+ecNetijwu74jjfmPexCX9+AhocQeMmtB/THjU9Nq5rEwP0EhKtN38oiunbC9kRKYlqyt533f6NX1iRl8j5hcP+G3SDf6Pz3ZxoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589109; c=relaxed/simple;
	bh=fIaFEL2432nob6KEiMmP2odt7ge8i70XjeaZTXAuU0I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ew8od8Lcn3OoZ3uSSOaUcrzSDoC61u7yUjBnqAjCHURk3n2RQio7xvwol1sawL+kS/No+oQcEB45D3fyRmzzBp4iwMPY0IQDmHwva5+2WPuU/8iZqgCu5/eOjsSng16y2PEitmUw89mzFe4/vNJIGIR0KGBraTuKPjmituOAHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH4ye3CD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F03C4CECC;
	Thu, 10 Oct 2024 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728589107;
	bh=fIaFEL2432nob6KEiMmP2odt7ge8i70XjeaZTXAuU0I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uH4ye3CDFTPsPCrl4O32hydS+/adIaz9F1/wxOhQ/dCW3ZSDHfoiR45sBWOehUz20
	 BXTO/COj3dxoqUxNkvN+KDiOhM91VAE0xIRVRGIcDWfRQQ6HYLJHpr1VM86CAvVB5V
	 JEK/QO7iJcYquT4NumU8Hbf1u35EO48qQ6f9JmjI20sXzlWM5oI2DPU9UIsozrx3Ie
	 D6TlKRiHlkYluVc1KsVXk9BNvZFxuUamjy3dGkfQxto+UUAqpCuIfKPaHQVV1+GLlm
	 keDJI85nPt9CAXhjo3vlXfUzTchT+PYBj85JHr+IIG4OQu90bj98r1UYl2LeExivGX
	 /ECPqcwEH9Bsg==
Date: Thu, 10 Oct 2024 12:38:25 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jiqian Chen <Jiqian.Chen@amd.com>
cc: Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
    =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v2] xen: Remove dependency between pciback and privcmd
In-Reply-To: <20241010075848.1002891-1-Jiqian.Chen@amd.com>
Message-ID: <alpine.DEB.2.22.394.2410101237430.471028@ubuntu-linux-20-04-desktop>
References: <20241010075848.1002891-1-Jiqian.Chen@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-35704740-1728589107=:471028"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-35704740-1728589107=:471028
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 10 Oct 2024, Jiqian Chen wrote:
> Commit 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
> adds a weak reverse dependency to the config XEN_PRIVCMD definition, that
> dependency causes xen-privcmd can't be loaded on domU, because
> dependent xen-pciback is always not be loaded successfully on domU.
> 
> To solve above problem, remove that dependency, and do not call
> pcistub_get_gsi_from_sbdf() directly, instead add a hook in
> drivers/xen/apci.c, xen-pciback register the real call function, then in
> privcmd_ioctl_pcidev_get_gsi call that hook.
> 
> Fixes: 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
> v1->v2 changes:
> Added hook xen_acpi_get_gsi_from_sbdf.
> Changed pcistub_get_gsi_from_sbdf to static and pciback register it as the real hook function.
> ---
>  drivers/xen/Kconfig                |  1 -
>  drivers/xen/acpi.c                 | 17 +++++++++++++++++
>  drivers/xen/privcmd.c              |  6 ++----
>  drivers/xen/xen-pciback/pci_stub.c |  4 ++--
>  include/xen/acpi.h                 | 12 ++++--------
>  5 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 72ddee4c1544..f7d6f47971fd 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -261,7 +261,6 @@ config XEN_SCSI_BACKEND
>  config XEN_PRIVCMD
>  	tristate "Xen hypercall passthrough driver"
>  	depends on XEN
> -	imply XEN_PCIDEV_BACKEND
>  	default m
>  	help
>  	  The hypercall passthrough driver allows privileged user programs to
> diff --git a/drivers/xen/acpi.c b/drivers/xen/acpi.c
> index 9e2096524fbc..0bff2f3a87d2 100644
> --- a/drivers/xen/acpi.c
> +++ b/drivers/xen/acpi.c
> @@ -125,3 +125,20 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(xen_acpi_get_gsi_info);
> +
> +get_gsi_from_sbdf_t get_gsi_from_sbdf = NULL;

This can be static


> +void xen_acpi_register_get_gsi_func(get_gsi_from_sbdf_t func)
> +{
> +	get_gsi_from_sbdf = func;
> +}
> +EXPORT_SYMBOL_GPL(xen_acpi_register_get_gsi_func);
> +
> +int xen_acpi_get_gsi_from_sbdf(u32 sbdf)
> +{
> +	if (get_gsi_from_sbdf)
> +		return get_gsi_from_sbdf(sbdf);
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(xen_acpi_get_gsi_from_sbdf);
> \ No newline at end of file
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 3273cb8c2a66..4f75bc876454 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -850,15 +850,13 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
>  static long privcmd_ioctl_pcidev_get_gsi(struct file *file, void __user *udata)
>  {
>  #if defined(CONFIG_XEN_ACPI)
> -	int rc = -EINVAL;
> +	int rc;
>  	struct privcmd_pcidev_get_gsi kdata;
>  
>  	if (copy_from_user(&kdata, udata, sizeof(kdata)))
>  		return -EFAULT;
>  
> -	if (IS_REACHABLE(CONFIG_XEN_PCIDEV_BACKEND))
> -		rc = pcistub_get_gsi_from_sbdf(kdata.sbdf);
> -
> +	rc = xen_acpi_get_gsi_from_sbdf(kdata.sbdf);
>  	if (rc < 0)
>  		return rc;
>  
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index 2f3da5ac62cd..900e6199eec7 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -227,7 +227,7 @@ static struct pci_dev *pcistub_device_get_pci_dev(struct xen_pcibk_device *pdev,
>  }
>  
>  #ifdef CONFIG_XEN_ACPI
> -int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
> +static int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
>  {
>  	struct pcistub_device *psdev;
>  	int domain = (sbdf >> 16) & 0xffff;
> @@ -242,7 +242,6 @@ int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
>  
>  	return psdev->gsi;
>  }
> -EXPORT_SYMBOL_GPL(pcistub_get_gsi_from_sbdf);
>  #endif
>  
>  struct pci_dev *pcistub_get_pci_dev_by_slot(struct xen_pcibk_device *pdev,
> @@ -484,6 +483,7 @@ static int pcistub_init_device(struct pcistub_device *psdev)
>  		if (err)
>  			goto config_release;
>  		psdev->gsi = gsi;
> +		xen_acpi_register_get_gsi_func(pcistub_get_gsi_from_sbdf);
>  	}
>  #endif
>  
> diff --git a/include/xen/acpi.h b/include/xen/acpi.h
> index daa96a22d257..ef4f70e4a557 100644
> --- a/include/xen/acpi.h
> +++ b/include/xen/acpi.h
> @@ -91,13 +91,9 @@ static inline int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  }
>  #endif
>  
> -#ifdef CONFIG_XEN_PCI_STUB
> -int pcistub_get_gsi_from_sbdf(unsigned int sbdf);
> -#else
> -static inline int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
> -{
> -	return -1;
> -}
> -#endif
> +typedef int (*get_gsi_from_sbdf_t)(u32 sbdf);
> +
> +void xen_acpi_register_get_gsi_func(get_gsi_from_sbdf_t func);
> +int xen_acpi_get_gsi_from_sbdf(unsigned int sbdf);
>  
>  #endif	/* _XEN_ACPI_H */
> -- 
> 2.34.1
> 
--8323329-35704740-1728589107=:471028--

