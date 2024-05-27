Return-Path: <linux-kernel+bounces-191370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E748F8D0D56
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE911F20D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC816079A;
	Mon, 27 May 2024 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6atOexS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F416079B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838126; cv=none; b=Zr+HIyCU3mdEbkjKe6N0I4hTmLbQIu74vd/XRHc+6U0WoEQa1WKnCYkpL/ypcyyCS1zTfNd5sveAG2rhkDQX5IB1kT8/I0BoyRj99vuAZqohKrLO8hG869NsuFPEEZh8UZax7HdgGH/x0wDkbA2sCg6PY/LSsLw7StfIdpllk0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838126; c=relaxed/simple;
	bh=oUfOHq9Rlb0a7D4l3Lqx6FtCvm34YuPLn0oskocY6Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKnSts2qD/uJHoGDboIIjq3gRdCTYQH7LHKs0tdgRqJSOT3+r9UYWSTAPlQNCxGbtRV0wYMgIygn+GaFTKnk5LrrVL0i7lkirMzsCiohRamS9h/ru0BFGwmCWOD4oG6+IIDwIYoJ7c3Z0A/QRQwrFp+7Ol9kG7XkANWgw3ApZo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6atOexS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6265d48d3fso2007266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716838122; x=1717442922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcDYDHXFbJ6D+vBSxtRFYbaH4Amc09bTylRzwYEhBfs=;
        b=S6atOexSYD8O0oBaBfXbcphGXFIF4KY3JFkpea+96zeqvA1qRbs/Si84df+KnYnYhB
         p9IoYgqGtdkGfS8BuvwMHwf6MNmkhMNvqDNSqe1OAl5bD1oiHyJURQFmJ0Gjfzdo/rLw
         6ralvLgIKKgz1ad+xFMx0pbMwj//uVfKQ+mH5kealk/ElCSrmjl4UDK2d3PCeSkTtPP2
         yaIFzdNPToqJeKXGF8JOoY4U0A8sG5kw3rbIvtIPd2/odv8XJpUnfuZYVfkklp2LyC6p
         +m0oKrgIz3EzDOJblKHjrpVQHgZfQ+KqHabA94hCcJOaFB4lGA2v2SLA0XM65s+SYwDY
         H53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716838122; x=1717442922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcDYDHXFbJ6D+vBSxtRFYbaH4Amc09bTylRzwYEhBfs=;
        b=Zme9DRA2zbN5hIqufQjxxMJ32ktEThhJk1v3oUmDJ8ARwZOtplspeYmxuzhGeyqwW6
         h/wlW/bqL8zdUG06YT+9xzRe/QjKklyU3qJJuzHxlGVrGELFXMG3diTUiFq+fesxA2Mr
         eqzMScwQNdWDPFWyv9JbM4nJuNWemlaNBydEQ7oTGbk9MwEBQ0Ba5dtNR+rSa/qsmvLG
         9tRQuS3wq1Q3ya9z7Zt4u9H4eMNljkSZU8XPUNN/hQQ7N7cZLviWwSJUznBomb6UvuyZ
         Oy0KToYvcVqwEO4coOqsnhYasce7vsq/CKySQjsXmTJO0P6TVrcAUyJZsOUlSXHBTSg1
         6V/w==
X-Forwarded-Encrypted: i=1; AJvYcCUlhhTVGtlXNApbRkVtP4sw/VJoakbUZLQP1xFxR7Q69CtZq2Leo5x95YhQVJ9LLXisKWLBc7GrKEh+rOgim6g+ZlnIw4SQYY6w97+u
X-Gm-Message-State: AOJu0YyOeIGq6k6GbTbz6doGRGRCrsffUNwHw+CFPm7zgAOXbK9+Kc1q
	tASKrY98Afyn+cWR9KoLBQDts14k0rcpaYc9vHFlCT6WGUyhZpxCRH5fsw==
X-Google-Smtp-Source: AGHT+IEO5J9zAQ03jtP8nl1KN6YZvtcvzBWdNgZZ17Xg+gIBBgIGTqclMf1CStrUOqVQCRc0hmbJFw==
X-Received: by 2002:a50:d718:0:b0:578:6263:727f with SMTP id 4fb4d7f45d1cf-5786263763fmr5664377a12.4.1716838122044;
        Mon, 27 May 2024 12:28:42 -0700 (PDT)
Received: from [192.168.8.103] (dynamic-176-005-137-056.176.5.pool.telefonica.de. [176.5.137.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852495de0sm6047812a12.61.2024.05.27.12.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 12:28:41 -0700 (PDT)
Message-ID: <f1e18696-8602-40ff-be90-d232c58693ca@gmail.com>
Date: Mon, 27 May 2024 21:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: hal: Fix spelling mistakes in
 rtl8723b_cmd.c
To: Roshan Khatri <topofeverest8848@gmail.com>, gregkh@linuxfoundation.org,
 colin.i.king@gmail.com, ruanjinjie@huawei.com, hi@atinb.me,
 bragathemanick0908@gmail.com
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240527045856.72996-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240527045856.72996-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.05.24 06:58, Roshan Khatri wrote:
> This patch fixes misspelled words to increase code readability and
> searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
>   drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
> index a59ae622f05e..d1ac2f44939c 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
> @@ -700,7 +700,7 @@ void rtl8723b_download_rsvd_page(struct adapter *padapter, u8 mstatus)
>   		rtw_write8(padapter, REG_BCN_CTRL, val8);
>   
>   		/*  To make sure that if there exists an adapter which would like to send beacon. */
> -		/*  If exists, the origianl value of 0x422[6] will be 1, we should check this to */
> +		/*  If exists, the original value of 0x422[6] will be 1, we should check this to */
>   		/*  prevent from setting 0x422[6] to 0 after download reserved page, or it will cause */
>   		/*  the beacon cannot be sent by HW. */
>   		/*  2010.06.23. Added by tynli. */
> @@ -964,7 +964,7 @@ void rtl8723b_download_BTCoex_AP_mode_rsvd_page(struct adapter *padapter)
>   	rtw_write8(padapter, REG_BCN_CTRL, val8);
>   
>   	/*  To make sure that if there exists an adapter which would like to send beacon. */
> -	/*  If exists, the origianl value of 0x422[6] will be 1, we should check this to */
> +	/*  If exists, the original value of 0x422[6] will be 1, we should check this to */
>   	/*  prevent from setting 0x422[6] to 0 after download reserved page, or it will cause */
>   	/*  the beacon cannot be sent by HW. */
>   	/*  2010.06.23. Added by tynli. */

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

