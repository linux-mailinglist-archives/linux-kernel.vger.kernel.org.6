Return-Path: <linux-kernel+bounces-288638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321D2953CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDE91F237BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FB414D702;
	Thu, 15 Aug 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ownhA4S/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9951153837
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757731; cv=none; b=T3yTq7hhxX7OIxoO783qWaOWlq+Odec0k0lFUDK6uSb+HzFuPq37KcWDbjtnh+Miq6XaR0tPxbSXcErJ5xpDT8x6gcRqYC4/+CK7v5Va+BiR7NQt3QhdZ9/9XQi4MFySuunRH4TCcL3hVZ3cl60NgMhNdDNlNQi4F89ZL5bBiSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757731; c=relaxed/simple;
	bh=85Et3LyGgcYCRqsytarYA/vC6hXDLIfHk4wiH/W8rE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktp93kIOXrgiTMGSYuiFgrZcLj6RShyB6G379XWQN4Bfhf1Rftmz53QWtTXKRzFg5bdpmJyuMyPWYynpiIKmv5YRs/hXKCOoMgFavxzqo+xWDUd804OTnJETP2YzliX8gE3CniuSwToKxrYylaKob+Vt9iqqRIQfOyh7Jk+XL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ownhA4S/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efd530a4eso2215268e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723757728; x=1724362528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3qj4pRwTR/N7wlzw62isxsFLKmYb8ZSPKnFcg0zHHk=;
        b=ownhA4S/NM8+1eDFzbY31x4lmZUbDzilWITFviZ445CrT7AfxsLDYDHC4q/V4Cjq9n
         CyKJdvjsRS3qcBWGf0n00/OkYcEO37gEVr04H2n56cXzcUNb2ywZL69pqV51gV4YfvuG
         KQ+hunh/QmEI1o9BVjxEkGuWaLwOLbND5RuwihigHEpp7yBZABCfESzMGDl8ZPXX8RXf
         7/k4Nn4Ik2jsTtTF2eaicrZs26ejlTtCENEIS5l8tP8wIW8xM2aMPbMSbeoJPnbFsM8b
         temWLdbGD30b4iu6V43V409BvnR96EEgFo2ntLwjdPq3/dsUZhWoADE9RODfTX2hdbj1
         nHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723757728; x=1724362528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3qj4pRwTR/N7wlzw62isxsFLKmYb8ZSPKnFcg0zHHk=;
        b=Zl/CAOsFxutR0d8QU4yIcJOUj2a7vnKggkSHN7oGqLXQbw+vuTzrZP5IKh2MlUPUae
         2Gk4aIFiW7XdUc+irYkPq+FSWUX0orA3PeOdrPD+I/UEZzwyuzeFzTZfD7fqCKdPUtbZ
         NbbQDPgrAES2gQdNvUID6LV+l0ab1Ohja+8jKOaEJpfsJvOqYIIEWgsJ7SYn6M+hbPsj
         BbyPvCAbF4dOR9HAKYS5GDDDL6l3kphnmDb18uoDcLhzK6OMs0HQLfG4RyBUTsbriJOY
         2+F8YnABDNb0VO1GAKjXk85iwuJIetPejWM1XjpWZk1r2SxCZ6ADyGx54L6B/S4DdTLL
         b7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUlbQi9f1i0l77+H5zn7bVgb9cti+brb4KaYDgu8+XTEVR1Vy/ueZh+bFpglp0teD1UpiYRjpaX5XdaBTMNZiBJREfoyNE0NaI1lOlj
X-Gm-Message-State: AOJu0YyWu4iiyXXQ3AQe7RkCVEHxyNDezUaEt2dgT44Y2pCFoX9ElxOb
	f+hNz67K7ubM1oov3c0768MMVusAtLR3EoXYm6YSDNU4nJziI40RlseHvl+4gpc=
X-Google-Smtp-Source: AGHT+IFT9W9SFnvKshuI2BWN6mZ3Q4hg5XR9mCXiiuBQfp7/zdYTKLQa4abD4l7S+aPS+vI+TNXIKg==
X-Received: by 2002:a05:6512:3044:b0:52f:154:661b with SMTP id 2adb3069b0e04-5331c695ab8mr525621e87.11.1723757727607;
        Thu, 15 Aug 2024 14:35:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed794635sm4567135e9.42.2024.08.15.14.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:35:27 -0700 (PDT)
Date: Fri, 16 Aug 2024 00:35:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Rob Herring <robh@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Brian Masney <bmasney@redhat.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Can Guo <quic_cang@quicinc.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: ufshcd-pltfrm: Signedness bug in
 ufshcd_parse_clock_info()
Message-ID: <6beba3f4-dfa1-4871-829c-ed1e44b5bd39@stanley.mountain>
References: <404a4727-89c6-410b-9ece-301fa399d4db@stanley.mountain>
 <b613d16f-1167-456d-a5cd-807db875adb9@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b613d16f-1167-456d-a5cd-807db875adb9@acm.org>

On Thu, Aug 15, 2024 at 10:47:30AM -0700, Bart Van Assche wrote:
> On 8/15/24 4:24 AM, Dan Carpenter wrote:
> > The "sz" variable needs to be a signed type for the error handling to
> > work as intended.
> 
> What error handling are you referring to? I haven't found any code that
> assigns a negative value to 'sz' in ufshcd_parse_clock_info(). Did I
> perhaps overlook something?
> 

Rob's patch in linux-next.

-       if (!of_get_property(np, "freq-table-hz", &len)) {
+       sz = of_property_count_u32_elems(np, "freq-table-hz");
+       if (sz <= 0) {
                dev_info(dev, "freq-table-hz property not specified\n");
                goto out;

regards,
dan carpenter


