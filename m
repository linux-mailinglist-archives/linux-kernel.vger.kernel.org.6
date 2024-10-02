Return-Path: <linux-kernel+bounces-347567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A1E98D53F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FFC8B20EE8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11816F84F;
	Wed,  2 Oct 2024 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iavwAuZs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AB1CF284
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875696; cv=none; b=MHMAnB1qJnJ16GrsTtesmRbf90xVGA823OqqMRezM281pLEJH/VLi4/WgxBS6qYzdHmsz0+S9Z9Y3GdCadwVXb0v88ykhJJ3R/NC4NM4K8sBoBlbM9YNgi8DyH6cZFR9MOs8+nL2hCvgi20dmqfmKl+43Ax2OOJIudF5xKooFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875696; c=relaxed/simple;
	bh=cT4656hQp6xPacxxchNnar1Fl/nzOqC6eTWTpNquSGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODVzfnaU1GHDhQKUilk1OFtcbZ9F11HR4bOCML/LhmeYn35crA4dlf+8dkU4PhBF2w2gJBOS8iGkT2ELRjaFkOdoKhEdq7R3MCYLPjQbUdqV8MWCBjlufrGeK8anTTpHYSEyhGG4hDtBhkSJPZxzPbpEAXOxIqqoSMovdGRXaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iavwAuZs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727875693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+VvDVDKFYS1/82i/nMHdeQIrsk+nBd6/CLcGztnt+Y=;
	b=iavwAuZsGgrkUDYOU0azDJCJH9mfVJXT7WXlYN0sE1DsPKyUM/G8TgTaL5WX5Dt04O6ksj
	IUKhY50cTs1M0ZmOhibm1Y90Cn9p0EWEbrC7DnLsnsaJuAG0XAq6zLW+GgdoJPZA4iSnxl
	lnw6W7SLCFhGzelhtS431A3RCugjwxk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-jA-55fOOMZW_ztGRB7EubA-1; Wed, 02 Oct 2024 09:28:12 -0400
X-MC-Unique: jA-55fOOMZW_ztGRB7EubA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37ccd39115bso4201833f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875691; x=1728480491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+VvDVDKFYS1/82i/nMHdeQIrsk+nBd6/CLcGztnt+Y=;
        b=u4PJi68MQvt1BZsQQ2jo4AY+bNT4Fa6tyHDvWk2rURigKt9KYO7YvS15EqAyQrCaK2
         Yf2DRdF4wlrgtK96jqxTZoi9C1z1J6qovqK+m53SyRroYHEdhWFhJVngWPFqXNzAcS1T
         uq13EiKJaI99jK15ewCTM8RZOfsemf5YwMpB5g/Ar8H3GnA74zZkfn+Bgq1whoxXNcQw
         h+6Us3458vS1JczuxsjAy4en0rTpcBSFXMB7BRKHau5xe2GbL2ohbvEqXJboJQGjJkYd
         kz17rMo5369yu1VX505xAQw0+BvbxqhhWF0YJW1AyLgOaQhapS2Lm0f6MPKZKBsUzAJh
         i6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc2qdVj2nE9/4OY/iAoHfchgujueTQJEUZu0cRnjQCoJd5+mOvHlgoQVpD3UFjCwL4yA8pJ6Z8s9O2qrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX22cLo1l6wbt/fEkYkfYp9vbcWQdoL3beoMJA+UIcBtK4b/pt
	jcmCW2R/25kQhDEK5l9gCrWttb/gzye7G3mxSV+X6sHkyk0ejR1g+0OFcxf8yVquxQwgrt1UuD2
	MUANmczIZMxHYfHv5ro2n7eeN3aVzDaKWqX6j6Q9FERWQdQaOdnII1LTbEwNFzg==
X-Received: by 2002:adf:f34f:0:b0:37c:d200:4fea with SMTP id ffacd0b85a97d-37cfb9d1efdmr1847902f8f.34.1727875690970;
        Wed, 02 Oct 2024 06:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGImb7tRUCqw88TPMFN34Y/dIqnQmHnS519NkAmKtNWLDD0LoJUTCHo9IlXjyCys473aLHxEw==
X-Received: by 2002:adf:f34f:0:b0:37c:d200:4fea with SMTP id ffacd0b85a97d-37cfb9d1efdmr1847885f8f.34.1727875690582;
        Wed, 02 Oct 2024 06:28:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ed3e3fsm18631645e9.23.2024.10.02.06.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:28:10 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:28:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 04/15] acpi/ghes: better handle source_id and
 notification
Message-ID: <20241002152809.0dcc4013@imammedo.users.ipa.redhat.com>
In-Reply-To: <1b6ddd0bdfc9ac32a35fa7d85692e635bb76da11.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
	<1b6ddd0bdfc9ac32a35fa7d85692e635bb76da11.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 09:03:41 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> GHES has two fields that are stored on HEST error source
> blocks:
> 
> - notification type, which is a number defined at the ACPI spec
>   containing several arch-specific synchronous and assynchronous
>   types;
> - source id, which is a HW/FW defined number, used to distinguish
>   between different implemented hardware report mechanisms.
there could be several sources with the same
hardware report mechanisms /aka notification type/

s/between different implemented hardware report mechanisms/
  different implemented sources.




> Cleanup the logic to fill those, as they should be handled
> independently.

above doesn't really say/describe the patch's intent

> This is a preparation for a future patch that will shift
> those fields to the HEST init function call.

not relevant in this series

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> Chenges from v10:
> 
> - Some changes got moved to the previous patch.
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 4a6c45bcb4be..29cd7e4d8171 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -284,9 +284,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> -static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> +static void build_ghes_v2(GArray *table_data,
> +                          BIOSLinker *linker,
> +                          enum AcpiGhesNotifyType notify,
> +                          uint16_t source_id)
>  {
>      uint64_t address_offset;
> +
>      /*
>       * Type:
>       * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> @@ -316,18 +320,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>          address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
>          ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
>  
> -    switch (source_id) {
> -    case ACPI_HEST_SRC_ID_SEA:
> -        /*
> -         * Notification Structure
> -         * Now only enable ARMv8 SEA notification type
> -         */
> -        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
> -        break;
> -    default:
> -        error_report("Not support this error source");
> -        abort();
> -    }
> +    /* Notification Structure */
> +    build_ghes_hw_error_notification(table_data, notify);
>  
>      /* Error Status Block Length */
>      build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
> @@ -369,7 +363,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>  
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
> -    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, linker,
> +                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
>  
>      acpi_table_end(linker, &table);
>  }


