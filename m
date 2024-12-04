Return-Path: <linux-kernel+bounces-431654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA449E3FEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AD11653F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B427A20C495;
	Wed,  4 Dec 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/XRXq1C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E415B10D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330539; cv=none; b=AOZGendCq7/IiFo0O+dfdRzMTkVMtrZfpyV/fz/C8aUZ8m1P+PiCQKZPZ4Wt36GJlaByxGpFcFVt5ryjza944w4JOuhR78RYqWt2mrIWEMPQ1lwTAnvwaJbTbEPOjzqJxfvbM565gKfZbh2t0f9SFF5a7x/uDPPosGPtWg0N2IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330539; c=relaxed/simple;
	bh=vZmSb4Y+KcJLAiE3V0encVzpxcWrsvCZOGlqtPSrsXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJGFLMbzteAZ4AKo8brM2apDXrcfUiN2FtjkqvsddHsiCNybzybgeiKtgoQI0fhx7fj40LM0np/mteuDJfK5baqvRvLatlL/Kgeob0GeVthEjpkzbW2k2hxW1vbfTT7tNkJovnVFDY45t1+iAKnLPSel6/N0qMl7YE25nTecfXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/XRXq1C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733330536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTboGuxBsv1/D7jYDtP1EAK+nV/89N3aSEIGaAgBjps=;
	b=K/XRXq1CEW7VoqhFknXXzL5h7ow1yTOsw9q47I5xrmO1vZj9dsWcvJZes1F8EwT++219At
	Ox5m98ntQl3HfqF1Jw+NuzKVvLanASCt15rsWYIfMBpCagz9tk53wuOvy5ekiDxmmQByIB
	0yspIOkYe1x+SWgzfUlnr8kYQF44qT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-IH1SD8uMNXOwEaXg2NXZow-1; Wed, 04 Dec 2024 11:42:15 -0500
X-MC-Unique: IH1SD8uMNXOwEaXg2NXZow-1
X-Mimecast-MFC-AGG-ID: IH1SD8uMNXOwEaXg2NXZow
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a37a57dfso45705e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330534; x=1733935334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTboGuxBsv1/D7jYDtP1EAK+nV/89N3aSEIGaAgBjps=;
        b=nFImoYXq3e1NKj/zuEq1Z0caQgrHKHNVzgBvt6Jxj2kb3dm5gIh6Bqpv5erXt7bCwU
         ydd2ee1amihufdrvB1lUzMbLHVzYV+xuokSnsWg94rfgkE+AAfAxPf/fiWDNPbhCob/S
         W0kmsCmHrB36Bvl4zW2Drgo67fPZ+gRU/0sW2aIYGAg0T3PQX052DY02kbkS+hY6va+L
         PXj/IKlGESM7I5EPsG9j7Bd9p7PCNr5ZROq/2xYlIrZrW/hQN/bTJPwW2mwTTHh5SnRO
         TDXnRkU0vzB76aAf2bSdOPjRWljk74yGUXwQ1pU6ddUNZgW/ie9B+oMxjDM3fA++a1TN
         j/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYAy7Ajl+zIUGpjX39f0SHSYbTMQqqa1TAs4SBEbswtMxMr4xBkv55huCceJpstbDZ4gKowNiTxJlZVg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPtBnRQ698zPi+ABO8Aj70lqqu2BBKbT+1i5UWOMLXHB+hDU+i
	pq6P116I6YkQdARbTu7t53Tf/Ax8G2Iw2uHlR9DRlYqpBO4Q7bPiD7IMEID1pRInSo6vHKBRK2g
	4sA/cQEFfKSC+u9M+JOkC8QXtb095h19yASkwG57rtx3QiX9q1CMg3tAEJVA71w==
X-Gm-Gg: ASbGnctQodlujxc8bz5X3Q2No+8Pi2bRmFC0ZPE18IACa4cOtJy8qf1Yf5RVETVDNMX
	FrHFtyXS/mDiPlS3aBBu1VrxxznJwH5UmOc+qjaA4cRIUBqmUh4nouT4IinRb+1tPhsSGp5E8M5
	xLgdZsZtuukStyufLaWSwW8QWk0SLzX9ZB2BYEOdUTtK49sgYE4g2j44WFZi+nn5OOlgBQVlGJv
	++03LWa8OksW2e7ZgOQyZ173GP/x39AQ1cxljd6DkfYNCg1JbUh/v5DxK2H9ro7dLz0AVelT0GZ
	OABOPqsJCFqynyyUvL6JNA==
X-Received: by 2002:a05:600c:3c9b:b0:434:a706:c0f0 with SMTP id 5b1f17b1804b1-434d09b5fbdmr65866625e9.14.1733330534037;
        Wed, 04 Dec 2024 08:42:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3vYYe0JYqWvdtnCbpcYPrqQ5wdtxOa58ZiyFbEhfHIUG+ni9gR0oBxI2tXG6+uCSAb9oHLw==
X-Received: by 2002:a05:600c:3c9b:b0:434:a706:c0f0 with SMTP id 5b1f17b1804b1-434d09b5fbdmr65866395e9.14.1733330533682;
        Wed, 04 Dec 2024 08:42:13 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd5asm29512655e9.40.2024.12.04.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:42:13 -0800 (PST)
Date: Wed, 4 Dec 2024 17:42:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 14/16] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241204174212.4c6558aa@imammedo.users.ipa.redhat.com>
In-Reply-To: <5a2bda4722e2d45839a75f3a193f6b8f4841c773.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
	<5a2bda4722e2d45839a75f3a193f6b8f4841c773.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Dec 2024 08:41:22 +0100
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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 90d76b9c2d8c..a4453ee357bc 100644
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
>      uint64_t start_addr;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> @@ -389,18 +416,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>  
>      start_addr += source_id * sizeof(uint64_t);
>  
> -    cpu_physical_memory_read(start_addr, &error_block_addr,
> -                             sizeof(error_block_addr));
> +    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
>  
> -    error_block_addr = le64_to_cpu(error_block_addr);
> -    if (!error_block_addr) {
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
> @@ -421,7 +443,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>          &read_ack_register, sizeof(uint64_t));
>  
>      /* Write the generic error data entry into guest memory */
> -    cpu_physical_memory_write(error_block_addr, cper, len);
> +    cpu_physical_memory_write(cper_addr, cper, len);
>  
>      return;
>  }


