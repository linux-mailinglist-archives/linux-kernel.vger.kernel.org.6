Return-Path: <linux-kernel+bounces-176980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDCF8C3813
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D591128233B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112994F88A;
	Sun, 12 May 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE2TLzug"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE421105
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715540764; cv=none; b=JNg7BuqXTYyux62rI3NldQ8/6fEOscyscURh8mhRK2lsqt5pE/n9/X+7FyjWsSU6xhfH7ZTVmOfGovcHh+lHbiGi3BXu6r1goeSFFR4nOVM4R8U5RRXM9/3dmG1s8WNZ3f8SQxgZeg5+9bdyJ04A5FQZPguu+aNkAEW0FDhHxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715540764; c=relaxed/simple;
	bh=pkomJYxvfv/JiLzIcMVCtNIprrxagoRmun3EoHok+P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N690lsRsZJjYdxmkHjnIyMLziBJ49/DfjRdyOGTiZvsPoVDqfXUgbuWrd1T+GEiOgb9l9R3cWbW5hjqHYOcwde9BZVjIFjSV4nl9SOZl0Yt8NXxwB096ew6AZsvajDVS2jZGaLdkhLa0FrVdugdXP7D5oApxrxlGN2SUHX2EmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eE2TLzug; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715540759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2ZvKk0goms3sOklGnb97jJLKtlDNF6jzg0t5gZGpwo=;
	b=eE2TLzugutaiITqGSRJ35megP1kRXQLERbzopC5om0rlVgZVu45Dz6oWjqh5hXRS4de2I2
	Y3N5/1CCO1EsCgTCEzw42ecMJ+PykZCdVw7lK+atdJpicnr4pqEWlqddxmNwlr2kvAQsyo
	hNuYdqQtunpHJEBEA1A4ILfa59UJnSQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-X6_5-ChpOdq2UiLIJ2HsVg-1; Sun, 12 May 2024 15:05:34 -0400
X-MC-Unique: X6_5-ChpOdq2UiLIJ2HsVg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5a194b34a6so202993066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 12:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715540733; x=1716145533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ZvKk0goms3sOklGnb97jJLKtlDNF6jzg0t5gZGpwo=;
        b=fi6SfqVIozPR1E1mmnddnb5wxyPcV3WqYLcbFnCdUH4w+R4BE0jazUzza4Fw247rbh
         kO1zLTmXdjaN/ZQnyQd+Vdui7voFFUcxoYmPe26CDMJsPol+JzWFdbfQzcZ3zrQe6xmR
         /xjLsNfm2PDQv+Zlhtl+Z3JJQGThECDjhbwLgZueYrn4bx3uZy4Cn0r0l38tKwE6G0u0
         0K/OezgSL122EU0NrJYSIz9/+h8FbcKnhCVF5uoc2J1DO7qZagvv+5OYzg57+MqwrOx4
         6DrmgpEcR8jEWLRwUOwNXvJs7y1owq91GO8c8StfOfH1QRKfrvDkfaAwoTiBXkoe3hWX
         jTTw==
X-Forwarded-Encrypted: i=1; AJvYcCW/86cu860y6afvIttIF59Tj98WDpJfP3lfiS5hdwRv2ZowZJG3Iqg7dODhghhRR8/7DPA8vT1D4r/gzxqLnSZpdmmAx+XFvFKdUjxr
X-Gm-Message-State: AOJu0Yw2Lxvfa8Rl2ThwoYThQfSdUriO3+ZyarUKmlxY4G2Dgs0VQZVu
	UbHMAQ+WfRk7bOm7JgkRw5fVPZzIX8yOnc1wIWUCPy/AtgWQAWwmTkB8HVpOB5rwiv437AdQYqm
	nURyiQIPu2umcg2v9RP3rAoeGDf9B4nmNhHAgijlO6vATdpT+XTHFFLFA6jOUsg==
X-Received: by 2002:a17:906:b7d7:b0:a59:b02a:90e7 with SMTP id a640c23a62f3a-a5a2d6a1708mr592289866b.64.1715540732941;
        Sun, 12 May 2024 12:05:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbenhfTHA/KvUCUg6h3R8WehVM4X/zv74O4qoM8gXL6m4GDTkjKiz7B0Mmx6Hqu19HHA5ruQ==
X-Received: by 2002:a17:906:b7d7:b0:a59:b02a:90e7 with SMTP id a640c23a62f3a-a5a2d6a1708mr592289166b.64.1715540732556;
        Sun, 12 May 2024 12:05:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce3fsm488215066b.4.2024.05.12.12.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 12:05:30 -0700 (PDT)
Message-ID: <c9e4b02d-6e3a-4813-8c87-769944176ff2@redhat.com>
Date: Sun, 12 May 2024 21:05:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: x86: Force StorageD3Enable on more products
To: Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yilin.Chen@amd.com, Randy.Perez@amd.com, Michael.Chiu@amd.com,
 stable@vger.kernel.org
References: <20240509184502.52480-1-mario.limonciello@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240509184502.52480-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/9/24 8:45 PM, Mario Limonciello wrote:
> A Rembrandt-based HP thin client is reported to have problems where
> the NVME disk isn't present after resume from s2idle.
> 
> This is because the NVME disk wasn't put into D3 at suspend, and
> that happened because the StorageD3Enable _DSD was missing in the BIOS.
> 
> As AMD's architecture requires that the NVME is in D3 for s2idle, adjust
> the criteria for force_storage_d3 to match *all* Zen SoCs when the FADT
> advertises low power idle support.
> 
> This will ensure that any future products with this BIOS deficiency don't
> need to be added to the allow list of overrides.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/acpi/x86/utils.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 90c3d2eab9e9..7507a7706898 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -197,16 +197,16 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
>  }
>  
>  /*
> - * AMD systems from Renoir and Lucienne *require* that the NVME controller
> + * AMD systems from Renoir onwards *require* that the NVME controller
>   * is put into D3 over a Modern Standby / suspend-to-idle cycle.
>   *
>   * This is "typically" accomplished using the `StorageD3Enable`
>   * property in the _DSD that is checked via the `acpi_storage_d3` function
> - * but this property was introduced after many of these systems launched
> - * and most OEM systems don't have it in their BIOS.
> + * but some OEM systems still don't have it in their BIOS.
>   *
>   * The Microsoft documentation for StorageD3Enable mentioned that Windows has
> - * a hardcoded allowlist for D3 support, which was used for these platforms.
> + * a hardcoded allowlist for D3 support as well as a registry key to override
> + * the BIOS, which has been used for these cases.
>   *
>   * This allows quirking on Linux in a similar fashion.
>   *
> @@ -219,19 +219,15 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
>   *    https://bugzilla.kernel.org/show_bug.cgi?id=216773
>   *    https://bugzilla.kernel.org/show_bug.cgi?id=217003
>   * 2) On at least one HP system StorageD3Enable is missing on the second NVME
> -      disk in the system.
> + *    disk in the system.
> + * 3) On at least one HP Rembrandt system StorageD3Enable is missing on the only
> + *    NVME device.
>   */
> -static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 24, NULL),  /* Picasso */
> -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
> -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
> -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),	/* Cezanne */
> -	{}
> -};
> -
>  bool force_storage_d3(void)
>  {
> -	return x86_match_cpu(storage_d3_cpu_ids);
> +	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> +		return false;
> +	return acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0;
>  }
>  
>  /*


