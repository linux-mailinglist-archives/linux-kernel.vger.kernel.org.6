Return-Path: <linux-kernel+bounces-347479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D074398D33D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0113F1C213B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3311D040B;
	Wed,  2 Oct 2024 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbpUwi6p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1F1CFECD
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872082; cv=none; b=bCWFBMZLX6B0AGnO17xxQzJSQ81uTGbGi/1JB7uAITjG9ObRF8ZBlC/hwql0Kq6YxQ3xvUxuhKdsyN02O//B/XHh8yZMsDp2+5/OMo61sUrAbYhxKHoGHJTAfvKcYbMnrj58xmYU0Mb1FMxohDbVKkY7iT+Pkb/I2CJ4XD2+AC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872082; c=relaxed/simple;
	bh=P4cjPgb96+Yfk31I4ArA741dHnxd/3ye1WFlhoY/qlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2SLABxruMeemHY2aiFLYlmi9SKpd44FY0zY461NDCP0sw6cA/QpPp0OVPEXjbfqpuSJ0j0krUk8UcYjFd2n+oJoLJXDZAQK/DyWTd1RPtr54TJ5J3I8y/towXk43YAH5P+pjXLFBbiPf+jm/8q2uE2UpsSfZjZTfq8udixVE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbpUwi6p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727872079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zy/ZYXezD/7SwVnrR76iPCG2vx+uv4epmVmeCMiNdC0=;
	b=ZbpUwi6pATMKMG1RMNZvWDEnRhInEolqjOEvc9p4LJmBK1MbyMmDdKXc7lTfItjAczQw4H
	IZK9J1f7D1I+CbHrXBmsanBuSJT/XHlXyGdC0QdbEKbsuGzqDdkoZMAz+wu7OVXCW4gFgd
	9q7zjrunrgZjV21kcdkehx3AxoRTuUE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-Ida4ljaeM46sbmtKhkYfhA-1; Wed, 02 Oct 2024 08:27:57 -0400
X-MC-Unique: Ida4ljaeM46sbmtKhkYfhA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37cd08d3678so363568f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727872076; x=1728476876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zy/ZYXezD/7SwVnrR76iPCG2vx+uv4epmVmeCMiNdC0=;
        b=UzteiVJW7vfDAqKnBwE7NwkoDaJmizdhgQ+i+ax4mFWwj0qhmChsMRBSMAuCYJJK1n
         RiXMwgVFQo2ZamtIXWWOTuQ0/9mJUmosjLK+k6ov2NLi2WTvLTXUKQgKxMG6I1O6MSTA
         cVc6CQp5it0RVDhq9cybo0Z47S2kJtuoIud9BP9IQyvfSZThCOMZbQpNZoo1W4U9Kr86
         sSmtl/AAdu0GYoY8XFBPki+CN7wJYDOLg2L6l4yqU2fO7zzynxDmVeiskPKpyzHZjlmv
         PbhG4XZp3J9xJKXV9xQzxF9tOw5WDs0p6q5idhoW3+nccPpiZ+6S5GkbAD1lFSfPzvSb
         VqqA==
X-Forwarded-Encrypted: i=1; AJvYcCWPEPRWUwVfiin1mV0Hv9hugLjs6U7k9XjrVsW7SjnYpfQ/IPMYGc9nmZePyiSfFW6fEh946Wascazktwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2cngtEi2EaK5K6Rkj7FL9W5TZooUCs01SFJuvdA9RML0FrJo0
	kVHqbfEgqM2NaMb14WCqTZwAmpUTGwJ5VB0bt05aLtGopa5ZXBSFrOonBWCZHEkdHF1mQ8CpbNi
	kpH5r6RBtZ9hEDmg0Dvbe/0OCddryyJfELT6kozuPcBmle8Yq4j6Kd48/RE1FFg==
X-Received: by 2002:a5d:6049:0:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-37cf289c5damr4197396f8f.6.1727872076196;
        Wed, 02 Oct 2024 05:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFTM7gXF/Sks/nw+9yQa8k1GxSL0J2xOO4baZqrcOegpPf0mXvZ4khqwx1fsxeobYetsQxOQ==
X-Received: by 2002:a5d:6049:0:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-37cf289c5damr4197374f8f.6.1727872075824;
        Wed, 02 Oct 2024 05:27:55 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a02ef4bsm17283085e9.47.2024.10.02.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:27:55 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:27:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 07/15] acpi/ghes: Change the type for source_id
Message-ID: <20241002142754.086a2cd8@imammedo.users.ipa.redhat.com>
In-Reply-To: <4149830f15bcad19f6e32981754d437493f3aeba.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
	<4149830f15bcad19f6e32981754d437493f3aeba.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 09:03:44 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> HEST source ID is actually a 16-bit value

add here spec/ver/chapter/table reference as a confirmation
of above statement.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/ghes-stub.c    | 2 +-
>  hw/acpi/ghes.c         | 2 +-
>  include/hw/acpi/ghes.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index c315de1802d6..2b64cbd2819a 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 5f67322bf0f2..edc74c38bf8a 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -383,7 +383,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  {
>      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
>      uint64_t start_addr;
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 50e3a25ea384..9295e46be25e 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present



