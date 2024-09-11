Return-Path: <linux-kernel+bounces-325075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1DE97549E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801E31F27742
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4DF19F105;
	Wed, 11 Sep 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfmXO2cA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0219E96A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062675; cv=none; b=h2MjaDA4KDVdwJb0wa0wDyd7Jk4Hk9U6X/KXQL17oyzDrD7M5QsSFnwYXQExlUFs+g5DRTe2+CYUZo+SvklCInZ2qPyOGhpYfhp8+CTRbfRkyd/KPjut6guOvAkY29TxoYYDc7D4dEyDlv/lzJpw1vjrWLx1edPhZrAFwo3Z6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062675; c=relaxed/simple;
	bh=3yTd4KdOimHVV/proQ9mzWYCXCNziTwu1Bk0UDD58V0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2hsCrVd8ch9XyN+d5C1aVMqdWkrm4zeBhFvBTD6Hl7yg7tlk8wzeI12vlR5u6ufEF4sFtqbtO7qrLqeqYrOk7N3vHjZv3sxN5ZlMZhbp0VmbtHY6nUXtz9ZKLExLs3CeqW4YqYZIhXWUaPLM1dTW7IPlapA/PxOdPEugou9ZE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfmXO2cA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726062673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GQVE2uuyEK3/RgorpZcN0UGcAeWWEStHDF6T/3/l8s=;
	b=JfmXO2cABQOV4fUtpJOVa84E2NpBJ8K/VP+J7zpNMNtClHqu2v/j5rG8o0JgWxX8RFUV5Q
	cTTiYprEt6MxT4Sulb4zIlRW4Npr1iSeL+O53TswaNsmg02VFGgmEbMmBsIOzozsor9sM9
	rNaj3CjsOt9DqZQHq6g8LpEeX++4kg0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-X-BZ9MF3OZSn9-pbLKELZg-1; Wed, 11 Sep 2024 09:51:11 -0400
X-MC-Unique: X-BZ9MF3OZSn9-pbLKELZg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb33e6299so26125815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726062670; x=1726667470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GQVE2uuyEK3/RgorpZcN0UGcAeWWEStHDF6T/3/l8s=;
        b=AeXLq+mUMIQkcnxvUgKWlOnKQOc+nvfOi7RxtFzftxGuupYjAmP32U6eBxYC8/qgdP
         UD0LPcq92OU4iymS2KlX3yvyqsq7GHKnaQPoJNsZot6wxgss2Rua6Y1Zgi8AsUcVb7Z/
         /8F97mJotb5k3LS+CnQhhKoyqCq+rjk4oH35/FqZzVFT/Zpnmq/IZ4+MlxP9UiDpTf4b
         +AuNn6PflcIT/cNC9lXmDfTEXf4NxFT73Pme2M6QRVmeUdght/jWXIVOQH1kjZ1BR6JW
         oOeLONKIgqzm9ilzhkE2tjVolbrevb3MbS8QGgZ5jxDuhLhb08OYiPWrNFcxFhApQgSW
         UzFA==
X-Forwarded-Encrypted: i=1; AJvYcCXcksphVH/ZYDwP4miuGgPtRS+WUOOdcWgvXKuYj3NcY53k6YkE+oUvHQuqqed3W/+CwoUdPXD5zUKE/+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKnf+f1baiXYRe5NfJq4aLXxYXacygFWhW1R5ROEPmh8Jc6yaV
	xHVQ9rP8FS1p801sEGVFB1V3yQ8R7cnt0q3A8QvBYX1nq6JKr439pw6IXPp45SqSStWXWsz8SBl
	aU0Q9yYhI3+uZ/Oy+lDEQdL9HAg8u6AUkR7uTIhXnr1TNj9hbDPet3JFi0AEv6Q==
X-Received: by 2002:a05:600c:3b9a:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-42caf060aa3mr100376835e9.28.1726062670566;
        Wed, 11 Sep 2024 06:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO3J09RP97kvF5YQ4SiyKLFil9vmlggk+kexCDdJuut3M2X4IPjV14jpq8cTqkCN/51S4QQQ==
X-Received: by 2002:a05:600c:3b9a:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-42caf060aa3mr100376375e9.28.1726062669558;
        Wed, 11 Sep 2024 06:51:09 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a5csm143859255e9.6.2024.09.11.06.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 06:51:08 -0700 (PDT)
Date: Wed, 11 Sep 2024 15:51:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST
 address
Message-ID: <20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
In-Reply-To: <34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
	<34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Aug 2024 05:45:56 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its content at
> hest_addr_le variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This looks good to me.

in addition to this, it needs a patch on top to make sure
that we migrate hest_addr_le.
See a08a64627b6b 'ACPI: Record the Generic Error Status Block address'
and fixes on top of that for an example.

> ---
> 
> Change from v8:
> - hest_addr_lr is now pointing to the error source size and data.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 15 +++++++++++++++
>  include/hw/acpi/ghes.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e9511d9b8f71..529c14e3289f 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -30,6 +30,7 @@
>  
>  #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
>  #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> @@ -367,11 +368,22 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>  
>      acpi_table_begin(&table, table_data);
>  
> +    int hest_offset = table_data->len;
> +
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
>  
>      acpi_table_end(linker, &table);
> +
> +    /*
> +     * tell firmware to write into GPA the address of HEST via fw_cfg,
> +     * once initialized.
> +     */
> +    bios_linker_loader_write_pointer(linker,
> +                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                     sizeof(uint64_t),
> +                                     ACPI_BUILD_TABLE_FILE, hest_offset);
>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> @@ -385,6 +397,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
>  
> +    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +
>      ags->present = true;
>  }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 674f6958e905..28b956acb19a 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -63,6 +63,7 @@ enum {
>  };
>  
>  typedef struct AcpiGhesState {
> +    uint64_t hest_addr_le;
>      uint64_t ghes_addr_le;
>      bool present; /* True if GHES is present at all on this board */
>  } AcpiGhesState;


