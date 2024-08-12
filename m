Return-Path: <linux-kernel+bounces-283007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA11594EBCC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFD81C20E67
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA432175D24;
	Mon, 12 Aug 2024 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClsX1e90"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6214D6FE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462131; cv=none; b=kFNbo4aLDDj2AvG6NVfT1eGuN7Dd8FLOVDo5gwseoEUNIy+Wf+N7nbfHyk4Y9RBB/V+VAxgBjh1fH0xSqpErcfl44/6WsKH9yekYcJfU3Pb2N0C3oo3E0BwkQ+nwMx2uOent2S81i2SZvzv0uRMVzAVpfIjjC4M9ai7WaeJjhJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462131; c=relaxed/simple;
	bh=uS8f+x0cKqtRZriiu58H+cvsvDje/eEoou5/IvvJUQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frnE0QZeRDq8/rRiYJa/MIE2nXclc7xmGddimixmwi51qHGuq0pZqPgy+NVyw/TLUHHfZILoTUGdkYEgVEWjABjmldXmV6/J2by/v1Z9/icEiRb+Xio30PP5jKmfwaxXhjjx65x+L9Iheth8ryvc0cP6R7Twhl2yqA3a7Jyfcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClsX1e90; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723462128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzMz3TZb/4STKd1zC5JgrVRXvARW6dC5kvx3z4x0yLA=;
	b=ClsX1e90Dx0cKNRhkVyTy3/8DaAYkbgE3Kw5uVJgAUwzvRnuvATehBInYG+1svfusH7Zkg
	XQZl9QHq1IZ+MZQfn/xVVLxLdS2vF8ADGAD8Y4yH6h0eaOeiy/H0PKj6iWw9q+vx/Q7J+u
	OjjGcuuqp8lHHmYxInmYgUH1gg24XZ0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-1dmgEYzoO1GajpNMd0GSuQ-1; Mon, 12 Aug 2024 07:28:47 -0400
X-MC-Unique: 1dmgEYzoO1GajpNMd0GSuQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36865706f5eso2177946f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723462126; x=1724066926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzMz3TZb/4STKd1zC5JgrVRXvARW6dC5kvx3z4x0yLA=;
        b=I7P45Ln1iJT2oL9ZXAGj619rYsIC7Ae3ZvHKpSHlo+cv/7L3kcqGDYfbHmEDM71pn1
         ZYrUKPpvL7YUc5y76uA44KOW2F3CeHzg87GLAr3b30Xir4CkFW13Zc5vKLsVF6RNlua9
         e2wiHCyDAsfF4CiDva6F7eJGw3JqC7vHS7X77PWS0wXrfujC/46/kcxq48HlE1Qaa+Ak
         +Uxtb67gpCxMd3NYDvJgyCi9L0SabgM71HLxugttfC8BNbOprh9Yc4OudT0GE7SbkR1f
         +URpQOTw7wGfnOHrpa8Kc2s2tEU14mlbz2nyKMO9T5wYDMbbwGiJpX6tkmzAZVGVm8NX
         j/hw==
X-Forwarded-Encrypted: i=1; AJvYcCUoHMPj7QD/d5qlzM3xSKAYU4+eMpcPPaxYs5289atNu+IWwguIkkR8guNcSc/HMQte22zcEz9Ab8ywXiNEbaebPt17s8NoovrxSpeh
X-Gm-Message-State: AOJu0YwYxevIHbpbIghYwvSyZA5US7lc0USg5GIyl7OAkPXwGKR2HAEq
	jVnUpevO4MOUUOPvwhkhqJrrbgTA50V7+iKSgCVn5OJcbTRxYgMNbr+78Wg0FeRpm6csYG8ce9W
	I6bfV2c8cuPwDjWVD1U+Ik9UKfQVbtr7cA3qoQ+4o5Y56gbpHLQY6sRvaK96WbA==
X-Received: by 2002:a05:6000:d2:b0:368:669c:3bd3 with SMTP id ffacd0b85a97d-36d60ef85b9mr4936744f8f.48.1723462125905;
        Mon, 12 Aug 2024 04:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/9JYbDBo4AKSZo1vV2wWmLWk1n2QGqfs8ws+B+ZbyAv3Twi0sB3J3zuY5yY+R8tzUT5/nuw==
X-Received: by 2002:a05:6000:d2:b0:368:669c:3bd3 with SMTP id ffacd0b85a97d-36d60ef85b9mr4936720f8f.48.1723462125308;
        Mon, 12 Aug 2024 04:28:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd33ffsm7203275f8f.99.2024.08.12.04.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:28:44 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:28:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 03/10] acpi/ghes: Add support for GED error device
Message-ID: <20240812132844.1328937b@imammedo.users.ipa.redhat.com>
In-Reply-To: <909c4b6c1b90be284f1e5b653e075db7156b00cd.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
	<909c4b6c1b90be284f1e5b653e075db7156b00cd.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 14:26:29 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As a GED error device is now defined, add another type
> of notification.
> 
> Add error notification to GHES v2 using a GED error device GED
> triggered via interrupt.
> 
> [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
>  rename HEST event to better identify GED interrupt OSPM]
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c         | 12 +++++++++---
>  include/hw/acpi/ghes.h |  3 ++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 13b105c5d02d..d6cbeed6e3d5 100644
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
> @@ -290,6 +290,9 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>  {
>      uint64_t address_offset;
> +
> +    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> +
>      /*
>       * Type:
>       * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> @@ -327,6 +330,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>           */
>          build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
>          break;
> +    case ACPI_HEST_NOTIFY_EXTERNAL:
> +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
> +        break;
>      default:
>          error_report("Not support this error source");
>          abort();
> @@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, ACPI_HEST_NOTIFY_EXTERNAL, linker);
>  
>      acpi_table_end(linker, &table);
>  }
> @@ -406,7 +413,6 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
>      if (physical_address) {
> -
>          if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
>              start_addr += source_id * sizeof(uint64_t);
>          }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index fb80897e7eac..ce6f82a1155a 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -59,9 +59,10 @@ enum AcpiGhesNotifyType {
>      ACPI_GHES_NOTIFY_RESERVED = 12
>  };
>  
> +/* Those are used as table indexes when building GHES tables */
>  enum {
>      ACPI_HEST_SRC_ID_SEA = 0,
> -    /* future ids go here */
> +    ACPI_HEST_NOTIFY_EXTERNAL,
>      ACPI_HEST_SRC_ID_RESERVED,
>  };
>  


