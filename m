Return-Path: <linux-kernel+bounces-266962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA4C940A77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFAF2847C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09D1922C0;
	Tue, 30 Jul 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXU0Eo0K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D4190666
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326161; cv=none; b=h4rqq5wLz2dgyWkM1zahxq14PiB/cYKoALp43vbVnYHk6QNM7OMGi3wl9mht4GSwimmxt/Qutx3+J+gkmHefU1VyVnavI4Tzkwrn9sExbzVGIrva6WiBErjJVYLZzFUPxVChmebLSYZUKF2XNmbZwX1Ds/uJhGBXFc6uXnKxfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326161; c=relaxed/simple;
	bh=iVM/lNIx9FLDzrJYFZIa7VB1NWYVO1TqB88lag6oSu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKqEVrOAbawgmGac3MLKPJokrDk+xzfaP/e/CwZ4SardrU6fFRXh8Iaf95x+JgNB6kfkmhLXhWTU3cNEEgYSlqBpTRN8ltGUu6qyYb/69cQiyKa8A45m/pvUGiwTVqeXITrtqPGDCEyHKmYlgE/KhdQZ54uhPiy/D3DU9p8aHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXU0Eo0K; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722326159; x=1753862159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iVM/lNIx9FLDzrJYFZIa7VB1NWYVO1TqB88lag6oSu4=;
  b=DXU0Eo0K0aC5R1PjWolyyafhM/N+v98z6y+9v+OCBWaq9k2AyYKXN1U5
   zzURkXbQIq7q3R9yUSByrpuVKlAtvVJXPxn7m9WO+3Y+s6a8lEziRAYAH
   cKGOMj0h4l5Yp+AsMMRXYLLlHb2SvqFOJel4h/bKTQuxmAeh3kwix42Zn
   JhD+VMoUtbhcNmb7JtjgP8pEFJI7jmfq2DWx1ydU2AYLPAUnQyM+arn7p
   lxPv4r1kr6dqdYVPsar89LyyGvtRwGDI6ffssQ7w9mSOVY1DidC/0GNwb
   dNTvTKiVywaF2BOZxSfBM1bq33JWPk4AaT437KhFA+U95hlrZQ6d65YYg
   g==;
X-CSE-ConnectionGUID: YAYLBVeUSXCpkR2sYaJuFA==
X-CSE-MsgGUID: lDLk35kgTW+oDe4LSqnshA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19967184"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="19967184"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 00:55:59 -0700
X-CSE-ConnectionGUID: Q2E2GV1PT1aKj92KyS1elw==
X-CSE-MsgGUID: 1+APfD/eRfyG89D5H4OylQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="58393322"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.36])
  by fmviesa003.fm.intel.com with ESMTP; 30 Jul 2024 00:55:55 -0700
Date: Tue, 30 Jul 2024 16:11:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	Igor Mammedov <imammedo@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>, linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/6] arm/virt: Wire up GPIO error source for ACPI /
 GHES
Message-ID: <ZqigPgTl7quJ553J@intel.com>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
 <e994c3944d31775d62bbd017dec3adff50ddf269.1722259246.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e994c3944d31775d62bbd017dec3adff50ddf269.1722259246.git.mchehab+huawei@kernel.org>

Hi Mauro,

On Mon, Jul 29, 2024 at 03:21:06PM +0200, Mauro Carvalho Chehab wrote:
> Date: Mon, 29 Jul 2024 15:21:06 +0200
> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Subject: [PATCH v4 2/6] arm/virt: Wire up GPIO error source for ACPI / GHES
> X-Mailer: git-send-email 2.45.2
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Creates a Generic Event Device (GED) as specified at
> ACPI 6.5 specification at 18.3.2.7.2:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> with HID PNP0C33.
> 
> The PNP0C33 device is used to report hardware errors to
> the bios via ACPI APEI Generic Hardware Error Source (GHES).
> 
> It is aligned with Linux Kernel patch:
> https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> 
> [mchehab: use a define for the generic event pin number and do some cleanups]
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 30 ++++++++++++++++++++++++++----
>  hw/arm/virt.c            | 14 ++++++++++++--
>  include/hw/arm/virt.h    |  1 +
>  include/hw/boards.h      |  1 +
>  4 files changed, 40 insertions(+), 6 deletions(-)

[snip]

> +static void virt_set_error(void)
> +{
> +    qemu_set_irq(qdev_get_gpio_in(gpio_error_dev, 0), 1);
> +}
> +

[snip]

> +    mc->generic_error_device_notify = virt_set_error;

[snip]

> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 48ff6d8b93f7..991f99138e57 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -308,6 +308,7 @@ struct MachineClass {
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>      ram_addr_t (*fixup_ram_size)(ram_addr_t size);
>      uint64_t smbios_memory_device_size;
> +    void (*generic_error_device_notify)(void);

The name looks inconsistent with the style of other MachineClass virtual
methods. What about the name like "notify_xxx"? And pls add the comment
about this new method.

BTW, I found this method is called in generic_error_device_notify() of
Patch 6. And the mc->generic_error_device_notify() - as the virtual
metchod of MachineClass looks just to implement a hook, and it doesn't
seem to have anything to do with MachineClass/MachineState, so my
question is why do we need to add this method to MachineClass?

Could we maintain a notifier list in ghes.c and expose an interface
to allow arm code register a notifier? This eliminates the need to add
the ¡°notify¡± method to MachineClass.

Regards,
Zhao


