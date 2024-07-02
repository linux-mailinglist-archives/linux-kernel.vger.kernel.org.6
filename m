Return-Path: <linux-kernel+bounces-237619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 262C1923B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72911F231D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF5B158DBF;
	Tue,  2 Jul 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hv/z9svX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19D158A3D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916876; cv=none; b=gO25AgrmzBzJLzim3IcAMY9Z3rNuPPFzNCPzIuj5wIAUnnBQZ4t3cdsOd0Ov1Bq7U/FQlwEotH/Ud185Zo7Z5wQRAqipcWWaPwPgXi1X0ogO3gZ5iQap/rZ45G0p4HS0prKJhVF6JgFdQTESp21xkq0Ve2J/6mBpIVLbxJBeccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916876; c=relaxed/simple;
	bh=lZWDKkVU4wUQ2+XVtlarhxp5FdOdYIV7mJ/9JVxeaqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iud0qqz3SO0ceBBKrd4AWn296LQmPL3+BfG8nHFHaczUfZUf46V0HID9/kr48JTr5/sLaedk4s3riFepu8rxrt7rVs9IAPH7ftLESh64f7IHkW7en5cJ44pvD0kGEckNhy/ccIeQkgzaDiR+ss/D5tp2VaMv6lQsO+UuwOvQUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hv/z9svX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719916874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAtqrFZvfKjiF7uOC6sDtpciWiE0nsuU8n5L7biUdck=;
	b=Hv/z9svXUVQzAO1LnbnKW9KHNv9pK7P2S874C2kXojxcIxPhUEVGZyjfyjj2H+UqxDMeAd
	qMuShlWEsnEZAaIOouoAzMmProBDAHsqfZo/xI1NOL7Rj9FCUaJ8UVwjAJu50B5qMz62fy
	PDndxOjkrAOsgrbR+M5GmYmLFn9rISQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-m29-H7dbNHS3ERBFLAe0tw-1; Tue, 02 Jul 2024 06:41:12 -0400
X-MC-Unique: m29-H7dbNHS3ERBFLAe0tw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58b0dce2704so937640a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 03:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916872; x=1720521672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAtqrFZvfKjiF7uOC6sDtpciWiE0nsuU8n5L7biUdck=;
        b=QRVvhfHkfoDbZxGyT2wiHfWEOyEr6aJQlsPhfu79JObGKoL/M8eRL6fDQXufoLGIWV
         Hjj0WIcGYLtG0kjWxICYHM15Az6RaZh9kgO+oro04Twk1lMIxooNCTepuDjXoEKhyZxK
         0hPkG7lsyvsqcJG/tcpR2PYY1bzlodP7tiuxOc+gm48hvea6j1VqYQxd5pOmwLhLYTVs
         gT8EhzTLdOL+8F6F4t34l52ug26/6z5/bJ+yDYfETsEr5GnV8SBCE12aj4Gk7t6hPWT9
         P1eu2PDp0PSNuC7q5FdTn74c55EZnN7E3fbhmFO6bV1ujaRktjBYd/TtnlLoro2mSLWy
         oDhA==
X-Forwarded-Encrypted: i=1; AJvYcCWgHZK2lrd/EHphA6H0NPAfz65TwY6YvUqVnEQx+fFHueBY+pr60eAEtVqZgXFyCiW5+t4nvXqyfT8DZK+N4m++Iyvskt6COGSXdopj
X-Gm-Message-State: AOJu0Yx1iKkNMto1nfaecMsUPkadjBD/7Lz7YGShHJNLON6qwVMY+HHj
	zp9gJUf0HIK62uBAR7OO0fOJgrdnfkVzr5xyi/JLRazkIjLKl8f9rFiogDT2gcgFIcwjXAH+u+4
	EaiE/zguj3XbYeyS8AXz0bLCNuGXBuTfxEGkx4LvajmT8tlabVdrL/wrXh31lvg==
X-Received: by 2002:a05:6402:51d3:b0:57c:947c:f9cf with SMTP id 4fb4d7f45d1cf-5879eed9408mr5609422a12.11.1719916871820;
        Tue, 02 Jul 2024 03:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLlgdlK6UOwTRIbEkRdNSjnktG1oYSCS5jVvBCEBX/8U9vauixSEkrhY6hQoBbUN2cdCflBg==
X-Received: by 2002:a05:6402:51d3:b0:57c:947c:f9cf with SMTP id 4fb4d7f45d1cf-5879eed9408mr5609372a12.11.1719916870421;
        Tue, 02 Jul 2024 03:41:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58613815dd7sm5505486a12.43.2024.07.02.03.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 03:41:10 -0700 (PDT)
Message-ID: <d240c315-b438-462c-90a6-22f7e39b2a7a@redhat.com>
Date: Tue, 2 Jul 2024 12:41:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: atomisp: Fix spelling mistake in
 sh_css_internal.h
To: Roshan Khatri <topofeverest8848@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org, hpa@redhat.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240501162620.86865-1-topofeverest8848@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240501162620.86865-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/1/24 6:26 PM, Roshan Khatri wrote:
> codespell reported misspelled words still and member.
> This patch fixes misspellings.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>

Thank you for your 5 patches.

I have merged all 5 in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And these will be included in my next pull-request to
Mauro (to media subsystem maintainer)

Regards,

Hans




> ---
>  drivers/staging/media/atomisp/pci/sh_css_internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_internal.h b/drivers/staging/media/atomisp/pci/sh_css_internal.h
> index 2349eb4d3767..5395be1ed26b 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_internal.h
> +++ b/drivers/staging/media/atomisp/pci/sh_css_internal.h
> @@ -509,7 +509,7 @@ struct sh_css_sp_pipeline {
>   * of the associated pipe. Dynamic means that the data address can
>   * change with every (frame) iteration of the associated pipe
>   *
> - * s3a and dis are now also dynamic but (stil) handled separately
> + * s3a and dis are now also dynamic but (still) handled separately
>   */
>  #define SH_CSS_NUM_DYNAMIC_FRAME_IDS (3)
>  
> @@ -597,7 +597,7 @@ struct sh_css_sp_stage {
>  
>  /*
>   * Time: 2012-07-19, 17:40.
> - * Note: Add a new data memeber "debug" in "sh_css_sp_group". This
> + * Note: Add a new data member "debug" in "sh_css_sp_group". This
>   * data member is used to pass the debugging command from the
>   * Host to the SP.
>   *


