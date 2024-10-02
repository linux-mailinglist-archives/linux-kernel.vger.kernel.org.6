Return-Path: <linux-kernel+bounces-347695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558D098DB54
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A44283E04
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207901D1E6E;
	Wed,  2 Oct 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RapqLEBn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAEA1D27BE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879118; cv=none; b=TE+d8K4TU6/bgroN6YTuSPQmcpeTUr46WnkxSAfIR6J2zU0E7anCShvH1IFROAySiDwg+KwPAIcItasZtDBAiuhXPa6SDOOcWwAii/y9G8tWU/1/JIyhc0HQcfpjDbEm2E/XddEZuiQm+Far9V0szRUFpeH9M/gYMWCBJVDWDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879118; c=relaxed/simple;
	bh=IEz/fyH3Tyd/8ey7TlFkZNppu6w+xdbX9vzmwHHVvqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRvQckGSAyaeYKGC7O8rt3ynN1japptTIcsLAde6aoY0D/CrzNLfgynRsnbWsZVufsnf3ZqKOrqpgaEGsi8+rHNOZmbRoK79cOkJbsaS4F7eG0/seb0cAfetkg8JMLze8lm2Ux2XCZrH6rIRhUg8ZIQDfR+G8Ntp5L03nlQQuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RapqLEBn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727879115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yYLFWSqoKhXSseNrFGZ+H7UKls7TXd7XUU0eMiJ64U=;
	b=RapqLEBneC6rOGQlKLPqmrnFuonMnfd13e+u4cHqYvJ1VaU45wd/B2N1ikVT6KVAcoyHlc
	Bm/TEfI/tMamEJjQuzJVqztvhk9lUhAFmtqgFnfAbKb5DUrb+sv4qvsTW60tV/XUEFzFQP
	MJPnXxIVZ+SsJa8MqmOXNDrsdtucOfg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-eG5EUtRGP7iXe2MPgWmlYw-1; Wed, 02 Oct 2024 10:25:14 -0400
X-MC-Unique: eG5EUtRGP7iXe2MPgWmlYw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso67148045e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879112; x=1728483912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yYLFWSqoKhXSseNrFGZ+H7UKls7TXd7XUU0eMiJ64U=;
        b=ToXQJZe5k61jLTY7J+wBIVISQeFnMHfvwYcI4cVsxoM2lDUu1eoEbKOzRkO2PE+150
         fnOUMN/Pmy8HSCzRXHgVx04Wg0yN6n2pCmGpiCjvT43G7jXz8JZFKkd5rXcC5oeNkL82
         nvkx9BEz9dV5b8VnSlWraRC5pESwEJHcOuAUnw8awo87RYVdbv/xax2r5yg9sOTOO7B6
         9e0B2o1iHZxqB5u2dmg/hmcnn+iAC9JfPl/72g65dtnTFHeMJwfx9x4Y668C6zlsfdxN
         s75raB7Wz9gg5vgo7uYNuhsdiZVkLdll2Lm2SqSe0m+MMdJGdAK4g9LKCooPN6CXPxpx
         uH3A==
X-Forwarded-Encrypted: i=1; AJvYcCUFxcGg9lPWEP7+Y5Iz3zfhpooiA4jwzN9E9f+w+S0Args7vbzVK+BWWRo7YRJ2aOzf2EKL2tA+EOYhFkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdxg8Z2fGXc7ivpyhMRhxInv7oIQYpjTVeoRdBVFWjRIW463dc
	ajpbEdIrQtwVz0U9qIKI82zJJAsev/G5m+2/UDmm5c9h/1WVNBTLYpFL3//JBSbYtJuzzfGFYeK
	aC6nJV4gx0r8DrlWcBgFD8fQ5hRDfpqb6cmFFNdXfnbtmlExST1wJAc1mNusEQwC+qrFreA==
X-Received: by 2002:adf:e712:0:b0:37c:d1c6:7e45 with SMTP id ffacd0b85a97d-37cfba0a614mr2591329f8f.40.1727879112092;
        Wed, 02 Oct 2024 07:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvsBZu6kUdqGD6UWXQeMJQdhI82ZeuVK+z+lgmZ2rR4jdzCitMuuMV5JcjWjKCcTMKcXxDcg==
X-Received: by 2002:adf:e712:0:b0:37c:d1c6:7e45 with SMTP id ffacd0b85a97d-37cfba0a614mr2591309f8f.40.1727879111650;
        Wed, 02 Oct 2024 07:25:11 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d2aasm14147627f8f.4.2024.10.02.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:25:11 -0700 (PDT)
Date: Wed, 2 Oct 2024 16:25:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 2/5] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20241002162510.6cb7aef6@imammedo.users.ipa.redhat.com>
In-Reply-To: <9eacb24e5e13b2028be90d19e936868a921f8e34.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
	<9eacb24e5e13b2028be90d19e936868a921f8e34.1727782588.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 13:42:47 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are two pointers that are needed during error injection:
> 
> 1. The start address of the CPER block to be stored;
> 2. The address of the ack, which needs a reset before next error.
> 
> Calculate them preferrable from the HEST table, as this allows
> checking the source ID, the size of the table and the type of
> HEST error block structures.
> 
> Yet, keep the old code, as this is needed for migration purposes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 93 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 83 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 2c2cf444edeb..313a6e453af6 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -61,6 +61,23 @@
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> +/*
> + * Offsets with regards to the start of the HEST table stored at
> + * ags->hest_addr_le, according with the memory layout map at
> + * docs/specs/acpi_hest_ghes.rst.
> + */
> +
> +/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
> + */
> +#define HEST_GHES_V2_TABLE_SIZE  92
> +#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET)
> +
> +/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
> + * Table 18-380: 'Error Status Address' field
> + */
> +#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET)
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -218,14 +235,6 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>  {
>      int i, error_status_block_offset;
>  
> -    /*
> -     * TODO: Current version supports only one source.
> -     * A further patch will drop this check, after adding a proper migration
> -     * code, as, for the code to work, we need to store a bios pointer to the
> -     * HEST table.
> -     */
> -    assert(num_sources == 1);
> -
>      /* Build error_block_address */
>      for (i = 0; i < num_sources; i++) {
>          build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
> @@ -425,6 +434,65 @@ static void get_ghes_offsets(uint64_t ghes_addr,
>      *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>  }
>  
> +static void get_hest_offsets(uint16_t source_id, uint64_t hest_addr,
> +                             uint64_t *cper_addr,
> +                             uint64_t *read_ack_start_addr,
> +                              Error **errp)

cper/read_ack are GHES specific only, aren't they?

perhaps s/get_hest_offsets/get_ghes_source_offsets/


> +{
> +    uint64_t hest_err_block_addr, hest_read_ack_start_addr;
> +    uint64_t err_source_struct, error_block_addr;
> +    uint32_t num_sources, i;
> +
> +    if (!hest_addr) {
> +        return;
> +    }
> +
> +    cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
> +
> +    err_source_struct = hest_addr + sizeof(num_sources);
> +
> +    /*
> +     * Currently, HEST Error source navigates only for GHESv2 tables
> +     */
> +
> +    for (i = 0; i < num_sources; i++) {

missing le2cpu(num_sources)

> +        uint64_t addr = err_source_struct;
> +        uint16_t type, src_id;
> +
> +        cpu_physical_memory_read(addr, &type, sizeof(type));

ditto for anything larger than 1 byte that you read from guest memory
(all over the patch)

> +
> +        /* For now, we only know the size of GHESv2 table */
> +        assert(type == ACPI_GHES_SOURCE_GENERIC_ERROR_V2);

Imagine in qemu-9.3 we add non GHES error source, and then try to migrate
such guest to qemu-9.2. It will explode here.
Of-cause we can add some compat property to ged or machine type to
make sure that code works old way in qemu-9.3 for virt-9.2
at expense of keeping 9.2 code in 9.3. Which adds to maintenance burden
and fragile, also it's a matter of time before we screw it up and release
non-migratable/broken QEMU.

So I'd like to avoid piling up compat code/knobs on to of each other
and do it in a way where this src id lookup could gracefully skip
not implemented yet error sources.
This way we won't need any compat knobs to deal with in the future. 

> +
> +        /* It is GHES. Compare CPER source address */
> +        addr += sizeof(type);
> +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
> +
> +        if (src_id == source_id) {
> +            break;
> +        }
> +
> +        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
> +    }
> +    if (i == num_sources) {
> +        error_setg(errp, "HEST: Source %d not found.", source_id);
> +        return;
> +    }
> +
> +    /* Navigate though table address pointers */
> +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
> +    hest_read_ack_start_addr = err_source_struct + GHES_ACK_OFFSET;

s/hest_read_ack_start_addr/hest_read_ack_addr/

> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(error_block_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +
> +    cpu_physical_memory_read(hest_read_ack_start_addr, read_ack_start_addr,
> +                             sizeof(*read_ack_start_addr));
> +}
> +
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -445,8 +513,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
> -                     &cper_addr, &read_ack_register_addr);
> +    if (!ags->hest_addr_le) {
> +        get_ghes_offsets(le64_to_cpu(ags->hw_error_le),

should it be named get_hw_error_offsets

> +                         &cper_addr, &read_ack_register_addr);
> +    } else {
> +        get_hest_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
> +                         &cper_addr, &read_ack_register_addr, errp);
> +    }
>  
>      if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");


