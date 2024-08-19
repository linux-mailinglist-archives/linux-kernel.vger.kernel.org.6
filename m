Return-Path: <linux-kernel+bounces-292119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F0956B59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7936B23807
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809016BE22;
	Mon, 19 Aug 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+HdzufI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A81487FE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072262; cv=none; b=Bks9+4h7QTq+QpoGj2f7ETR7spqVvClbcqjqNXo9BD15Jt6K/o31X9LvCLya1KEEsbPp0V/Sw1pigEKDrg65Gv5Hb2b519O2QnaLKkF/D7bHgqGsWdcX37OYRpV4QW6TYvvwzK0Km4Q0DuZvEQTSRdWi3ddgpp3SIhQcX7LOQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072262; c=relaxed/simple;
	bh=EQvAPxbYK9aJKa+sYM/5hTTzSn2JzfriDftGL9b/8uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N88UAGMCTr/jinCdst+wAD8e9ml1IvuLUh2cnelkkJ4qviCHKpzgjrlSHUY4zGKxt+E5v49o2/a6XJksUabxoSHHtbLmvYA63zb57ufafXcT8oB/QhBn2B+w+FHqJQRcHNF3MNRtd4pB17D8n5J45E5UeL/HYNw4yv8Vl3zXLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+HdzufI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724072259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQq04umgaGGIU/uyNF6ouiRkFMTZ4eoaEDjVqBV4xoQ=;
	b=L+HdzufIZx3ptFtlVd/+jsYjfLa9AFMLC4kRpF/Cw+6XOIJA4yRhpBXG4Yf2s5tAX+tnkj
	B0tc2bM9SudAsJzl6ULSxl0wglPsccVke0Et7bM3S/+ce0tGj5+WIUlimB/wx0cdp5g3Gl
	/s9hw9Jpr1ZCRGoG8Qv6Jx5bPpoL+2I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-6ZKLXUnZPdWBt6ecwF4m3g-1; Mon, 19 Aug 2024 08:57:37 -0400
X-MC-Unique: 6ZKLXUnZPdWBt6ecwF4m3g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280d8e685eso36583015e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724072256; x=1724677056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQq04umgaGGIU/uyNF6ouiRkFMTZ4eoaEDjVqBV4xoQ=;
        b=JEC4YAVm61LQ8R41fGeGx3W+oGrc5kBHjmHJP5diKmOsILtPX5WGR/IPD3SCyowpbP
         RI7t2iU5nLTHtu54qpNaDAM7T803/3eMVi1B7C8ZcTNEtPsBIgGJX02K/ZtylH6nPm42
         dA5HvgIL+qWBP3puQbMcY70326OuUBn1PP98TaIUP7IxowjT7TvBYN/TOVh+nkTGyqrD
         V31GkmNs5gWKkeyl0o+kLcE9q8AWMsfe7zhp0Jzapg+LuVOVCyjc7s9Pud36LkINtshC
         wE9ixe/cKWOCX2idu2dJIJOLmDvkuHycp1kurUlJeQsF3mTZi2N8w6O0v61uRx3lRKdv
         eh7A==
X-Forwarded-Encrypted: i=1; AJvYcCUZWxzwPCLwh7It91938+9Yt/zvrltiuAPOesP2XYrJxQPnypxgD9wN47jrXQafihGSCjskWRUmlRwvRaKjNPO1xTq08yoOeSDXBKwI
X-Gm-Message-State: AOJu0YyR9QgjsRwRfkaqOpJcJQlOGsuK3FhDwD+dhtbU7ZR1/QAZZA56
	Hz8LBbY44HLpR7cpQolnW2ekdn1CIqiAwfYx0WfcX+mxrsoFteyYx0TkCRAoIiRgSDGdOw0UhGs
	sQoTrNe1CE4RnodzBFINisXNs37YPVmI1n3bQsbMbX6y0mrChgPI25Tw1Or3gjQ==
X-Received: by 2002:a05:6000:e4e:b0:367:8f29:f7b6 with SMTP id ffacd0b85a97d-371946ae685mr7234175f8f.51.1724072256293;
        Mon, 19 Aug 2024 05:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdM5bWz0CAQc4dGvn0HR9XlG67JZvOfW1ujlsk+hoA8XtZ2Fphyll8c8dG8XzG5MUJlwt/cg==
X-Received: by 2002:a05:6000:e4e:b0:367:8f29:f7b6 with SMTP id ffacd0b85a97d-371946ae685mr7234159f8f.51.1724072255728;
        Mon, 19 Aug 2024 05:57:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984c0d0sm10471874f8f.38.2024.08.19.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:57:35 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:57:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 12/13] acpi/ghes: cleanup generic error data logic
Message-ID: <20240819145734.03977654@imammedo.users.ipa.redhat.com>
In-Reply-To: <d91565e9ac1c59bd2bb22b06256f5fefcb43a973.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<d91565e9ac1c59bd2bb22b06256f5fefcb43a973.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 09:37:44 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Remove comments that are obvious.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
these comments help if you don't have spec side by side with code
to compare. I'd even say such comments are preferable than no comments
when composing an ACPI table.

pls, drop the patch

> ---
>  hw/acpi/ghes.c | 38 +++++++++++++++-----------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 4f7b6c5ad2b6..a822a5eafaa0 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -130,34 +130,28 @@ static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
>   * ACPI 6.1: 18.3.2.7.1 Generic Error Data
>   */
>  static void acpi_ghes_generic_error_data(GArray *table,
> -                const uint8_t *section_type, uint32_t error_severity,
> -                uint8_t validation_bits, uint8_t flags,
> -                uint32_t error_data_length, QemuUUID fru_id,
> -                uint64_t time_stamp)
> +                                         const uint8_t *section_type,
> +                                         uint32_t error_severity,
> +                                         uint8_t validation_bits,
> +                                         uint8_t flags,
> +                                         uint32_t error_data_length,
> +                                         QemuUUID fru_id,
> +                                         uint64_t time_stamp)
>  {
>      const uint8_t fru_text[20] = {0};
>  
> -    /* Section Type */
>      g_array_append_vals(table, section_type, 16);
> -
> -    /* Error Severity */
>      build_append_int_noprefix(table, error_severity, 4);
> +
>      /* Revision */
>      build_append_int_noprefix(table, 0x300, 2);
> -    /* Validation Bits */
> +
>      build_append_int_noprefix(table, validation_bits, 1);
> -    /* Flags */
>      build_append_int_noprefix(table, flags, 1);
> -    /* Error Data Length */
>      build_append_int_noprefix(table, error_data_length, 4);
>  
> -    /* FRU Id */
>      g_array_append_vals(table, fru_id.data, ARRAY_SIZE(fru_id.data));
> -
> -    /* FRU Text */
>      g_array_append_vals(table, fru_text, sizeof(fru_text));
> -
> -    /* Timestamp */
>      build_append_int_noprefix(table, time_stamp, 8);
>  }
>  
> @@ -165,19 +159,17 @@ static void acpi_ghes_generic_error_data(GArray *table,
>   * Generic Error Status Block
>   * ACPI 6.1: 18.3.2.7.1 Generic Error Data
>   */
> -static void acpi_ghes_generic_error_status(GArray *table, uint32_t block_status,
> -                uint32_t raw_data_offset, uint32_t raw_data_length,
> -                uint32_t data_length, uint32_t error_severity)
> +static void acpi_ghes_generic_error_status(GArray *table,
> +                                           uint32_t block_status,
> +                                           uint32_t raw_data_offset,
> +                                           uint32_t raw_data_length,
> +                                           uint32_t data_length,
> +                                           uint32_t error_severity)
>  {
> -    /* Block Status */
>      build_append_int_noprefix(table, block_status, 4);
> -    /* Raw Data Offset */
>      build_append_int_noprefix(table, raw_data_offset, 4);
> -    /* Raw Data Length */
>      build_append_int_noprefix(table, raw_data_length, 4);
> -    /* Data Length */
>      build_append_int_noprefix(table, data_length, 4);
> -    /* Error Severity */
>      build_append_int_noprefix(table, error_severity, 4);
>  }
>  


