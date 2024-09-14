Return-Path: <linux-kernel+bounces-329491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A29791FE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B2E1C21536
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E81D095E;
	Sat, 14 Sep 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaXzLoFU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3E1D04B8
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330214; cv=none; b=R6mT3dCcPlpHFMvXzwCOlt1i+9iJW7xdnotBG3fLea2AS9Cy2TkP7BK9IiQlQR97n5m6FH2HyWcBrHk5OLnB2mugbQ341vmJjmqUp9LhGNc+Q6pwS9oLulCGPl0DvbPW9hMG2jthIA+X7VC8jw3TqBQT1uYdPoaRpD7LEw8Czas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330214; c=relaxed/simple;
	bh=8AOCxFfb7j8DcfInrSLgYDK9nmwjDzPAdDYsIDvR/lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ7xi5IeHkJRGmSgAzRav193LRND0+JFOF39NJaXZutD+nnuAdUrlSYlBelMlB15vde5lQTZ24otrF5zzC0y7YmwM9JBnpBw283/EJdopagw800h7ZDiGIDmCdgLU1E7npc28+Zo8uoVu6ZClyd6GlY462rKs6hWmpVJ/lO3P6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaXzLoFU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726330211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVjWpjqJODWBhVoOOIKNl587HfNajGvXg1O8JyOtZI8=;
	b=BaXzLoFUNrnoj5arWZLk3GUMTIIYYzsgUgJTmQMA+a+F0cntdCkNDTCbQDUbKT1qXQzz2B
	+Fl6BU3Pa83xwrPFvlfyY55T1Iu+Agd2zJAvfsUOggXY/vmB67ZfjLkh5+PxCqQyZrz0f3
	FRbHiG58dbuVCQ1x/2p+NRgsOez5/Vc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-sWIfxNsFOJCaQoo_AR9UXw-1; Sat, 14 Sep 2024 12:10:09 -0400
X-MC-Unique: sWIfxNsFOJCaQoo_AR9UXw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c25cf44030so1982191a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726330208; x=1726935008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVjWpjqJODWBhVoOOIKNl587HfNajGvXg1O8JyOtZI8=;
        b=jaR/t2GtlTdJZfe3smeZKlYFbE4FOBImVt16vptsKifyJoHrFKXwAN+hoyKlO60IBK
         8bK3tSlzPPzz8D0nY8cxRqpUCZNZwKYFQcOZNA1Tkj1V8P2zp99Eda2pDsBfTgJmAMya
         Lo3Mpi5JutVTvTcQ4LSjlZBceaKYlC4/ic4DiC1CCFlsPV/tnTay1yB9yBmxZWiHXKrD
         VTSVRXGj1GD2trQBVph5tVjap/iYy4YnJI0kRbZuloceABTTSfm9c4hh/NEdNmqSfBwp
         YjpPse+gKT+GyM9ML2gXtXGVRUizFe6H0ExKJp11FzQlk4ltMaS6g/lxWN++oW0giNQS
         uXcw==
X-Forwarded-Encrypted: i=1; AJvYcCXrdIX7oQNqL7jKKa84+eAi5Yck4ddI85aZqSqT8VLx26N8X5Mk4zTwKZ3nxkCWhGzPpNEHNssl03ju0mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetYHk9D58NlxQBQZIiN7Tu5yDAhPeGLAr2jjHlmOF+v+/sAAi
	OAdCPu79Xxzd1s0uvSK5tjF7Wr+/TJuBAGFdCDnbfx5PzZ0rBjtYvy6oHqadj13xLJfSLRp/zHo
	j89O0p6F4qjh7WgkNm/PtpAPYU4TJCks5gcn2xeTESkQyo5g03LGSHKvRZcar2Q==
X-Received: by 2002:a05:6402:51cd:b0:5c4:1d22:9fd0 with SMTP id 4fb4d7f45d1cf-5c41d22a03emr5251871a12.8.1726330208544;
        Sat, 14 Sep 2024 09:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnSE/Qvo9dn/cOeU/e6N9e8WObdZYM7N1mwuFdI0DuIuqajIEaNoiroJO0uOjqGvDq2PqXqQ==
X-Received: by 2002:a05:6402:51cd:b0:5c4:1d22:9fd0 with SMTP id 4fb4d7f45d1cf-5c41d22a03emr5251843a12.8.1726330208020;
        Sat, 14 Sep 2024 09:10:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89c7fsm773079a12.67.2024.09.14.09.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 09:10:06 -0700 (PDT)
Message-ID: <f987b71a-361f-4d4e-a2d1-6410f4b22cc7@redhat.com>
Date: Sat, 14 Sep 2024 18:10:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/amd: pmf: Add quirk for TUF Gaming A14
To: aln8 <aln8un@gmail.com>, Shyam-sundar.S-k@amd.com
Cc: ilpo.jarvinen@linux.intel.com, luke@ljones.dev,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240912073601.65656-1-aln8un@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240912073601.65656-1-aln8un@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/12/24 9:36 AM, aln8 wrote:
> The ASUS TUF Gaming A14 has the same issue as the ROG Zephyrus G14
> where it advertises SPS support but doesn't use it.
> 
> Signed-off-by: aln8 <aln8un@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> v1 -> v2: Change to FA401W so full series models will get the fix.
> ---
>  drivers/platform/x86/amd/pmf/pmf-quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
> index 48870ca52..7cde5733b 100644
> --- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
> +++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
> @@ -37,6 +37,14 @@ static const struct dmi_system_id fwbug_list[] = {
>  		},
>  		.driver_data = &quirk_no_sps_bug,
>  	},
> +	{
> +		.ident = "ASUS TUF Gaming A14",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "FA401W"),
> +		},
> +		.driver_data = &quirk_no_sps_bug,
> +	},
>  	{}
>  };
>  


