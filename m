Return-Path: <linux-kernel+bounces-534156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295EA4638D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E95189EC89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097B221734;
	Wed, 26 Feb 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOLuc4c+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A22218AB4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581291; cv=none; b=ai0F3CKq9qBppIa7XJcFq24J/E6Daot5WaVg3kmdgSEKE/TItG3olbfVtCITmooFkik8Nsqv2Ou882ks76gJ56MuZz/ieEuQOKKY4IryVfXSyId+D+z9LsqFAibKnwciUlkHaFMJXY5dxVosqH1mCy2x+EJsc8oqrU+5fxcJ3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581291; c=relaxed/simple;
	bh=NR8acvY9HBtKknXlzOTnCjVI4CMDvxPe/sjYzEh3OII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r93f7cwc8UtyvEVccClYLRqRoIhETwXRLQG6o5AKT3XupqwDz30RTJnFWL2zw+2hAs/bnzlcu/qvNstgKCZetutQjiiRH/bXtIfFYz8u5IMGSKAN6DtfTAxqW1REGJ4OJHwSSUdyH6kpLgMqsZlDD8VBsOnKx5iG799PbUXDBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOLuc4c+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740581288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vkoWrSDvFL6bPp2+SBWRgFUy47QB4e69nH0NyHiTjI=;
	b=SOLuc4c+9bmRVovV52VscO/v0dfT/V96gryQWGfkQB7IkbXrVy2Obghlv3MxUf5Wq1koH2
	ILlnpiutXhESp3WNo8EFyLwmDaSQrLOx3dRqFuwz9Liqv4ix9drqumRU+ave7NW0kgf0B1
	dYGVL7TYRVsA1uKas/l+CJBb0xe+7Wo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-ydHncu8eMk2VRrIHpxP4Zw-1; Wed, 26 Feb 2025 09:48:06 -0500
X-MC-Unique: ydHncu8eMk2VRrIHpxP4Zw-1
X-Mimecast-MFC-AGG-ID: ydHncu8eMk2VRrIHpxP4Zw_1740581284
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f2ef5f0dbso2642546f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581284; x=1741186084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vkoWrSDvFL6bPp2+SBWRgFUy47QB4e69nH0NyHiTjI=;
        b=bl8OMXUogUGij7mRiLhsixmQz3P2pxYez0rJwk3E/gUNClQDopkKCsHwtAdZCMLx12
         deDj8mmHOPb+j7C3g4Ki0SK3VtSgxRm7NFuPBsuZaocGWn7CtTDB/4BviC4/m9UH/igr
         UQvwY2Q5+STkdxRx7CtrXIcarRw5WcUB4ZEPAvdVBO6YonmcDwZ2YvxxTzrdIgsQWJql
         /GH70PUc3htBrqysXyGBBkKik2FnzgAxpsfQa3nPzlC9RETiV32Cm/s0+vBtgmmcOJJB
         65raHM5mT0PeTK2E32R6kljOUZHJV2qYGvxrdlfN1+t7LYN7aFEw68dx6L8FbF3WGZFn
         Ijng==
X-Forwarded-Encrypted: i=1; AJvYcCUtGA6JHENNw/ZvMppWkxifK65ucUBAs3QCtdoveOWNjYugeiY0VZfmEZrg9O63Y1PzbsXn7GpGPgcvPyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+Wth4llEHfcrrr+t9+Le0q7qlT0zFt9mfVp0kthUjXrqOjWK
	qPd4D13GIRYaoj36cpz/0LmE9oxuXlZAVvjXM6F0YoZR0b3fUgW0uEelBr1FwKiGtfXL+GI5MCf
	yz7IOGE/BwdmOUUARECoJqd5qIE20L6knenp9zMNMuDyb8bBWt1qdD5S0e8Hvyw==
X-Gm-Gg: ASbGncunph+H+aLvGK41sd36X2UXRRCRUTBOVWoPCukQSoOvz2sZUrg8MAruphVAr0M
	GSAAo5sKzsJo/DeYTiYSkLSkfPzd3LPn5Tj7avOM9YBeP/sMs/2NahOEnBu1wQX8njUXXMs3jyM
	3dQYIg40qqsfgKNqvSIB5knsTS3deA8I2W60VV9xusn5ABT/uVxxi3a71SwiPEvsWtQAcbcCTVT
	I6hHv2W6oZz9D05XFj2L3KYF7ptua5hL9QFfy24846r6d1TaPLEojaNvqk157d37ffxAyG1mY/5
	HTOfeuU2o1DqkxOLEBChVoaVzL/8WOwqP6Eb0DCyEQNkrfXv2Y/z3e30gjPKhbc=
X-Received: by 2002:a05:6000:1541:b0:38f:38eb:fcff with SMTP id ffacd0b85a97d-390cc60a682mr6467902f8f.29.1740581284324;
        Wed, 26 Feb 2025 06:48:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt0IdIIux70KZSKj21MuPK89m+sivEs5JGNzpiw8G6lG8AV6fs8fa3K3La96P0ieYxPdZd0Q==
X-Received: by 2002:a05:6000:1541:b0:38f:38eb:fcff with SMTP id ffacd0b85a97d-390cc60a682mr6467878f8f.29.1740581283918;
        Wed, 26 Feb 2025 06:48:03 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e725dsm5991101f8f.63.2025.02.26.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:48:03 -0800 (PST)
Date: Wed, 26 Feb 2025 15:48:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/14] acpi/ghes: add a firmware file with HEST
 address
Message-ID: <20250226154802.58d865a8@imammedo.users.ipa.redhat.com>
In-Reply-To: <0866291724e8c276c5f7066991ce08250d7857d3.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<0866291724e8c276c5f7066991ce08250d7857d3.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:35:11 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its the start of the table at
> hest_addr_le variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes.c         | 22 ++++++++++++++++++++--
>  include/hw/acpi/ghes.h |  7 ++++++-
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e49a03fdb94e..ba37be9e7022 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -30,6 +30,7 @@
>  
>  #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
>  #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> @@ -341,6 +342,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> +    uint32_t hest_offset;
> +
> +    hest_offset = table_data->len;
>  
>      build_ghes_error_table(ags, hardware_errors, linker);
>  
> @@ -352,6 +356,17 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                    ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
>  
>      acpi_table_end(linker, &table);
> +
> +    if (ags->use_hest_addr) {
> +        /*
> +         * Tell firmware to write into GPA the address of HEST via fw_cfg,
> +         * once initialized.
> +         */
> +        bios_linker_loader_write_pointer(linker,
> +                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                         sizeof(uint64_t),
> +                                         ACPI_BUILD_TABLE_FILE, hest_offset);
> +    }
>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> @@ -361,7 +376,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
> -    if (!ags->use_hest_addr) {
> +    if (ags->use_hest_addr) {
> +        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    } else {
>          /* Create a read-write fw_cfg file for Address */
>          fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>              NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> @@ -501,7 +519,7 @@ bool acpi_ghes_present(void)
>          return false;
>      }
>      ags = &acpi_ged_state->ghes_state;
> -    if (!ags->hw_error_le)
> +    if (!ags->hw_error_le && !ags->hest_addr_le)
>          return false;
>  
>      return true;
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index a3d62b96584f..454e97b5341c 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -71,9 +71,14 @@ enum {
>   * meaning an offset from the etc/hardware_errors firmware address. This
>   * is the default on QEMU 9.x.
>   *
> - * An offset value equal to zero means that GHES is not present.

> + * When use_hest_addr is true, the stored offset is placed at hest_addr_le,
> + * meaning an offset from theHEST table address from etc/acpi/tables firmware.
                             ^^^^^^ missing whitespace

'offset' language is confusing here, is asks for explanation offset from what?

what is kept in hest_addr_le is GPA of HEST table, it would be better to address
wording here.
The same applies to similar comment in previous patch

> + * This is the default for QEMU 10.x and above.
> + *
> + * If both offset values are equal to zero, it means that GHES is not present
>   */
>  typedef struct AcpiGhesState {
> +    uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool use_hest_addr;         /* Currently, always false */
>  } AcpiGhesState;


