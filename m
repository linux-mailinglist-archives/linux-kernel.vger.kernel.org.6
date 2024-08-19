Return-Path: <linux-kernel+bounces-292684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4AB9572C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05B9B22335
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2342F175D21;
	Mon, 19 Aug 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGGDoGXq"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E213BAC6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091325; cv=none; b=YX/AHlXylkAIrh9c3Z7txKZRXH2e/EsaFJFcLNI2qyFdb8fxWvvqaQzFKc9tAk6D1l1czqEQwkvBLMi4DXksETIqmHREr2j6NbDZyp8CHDBbLxmOhw7H9Apds4fKaUu8GpTc4RNUOi0RRRVRKJ7gcnu4m+EkffQWc83JOGspuZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091325; c=relaxed/simple;
	bh=WlUaJPEO53FA+WTRmjIZn/wxEwMtAVwhilaIZgSekdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6vVmCG6D0ZUn0+/lYP8F0zVhcs9SzL6n6YRfn53qyX1NoE2BK4NgxRKUHZ7VE+FV8FXNOkMXGvbWwTv+7KpzXbeVsAm0rhb4lvA/LlV0L4uPcv2DIIEYN7P05jtcgXnhLADSMN4aY0O/ifcH5ON5X6fzK5oZXI7qwCf29qASw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGGDoGXq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso459709466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724091322; x=1724696122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXJ/JxTQWUx4WEp9jXZ6KZTIfAGcgAjkGtJ6Z4ID9VE=;
        b=JGGDoGXq4XW1kWXnxFcbsIXuevLpDdebPmP4C3zY8fQafe8FCQGl5XuslNkK325g2o
         H98f3sLgk0mUen/5UAmLaHJytWEiT60nHwMO/VJkaGBH09GBDpo9H8h+RVRvfC4wnd3l
         99IpN0cvxLd8R04XJSOMZjajKogHZW6v/Jn7oXNOs0SSTPldcL3qHJE07vA0noGSIZFO
         dicY0cLUWkNhMNgYzoruDo3xyD9OfrE1sxht1cOycnombD2wj5fqQYuCTO2sIgpoPUFk
         5nWQy/t9+9I+5Low3uLo+3J5gEf8sS4bhNo8Xi3eu+DrFJ4xYWGWH/f5V2WnfBT0jWWX
         M+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724091322; x=1724696122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXJ/JxTQWUx4WEp9jXZ6KZTIfAGcgAjkGtJ6Z4ID9VE=;
        b=u39MhWdb5Hmzyh1ausJLkW0AoKt8tBMkAk6OV29HLmu5PW1b/4fehgGos8qhAxdrVT
         JOgN422RZTMOFoal2QFDLOsx3Gy5ZE8hq4nWuvQDDWrXa3PXhRmcHAN9zR/tp3zAMPTe
         1LGpp+mVRZmXDeYGw09oDY7AS8TLSnjxWRLLmnm29w5ke5Gj3f426sVNjP1EOtkTtsUP
         90MvwV4lHfC/iI7TQO4umPLUMIOH68NsD8EXBW8vCKPjDkxsGCcONoNQvGUiTz6ihb5q
         zK9bmo6WcnIg6kRtak0W11M1lQY/UJZBZT1pW/9JSLSihAWuawoHLLybOXE72qhO2tM4
         PnRw==
X-Forwarded-Encrypted: i=1; AJvYcCXFDUVGKrvFtgsSDdHCBz8DWCUWrSisfO1ri5SMOyo8X91aHr4BpTCAPjTBjgr6ujfqq9dKrTsVNXbjHh2IyFDExMZn4ApMpJ1Mtopz
X-Gm-Message-State: AOJu0YxttHPE2eSR8sZk0Zq+5lb9XNjDbYCiyoLEiakfRDRvxPzBaw5/
	r+8r0zpcqSBhT3bGMY1i1V6QhIoLWDyYqt+iu//wa9xqPfGQ3JzL
X-Google-Smtp-Source: AGHT+IFc0po3mo4O9fpfmCnNRPHDYRjKwDTdjNmK8sh/+kEbHxstRUb///5F+1qJ3wH6KwvLikxDvg==
X-Received: by 2002:a17:907:e2df:b0:a7d:a031:7bb2 with SMTP id a640c23a62f3a-a839295605bmr878537566b.40.1724091321672;
        Mon, 19 Aug 2024 11:15:21 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d00f0sm656546266b.87.2024.08.19.11.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 11:15:21 -0700 (PDT)
Message-ID: <e937e26f-038a-6d01-76a9-76c86760ca4a@gmail.com>
Date: Mon, 19 Aug 2024 20:15:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] iommu/amd: Modify set_dte_entry() to use 128-bit cmpxchg
 operation
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
 jgg@nvidia.com, kevin.tian@intel.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
References: <20240819161839.4657-1-suravee.suthikulpanit@amd.com>
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20240819161839.4657-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19. 08. 24 18:18, Suravee Suthikulpanit wrote:
> The current implementation does not follow the 128-bit write
> requirement to update DTE as specified in the AMD I/O Virtualization
> Techonology (IOMMU) Specification.
> 
> In addition, the function is used to program several DTE fields
> (e.g. stage1 table, stage2 table, domain id, and etc.), which is
> difficult to keep track with current implementation.
> 
> Therefore, introduce new a new dte256_t data type and a helper function
> update_dte_256(), which uses two try_cmpxchg128 operations to update
> 256-bit DTE.
> 
> Also, separate logic for setting up the GCR3 Table Root Pointer, GIOV, GV,
> GLX, and GuestPagingMode into another helper function set_dte_gcr3_table().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[...]

> +static void update_dte256(struct amd_iommu *iommu, u16 devid, struct dte256 *new)
> +{
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +	struct dte256 *ptr = (struct dte256 *)&dev_table[devid];
> +	struct dte256 old = {
> +		.qw_lo.data = ptr->qw_lo.data,
> +		.qw_hi.data = ptr->qw_hi.data,
> +	};
> +
> +	/* Update qw_lo */
> +	if (!try_cmpxchg128(&ptr->qw_lo.data, &old.qw_lo.data, new->qw_lo.data))
> +		goto err_out;
> +
> +	/* Update qw_hi */
> +	if (!try_cmpxchg128(&ptr->qw_hi.data, &old.qw_hi.data, new->qw_hi.data)) {
> +		/* Restore qw_lo */
> +		try_cmpxchg128(&ptr->qw_lo.data, &new->qw_lo.data, old.qw_lo.data);

You should use plain cmpxchg128() when the result is unused.

Uros.

