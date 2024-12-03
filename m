Return-Path: <linux-kernel+bounces-429384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7B9E1D81
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CD65B3C044
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D983A1E47D2;
	Tue,  3 Dec 2024 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hquOb6qb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4F1E47B2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226710; cv=none; b=VxY0arVi9sf9x1973E1/7FqZHzgzkWb0KmEivtb+o+tU6EVJXqrwWB6qPHBZ7V3tNUZ3lIFlHoKvX5daUCCHn1TUQKnxABzrZR0f1SVkTMT7NTrH8rcYPgO0/zOqqEagj22p4L8QXgkt4sVqypEFbfYrFKcfoU7SpT+YX/N0k08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226710; c=relaxed/simple;
	bh=Emi1Zdseta3G8eTSV/lj1m+eVEQNDjemqiTS+vscWt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7zM2LzD+M8VnFCHYZjKtGqsjLL5cRouAkoW96/DYdmqU/mSZT6A24yCf0mMeEcVDYMtx+PVFSpD1Hg7X5+4bAhu2uhVF+IPvYOkCMjIviO9uarU+s1NR1cENdjXxuA+xMh9cejaKLPr0SKjvEB3zwnsq3BqClfig7Sc0bD/Vr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hquOb6qb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733226707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQkSGIxzX3VxvHwHfMs8XnHAuI+Nji2BKn26CghMNBo=;
	b=hquOb6qbTk9bnVN8GZJElD8zH4S7V2BzqU8bZR5MvU3/RD1InFco/0N65d47MAWcXjHccR
	pt4cl903vgoerKibrFoJu5s1h8/7MM7fNVeKCFExFR0Dai3+KZcgMDXL9AyNg9SU1K30/+
	hHiTksKA4Fe1du2RJZTBdjqwgOpND0k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-GkZ6ZnHIN2Cc0A8jZKRnbA-1; Tue, 03 Dec 2024 06:51:46 -0500
X-MC-Unique: GkZ6ZnHIN2Cc0A8jZKRnbA-1
X-Mimecast-MFC-AGG-ID: GkZ6ZnHIN2Cc0A8jZKRnbA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385df115288so1875132f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226705; x=1733831505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQkSGIxzX3VxvHwHfMs8XnHAuI+Nji2BKn26CghMNBo=;
        b=QIhSw4n+g//u5pLRv73nOwSY1SuePRMvDwg/qwS9h8WdLLRDNi5rCAi9xClM8YPKGX
         jHVu3Db073WHm0creW7eChiLlJlInNWWpqLoSKYWdjoWtlAtmhXXOvISROPzWyc7OzDs
         igBcsKVJdWWGMVFGEuMJy5cHbP9WtpwuX+LKajps11jAPPJvKnCZSm3dnLLj71/wXhtC
         f12SSYYasRyFu4DPwEtYbBUqI0xmSVLV5eNAsUcLG+Epj6Z9jxc5sXXXow6RD9sKXBoV
         9g62/o3hz5qCmkXrBi4GzU+8n2ksixvgW0ExHBJ/Y0tMkFtaOK7ilNvXC6YREXqhYWsR
         MSew==
X-Forwarded-Encrypted: i=1; AJvYcCVCbrCwMNIvvSFixULH19RKdAWY+ftY3f2J7SrHANH7CqtyU9eLpDKLdSEBjpvBV+6UVNu9FCmRifV9syk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6fsSgiZbQPLSniFuvB9JVI/Oj4oY4pb2TYERq91c035rLSXtx
	NowOUaXm/t41hD7quXltHViXU6jRx4TPE+CXLPmw3f0uZHyG/590QOR4rF9bFhUxQhtDRq0WzbR
	iuTNfmQ5E6N1npGVfGJcwt+mhyYR3p8q+drMxesuiJVFobtRvIGMRPiwVzYVWiA==
X-Gm-Gg: ASbGnctUfwWV9j1+Ulu6lrlfioqhaWARm5rkXalREcJiJfkNaDbHXkYovklhmSvT7M4
	FFuYv+UZrMHc4Mev8D67+sWBaAhvJWSOZwuEJIg5UuJn01e9TUb+/52yD/WW3E5hvaTNn/o37hk
	PhI8AVHy8yrBjP9xPwxc5asF1p8KBwtXQQyA8RUef+cGdAKvxEVyQweWzNIBdnOG9I+WOhHwSGa
	wsBCloN+TAbyee2+m+vUTllzQdyeCKvXnkUyqgvwHJQ27DVVr+6VzE4WHfMbvMCXuyP4QnWqBjh
	sOVgAoScpzzf3jb+hMUzBw==
X-Received: by 2002:a05:6000:154a:b0:385:e889:4270 with SMTP id ffacd0b85a97d-385fd4365c1mr1756236f8f.56.1733226704792;
        Tue, 03 Dec 2024 03:51:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH/F3aXmuoPATMSkiaZyphdNPoumo1s4gtBFB8R5/Ts345w9Pwkm5yBSWTL+e4JXMWXxhBjg==
X-Received: by 2002:a05:6000:154a:b0:385:e889:4270 with SMTP id ffacd0b85a97d-385fd4365c1mr1756218f8f.56.1733226704383;
        Tue, 03 Dec 2024 03:51:44 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e3c21ba7sm9704995f8f.53.2024.12.03.03.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:51:43 -0800 (PST)
Date: Tue, 3 Dec 2024 12:51:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241203125143.7171892a@imammedo.users.ipa.redhat.com>
In-Reply-To: <e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 10:11:30 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Currently, CPER address location is calculated as an offset of
> the hardware_errors table. It is also badly named, as the
> offset actually used is the address where the CPER data starts,
> and not the beginning of the error source.
> 
> Move the logic which calculates such offset to a separate
> function, in preparation for a patch that will be changing the
> logic to calculate it from the HEST table.
> 
> While here, properly name the variable which stores the cper
> address.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/ghes.c | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 87fd3feedd2a..d99697b20164 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -364,10 +364,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> +static void get_hw_error_offsets(uint64_t ghes_addr,
> +                                 uint64_t *cper_addr,
> +                                 uint64_t *read_ack_register_addr)
> +{


> +    if (!ghes_addr) {
> +        return;
> +    }

why do we need this check?

> +
> +    /*
> +     * non-HEST version supports only one source, so no need to change
> +     * the start offset based on the source ID. Also, we can't validate
> +     * the source ID, as it is stored inside the HEST table.
> +     */
> +
> +    cpu_physical_memory_read(ghes_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +
> +    *cper_addr = le64_to_cpu(*cper_addr);
        1st bits flip, and then see later

> +
> +    /*
> +     * As the current version supports only one source, the ack offset is
> +     * just sizeof(uint64_t).
> +     */
> +    *read_ack_register_addr = ghes_addr +
> +			      ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +}
> +
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> +    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;

if get_hw_error_offsets() isn't supposed to fail, then we do not need to initialize
above. So this hunk doesn't belong to this patch.

>      uint64_t start_addr;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> @@ -389,18 +416,14 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>  
>      start_addr += source_id * sizeof(uint64_t);
>  
> -    cpu_physical_memory_read(start_addr, &error_block_addr,
> -                             sizeof(error_block_addr));
> +    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
>  
> -    error_block_addr = le64_to_cpu(error_block_addr);
> -    if (!error_block_addr) {
> +    cper_addr = le64_to_cpu(cper_addr);
                   ^^^^ 2nd bits flip turning it back to guest byte order again

suggest to keep only one of them in get_hw_error_offsets()

> +    if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");
>          return;
>      }
>  
> -    read_ack_register_addr = start_addr +
> -                             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> -
>      cpu_physical_memory_read(read_ack_register_addr,
>                               &read_ack_register, sizeof(read_ack_register));
>  
> @@ -421,7 +444,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>          &read_ack_register, sizeof(uint64_t));
>  
>      /* Write the generic error data entry into guest memory */
> -    cpu_physical_memory_write(error_block_addr, cper, len);
> +    cpu_physical_memory_write(cper_addr, cper, len);
>  
>      return;
>  }


