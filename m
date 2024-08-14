Return-Path: <linux-kernel+bounces-286151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F30D951745
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C5BB21890
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36817143879;
	Wed, 14 Aug 2024 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYDLffLM"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368DE36134
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626138; cv=none; b=ucFyyq3EFoAFFrzVcD3EM77JWlF+L0+9mAnc/HKaH8dlUeeA10ZnBtsv2roLSL/B94NXaFJn0iBu+yaq5R5kka54vfyjD5xbngdScgWSzQNIqQRUFQurO7gpJJlMKKSQSuXWS1x9ErJ4drkXT+cHt9Z9L8E+JEjAoGajgRBN4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626138; c=relaxed/simple;
	bh=dsKV+wqMisbH03QAF7wEuOvOjTFUb6hi739fdjsgYAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbNqRGQDIyiUucYKWqjAydxn1vXlqnrHX5WfRAerKVFdwTFa6GJrSzZwMPaMRyo3kH9OqQp2lEhSRZ6CecIR2my/4DXmGRB1h6oaAzuRXz4wYlPHuvV51/YIals7wbIAeF6QM6Icc2mVvS9u2aDIBZWiJ6ldJSad6i0dT3pHTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYDLffLM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd657c9199so49695ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723626136; x=1724230936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BeIv8tpPW4wd1BzSToPaTcquF6WJ68vuiwIAiNwYEo=;
        b=VYDLffLMA9sk7A8LsdsZhJy8otNt85m6xwDk5hsSmx20GgHEM5Si8AFcc0eGIr9Jm2
         KzZu5TGSLfNZHwUsixKNaq7km9eHkRJtSSYGB7Vzkmxse3PsUsQEaQ0nhv4bHvzpbePS
         04+emd1Ww3IG+K3B5TT6/nFxkjwwfxhaOzbjxZkjrrgIp310WR44z50I16zhUaokGuje
         Uuwf6WrnYssVYCPx2aTtDg5GTlxoA9Yj/EmdaDqlQi9H+W3ycTeaOi8lMeBqzk8+bSmn
         9ZiAVDrI0X1h1appSKeyQFP7Q/x94+dljckIts/nqS20LmqpNsh+5j1Dim61DL4vq8ue
         5rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626136; x=1724230936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BeIv8tpPW4wd1BzSToPaTcquF6WJ68vuiwIAiNwYEo=;
        b=ctW9grt4xvN2QXsK+zbAtPdQzHUX/07naTNGZGQ5YK7/B5iv6RQTh7gpJkewFBwpak
         IQtDkWwqo6E6OIMzMJtzRwujtzPRxAS04j5uEZ9xYyjlCl6WujDU6oC0D9lvFf2A2Zj3
         t2S1SGqBN3Xzfy9qVcRYBJeXas7i+ozgfLej3FSZwFj9okf4gWRMS7xrWKSOmyv37qtL
         ncosfnYapFyufhiiVfhcd49FPY+i0FMnuK5o64DDc5lCAGAfMW9s9h27izknLzuY02ta
         yCiuFtz42AH/LpofLHHjk99SCmJnp5fOJVKIreVN+IzllfVOQ3tShJaQQZdVUHCAENP3
         yqdg==
X-Forwarded-Encrypted: i=1; AJvYcCUlZRFRsgDfc/LslOp4hbUkRoAdl2qYnVSHyRNj4JDY7hGJiA887izrkGPundO1HxwjNXfRa2d1J9DU+AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEq9b24zNnb538ghat6F9TRzOdphGhSKHvk8Q7A3zgr4yJZEz6
	AtQTH7sRyk6yluJs7UQ+w7ldZJEVhyxZli1IS+uzI+rdYBtMve6rjP8ezgBVOQ==
X-Google-Smtp-Source: AGHT+IG7OdlbAYBH+rSxfLKvmXWaZU+mzyHJgiWriDP/OYhsl145DYw3VYr0B7PXkF9ajxWoJVYutw==
X-Received: by 2002:a17:903:2284:b0:1fc:548f:6533 with SMTP id d9443c01a7336-201d8fd876dmr844895ad.3.1723626135784;
        Wed, 14 Aug 2024 02:02:15 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a9373sm25374055ad.144.2024.08.14.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:02:15 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:02:06 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <ZrxyjgNGps1PuIVZ@google.com>
References: <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck>
 <ZrDwolC6oXN44coq@google.com>
 <20240806124943.GF676757@ziepe.ca>
 <ZrJIM8-pS31grIVR@google.com>
 <315e95d4-064d-4322-a9d3-97e96c013b4d@linux.intel.com>
 <ZrTNGepJXbmfuKBK@google.com>
 <20240813175658.GO1985367@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813175658.GO1985367@ziepe.ca>

On Tue, Aug 13, 2024 at 02:56:58PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 08, 2024 at 01:50:17PM +0000, Pranjal Shrivastava wrote:
> > 
> > Kunkun -- Please try this diff and check if it fixes the problem?
> 
> This looks OK to me, you should send it as a proper patch..
> 
> >  	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> > -		report_partial_fault(iopf_param, fault);
> > +		ret = report_partial_fault(iopf_param, fault);
> >  		iopf_put_dev_fault_param(iopf_param);
> >  		/* A request that is not the last does not need to be ack'd */
> > +
> > +		if (ret)
> > +			goto err_bad_iopf;
> >  	}
> 
> rebase it on -rc3 and there will be a return line added here
> too.. Maybe you don't want the goto in that cast

Sure, I'll quickly rebase & send it out as a patch. Please let me know
if should add any tag by you?

> 
> Jason

Thanks,
Pranjal

