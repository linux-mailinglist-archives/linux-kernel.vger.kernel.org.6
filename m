Return-Path: <linux-kernel+bounces-534255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2269A464CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597A44215C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22092309B9;
	Wed, 26 Feb 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbcNsXOL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9549227BA4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583632; cv=none; b=tAe9xXQH0JzFSM/I6xhNwUuOoiukGjeuC4yYV7gBLsQsQxOyrAwxs+ESGbr/NVWu0jjUQ2yB5gZeU2gmnkvmJDkq2itahyJ1npcRnzBb432Qv0Hsfoub8A6YrEzpM1Gh+vaRVOvCbLa5/O5FHfTCEoSq5GZ3VU9gIfnpz5VbuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583632; c=relaxed/simple;
	bh=T4Baa59RSsii1/+I1kF4FXFme9v/EnqNMR7oY5tvLz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQgH3j2ayYYnsCiz2VMXLFnV5VRtqseU6CMlH6QMyBqawIf2vLom3npuXilbr7tVvRjraSsLzWLqaF5krlJV10asZ+OAanAJ1uLfO7MsmHmxe3K9UylDjoi/grPMtt2mRhJvf9c3fgBQng1oGbaSfNT4sarOcFnWvarmiEyIUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbcNsXOL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740583629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opCox9KVcehhy1NQGp4HS1lXiyGpPcoip0UbMOR0ICE=;
	b=JbcNsXOLL0jO4NG6ryd3uRLjVGE7J78Xb1w0U/xYAAwsbhehsZDspedfr1j6ukA/0vW3/4
	L1W7Ktd8pWYGugcsNCgsr//uBZ2FQfIVmcaaIcYlvNpxH70R2zkQzZk7Jb+O6zJzO2a5Fb
	XhlLIjZaL1bL71ifSYa9p9cfFjdMCTA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-bZ2VoH86O2Ku7PGseltwTw-1; Wed, 26 Feb 2025 10:27:08 -0500
X-MC-Unique: bZ2VoH86O2Ku7PGseltwTw-1
X-Mimecast-MFC-AGG-ID: bZ2VoH86O2Ku7PGseltwTw_1740583627
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f31e96292so4372842f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583627; x=1741188427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opCox9KVcehhy1NQGp4HS1lXiyGpPcoip0UbMOR0ICE=;
        b=ubgyM5n1xX6bRndJJl/4Fq0kGeq2HQ1TJZzNC0DRpRqa2G2hS4LKLNcJtz4nCXyOJq
         AOFJjknB6sffjSX3hoeUB1H23/OS8ask2yWI6MBGNYoX9H3hyqMbBuflYqGYr9WY/dEE
         E8+ebQidb4aCgHSvJDT/ICFJIpAx3mU0vyOZ23234C+2rhZEcaiL8kl8WJ4qGCcXwIZ+
         +gSKU3FTONLW6VEFSd5dfaAs3rMlXUt231Haz4wbUe95TKpvp6qLfkXqO7cDcOSwbjaW
         xZX+zTDiPfZacRtGxqq1AYmYu3T1GBjt+KtMBQzaTpOOledTSQYaXzpP8+lgl/Pp22CP
         5yGA==
X-Forwarded-Encrypted: i=1; AJvYcCXM/+JGCkwqICKyHiicyan9+RCpYdMHN9ogdC29sx/lcniTjOGgJcg+F6OYr4qy83Jir9FIUL0D7zKI+s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPdV+P7JVZhiLqOhF0iDSx5e0V+8VPgh5+OczoCeG9swCGuaF
	wND0V4SBYoOo4vzZHtNnPwahz7jCwg0T8630RAvP8fJiONXM1h87U0aYJf9I8wMPV+NyScrswDc
	iy1sd+bT/z10htpSRrV8pFVgHqRg66FZ2uiu8yfJiviDSroAoRyTj1bDRtIuDtw==
X-Gm-Gg: ASbGncsda9Lmdl0Pq09aQa+J1P9e0zgHmNo5jBc+Mi+IYaiw6SiSUdeX3u4QQ2FxDsZ
	rnDE4/hu4OYbgfRNkTiChoQx/z3Cej3fhmc3NTXl9fX9RBhNrmkgX5E7+KcN7E6wAh8+1R35vWf
	CF7RgreZnWNyEtA0EpcBg4MPe2Q0zvMJyBbw32MOoDJfOtCAz2P2ftFdgctIgE5PEEuIR4AMkQr
	nfj6ibFcznANzboNAMkKlGhzDJg3zAFiwvfmKUxKZDRC+HgnPFBxukmAElavAR89CqHISsSb1De
	OA9Ppa/HroNPBFGkX4M2NGEzE/p8ha93Z3rsKfSUygXqeaKLw8jWU7Mclg2AKD8=
X-Received: by 2002:a5d:5887:0:b0:38f:355b:141e with SMTP id ffacd0b85a97d-390d4f378ebmr3452617f8f.3.1740583626899;
        Wed, 26 Feb 2025 07:27:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1DwZYHHCSs8+Mdqpg+KX0YNs2WqUN7TodnTaxIGwwctMTc50nKGidchiWQV2RbC4q0fkVAw==
X-Received: by 2002:a5d:5887:0:b0:38f:355b:141e with SMTP id ffacd0b85a97d-390d4f378ebmr3452587f8f.3.1740583626458;
        Wed, 26 Feb 2025 07:27:06 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882a64sm5769008f8f.46.2025.02.26.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:27:05 -0800 (PST)
Date: Wed, 26 Feb 2025 16:27:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/14] acpi/ghes: create an ancillary
 acpi_ghes_get_state() function
Message-ID: <20250226162705.67875661@imammedo.users.ipa.redhat.com>
In-Reply-To: <2288cfe02f8cfec4b35759fd748366c885018b59.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<2288cfe02f8cfec4b35759fd748366c885018b59.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:35:15 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Instead of having a function to check if ACPI is enabled
> (acpi_ghes_present), change its logic to be more generic,
> returing a pointed to AcpiGhesState.
> 
> Such change allows cleanup the ghes GED state code, avoiding
> to read it multiple times, and simplifying the code.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by:  Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes-stub.c    |  7 ++++---
>  hw/acpi/ghes.c         | 38 ++++++++++----------------------------
>  include/hw/acpi/ghes.h | 14 ++++++++------
>  target/arm/kvm.c       |  7 +++++--
>  4 files changed, 27 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index 7cec1812dad9..40f660c246fe 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,12 +11,13 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                            uint64_t physical_address)
>  {
>      return -1;
>  }
>  
> -bool acpi_ghes_present(void)
> +AcpiGhesState *acpi_ghes_get_state(void)
>  {
> -    return false;
> +    return NULL;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index f2d1cc7369f4..401789259f60 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -425,10 +425,6 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>                                   uint64_t *cper_addr,
>                                   uint64_t *read_ack_register_addr)
>  {
> -    if (!ghes_addr) {
> -        return;
> -    }
> -
>      /*
>       * non-HEST version supports only one source, so no need to change
>       * the start offset based on the source ID. Also, we can't validate
> @@ -517,27 +513,16 @@ static void get_ghes_source_offsets(uint16_t source_id,
>  NotifierList acpi_generic_error_notifiers =
>      NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
>  
> -void ghes_record_cper_errors(const void *cper, size_t len,
> +void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
>      uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
> -    AcpiGedState *acpi_ged_state;
> -    AcpiGhesState *ags;
>  
>      if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
>          error_setg(errp, "GHES CPER record is too big: %zd", len);
>          return;
>      }
>  
> -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> -                                                       NULL));
> -    if (!acpi_ged_state) {
> -        error_setg(errp, "Can't find ACPI_GED object");
> -        return;
> -    }
> -    ags = &acpi_ged_state->ghes_state;
> -
> -
>      if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
> @@ -546,11 +531,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>                                  &cper_addr, &read_ack_register_addr, errp);
>      }
>  
> -    if (!cper_addr) {
> -        error_setg(errp, "can not find Generic Error Status Block");
> -        return;
> -    }
> -
>      cpu_physical_memory_read(read_ack_register_addr,
>                               &read_ack_register, sizeof(read_ack_register));
>  
> @@ -576,7 +556,8 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      notifier_list_notify(&acpi_generic_error_notifiers, NULL);
>  }
>  
> -int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                            uint64_t physical_address)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
> @@ -602,7 +583,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>      acpi_ghes_build_append_mem_cper(block, physical_address);
>  
>      /* Report the error */
> -    ghes_record_cper_errors(block->data, block->len, source_id, &errp);
> +    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
>  
>      g_array_free(block, true);
>  
> @@ -614,7 +595,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>      return 0;
>  }
>  
> -bool acpi_ghes_present(void)
> +AcpiGhesState *acpi_ghes_get_state(void)
>  {
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> @@ -623,11 +604,12 @@ bool acpi_ghes_present(void)
>                                                         NULL));
>  
>      if (!acpi_ged_state) {
> -        return false;
> +        return NULL;
>      }
>      ags = &acpi_ged_state->ghes_state;
> -    if (!ags->hw_error_le && !ags->hest_addr_le)
> -        return false;
>  
> -    return true;
> +    if (!ags->hw_error_le && !ags->hest_addr_le) {
> +        return NULL;
> +    }
> +    return ags;
>  }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 219aa7ab4fe0..276f9dc076d9 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -99,15 +99,17 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
> -void ghes_record_cper_errors(const void *cper, size_t len,
> +int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                            uint64_t error_physical_addr);
> +void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
>  
>  /**
> - * acpi_ghes_present: Report whether ACPI GHES table is present
> + * acpi_ghes_get_state: Get a pointer for ACPI ghes state
>   *
> - * Returns: true if the system has an ACPI GHES table and it is
> - * safe to call acpi_ghes_memory_errors() to record a memory error.
> + * Returns: a pointer to ghes state if the system has an ACPI GHES table,
> + * it is enabled and it is safe to call acpi_ghes_memory_errors() to record
      ^^^^^^^^^^^^^ can't link 'it' with anything, I'd drop this

> + * a memory error. Returns false, otherwise.
                              ^^^ NULL ??

>   */
> -bool acpi_ghes_present(void);
> +AcpiGhesState *acpi_ghes_get_state(void);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index da30bdbb2349..80ca7779797b 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2366,10 +2366,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>  {
>      ram_addr_t ram_addr;
>      hwaddr paddr;
> +    AcpiGhesState *ags;
>  
>      assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>  
> -    if (acpi_ghes_present() && addr) {
> +    ags = acpi_ghes_get_state();
> +    if (ags && addr) {
>          ram_addr = qemu_ram_addr_from_host(addr);
>          if (ram_addr != RAM_ADDR_INVALID &&
>              kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> @@ -2387,7 +2389,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               */
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
> +                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SEA,
> +                                             paddr)) {
>                      kvm_inject_arm_sea(c);
>                  } else {
>                      error_report("failed to record the error");


