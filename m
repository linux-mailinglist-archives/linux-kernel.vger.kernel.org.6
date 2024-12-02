Return-Path: <linux-kernel+bounces-427139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052629DFD26
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1A9B22494
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2657B1F9EB4;
	Mon,  2 Dec 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZo0VPoz"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F151F8F14
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131752; cv=none; b=L225hqYlHaXkHtc6z4eiFb4COoeboHlE3qdi+qo/YECs01a3I+k4C6qKBTMe4k2PsOLEX0w9tWRHc45Ea1FVdU6mVA+PhbcW3WqELo+cDSUdFbk8fKPNIK+q1SVIukQKVZdCMcvLR96BY6hidhPbegMX92gaC1MoDSfSBnbry2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131752; c=relaxed/simple;
	bh=fC2AEId7tNasHk337cq2lQod3+detAM62YDKRytBbU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuLwNKwJBPafQ6n2QKDDfeESt5SGoOvHl0nZRZ3kAAaoyO/r1LR16cdGUurNGjp73n+d5ClfeTJNT+HCPqUalWoO7ahrryRbH2yfk6pc/hpv64rnMI5RUvxC7zfVUtyQVUKQpi+e1ODg/gWcQABPxCQC3CU8h4kX8VResFk2Cxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZo0VPoz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21577f65bdeso7030275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733131750; x=1733736550; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EGMPvoh3nnYvZxMNds9qARKtX9Uv0fcU6Rjh9g+g7NA=;
        b=yZo0VPozkOZXMBbmK5f2crD4shJ5pzSSNjE/33/CkoXBuhGW29iuDrA7phah2jOE+2
         qxr7mfeXiyjjB0lhnp/FohNETyhtpxeP/YcZxnoQjIkQ3sVUW2v30Jent7/xrT7eXkDQ
         oEpokEODTW3wvUMm7lF7QgVxrM1/cC+kX42v7E92ICfrP/5DYUBjlqQwZL6DU662yBud
         LWD6V/99fG+h6avkZjAG526Jb1ygnZUgsUB2Ht0+SqX+ibWYYCuPif8+l7liucVbfwff
         HbfTghwqDyiQKtPcIGz5M6cowRaPf/yW1UlCRGxNDhqIdUsQWSWQRlgNou4NFXhF+CM7
         2C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131750; x=1733736550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGMPvoh3nnYvZxMNds9qARKtX9Uv0fcU6Rjh9g+g7NA=;
        b=M6o/4eJYuxpKKWmqzT2I/FS3pfcBbwO4QHPdZn3Do5bNQq8iueI2/doFXKkt4Q4LKk
         lTAgkiSbB9U52I+YlxXf5hmCsc0TxCaHMRKP5XPv6homK7AkRki1BfV8KqF/ytZzm7be
         KCnskVYoMQsjvpKZGXx2co3BS6bybBmSizZPPyHCAIlrOZhE4PFoQ0oEACnn9C70fD1P
         41OR0ctZ3RNFbL3lqS9g+Sz6lIP5hal4O6ZZs8jn/oQugONNWsrTyfmdF3s2qUsj9Q/7
         8222zaU8mPpkzGJxd8TCV6tbwPah+TF/aCqKoJUnaQYnIPOqrYCPpLDj9niW511l1mlX
         6UBw==
X-Forwarded-Encrypted: i=1; AJvYcCWe0P9sxL+jNUCBDnkpmTxbWdXEaY972nqUcUqanWhTvjWrD7al0nt3z/ABuKPD9ilGf78aSPVP+bhVOSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+a6a8IqMMsZd4KW2jvhjoP6cBvijHM886c0sdIMQEIV/jDSus
	+HDqBOSz1lnFdJdXAk9OjlvNA7iTvn9joB2y31qb2jL9o+yK08oVh0Vsefea+g==
X-Gm-Gg: ASbGncuWGw0FCeF3U49F/Tdn7anjRfD+S7z2rDNMxOPjiu70GzTriYSADgeBaAl7hIj
	eDN+fvm16RQHwyCiSdIQAtOCYtY8jaM9D6Kuo1nmivrnkrOJvw9muNi060VPVJqYyYE7Sp3rMAO
	erBbBMDHN+N/kHGhwg3CDy9wPvnh+B8OA2Aww9NxRl2QTTF8K/t+AEdlS3NdiQNy/aqdXmwO3ge
	lHopwZ2A61ERNtpLO6R4iyOTVIaANApS/MEGI8+jHWn/dpXQqYdtmvQFr6IUQ==
X-Google-Smtp-Source: AGHT+IGBDoG25e3pEf75i9cCZn/hE8xGiTP5kP5qKiZ7M9GVusUnW+yFGAk3ficksX3QF5GI5UN3Qg==
X-Received: by 2002:a17:902:ec8e:b0:215:6c5f:d142 with SMTP id d9443c01a7336-2156c5fd28bmr100497085ad.20.1733131750007;
        Mon, 02 Dec 2024 01:29:10 -0800 (PST)
Received: from thinkpad ([120.60.140.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c31a0sm72507725ad.249.2024.12.02.01.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:29:09 -0800 (PST)
Date: Mon, 2 Dec 2024 14:59:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: check bridge->bus in pci_host_common_remove
Message-ID: <20241202092902.rp6xb3f64llpabbi@thinkpad>
References: <20241028084644.3778081-1-peng.fan@oss.nxp.com>
 <20241115062005.6ifvr6ens2qnrrrf@thinkpad>
 <PAXPR04MB8459D1507CA69498D8C38E0488242@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241115144720.ovsyq2ani47norby@thinkpad>
 <20241127195650.GA4132105-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127195650.GA4132105-robh@kernel.org>

On Wed, Nov 27, 2024 at 01:56:50PM -0600, Rob Herring wrote:
> On Fri, Nov 15, 2024 at 08:17:20PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 15, 2024 at 10:14:10AM +0000, Peng Fan wrote:
> > > Hi Manivannan,
> > > 
> > > > Subject: Re: [PATCH] PCI: check bridge->bus in
> > > > pci_host_common_remove
> > > > 
> > > > On Mon, Oct 28, 2024 at 04:46:43PM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > When PCI node was created using an overlay and the overlay is
> > > > > reverted/destroyed, the "linux,pci-domain" property no longer exists,
> > > > > so of_get_pci_domain_nr will return failure. Then
> > > > > of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> > > > even
> > > > > if the IDA was allocated in static IDA. So the flow is as below:
> > > > > A: of_changeset_revert
> > > > >     pci_host_common_remove
> > > > >      pci_bus_release_domain_nr
> > > > >        of_pci_bus_release_domain_nr
> > > > >          of_get_pci_domain_nr      # fails because overlay is gone
> > > > >          ida_free(&pci_domain_nr_dynamic_ida)
> > > > >
> > > > > With driver calls pci_host_common_remove explicity, the flow
> > > > becomes:
> > > > > B pci_host_common_remove
> > > > >    pci_bus_release_domain_nr
> > > > >     of_pci_bus_release_domain_nr
> > > > >      of_get_pci_domain_nr      # succeeds in this order
> > > > >       ida_free(&pci_domain_nr_static_ida)
> > > > > A of_changeset_revert
> > > > >    pci_host_common_remove
> > > > >
> > > > > With updated flow, the pci_host_common_remove will be called
> > > > twice, so
> > > > > need to check 'bridge->bus' to avoid accessing invalid pointer.
> > > > >
> > > > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > 
> > > > I went through the previous discussion [1] and I couldn't see an
> > > > agreement on the point raised by Bjorn on 'removing the host bridge
> > > > before the overlay'.
> > > 
> > > This patch is an agreement to Bjorn's idea. 
> > > 
> > > I have added pci_host_common_remove to remove host bridge
> > > before removing overlay as I wrote in commit log.
> > > 
> > > But of_changeset_revert will still runs into pci_host_
> > > common_remove to remove the host bridge again. Per
> > > my view, the design of of_changeset_revert to remove
> > > the device tree node will trigger device remove, so even
> > > pci_host_common_remove was explicitly used before
> > > of_changeset_revert. The following call to of_changeset_revert
> > > will still call pci_host_common_remove.
> > > 
> > > So I did this patch to add a check of 'bus' to avoid remove again.
> > > 
> > 
> > Ok. I think there was a misunderstanding. Bjorn's example driver,
> > 'i2c-demux-pinctrl' applies the changeset, then adds the i2c adapter for its
> > own. And in remove(), it does the reverse.
> > 
> > But in your case, the issue is with the host bridge driver that gets probed
> > because of the changeset. While with 'i2c-demux-pinctrl' driver, it only
> > applies the changeset. So we cannot compare both drivers. I believe in your
> > case, 'i2c-demux-pinctrl' becomes 'jailhouse', isn't it?
> > 
> > So in your case, changeset is applied by jailhouse and that causes the
> > platform device to be created for the host bridge and then the host bridge
> > driver gets probed. So during destroy(), you call of_changeset_revert() that
> > removes the platform device and during that process it removes the host bridge
> > driver. The issue happens because during host bridge remove, it calls
> > pci_remove_root_bus() and that tries to remove the domain_nr using
> > pci_bus_release_domain_nr().
> >
> > But pci_bus_release_domain_nr() uses DT node to check whether to free the
> > domain_nr from static IDA or dynamic IDA. And because there is no DT node exist
> > at this time (it was already removed by of_changeset_revert()), it forces
> > pci_bus_release_domain_nr() to use dynamic IDA even though the IDA was initially
> > allocated from static IDA.
> 
> Putting linux,pci-domain in an overlay is the same problem as aliases in 
> overlays[1]. It's not going to work well.
> 
> IMO, you can have overlays, or you can have static domains. You can't 
> have both.
> 

Okay. 

> > I think a neat way to solve this issue would be by removing the OF node only
> > after removing all platform devices/drivers associated with that node. But I
> > honestly do not know whether that is possible or not. Otherwise, any other
> > driver that relies on the OF node in its remove() callback, could suffer from
> > the same issue. And whatever fix we may come up with in PCI core, it will be a
> > band-aid only.
> > 
> > I'd like to check with Rob first about his opinion.
> 
> If the struct device has an of_node set, there should be a reference 
> count on that node. But I think that only prevents the node from being 
> freed. It does not prevent the overlay from being detached. This is one 
> of many of the issues with overlays Frank painstakingly documented[2].
> 

Ah, I do remember this page as Frank ended up creating it based on my
continuous nudge to add CONFIG_FS interface for applying overlays.

So why are we applying overlays in kernel now?

> Perhaps it is just a matter of iterating thru all the nodes in an 
> overlay, getting their driver/device, and forcing them to unbind. 
> Though that has to be done per bus type.
> 

Sounds like the correct approach.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

