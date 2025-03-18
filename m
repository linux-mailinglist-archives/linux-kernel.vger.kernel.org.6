Return-Path: <linux-kernel+bounces-566699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E7EA67B79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8622A3AE65C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9906211497;
	Tue, 18 Mar 2025 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wyst/8eK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABED54758
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320724; cv=none; b=s+4WNyL5d7p0pW1p1JEqb1EVRz9tvlVyEtIkdnHmB+Ecw6D8m8pYr62VOfVBiFLjlZzOQCo3ePOG4GgaKZ4VSG87thWvdbNNVU+imqKAZ76YJe+HgFx9PLwzoP+hMdCLbIkBvoQAKalz4IZ/fsARfKgBMkJFel1+3Y76c8iemNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320724; c=relaxed/simple;
	bh=+1bVEzEad7VOho/IB0KwOIvylNq1MXEC0hJ8cVRnBS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7dJGcGeGf3fRQk0Kokfk1oVydU+5rxuFASgf5ydjqhOaKuuhNWSJCOqWR1ZXDu2BjjBufNBW/Vkq0easqxkQ6qFOGMZmPH5wcZIoAPi6frhG9SE636yXTC/fYz1lfgaKxX252GPYBrgie1d2SDgApZVH8N4Wa5SO3vFAexh/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wyst/8eK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742320717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bxl1Ld3BAp4jOPXx2r3UoMSFMwZHzeN8OlZBrkNTKbo=;
	b=Wyst/8eK/N+roR84AetnKkutaNFTqYgOx7g2iJK1qaxCNWXdrSuoEdQTnFCkHdfbPnmZhx
	JfMEuSGK71clKAHnpcKA/dNMMmHC8T/3chxoS6YTx2uzfHqwYGVnaF0eskntCSAq2n91Se
	o4MEz0VCc2tyQAjzl/SS5Pjt0NDt85Q=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-goR22yq1O0KCPeNgrWA1ww-1; Tue, 18 Mar 2025 13:58:36 -0400
X-MC-Unique: goR22yq1O0KCPeNgrWA1ww-1
X-Mimecast-MFC-AGG-ID: goR22yq1O0KCPeNgrWA1ww_1742320716
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85db97c5c47so52734239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320716; x=1742925516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bxl1Ld3BAp4jOPXx2r3UoMSFMwZHzeN8OlZBrkNTKbo=;
        b=sy40P6Sp6uwRz7J8/Y/p3mMNZvBCfLKS5YxXMmEil2bbGCnrJZHYRlWlZCEPMhE9Wv
         9i7u7wIo4ZIy+Z5hRSaJ8D8G0LzSubwWcrAcqY1tjdsOCeHFXt7I6qz/3tRYMbW5ZrSN
         CvmG5CB+Lkll6rLS9PmxcTxRexS3M6SDRAhr+2rQ7Pih61OL1ZbOScb1Tr9ME8gsNgz/
         V146cjMW900GEsQ+kwaOQULmCNWkDhFkPsqIIVZLxUpJ/yh8Alo89E6Y97stcz+sgBaR
         q/YKFfQLGbVZTVtBMRHCRC7aADOZ/9cyAQPeDp43okWNHusE8VWmR28rKVwJO2X1x33D
         4rig==
X-Forwarded-Encrypted: i=1; AJvYcCWovt9e4F+MfSQNapcjkEsC4XbDq/dlpzR00aoSvc5fRLim0f3R/UUyfML/B9mLhCXlFDUQiT0hJczCG7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJy5XHub2s5lF+rhBFdxscbvLXlBWRVanQbuAlDf0z76gkJquW
	O7/30WN/WY5mmNsEPKuHW8pnC1K5Ss9O3exu5yiIX/JBs+J59rMO/64OtwEPyQ4P+sO/2gIalDW
	SSIBAG5NyNRdOha47ukJ8X1tGfca312HeJo1M6xrmYif3BvAxIATbRQtpBtGnMQ==
X-Gm-Gg: ASbGncslSg9IVXHC/49ohYzFm1MbYG7hbWsY15oWtTF3Tq31rXxQ3tiqlBBp/dBHxOo
	MhMheYmrWGOpfEoLsEYPG2ly+OSTBqa/99UXwltVuZBPqf3OkD/VhvBJYEu+Y2Fjwmag/3RNokY
	R7oKnvJC8RxD09ODLhAmNl7cVMdM0k9U6atYSFCVoCc2Sy7Ps6n4uyl7VTB9TI7ryiQHPqChfrj
	oRnehT1rBlSl2XbhCM7ILA9c1eASQJlUXA4k+eql6T1MMQUJEtAKyFgIH1B8MZQD1sXPnmQUHv6
	9IA6FVfsOOntJIRxnSE=
X-Received: by 2002:a05:6602:620e:b0:855:9e01:9acf with SMTP id ca18e2360f4ac-85dc4820bb0mr535551439f.1.1742320715743;
        Tue, 18 Mar 2025 10:58:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlkkLLnQNtTDFReWf7pCaR7vIy9TXueCWKVkZHXRvNIS2pfiS2nIoGKt6+5q9CMJ94ft2RMA==
X-Received: by 2002:a05:6602:620e:b0:855:9e01:9acf with SMTP id ca18e2360f4ac-85dc4820bb0mr535550839f.1.1742320715386;
        Tue, 18 Mar 2025 10:58:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263816a1fsm2807665173.110.2025.03.18.10.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 10:58:34 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:58:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: jgg@ziepe.ca, kevin.tian@intel.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, yi.l.liu@intel.com, Yunxiang.Li@amd.com,
 pstanner@redhat.com, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] vfio: pci: Advertise INTx only if LINE is connected
Message-ID: <20250318115832.04abbea7.alex.williamson@redhat.com>
In-Reply-To: <174231895238.2295.12586708771396482526.stgit@linux.ibm.com>
References: <174231895238.2295.12586708771396482526.stgit@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 17:29:21 +0000
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> On POWER systems, when the device is behind the io expander,
> not all PCI slots would have the PCI_INTERRUPT_LINE connected.
> The firmware assigns a valid PCI_INTERRUPT_PIN though. In such
> configuration, the irq_info ioctl currently advertizes the
> irq count as 1 as the PCI_INTERRUPT_PIN is valid.
> 
> The patch adds the additional check[1] if the irq is assigned
> for the PIN which is done iff the LINE is connected.
> 
> [1]: https://lore.kernel.org/qemu-devel/20250131150201.048aa3bf.alex.williamson@redhat.com/
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Suggested-By: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 586e49efb81b..4ce70f05b4a8 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -734,6 +734,10 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
>  			return 0;
>  
>  		pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> +#if IS_ENABLED(CONFIG_PPC64)
> +		if (!vdev->pdev->irq)
> +			pin = 0;
> +#endif
>  
>  		return pin ? 1 : 0;
>  	} else if (irq_type == VFIO_PCI_MSI_IRQ_INDEX) {
> 
> 

See:

https://lore.kernel.org/all/20250311230623.1264283-1-alex.williamson@redhat.com/

Do we need to expand that to test !vdev->pdev->irq in
vfio_config_init()?  We don't allow a zero irq to be enabled in
vfio_intx_enable(), so we might as well not report it as supported.  I
don't see why any of this needs to be POWER specific.  Thanks,

Alex


