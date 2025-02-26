Return-Path: <linux-kernel+bounces-534225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1769CA4645A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC204177881
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F45C224891;
	Wed, 26 Feb 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABFhO7nG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16C2236F7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582988; cv=none; b=aS7lu0Mw5+vNs8G9HmkEnLcgAFawFz7XsUkr1qDJzU8ErVYUJ3UGM6RHEADIcSn8cVDsiVnv5POmbiVU9iTrXqnBiKZEKK3l+J0N//uZQrSEvHHItAZuswIb9tdmBVJWRVIvDyBuMWR1PBl1nHpWc4O9sfxg/pgO7f07svpn53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582988; c=relaxed/simple;
	bh=FUEMvRE7Nzmaxe/eEa1EbvJ7RepkW+SacuMPGANMIUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLPy3EMSsrPDGYiNh583f9x/VSuEdwUsHpOtwrFMnBCAaTpmhBdISBki4JjRpJLdCqJ4PmU7cdRU9Xnc7y1ul00KA2WLN5j7UKsmsqFNUOsaX8OUqEA9gbEkXuEArG3HaImYywk90KngguRDmgNjBthcMng7fUkzCxVA1nGPBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABFhO7nG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740582985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAMKaxbCuypd3vaZYRif/XLYSi0QvW8Uwy9pZuSSG5I=;
	b=ABFhO7nG24EoDPKtc1Tcl0gAISbUwC25TtENDRgGxBNi4hN/Wfv5TzajLE10yJPx1KNTXv
	eQJQVx3EgBgrXMaoNrKF+qK1yVsONfgVhFeLqJMnmox9SbTAI1sEkjwVSGEcsI9E7IV+pO
	E9U3ItIi3X7y+bBhIn3q7LhNNYGRVOs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-EwjMvnpHOaO-o3_qqvRcqA-1; Wed, 26 Feb 2025 10:16:24 -0500
X-MC-Unique: EwjMvnpHOaO-o3_qqvRcqA-1
X-Mimecast-MFC-AGG-ID: EwjMvnpHOaO-o3_qqvRcqA_1740582983
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43988b9ecfbso33080025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582983; x=1741187783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAMKaxbCuypd3vaZYRif/XLYSi0QvW8Uwy9pZuSSG5I=;
        b=KMRext0GwvQ/EEjUmT1l6BEMr7DXIx/7F0tVkZ+Sd0vmAHv5/chZez9Fmdb7Y9ssn0
         Nd28PoRPmR2+olu16t10tVn9zxy6Mo2OM80SzYVji3gAeInXvlThxKOR5qYOpN64Xc7+
         b0unKa+K8xEmrBM15stcXtaHP+MU7SSJ/VBjeB2koUzYm0HB7olAAJC0Ot8DiucZ/TBf
         OocaME9/sHYSIofS7Jn3i26Vv+gQtvsrFsXIL/X/sUW3X4PBjdnrflgWZv0LfeXWNBNn
         Dkk3YzLXzrRrvo+NUYNQxmpayl+HcPrrco+mvNRbS0bwa94qYdMEfM4F9xNqsQ9pwTG3
         Jr9A==
X-Forwarded-Encrypted: i=1; AJvYcCXmwIOQ8t2vAsyn4UutNl0zuID+Rejp1M2kfA/jyyaiG3DZOfJpKtotex5Kg9YaKH4SM3K8O+URl8GJiBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwObMt60ETPQUMWwNNfIiHWdVaHz9nwcA6jQn2bKusNRCU1coCt
	Ga9zHBFZaf53DztCTEejay7WqpX9yA/pdQ64idDMoukFZmVo/4wfHBSR9tyd5rBn5zEaE6SMsjK
	Ac0ZwA4VrFhj+a0Go+0pSX36vGK6l6+eDl3jsZNXDc4sSXsP3EqQa9gc3669wKQ==
X-Gm-Gg: ASbGncs8CR+l9YIxy2zeiFpUN1P+62URF1yxsIddk7vSIOB3PXRH6i51PNPFRCan5jA
	/hCEsfhGd0Zzinoa8A5dSNiTor4hmPW4+JgakdFLFsg4ggt6TIM8y3+7tQPkVnnz/IQ2H/JV42a
	HA8yIMtphp1ZQeGZh8RzhrS+6oB6N2mrBY0k12zUhmGuFHbJt/KvbuC9JSzJqXZrIw8RLm17gD3
	FnR3GY1CMnLrLJjFVb4BQ8y4HrRbxK2TKeOdqlgo3BNk721HepMleizIHQg01nqzyvo7N6qy6FG
	zw9W82xL5LKoQKH0GqeBt4NFu3JTPUAdEyQOORgfmvwNIlL+JwfUR7LByBY8UrQ=
X-Received: by 2002:a05:600c:3b13:b0:439:8b19:fa92 with SMTP id 5b1f17b1804b1-43ab8fd1d5dmr31944505e9.3.1740582982938;
        Wed, 26 Feb 2025 07:16:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlM6i8Ee/tLzlEeUpo6E2Z8sILDKY6kCfAi/XqI/dobpFiR2uV+QuL0e7RHhvki21w2RWp4g==
X-Received: by 2002:a05:600c:3b13:b0:439:8b19:fa92 with SMTP id 5b1f17b1804b1-43ab8fd1d5dmr31943985e9.3.1740582982458;
        Wed, 26 Feb 2025 07:16:22 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba549d6asm24515085e9.36.2025.02.26.07.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:16:21 -0800 (PST)
Date: Wed, 26 Feb 2025 16:16:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/14] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20250226161621.61d482fc@imammedo.users.ipa.redhat.com>
In-Reply-To: <0134424ddba15dea8daaf32b09e89f1bf7e81552.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<0134424ddba15dea8daaf32b09e89f1bf7e81552.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:35:12 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are two pointers that are needed during error injection:
> 
> 1. The start address of the CPER block to be stored;
> 2. The address of the ack.
s/ack/read_ack/

> 
> It is preferable to calculate them from the HEST table.  This allows
> checking the source ID, the size of the table and the type of the
> HEST error block structures.
> 
> Yet, keep the old code, as this is needed for migration purposes

+ from older QEMU versions

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/ghes.c         | 100 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/ghes.h |   2 +-
>  2 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index ba37be9e7022..7efea519f766 100644
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
> + * ACPI 6.1: 18.3.2.7: Generic Hardware Error Source
wrong chapter, read ack can't be in v1 GHES

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
> @@ -412,6 +442,73 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
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
> +        /* Compare CPER source address at the GHESv2 structure */
                                  ^^^^^ typo?

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
> +    /* Navigate though table address pointers */
                   ^^^^^ typo
 
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
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -437,6 +534,9 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
> +    } else {
> +        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
> +                                &cper_addr, &read_ack_register_addr, errp);
>      }
>  
>      if (!cper_addr) {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 454e97b5341c..2f06e433ce04 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -80,7 +80,7 @@ enum {
>  typedef struct AcpiGhesState {
>      uint64_t hest_addr_le;
>      uint64_t hw_error_le;
> -    bool use_hest_addr;         /* Currently, always false */
> +    bool use_hest_addr; /* True if HEST address is present */
>  } AcpiGhesState;
>  
>  void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,


