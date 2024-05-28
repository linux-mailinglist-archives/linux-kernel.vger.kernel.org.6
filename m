Return-Path: <linux-kernel+bounces-192794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786748D222B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1759B1F23CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2624C173342;
	Tue, 28 May 2024 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwTfhFC2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749C171E4C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916200; cv=none; b=JIrJvxw0WumdgybKWFMu2bLJfzqo7Tn9xDhNxGGVEiLaWInqWYf8ZFINonrCXAyQCxCfQxMb09anIfQCxk5IBQDoH69mOpGpX5faG5dW2RrNo7kAjfeSv2lvKOGamUDXbR0cRk7K7m5AygpRYEo3HS2pb2HucvmCAneUoXJ4/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916200; c=relaxed/simple;
	bh=AR6U/qaELEoqk8nQWg6NpFQNeo717uJTQM3pryiZM2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tR4sfeNEDi6HuIeITRI2Y9wJdlBLFU0HLvJtiTixe5CC46PCf4xdC2Lr/QD+zpr3a9QHgQBuzekDpN72tksGzVyjy7TOrGOSFD8NoZ+wIuRB3xoBifCTWMSf0F1d9rWjpHaxcx1iS9TdiKyZxMoUTwIn11lFW4qMm8QsJJXGpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwTfhFC2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716916198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35VQHwWk0//mBlvImqaujEfVCW2jrOIkEafBbzr68rM=;
	b=bwTfhFC23UI0boiJAHWfZqRdbe4uYEMBmcKw01N75maHu+M3lHRVAV8u1GVHXVCEAU5GCr
	Eie4LANTp5tqGjJgZpr9zM5tvDxNjz8gj9Naua2MnrTtr/ZGnY2LFo6DpCmoJmAn/ilYac
	hIBe3Y/dvHIVk1Hke1YguIw64ctx3Eg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-f2x9sTUNNGStEkt4U11PFw-1; Tue, 28 May 2024 13:09:56 -0400
X-MC-Unique: f2x9sTUNNGStEkt4U11PFw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-579e6c8f396so655459a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716916195; x=1717520995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35VQHwWk0//mBlvImqaujEfVCW2jrOIkEafBbzr68rM=;
        b=mBHhoGGh6wN2l/P9KmKd7jCJy1z+XDHzlkQeTm5cbR7etMxweMGKqx+bSd8h0tplXE
         GNquOufgDN4supzvnINjCOP09Qd1xEDP9hKI2xZ77lnf8VSCeMlwDxK7uxKhiuF5oUJu
         aQd5GrdGV3pyGnprK7Z1ddapyWiBFEXJGnY/u3WP4FV7DD27LwQu8wTby56RnsH7P1ti
         Y8OG97OX9oRg99eBuyLoiJ+uHJlusfy37stSXMUNme+RsVkr2VEFgdwTq75K6wQBrPR7
         MsKRwAHMFe7TrjFbTYkOqD8TNm3HA5NvruQZ54XdsA5hQdRb2vSgdCobQXWxNG9B7LDI
         fzsQ==
X-Gm-Message-State: AOJu0Yz9BZaCkP1YQPHjX+fAxAq3QJRuCN5kIR9wd/9zYPEdoDpkxmwt
	Pe9O7dNtLSNPB0cyz26qg8ZEsU/tT91vqNaCJ7cth/j2jiw2jjlztOyidXDseWxXUW/Mo2vbwVj
	CF8qoufGvrm1Ki3Dg+9OT6Syy7VKXZ1rpNERqDKFONfuWk48SgTe/o7eZNyohRccuuIheGg==
X-Received: by 2002:a50:998e:0:b0:572:7bda:1709 with SMTP id 4fb4d7f45d1cf-578518f04ddmr8884721a12.9.1716916195144;
        Tue, 28 May 2024 10:09:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHisjcCOLlmts/18OlmSuIGYLeswwiHjRkyoWnS+26pyPDJbbrZR2whGmmavfsDxJfHysbVGg==
X-Received: by 2002:a50:998e:0:b0:572:7bda:1709 with SMTP id 4fb4d7f45d1cf-578518f04ddmr8884705a12.9.1716916194690;
        Tue, 28 May 2024 10:09:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:e7a9:b143:57e6:261b? (2001-1c00-2a07-3a01-e7a9-b143-57e6-261b.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:e7a9:b143:57e6:261b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579deb8f406sm2324565a12.34.2024.05.28.10.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 10:09:54 -0700 (PDT)
Message-ID: <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
Date: Tue, 28 May 2024 19:09:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
 wentong.wu@intel.com, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 5/28/24 10:44 AM, Sakari Ailus wrote:
> Ignore camera related graph port nodes on Dell XPS 9320. They data in BIOS
> is buggy, just like it is for Dell XPS 9315. The corresponding software
> nodes are created by the ipu-bridge.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi,
> 
> Could you test this and see whether it fixes the warning?
> 
> The camera might work with this change, too.

Thank you I just received a Dell XPS 13 plus 9320 myself to use
for VSC testing and I can confirm that with this patch 6.10.0-rc1
works, including giving a picture with the libcamera software ISP +
3 small libcamera patches.

Regards,

Hans




> 
> - Sakari
> 
>  drivers/acpi/mipi-disco-img.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
> index d05413a0672a..bf9a5cee32ac 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -732,6 +732,12 @@ static const struct dmi_system_id dmi_ignore_port_nodes[] = {
>  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
>  		},
>  	},
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9320"),
> +		},
> +	},
>  	{ }
>  };
>  


