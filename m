Return-Path: <linux-kernel+bounces-536408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE170A47F21
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502C87A3F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AA822FF42;
	Thu, 27 Feb 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfYAHXeJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742E21348
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662843; cv=none; b=nLqdyf4s+z2K4jWVgmjYMWmP7+70Tf8/sRrnkgFZAEa+bfOWVMkPAfa//oXrRrL+c0rfBhd9J/lDQWcO68qpBIxHZrFRIlX2b8kyvfmxvt7lk5e9Egewq7yYsAvepG/1egL/ahLOQsedib1q0kZUQOti9anuRxRQEajWxhDqWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662843; c=relaxed/simple;
	bh=sVCxZPCqujOzBVTyTOiH5muwUVaT0q8C8JTT60kv2cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=berB78cKq3mQIkihNCngYT83MHA2r7R9rnAe3njkQmshfkqSFgVcJqhlDmz7zs4z8Ba/gV/qTZYLNfwPRiJeaisMee23Dh1B4m8Fms2hkYDzWBfFjy4QOxAOtKTPeYLgVmaNIkgQk5NUiPIYyS60M7stVOeqgzgbSvUQ9J8fiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfYAHXeJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740662840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Az0axnx9GoNHmG1bRahpz+gTtatrJjB9FkHXDcLXTEU=;
	b=SfYAHXeJDWt2//MhBw2kNKYdGLMEZ9+LFHSZYTdcWohTvhA8lHMlTA2mg4Lp2PIiAdfCbz
	9XTz0xGHzbhkaaZ+N7TvWNiXTnGCQUUbK3kmYGrdGflzAYlzwS4QZMJGH0ezzYceTeMftH
	EELNzxK3N79vZz89AdK9fgfrICV4kbY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-aECv8yEyM4-Wvmmj7QwCjA-1; Thu, 27 Feb 2025 08:27:18 -0500
X-MC-Unique: aECv8yEyM4-Wvmmj7QwCjA-1
X-Mimecast-MFC-AGG-ID: aECv8yEyM4-Wvmmj7QwCjA_1740662838
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f628ff78eso536442f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662837; x=1741267637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Az0axnx9GoNHmG1bRahpz+gTtatrJjB9FkHXDcLXTEU=;
        b=hSsFNavMxtLUkB+trqEzwioIOm43AW/Q5zXhHpg8JET1rbBsfQmwCeYluNE+cwI+Or
         X7L/NSMRBsIcZ7VsmDECI+ydfH/M9qoYVKS0zMh5PSpya4rsve7B0qvBXjOEYAnQ+eTK
         NiifZ9IlyuQp1alpUl+RGFs5ct+X6f+0VhstVClUFtsZr5xr9zQnS5Lqk709oBZrabs1
         hkUYrxdZdtJeWe+DfFG4qGsevuVP3rRMM3357uhKeRIW6PWnS07OgaCU3C7I5VEtT6FL
         dLaX3RPDKNf/Z+7aQgUYDayGCSArGj1GtjD0juNSMLeWnor16QANs6nIzfcXguZ//BOP
         mNUg==
X-Forwarded-Encrypted: i=1; AJvYcCVRw5RwhclXJEQ3x3GovgaFhCgw2J4h2e1fZAlA5m8jCRdCKquErvu0HHVLVoXzheGd/6QeLYlk/c8zDZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/4CqLR3Ezqg1HP2T9nEvaltoGC1RkLTNv9kqxXPvq2mH17HV
	KzAlDA+CFlb1+9tgkSxFZO+MBsKYBxfb9sLrPOVbQqTha68KNKc8J64qWZP/yfWM6rKv54vsEsy
	3u0qJ/ubQGmYhSj3qYSVWJN9Cm21J35aw0wfvnhsUznjNfI4ruotJ/ot1eqPv9Q==
X-Gm-Gg: ASbGncuEKeQFQaoQaM/z6qxz51f+ZKE9cefhllEQ8MAojZGyQe9ioQHzgMTDX5IzaDD
	1sG/guC6izjfJ/YKD4gfFdpZo7aKQnR8FgpNyCmlAjlurCpZTG0ufzbE+zf7HliIf8td0yelYk9
	BbnNtz7/VpzHv19E/OhD9t1s+mwULiwjzYUnKSKC7koWUY+/YuOgPc6+MX07UIvI4N+zVZAKGwQ
	Kz1GdMsyBXcylpxKaBjA46ps1R5RXc+c8zyNcZ/hl+ysGvbN4sHAig8nJ/U81Y3LGGDScQ+pIn6
	O0eSuCO4JZl1MGgPTZh7ddxRV/MjYtLQRLFAgkFML4SYryD9PNAPvQCmnx9FrPQ=
X-Received: by 2002:a5d:5f93:0:b0:38b:f4e6:21aa with SMTP id ffacd0b85a97d-390e1648bd8mr2548339f8f.5.1740662837593;
        Thu, 27 Feb 2025 05:27:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpfkKx1S7TW7K4FNOYoEi418gJH6dJcGjcmN/GLUDm9AZ+9mdiaFjVmR4OGFaJbqvSqzQKDA==
X-Received: by 2002:a5d:5f93:0:b0:38b:f4e6:21aa with SMTP id ffacd0b85a97d-390e1648bd8mr2548313f8f.5.1740662837146;
        Thu, 27 Feb 2025 05:27:17 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795962sm2139257f8f.13.2025.02.27.05.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:27:16 -0800 (PST)
Date: Thu, 27 Feb 2025 14:27:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/21] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20250227142715.79984512@imammedo.users.ipa.redhat.com>
In-Reply-To: <bd544e003047996eaaebe10c11e13f1d30c2751d.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<bd544e003047996eaaebe10c11e13f1d30c2751d.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 12:03:37 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are two pointers that are needed during error injection:
> 
> 1. The start address of the CPER block to be stored;
> 2. The address of the read ack.
> 
> It is preferable to calculate them from the HEST table.  This allows
> checking the source ID, the size of the table and the type of the
> HEST error block structures.
> 
> Yet, keep the old code, as this is needed for migration purposes
> from older QEMU versions.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c         | 100 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/ghes.h |   2 +-
>  2 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 8ec423726b3f..5158418f93cb 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -41,6 +41,12 @@
>  /* Address offset in Generic Address Structure(GAS) */
>  #define GAS_ADDR_OFFSET 4
>  
> +/*
> + * ACPI spec 1.0b
> + * 5.2.3 System Description Table Header
> + */
> +#define ACPI_DESC_HEADER_OFFSET     36
> +
>  /*
>   * The total size of Generic Error Data Entry
>   * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> @@ -61,6 +67,30 @@
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> +/*
> + * See the memory layout map at docs/specs/acpi_hest_ghes.rst.
> + */
> +
> +/*
> + * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure
> + */
> +#define HEST_GHES_V2_ENTRY_SIZE  92
> +
> +/*
> + * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure
> + * Read Ack Register
> + */
> +#define GHES_READ_ACK_ADDR_OFF          64
> +
> +/*
> + * ACPI 6.1: 18.3.2.7: Generic Hardware Error Source
> + * Table 18-341 Generic Hardware Error Source Structure
> + * Error Status Address
> + */
> +#define GHES_ERR_STATUS_ADDR_OFF  20
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -408,6 +438,73 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>      *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>  }
>  
> +static void get_ghes_source_offsets(uint16_t source_id,
> +                                    uint64_t hest_addr,
> +                                    uint64_t *cper_addr,
> +                                    uint64_t *read_ack_start_addr,
> +                                    Error **errp)
> +{
> +    uint64_t hest_err_block_addr, hest_read_ack_addr;
> +    uint64_t err_source_entry, error_block_addr;
> +    uint32_t num_sources, i;
> +
> +    hest_addr += ACPI_DESC_HEADER_OFFSET;
> +
> +    cpu_physical_memory_read(hest_addr, &num_sources,
> +                             sizeof(num_sources));
> +    num_sources = le32_to_cpu(num_sources);
> +
> +    err_source_entry = hest_addr + sizeof(num_sources);
> +
> +    /*
> +     * Currently, HEST Error source navigates only for GHESv2 tables
> +     */
> +    for (i = 0; i < num_sources; i++) {
> +        uint64_t addr = err_source_entry;
> +        uint16_t type, src_id;
> +
> +        cpu_physical_memory_read(addr, &type, sizeof(type));
> +        type = le16_to_cpu(type);
> +
> +        /* For now, we only know the size of GHESv2 table */
> +        if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
> +            error_setg(errp, "HEST: type %d not supported.", type);
> +            return;
> +        }
> +
> +        /* Compare CPER source ID at the GHESv2 structure */
> +        addr += sizeof(type);
> +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
> +        if (le16_to_cpu(src_id) == source_id) {
> +            break;
> +        }
> +
> +        err_source_entry += HEST_GHES_V2_ENTRY_SIZE;
> +    }
> +    if (i == num_sources) {
> +        error_setg(errp, "HEST: Source %d not found.", source_id);
> +        return;
> +    }
> +
> +    /* Navigate through table address pointers */
> +    hest_err_block_addr = err_source_entry + GHES_ERR_STATUS_ADDR_OFF +
> +                          GAS_ADDR_OFFSET;
> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +    error_block_addr = le64_to_cpu(error_block_addr);
> +
> +    cpu_physical_memory_read(error_block_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +    *cper_addr = le64_to_cpu(*cper_addr);
> +
> +    hest_read_ack_addr = err_source_entry + GHES_READ_ACK_ADDR_OFF +
> +                         GAS_ADDR_OFFSET;
> +    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
> +                             sizeof(*read_ack_start_addr));
> +    *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
> +}
> +
>  void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -423,6 +520,9 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
> +    } else {
> +        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
> +                                &cper_addr, &read_ack_register_addr, errp);
>      }
>  
>      cpu_physical_memory_read(read_ack_register_addr,
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 38abe6e3db52..dcc7288ffba5 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -79,7 +79,7 @@ enum {
>  typedef struct AcpiGhesState {
>      uint64_t hest_addr_le;
>      uint64_t hw_error_le;
> -    bool use_hest_addr;         /* Currently, always false */
> +    bool use_hest_addr; /* True if HEST address is present */
>  } AcpiGhesState;
>  
>  void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,


