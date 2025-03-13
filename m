Return-Path: <linux-kernel+bounces-559838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A465A5FA77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78AB19C1FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9837523A;
	Thu, 13 Mar 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiNMdv87"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD62145A11;
	Thu, 13 Mar 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881182; cv=none; b=B8473S2HENHnV5S+y/CwGulG5NutL/OM9488c7/a0az8aKvsHFpzLKd/Twd/c2WMplZOUWkAvN2PyYJFw5f2OV9Vj0HmLlHq+j8muVTokVAnJhp7/pwStY9Slyw7fkBPcztt2H1NKO5V9XTAIDc7PuIAstvYwOQkDEBw9lz6jbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881182; c=relaxed/simple;
	bh=B+iodccQAAWWFeaau0E85WS8h8bYx85cuP8vx0wMJMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zse6xmCq2HolC082BpI+U7XBqCSk0kD8nb0XLlnHxFu5Su51zVlyQ6AzqeWeYJnOKPij/yhdkByWenmtfgac7AebWdALnq2DMzHJZkiYYSxOHbZDcLlr6ab8bVdHZjXIln+liOfMjZsj+9VWwxIVCIVeT17maJaNAL8SLBREh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiNMdv87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9697AC4CEEB;
	Thu, 13 Mar 2025 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741881182;
	bh=B+iodccQAAWWFeaau0E85WS8h8bYx85cuP8vx0wMJMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WiNMdv87YueAruvkGnE+vHiU2Cax7A7/JPg9r7g9qO3CfD5beA5i830uQg+jPqTnA
	 1hKpjZ4/nyBNfH3XzPeQBF3nPsiQBK36talzarQDaKv6BdHD1Jr8Acb33HQLysx2m2
	 k9mzjLTpskpqopmwnCcCIpf++eD67Lpci2ioyT2IiDwqq1PoXKHXlPCFRiUQG1reXd
	 ZsczD+7XeoYLvd0s9B4XlcJnUN/7S7IiZcdV8LEiHW3sSS/WcudRH27xM5g8qiGmjM
	 aXrZPj24e2OfgVnE/dPpf+WCLC8ywF+vrCgmkauGzJXy4l9ntyUaTWMBYe6pDTXoOz
	 wEA7xYRy3j3Dw==
Date: Thu, 13 Mar 2025 16:52:55 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	Mario.Limonciello@amd.com, Vijendar.Mukunda@amd.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	ssabakar@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Murad Masimov <m.masimov@maxima.ru>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/14] ASoC: amd: acp: Refactor acp machine select
Message-ID: <20250313155255.GA2477963@ax162>
References: <20250310183201.11979-1-venkataprasad.potturu@amd.com>
 <20250310183201.11979-6-venkataprasad.potturu@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310183201.11979-6-venkataprasad.potturu@amd.com>

Hi Venkata,

On Tue, Mar 11, 2025 at 12:01:52AM +0530, Venkata Prasad Potturu wrote:
> Refactor and move acp machine select function from acp platform
> driver to acp pci driver and assign platform specific acpi machines
> to chip->machines.
> 
> Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
...
> diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
> index be1aa405a14a..b7a1b4aa8fef 100644
> --- a/sound/soc/amd/acp/amd.h
> +++ b/sound/soc/amd/acp/amd.h
> @@ -149,6 +149,8 @@ struct acp_chip_info {
>  	struct platform_device *chip_pdev;
>  	struct platform_device *dmic_codec_dev;
>  	struct platform_device *acp_plat_dev;
> +	struct platform_device *mach_dev;
> +	struct snd_soc_acpi_mach *machines;
>  	u32 addr;
>  	unsigned int flag;	/* Distinguish b/w Legacy or Only PDM */
>  	bool is_pdm_dev;	/* flag set to true when ACP PDM controller exists */
> @@ -195,7 +197,6 @@ struct acp_dev_data {
>  	struct list_head stream_list;
>  	spinlock_t acp_lock;
>  
> -	struct snd_soc_acpi_mach *machines;
>  	struct platform_device *mach_dev;
>  
>  	u32 bclk_div;
> @@ -245,13 +246,89 @@ enum acp_config {
>  	ACP_CONFIG_20,
>  };
>  
> +struct snd_soc_acpi_codecs amp_rt1019 = {
> +	.num_codecs = 1,
> +	.codecs = {"10EC1019"}
> +};
> +
> +struct snd_soc_acpi_codecs amp_max = {
> +	.num_codecs = 1,
> +	.codecs = {"MX98360A"}
> +};
> +
> +struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[] = {
> +	{
> +		.id = "10EC5682",
> +		.drv_name = "acp3xalc56821019",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &amp_rt1019,
> +	},
> +	{
> +		.id = "RTL5682",
> +		.drv_name = "acp3xalc5682sm98360",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &amp_max,
> +	},
> +	{
> +		.id = "RTL5682",
> +		.drv_name = "acp3xalc5682s1019",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &amp_rt1019,
> +	},
> +	{
> +		.id = "AMDI1019",
> +		.drv_name = "renoir-acp",
> +	},
> +	{
> +		.id = "ESSX8336",
> +		.drv_name = "acp3x-es83xx",
> +	},
> +	{},
> +};
> +
> +struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_acp_machines[] = {
> +	{
> +		.id = "10508825",
> +		.drv_name = "rmb-nau8825-max",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &amp_max,
> +	},
> +	{
> +		.id = "AMDI0007",
> +		.drv_name = "rembrandt-acp",
> +	},
> +	{
> +		.id = "RTL5682",
> +		.drv_name = "rmb-rt5682s-rt1019",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &amp_rt1019,
> +	},
> +	{},
> +};
> +
> +struct snd_soc_acpi_mach snd_soc_acpi_amd_acp63_acp_machines[] = {
> +	{
> +		.id = "AMDI0052",
> +		.drv_name = "acp63-acp",
> +	},
> +	{},
> +};
> +
> +struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_acp_machines[] = {
> +	{
> +		.id = "AMDI0029",
> +		.drv_name = "acp70-acp",
> +	},
> +	{},
> +};
> +
>  extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
>  extern const struct snd_soc_dai_ops acp_dmic_dai_ops;
>  
>  int acp_platform_register(struct device *dev);
>  int acp_platform_unregister(struct device *dev);
>  
> -int acp_machine_select(struct acp_dev_data *adata);
> +int acp_machine_select(struct acp_chip_info *chip);
>  
>  int acp_init(struct acp_chip_info *chip);
>  int acp_deinit(struct acp_chip_info *chip);
> -- 
> 2.39.2
> 

I have not done a formal bisect but it seems like this hunk introduces
build errors when certain drivers are built into the same image
together, as these structures will be externally visible.

$ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- mrproper allyesconfig vmlinux
x86_64-linux-ld: sound/soc/amd/acp/acp-i2s.o:(.data+0x3e0): multiple definition of `snd_soc_acpi_amd_acp70_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x20): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-i2s.o:(.data+0x580): multiple definition of `snd_soc_acpi_amd_acp63_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x1c0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-i2s.o:(.data+0x720): multiple definition of `snd_soc_acpi_amd_rmb_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x360): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-i2s.o:(.data+0xf00): multiple definition of `amp_max'; sound/soc/amd/acp/acp-platform.o:(.data+0xb40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-i2s.o:(.data+0xf40): multiple definition of `amp_rt1019'; sound/soc/amd/acp/acp-platform.o:(.data+0xb80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-i2s.o:(.data+0xa40): multiple definition of `snd_soc_acpi_amd_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x680): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-i2s.o:(.data+0xf80): multiple definition of `acp70_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xbc0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-i2s.o:(.data+0xfc0): multiple definition of `acp63_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc00): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-i2s.o:(.data+0x1000): multiple definition of `rmb_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-i2s.o:(.data+0x1040): multiple definition of `rn_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pdm.o:(.data+0xa0): multiple definition of `snd_soc_acpi_amd_acp70_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x20): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pdm.o:(.data+0x240): multiple definition of `snd_soc_acpi_amd_acp63_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x1c0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pdm.o:(.data+0x3e0): multiple definition of `snd_soc_acpi_amd_rmb_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x360): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pdm.o:(.data+0xbc0): multiple definition of `amp_max'; sound/soc/amd/acp/acp-platform.o:(.data+0xb40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pdm.o:(.data+0xc00): multiple definition of `amp_rt1019'; sound/soc/amd/acp/acp-platform.o:(.data+0xb80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pdm.o:(.data+0x700): multiple definition of `snd_soc_acpi_amd_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x680): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pdm.o:(.data+0xc40): multiple definition of `acp70_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xbc0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pdm.o:(.data+0xc80): multiple definition of `acp63_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc00): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pdm.o:(.data+0xcc0): multiple definition of `rmb_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pdm.o:(.data+0xd00): multiple definition of `rn_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-legacy-common.o:(.data+0x1a0): multiple definition of `snd_soc_acpi_amd_acp70_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x20): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-legacy-common.o:(.data+0x340): multiple definition of `snd_soc_acpi_amd_acp63_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x1c0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-legacy-common.o:(.data+0x4e0): multiple definition of `snd_soc_acpi_amd_rmb_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x360): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-legacy-common.o:(.data+0xcc0): multiple definition of `amp_max'; sound/soc/amd/acp/acp-platform.o:(.data+0xb40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-legacy-common.o:(.data+0xd00): multiple definition of `amp_rt1019'; sound/soc/amd/acp/acp-platform.o:(.data+0xb80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-legacy-common.o:(.data+0x800): multiple definition of `snd_soc_acpi_amd_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x680): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-legacy-common.o:(.data+0xd40): multiple definition of `acp70_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xbc0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-legacy-common.o:(.data+0xd80): multiple definition of `acp63_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc00): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-legacy-common.o:(.data+0xdc0): multiple definition of `rmb_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-legacy-common.o:(.data+0xe00): multiple definition of `rn_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o:(.data+0xe60): multiple definition of `rn_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o:(.data+0x860): multiple definition of `snd_soc_acpi_amd_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x680): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o:(.data+0xde0): multiple definition of `acp63_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc00): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o:(.data+0x3a0): multiple definition of `snd_soc_acpi_amd_acp63_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x1c0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o:(.data+0xe20): multiple definition of `rmb_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o:(.data+0x540): multiple definition of `snd_soc_acpi_amd_rmb_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x360): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o:(.data+0xda0): multiple definition of `acp70_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xbc0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o:(.data+0x200): multiple definition of `snd_soc_acpi_amd_acp70_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x20): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o:(.data+0xd20): multiple definition of `amp_max'; sound/soc/amd/acp/acp-platform.o:(.data+0xb40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o:(.data+0xd60): multiple definition of `amp_rt1019'; sound/soc/amd/acp/acp-platform.o:(.data+0xb80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-renoir.o:(.data+0x360): multiple definition of `snd_soc_acpi_amd_acp70_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x20): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-renoir.o:(.data+0x500): multiple definition of `snd_soc_acpi_amd_acp63_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x1c0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-renoir.o:(.data+0x6a0): multiple definition of `snd_soc_acpi_amd_rmb_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x360): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-renoir.o:(.data+0xe80): multiple definition of `amp_max'; sound/soc/amd/acp/acp-platform.o:(.data+0xb40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-renoir.o:(.data+0xec0): multiple definition of `amp_rt1019'; sound/soc/amd/acp/acp-platform.o:(.data+0xb80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-renoir.o:(.data+0x9c0): multiple definition of `snd_soc_acpi_amd_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x680): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-renoir.o:(.data+0xf00): multiple definition of `acp70_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xbc0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-renoir.o:(.data+0xf40): multiple definition of `acp63_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc00): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-renoir.o:(.data+0xf80): multiple definition of `rmb_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-renoir.o:(.data+0xfc0): multiple definition of `rn_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-rembrandt.o:(.data+0x4c0): multiple definition of `snd_soc_acpi_amd_acp70_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x20): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-rembrandt.o:(.data+0x660): multiple definition of `snd_soc_acpi_amd_acp63_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x1c0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-rembrandt.o:(.data+0x800): multiple definition of `snd_soc_acpi_amd_rmb_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x360): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-rembrandt.o:(.data+0xfe0): multiple definition of `amp_max'; sound/soc/amd/acp/acp-platform.o:(.data+0xb40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-rembrandt.o:(.data+0x1020): multiple definition of `amp_rt1019'; sound/soc/amd/acp/acp-platform.o:(.data+0xb80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-rembrandt.o:(.data+0xb20): multiple definition of `snd_soc_acpi_amd_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x680): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-rembrandt.o:(.data+0x1060): multiple definition of `acp70_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xbc0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-rembrandt.o:(.data+0x10a0): multiple definition of `acp63_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc00): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-rembrandt.o:(.data+0x10e0): multiple definition of `rmb_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp-rembrandt.o:(.data+0x1120): multiple definition of `rn_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp63.o:(.data+0x4c0): multiple definition of `snd_soc_acpi_amd_acp70_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x20): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp63.o:(.data+0x660): multiple definition of `snd_soc_acpi_amd_acp63_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x1c0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp63.o:(.data+0x800): multiple definition of `snd_soc_acpi_amd_rmb_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x360): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp63.o:(.data+0xfe0): multiple definition of `amp_max'; sound/soc/amd/acp/acp-platform.o:(.data+0xb40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp63.o:(.data+0x1020): multiple definition of `amp_rt1019'; sound/soc/amd/acp/acp-platform.o:(.data+0xb80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp63.o:(.data+0xb20): multiple definition of `snd_soc_acpi_amd_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x680): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp63.o:(.data+0x1060): multiple definition of `acp70_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xbc0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp63.o:(.data+0x10a0): multiple definition of `acp63_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc00): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp63.o:(.data+0x10e0): multiple definition of `rmb_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp63.o:(.data+0x1120): multiple definition of `rn_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp70.o:(.data+0x420): multiple definition of `snd_soc_acpi_amd_acp70_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x20): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp70.o:(.data+0x5c0): multiple definition of `snd_soc_acpi_amd_acp63_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x1c0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp70.o:(.data+0x760): multiple definition of `snd_soc_acpi_amd_rmb_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x360): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp70.o:(.data+0xf40): multiple definition of `amp_max'; sound/soc/amd/acp/acp-platform.o:(.data+0xb40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp70.o:(.data+0xf80): multiple definition of `amp_rt1019'; sound/soc/amd/acp/acp-platform.o:(.data+0xb80): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp70.o:(.data+0xa80): multiple definition of `snd_soc_acpi_amd_acp_machines'; sound/soc/amd/acp/acp-platform.o:(.data+0x680): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp70.o:(.data+0xfc0): multiple definition of `acp70_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xbc0): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp70.o:(.data+0x1000): multiple definition of `acp63_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc00): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp70.o:(.data+0x1040): multiple definition of `rmb_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc40): first defined here
x86_64-linux-ld: sound/soc/amd/acp/acp70.o:(.data+0x1080): multiple definition of `rn_rsrc'; sound/soc/amd/acp/acp-platform.o:(.data+0xc80): first defined here

Cheers,
Nathan

