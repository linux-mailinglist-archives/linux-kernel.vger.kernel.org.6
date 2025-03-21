Return-Path: <linux-kernel+bounces-571387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB72A6BC86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42C23B4912
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA9578F29;
	Fri, 21 Mar 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKZT2Tqi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3438FB9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565987; cv=none; b=WI66sRJiOPqagOa4E5660dFNZ9eSuGAthGZNP6ICsoOsNy139s/LvEwVwSVgRpxWxIkn5r4qW5Uni2+83A62EYJIf40hFLDrunf5tJ2HkT46IgPU+5uRS4gW4LmRaTfR1bC+eY8LtqW9AYzRWA+Szkvmv+CTpCF4K3U1lFhxKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565987; c=relaxed/simple;
	bh=pr/QaPmsS1R3c1ZPvXy4FKnBJCT8B5G42KzW+EOLsnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwv56baPOk+Wjot0KfskPizYpGJaZaJxtC1nje3NQxHzpglA3pW0I1vn/8sbVGPbmeX1RB+tTLhd+EP7ymHrWFxNv8iR0xebOoDiuoMaGySai3Crde89WGEuro+8eQGpfj54gOQZNwW1etiEEZK6KW9TYu1UbySFttDSkGO1JSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKZT2Tqi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742565984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtfqZFqF8iFiel/s4I4nuuc5DqZUNdlFQlj2cWV2Ueg=;
	b=SKZT2TqiGog31SHDGSOPh6FoplixFOL/dkNwDdujcHBcGU5FAD6mxcn45cyKrZkzOBuasu
	6j3t4TQIkBG/SH+U/NhJr0mUgMDw5cyVMs+XryHQ0cqjZTJd6RD0PcZeBUxCWBTjMN8jEc
	S3janHRmQwlT1tVcJMytvIPfKOGNgOY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-vvTOdc1kOfG324fSlLgG_Q-1; Fri, 21 Mar 2025 10:06:23 -0400
X-MC-Unique: vvTOdc1kOfG324fSlLgG_Q-1
X-Mimecast-MFC-AGG-ID: vvTOdc1kOfG324fSlLgG_Q_1742565982
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3f6abe5c0cbso352163b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742565982; x=1743170782;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtfqZFqF8iFiel/s4I4nuuc5DqZUNdlFQlj2cWV2Ueg=;
        b=lvTD/JF7UJhh1iqAtvxzfpPGhYtrxnpaZLMiD2chsarwqlYJhBgFUcZUJWCXiCkQuY
         9eWx9pySGWnkKwdd37vxLuqLZ9NHdeJMwXVUVXTX9yXUJTC8IlmOqnUJZK6B1C4lmGUf
         JVJpXyc3GSvPZ4KfRHvEfmh8odoC16wy1PdZ8Qs0S+kfSxQEeDXNfQ+85i6V743oHFmD
         STr1hKiD5FDot5QAH+0cdcyFVEXpfYQsvvJEbXtSlxjCKw705GbksvwCDJ9QqgQNbhcj
         3lUqPadSyUlA+e7BAz2DJ/4hDTeB/CTDqrXwwpgbAL1+wbtPwJjAcreFISpF6y6eGjgT
         0gOw==
X-Forwarded-Encrypted: i=1; AJvYcCV3AE5qBYwQ9XEomGm3N/5rwaEd1o4E4fEErjI7X46Xjnz2TK6ukce6AYUoPJS9pZRlW1dUxPpQlsGagFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtebJxs1UZBS8EHUq75z6dalA7fOq+1jJRy1vB3eEjw79Cn3s8
	jSgH+C1E21qzc4KFU4ICKSBWz4uW/HDPYn7qQMkRaIxWO6g74OAysnk1Zke+7426vKxfTqfzPek
	nKh7IuJF+E8DSdkiai4+iyuofmxVP/rTho+clUotRcJYQDtbT1hA8c1nXklbdOA==
X-Gm-Gg: ASbGnctnBN/SG4gIhM0NKaMIIgq7Nbt+x3295XY98Q1ydiS9cbBUFZHTctUWOqfYc2I
	AIPU/IlRvMfy4RkXj+pZDDVXhr6UUIe3ikz2oVtYVl0BOcXIp7S4Gfm1i5LgLOCpjy2tJwaNXsY
	4J9hujtruUPXEtogM6+WeM2wjqXXTHISjZJP0/wL/DZGC8iMLg1ejv8/rAK2L7DN35wm98BUUBX
	2J+6mM0hCrP2o8rBrU56tnyv8hSc4//SfLDjAcCnloI9R6vtl8mDodbzH1wlSb53b1FZA2nsdvW
	5CZPtngYLtbFf+xJMvI=
X-Received: by 2002:a05:6808:6807:b0:3fe:b5d3:3f23 with SMTP id 5614622812f47-3febf793391mr842057b6e.5.1742565982320;
        Fri, 21 Mar 2025 07:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXrUa2CJtGUuPnUiUVvqG8OIHWW+85+a82cVLjG6j0tZ/F39gii6vY+WagE3AnL6fCZ04BMg==
X-Received: by 2002:a05:6808:6807:b0:3fe:b5d3:3f23 with SMTP id 5614622812f47-3febf793391mr842043b6e.5.1742565981807;
        Fri, 21 Mar 2025 07:06:21 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf7109ddsm335819b6e.26.2025.03.21.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:06:19 -0700 (PDT)
Date: Fri, 21 Mar 2025 08:06:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: jgg@ziepe.ca, kevin.tian@intel.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, yi.l.liu@intel.com, Yunxiang.Li@amd.com,
 pstanner@redhat.com, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] vfio: pci: Advertise INTx only if LINE is connected
Message-ID: <20250321080613.566cb6bd.alex.williamson@redhat.com>
In-Reply-To: <9131d1be-d68e-48d6-afe3-af8949194b21@linux.ibm.com>
References: <174231895238.2295.12586708771396482526.stgit@linux.ibm.com>
	<20250318115832.04abbea7.alex.williamson@redhat.com>
	<9131d1be-d68e-48d6-afe3-af8949194b21@linux.ibm.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 23:24:49 +0530
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> On 3/18/25 11:28 PM, Alex Williamson wrote:
> > On Tue, 18 Mar 2025 17:29:21 +0000
> > Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
> >  
> >> On POWER systems, when the device is behind the io expander,
> >> not all PCI slots would have the PCI_INTERRUPT_LINE connected.
> >> The firmware assigns a valid PCI_INTERRUPT_PIN though. In such
> >> configuration, the irq_info ioctl currently advertizes the
> >> irq count as 1 as the PCI_INTERRUPT_PIN is valid.
> >>
> >> The patch adds the additional check[1] if the irq is assigned
> >> for the PIN which is done iff the LINE is connected.
> >>
> >> [1]: https://lore.kernel.org/qemu-devel/20250131150201.048aa3bf.alex.williamson@redhat.com/
> >>
> >> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> >> Suggested-By: Alex Williamson <alex.williamson@redhat.com>
> >> ---
> >>   drivers/vfio/pci/vfio_pci_core.c |    4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index 586e49efb81b..4ce70f05b4a8 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -734,6 +734,10 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
> >>   			return 0;
> >>   
> >>   		pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> >> +#if IS_ENABLED(CONFIG_PPC64)
> >> +		if (!vdev->pdev->irq)
> >> +			pin = 0;
> >> +#endif
> >>   
> >>   		return pin ? 1 : 0;
> >>   	} else if (irq_type == VFIO_PCI_MSI_IRQ_INDEX) {
> >>
> >>  
> > See:
> >
> > https://lore.kernel.org/all/20250311230623.1264283-1-alex.williamson@redhat.com/
> >
> > Do we need to expand that to test !vdev->pdev->irq in
> > vfio_config_init()?  
> 
> Yes. Looks to be the better option. I did try this and it works.
> 
> 
> I see your patch has already got Reviewed-by. Are you planning
> 
> for v2 Or want me to post a separate patch with this new check?

It seems worth noting this as an additional vector for virtualizing the
PIN register since we'd often expect the PIN is already zero if
pdev->irq is zero.  I posted a patch[1], please review/test.  Thanks,

Alex

[1]https://lore.kernel.org/all/20250320194145.2816379-1-alex.williamson@redhat.com/


