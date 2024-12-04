Return-Path: <linux-kernel+bounces-431647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01D89E3FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6022A2824B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA09120CCDE;
	Wed,  4 Dec 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QelsXKaS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04320D4F8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330432; cv=none; b=oniGsT031U7VmTyxcvPgdwezxH2gxcXFNkSEcJzdHHJkzLvLkgjwe14jDpY/GZwkqc+nAy4sRygX6AK1m5imzVfq9S/IqrY5yjEWT4K+KX1NEuqw9uBNlclCv4kGxCmhCUgUID2/L3lyS4XaYeySr8VDLn2KTWmdQoEVCM8MM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330432; c=relaxed/simple;
	bh=E07o7SrVn6fMgHQ2ye3xvGGrM1Xm8Ed0AWBR9iBbFuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTZK+FVoCK48eJs2PUIl4HULtd8qFOqZsffeEQq2UMoB4U/oBJDEsTkybBarZLpm1PaNVg3YtPhncP7C82z5JyyP1/d3IOdTASE9R8MEkN1HbavVt6glp4Nssv0Ox3VgzVrFDAzg6rBeHVpUywHeqsuCByGhnNkohVObCVipvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QelsXKaS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733330429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEeC3RYjo0ryc9cx1hBsYweGmp9PRkMA7aFXlYOXkWM=;
	b=QelsXKaS6XX7se4l1KQo73xSWxnez2d7LhuAXJp4VCxeubakZFlN7pTXVh1mxMvT3i3bQk
	qjdahc3NOZv3lMl6YQzR7LLHnPZi+uZb3E1qmPheABbGiVLyG4sDzK9YoX+dOHS3UyL3N5
	inCwDyeQoRy2/GW69N1aPuB3+Agff1o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-g51OzRKFP16gNXr4gDpw6g-1; Wed, 04 Dec 2024 11:40:28 -0500
X-MC-Unique: g51OzRKFP16gNXr4gDpw6g-1
X-Mimecast-MFC-AGG-ID: g51OzRKFP16gNXr4gDpw6g
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4349e08ae91so33005e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330427; x=1733935227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEeC3RYjo0ryc9cx1hBsYweGmp9PRkMA7aFXlYOXkWM=;
        b=kmxEKD36G2gNF3CGPfQ/T2g84cDvr1fPxkjreYU0wDtW662QeFFEQa828muvVpouyw
         xzHp2yCPA159uOOfOlzMxOH/iC5dceQsl2c8e2aHbnDUVBBbF8xNAip+xvOmzgC4Z4Gb
         jT9XVKispVlt0+9V1VaNxKrxTs/SrtODUw+LHb+MrBH2KZ31eE9IuRaZ42BW5d3uXyH3
         Ol3OXPSrgA4A9OPk8UohchaXjgXsyp2rbxuHK8zDnqhjcRN0ycRgPxR7a9DgLNDrH3Yr
         VbABGnFaVGZV2kt967wQXZ21Mvtb/Xo2ypBHdpcJbdeCZ7NFY4uLvtKFm7usOD8h7slX
         Lubw==
X-Forwarded-Encrypted: i=1; AJvYcCUlZzZlMAgT/EV6vaAjMYr28W4frt4PZKZfDrLKlX6bqFS2LjAN6u90p/3mNXqCS2S3K7RnASlyvWWX/nI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6wapelcGrieayzK8dqTMfH2p5Sp96LDIADqIUIIXNMXaLPCqS
	BE+3Bf9FFmA9ZhBVCGl8DgoUGDE1P0cy9oGPNEt2bC+QYjn2ak9zF8ogFVqzlHyFsLUPDAx6KIa
	51ubr8qj2kLnG+yyXX3M1Rn9QbzTVu4i8LW43uCdytwRa8JJvkPn8TTDJemgfgg==
X-Gm-Gg: ASbGncs5AH9le+pO+zLDTOieHRQ8G71eIMGqsVZyl+jkH9vbytQjoIkze/XixqPSW8V
	4jK1fUMcCO30cK72dJ19WSXPNs1+nI63klI2mBLU95DgSqjXqOkD20057GdCE0I/JYAjpF3ZgjR
	OBD1BBR0fCktB/70p2OOVq0EWYym3L6bbxGL/73retnTNCwlbz9p7svKieCY3l34MT/mpZogcGR
	rUBtlVsLNr4bzPON2oD4MAb3HjXgF3k13bpymmaYC01BklWCNVwKmKjN0KTFUORrfH8ycUa1/U6
	VHmdCMC/VCGy4xp3KVd2Lw==
X-Received: by 2002:a05:600c:35cf:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-434d0a07e76mr56634735e9.20.1733330426905;
        Wed, 04 Dec 2024 08:40:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlmQvivINODRz0LjSbG3GHEmn9Krx7Hqgr3pzwsWlsNg+E/WUPCGldC0NDYZMcYKm+/x0RRg==
X-Received: by 2002:a05:600c:35cf:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-434d0a07e76mr56634495e9.20.1733330426521;
        Wed, 04 Dec 2024 08:40:26 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd42sm29861995e9.38.2024.12.04.08.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:40:26 -0800 (PST)
Date: Wed, 4 Dec 2024 17:40:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5 10/16] acpi/ghes: better name GHES memory error
 function
Message-ID: <20241204174025.52e3756a@imammedo.users.ipa.redhat.com>
In-Reply-To: <1f16080ef9848dacb207ffdbb2716b1c928d8fad.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
	<1f16080ef9848dacb207ffdbb2716b1c928d8fad.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Dec 2024 08:41:18 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current function used to generate GHES data is specific for
> memory errors. Give a better name for it, as we now have a generic
> function as well.
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

not that it matters but for FYI
Sign off of author goes 1st and then after it other tags
that were added later

> ---
>  hw/acpi/ghes-stub.c    | 2 +-
>  hw/acpi/ghes.c         | 2 +-
>  include/hw/acpi/ghes.h | 4 ++--
>  target/arm/kvm.c       | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index 2b64cbd2819a..7cec1812dad9 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 4b5332f8c667..414a4a1ee00e 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -415,7 +415,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      return;
>  }
>  
> -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 8859346af51a..21666a4bcc8b 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -74,15 +74,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> +int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
> -int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present
>   *
>   * Returns: true if the system has an ACPI GHES table and it is
> - * safe to call acpi_ghes_record_errors() to record a memory error.
> + * safe to call acpi_ghes_memory_errors() to record a memory error.
>   */
>  bool acpi_ghes_present(void);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 7b6812c0de2e..b4260467f8b9 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2387,7 +2387,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               */
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
> +                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
>                      kvm_inject_arm_sea(c);
>                  } else {
>                      error_report("failed to record the error");


