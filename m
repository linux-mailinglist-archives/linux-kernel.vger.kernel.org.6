Return-Path: <linux-kernel+bounces-171673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C28BE728
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE761F26F06
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93171635B0;
	Tue,  7 May 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SHMpqsfK"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A4161930
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094920; cv=none; b=NabS3TANQbNYR4BozBsHNltYq1lSUpcfDWdLz1hW9nhbuRLp41bn1dtQ00tXlchlD+3xNpko+CjBx127v6I1FV5xU5kf6vntBXoSCD12sUZgdcEuK4nplgYgcWXYVvCqjYNOzinfkGnNIAF/vCaV+jGY1i+7buScAy5I9RkuP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094920; c=relaxed/simple;
	bh=gF84VCMPJTVEggmFhKFaP/dcKdSzxcXmZFhnXWJW44w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYzf45zdc4otoK8LO0DX2ZMNF5oDnIPb8wP2m2A0nY7CCNyq4akO883Z7HNL7mzXmFpb+9NTy8BhZRfnVGBwfc3A0gs6uEB2wRNoJuXnWffaRjmjfOR9Irpx+Pw8BwH4bWcvC5FmFOab+RhsxpRSlQMWLS4CKzWa3rcHqUakh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SHMpqsfK; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f0277767fbso1285060a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715094917; x=1715699717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkqGl/7x0OwO56SYs+uVQbq7OCSGKYp1K0+HP7Qmbg8=;
        b=SHMpqsfKjAssDmFNn7fBLY/b5tsHVfThMIXAINO5mjObi0e9uDGN5yCYCsgkNm9RZM
         BDN7Bu/Mzt4FC1X3jSLjiDHLYMaqh05LD27UWgVBkMeKqwBdK7IqHmrMfUjAOChVb8Tf
         MPxXUU/Q8o1p+gGasv8l+b+uiZtGuLx0NuU4mlTc+FJ+ds7YYdv+M4yTg49rNi+vqZEE
         AoEPMtTw+d3KEuL02XXP8qgw22wcPPyCLn4UhNJxENWRGv3vCvwx8kZUPTsnlFTgWH8+
         Vc2RXptoKLRRyJpyR8iBPt/RlhiiPVFzmZfNaBCgFcbR+UMphGE3SI9TuAuV/UHpPQAW
         UwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094917; x=1715699717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkqGl/7x0OwO56SYs+uVQbq7OCSGKYp1K0+HP7Qmbg8=;
        b=u/YHKI7LesBbsJjvF59eZBRxJoIH1zzLkr7Qfy136AlCByy8D89NUUBkHTIPKbufHJ
         dQX/mKF++56vcpynhbNokBPxw2pO2A9KaR4TSurLhUKkGJ6gd+DgvbJKIce9vx4hKTet
         dyqmpWum32kvxYaiOxOk0vzTTHLgbjzrLE6OA1xnPXugGt+HouHcolFhcrzaoUk8zEjU
         gB6ou2PLkWea6z8H2QLeGV90BHx/U3EqlPzjhYyPcdceLRKwHKKtbdMDTnRpLS70wo7Q
         8JFOE63OtZ+SHpKp/+0B777tQcfk59o/uiJNvR0qlZFUX6VrHjNwoei7gzfdNp7xVLUo
         PCyg==
X-Forwarded-Encrypted: i=1; AJvYcCXVbXxdiGY2LL4yRxVNPkfnGe49DjEpeh88H/SfTr3y52WU91peoT+gj9RxGqir1lbKEfwKCsuJ0a+45WRcM7KAh4eEIepC6fmCqfJj
X-Gm-Message-State: AOJu0YxwjKGaeUTvAdkEgxMPIhd6fwXsdypcDg/pNNDZwCz4cvLWHz4F
	Q8sqztGwufWiyXFjB+Bk3CafCJts2Hcmf2CGsZ0DkNRtAyLZ1ixypqnTgROjP1E=
X-Google-Smtp-Source: AGHT+IGUoxvdjNdzspF19Ce1OuUkdsrFCLLK5IkafH8wCvTsMAF8ekXOGHUiIHhabayOnNY5P/EIZA==
X-Received: by 2002:a05:6870:d205:b0:23f:ba88:d5ac with SMTP id g5-20020a056870d20500b0023fba88d5acmr5660623oac.53.1715094917705;
        Tue, 07 May 2024 08:15:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id pn27-20020a0568704d1b00b002397a883e7csm2552861oab.12.2024.05.07.08.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:15:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4MXE-0083RU-0c;
	Tue, 07 May 2024 12:15:16 -0300
Date: Tue, 7 May 2024 12:15:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 3/6] iommu/riscv: support GSCID
Message-ID: <20240507151516.GK901876@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-4-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507142600.23844-4-zong.li@sifive.com>

On Tue, May 07, 2024 at 10:25:57PM +0800, Zong Li wrote:
> @@ -919,29 +924,43 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
>  	rcu_read_lock();
>  
>  	prev = NULL;
> -	list_for_each_entry_rcu(bond, &domain->bonds, list) {
> -		iommu = dev_to_iommu(bond->dev);
>  
> -		/*
> -		 * IOTLB invalidation request can be safely omitted if already sent
> -		 * to the IOMMU for the same PSCID, and with domain->bonds list
> -		 * arranged based on the device's IOMMU, it's sufficient to check
> -		 * last device the invalidation was sent to.
> -		 */
> -		if (iommu == prev)
> -			continue;
> -
> -		riscv_iommu_cmd_inval_vma(&cmd);
> -		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> -		if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> -			for (iova = start; iova < end; iova += PAGE_SIZE) {
> -				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> +	/*
> +	 * Host domain needs to flush entries in stage-2 for MSI mapping.
> +	 * However, device is bound to s1 domain instead of s2 domain.
> +	 * We need to flush mapping without looping devices of s2 domain
> +	 */
> +	if (domain->gscid) {
> +		riscv_iommu_cmd_inval_gvma(&cmd);
> +		riscv_iommu_cmd_inval_set_gscid(&cmd, domain->gscid);
> +		riscv_iommu_cmd_send(iommu, &cmd, 0);
> +		riscv_iommu_cmd_iofence(&cmd);
> +		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);

Is iommu null here? Where did it come from?

This looks wrong too. The "bonds" list is sort of misnamed, it is
really a list of invalidation instructions. If you need a special
invalidation instruction for this case then you should allocate a
memory and add it to the bond list when the attach is done.

Invalidation should simply iterate over the bond list and do the
instructions it contains, always.

>  static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> -				     struct device *dev, u64 fsc, u64 ta)
> +				     struct device *dev, u64 fsc, u64 ta, u64 iohgatp)

I think you should make a struct to represent the dc entry.

Jason

