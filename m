Return-Path: <linux-kernel+bounces-292224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6493A956CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FEE6B25552
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265516D304;
	Mon, 19 Aug 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9t/RzUt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80122166F21
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076463; cv=none; b=LoBdxMQnU7AxgvZMbMrrcdAF084MDS0CFCUfVafGj5M16/wjd40nFrrGTlFC2Py9ka1G6sE+z+8pTkJTKwqPqOWNNclaG7SknVxI3aWwUT4gjqKWf4vQ3WJSGvxM0scbI4mc5eHOVLJt5VAhoS/J45K8hL7qoLZudOE46qZMQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076463; c=relaxed/simple;
	bh=yqdmO/wb+HUK00EHySef2/UTEWgvOVowf6qWDp3N4nI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8YM/82lf67E1wiEnug5QhOG7L81AIw5ylCK1f+PTfcd2rgm/unmNtiaprc8BCrmQs1JKp8+Hv/scqqLa9+yPTvvYh//ikyw6Hb/awNxngJNe98mywlEG2rwqXGdKUCQG2B9UcQlhfcwBwb0lg1wr7aINl3UJJGQ5cmABii2Fqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9t/RzUt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724076460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaG8gnC9HkBkVZUgCu9DLDVNY0F8IxCdBiRj1sSxhj0=;
	b=g9t/RzUtyzWvsa67Sx02VaKYHpdQca/jW63/1cEumioIy5j96AM9fo9wfI9s33aAsfPTHr
	HuP/8kV5uTUbSoli3087jPuBQwQd2Z8eNo2qlScgWh3zIjDG90YURbI7hk5rKum3tIMK6V
	kyJnMgGdN//9cphjf8mnyj+XA4XToZM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-sAeB1UQTMJKaI6-TJQI0gQ-1; Mon, 19 Aug 2024 10:07:37 -0400
X-MC-Unique: sAeB1UQTMJKaI6-TJQI0gQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280a434147so37114625e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724076455; x=1724681255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaG8gnC9HkBkVZUgCu9DLDVNY0F8IxCdBiRj1sSxhj0=;
        b=eoi0RHX+PVv9AEGNe6lR/ehZ53WHiF2P82B58sMezeGHrV4nqUPui6pfxbIxBHIT7N
         gDnI9vtBxVjyEMs7y+Vp0nruAbchtj2Nj9arVAQE/KfsA8I0E5c94jPxnd/gJet3EtSO
         is44VH30a0ZlJl9jVShHBCyi2Ld1+2SR05mjW23AayCyVjYW5ytjcQPuuordbA8p1/L/
         w1feyr2dvaSuF7l6RIz52DXZGk0Wly26KyIr9RjprGMawz1H2uYU8iPHE1avPIUeQmvj
         0Tzn1B7uJqvLG0PZzrWt0bxeWK/n6JkqWcY2ygHVqrlVDONB33GrhfhEc7kM6Q72jM6z
         i4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUS0YA3bVc3wSpHjSVnYyyPoTKawwwDwDUlVMrbIlE0uRvMqztwjn3hgbEc8ahqD03BOVLSmC5BYVQGTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+2dW1MyhDfUk0/1lDlBWV2sk/CeFAVl8Sw4cH7xR0vENXdoE
	xeuioDGUgJCzOwgOdmrvQSkIugCyEusRs3M4ZNTYukxVSCVNUno0YtNqivoQ0qL8iB2MCOAItGa
	/vtz/+XX+aJ7yyRqs2OwlQEMRu1F4xdYFtRilmW/mi7sRteoOFObreLlKs8rKlQ==
X-Received: by 2002:a05:600c:3c92:b0:428:14b6:ce32 with SMTP id 5b1f17b1804b1-429ed794e9bmr83814525e9.9.1724076455465;
        Mon, 19 Aug 2024 07:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfRKyefx3jM8peabry8rlLAWDzXV188Bk6OgXILyrHTgcw2C0oEyb8nbpJUVCVYivXUG6/SQ==
X-Received: by 2002:a05:600c:3c92:b0:428:14b6:ce32 with SMTP id 5b1f17b1804b1-429ed794e9bmr83814305e9.9.1724076454913;
        Mon, 19 Aug 2024 07:07:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5a9sm164102525e9.43.2024.08.19.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:07:34 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:07:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 13/13] acpi/ghes: check if the BIOS pointers for HEST
 are correct
Message-ID: <20240819160733.464ccebf@imammedo.users.ipa.redhat.com>
In-Reply-To: <52e6058feba318d01f54da6dca427b40ea5c9435.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<52e6058feba318d01f54da6dca427b40ea5c9435.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 09:37:45 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The OS kernels navigate between HEST, error source struct
> and CPER by the usage of some pointers. Double-check if such
> pointers were properly initializing, ensuring that they match
> the right address for CPER.

as QEMU, we don't care about what guest wrote into those addresses
(aka it's not hw businesses), even if later qemu will trample
on wrong guest memory (it's guest responsibility to do init right).

However this patch introduces usage for hest_addr_le, that I was looking for.
See notes below.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index a822a5eafaa0..51e2e40e5a9c 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -85,6 +85,9 @@ enum AcpiHestSourceId {
>  #define HEST_GHES_V2_TABLE_SIZE  92
>  #define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET + ACPI_HEST_HEADER_SIZE)
>  
> +/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source */
> +#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET + ACPI_HEST_HEADER_SIZE)
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -425,7 +428,10 @@ NotifierList acpi_generic_error_notifiers =
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               enum AcpiGhesNotifyType notify, Error **errp)
>  {
> -    uint64_t cper_addr, read_ack_start_addr;
> +    uint64_t hest_read_ack_start_addr, read_ack_start_addr;
> +    uint64_t read_ack_start_addr_2, err_source_struct;
> +    uint64_t hest_err_block_addr, error_block_addr;
> +    uint64_t cper_addr, cper_addr_2;
>      enum AcpiHestSourceId source;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> @@ -450,6 +456,28 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
>      cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
>  
> +    err_source_struct = le64_to_cpu(ags->hest_addr_le) +
> +                        source * HEST_GHES_V2_TABLE_SIZE;

there is no guaranties that HEST table will contain only GHESv2 sources,
and once such is added this place becomes broken.

we need to iterate over HEST taking that into account
and find only ghesv2 structure with source id of interest.

This function (and acpi_ghes_record_errors() as well) taking source_id
as input should be able to lookup pointers from HEST in guest RAM,
very crude idea could look something like this:

typedef struct hest_source_type2len{
   uint16_t type
   int len
} hest_structure_type2len

hest_structure_type2len supported_hest_sources[] = {
    /* Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure */
    {.type = 10, .len = 92},
}

uint64_t find_error_source(src_id) {
    uint32_t struct_offset = hest_header_size;
    uint16_t type, id
    do {
       addr = ags->hest_addr_le + struct_offset
 
       cpu_physical_memory_read(addr, &id)
       if (src_id == id)
         return addr

       cpu_physical_memory_read(addr, &type)
       struct_offset ++= get_len_from_supported_hest_sources(type)
    while(struct_offset < hest_len)
    assert if not found
}

unit64_t get_error_status_block_addr(src_id) {
   struct_addr = find_error_source(src_id) 
   hest_err_block_addr =   struct_addr + GHES_ERR_ST_ADDR_OFFSET
   // read intermediate pointer to status block addr pointer in hw table
   cpu_physical_memory_read(hest_err_block_addr, &error_block_addr)
   // read actual pointer to status block
   cpu_physical_memory_read(error_block_addr, &error_status_block_addr)
   return error_status_block_addr
}
 
ditto for read_ack modulo indirection that we have for error_status_block_addr

This way we can easily map source id to error status block
and find needed addresses using pointer info from guest RAM
without fragile pointer math and assumptions which might go wrong
when new error sources are added and regardless of the order they
are being added.

> +    /* Check if BIOS addr pointers were properly generated */
> +
> +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
> +    hest_read_ack_start_addr = err_source_struct + GHES_ACK_OFFSET;
> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(error_block_addr, &cper_addr_2,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(hest_read_ack_start_addr, &read_ack_start_addr_2,
> +			     sizeof(read_ack_start_addr_2));
> +
> +    assert(cper_addr == cper_addr_2);
> +    assert(read_ack_start_addr == read_ack_start_addr_2);
> +
> +    /* Update ACK offset to notify about a new error */
> +
>      cpu_physical_memory_read(read_ack_start_addr,
>                               &read_ack, sizeof(uint64_t));
>  


