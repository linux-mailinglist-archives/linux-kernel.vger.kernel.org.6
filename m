Return-Path: <linux-kernel+bounces-267061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47020940BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646D01C23FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C91922F3;
	Tue, 30 Jul 2024 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKxZKtve"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8315ECDB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328836; cv=none; b=UcFyuY5iglcpwFP1mdGdvXI0dHj/NlXoB8RETQYtSdKK/AHvplbbUTXmESeIUouLxnhRrmLEYEbJgoLd/ieMDHFTH52RHJZIXN1oaEq5I31fEKypOUIQUfGRaIG7K6TekmE4tfkRuY+EgYkI7xQ2EYJ+83dAfaRG2/xtOjnFFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328836; c=relaxed/simple;
	bh=KeKIjr56GWZ3TmbKjhjuPrfxdwxCI4PdedCJAWyDQYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nz8MV6n7r2T2QlN4WuYzqkvjByEnafsTXRp6XFrvocRNIw8gqn0kBmIi5qZg9ksMziBiHmuzpc3d288Uan8sNHveYPu9YoAuavBvsqJaoxe04wHu9NE5SuodNqjaACFTRNuYF2YVf9TANrdVE9kpnWwYdHO67bFGtTegaal5eKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKxZKtve; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722328833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bx38A0XpDP06oxe3bl+pZoWbefbgYUyRCc/BaKj6xL4=;
	b=YKxZKtveXy+8Q7U1C2InZJJ7tZLf2BiBGdgfdL3CZdOg8DZ0gBdZAbilfDIIIbimgC3uTj
	5n/XQkHw1EnOnky5eLfOvmYGlQ/HFwAcT20JBdMUiXLT3Ze++aOmUBjNgmfX5ah2aPEncD
	4YGdygG8C420jros6LcsD9TpEBh5phs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-gfpRqIOuOTeoSwhJTi8vKg-1; Tue, 30 Jul 2024 04:40:30 -0400
X-MC-Unique: gfpRqIOuOTeoSwhJTi8vKg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-427b7a2052bso34754385e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722328829; x=1722933629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx38A0XpDP06oxe3bl+pZoWbefbgYUyRCc/BaKj6xL4=;
        b=Q1LX/pHlWFDA1m8Tl4H4UUSJ1OhmSJ6FRfWCdRdPD74mecXq7P46XVzNhKktmiKe9T
         tZ7205yO1ku/ULQTlDRPLuSNVXjLQk5+0rwt7Ph4vkNTttNsQ1mLf5U51DzjM2W5YCQj
         R3GDOfAfzKmxA4PgdCqa+pKpC6mTHrHXkUMT+gitURGt8kDTeXL0nLYbFlJJmEwKgfTJ
         nMX9/VRIZQM7JWt0NzBOZhym9e2I2lD47GTnJ2MRc3yIttbHDWLwXa/OuDKRdrQquver
         wo6WmwiO5HkqtWfwr2rn17t6Tk/N2/3LXAx50L/ZP675tF8l2XNuj2ZZuU9nshMq5s4y
         Y37A==
X-Forwarded-Encrypted: i=1; AJvYcCUgiNp/pMcNaAUOrXY+/yGa5k6zd6tNdOq3GewZL5fP8uTKJAgv+pq2BawhVVvYvTjoC4m36vus4qsJemf0MwqPq6hn5LFZdrUQI+IB
X-Gm-Message-State: AOJu0Yzw+01y6zHBdzvacKw4KkjnEidTpnuFrJBkAKAnyExN/taAstqs
	ysMlhPEUfkbRiQnHUkQS3K9hz2ro6Cirau6bfaCsF8Su5266VJfR51FVZlXv7jVNGq7uMG5Pfzw
	ZZVcpOcWhh/Lknl95xz7XFNBrk7PHWGokF/CHtqtQxwdJXCEWosdkWzE5MHf+3A==
X-Received: by 2002:a05:600c:310e:b0:428:15b0:c8dd with SMTP id 5b1f17b1804b1-42815b0cb56mr77206205e9.20.1722328829632;
        Tue, 30 Jul 2024 01:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA7F8Wl0Pk7pPlBS7mRllgrGC08PD3OtHUYft3GlhhdnBwSt1qfBBkpUl1DTL1TfpmO5NU+Q==
X-Received: by 2002:a05:600c:310e:b0:428:15b0:c8dd with SMTP id 5b1f17b1804b1-42815b0cb56mr77205935e9.20.1722328829115;
        Tue, 30 Jul 2024 01:40:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280fa9a30csm136438785e9.30.2024.07.30.01.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:40:28 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:40:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/7] acpi/ghes: Support GPIO error source.
Message-ID: <20240730104028.4f503d91@imammedo.users.ipa.redhat.com>
In-Reply-To: <64a31a09fe6b11bebad1c592ad20071a9d93fee5.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<64a31a09fe6b11bebad1c592ad20071a9d93fee5.1721630625.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 08:45:55 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add error notification to GHES v2 using the GPIO source.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 8 ++++++--
>  include/hw/acpi/ghes.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e9511d9b8f71..5b8bc6eeb437 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -34,8 +34,8 @@
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
>  
> -/* Now only support ARMv8 SEA notification type error source */
> -#define ACPI_GHES_ERROR_SOURCE_COUNT        1
> +/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
> +#define ACPI_GHES_ERROR_SOURCE_COUNT        2
>  
>  /* Generic Hardware Error Source version 2 */
>  #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
> @@ -327,6 +327,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>           */
>          build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
>          break;
> +    case ACPI_HEST_SRC_ID_GPIO:
> +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
> +        break;
>      default:
>          error_report("Not support this error source");
>          abort();
> @@ -370,6 +373,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GPIO, linker);
>  
>      acpi_table_end(linker, &table);
>  }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 674f6958e905..4f1ab1a73a06 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
>  
>  enum {
>      ACPI_HEST_SRC_ID_SEA = 0,
> +    ACPI_HEST_SRC_ID_GPIO = 1,
is it defined by some spec, or just a made up number?

>      /* future ids go here */
>      ACPI_HEST_SRC_ID_RESERVED,
>  };


