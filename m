Return-Path: <linux-kernel+bounces-176893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DECC8C36C4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D101F21E41
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9AF28DA4;
	Sun, 12 May 2024 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NG8xFGTJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7A210FB
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715522129; cv=none; b=iTrLvxK8k1+1xnRv8x2nD3x+4y3Y/qDX7beUjsxCpyqhen/UCvse/3q6sJJoe+P+el4TXKJMuobH9fG8o5c5dApkk8dCYgvRN9l3L6ibwaYRplHjdf3AVeICx6F7s59kiMGlos1GOaHJ43mmsTm++C4L7azk66zJjzifuXgmvQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715522129; c=relaxed/simple;
	bh=QzWIjhiIW1aFIbIhMjmlJIAZhe/Sp3sb9SM0pcpMXm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OP162EDpfj+IvfMpLErWb7+xjPXJUfWR+ds1zQBpL1OpIN4Mnio/OhQZWysgawA8QVdMc5vTAbp2h0BonHTorAK9Zb2WMYw+rs31QszeIMgJ+t61zl30ja0abZRoe1dNneEkvaTO4akYBSWgo5oEKNyDZvbgZg0shWpFZd4FkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NG8xFGTJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715522126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/r0A7TPkHZGpSI3kSzq0XZsCei4tDjmUynzk4cOnsI=;
	b=NG8xFGTJpj1uxFjUBHHA2VVmZt4OUOOdge6beAYnoDxL6xsVpdrdt8FEtKxgM4Xpi1slse
	mckJcccz06uOzYNGc3zV7aTASr4OpPHONrMPVObxOREzOP5H2dLzL2LZX42WDgwnUY+PT+
	fl0GkL9tGMjF8vHIg7nRjd4HdI1AYoE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-NWl_-i3wNy-w5MSPzOVsjg-1; Sun, 12 May 2024 09:55:14 -0400
X-MC-Unique: NWl_-i3wNy-w5MSPzOVsjg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e262d63c70so34301421fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 06:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715522113; x=1716126913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/r0A7TPkHZGpSI3kSzq0XZsCei4tDjmUynzk4cOnsI=;
        b=Fw3tVOABGloCy1KZ7/3p6BHWY/hZRgdfuH4ZCo6tu98ITkzCWBoLzUihiCGvNtLqN5
         rc61PPzlJb+mEOf8zwxXNnut8+TeYVVyRomfqEdeI6x7q2XjpEVhJ9ZdB9igVz3EfjJq
         Nt/o9ZzzkCaE5ztxMeFsveJRA0hE6MdfnbNFNjnOmuKQAVqgX1evEAr0zbhK005WVehn
         oNg70+3i7vQ2LmKA6bQEv09Rq6UqtOFB7qfEypzlrWjrD62fZsFxxSjVtLS/86ZxeCc/
         B6C22skZHD06fy8uUAaKgNDXharL+8eagQaZTHy00oqVkYgmJiSJ7qZdg0dLVK4BZPdu
         o8TA==
X-Gm-Message-State: AOJu0YwyEFxLNMaXXr6ikNO171YUaz8eo6+XTBCH/V2Q7YT0MW0j53kz
	XOVptliwAIozh9MBp8EmNl33nQWz1ffzKmRvwfb5IQjGOPZmGPDW9bHr9miOtVmosgKfwPz/d9G
	0/y179azoy1l1vulcihg1nYn+27UCTgYiu7lXWOxEpK0WC1o9IMwSlofvpToQHy5PlXvKHegj
X-Received: by 2002:a2e:954c:0:b0:2e5:6957:187a with SMTP id 38308e7fff4ca-2e569571f3amr35927981fa.4.1715522113205;
        Sun, 12 May 2024 06:55:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhPImeqHdj7RC0ZYwwkh8BAqDqXDeq0j+HJ2a85twhLE+tGMBO4C8LqXyu6uCaufPlp77uZQ==
X-Received: by 2002:a2e:954c:0:b0:2e5:6957:187a with SMTP id 38308e7fff4ca-2e569571f3amr35927831fa.4.1715522112795;
        Sun, 12 May 2024 06:55:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c699sm458503866b.53.2024.05.12.06.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 06:55:12 -0700 (PDT)
Message-ID: <dd84ba87-b546-41ec-9cbd-9e6d0fa35476@redhat.com>
Date: Sun, 12 May 2024 15:55:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: chipone_icn8505 - remove an unused field in struct
 icn8505_data
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-input@vger.kernel.org
References: <37443a675ca07c91c5f0118ce255406e6e3c08f5.1715502304.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <37443a675ca07c91c5f0118ce255406e6e3c08f5.1715502304.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/12/24 10:25 AM, Christophe JAILLET wrote:
> In "struct icn8505_data", the 'wake_gpio' field is unused.
> There is also nothing about gpio neither in this driver nor in the
> data-sheet.
> 
> So, remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> Compile tested only.
> 
> It was added in the initial commit e7330fa032bb ("Input: add support for
> ChipOne icn8505 based touchscreens") but was never used.
> ---
>  drivers/input/touchscreen/chipone_icn8505.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/touchscreen/chipone_icn8505.c
> index b56954830b33..c1b4fc28fa8d 100644
> --- a/drivers/input/touchscreen/chipone_icn8505.c
> +++ b/drivers/input/touchscreen/chipone_icn8505.c
> @@ -68,7 +68,6 @@ struct icn8505_touch_data {
>  struct icn8505_data {
>  	struct i2c_client *client;
>  	struct input_dev *input;
> -	struct gpio_desc *wake_gpio;
>  	struct touchscreen_properties prop;
>  	char firmware_name[32];
>  };


