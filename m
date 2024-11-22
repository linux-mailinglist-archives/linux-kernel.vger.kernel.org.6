Return-Path: <linux-kernel+bounces-418431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6779D617D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA42A16059C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87351DE4C6;
	Fri, 22 Nov 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnAVdp7G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558813C80C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290117; cv=none; b=VxE/JhMI/ZGZYONCgD5nBbeEe+osDVgQDu/1oOvprC41HkLa0eqy6xzNLgEFqkyvPbXwmbqt/PZzIweLhlDfq3XEYHmxD/jvmgY9GtyWuMKasn+2n7m/RSgUwC3u91sToXT7dO0pf7yHLEFQN7e3Uyn7XF3nQfUx2xZd8NqaxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290117; c=relaxed/simple;
	bh=8WgYNvmi0MTh62Cfx0w4RocIsD3bPUHCccQ8EDfitjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDt/Qb8uNVeQup2PUuRsEphhVDoQOieVktGArPyCdeEJJDMvFWvpynvOGkt1mBLZ0CwW1QX0pRjO29P1czLJs0meiZKBPnKi+3kkPk+XqgDnIJLtC0XCS3T6DwNm8R+AoSVmCtZpGZjl7MCSSIzLYTCEYleZcMyBxYORs9uPiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnAVdp7G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732290113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+yaHaIkSyy8GR8NSGw9v4GihzAiPvpRQjvYO902Fu4=;
	b=BnAVdp7G0m0+R+w/RxHrRWKRV15DV0eMNa7pdSupIkD8jP1+FaTp9g1W0frPcNZxy+iQ/m
	81FXukQaV3GIQ1TcRvkn6QVIqI3osexgxQeFKEGjo+WUEsmPjTfOT2t34bb4JoMTobITsw
	Flj3hQ7w6VDWwAlRW/KY3cOGy0/Emec=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-NoqnxJO2OeK7ftnC99Wtbg-1; Fri, 22 Nov 2024 10:41:52 -0500
X-MC-Unique: NoqnxJO2OeK7ftnC99Wtbg-1
X-Mimecast-MFC-AGG-ID: NoqnxJO2OeK7ftnC99Wtbg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43152cd2843so14303875e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290110; x=1732894910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+yaHaIkSyy8GR8NSGw9v4GihzAiPvpRQjvYO902Fu4=;
        b=fYBdLxNv/Fm3XhSVHU6d/7yuppTxIla6C485/W4nh64z6q/RHgAs4udjZ6p9eYdB35
         QigkxAqQcPy22jMv08MmiN8NAYvuIM5ZAV599qKc0oxJDvvN9CEaGeQjZaNkbHuYMUcR
         WuQxZEUJ4VgNSRj0xGVYWGiB9HbGBlQWvZNx2aa0RolaCNz+MpuFroeW1msdgDRbo8GT
         C4Zx1d8Df5ogZQc4g76lxQjBSP92h4H8XlqZVAaYU8fBqXoWZlltNDw8/Eld9LySnlnZ
         FY0oaCOS712gD1YJ6R4n4nqv07qgK/H0caEPQQ6AC5P11oQMKdNiiLXlzHCXlQf3Pa8h
         205w==
X-Forwarded-Encrypted: i=1; AJvYcCXDOQhUyV5Kqp2UZA82EV8cXjmYXgz7SFbcOMLLWP+m4eL3ZEb9gnpeGAxwtINfh5iNmu6ofJjSfdrrnIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hPhoxjMaFcN4RYVXUov2JxLRIvPPSxlwYsn6CAPv9N7Vg2zH
	SJjYvwcdGWhMS8rl765ySAn6Q1VmZSAhieB81rmmXJBoJMc59sdAaep5WtvmSeCrPPsaCXyV/wj
	L9mDISt3zpOkTEEt1zwOH5HKw5rsSOPpKQObLrnwh1NLWq6Mo4+Rnw9xwYJ5FT3xfWAqk2A==
X-Gm-Gg: ASbGnct5qQtX3WGKU5EO2KyX4cSP5vJlljPfW8xjZRiIZRZ2OyVr8rWAoJwOEvDOXNk
	cvlIpOPgLZBRMUAShFSMfn9pxG9DQ5XtJFXXGk+KycP1XJax+z6ceCwwanyRl1jh93OOgqNWxsm
	N5ZcMutVwUx4WlaNKMdjPl7BkdFd+nlKoeBBZ95jgxh3NFvWgkr2xpgqHpMoD5683omSkCq6tYY
	GjpdINI68NmmgLBKojdiSRUx4kvSG2LtJgdyycu/0iQ8FF8Z+GtdjsHQxYE2wzDL+ernV1Kc6J4
	A7Juz6JvFk2/IiiFKzvkWQ==
X-Received: by 2002:a05:6000:1446:b0:382:512b:baff with SMTP id ffacd0b85a97d-38260bfaedamr3291394f8f.59.1732290110691;
        Fri, 22 Nov 2024 07:41:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZIAv9MqkDQh4Mlw1DlID8h5lyTKTFj7KDo0Gz8w4AVp3Lc4Otp3hDXSOF+GaOumjzW9S5LA==
X-Received: by 2002:a05:6000:1446:b0:382:512b:baff with SMTP id ffacd0b85a97d-38260bfaedamr3291367f8f.59.1732290110322;
        Fri, 22 Nov 2024 07:41:50 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fd0fbdcsm2680201f8f.109.2024.11.22.07.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:41:49 -0800 (PST)
Date: Fri, 22 Nov 2024 16:41:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 07/15] acpi/ghes: Change the type for source_id
Message-ID: <20241122164148.60dc5290@imammedo.users.ipa.redhat.com>
In-Reply-To: <84475e30b69680d93697ec666214482e36cd8844.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<84475e30b69680d93697ec666214482e36cd8844.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 10:11:24 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> As described at: ACPI 6.5 spec at:
> 	18.3.2. ACPI Error Source
> 
> In particular at GHES/GHESv2 table:
> 	Table 18.10 Generic Hardware Error Source Structure
> 
> HEST source ID is actually a 16-bit value.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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


