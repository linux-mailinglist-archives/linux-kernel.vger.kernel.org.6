Return-Path: <linux-kernel+bounces-349126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B2598F15B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05ADD1C20CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38EC19E967;
	Thu,  3 Oct 2024 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYUl0MKy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C31CFBC
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965656; cv=none; b=iyhH0E6Rr6uqlrBmf3JvVz/IDK4SwSFid3/eaKSMv0jWXI1NQe8LG9yESuQMxTKv6bWPMAz90KLl2kM8Uq9dz3oK1KPRUq/YnWyrw+qu2gjAaVpqs79U8RbsP/brpp3QvQBk00Zlh02MNZg2CWxEDz5gda8l/wjPOHnQYsrTeWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965656; c=relaxed/simple;
	bh=2H9N41lOa743gHarwDbZz2BDYAZgwD99s/YFhFW2eqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqsFnYDW1wRmQ7DelywR2wnoBd9d95Sx7YjS2RdC+lo8IPoDhfta2K2pD7RAAA8l4g6OALIkhPzX60Asi59d7w3FIxjN67f0yXZPMlPuLu+HqavkEgsukdt3yoC82tdoBTSNZ8Ljyya/zJSr7fX4hVY4XddhAWoXqfKXow5g2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYUl0MKy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727965653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pJZobA60sAFaK3pApVWkQmuKWb0cjI4YlaaOYgdqzI=;
	b=TYUl0MKyA6hix3Q7qj1JcYlBb23m53/h1K2FD3PhuKxyCiEwCawSW5CFFZSthYqLZuGe0a
	XTh5C2tP33xyq2zUFt4eHxP4TY0LTpb2mh/GJtItX9gppf9QtXbzO3DO6+o80/pTrJwikW
	uJGBD2ASfXLzBWNBuFUnhMFf0JwBJJg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-BL0-0mBVNru7Bx50_KeRmA-1; Thu, 03 Oct 2024 10:27:32 -0400
X-MC-Unique: BL0-0mBVNru7Bx50_KeRmA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cae209243so5574335e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 07:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965651; x=1728570451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pJZobA60sAFaK3pApVWkQmuKWb0cjI4YlaaOYgdqzI=;
        b=v8SGnzNqeqBd7yQCoY9JX5WfE9PL4WnCmYr6PAFyx6bAYFrC2X199L+2QYxKOi3pNQ
         J8EhKxiO7kEN2Os1fA/BeKtStzBIbZW2VO7cK1K8GtzNzQ02ZxtVv+qdb938OMGTqQkf
         UtKs6PrJqanoqtpi4pVnZlh8QnQfEOmWnAi/lIcjte3Qs6BikhICDvcUlAJeGcDq4E6M
         F1YOFkTqxTb6Id3lihTHFZ/BHudp6GYOvL5F8RclTLx/Uhzn9DCkBq96MmgmhSOm73Wp
         /c/gKdY96atmgf67eXUFUYaN7EbD3KgzPsO3JRG+RePu7stp2mcGPW2d/paRO8HCaMiV
         8Gqg==
X-Forwarded-Encrypted: i=1; AJvYcCUNlD0sPxB2Ws+OcU0vQz8mmWdgu9xOPDetoBr123X0+WbuAeKSa4zn1DrTGrDxve+q3dG45NHmFHwypqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9UrLCIRVTFPns3mMubd1q9dOxrgXl/+MkuhOKzbUntoZv0LlR
	OJX27obDpjipCHWXdVT5ok2BQlUGZWvw3045PWAAz9xWTVoRv27isYzlOlLqbTctcDcltA5nKsJ
	1+WBHDqI1BEn3Vyd7OtNCjjtPPOYPOTXXzJLmqZUecVHmDjvTkMWMWjnQwPFFSA==
X-Received: by 2002:a05:600c:1c04:b0:426:6158:962d with SMTP id 5b1f17b1804b1-42f778f17b5mr41060305e9.23.1727965650638;
        Thu, 03 Oct 2024 07:27:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnde61JPLgejKdLJPeGP1RyJk7X3RYeBhIql5q+2I1+Eaui6EGqEsyK+CzUCX61mnghmU7Jw==
X-Received: by 2002:a05:600c:1c04:b0:426:6158:962d with SMTP id 5b1f17b1804b1-42f778f17b5mr41060175e9.23.1727965650166;
        Thu, 03 Oct 2024 07:27:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802b2805sm16826775e9.44.2024.10.03.07.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 07:27:29 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:27:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 4/5] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20241003162728.1de6fc62@imammedo.users.ipa.redhat.com>
In-Reply-To: <176693e011a411db92be9e912bfc4a9da0e664b7.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
	<176693e011a411db92be9e912bfc4a9da0e664b7.1727782588.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 13:42:49 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Create a new property (x-has-hest-addr) and use it to detect if
> the GHES table offsets can be calculated from the HEST address
> (qemu 9.2 and upper) or via the legacy way via an offset obtained
> from the hardware_errors firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/generic_event_device.c | 1 +
>  hw/acpi/ghes.c                 | 2 +-
>  hw/core/machine.c              | 4 +++-
>  include/hw/acpi/ghes.h         | 1 +
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 49ca1fb8e84a..c4677c9ae6b4 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.hest_lookup, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 313a6e453af6..86bad865168c 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -513,7 +513,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    if (!ags->hest_addr_le) {
> +    if (!ags->hest_lookup) {
>          get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
>                           &cper_addr, &read_ack_register_addr);

just fencing off lookup is not enough,
to be compatible with qemu-9.1 (virt-9.1) we also should not publish hest_addr fwcfg.

Also have assert (to be removed later) to make sure that we put only
1 (existing) error source in HEST.
When you switch to multiple sources, this will become a condition
to switch HEST generation between 9.1 and 9.2+ variants.


>      } else {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index adaba17ebac1..b58afe48aa71 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,7 +34,9 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "audio/audio.h"
>  
> -GlobalProperty hw_compat_9_1[] = {};
> +GlobalProperty hw_compat_9_1[] = {
> +    {"x-has-hest-addr", "false"},
> +};
>  const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
>  
>  GlobalProperty hw_compat_9_0[] = {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index a07c30ef13b7..040d6ee366b2 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -61,6 +61,7 @@ typedef struct AcpiGhesState {
>      uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool present; /* True if GHES is present at all on this board */
> +    bool hest_lookup; /* True if HEST address is present */
>  } AcpiGhesState;
>  
>  /*


