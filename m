Return-Path: <linux-kernel+bounces-292110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C4956B38
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB42F1C21C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C2716B732;
	Mon, 19 Aug 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLzdRlZi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92216849F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071904; cv=none; b=rRwXT3gfXJus2mTScTaGrFJLzrQVsrX03mT9DjMQOzDhBb6JeKpDQb0SDCwNhTDe2NuIGinBCSJFQwrfS7msj7YuFeP5GYSftONa+m4NLAuuK4at0a1SV1+6Fj2Uw2fXAE6lNBaikt54QbpPTl2Ljhjv7cxv3GIzkbnYqVJz8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071904; c=relaxed/simple;
	bh=Tp60tvpmXwimkntneg2cYy+EyA+zEdByTTCcBNV0cc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuaLK1c9gVOcVYZIZYA/7uzY4/oghJ64kqC9FQztXyJGreopjgA/XFrtO+2jpTIa5zlsK2ux7B24EFUZ3li6HW8989M2tac/nPXuAfkkDYzBz6QbnZlRLt/CNFQd/15J1fuAJOQb+Dq0c5Hr2NPHCUkzlmFYQB0Dye/xbOgkLtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLzdRlZi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724071901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=by+QCFBT6MiEPhb9gf96i+Wtei4ibVP3WzqXMkTBrlg=;
	b=XLzdRlZi9DCwD9/uYOnLJnZMGK/ZjXbIsz00HChi1YyBN4WsurzYo6chmbeDxE3lnPYL7B
	kJUOX9iL24emjjjbOWmELAqSNmo4vOna04qtoFo4qXnz24WkSi9XL2rokXu7tQ5Zc0lprG
	4fvBX1aWZeSPZ6LJfI/P8OWje8NdtH8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-S5sW4amVOSKHk7FpkiSAsw-1; Mon, 19 Aug 2024 08:51:40 -0400
X-MC-Unique: S5sW4amVOSKHk7FpkiSAsw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37193ed09b2so1700329f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071899; x=1724676699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by+QCFBT6MiEPhb9gf96i+Wtei4ibVP3WzqXMkTBrlg=;
        b=TyShTrE/q4pxAcAxVMQOYtyZwGuIL7nzOu2awDXOcqGBAogJ4/WnzwdFZEwxZhu8Oc
         PCnWKiki3xFayjF2fNX4iBpmbc0qkaDgpEK/XKNIkTcLV3jAx4OkKIxh1GG7Hb/c3cC+
         snoiPYQ9rSYon0p4yawgSQUijZeMyvHzIUokzh10//YGWQ4zCAg+GD65aClsW/gkQ41S
         sOGjQE7kky2qSU/VUZ+Eh077OrfOXADckO2/DFWphqqwnjm+1UIox/7Z5raN0+lxqdni
         9Y6OtokPognCm9FEYrdPVF5FbNqhmfR9liX24VKZU903g2xbi1MjlLFuj25aRpvWRY79
         q5+A==
X-Forwarded-Encrypted: i=1; AJvYcCV1/9038aQ8a8CmCr8K7NmWZUjnXupAf1NJvFHUkKjgdIXyf/mmxPvST74LafzyTQOI63wZxj5MtGbL+chJPOSbsmTikHMUUePLjn5O
X-Gm-Message-State: AOJu0YymvkOPOYdPzECMn8L5GsfHg5eqxoT+FNbfEwUea+FwbdPAxZDh
	BwOXI494TpP0+74ZWnu+gqSaFrVDtg9TmY5PCccMfO0tldXRtZKfr12+pcBKcezO/3HZPbPJQ6L
	+MG+RZiT+OfHxsRZNKcstp+9ikba6mMDP8iJ+AHAPjBSjAtXAvPSOw31M7kY+Qw==
X-Received: by 2002:a05:600c:a4f:b0:426:67f9:a7d8 with SMTP id 5b1f17b1804b1-429ed9f844fmr70111975e9.9.1724071898914;
        Mon, 19 Aug 2024 05:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu5dMeM3vuzUh+X/YtAM1Q3TDvVYo3c4xih2tjIAfoIXlYmZsj5lFA5CHrpBFR2sximZ4f7w==
X-Received: by 2002:a05:600c:a4f:b0:426:67f9:a7d8 with SMTP id 5b1f17b1804b1-429ed9f844fmr70111795e9.9.1724071898403;
        Mon, 19 Aug 2024 05:51:38 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed65072asm108393795e9.13.2024.08.19.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:51:37 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:51:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
In-Reply-To: <2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 09:37:38 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Provide a generic interface for error injection via GHESv2.
> 
> This patch is co-authored:
>     - original ghes logic to inject a simple ARM record by Shiju Jose;
>     - generic logic to handle block addresses by Jonathan Cameron;
>     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> 
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/ghes_cper.c |  2 +-
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 7870f51e2a9e..a3ae710dcf81 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -500,6 +500,63 @@ int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
>  NotifierList acpi_generic_error_notifiers =
>      NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
>  
> +void ghes_record_cper_errors(uint8_t *cper, size_t len,
> +                             enum AcpiGhesNotifyType notify, Error **errp)
> +{
> +    uint64_t cper_addr, read_ack_start_addr;
> +    enum AcpiHestSourceId source;
> +    AcpiGedState *acpi_ged_state;
> +    AcpiGhesState *ags;
> +    uint64_t read_ack;
> +
> +    if (ghes_notify_to_source_id(notify, &source)) {
> +        error_setg(errp,
> +                   "GHES: Invalid error block/ack address(es) for notify %d",
> +                   notify);
> +        return;
> +    }
> +
> +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +    g_assert(acpi_ged_state);
> +    ags = &acpi_ged_state->ghes_state;
> +
> +    cper_addr = le64_to_cpu(ags->ghes_addr_le);
       ^^^ suggest to rename to error_block_address
       that way reader can easily match it with spec.

> +    cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
and it would be better to merge this with previous line to be more clear
 + to avoid shifting meaning of variable between lines.

> +    read_ack_start_addr = cper_addr + source * sizeof(uint64_t);

> +    cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
> +    cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
I'd avoid changing meaning of variable, it adds up to confusion.
Anyway, what the point of of above math?  

> +
> +    cpu_physical_memory_read(read_ack_start_addr,
> +                             &read_ack, sizeof(uint64_t));
s/sizeof(uint64_t)/sizeof(read_ack)/
ditto elsewhere

> +
> +    /* zero means OSPM does not acknowledge the error */
> +    if (!read_ack) {
> +        error_setg(errp,
> +                   "Last CPER record was not acknowledged yet");

> +        read_ack = 1;
> +        cpu_physical_memory_write(read_ack_start_addr,
> +                                  &read_ack, (uint64_t));
we don't do this for SEV so, why are you setting it to 1 here?


> +        return;
> +    }
> +
> +    read_ack = cpu_to_le64(0);
> +    cpu_physical_memory_write(read_ack_start_addr,
> +                              &read_ack, sizeof(uint64_t));
> +
> +    /* Build CPER record */
> +
> +    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> +        error_setg(errp, "GHES CPER record is too big: %ld", len);
> +    }
move check at start of function?

> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(cper_addr, cper, len);
> +
> +    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
> +}
> +
>  bool acpi_ghes_present(void)
>  {
>      AcpiGedState *acpi_ged_state;
> diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> index 92ca84d738de..2328dbff7012 100644
> --- a/hw/acpi/ghes_cper.c
> +++ b/hw/acpi/ghes_cper.c
> @@ -29,5 +29,5 @@ void qmp_ghes_cper(const char *qmp_cper,
>          return;
>      }
>  
> -    /* TODO: call a function at ghes */
> +    ghes_record_cper_errors(cper, len, ACPI_GHES_NOTIFY_GPIO, errp);
>  }


