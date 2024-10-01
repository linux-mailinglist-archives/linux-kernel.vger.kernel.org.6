Return-Path: <linux-kernel+bounces-346662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640F098C75C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9676B1C20A0A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C11CDFD3;
	Tue,  1 Oct 2024 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VYD8EWdD"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ADF1CDA0D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816525; cv=none; b=axMZqYJGFpa+EfQzo1/Y1aTxToGQtALQQuI1FyL0dbuTf/0Ub90SH9NPQxVDKrflGI24gfj+hynrp9h3gnVBsT8s9jFxIFyDn3vziJ94fp/kG6Hpd4L5hkw66L0kk9vs/Xc6OiXFc8SHfQh9dh/kfisSARWJHAhMgMx/s/C5k70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816525; c=relaxed/simple;
	bh=+r0tonjDvNkXNTkvdMW6fNEWRVghanMq70iGa8lR8rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3/RHg53c7AvRgh/HScqlp3h8Y1fNoKCZDkNUiprmSGl0skDyT6Hi5/n81ioyNhi9+5rF9sPRWR+zp+m36v7WgM08BSPYttOCLjrly+PQpuEkw6X5ku1BjYNvCcw1zmo4lKiBz0Fhlpzn+IC+JhHXs9skk/qZ6NHwzlZ16NQXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VYD8EWdD; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a99fd4ea26so518039885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727816522; x=1728421322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWtD++Hnl4oGFYNk31Vwvfy9zu72nUBaUAs7MD+0Pqg=;
        b=VYD8EWdDV/reUlhpfNIHk04cHLRQjrLbO58a3oER3KONXWw3XXjt1A3IGTPa4TAizr
         GQgyVKCSAzsUfuLzHHyq1AuiQyDpC4IkyWmZUh5zEjbuOxna6+BwO5OIp2bqQqAc/2Ga
         LGV2MVZ0zOkWTelJ2o+TedX6PIh44izWYP2mifIQ+xPIREzGuXskwzP9ub8vztoZkgSs
         ynWEOgkMtPtmsXBPS8+UrNi4VcKDNcwbH+1FhIJZ2mhaQ7w6LANdQwXsSBv54L+xgRMu
         4QBWFV2wpJRj1JiVQ6p2kfWZsugWO2uUnibnvgMgTH+4QCi+XOzs0+OggP3nkjaDmwaT
         /cDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816522; x=1728421322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWtD++Hnl4oGFYNk31Vwvfy9zu72nUBaUAs7MD+0Pqg=;
        b=ajdUjS4h1e2/E+tykJvpFWp8ytBfuieo9eXqbHiDotrZ0BWRKEuAMxLvSo21C18chz
         lkSmeI1UUGrmnM1ypKLnVc0fnksTLleGU4lg/FZtfQb0n6bmoxWy7ggheqL20JeYTCJ9
         zXmWN+1tLLsGW1ai2rDVOOmlBgPjUU5cWjBgKnySmID2Gt4wq5n+eM5DEf+Qx/nSWuPT
         NbUyo7EuKRvuga6UFLFEqRzks1rflVobRrlWcI3rkpdzAxAmsO8ItuppcMlU+xqBG3yj
         RJVgEiIVDHSCMvFreHlbFUek8p/0HzVwUR+xLRRvvyS8nrEp62jiPjIP6Ix8YlbG+pce
         9L8w==
X-Forwarded-Encrypted: i=1; AJvYcCWH9AUjJ+YIKrH8AY1ioz4g12r3uc1CbvoeUx1RRE/PHv54u68NOSchaKDFdIv3oexS2sZEpTCkCZH2004=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXor3LCReuVXIL0Uls7dwQVRppvgQ3mkf2PU4e1ZJy5k2kVbSk
	h3iYbJCmMR5u869W12S4JvjazxWciQrKsSzBkVdugtb0gK/9ZchyslBuu0NH58M=
X-Google-Smtp-Source: AGHT+IHULfn5lXM4Kjk4P8yRcei24tL5q2e5nIBdHiXVRWfw/1DTCaErYYyTzss+FTMmxlmSF+uhOg==
X-Received: by 2002:a05:620a:191d:b0:7ac:de4c:f6e6 with SMTP id af79cd13be357-7ae626d9090mr148956185a.33.1727816521943;
        Tue, 01 Oct 2024 14:02:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782c614sm542104985a.76.2024.10.01.14.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:02:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1svk0O-008A4U-Ma;
	Tue, 01 Oct 2024 18:02:00 -0300
Date: Tue, 1 Oct 2024 18:02:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
Message-ID: <20241001210200.GC1369530@ziepe.ca>
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
 <20241001191800.GA1369530@ziepe.ca>
 <0e84f3c0-09d6-4485-ac76-ca296d1ee07e@os.amperecomputing.com>
 <20241001194620.GB1369530@ziepe.ca>
 <e374e8ec-29db-48a2-95d7-6fc9ac6317d9@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e374e8ec-29db-48a2-95d7-6fc9ac6317d9@os.amperecomputing.com>

On Tue, Oct 01, 2024 at 01:47:24PM -0700, Yang Shi wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 1e9952ca989f..de9f14293485 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -235,6 +235,11 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
>         return sid % STRTAB_NUM_L2_STES;
>  }
> 
> +static inline unsigned int arm_smmu_strtab_max_sid(unsigned int sid_bits)
> +{

Can we take the smmu struct here instead of the int?

But yes, this looks OK

Jason

