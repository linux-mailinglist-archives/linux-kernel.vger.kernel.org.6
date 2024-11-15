Return-Path: <linux-kernel+bounces-410837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819DC9CE1A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423D9286763
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7882A1D278A;
	Fri, 15 Nov 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCpdrqQW"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93F1D131E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682051; cv=none; b=HHhoqxSfqryZHna/y9J3drD+QX0mmOaVirB8W66LnqwGzNostEKe7CaW3lQ1UxDlgeNMe4umgurPJobuoaSOySAhibTN7o5j7FvSj+VVnt/G9mL6TcfijaL1Mqybc+Du34/TT5oWNaoJIhgN3nCYHXCBlH2BjNP/0gG/CshTykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682051; c=relaxed/simple;
	bh=RVzYRlazkAo7JLebKniY87msHKi2XN8n8ngTFYKi7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHr+fQOfwOm5DKufaqxknVQ3gC73neAe4+eNHeoPXsr3drW3kvFoelUBjMXDExXChgCJ6fiIMVzXulSNc1K9G6ar2rsG2nXjtvTPIf/oMtM4+hTFlqaRRIJTKWV/4eTspmL2gj19i1aa1muy9rN39KMPhEaTr1KGPbPupbPpaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WCpdrqQW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f8095a200eso1489662a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731682049; x=1732286849; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=28sARET1Qvfwc/kfA8YISTif9oxfXiX08KxWO0Zur2Q=;
        b=WCpdrqQWZ23xSIAl+OrslAEHMA+oIILATYlpuVdIZya+cKybxbfzQrmIQ0t/cORiVe
         5WZooVy+5hXfIJZsssuZxIaNiK03wZUesbdNvHTUkDvNi7fpU6EiM7JpVLuQPnJGaIuT
         LHDwLPlMByiq0MkrDBcLxp6t9oIcL94YDmjkRy8IYFgwdYmqVZapFKbtKyj53Wot8xuK
         5bfx6oPYuSz971/hco73BL3hubrLX2mt47Drw0ceMiPBkJwDSIlLUm05y9tmFOstgqX/
         RLe4T6zeO33d/94p2G1hPPqXuYjpjjN/1jOtMLKjI19fCgR/OwIE/k5USi3kjT1ipHCI
         RVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682049; x=1732286849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28sARET1Qvfwc/kfA8YISTif9oxfXiX08KxWO0Zur2Q=;
        b=NxaWT/f5OtBWgRZWVY9CwA/1vpuTr47u6jfX+26JfoNW7qth3njaWx+ZGbR6LqjK9p
         2t/VbezDdmiDYal+Q5Upb40A6HLLvSP4chtiZKzfs/AW257KGgJN8hlyRJ9HCh8G1Mii
         slK8fBHNK/v2FZB6PHP0WV4d8XDKmaQiirr8+SszLs/BTYOoNoO+6QC/wrFzYR+e82Df
         najhYDVXxXDMxyLDRk6W7FjwQ9ZRiN66otNt7Zr7DF2MtSUWT168+8Ew31dfKJjJG3vQ
         +dPohDrId6a1vdaiC7r9nz6xUa/A1kLX0TVHKagbJEp3W2zOHJ1r0R7S/yL7Y9jAVSfp
         LXmw==
X-Forwarded-Encrypted: i=1; AJvYcCVvTko3pmA9cjAzDPN0oESDTMC+YTMxMuRT3GiTnAIqWEDZddQOCDMKjc/Ydjg3qYUvqfscXUW2ENKYPl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlc8KWjw+YUTt+FU/gHLHrzi56E/p8M8vcX5PBkz+qeRnZ9aKS
	jhuDUj/lsWMC3C+LXKoPO75lnQnauG9xBnA9jxgk8xXpeA6u4qt7rqW5wUhsYw==
X-Google-Smtp-Source: AGHT+IGRUIkevz/pH5H9stH+NwULAos/5+zuVi7FkeklDpdipWBtq5/BITL7lD88Phwhg2XyNYyRxQ==
X-Received: by 2002:a17:902:ea04:b0:20a:fd4e:fef6 with SMTP id d9443c01a7336-211c0f1edf4mr113011435ad.8.1731682049251;
        Fri, 15 Nov 2024 06:47:29 -0800 (PST)
Received: from thinkpad ([117.193.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f54a2csm12920475ad.256.2024.11.15.06.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:47:28 -0800 (PST)
Date: Fri, 15 Nov 2024 20:17:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: check bridge->bus in pci_host_common_remove
Message-ID: <20241115144720.ovsyq2ani47norby@thinkpad>
References: <20241028084644.3778081-1-peng.fan@oss.nxp.com>
 <20241115062005.6ifvr6ens2qnrrrf@thinkpad>
 <PAXPR04MB8459D1507CA69498D8C38E0488242@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB8459D1507CA69498D8C38E0488242@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Fri, Nov 15, 2024 at 10:14:10AM +0000, Peng Fan wrote:
> Hi Manivannan,
> 
> > Subject: Re: [PATCH] PCI: check bridge->bus in
> > pci_host_common_remove
> > 
> > On Mon, Oct 28, 2024 at 04:46:43PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > When PCI node was created using an overlay and the overlay is
> > > reverted/destroyed, the "linux,pci-domain" property no longer exists,
> > > so of_get_pci_domain_nr will return failure. Then
> > > of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> > even
> > > if the IDA was allocated in static IDA. So the flow is as below:
> > > A: of_changeset_revert
> > >     pci_host_common_remove
> > >      pci_bus_release_domain_nr
> > >        of_pci_bus_release_domain_nr
> > >          of_get_pci_domain_nr      # fails because overlay is gone
> > >          ida_free(&pci_domain_nr_dynamic_ida)
> > >
> > > With driver calls pci_host_common_remove explicity, the flow
> > becomes:
> > > B pci_host_common_remove
> > >    pci_bus_release_domain_nr
> > >     of_pci_bus_release_domain_nr
> > >      of_get_pci_domain_nr      # succeeds in this order
> > >       ida_free(&pci_domain_nr_static_ida)
> > > A of_changeset_revert
> > >    pci_host_common_remove
> > >
> > > With updated flow, the pci_host_common_remove will be called
> > twice, so
> > > need to check 'bridge->bus' to avoid accessing invalid pointer.
> > >
> > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > I went through the previous discussion [1] and I couldn't see an
> > agreement on the point raised by Bjorn on 'removing the host bridge
> > before the overlay'.
> 
> This patch is an agreement to Bjorn's idea. 
> 
> I have added pci_host_common_remove to remove host bridge
> before removing overlay as I wrote in commit log.
> 
> But of_changeset_revert will still runs into pci_host_
> common_remove to remove the host bridge again. Per
> my view, the design of of_changeset_revert to remove
> the device tree node will trigger device remove, so even
> pci_host_common_remove was explicitly used before
> of_changeset_revert. The following call to of_changeset_revert
> will still call pci_host_common_remove.
> 
> So I did this patch to add a check of 'bus' to avoid remove again.
> 

Ok. I think there was a misunderstanding. Bjorn's example driver,
'i2c-demux-pinctrl' applies the changeset, then adds the i2c adapter for its
own. And in remove(), it does the reverse.

But in your case, the issue is with the host bridge driver that gets probed
because of the changeset. While with 'i2c-demux-pinctrl' driver, it only
applies the changeset. So we cannot compare both drivers. I believe in your
case, 'i2c-demux-pinctrl' becomes 'jailhouse', isn't it?

So in your case, changeset is applied by jailhouse and that causes the
platform device to be created for the host bridge and then the host bridge
driver gets probed. So during destroy(), you call of_changeset_revert() that
removes the platform device and during that process it removes the host bridge
driver. The issue happens because during host bridge remove, it calls
pci_remove_root_bus() and that tries to remove the domain_nr using
pci_bus_release_domain_nr().

But pci_bus_release_domain_nr() uses DT node to check whether to free the
domain_nr from static IDA or dynamic IDA. And because there is no DT node exist
at this time (it was already removed by of_changeset_revert()), it forces
pci_bus_release_domain_nr() to use dynamic IDA even though the IDA was initially
allocated from static IDA.

I think a neat way to solve this issue would be by removing the OF node only
after removing all platform devices/drivers associated with that node. But I
honestly do not know whether that is possible or not. Otherwise, any other
driver that relies on the OF node in its remove() callback, could suffer from
the same issue. And whatever fix we may come up with in PCI core, it will be a
band-aid only.

I'd like to check with Rob first about his opinion.

- Mani

> > 
> > I do think this is a valid point and if you do not think so, please state
> > the reason.
> 
> I agree Bjorn's view, this patch is output of agreement as I write above.
> 
> Thanks,
> Peng.
> 
> > 
> > - Mani
> > 
> > [1]
> > https://lore.kernel.org/lkml/20230913115737.GA426735@bhelgaas/
> > 
> > > ---
> > >
> > > V1:
> > >  Not sure to keep the fixes here. I could drop the Fixes tag if it is
> > > improper.
> > >  This is to revisit the patch [1] which was rejected last year. This
> > > new flow is using the suggest flow following Bjorn's suggestion.
> > >  But of_changeset_revert will still invoke plaform_remove and then
> > > pci_host_common_remove. So worked out this patch together with a
> > patch
> > > to jailhouse driver as below:
> > >  static void destroy_vpci_of_overlay(void)  {
> > > +       struct device_node *vpci_node = NULL;
> > > +
> > >         if (overlay_applied) {
> > > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,6,0)
> > > +               vpci_node = of_find_node_by_path("/pci@0");
> > > +               if (vpci_node) {
> > > +                       struct platform_device *pdev =
> > of_find_device_by_node(vpci_node);
> > > +                       if (!pdev)
> > > +                               printk("Not found device for /pci@0\n");
> > > +                       else {
> > > +                               pci_host_common_remove(pdev);
> > > +                               platform_device_put(pdev);
> > > +                       }
> > > +               }
> > > +               of_node_put(vpci_node); #endif
> > > +
> > >                 of_changeset_revert(&overlay_changeset);
> > >
> > >  [1]
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > lore
> > > .kernel.org%2Flkml%2F20230908224858.GA306960%40bhelgaas%2
> > FT%2F%23md12e
> > >
> > 6097d91a012ede78c997fc5abf460029a569&data=05%7C02%7Cpeng.
> > fan%40nxp.com
> > > %7C025e209cf9264c4240fa08dd053d9211%7C686ea1d3bc2b4c6fa
> > 92cd99c5c301635
> > > %7C0%7C0%7C638672484189046564%7CUnknown%7CTWFpbGZsb
> > 3d8eyJFbXB0eU1hcGki
> > >
> > OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIl
> > dUIjoyfQ
> > > %3D%3D%7C0%7C%7C%7C&sdata=uCo5MO5fEqCjBzwZ8hdnsf3ORh
> > SedhrJWvNOCCMNvG0%
> > > 3D&reserved=0
> > >
> > >  drivers/pci/controller/pci-host-common.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-host-common.c
> > > b/drivers/pci/controller/pci-host-common.c
> > > index cf5f59a745b3..5a9c29fc57cd 100644
> > > --- a/drivers/pci/controller/pci-host-common.c
> > > +++ b/drivers/pci/controller/pci-host-common.c
> > > @@ -86,8 +86,10 @@ void pci_host_common_remove(struct
> > platform_device *pdev)
> > >  	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
> > >
> > >  	pci_lock_rescan_remove();
> > > -	pci_stop_root_bus(bridge->bus);
> > > -	pci_remove_root_bus(bridge->bus);
> > > +	if (bridge->bus) {
> > > +		pci_stop_root_bus(bridge->bus);
> > > +		pci_remove_root_bus(bridge->bus);
> > > +	}
> > >  	pci_unlock_rescan_remove();
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_host_common_remove);
> > > --
> > > 2.37.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

