Return-Path: <linux-kernel+bounces-418480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770079D6215
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366F92818E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3321DFDA6;
	Fri, 22 Nov 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2Qnlzt0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91631DF996
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292432; cv=none; b=PfmNgI2rM9fLmnLL86o/YPmBbiO0Mkxubp9FLsBZIIsW2kOEEtY0CTE5DmKBZiDIa8B0XxbMP/bwSgTciiT25lyKdcKA3k12ivNEaCpWIYq+z06y9W2Lh5KcCcyr6Bhs7NXmju6riwjK/NaHQAVP8WNXsgWphpJHMU9hNSMp0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292432; c=relaxed/simple;
	bh=O8DTFdUDvt0Jqe14tTtcDcYNJoRYAHOjoV9axjKb8tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6JfbTx95BuQ4gpFjp9kOPArOfE+VYcFZhw79EBfeBexo/OOXGhvBrZp3TBMTRAaiGG+NfZjbSjSOjHPwuH0PMSj7f4RcCDkBe+yNGIoA2FuznlUQIxTpjtH02ss+4EG6okyxBt7txWE423djcUQIs1afbAOGg1Bp6eL/eKCr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2Qnlzt0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732292429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeBsoywq5pgh/XUprwXSGU0TjSDIfHvJFYAFD/VkyJs=;
	b=f2Qnlzt0Pt2kIi3ZK21nuccAe6gJNTvcZCIe3T4lLjUILUNcIyfrD35yq5AL7CVc7oki7C
	cNFrT7dHAlTVfy++Gx1Tefagw13+fWlYrIrr7idKaAW8fEMJabpjxUGVc/Nul1pBFrxaTs
	ghD2aLTt/Pu9nYCOSh8BfwrZcNoCxiQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-kF-eEYDANqqwl81mn6m9wg-1; Fri, 22 Nov 2024 11:20:27 -0500
X-MC-Unique: kF-eEYDANqqwl81mn6m9wg-1
X-Mimecast-MFC-AGG-ID: kF-eEYDANqqwl81mn6m9wg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso20088825e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292427; x=1732897227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeBsoywq5pgh/XUprwXSGU0TjSDIfHvJFYAFD/VkyJs=;
        b=tLmt7dL4gljy91qzNIn4ezeZPvsHy7mRxZvEgQEOgvwAfDkaKDYB/A0u4WX3Mj20LW
         HtPAfqaSaYXOeZ+w6OoGo6RTWZj+4LrOHmCneJY11AkncvMJ3ZZ6qreKSxkcRdkD8I1e
         AV1orI5yGK/EukXh4L3FnGpq0d3CzIRGE3NRlSz/sjUrWf1KnwQmZQx3f5rORXZ6GelH
         Hdz5sbB3cqJmFTlRj/5o3bYq55SDAfJ10vkFpz4PNcXtvASUv6myx+NB+NDKKE3QH520
         vBTBKoiwQ+RG30ok3pQv0TnyQz8JV7Y5EbCDUqif7atXswz892XOVUKx6tG6E9ZJmy/x
         FHUg==
X-Forwarded-Encrypted: i=1; AJvYcCWbPWfNN35dQ83OTDYFt1LLEQH41coDvvXuaG5ebQLkwDr/XqGqNxHALHjBMnK8QxcJqm+mYcw1LNU6K60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoF8nJylNda/5MP84sLoKGh/vu1gkxG/NhRGnRD8HTLpMoy2YE
	7fEjIfFJa2o2CVVx0EXOtSS3KuLkFudGzO/KhyDoskxfUkTqgeezx9zJnHo67AVqH+BeNMDOpfU
	W3axJ6ZaoH8x7ZcHx7ok83DkKWb9LcX9l0cL3AIdGS9pkiI1r3fB5IKRvLre/KQ==
X-Gm-Gg: ASbGncsqFBnRt8M1VTXoQU64YGCzThyqnjmb780v1Ogk4nyXEipfsr341IueVUI3+Sp
	9ZHtg4Exs1Xb5nf07rHEc3u6GMhJ76+n9zWX2gLoX4CvYvNBLR06SyrLmmZEsnEygsGae7gZ9nr
	feE5yE/M+psQScCMDK0DnGcqHscr/2nyPTlAjqHeYidqJATqEia/aZCyY4fQd3nsdFSjGfBGXAY
	I/OQjbBDSnPWExUYZWGh+ZigRY+n3eX9cF3wiVw2a9ESGQhYLQS9AF+dUWdbwJpHySOO2xYLDii
	v3cA2Ta6DLDle59UEw5zFQ==
X-Received: by 2002:a05:600c:4fcc:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-433ce410337mr29781545e9.1.1732292426644;
        Fri, 22 Nov 2024 08:20:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfnCVCtSLDvYz49C8CbppJHHhiynRHuZUEWU9I8Ig8QVTpU3P25aNt428T9B2r9GX9wU/yTw==
X-Received: by 2002:a05:600c:4fcc:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-433ce410337mr29781235e9.1.1732292426254;
        Fri, 22 Nov 2024 08:20:26 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b4643217sm95331535e9.44.2024.11.22.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:20:24 -0800 (PST)
Date: Fri, 22 Nov 2024 17:20:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 04/15] acpi/ghes: better handle source_id and
 notification
Message-ID: <20241122172022.64fddb52@imammedo.users.ipa.redhat.com>
In-Reply-To: <0ad66ed39b357d5fbf2e4a6d1fa47d310796cc1c.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<0ad66ed39b357d5fbf2e4a6d1fa47d310796cc1c.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 10:11:21 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> GHES has two fields that are stored on HEST error source
> blocks associated with notifications:
> 
> - notification type, which is a number defined at the ACPI spec
>   containing several arch-specific synchronous and assynchronous
>   types;
> - source id, which is a HW/FW defined number, used to distinguish
>   between different implemented sources.
> 
> There could be several sources with the same notification type,
> which is dependent of the way each architecture maps notifications.
> 
> Right now, build_ghes_v2() hardcodes a 1:1 mapping between such
> fields. Move it to two independent parameters, allowing the
> caller function to fill both.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> Chenges from v10:
> 
> - Some changes got moved to the previous patch.
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 4a6c45bcb4be..29cd7e4d8171 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -284,9 +284,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> -static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> +static void build_ghes_v2(GArray *table_data,
> +                          BIOSLinker *linker,
> +                          enum AcpiGhesNotifyType notify,
> +                          uint16_t source_id)
>  {
>      uint64_t address_offset;
> +
>      /*
>       * Type:
>       * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> @@ -316,18 +320,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>          address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
>          ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
>  
> -    switch (source_id) {
> -    case ACPI_HEST_SRC_ID_SEA:
> -        /*
> -         * Notification Structure
> -         * Now only enable ARMv8 SEA notification type
> -         */
> -        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
> -        break;
> -    default:
> -        error_report("Not support this error source");
> -        abort();
> -    }
> +    /* Notification Structure */
> +    build_ghes_hw_error_notification(table_data, notify);
>  
>      /* Error Status Block Length */
>      build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
> @@ -369,7 +363,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>  
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
> -    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, linker,
> +                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
>  
>      acpi_table_end(linker, &table);
>  }


