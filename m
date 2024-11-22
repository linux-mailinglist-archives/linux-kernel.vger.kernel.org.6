Return-Path: <linux-kernel+bounces-418488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7590D9D622E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C57161556
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE832E3EE;
	Fri, 22 Nov 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZpCMpxq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30D1DE8BE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292526; cv=none; b=f3nOea+3C7uPSXpOJiPhD4tCQEfeSV9+9u387iUpr7p2HZGjkpfvS9hjnRfqBVEQkleUDVPtr8NEhuBEGWJ1NSZpgczWWB+1ZQ2g5BH4VVEO+O6lDEqHMCIVgvmQLHs2d1t6nJD+3Z6mqfubVlqZvw4BAUh5M7bb5TkSYBR/ySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292526; c=relaxed/simple;
	bh=JtSvY87WjjwvKs7FSXTbJBnbQ2KispFsTq0UPxEWmcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7vxd0Bgx09wqD0TRrFiTVOLw6wwjuDXBvTLcGClUdOz8CpFkh35QyNlA57+3INmoeNaHgrU2uGumLppKhSjlvvHPiT2sdUiAatT0s8vrt3/0ndiODTzaOfCPHnoAToPQHbjYXBoJ9gkHRMJuLRb7sUl8ODTW6FJWa+p1pWpD44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZpCMpxq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732292524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyV4m9dJITsICN0qNNwyYDHcaqurrOEnQKifJ5kQsB0=;
	b=GZpCMpxqFQqVxOjBqmKzNplfunkNRXgFDQf5tvg4ZEoLBzZyVDZpFNoWmDUQCNKp1x0VIS
	uARVHJep8T+xZNUrJgo+2pVL0iUlvIpkyxFMLu1hWsypqH3MUEdN7XNYr1Qu3728U3a34t
	JV5dixb9ZMMjJtW1oarIaw4/4CaxI2Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-PXB0-23wOH2-kLV1SLKysg-1; Fri, 22 Nov 2024 11:22:03 -0500
X-MC-Unique: PXB0-23wOH2-kLV1SLKysg-1
X-Mimecast-MFC-AGG-ID: PXB0-23wOH2-kLV1SLKysg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso16125065e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292520; x=1732897320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyV4m9dJITsICN0qNNwyYDHcaqurrOEnQKifJ5kQsB0=;
        b=r9JgYuOCYBgR9m+r8sD+cfVmtMc4TYA1Py5t2Fm2Os3MRKY5OuwgsKRB01aGkC4bVp
         3ovMz5Nsny3AR906HzGWivY7i373b11edBqvfxp8g+7WMLhIVTxo96ZLwyjIU146FQrK
         gn5iFhBOLiK/Sgk3PNqB2vvX9DsxT5DppvrCOuuP3p3QoCx/bm2eN/0h4AIgblHnDHNm
         YHqXeH483rViiIMrs0cyP3G5oXVdoKGKv9vYq5Le0jtV1L+rp74ipTjtrKkhrDpuOUbO
         wLAbu8KSPgKERtp6+/BYfrOUhOmlgXMoO+UkpKOnMuvqdMo5jcEBiPJ154ihVKCgqIQb
         khOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXfh7an2O2r8TxB0qqga0laJnd2S6+AoxmWWeRM62PFvWqQGcPsD1lAAX3TJ7/AdLrJTGEz+P8+xgNF98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KPwavUIBC8eAUeeR1buYExmtg6zRVip3nsNetjQcZQq1maPJ
	Tj09QQam2mm/7K/fKljaHQlEgoK9WVh75So6h3pXWI48QbgwVQaI5amWw4PajHW2lfsEiAyZxTl
	3icikeCBUfWUDt2HkgmoqHIEz+du2GEQLqGT2nSwgX5mmpwXyYhVfB6ajSbTTIwx9bmXPnA==
X-Gm-Gg: ASbGncvwQwSQbZCHZycQfYZWnEjDl4aTYyKz0+l8UEmGtNCNpSUVVPDzcEfCkslFOeb
	qXlTrBqreG3oMTXqQN8djkI5b/1notRNmzKr48FQTjk2HF5eHkxutej9el7VOUjDXLxE+aTEI9T
	csFt2G9rGKdqOn6B1xVJH7IE3B6wa5dgQq375UyVYxT1x3cdvknOX3USQzM27VIsqumBqgYHlve
	0RO/HIQsmox5HwJccUS49gOGndBv2NRLVpI7yK957BU3DkVyfYq6CrCeEqFAhhL7hl2pXy0Gp7S
	8FbQ3X4jnmh4oV+C8nJ6Bw==
X-Received: by 2002:a05:600c:3b19:b0:42c:bae0:f05b with SMTP id 5b1f17b1804b1-433ce413c8emr26604735e9.1.1732292520044;
        Fri, 22 Nov 2024 08:22:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEkstkJfSxr8aGDMBPVQGktPpGXJ+GanjyrPf4YG9VrYHHxatCFCWHJCelP1CWqHq06xVoyw==
X-Received: by 2002:a05:600c:3b19:b0:42c:bae0:f05b with SMTP id 5b1f17b1804b1-433ce413c8emr26604585e9.1.1732292519763;
        Fri, 22 Nov 2024 08:21:59 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d40basm100217045e9.21.2024.11.22.08.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:21:58 -0800 (PST)
Date: Fri, 22 Nov 2024 17:21:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 10/15] acpi/ghes: don't crash QEMU if ghes GED is not
 found
Message-ID: <20241122172157.10012778@imammedo.users.ipa.redhat.com>
In-Reply-To: <d72d9cf99ad0169a39cd3f8028ee7c2e112edf06.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<d72d9cf99ad0169a39cd3f8028ee7c2e112edf06.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 10:11:27 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Make error handling within ghes_record_cper_errors() consistent,
> i.e. instead abort just print a error in case ghes GED is not found.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index ad7d895def2a..25587f5fc9ab 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -371,7 +371,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
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
>      start_addr = le64_to_cpu(ags->ghes_addr_le);


