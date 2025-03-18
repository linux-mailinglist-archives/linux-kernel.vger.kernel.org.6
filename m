Return-Path: <linux-kernel+bounces-565547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BA5A66A62
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743CD17A731
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03861DE3DC;
	Tue, 18 Mar 2025 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSDn/H02"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526D1B85D1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279286; cv=none; b=HyG39SUWtvH8Ro61nsFwClPPeXHsJkidhHVq82iX3JU0hqwl3r0+7R01hoevrwMKw54UeoUm5EZlXyAaYVciSgmJ0Pl29savc9Pam5j/Zpgw+JuebgefYDhKmOy2qhkaGW+tJMnPA+Snd4hjH2AByLGvpcbPaK1bYSWW+VR7yqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279286; c=relaxed/simple;
	bh=BKMVTQqz3RsMwgJiObS9tQZ/rouwlRUpINy4oDngqVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEIYje3Yi07MLbLvbyQ4JXOD2szj7uw2QjU3BcAG7w1z0ZWGyVxJOaojqmQ7TcMJL5K9afYSjIjQVgXWUJlHPy0ZDDjMgJFQrGJlf/RyBZPbkdHrotzQSyrr6ZBNOJZ7YPJcNmnCOLVZAuxqdiXEJHVEb1VUIxfC/Hqm62HZpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nSDn/H02; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22401f4d35aso97561285ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742279283; x=1742884083; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BSXIkkDh3qUjQU6JXyu8jEZBeTmc92jcPbpiryIBFW0=;
        b=nSDn/H02NITiW5l+fuBdoG/uvKANZCal+SirTwmTYjtHkNiuhBi0vQf9BUEwfsTc+P
         Lpt6Qbty3m5Bz+BxNTBOO59WirgLrAvvtKBunJlDszh0RB/YQGEKq5e432dHGdmld+pw
         gLLdcjui1NvfKARuaQGDm5VCI2/RfYVuizEVfmrhgM2v45s6L0IK6DR3Y0nLik3c3oZ0
         kbXso3d6XgXc3gsgKaCyaJNKnuoe/Ian1vfIY0Cy+BSaAul1fR8iJVKVvZ0RCbEimXtg
         esTANh97A+yVY34M8EzkVkE+RBt5rKtmilIjFcM5y2lkERsloJT9om+vgV3O9VUbGPKb
         BPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742279283; x=1742884083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSXIkkDh3qUjQU6JXyu8jEZBeTmc92jcPbpiryIBFW0=;
        b=j03fV9m67WfFHnxp43/VhStCZrRNxY85OcQi/8eiLXELghRbhMsZd5+VQkW/3lKSPB
         nCL90n7dqIFFG1xXJVZGvz4xS8Wtjvw5cGH1BCm2w+eh6CYqOnoPYDr9s7RdUaM0nv6v
         vnqEHazg2wRvVTJL4erF8nXrgOJ+cL9Ohk2vuhcfTYwEmWut813PMOzYSX1Kha15osv6
         Zs+1T2dk5pHeZMY/vsDS9CY+9T9brALWyJGqH0D07S9iiKiBwgKcsfPYNE4t3Fy89STO
         YJ1B3OBknf8HIBBLr3MJCssXKwyx4tbICRM7exnS1UdgU+dx85JZAzaOqVb1Gg5gAVwB
         ZNRA==
X-Forwarded-Encrypted: i=1; AJvYcCXXvE6zJTJna+cWXkEyx12O+cvSsb1G5Ho2kuPb5I7C/VhIIb3PN6oDB3A4zxeIrOBeC2uBAbYQOA7Oc7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMnTpf3oibRccN1M0e6GbMqNuCRIu41i5hp1+2OddOEEHKr50e
	osR0bXxLFPEK4ym3MPlV9pU65tDfqwUDoLpMODTEJEYFu6qHuyyg0CCxcFeTSg==
X-Gm-Gg: ASbGncuimmeZh9vdAhvkbzXc2kxovuVSk3UMkrjKQMmcic92x+LgEAqq72EYoOtJt4r
	DPjm7dq/A4xnVql9W8DFgsq5UWI76BusC2/NclEsEnH3OgrcWK5MJ6FF7DCYdd54jeauBdQ5Nk0
	3W5c7HNq9qJDJIU5mxe7m4iGEn7HmAI0qDqGgumrMWNLCCgwzu2360B6P1KvPf1ffQnutC6iKGQ
	+x9ugqpt1Pd70eCQ86Mh+KI/52rO/86VYY0xirt2pmg3Ll88SIsBnGw52DOz3FFCwlLR7JPU4Gy
	hjV5nAoObFaK1sT56VY5ZnoQbRoQcLdzIk9INJ/wyJT8HWRMcum3CPIT
X-Google-Smtp-Source: AGHT+IE9Ipx8e8hi6l851M8ECjjGxpURnuc//kCtsTCbalD6OxbQYJGW4eIjPuy+9CqCFihdVq7D0A==
X-Received: by 2002:a17:902:ecc7:b0:224:1220:7f40 with SMTP id d9443c01a7336-2262c51bcb7mr23881445ad.3.1742279283447;
        Mon, 17 Mar 2025 23:28:03 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301536326f6sm7277131a91.35.2025.03.17.23.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:28:02 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:57:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bo Sun <Bo.Sun.CN@windriver.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Vidya Sagar <vidyas@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Hao <kexin.hao@windriver.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Forcefully set the PCI_REASSIGN_ALL_BUS flag
 for Marvell CN96XX/CN10XXX boards
Message-ID: <20250318062758.hrquo3xhkt4kgt6g@thinkpad>
References: <20250311135229.3329381-1-Bo.Sun.CN@windriver.com>
 <20250311135229.3329381-2-Bo.Sun.CN@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311135229.3329381-2-Bo.Sun.CN@windriver.com>

On Tue, Mar 11, 2025 at 09:52:28PM +0800, Bo Sun wrote:
> On our Marvell OCTEON CN96XX board, we observed the following panic on
> the latest kernel:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> CPU: 22 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6 #20
> Hardware name: Marvell OcteonTX CN96XX board (DT)
> pc : of_pci_add_properties+0x278/0x4c8
> Call trace:
>  of_pci_add_properties+0x278/0x4c8 (P)
>  of_pci_make_dev_node+0xe0/0x158
>  pci_bus_add_device+0x158/0x228
>  pci_bus_add_devices+0x40/0x98
>  pci_host_probe+0x94/0x118
>  pci_host_common_probe+0x130/0x1b0
>  platform_probe+0x70/0xf0
> 
> The dmesg logs indicated that the PCI bridge was scanning with an invalid bus range:
>  pci-host-generic 878020000000.pci: PCI host bridge to bus 0002:00
>  pci_bus 0002:00: root bus resource [bus 00-ff]
>  pci 0002:00:00.0: scanning [bus f9-f9] behind bridge, pass 0
>  pci 0002:00:01.0: scanning [bus fa-fa] behind bridge, pass 0
>  pci 0002:00:02.0: scanning [bus fb-fb] behind bridge, pass 0
>  pci 0002:00:03.0: scanning [bus fc-fc] behind bridge, pass 0
>  pci 0002:00:04.0: scanning [bus fd-fd] behind bridge, pass 0
>  pci 0002:00:05.0: scanning [bus fe-fe] behind bridge, pass 0
>  pci 0002:00:06.0: scanning [bus ff-ff] behind bridge, pass 0
>  pci 0002:00:07.0: scanning [bus 00-00] behind bridge, pass 0
>  pci 0002:00:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>  pci 0002:00:08.0: scanning [bus 01-01] behind bridge, pass 0
>  pci 0002:00:09.0: scanning [bus 02-02] behind bridge, pass 0
>  pci 0002:00:0a.0: scanning [bus 03-03] behind bridge, pass 0
>  pci 0002:00:0b.0: scanning [bus 04-04] behind bridge, pass 0
>  pci 0002:00:0c.0: scanning [bus 05-05] behind bridge, pass 0
>  pci 0002:00:0d.0: scanning [bus 06-06] behind bridge, pass 0
>  pci 0002:00:0e.0: scanning [bus 07-07] behind bridge, pass 0
>  pci 0002:00:0f.0: scanning [bus 08-08] behind bridge, pass 0
> 
> This regression was introduced by commit 7246a4520b4b ("PCI: Use
> preserve_config in place of pci_flags"). On our board, the 0002:00:07.0
> bridge is misconfigured by the bootloader. Both its secondary and
> subordinate bus numbers are initialized to 0, while its fixed secondary
> bus number is set to 8. However, bus number 8 is also assigned to another
> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was set
> by default when PCI_PROBE_ONLY was not enabled, ensuing that all the
> bus number for these bridges were reassigned, avoiding any conflicts.
> 
> After the change introduced in commit 7246a4520b4b, the bus numbers
> assigned by the bootloader are reused by all other bridges, except
> the misconfigured 0002:00:07.0 bridge. The kernel attempt to reconfigure
> 0002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
> bootloader. However, since a pci_bus has already been allocated for
> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
> 0002:00:07.0. This results in a pci bridge device without a pci_bus
> attached (pdev->subordinate == NULL). Consequently, accessing
> pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
> dereference.
> 
> To summarize, we need to set the PCI_REASSIGN_ALL_BUS flag when
> PCI_PROBE_ONLY is not enabled in order to work around issue like the
> one described above.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
> Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
> ---
> Changes in v2:
>  - Added explicit comment about the quirk, as requested by Mani.
>  - Made commit message more clear, as requested by Bjorn.
> 
>  drivers/pci/quirks.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 82b21e34c545..cec58c7479e1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6181,6 +6181,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
>  
> +/*
> + * Quirk for Marvell CN96XX/CN10XXX boards:
> + *
> + * Adds PCI_REASSIGN_ALL_BUS unless PCI_PROBE_ONLY is set, forcing bus number
> + * reassignment to avoid conflicts caused by bootloader misconfigured PCI bridges.
> + *

Do we really need to care about PCI_PROBE_ONLY in the quirk? Why can't we make
it unconditional?

> + * This resolves a regression introduced by commit 7246a4520b4b ("PCI: Use
> + * preserve_config in place of pci_flags"), which removed this behavior.

I don't think mentioning the commit is really needed here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

