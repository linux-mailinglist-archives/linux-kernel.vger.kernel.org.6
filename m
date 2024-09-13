Return-Path: <linux-kernel+bounces-328264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153FD978131
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB7B1C23B47
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11771D79BE;
	Fri, 13 Sep 2024 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c77EADZ1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C71DB526
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234268; cv=none; b=k/Bw3aoLXJVa8HK9BLzab2i6VUoUc33dvdMF89Un4tkBmn3utwyWOnNPBFbqwhkkaVUN8xLi0yLE72L7HqcfxTzhAK3PFDeq9e5V1jyi+MpD0Qgy3v6UJ3FSOEXIdXYvOY0NMJe1ZTu35yjALOCaSrL/DyIXIsjwEOHIoIqZmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234268; c=relaxed/simple;
	bh=Jlqrp0RDfQwh4Nv3p7BufZvHUg4iG9y1AGqkD2XkFNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGI78CD6fcgm6GW3ebFO2QLbbzWPZ5oAdv0MKREUK08uM/gFt1+sorpqVNQ7BUh18he2rlO+eV6SeFjqzTb+DBLjngyarhihxFceFZcytHqcl5DBx8YpmApVIDHXHISti3mxr8fsLK7LrSVlsxoWsFjF7usBt893NBVBLlVA5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c77EADZ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726234265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvGBItUkDfqFh1oLJWbFeeOAiWJ5xgJuYz7EKc9ObyY=;
	b=c77EADZ16iy9tEDp7jsojuqjw5vbKIpnHs/uQ+XZfujSLPBj14mnOR8LdJynJmhgf7kcfH
	bKNtw1TfndhSYQq3rM2eOXN6Sp5cgSHzANi7sGVGuVVTj4QnEoOVUbIxqYo5hXrZdKbLmb
	WYtFX5R0XuDfct6rtQ2p8i4zp7o+Vhk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246--JJnHO4HNkuOgwZVt0SbaQ-1; Fri, 13 Sep 2024 09:31:03 -0400
X-MC-Unique: -JJnHO4HNkuOgwZVt0SbaQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374bb1e931cso1659007f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726234262; x=1726839062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvGBItUkDfqFh1oLJWbFeeOAiWJ5xgJuYz7EKc9ObyY=;
        b=HhxWQazd/2fwtDhS1pZAkEcVxROvVimLhBZvvRrd6o+BStZWTo0y1NIbt8a+yDRRiD
         92s1kfr/AGe3a5TtQrqL2gs+3SbnC+ZhFjy1eKFXO+l0GBmKQKoPRRCAqSkL2Gmerrkf
         9NRvsHU3MiXII6O5ciWpLQpVar52A22ZUHKiXtDVUE4LhiK7ngzpk3HJLodQpOItVkl2
         ESDuaun0zHy/QCnlx9V7LL+U+4IVh6yAQB0jmVX/ExIVennhPP7ttlqw1DOjSOzKTlOD
         CUVMeHijCkXP66nOmwxLpe5trVdTz2R/fENMBjAguxEb99clf2cOGnEWr1e4dD9UZvRs
         +b/A==
X-Forwarded-Encrypted: i=1; AJvYcCVjS1R5j5ifl3+5jt4Jyb6jIY6dm/4pW3ATAGH30IWjycqaL41Avpmf262/nWqOeqFlZJIN1UefiWVNaKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3KJksHnrQCnudYIhrcNG6Hhwu/0LL9A8ILgADIjeO2enMdqAn
	f04Tjr8F7f5lEjpZ24xU8bcZWfRjgYeLf4MBZn7R2j34rqkNeQsGEicFwVGaOxOOhEH4Ei1Q1W4
	N5GkcroN6blEBSR2ptZ1wJsyzhIvU9py8CPIS15MG4vujYe1swdjBpU09qnRvUw==
X-Received: by 2002:adf:b342:0:b0:374:c79d:5f7e with SMTP id ffacd0b85a97d-378a8a9c10fmr8178231f8f.26.1726234262211;
        Fri, 13 Sep 2024 06:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERXa2lMjmAwq4vQT2K5EePIHr0LVLSu9sZkY1lZNKoaVRfj2Z4+KZyop89HsTwxVpI7RpYpA==
X-Received: by 2002:adf:b342:0:b0:374:c79d:5f7e with SMTP id ffacd0b85a97d-378a8a9c10fmr8178193f8f.26.1726234261379;
        Fri, 13 Sep 2024 06:31:01 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05c984sm26274465e9.11.2024.09.13.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:31:00 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:31:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 04/12] acpi/ghes: better name GHES memory error
 function
Message-ID: <20240913153100.275ce41c@imammedo.users.ipa.redhat.com>
In-Reply-To: <ceb8b8f3537cf9f125fbdc86659bae25fdb34e3b.1724556967.git.mchehab+huawei@kernel.org>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
	<ceb8b8f3537cf9f125fbdc86659bae25fdb34e3b.1724556967.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Aug 2024 05:45:59 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current function used to generate GHES data is specific for
> memory errors. Give a better name for it, as we now have a generic
> function as well.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes-stub.c    | 2 +-
>  hw/acpi/ghes.c         | 2 +-
>  include/hw/acpi/ghes.h | 4 ++--
>  target/arm/kvm.c       | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index c315de1802d6..dd41b3fd91df 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(uint8_t source_id, uint64_t physical_address)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 3190eb954de4..10ed9c0614ff 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -494,7 +494,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      cpu_physical_memory_write(cper_addr, cper, len);
>  }
>  
> -int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(int source_id, uint64_t physical_address)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 4b5af86ec077..be53b7c53c91 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -70,7 +70,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(int source_id,
> +int acpi_ghes_memory_errors(int source_id,
>                              uint64_t error_physical_addr);
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
> @@ -79,7 +79,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>   * acpi_ghes_present: Report whether ACPI GHES table is present
>   *
>   * Returns: true if the system has an ACPI GHES table and it is
> - * safe to call acpi_ghes_record_errors() to record a memory error.
> + * safe to call acpi_ghes_memory_errors() to record a memory error.
>   */
>  bool acpi_ghes_present(void);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 8c4c8263b85a..8e63e9a59a5e 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2373,7 +2373,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               */
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_record_errors(ARM_ACPI_HEST_SRC_ID_SEA,
> +                if (!acpi_ghes_memory_errors(ARM_ACPI_HEST_SRC_ID_SEA,
>                                               paddr)) {
>                      kvm_inject_arm_sea(c);
>                  } else {


