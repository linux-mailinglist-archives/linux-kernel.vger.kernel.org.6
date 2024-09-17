Return-Path: <linux-kernel+bounces-331532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A1B97AE08
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368471C224C7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0604715C138;
	Tue, 17 Sep 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYuDXHnh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACE13BC0E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565689; cv=none; b=HivCdI2477T9nch1NCKY5yw4BLUEneGZVO4ah4X226cTwrICFzSfHuinko8tYEjOeVmeEqAfFGd9pAwPpiEX1rAn+vXaplV23GvmgX82QkY1xAZaih361wrzXSPJlLnuVGty7B/MIiS6Npu7jcLjnIYmqr229xmevAtpzxSRcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565689; c=relaxed/simple;
	bh=NZnGoA9mTOq0GYW18/41M7/Jbyk0Intmo3WI4UCT59I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hF/1iuLwdytO0H46dSIJNIkLOP1IaE16iBBqHIeYGxYDJfKSMmMxpAb1dUZLiyiBnJ8kROetdYsg+nZsP6djh96RgEdAH5O86lz735vZDcm1O6m98uqCNHMVvRQc0Fyb/pr2tPkDMyiBlxxrqdwQy6LrOXRdTG7sf1CcV7jdigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYuDXHnh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726565686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjkuNBDLMIAJ/uQm+mpkOUbFOPVD1Lvn3qtluJr/L6k=;
	b=dYuDXHnhkMiDKRP69HfvNrdzBGrUKxuy5uF1ij3mtDkqQ5k6ZUryFg2O/RKATbQVTMv8rE
	Q+naKeowyiippYw8fmI0KmwzIrpxcBN/2t17sbihTV6Exy6VRRdponnMNg7UGgWqLp9QSr
	FN+h50JSlce+osUAN37xjSJllh3O5WE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-4vLJCxbdN9SFpQ_cYaHbzw-1; Tue, 17 Sep 2024 05:34:44 -0400
X-MC-Unique: 4vLJCxbdN9SFpQ_cYaHbzw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5365a82e3dfso1157693e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726565683; x=1727170483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjkuNBDLMIAJ/uQm+mpkOUbFOPVD1Lvn3qtluJr/L6k=;
        b=K/K4rTHQp9P+TAr8ZEQl3AovwAJJ9PylLlXwzu6BbYTY3olHASqbAh3cEQoZ3JXJL7
         n3I4pjpADVkDSOi84WI0IcjT6XLnWzH1M1FvlYJWqTL9TzE/npsSypNjyVeS3gN+5+tQ
         eHm1Ai2U8a4cMmfXUvBITVK8rVf1qOVkWS8Ne1ZKQ0rm8H7K0PSdKOm2AZqHNLzz9HKM
         rIqI1x9/AK+shoSNIxBQIbvKDSjuUfZ8fAyrjY6ux4dRYsfvLRLR7QKYcZe5gy9ebZwD
         1ROcPdK4udIyW/N0WOG7MT/KtTaC8oom81diNVuURtDt8F6oas56qnZJs5H7SzgFsMWh
         bB1A==
X-Forwarded-Encrypted: i=1; AJvYcCXWh6OGw7axOlEoDYS+J/8Tng9/1R9nrb+wEzDPx7a7ADfMAERgskSBiikOwH89cSOinM0IJc/8FbHfalM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXN7nfHBWN8E/FYfsV2rpZSa6DLD9DF2HVKYZAw93j/QNz3BRW
	jIKvoutZKA7i9KTFdkQdaH16oyjfG5MZWuaYjbZSqQneunX9rNEqO7Of+oOy8B9Yvgy+U5OFz06
	LhTsb+IBMs+54p3/TCe0XZLpmCJHBieSLOwkayQGTk0QcnclAYmNleOTgF07WYw==
X-Received: by 2002:a05:6512:ea4:b0:52e:f907:1023 with SMTP id 2adb3069b0e04-53678ff5e06mr9932919e87.49.1726565682973;
        Tue, 17 Sep 2024 02:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx9LegrKHp/daHt+ABb2qNfSu0ZiXmGlSGM+DWvjW//RcWpKn1wgglAmL+62PIHMLYMDeVvQ==
X-Received: by 2002:a05:6512:ea4:b0:52e:f907:1023 with SMTP id 2adb3069b0e04-53678ff5e06mr9932887e87.49.1726565682325;
        Tue, 17 Sep 2024 02:34:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22d85f2sm96908345e9.17.2024.09.17.02.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:34:41 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:34:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 01/21] acpi/ghes: add a firmware file with HEST
 address
Message-ID: <20240917113441.430d0bd9@imammedo.users.ipa.redhat.com>
In-Reply-To: <a1dacc20d1a2e6fc0031f957863750bd6132f423.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<a1dacc20d1a2e6fc0031f957863750bd6132f423.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 08:13:22 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its content at
> hest_addr_le variable.

say here why (just short description and pointing to the next patch
that would do that)

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

PS:
I'd move this patch to later in the series,
right before the patch where you are going to use hest_addr_le

> 
> ---
> 
> Change from v8:
> - hest_addr_lr is now pointing to the error source size and data.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
stray Signed-off-by

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


