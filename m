Return-Path: <linux-kernel+bounces-331519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830F97ADCA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0DA1F22928
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834FA1586CB;
	Tue, 17 Sep 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARPFIflb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5D4594A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564966; cv=none; b=VBWQurqBPojTWpkKy7YO5z61gl+prWjYm1WjgfJLaWa3TJQFqDbAfQYVhpBloAxt7TvmgyzYpMiMKQKPA/trLXwyieZkM+TtZHTbMi+o0EXSDdhP9QQBwILtv7IaGvwwAYrRE30pOsFrJZxNA8XXxg8hUzzR8EIkU4qsaQM0ZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564966; c=relaxed/simple;
	bh=z6zsszpTqpD+2xRUZNgY5tcNkGFeaWpqpeBlzad6yyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4JUBC5eICgJfu2+jaS32d9y5NHCqKo9YXH+0yrHrSbByBPbCbPeVTjoCGTZ449MNQX2to2WWO3+r8ayhsL3Wlgw66dOV/ckgk98yquVEfqLEaKES63FKN8jV1l8zgcqlRpKx3kGhF8CShVIL91/QrcokYtae22j0eiiFSzTUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARPFIflb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726564964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gM6/s5JzlURtImk2OaK1piumzBONmsL9B4dUQRIQefk=;
	b=ARPFIflbk25XJsmYE/eg/nLDTEknavw1FworF+cnDbYvpnjBMhrXSfI9nbqdy5OHEnBU5D
	kiD3K7Qb9qIWM+xxJr4mJv2kE/XwAKtOScVeF7zxsmGF96zsXaVstXydBAgAwVDNJQnehJ
	hZp96+iPWv7BIDo52/W0aXZhEyi18ok=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-0r8dulNDNG2inB_DJYuQKw-1; Tue, 17 Sep 2024 05:22:42 -0400
X-MC-Unique: 0r8dulNDNG2inB_DJYuQKw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cdeac2da6so41183245e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726564961; x=1727169761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM6/s5JzlURtImk2OaK1piumzBONmsL9B4dUQRIQefk=;
        b=FyGhCZ2fAw7ii5noxOOkCb6nh6jxhWJjhjXsAnj8ShlYC7J58ht3wpsnCEkuJNWSQS
         zA2K6LbEJ4g8CCJlIm+V98Uncs5sm4PkJ6EEe+/D2SRRx812cRwNhiCgRUxBqC6U7VvJ
         JVoiBKahLUdVrNunCZRJriYyXKBJSZ9Efoz8szAB5PL0Ikq4Q1ceQLWM9HDjAqq8MmcL
         PxlZKgcHbH3u26zsqJC9RK5fn42WxCdqOFp1cGrabyNdMyV8LXar3U+pjc8WicVryMJw
         +skdNxgibCqn8VpNeqS1To1ZYLy2ObULPj4fbEcTHn3vL4pAzaHvuwVcrwkhCyFdhOHH
         aZfg==
X-Forwarded-Encrypted: i=1; AJvYcCUnzazNPcc8NUF2k52U34uGbt5XshUeo/8EIBmiBBvi2Nam23G9mazP6hJj9pzQc5ARsOMKJgrcuTCKI6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY88MtKuerSkDP1mwAaBD+V7uZAuuCCQJVgxlsdqvoQbo2+9Xr
	qbxo6tqg/F0l9QROtc36NCSaU0abXt1+EUysWyl8iBq4AmYsIZDkDSD6fZyitB7blgf3M0+7yPg
	MDD82xEgqwSpMnztBMogLXwUi4cUXLbY5tmd0rzisBTulZ/nYJ2cbQejR/1Maig==
X-Received: by 2002:adf:efc9:0:b0:371:8a91:9e72 with SMTP id ffacd0b85a97d-378c2d119f7mr12005829f8f.30.1726564961565;
        Tue, 17 Sep 2024 02:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqYVYCTIMhAhk0CJfwZmZ3/b1qIb8YzfZSTf4gL82RAQ5AU+D2fLAvtIxrIBrsVjw24Z0VhA==
X-Received: by 2002:adf:efc9:0:b0:371:8a91:9e72 with SMTP id ffacd0b85a97d-378c2d119f7mr12005812f8f.30.1726564961052;
        Tue, 17 Sep 2024 02:22:41 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm8971910f8f.49.2024.09.17.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:22:40 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:22:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 03/21] acpi/ghes: get rid of
 ACPI_HEST_SRC_ID_RESERVED
Message-ID: <20240917112239.503b2a0b@imammedo.users.ipa.redhat.com>
In-Reply-To: <eb07ac97c57f4fbab413eba8a47150037b5a7684.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<eb07ac97c57f4fbab413eba8a47150037b5a7684.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 08:13:24 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This is just duplicating ACPI_GHES_ERROR_SOURCE_COUNT, which
> has a better name. So, drop the duplication.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c         | 7 ++-----
>  include/hw/acpi/ghes.h | 3 ++-
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 529c14e3289f..35f793401d06 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -35,9 +35,6 @@
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
>  
> -/* Now only support ARMv8 SEA notification type error source */
> -#define ACPI_GHES_ERROR_SOURCE_COUNT        1
> -
>  /* Generic Hardware Error Source version 2 */
>  #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
>  
> @@ -411,7 +408,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
> -    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> +    assert(source_id < ACPI_GHES_ERROR_SOURCE_COUNT);
>  
>      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>                                                         NULL));
> @@ -422,7 +419,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>  
>      if (physical_address) {
>  
> -        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
> +        if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
>              start_addr += source_id * sizeof(uint64_t);
>          }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 28b956acb19a..5421ffcbb7fa 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -59,7 +59,8 @@ enum AcpiGhesNotifyType {
>  enum {
>      ACPI_HEST_SRC_ID_SEA = 0,
>      /* future ids go here */
> -    ACPI_HEST_SRC_ID_RESERVED,
> +
> +    ACPI_GHES_ERROR_SOURCE_COUNT
>  };
>  
>  typedef struct AcpiGhesState {


