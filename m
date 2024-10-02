Return-Path: <linux-kernel+bounces-347556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13A098D490
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA3C1F22C52
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945641CFEB0;
	Wed,  2 Oct 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8R7Gw1j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734BC16F84F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875293; cv=none; b=pkYZl7OONg/Ql7voMVkXt0Fz0Kivt1VZOMInRug5FhKWs+R63A3/V/yaBZOhuFznPaNABgDDST8RVOVykCQ05VUnNGK4/zq/c1gH2uk0LVr4hoxiGm0ZJYT1mwUUbTgAqw3IyVB4DK3BQaq0iR0BSd/qDkPnJozoi+ur0839u/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875293; c=relaxed/simple;
	bh=5UuVOjqa0P7tzpjwNO/WOkWT78kr2eBoJXU+0dOFzzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWtvp1h/LTrBnwbXBfmYOru7jFVtJvieRvhvDaOFceRU/Zy+KuNDSoLm1ZVwXCh0Wo6vPgIoRGd67Te+0AOkdwyt7PsYVAkvzkvA4Nj8NxiGQLx5M9CK7N9oZay/XB27t947tL1GMisBRMZ2ErZgwR/jQefaid6VcHJgPIQjxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8R7Gw1j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727875290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fi2yz8P5s1N+bIPUltlWoEdasaEDLb+ur9FDivcVwJc=;
	b=U8R7Gw1jd81iFVx2ayV+BRPWtTcUPAZizWqDdzYAkImqvQhgNivdGawB0zICZo8PmlWd+4
	M6O6ttXAQQK9gRmLVs6ofdkMuBq9AaxkGkklcxEsAUUNDRFmDhRr27nSg1yjLo21PL1T6Q
	vkar+J+kPBnpO2qLy2hLELuDU9piF44=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-EXPWScWgMCmjaDmzMx2M1Q-1; Wed, 02 Oct 2024 09:21:29 -0400
X-MC-Unique: EXPWScWgMCmjaDmzMx2M1Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb6dc3365so52472675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875288; x=1728480088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi2yz8P5s1N+bIPUltlWoEdasaEDLb+ur9FDivcVwJc=;
        b=t5iqQ7Ae4HSGE7E3i2NwBtdSzg9kzXo9eoP8PvlNWXdITYAosurTslEBoXrmKYtCky
         9EfCCuJaMspNYN2jsisH8cwMXHfTxT4JjRx5yo6N6Pa3C+LVf7kBJM8Z7TaFQd0kUStn
         eGDwXPbC2ixK5kk8hKIAWzpouBqSP8X1UCZWBhPhTC5agDeyy3D3cRisGG1KBvgKnu7j
         HnPLBSRlQAbyPW1b1M96+ISk3CkmJ0sXEgL/E49tMPvD3lFm8c6IXL72C7eRlt8pfwJJ
         TxzkOYn/A7+pRhp48vaCoW6mFc/81DU+muI2jW29ULzg2+2wPpqxYGl0cLpnJtKpw/wK
         oZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCVM1LOgkC6tntGt2h2bo+rVt74wFIkYhOgGBlHzGbW7pywoSGkI+JnGKeFAXESWjEDn4g6+9nAcuR07Qsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/v6yQprZPneucQmxLmxPGGS2zBcVCXN9hn2punFwh4Q7qsXQ
	DWfUdzZXJK91jSTFMfQPzrMt+ho35bRmls9R8IBz6BsdK7vFcd/NmDw1El++LV8Ta7ENRmtscRF
	kKn/PcZbapLQsn+9x26JDN5A8VsYlOuxzOd0he/nYBEobgi/bbx/U5pWdW+L84w==
X-Received: by 2002:a05:600c:3b11:b0:42f:5209:f82 with SMTP id 5b1f17b1804b1-42f778fca07mr24075725e9.29.1727875287922;
        Wed, 02 Oct 2024 06:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa0CuSkIxupuJBALLTiHnpFUd8KhvmGmKNzGDZWA5YCsoW6MqplAwf5hNS0uMtbh92chZYoA==
X-Received: by 2002:a05:600c:3b11:b0:42f:5209:f82 with SMTP id 5b1f17b1804b1-42f778fca07mr24075465e9.29.1727875287486;
        Wed, 02 Oct 2024 06:21:27 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79db2b97sm18643505e9.6.2024.10.02.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:21:26 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:21:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 05/15] acpi/ghes: Fix acpi_ghes_record_errors()
 argument
Message-ID: <20241002152126.08438809@imammedo.users.ipa.redhat.com>
In-Reply-To: <7c2862061ef4b358154414127f6cfd231310660e.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
	<7c2862061ef4b358154414127f6cfd231310660e.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 09:03:42 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Align the header file with the actual implementation of
> this function, as the first argument is source ID and not
> notification type.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/hw/acpi/ghes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 20016c226d1f..50e3a25ea384 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
> +int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present


