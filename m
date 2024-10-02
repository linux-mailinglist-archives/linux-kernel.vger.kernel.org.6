Return-Path: <linux-kernel+bounces-347790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D998DEB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6991C23B08
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036931D12E1;
	Wed,  2 Oct 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpIE4CBc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0161D0E01
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882151; cv=none; b=ZP4dfHM0kzzd63TiDiL55X9SYAOjX3Sun3GIarjw23zo5nE2ICnLOc64+meXLCtlgv96Zuk1XzLmscDRT0iep9XwX16Ytdiy5j3hJpedwD2utzfvsy4XcR4HM6yWv9m/5UIaJln7Td3LE4fFyj+5Ru9IAJe4iyk+qInCiefWPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882151; c=relaxed/simple;
	bh=8P2XAvfuFKQp96Xpg+yc1aJznvN9jQAE7/xqNSIdRSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N960ODVq0hLNd3UzylWtNkQB1uB/fsEJADhdAHqiljxpQ1Wk3SfVsUMgk50XisLDzN22YgVdHaZd/Pq9uzTHP31ljEUh7WQwu3orZS24eHKTirS8Hf1rqUjyqyFMJUH106aDZ39KcaXFaSKN2+UyN3N1EOWb8Qgf2naBdQpim/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpIE4CBc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727882148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RG7pacTsb3Z1pKhgoiCAeMHrnd1TFk28biALoK/dBSA=;
	b=DpIE4CBcdmhp4n91jt3tuBFC1KM9S5cY/ktZnNFWk1uwqYVtMeGXaUFBsVER4yJkmm6q6F
	nmC0/CSmdYvYqmmd6aR4UEy3bOVJ6S8NDIHRei30xhPLJ4n0oujhG8wuZBD4fcqT6G/5p3
	FzdtB/yQLtLG6ZV1CtUEU5Zi+H2aWFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202--1V2uJo5Oj6vM8S1UF_mfg-1; Wed, 02 Oct 2024 11:15:47 -0400
X-MC-Unique: -1V2uJo5Oj6vM8S1UF_mfg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42ca8037d9aso44633095e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 08:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882146; x=1728486946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RG7pacTsb3Z1pKhgoiCAeMHrnd1TFk28biALoK/dBSA=;
        b=dojX1lUUgJ/QfENuSTYCkzcjgotctteEyby/36aZD7W8egeJ7innULTiIAaSIMay3h
         DirUtEl2nKLmDEIYtsDMtDHm2bvYM/4Ewx36SYkhONWP2NmlW6VjqxdshI/csRKihLbM
         gDtgLu//gGwua4W0f+nU1nCzkKJkgYeIslZcXWNmKZjQkPWPdCZCLM6hm9f+KeUudXM6
         i9UmcFTaZEITWJ3sa3TxB8nzXm8I8snzgNLryuk7Ic3kL86Pa204vtwJxQXkrA9obxSc
         lAR2aqGNWkcz4hPcuaqo77zfyr5VfkSNRq+trcHi5RPXtwW5xL3yyf2YHkDP7Yh9oqoS
         X/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvgunFdCbCMTmgfVw/KpYzwCvME19DNtCFkUUZZUTyxvOcoDrtnT/litZkDCh1GNh39jhn0mggbvn6y08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2BCMlZcLOcBUjBT+BXzkMnFh12iSZ9gSqHt6nKipgfumWySna
	2EB/ulNzEpmTEDQIxbWCBFdhkF7k+FX7M8vMzEaWugTiZ54tXTlcUal9y2W6vaScZEM2o8xdEOW
	FxUmAZfnvGcRuHr4kRusgs0mJEgkvYF51/NxrquZJP7F90vnssfao1HdT8MltHw==
X-Received: by 2002:a05:600c:1d1f:b0:42c:b22e:fbfa with SMTP id 5b1f17b1804b1-42f777dba40mr23824575e9.21.1727882146012;
        Wed, 02 Oct 2024 08:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsK+5K05akORUjistIGZUjbBnDCo25jpAOQvMzy3UiB8KuFLG4FXkVEoB0X6hHQIGL2t3orw==
X-Received: by 2002:a05:600c:1d1f:b0:42c:b22e:fbfa with SMTP id 5b1f17b1804b1-42f777dba40mr23824365e9.21.1727882145626;
        Wed, 02 Oct 2024 08:15:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79db2b97sm21240245e9.6.2024.10.02.08.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:15:45 -0700 (PDT)
Date: Wed, 2 Oct 2024 17:15:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 peterx@redhat.com
Subject: Re: [PATCH RFC 3/5] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <20241002171543.703ab6e1@imammedo.users.ipa.redhat.com>
In-Reply-To: <d29cdf2bbb67c660142841c2d854db280c18e5e0.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
	<d29cdf2bbb67c660142841c2d854db280c18e5e0.1727782588.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 13:42:48 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES migration logic at GED should now support HEST table
> location too.
> 
> Increase migration version and change needed to check for both
> ghes_addr_le and hest_addr_le.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

other than minor issues below, lgtm

> ---
>  hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index d4dbfb45e181..49ca1fb8e84a 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -369,6 +369,34 @@ static const VMStateDescription vmstate_ghes_state = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_hest = {
> +    .name = "acpi-ghes",
duplicate name for section, we use that already for hw_error address
I don't know ramification of (CCIng Peter)

Perhaps
s/ghes/hest/



> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool hest_needed(void *opaque)
> +{
> +    AcpiGedState *s = opaque;
> +    return s->ghes_state.hest_addr_le;
> +}
> +
> +static const VMStateDescription vmstate_hest_state = {
> +    .name = "acpi-ged/ghes",

ditto

> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = hest_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> +                       vmstate_hest, AcpiGhesState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_acpi_ged = {
>      .name = "acpi-ged",
>      .version_id = 1,
> @@ -380,6 +408,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_memhp_state,
>          &vmstate_ghes_state,
> +        &vmstate_hest_state,
>          NULL
>      }
>  };


