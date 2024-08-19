Return-Path: <linux-kernel+bounces-291973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB7295698E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A7CB22AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA70166F11;
	Mon, 19 Aug 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUwYqSx1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15564167D98
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067793; cv=none; b=AFcXG4WUa4Wcz7oVtBOULruu+vuuoCkZCE5oaeTywtOoIjvK687gAhPPJf/OonAyV4k1fj3co/nEFlrQqCmjr3EMAAJJlHMRPGBTM81dOh/ndHnGHUzD9zwXjtHD7OB1HH0V7t9auQrndnpEyGFAbV4V59LsRX3YeiBAGqBSQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067793; c=relaxed/simple;
	bh=EaygkjFGIAu2ShlMJxvNvgaxZwiMBgPK6i8/kWqrpn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcQKlazSNZtC167sNO3bPTLvDHniYFTwHqVjuNqCX7ep988V3HcIXZMkzWqxSHlslqkOUgSdX7tS1OmJsd2qYr6W2Dhi5jZTOrHc7gXWpUWvY82526w+dRg3YY63X+6OX2TJZXckHvxXs1kbhfjYDhNrAVEiZYRxn5BuOIh3riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUwYqSx1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724067791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17jyWeoONpjyGGI56CQoEQmnYqkX6odmOILY01oA+ic=;
	b=GUwYqSx1/obrv0o9IrbfxsklNNTOkTpqw9AzyebZoeZ28cxHMU1v2HS4klWs65uMXdGy3V
	SyID2A9y1o0mjCS51UXpOs4VtqJmBkGvQqaQJDykuzt1wN9wqktPu7DsBTJ+Mr5o7AHiKv
	agp3elSYfJM2SWv7XuWhPWX0tsNvNZA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-9bXzfe_gNRi1vLrFDwehNg-1; Mon, 19 Aug 2024 07:43:07 -0400
X-MC-Unique: 9bXzfe_gNRi1vLrFDwehNg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3717cc80ce1so2602338f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067786; x=1724672586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17jyWeoONpjyGGI56CQoEQmnYqkX6odmOILY01oA+ic=;
        b=HNGH5YkbJ8Z9a65VlRkeauQT4R3H5hLsrJrnpKpUrWYxrL+4vnjTP4lg+05Mtrni5I
         m2PSvvysPmrOpGnadfgBSpd4K+897M6o21CSIs5ymgYlh+QS4zaZWfP0sYe1uG6O7XiZ
         R068gE0iQ+V4qM3bjMdxtKi6AKv2ybpdccAKiROQgkBvoRH98mTZHFjZsVcbpPwWIyrb
         ChPXC6w4wSE+5qBwOoexrNnO9WfmLSAuqYbt1+EXyJYz2KrUQw6Y60yvnbGb+k1P32LV
         e3SVKFIlpLfO6NR85vmrhDM2lOSBY9HWjcaJgKuvbEWKP+NC8kiiFKNCr+V949M1tVk4
         5Mgw==
X-Forwarded-Encrypted: i=1; AJvYcCVhhmS7heKgDQHLY6nUe82kfZ8vY5cq5N6e4XyB/8/6CEjNOeaqENNR1J4/2ix1v/NgNWHghw6VWsahgwqD7PIvuFOg/E5Hx5+JFYA9
X-Gm-Message-State: AOJu0YxWOMjMYyM37yKthLQ8CAfCzcAzriq/YjoyFhQKZBBh07O7Xzfc
	OKntsHFipaIUIgXElBNF4qUcZ0OSh5urxXzQbBPyxHVm/i4+jVMcw7/d/bP1TS4gBrxUTFhzNdi
	vtskppmTpgVt/M8vzQVnxlJ8p1q1Syofyzzv0LrycK3KbKpCU7EGLEbiGZ+YOjg==
X-Received: by 2002:a5d:670d:0:b0:367:9903:a81 with SMTP id ffacd0b85a97d-3719469fac2mr6086917f8f.43.1724067786436;
        Mon, 19 Aug 2024 04:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWyMzsfmGeIApO4W5+0bsHLh6op/eqv7THYktyM6hkYdNs7seHGgscXFYllJRCPq6znqduEw==
X-Received: by 2002:a5d:670d:0:b0:367:9903:a81 with SMTP id ffacd0b85a97d-3719469fac2mr6086901f8f.43.1724067785934;
        Mon, 19 Aug 2024 04:43:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2eesm10352516f8f.19.2024.08.19.04.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:43:05 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:43:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 03/13] acpi/ghes: Add support for GED error device
Message-ID: <20240819134304.68c54eae@imammedo.users.ipa.redhat.com>
In-Reply-To: <ba1864f1aa7073abe090eec0c31915f187967140.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<ba1864f1aa7073abe090eec0c31915f187967140.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 09:37:35 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As a GED error device is now defined, add another type
> of notification.
> 
> Add error notification to GHES v2 using
>a GED error device GED triggered via interrupt.
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is hard to parse, perhaps update so it would be
more clear what does what

> 
> [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
>  rename HEST event to better identify GED interrupt OSPM]
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---

in addition to change log in cover letter,
I'd suggest to keep per patch change log as well (after ---),
it helps reviewer to notice intended changes.


[...]
> +    case ACPI_HEST_SRC_ID_GED:
> +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
While GPIO works for arm, it's not the case for other machines.
I recall a suggestion to use ACPI_GHES_NOTIFY_EXTERNAL instead of GPIO one,
but that got lost somewhere...

> +        break;
>      default:
>          error_report("Not support this error source");
>          abort();
> @@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GED, linker);
>  
>      acpi_table_end(linker, &table);
>  }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index fb80897e7eac..419a97d5cbd9 100644
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
> +    ACPI_HEST_SRC_ID_GED,
>      ACPI_HEST_SRC_ID_RESERVED,
>  };
>  


