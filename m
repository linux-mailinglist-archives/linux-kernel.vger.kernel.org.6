Return-Path: <linux-kernel+bounces-185360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E98CB3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8011F23076
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA271494B2;
	Tue, 21 May 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB0eYjsP"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE06142910
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318232; cv=none; b=F3TW1S+4cSEJDTsnICQlQYXIjHLx5PJ/HE0AnkFuUNlmozkUa1gP6nSHxLw/gfVtxJVxapYEJxNGWPyswpaStAiDK9izBeHuxZu5U1KR+T0Ls283zbVkpuDxPRvcSLuKi4z2crFnsUKkd38SCqjO0Bu8co5rRZGsMdVkR/dsGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318232; c=relaxed/simple;
	bh=j93r0x2LLl5DrCShcGy1ILGc6pv/qMlYGnlPMpRuj10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUofNpdlQNMLYbom8Jd6lQg5UH3OJ/dhBmh4IvCjcyty03Z5JkMuN0MjJP86XiCqH1yaku2mPBi6MIs7y+x8JABERMqbD6jRqpcDkzx3P8MVVlCUyPTFCjPGev2Ce8QbLVcI/TRRleyp91k7+LFuEPp7qck/34spd/QYq96YK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB0eYjsP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5a5ccebff9so112638866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716318229; x=1716923029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yP70HlVsmQBP1saZ9APp+m5Pne5zk0a5fTtAUISwyBw=;
        b=ZB0eYjsP5IfAuW+e4XXbXvuuE0gvUbQIR/fTCi707WyRicYMhT9pmcOfaNewUTr3EP
         BkfCHwZpBlgk+qsQuVisQGTx+dI140OkI17DOr+jBh/CfqJvoBXFZh43C/LVvV7C8+k4
         ldFEyOfBlZcAnFcD7EsLdTAqP6D8Z6SM06OdxhPqMhTDqyifLbLj74PdhLSVTaBcVbNQ
         CO0c3aRWvgX3SIGlkQn8PSU6eOd++Qu2IWbF62fdq6jygH7wbZYZe5LdXJshX1iyVUo2
         +jZxcrn9NI7NysFEvKrTbBqc/Iy+Cpjv2PSwWDjYu2D9ak+wQ8OOlOm7bhE+eMV7nOrH
         putQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318229; x=1716923029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yP70HlVsmQBP1saZ9APp+m5Pne5zk0a5fTtAUISwyBw=;
        b=QowyfSbyHhDLHOiWJ4usal+os2J4bpHL46U4oPCaBbP6VJdq/0pdDTqP0FhPsrsvxn
         Annlo4xQ9330r20uYXK6TlL4/7ix4etCyU2WMQOs5CQlRgekYo9KM5ai3Z2qLQu7JCSC
         AMaxK+h4+2h9PviRkHNAgPpWjpU9pJjbz+Gv5LTEL+GqHeJrSbiHUwWm3aCyLmWLRL/2
         kX0IuX1F3tqO4+Ow6pzGrLFh7GAnKk6Lq1b5skjE6RV+fAXySgvHhMlsJ3Ush5hvx1+0
         e6AGyjwNmA73GSpCqNT9jqE+QtVE1Az4nE675jOrf4QO20ITMxHhHwJ4EV4mZ3kdlVjj
         TlZA==
X-Forwarded-Encrypted: i=1; AJvYcCXmQ9i7uvKLOY+FpPYWe5jYHRmGGGX5KkAnYowo4KrvZcxADHstMNH4FYkI6K/O8SvL68Lf0nag9fqnjic5icvrXtURxKp8ZdHGJIUY
X-Gm-Message-State: AOJu0YwStPXlynwxAThQu1aVYsZrFAoqCSWFCwqPK8s8laUYhHOUQZqf
	ECsN4PJyRKLPHuKvxw+oUWlHIt7ki3IZzgML1LmR8x8ZugFZUo66
X-Google-Smtp-Source: AGHT+IHPmmhK06HEQmbWaGAFGJKH6vmoFuJ+phNwATanBst8AWfKvLNvPwHhyc5tKZ8r5UKkqCBB7Q==
X-Received: by 2002:a17:906:5a53:b0:a59:cb29:3f9e with SMTP id a640c23a62f3a-a5a2d508447mr2094984866b.1.1716318228601;
        Tue, 21 May 2024 12:03:48 -0700 (PDT)
Received: from [192.168.0.103] (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c814dsm1639029066b.118.2024.05.21.12.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 12:03:48 -0700 (PDT)
Message-ID: <1aefa708-b1fe-4246-bb67-36f25919c766@gmail.com>
Date: Tue, 21 May 2024 21:03:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: rtl8712: Fix spelling mistake in
 rtl871x_event.h
To: Roshan Khatri <topofeverest8848@gmail.com>, Larry.Finger@lwfinger.net,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 ayushtiw0110@gmail.com, dan.carpenter@linaro.org, namcaov@gmail.com,
 linux-kernel@vger.kernel.org
Cc: linux-staging@lists.linux.dev
References: <20240521095633.50753-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240521095633.50753-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/24 11:56, Roshan Khatri wrote:
> codespell reported misspelled joining in rtl871x_event.h. Correcting the
> misspelled word improves readability and helps in searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
> v3:
>   - Fixed misspelled word "readability" in patch description
> v2:
>   - Changed "mistakes" to "mistake" in the patch title as suggested by Philipp
>   - Updated the patch description to reflect why this change is important
>     as suggested by Philipp
>   - https://lore.kernel.org/all/20240521082510.50422-1-topofeverest8848@gmail.com/
> v1: https://lore.kernel.org/all/20240520064750.48912-1-topofeverest8848@gmail.com/
> 
>   drivers/staging/rtl8712/rtl871x_event.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
> index 759a2d27d8f2..0cc780cf4341 100644
> --- a/drivers/staging/rtl8712/rtl871x_event.h
> +++ b/drivers/staging/rtl8712/rtl871x_event.h
> @@ -37,7 +37,7 @@ struct surveydone_event {
>   };
>   
>   /*
> - * Used to report the link result of joinning the given bss
> + * Used to report the link result of joining the given bss
>    * join_res:
>    *  -1: authentication fail
>    *  -2: association fail

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

