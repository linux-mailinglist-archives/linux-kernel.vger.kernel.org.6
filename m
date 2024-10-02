Return-Path: <linux-kernel+bounces-347506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636CD98D399
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5D51C2160A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441B61D0426;
	Wed,  2 Oct 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzLwmOU7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FD1D0171
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873196; cv=none; b=d1EhNTeK7Y2RxWCCPGM/IwHqvsV9PV8tUOReQPUPRMl7L9/EaRE8N5iHkZpQ0KazooZpxDAeXpwuKzi4x2R3pcKKx2oFoA2FfRTDZAkCbY8kfDWV2/7cIIVjJ/OFBJVc92y9hV6r0Y+XxLdsg+8OLJEPaZbNEr+dgw10rQa3r1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873196; c=relaxed/simple;
	bh=AB7AMxPtN9l3ud2As2syfoyv5OQ+JRnUmGfoZ1xxZOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSWbgsM2LZ22xQr0j6HpqmlWqhqWN7CAXBUxmcg1pBq3x6ZTyictVq33sv/rnYPEG4N1B8ezOSmIPS/aAbSK/sMMWWYbTXpxRCeb2PlDA/HwbBRzsHgm17AUOz9G9OA/9lBvRsagn12+BjCmCHGT1DUF4K+32ufzl+G8h9YEw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzLwmOU7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727873194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRd2IPTTLSDR0JY8la8Jnse8DqiuCfGZKtSPqIBVrXM=;
	b=MzLwmOU7bPTc5rA7/fLESHz/LA3zv/KskZ3HRLcaxUhTBNtmV4Ea6E+BR5AJCYKtt7hsZI
	3K/asLMO6DiVoTEzc4P8o7pEvzKZRavyoJftiNmwYembFU8P3IhTt3G9iSGHTN/gDHLpz7
	BNDJEvqK5WXQOr81lNxVqPpBefpI0uI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-pi2XUBSUPKWiTpJ4F2OErQ-1; Wed, 02 Oct 2024 08:46:32 -0400
X-MC-Unique: pi2XUBSUPKWiTpJ4F2OErQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37ccd7c3080so2936262f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727873191; x=1728477991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRd2IPTTLSDR0JY8la8Jnse8DqiuCfGZKtSPqIBVrXM=;
        b=morqEqEGv9a78nLDS8shKYSxOjxV5PRMRwRnHAMWrTDkAp4Wwld/Csav5FX9rxawHK
         BB0lQdR2vzs7F8qhO0QkvsThQXQ8VFdStYA+BBpttj/Ak3xhOHwdCCCeowC4tO54qYM0
         qCrITnC4g4NP/sXzNaspRPdNvVxUFyrGPeNYFVuE8Uj1nrfBzYysZwYIBlYfYE//qnex
         9QiNEa2WZrlVGG8z+9UK97fdkr9FnTdb3vBK1V7yiIqQOr5eUPdma9/t4GfdFj4/coRI
         hOcfsDejzXuIhf6Q898UMoNn/arUr3YSRuj28xuBEWbo1C4uKX1ny651F3vA0SxB1LC6
         rYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgjQjfVw4Ao2pPGU5FDa+8jMR9U+75wd0VKsiWca2ay79CAtsoSsWq6RPvXAY+fY2lgxB4EBU4fuAZzlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysLUj94FWrf/9ndmLOgBvuXv7IylCRxbCUqG82vnwltKwAi4i+
	DQ6xfzMhr/plrHkYg/YQs7lDnKa6Uo3BJ5GWKX23XW0txUHD/+NIugTJvZIP9+P1UtaDgv57sfG
	qTP+0uY2OOIg8bgqZMrI7kPMNuV7uVhpY2irzm3M9e6A4woHDAQ/Ql0axeDrZ9g==
X-Received: by 2002:a5d:6283:0:b0:374:c942:a6b4 with SMTP id ffacd0b85a97d-37cfb8b567bmr2019745f8f.20.1727873191656;
        Wed, 02 Oct 2024 05:46:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2PexkVT7Txl6Bb82fMhSXSDAiku9xoeWYMrqFmP3lO1ymceSSFLAoDOWFkn8RM4zZGf3o9g==
X-Received: by 2002:a5d:6283:0:b0:374:c942:a6b4 with SMTP id ffacd0b85a97d-37cfb8b567bmr2019732f8f.20.1727873191343;
        Wed, 02 Oct 2024 05:46:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ff6e28sm17615235e9.37.2024.10.02.05.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:46:30 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:46:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/15] acpi/ghes: don't crash QEMU if ghes GED is not
 found
Message-ID: <20241002144630.1f8b68c1@imammedo.users.ipa.redhat.com>
In-Reply-To: <18c69e8c7a6b6ac365397fe1f442f3ba0cb83be8.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
	<18c69e8c7a6b6ac365397fe1f442f3ba0cb83be8.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 09:03:49 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Instead, produce an error and continue working

s/^^^^/make error handling within ... consistent, i.e. instead abort just print a error in case ... /


> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 3af1cd16d4d7..209095f67e9a 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -418,7 +418,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>  
>      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>                                                         NULL));
> -    g_assert(acpi_ged_state);
> +    if (!acpi_ged_state) {
> +        error_setg(errp, "Can't find ACPI_GED object");
> +        return;
> +    }
>      ags = &acpi_ged_state->ghes_state;
>  
>      get_ghes_offsets(le64_to_cpu(ags->ghes_addr_le),


