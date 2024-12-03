Return-Path: <linux-kernel+bounces-429387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C9F9E1D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F19B42AB0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1DE1E47B9;
	Tue,  3 Dec 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFGmSD2Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41891E2312
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226781; cv=none; b=hblbKQgkw3RlhdxHkrD+0NJ+ExR9jCTKrPZX5sxMfNwSUeXubaYIs8K8rdRkfplF6MXFDUod0oabKyWkFclPKNXQ69qD17mdiLtsEGsA785fjhSuGDDDz8ujFwKIGOG/yF999pOQQEk7BiLRDxme+YTWq2qvdqaJvjrQ+3Lrr40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226781; c=relaxed/simple;
	bh=ooVry/laSihhT/MMtId3YlrgmbsfAUcDSFHUIRs1cPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwoI+VkY6tpyVoet1tpwvOQmwGu24tdIYjKhSRr4wpri+qLcdtOuyBPD97mBctk1Iz0/cvSxdGopHxX1HP9isV52epVchlpwTdFqRVM4M4WZeT6I8znSdB544yUkPRB7nMSh4O9toQHxJwFUcWa1j7X7PFNRerItLdVur1FsUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFGmSD2Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733226778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=if0eS42ic4FtOI54nNA13X1+b8OGQFDK6o4TLYIRToo=;
	b=GFGmSD2QehFzBlvtH8+FHlAeTD7O/msgoPgpwXwlY2PRDqUVzkrGIfpzhOqigsCzy/CYjh
	t0FEabtd1VyWkv/5x7SoHrbWa27WP0q6+lvfMG6uQdAs4iIWwI9Evr4YVb+TYzGTytXRxi
	MTnpFI9JryR8rMERtUwtUasBbzXp6Y0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-goMA2kyyNpi20OgNk-iLjg-1; Tue, 03 Dec 2024 06:52:57 -0500
X-MC-Unique: goMA2kyyNpi20OgNk-iLjg-1
X-Mimecast-MFC-AGG-ID: goMA2kyyNpi20OgNk-iLjg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434ad71268dso30069585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:52:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226775; x=1733831575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=if0eS42ic4FtOI54nNA13X1+b8OGQFDK6o4TLYIRToo=;
        b=LIZgJT0ATQq8yjvOIL1W64Pc3YJRb4PXITqY8v1Ta1UItfp/GT65yRR1Dq3oSD7/Sx
         z5fZRnxh9GHjqWQkoN5VhI7cIf9z6ncmq6d06lAuUph9UwbiHJPR7BDeuAO5O81pyKiB
         7FItgbZYkDfiCKrEJCI0YGBLh5ML6tJoSa+JNx9v7D4Eqa/Ggg5k3KPb44WOQTOfc+49
         Cvx+CgONKjEokla33k1pg3AHZXY8opwQq0d5rqAcStHsaryK9S8KWHdTerXE0u8DJ6RO
         KwVatRkNYRPQC+5duOZgKPbSBI5dLdoLcPghy0psW4wBjTA1KHuNMN8RKxFAc3pL56JM
         v8/w==
X-Forwarded-Encrypted: i=1; AJvYcCVIfPCoq7DTd1+6ucuSj8NpnkI9rRviVGgMR1QLrlupVTZkSLJmC2IUndF1rCwVdXwKztKpzmZjx0v/t88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsfOjrZsOcmH9BiRJv+awfwQvPyl18DamIurkfcO5hlXCTVNln
	npi/LM/ZjO82PpSUJ191RRk1u71qOoJ2Wiae3cOCmZevQHX8+rbWnMw+cUVzsVdVjBaqPZNL6h8
	CZ/kRpyRV1D6rSlSyG3+Q1ME3C+pT7ARuF4UhoWr6B2vxBBb31Pj3CUb2FJlVHA==
X-Gm-Gg: ASbGnctxbEuw675YeUrS0Hf1JvXcW1uhvP9iOgzMmBU3B+hhpO8tqdyIAa+KbSCeixr
	gWJaieM9jM3owX9cU5m12QxumDXNTkU6tFK3l7jQLCOJ2Rd3DFUAHETX0vKeTJQrMG9wZ+0LmpJ
	Ok6ncok6RR0jt20qoJ84m9qlUltKiOqhlU8SJWD49nlZvS6AZY6CEGoAf0jc4OWtKC38VexHeAc
	L4OpMZ3+ynPn9W+cfXhGlaOLJKxyBI4p+lxpMUINQxYJAV4JE2n89J3Q9ylYIFEryjU6uKuQ5oO
	/kwoKw7FZhedqGsKbJTOfw==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr192833175e9.8.1733226774917;
        Tue, 03 Dec 2024 03:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxOz/gJmc3Ivz+XXCVg78C+KOFX7mhlXMTseV2ZbEE8L+T7U/tPYdNEWcyrVrhI3wXoR2XvA==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr192833055e9.8.1733226774600;
        Tue, 03 Dec 2024 03:52:54 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7804fbsm223249265e9.21.2024.12.03.03.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:52:54 -0800 (PST)
Date: Tue, 3 Dec 2024 12:52:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 14/15] acpi/ghes: Change ghes fill logic to work with
 only one source
Message-ID: <20241203125253.5a11194b@imammedo.users.ipa.redhat.com>
In-Reply-To: <cf16e0900e10c5a39e11b590f5267a4b9c228060.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<cf16e0900e10c5a39e11b590f5267a4b9c228060.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 10:11:31 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Extending to multiple sources require a BIOS pointer to the
> beginning of the HEST table, which in turn requires a backward-compatible
> code.
> 
> So, the current code supports only one source. Ensure that and simplify
> the code.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index d99697b20164..b0b1865dc8d3 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -387,15 +387,13 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>       * As the current version supports only one source, the ack offset is
>       * just sizeof(uint64_t).
>       */
> -    *read_ack_register_addr = ghes_addr +
> -			      ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +    *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>  }
>  
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
>      uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
> -    uint64_t start_addr;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
> @@ -412,11 +410,9 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    start_addr = le64_to_cpu(ags->hw_error_le);
> -
> -    start_addr += source_id * sizeof(uint64_t);
> -
> -    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
> +    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
> +    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> +                         &cper_addr, &read_ack_register_addr);
>  
>      cper_addr = le64_to_cpu(cper_addr);
>      if (!cper_addr) {


