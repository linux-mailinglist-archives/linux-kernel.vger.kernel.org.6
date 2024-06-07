Return-Path: <linux-kernel+bounces-206574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F8900B99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200ADB236D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAA119B3CC;
	Fri,  7 Jun 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wz8OJoi3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFFB4317B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782998; cv=none; b=IuP5RsPFmkl1At/cN2EILRx04qP+807PEScWShNZlsHVORw572zgoHn6jiJQqK3wIP9Lx2mAPMekCVcre/22F2HNS6dArD9daVf2gMU0A9EnGiXgVsXyJxSt0hb6H2E6lmw7JMbLbrOglqhh3ymg8USoTULkCz7gBc6WLjvJ6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782998; c=relaxed/simple;
	bh=de1isALUI6uoVRsEqbYmJH4cywJUZMBwIdGsDgR0zjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeN9bCoTVpP8i6/upJvgAcrLjGUW8S9x5qGozCZzkv0cpT6/+/8TYcds0bgnFqt+pXcq5SB4gYza3Cc2JYkWpw+amAnOZciR60OEmhbDvcyf9lcoR0WrTcHMIhwSDrSUoX+yRJzazVgCfgTjwkwckgCzmjL5Xx1CfQqz2tLlxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wz8OJoi3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717782995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Dq823qS5qbYnbhJH0kaG14MNgIq+VaZmSgwk/Jjr1s=;
	b=Wz8OJoi3HsLRdFumF/2i4qeusGe8ERWnAnZ5H/T6SIUIALfLhCoMJQdUBsJaPA9XPq2uUC
	QZutRHPnylAohD6cGcq2tT2zLIpFKkTZyW65YZhRI4jJFEb1mRk3MCynO1MEbs0E1jbVzu
	5dJHY1cfLfcfOHY1AVNy5YhWQ4NEhWM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Th8csEVLMrGRXb2nHO29aw-1; Fri, 07 Jun 2024 13:56:34 -0400
X-MC-Unique: Th8csEVLMrGRXb2nHO29aw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7951dee4315so184172985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717782994; x=1718387794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Dq823qS5qbYnbhJH0kaG14MNgIq+VaZmSgwk/Jjr1s=;
        b=Oht+CwZmwpCfiv8fNSMlBMLDO5IQlp4+UR0hdbEBVpyA9Hv+pEKnzOTKOY1TV72QUZ
         507xPBBf4a3jZBli+BV1p8f7ipVmSsmE6l9WbMmCu3RCvvigcIQ0yDYK+iz4j7M/gH/g
         n1BK2jdSr1txLYmLDPYD89qlKHCr+WR0jCJWp5SkQQgIc05Ds3ZqqZF8BqO0sQ3EPpjk
         LhwDTpwVXvqaCvrGsnAD9HZc6r7+1dEi0RPVXr+bRDKGKcYPtOh25zruUfRElmpvLQYl
         iQ3KmFsgayxTXia+Zf2iikCYDN1xUbOOOI/hjbUefwkI1XSFVzCR2dr88qNRHm5Vz7hK
         AbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr7ee6iYwfOa2E/pgnJoIS+Zlhz+U5V7uTjbC4kxWRy/oCAMyqow9FGyTlMiLUrH81j1zDDv/vw+IfO2AnbC1SyMCh3JUeHDrxJhR8
X-Gm-Message-State: AOJu0YwH7wl4fhGefj0pWZKWJyqDx0Yxd4tIZUXZdzI5BEAwQQh+/meA
	zKsZkCnWUCLN6ILztVqJd4plObJcgXjpgLRUAJPHFuTOm8SUauNY9sQRxVYOGLNCuovID7nc5bm
	UDDFINJ80u1umGI3BTuDuqjwmnOudpMjgOkOkhac5P1vk6wWWZ6diofRX0n4CjQ==
X-Received: by 2002:a37:e103:0:b0:794:f1f1:804 with SMTP id af79cd13be357-7953c5dc121mr272158185a.52.1717782993946;
        Fri, 07 Jun 2024 10:56:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1jqy09tN4euwVTk1IC+LnZ5WNN+yf+ukRKckgihHaDLqr+dOdWB86hB+p4Vk6oqdI0p2AkQ==
X-Received: by 2002:a37:e103:0:b0:794:f1f1:804 with SMTP id af79cd13be357-7953c5dc121mr272156285a.52.1717782993550;
        Fri, 07 Jun 2024 10:56:33 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795330b1f12sm188416785a.95.2024.06.07.10.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 10:56:32 -0700 (PDT)
Date: Fri, 7 Jun 2024 10:56:31 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Dimitri Sivanich <sivanich@hpe.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	David Wang <00107082@163.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, 
	Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] iommu/amd: Fix panic accessing amd_iommu_enable_faulting
Message-ID: <lsahbfrt26ysjzgg6p6ezcrf525b25d7nnuqxgis5k6g3zsnzt@qsmzecwdjnen>
References: <ZljHE/R4KLzGU6vx@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZljHE/R4KLzGU6vx@hpe.com>

On Thu, May 30, 2024 at 01:36:03PM GMT, Dimitri Sivanich wrote:
> This fixes a bug introduced by commit d74169ceb0d2 ("iommu/vt-d: Allocate
> DMAR fault interrupts locally").  The panic happens when
> amd_iommu_enable_faulting is called from CPUHP_AP_ONLINE_DYN context.
> 
> Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index a18e74878f68..b02b959d12af 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3353,7 +3353,7 @@ int amd_iommu_reenable(int mode)
>  	return 0;
>  }
>  
> -int __init amd_iommu_enable_faulting(unsigned int cpu)
> +int amd_iommu_enable_faulting(unsigned int cpu)
>  {
>  	/* We enable MSI later when PCI is initialized */
>  	return 0;
> -- 
> 2.35.3

Joerg,

Can this get pulled in for the next batch of fixes?

Regards,
Jerry


