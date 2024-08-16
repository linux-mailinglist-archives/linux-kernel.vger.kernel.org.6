Return-Path: <linux-kernel+bounces-289614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32A4954838
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7001F25860
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F414B1ABEC5;
	Fri, 16 Aug 2024 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbBjmOEz"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868C194AF6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808827; cv=none; b=KFJXwnOhwoUofTB8SiVOcqDRXvVfDVrixxINH7lQklUd/Yc202Am3kZacFtaWVRKvAZiMzMFjfzry5/86iyoBMccczDUmj/3fRCB0ACgZyXsQphL0bVmsdL63ViKrVKMrkYdGDT5VxSUZpYFMcoJsynhQKxm4ECm6G6E/CvXqZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808827; c=relaxed/simple;
	bh=BYNOuo7VdELGAZCeJracaEuuvIf7F0bO1297z3Jgw60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBHuH4mOfRkjyWIWGckoDVVZt0Zb9iqp6EbGkCGqvWkS9g2TEt3KmqyPn2b0j2xF/Jp7C1wsaszLMK5FUjesUXed2Jt3JnVG4A6qYkTWImSFSXxyInYDe9ZwmmOS34x7ORtAxBF3iNnDvUZraoeGC48hX73AZvMkElqBJZo556o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cbBjmOEz; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f1a7faa4d5so23441321fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723808824; x=1724413624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wV3f3tgXbZ6RS8PMVxuGaxCBTXr8Z51l89FQdcyx9OA=;
        b=cbBjmOEzsdagCdA7RgQgdfMCNfGkm1QlompTPTii/5qlUNEQD2VwZtitGDD5ml6UdD
         Dv0wndhGQUZ3IKb7KhsV/5j63j3hq4wdvDVxf/ltBoj0g/uRhTpOwLH3Lza27QvEVnRJ
         Be7dccccavnXAnMw1z0lykWuMsrmWY87Jp3O3wAwUjFoxfsHBHx2t5pZ3o3Sboo6ztDN
         ItOfTlORXy8qZ0LArXlliaNrlHGeZiUFTL5FE1lx0L14VouJW2t6lQCIpBALnAdmnm20
         gyaUYCX7AdUn+ZiblsonXeP/u9l3npO+55Xdhwt7uZUciKgYgDERnbbU5jM97jGZqkej
         0bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723808824; x=1724413624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV3f3tgXbZ6RS8PMVxuGaxCBTXr8Z51l89FQdcyx9OA=;
        b=ZGzc9cmVFZBRrft7oxwQWe+5X52lk2gS6FxnuDclJECJDaJgTYFyrbetqlnaxquAPx
         0aBOJSg7W5DLbcm1rFhBKpDiMn8WZwaVhO4zR+ZbNG2O1smJqEC6iKrUhLYurleliSvM
         r1zKYlpB/OHq5D63kneR+MBQFlAFAa8vLLncPBK2Cq1hipDAt7GEz5kcqO1o1zRLKt1F
         eDekXE01Hl/+p9f7LehtxmUoNph07pwscrpb82aRTQglHBSwhynOIsHCbBsOe3efIkbw
         XICulvntJeJjFcG6kV4QON9rKZEAQNr1sm7gx4cNgqpfCUeXvEjTfmqzzaaKzeZXKym1
         15MA==
X-Forwarded-Encrypted: i=1; AJvYcCWR4A0N1g0/O5so1YNLPjUZakA2wURE2cIEej9cxb+aX+X9pC9xPwiC5nFQUrVpG1IWKHjgXWCcKlknh6KeVae1ft6uQSbq1xLkSMfK
X-Gm-Message-State: AOJu0YxSXWSuoc5xNYEZKiwG7e+CAWSJ+omBIALSBfr4CpFJzIsu7aAP
	lrRrb/HWAqHF43fKfhQykR0MeidcBihMG9QT4Sju2up++4ycr2CKFToXEazn+bc=
X-Google-Smtp-Source: AGHT+IFsJvShCAzHPXv9NfhSPB7MlpUN8gvqY9PXC7ZNR3VQQoCvobHbpuluFO6/2tEVHSxFNSgARA==
X-Received: by 2002:a05:651c:2224:b0:2f1:6cb1:44c0 with SMTP id 38308e7fff4ca-2f3be577d8emr20100601fa.6.1723808823479;
        Fri, 16 Aug 2024 04:47:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aada4sm3446023f8f.94.2024.08.16.04.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:47:02 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:46:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Brian Masney <bmasney@redhat.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Can Guo <quic_cang@quicinc.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: ufshcd-pltfrm: Signedness bug in
 ufshcd_parse_clock_info()
Message-ID: <cd5c2315-1d40-44db-a2d9-c4fd7ab3e7f4@stanley.mountain>
References: <404a4727-89c6-410b-9ece-301fa399d4db@stanley.mountain>
 <b613d16f-1167-456d-a5cd-807db875adb9@acm.org>
 <6beba3f4-dfa1-4871-829c-ed1e44b5bd39@stanley.mountain>
 <20240816063404.GH2331@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816063404.GH2331@thinkpad>

On Fri, Aug 16, 2024 at 12:04:04PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Aug 16, 2024 at 12:35:22AM +0300, Dan Carpenter wrote:
> > On Thu, Aug 15, 2024 at 10:47:30AM -0700, Bart Van Assche wrote:
> > > On 8/15/24 4:24 AM, Dan Carpenter wrote:
> > > > The "sz" variable needs to be a signed type for the error handling to
> > > > work as intended.
> > > 
> > > What error handling are you referring to? I haven't found any code that
> > > assigns a negative value to 'sz' in ufshcd_parse_clock_info(). Did I
> > > perhaps overlook something?
> > > 
> > 
> > Rob's patch in linux-next.
> > 
> 
> It would've been helpful if you added 'next' in the patch subject prefix.
> 

I guess that would helped in this case.  But most of the time when I see this
question it's because there are two different upstream maintainers modifying the
same code...  Anyway, sure, I can change my script to add "next" to the subject
when the FIXES_COMMIT isn't in Linus's tree.

if [ "$FIXES_COMMIT" != "" ] ; then
    if ! git merge-base --is-ancestor $FIXES_COMMIT origin/master ; then
        TREE=" next"
    fi
fi

regards,
dan carpenter


