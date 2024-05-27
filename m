Return-Path: <linux-kernel+bounces-190330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA78CFCF7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0183228131D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED51313AA20;
	Mon, 27 May 2024 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzY2SZ6R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C713A897
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802391; cv=none; b=SjuXKbGQULYOAD4X5oTM8GzPfh92Br8tpkNugrmA/Tpn/05gQmAeQoR5W5TN5jC2tvTEZm1XUZaDT9UJosR+48kKikFLFuvn6NFdiWJu31tA57A8A211TGQL0LvMKwG0ZwcnWjjT6BMe0OO7Z9E0J2pdhn1Nbn7ugjd0bTJE4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802391; c=relaxed/simple;
	bh=COzNM6oDLm4wTy/CEwQcW40ZylxD3PyiTtNvAyKA2R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTNmcKAYCDUuMKvIWSbaOCEAVaxJR5TNDoDm+4z64vw41RBRa55P393B6/uX7mGDFoJOSBvcHX5kjJmTx5f3vSCE3CnGT8Cu4fgzsR8j/jM/aMP/Y0MPrY9p2CV+5lKpAibddYAc/wbNIFqpW7oPgrgW/7x5AJG3LwfoUuiJIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzY2SZ6R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716802388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2W3HQ2FbT0lMvcZpOadwibJdGOUxJezqTqd6ETmGY4=;
	b=LzY2SZ6RZ+ZUDLFpSObEMEpmb1SE7QEbM2SzXX+VwyknuFmofYCrPiZOIB5ruSsE5ndIvB
	F9NgNl0CIq8pLyOJURHFXjlygR7asc02xHp6VhO9YlwVnRWCY+GfHme1LXqt0B8U60oUCO
	pGczIl3xL7vAXyqiasZ1qCy00G+mVYk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-CaZKyi9RMqWWUxAqcUlfvg-1; Mon, 27 May 2024 05:33:06 -0400
X-MC-Unique: CaZKyi9RMqWWUxAqcUlfvg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6266c77502so179543466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716802385; x=1717407185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2W3HQ2FbT0lMvcZpOadwibJdGOUxJezqTqd6ETmGY4=;
        b=pGmgO8ia6Nha/Ejc9cQ/DjZui8TCDse2NW4nGZUdQdA+6Wq/0j0RAJ/3utEnqr8+mi
         4Y5dMZm6dqozSI/e/45TPypGrNxHL4M03TOxbrxPvrOyvD2m7+8xW+boiu5Nanka3B1m
         uetznChMq2F/+uXsy4wg5YcCNk74Sx2l/vpUSakvaLVKL5MPdF15llJr6oYPc9630bUb
         FBDumVOKrClEnPecfQjkEpYCG/Z+LjxBf6i20t4VeF3TBa4fWzxHlLYOwA1X+eORq53T
         sFF6c9BXd8k1zZy3eLIDINOrBSOOSqZ/KaFthB1Oa2PtwXCl4gfUzUBqRQ450CEi1Ity
         6FRg==
X-Forwarded-Encrypted: i=1; AJvYcCXBcN/H2nouXsBGnt8IYGiUeuP+n+P48mkfauza0mu9Sma0WOrlfU1ZPUGyOd0FDMk4Q4hEDPjs6enmCmY8/vC11OuEzcc5uatAD6Kr
X-Gm-Message-State: AOJu0YxJM90XQKOsv758mIvZ0VXY9bd8jR44WKT+ftfAH5aRns6qjULX
	M8O+7BtkRrYlBJrkf9mLQ2en8niXkpLOM8A3umnlq273imbrIf0qVJNSBbNWwBgH5GRgouqGBLe
	fZ/BVZhPIyE3H654C8FUc/2KxTnovHSYftADf5tJvOs+qhbOH2ZU+gGE8wpWk0U7BvEvzhpHV
X-Received: by 2002:a17:906:470f:b0:a5c:e240:ceb7 with SMTP id a640c23a62f3a-a6264f0e8c9mr524496066b.62.1716802385458;
        Mon, 27 May 2024 02:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpcYMc1VyHs5D2+265Ocu7lm2Yq8+Lc/mFzBMEb0dWGcljnBKhLIuqsvzUV6YzHDZaMsVDVQ==
X-Received: by 2002:a17:906:470f:b0:a5c:e240:ceb7 with SMTP id a640c23a62f3a-a6264f0e8c9mr524494466b.62.1716802384975;
        Mon, 27 May 2024 02:33:04 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817e60sm471194266b.21.2024.05.27.02.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 02:33:04 -0700 (PDT)
Message-ID: <de5ad888-65ff-4339-b585-0c0618adcc99@redhat.com>
Date: Mon, 27 May 2024 11:32:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Select INPUT_SPARSEKMAP in
 Kconfig
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <20240522074813.379b9fc2@gandalf.local.home>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240522074813.379b9fc2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/22/24 1:48 PM, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Now that drivers/platform/x86/thinkpad_acpi.c uses
> sparse_keymap_report_event(), it must select INPUT_SPARSEKMAP in its
> Kconfig option otherwise the build fails with:
> 
>   ld: vmlinux.o: in function `tpacpi_input_send_key':
>   thinkpad_acpi.c:(.text+0xd4d27f): undefined reference to `sparse_keymap_report_event'
>   ld: vmlinux.o: in function `hotkey_init':
>   thinkpad_acpi.c:(.init.text+0x66cb6): undefined reference to `sparse_keymap_setup'
> 
> Fixes: 42f7b965de9d ("platform/x86: thinkpad_acpi: Switch to using sparse-keymap helpers")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans


> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0ec952b5d03e..1953317541ea 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -515,6 +515,7 @@ config THINKPAD_ACPI
>  	select NVRAM
>  	select NEW_LEDS
>  	select LEDS_CLASS
> +	select INPUT_SPARSEKMAP
>  	help
>  	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
>  	  support for Fn-Fx key combinations, Bluetooth control, video


