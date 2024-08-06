Return-Path: <linux-kernel+bounces-275937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5103948C30
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C479D1C22FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22E16B74F;
	Tue,  6 Aug 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPVVygAP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534641AAC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936750; cv=none; b=UdJyMQXxdu1kW8MBFn1gcyB7aseOiZ6wIY8eP8Dw9zBmzUxvc5rPeu9Z8a1qS2hpzWmv5o/2rzxDGFfARLtYzr1zIGRGm7Wv20UA0Ioa368d74ykm38HvqaJtJMRHayfhRsQvMOSX46uWGKqYZQ3WpbyhTr7X7/79gSJNTedd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936750; c=relaxed/simple;
	bh=HvT2rHpCSmQ5CZ1ctLsjQLUyRlAgJmMWqbD3dpG0Hp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXqDznLRIZiXgM2zxcjncxYvZVZG9NCh/Z/Gx7mMAkr1lcVQ36nCGwXkqrUbZQjRzRMwOfY1lSU9NXaMIhb4fpbpgyYOh5R+Ap8PDLO6CUvpx0M+lxiZrvYlxYncNnhy7gmlV2ZhXta75FoPnw91yPODrHbIj44cwZMKbqrHYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPVVygAP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722936747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNPu6LDpYhbJ2jHL6PKAzJIFj3TmTcV+iCxzYNSBT/0=;
	b=SPVVygAPH8o1qqlHwBpH6X+xeZ7odPFAzeriba2q2Yumi9ISRon9Jlyd1PYB6MvUK5KMMK
	eUBZ7X6ukyIK1XI92INyhOIIrd2ep2DMlKOTm8qnbY8moEHsiluWLS4JKXUp3bb2LvxlDY
	kjVjGXG2+3gSZwtOn3eIwi0vEASTwik=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-wRuu7IrRO--m-WvKzGWeRA-1; Tue, 06 Aug 2024 05:32:24 -0400
X-MC-Unique: wRuu7IrRO--m-WvKzGWeRA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef22e62457so4093131fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722936742; x=1723541542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNPu6LDpYhbJ2jHL6PKAzJIFj3TmTcV+iCxzYNSBT/0=;
        b=sjqNgyaYxIs8M4ADCCZC9A+UnDbkEGAut/t3W9zxwj2N7v1hQdYUW+lF8H4NFXyzaB
         mBPeJ0f3m3/3Yl6Jsa2bOIyk/wd9YLpjmfpDhk6LFwuO/2EoSYfzojEHB/6RjJO15FUm
         BlImuRO4+DJEqgAjPMzi2DlMd4ONNVTgWh+5emJFGIJkHrDGPcsJibt/fDWV6a3k2DCg
         ZZQXIt3rL++3LxP2cJIUajcujyaGyxq1dWKaruGdUVznr6rpFulf5/QaE+K9zX96t8a+
         dFT9rACwBQaynEvzQal3+eNha9kfb+MZwb/njcWwyd8rjRyEpzMLp5v+vpYqyZKKN+q3
         NNQg==
X-Forwarded-Encrypted: i=1; AJvYcCVX1bSHxhvOsAEbVJ6L6H0Knw6fzV7IRhSQPhZBVTdrl812SH+V3T0l0tELeqeiGnffzOz78MgUGO5k+ruRCFbhdw4MBHdVJOzmBVZy
X-Gm-Message-State: AOJu0Yz6OLlJG7RQv+BB9nkcSUH9RNsyRvs4K6V8y9Q4WgU5RX6UaM9h
	BRMDkE1ZdyWuOcRcLqNJ6bQmPACSH1szBp59J17e9DfT1NVhZA5TqRuPF1OM/k3+Cj+NuB5+2mc
	ZDCVZWqH+4FuTxiSylaODUM0msu97HFjW8jqtUjh8m/PvGaG6JMHtV30z1Zq349tP8iqROw==
X-Received: by 2002:a2e:968b:0:b0:2ec:56b9:259b with SMTP id 38308e7fff4ca-2f15ab5db15mr94720561fa.49.1722936742175;
        Tue, 06 Aug 2024 02:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEow/WATG8BQ3G1Izu1sXI36xWSPlf4kPcR6y+06fEg5iiFT1qOQ5VcUBxZEzK3GuW8lZA1nQ==
X-Received: by 2002:a2e:968b:0:b0:2ec:56b9:259b with SMTP id 38308e7fff4ca-2f15ab5db15mr94720281fa.49.1722936741527;
        Tue, 06 Aug 2024 02:32:21 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a86dsm233403665e9.1.2024.08.06.02.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 02:32:20 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:32:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Message-ID: <20240806113219.02ba0fdd@imammedo.users.ipa.redhat.com>
In-Reply-To: <5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 23:43:59 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add error notification to GHES v2 using the GPIO source.
> 
> [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks]
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 16 ++++++++++------
>  include/hw/acpi/ghes.h |  3 ++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 8d0262e6c1aa..a745dcc7be5e 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -34,8 +34,8 @@
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
>  
> -/* Now only support ARMv8 SEA notification type error source */
> -#define ACPI_GHES_ERROR_SOURCE_COUNT        1
> +/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
> +#define ACPI_GHES_ERROR_SOURCE_COUNT        2
>  
>  /* Generic Hardware Error Source version 2 */
>  #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
> @@ -290,6 +290,9 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>  {
>      uint64_t address_offset;
> +
> +    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> +
>      /*
>       * Type:
>       * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> @@ -327,6 +330,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>           */
>          build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
>          break;
> +    case ACPI_HEST_SRC_ID_GPIO:
> +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);

perhaps ACPI_GHES_NOTIFY_EXTERNAL fits better here?

> +        break;
>      default:
>          error_report("Not support this error source");
>          abort();
> @@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GPIO, linker);
>  
>      acpi_table_end(linker, &table);
>  }
> @@ -406,10 +413,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
>      if (physical_address) {
> -
> -        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
> -            start_addr += source_id * sizeof(uint64_t);
> -        }
> +        start_addr += source_id * sizeof(uint64_t);

why check is being removed?

>  
>          cpu_physical_memory_read(start_addr, &error_block_addr,
>                                   sizeof(error_block_addr));
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 6891eafff5ab..33be1eb5acf4 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -59,9 +59,10 @@ enum AcpiGhesNotifyType {
>      ACPI_GHES_NOTIFY_RESERVED = 12
>  };
>  
> +/* Those are used as table indexes when building GHES tables */
>  enum {
>      ACPI_HEST_SRC_ID_SEA = 0,
> -    /* future ids go here */
> +    ACPI_HEST_SRC_ID_GPIO,
>      ACPI_HEST_SRC_ID_RESERVED,
>  };
>  


