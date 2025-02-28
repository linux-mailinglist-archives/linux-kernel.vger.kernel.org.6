Return-Path: <linux-kernel+bounces-538546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD73A49A10
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FEA172C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E3A26B2C8;
	Fri, 28 Feb 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+WTadtu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AF26A1CB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747511; cv=none; b=ZbZIO9hSugbRfGdiEZMGKF525Qu92cV79ffqpZNJM+66GbpL24vWGwFO2RzybJFY4PWy20NlysJeMTuwBRfGtdJym0WByAYrpFw0Wmdi4a3pf810xSWlqg9rdKX86yvPUqIYn+whG2ZDXJZGEci1z5OI0q9VbNBw8ITpBMsY+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747511; c=relaxed/simple;
	bh=GJ5n9iQrQrLbIoNU4lh0lFd7gZXNiLmGKlhe0udbur4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opYqNZ0B/SvLugowsbnS4cr3UIp90a92bc+ezPGgaCqeUzgtFag7FqzcNNdwALw4rRcqRjnTkSPLGPk92efG7tXvv9kZPABdbXKAQzpx1dXTQtcLJEBPrxZkHtx5FVvBX8s8PYxSdAjqfZAQ36RjtzA+VQ32l1oOtVilI9ZV2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+WTadtu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740747508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOdElMhER4o/+uZuYvse6PdLduLz2Bd1s6NaMonnZvg=;
	b=W+WTadtusNVhXeH8ZoaKn3EfFy3On4n1CJAl5OwMIird3g7QieQPIf1/F0oUTeHB1PyxCZ
	kgCNieuZzBwPlao73iAlGj7bmEQUz0Z3DGjaU7w2qshuV8YVzy/LfxuJQxPCk8XTYc/Xm6
	ysV1/nmeRfZD7tDFJ/tgrD5AIpj7rzE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-hGYY0uXdMreEHrpgauPjQg-1; Fri, 28 Feb 2025 07:58:27 -0500
X-MC-Unique: hGYY0uXdMreEHrpgauPjQg-1
X-Mimecast-MFC-AGG-ID: hGYY0uXdMreEHrpgauPjQg_1740747506
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4e47d0b2so927628f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747506; x=1741352306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOdElMhER4o/+uZuYvse6PdLduLz2Bd1s6NaMonnZvg=;
        b=jtExDKDChvVXk2TSZF6rOO0Zk/e/BjZiXwdV9AUJ/1/TQxG2aLF0fL2JbWi722ilb5
         LAo18YRcSzgJG4e+qugmi4Eo3cO1QtENFDTCzwh/lHIXS9dbThjZFcXmWNk70JWACV/P
         2VjMulxZofsCjqg8d5QN6bur/F93ayDykzInu8xua0l3QajkMR/ZjLffPQLjVPo9Ia0o
         OyOqV6cdVAj9LgnzKDzYqkBGAJUQkUixLzRH7nGSDBwi52w15kr8ktjKcO4FYb3uB1Dk
         GVcqduSa0JhTajkofoRNjsNyB/f1NpqnBIMc6hJ4FtjdNSmp0apw5RTC54hkw9MAEYNN
         C6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXyS/dO+lCUGJY1EtbkxhsWmxDA1aiSVWY0klrwChnRf/0E766K52uOZbTq6hP0VloARbCXBgX52YXMGyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+3UShRkeWjy0r8aZc657jO0f9ciYESpLwLb1BTX4UB3vqnUh
	6LbSAu0taxAEnsQA2PjiYqOxdlYYZ5Lhx65vLnjkp5JakWnImSPICuFlbDjwqGo11uZ5OCVI3gh
	paFLOS3y8fSVf/g/KucoFyk9LWkJs2gCAo9WZuXc6DJxTgBDSn7KZJdMvbE+wnQ==
X-Gm-Gg: ASbGncsojWsFr79nUOqlXZTOOqNyNvT+NCoE4rUdhvFMQjjlt3rLVTe8wsDglcNw4mf
	KP7OUNf1K7KSwo9eZTf1s6IN3NsgLnIxZDszvPotiPJ2OYqhb9FJb7IMdKwAkUNYjUigL9slIR1
	UnxYvEPvnMsg4hN2y3wWjunlJ5n7Z1LBSx2AMxujZnGpLDOCgIDGqd3pH+gwH7TdBs4iFXFxqXy
	nv2FKpcc8yIzT8bQmS6b9TPYwfD2gnypiT9xh04MkY2ijy50RqOZFEGb7y9s0Zp+to2nVFINfEN
	vtgPXgh5vU7qMl/2zpmfQ5V/yiskwTrkGbsLKBXChtKYmlln2jfx76QGGzSLW+c=
X-Received: by 2002:a05:6000:1fac:b0:38f:277a:4eb6 with SMTP id ffacd0b85a97d-390ec7760efmr2961127f8f.0.1740747505788;
        Fri, 28 Feb 2025 04:58:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd3CKonl5hDfbOT/izjKTluVl0Zz26NrDrbURNF+GzsPp4DmwMrCrizD5xEMyGPCPAnDe6Gg==
X-Received: by 2002:a05:6000:1fac:b0:38f:277a:4eb6 with SMTP id ffacd0b85a97d-390ec7760efmr2961109f8f.0.1740747505438;
        Fri, 28 Feb 2025 04:58:25 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965ddsm5288898f8f.18.2025.02.28.04.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:58:24 -0800 (PST)
Date: Fri, 28 Feb 2025 13:58:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/19] acpi/ghes: add a notifier to notify when error
 data is ready
Message-ID: <20250228135824.04713a97@imammedo.users.ipa.redhat.com>
In-Reply-To: <a6a2b8b68a12df8ef9018a9756b3ea95b1c84eb9.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
	<a6a2b8b68a12df8ef9018a9756b3ea95b1c84eb9.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 17:00:47 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Some error injection notify methods are async, like GPIO
> notify. Add a notifier to be used when the error record is
> ready to be sent to the guest OS.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c         | 5 ++++-
>  include/hw/acpi/ghes.h | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index f49d0d628fc4..0135ac844bcf 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -510,6 +510,9 @@ static void get_ghes_source_offsets(uint16_t source_id,
>      *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
>  }
>  
> +NotifierList acpi_generic_error_notifiers =
> +    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
> +
>  void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -550,7 +553,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      /* Write the generic error data entry into guest memory */
>      cpu_physical_memory_write(cper_addr, cper, len);
>  
> -    return;
> +    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
>  }
>  
>  int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 8c4b08433760..390943e46d99 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -24,6 +24,9 @@
>  
>  #include "hw/acpi/bios-linker-loader.h"
>  #include "qapi/error.h"
> +#include "qemu/notify.h"
> +
> +extern NotifierList acpi_generic_error_notifiers;
>  
>  /*
>   * Values for Hardware Error Notification Type field


