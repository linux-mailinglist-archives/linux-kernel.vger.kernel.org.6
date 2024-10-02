Return-Path: <linux-kernel+bounces-347553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C977D98D477
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED43A1C2125A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDC21D0424;
	Wed,  2 Oct 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8OZRzux"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC021D042F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875237; cv=none; b=TE8hapaBTRQcsjYJ+zWuTnoyFqrh7SmvvQTPGPGDWTU9PpQHV3byUf1dpx+mm1qQiw83y0rXVP6DxkHx8+5ccLuoabM8IXAmHmRWNgDyLBMUoW6YeUMIPZPRcghqFBH7WufscJx2nIspo6ornm8KDzp7NCZEyqoH6RsMuXoBA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875237; c=relaxed/simple;
	bh=0LgmpLRS+Cm01PeFwvxQbDghajaOb+lOSaWJlDnYwkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8WvmAfDG9j+ym9iQE62sIlbMCkmAkmnXrjvUyYlegJAiDh9AF6f3UC682KA9M4oGMzpZj56MBTo1Q/E8TBRaynMMYCscJm/cxnatKgiEMHltuEH7IYsno71k9iZactAYX2a71dQhft64UASP+sveR0h6/s/Zp/LFSu+rf9J+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8OZRzux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727875234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8G6I2i4FaDHY2EK/vvbx77DXkVZHXJ6ZumTYcL076I=;
	b=Z8OZRzuxZ4mKM1nYo68OgWj3x7eG7UINura4JtW7u55xEL++vFHllJi/vfGTluu3zmG03d
	lUWArNUY0s3YdlLTc+Tyj2J+nuK8CiGbhYiqYBc1oPMdrMBAmdjeipgjt5Uba/Q7w6moXW
	DZax8nR4i055fTbM1+1b1JYGwXDp528=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-VHoweW2CN0eg3Qq8Uog5Nw-1; Wed, 02 Oct 2024 09:20:33 -0400
X-MC-Unique: VHoweW2CN0eg3Qq8Uog5Nw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb5f6708aso41388675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875230; x=1728480030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8G6I2i4FaDHY2EK/vvbx77DXkVZHXJ6ZumTYcL076I=;
        b=gmrPgkl0JFW7+LiLO2aeq7IeUtaIqNkKQtkt2Xk4q8d6p3G5K1xKc5I3OgywYA55hm
         3U/BIsHb7ekVsPems0tGcI+siv5TplBGSTrzUPNlbEJQWNLM4PB/e/woN0L7VjBZlnHY
         eXNNUFr2mNFLUQY1uRiB1gDCxPBvnN1kGXHA8N/7Eoyi0HIubtoXYw3eTy6+1tjrLqhy
         Mdo+ZFMuzwQl6kUwzwVXQFDPIBblePu68N19ZEwvsZ/ap2z4ezJ/M3QbPkMoky9tnewL
         Q4PxYXmxZBrOmrhxReYW5ZijRRFLHHuDweGmIdOnfMMSlnpOJFP7Dlvn1nvkriGkEHra
         dM1A==
X-Forwarded-Encrypted: i=1; AJvYcCWPPk94SDvE8YkmVvcvQBc+QqBnDm6pHsLb0NaGnQVk/hQJSNl1hIxVpI1r7HhWvNcciKDQlLs8N5MiuAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxucM4PB421R+i+ymS+dgV3wIdSzqP4Kq6Paazr5rkWRX0fbAuo
	3EEmv/OL7TkdcrjsVQK+QvxMIkPY6MPSvTuOXBTz8crguErlQNjMUKNYMJUPPpzs6Fb9W3wsOJ1
	sRKapF6SxBmZCXxEJ8IUiN12fNgMJ/NIcEldSWdloengoyM1+4IlklleWQgoiHLcWz+W8yw==
X-Received: by 2002:a05:600c:a4b:b0:426:6edf:6597 with SMTP id 5b1f17b1804b1-42f777c7ea4mr19128865e9.19.1727875230519;
        Wed, 02 Oct 2024 06:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ+dzAihiBsY9l8Oiv6bvplCLVDGsi0Vh04FiMpWB5vmn9nn14wcdtaG5jGl8wWqU/T1F/KQ==
X-Received: by 2002:a05:600c:a4b:b0:426:6edf:6597 with SMTP id 5b1f17b1804b1-42f777c7ea4mr19128635e9.19.1727875230121;
        Wed, 02 Oct 2024 06:20:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ead1absm18404085e9.17.2024.10.02.06.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:20:28 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:20:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 10/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241002152027.6b90e8cd@imammedo.users.ipa.redhat.com>
In-Reply-To: <84226f5976fd29e23ce47d3a5cd311821c8111f8.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
	<84226f5976fd29e23ce47d3a5cd311821c8111f8.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 09:03:47 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Currently, CPER address location is calculated as an offset of
> the hardware_errors table. It is also badly named, as the
> offset actually used is the address where the CPER data starts,
> and not the beginning of the error source.
> 
> Move the logic which calculates such offset to a separate
> function, in preparation for a patch that will be changing the
> logic to calculate it from the HEST table.
> 
> While here, properly name the variable which stores the cper
> address.

I'd move 14/15 into the beginning of the series,
so this patch would look a bit more sensible.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/ghes.c | 50 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 628fa9b22f4b..900f1571bc97 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -378,11 +378,36 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> +static void get_ghes_offsets(uint64_t ghes_addr,
> +                             uint64_t *cper_addr,
> +                             uint64_t *read_ack_register_addr)
> +{
> +    if (!ghes_addr) {
> +        return;
> +    }
> +
> +    /*
> +     * non-HEST version supports only one source, so no need to change
> +     * the start offset based on the source ID. Also, we can't validate
> +     * the source ID, as it is stored inside the HEST table.
> +     */
> +
> +    cpu_physical_memory_read(ghes_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +
> +    *cper_addr = le64_to_cpu(*cper_addr);
> +
> +    /*
> +     * As the current version supports only one source, the ack offset is
> +     * just sizeof(uint64_t).
> +     */
> +    *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
> +}
> +
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> -    uint64_t start_addr;
> +    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
> @@ -396,27 +421,14 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      g_assert(acpi_ged_state);
>      ags = &acpi_ged_state->ghes_state;
>  
> -    /*
> -     * Current version supports only one source, as assured during table build,
> -     * so no need to change the start offset based on the source ID.
> -     */
> -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> +    get_ghes_offsets(le64_to_cpu(ags->ghes_addr_le),
> +                     &cper_addr, &read_ack_register_addr);
>  
> -    cpu_physical_memory_read(start_addr, &error_block_addr,
> -                             sizeof(error_block_addr));
> -
> -    error_block_addr = le64_to_cpu(error_block_addr);
> -    if (!error_block_addr) {
> +    if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");
>          return;
>      }
>  
> -    /*
> -     * As the current version supports only one source, the ack offset is
> -     * just sizeof(uint64_t).
> -     */
> -    read_ack_register_addr = start_addr + sizeof(uint64_t);
> -
>      cpu_physical_memory_read(read_ack_register_addr,
>                               &read_ack_register, sizeof(read_ack_register));
>  
> @@ -437,7 +449,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>          &read_ack_register, sizeof(uint64_t));
>  
>      /* Write the generic error data entry into guest memory */
> -    cpu_physical_memory_write(error_block_addr, cper, len);
> +    cpu_physical_memory_write(cper_addr, cper, len);
>  
>      return;
>  }


