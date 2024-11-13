Return-Path: <linux-kernel+bounces-407405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A59C6D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C697B244CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894D1FE0E7;
	Wed, 13 Nov 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFReOgs0"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29481BD9DC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494404; cv=none; b=MvJaIgPaj8FevlinIfw9IFQk+XVpOxZfqwmshoqZl8UKOyCbE3sYxaZfobZDkTzMFVcyTSBrkbJvmRi/YxK8HOE9skJWL7jUbUcKNgfabzi59KnO2yRxRdfob0ovXRDwYgIb1DrUL/HICUInshoU3b5A/1TxqloG9b03bhILY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494404; c=relaxed/simple;
	bh=CVBLgO9PCTR1EzxJ5XBaCJ7HXIlrxXyjwaYXCyT6JjA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W0mhN2uMycLw6SVIYUrluZ9vDnErxMDckXuOYarlxpf1aJPPASpgVctL83cWmqsQQuTI2QeCCKXLE7+IC3NuIgwuCv2OQtdTecyTdq9m3LhWIFrFMdbnHziF3JURjIyxUal4lW/kCwFpgIU2Rpj9aNRilQLY1rl6BVJWDvsm5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFReOgs0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314f38d274so83939505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731494401; x=1732099201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s/Thv3s5fZYiC+uXrouI6KDRRkyx5pHxDuOMRZSWEns=;
        b=LFReOgs0lVUEU0Ijn7LcX/A51el+EdIzqzmFtFm1jNeJz9XhVN+eRGXLlF0dSLLtIg
         6GqI5uSxzfGTc1NkNAeF+tts7eIPt/ryNdinCCCZDc6AKF7p+lIrZBkZeKrWEn8nerdw
         J1O8FJ6cHwOW+3wC0TVrZR77UIRiv/EO2khXVd6jNP0Yp9jOd0nZ0jp3+XFuBgG3iBcz
         A0H2Pd7LS8uU7KatgF2mTODboGmV+/ezj2itFg6Nj5YNsOHseHlrOMZrnR+ej2RG4hcJ
         qgR4p9zfRMHxKI6nIO7jx7V10JGFHUUnZjItujBCPLmk+Ip+93XvKtRXLGSPNSXJc/x2
         tJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731494401; x=1732099201;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/Thv3s5fZYiC+uXrouI6KDRRkyx5pHxDuOMRZSWEns=;
        b=EN/4TY8mBBKfnxeDOysTc+hbF0qPreM+T05c76iz/pCy3oSsu37w+D7di7V23xsfoj
         26qClfYMaYCMJSAONOEStUnSVozuRcUWuD9zBmrqVrK3v5xFhmF6+/Pt5A0/PY78NSTn
         ooANGhb/F7JeOM47j1qY28w6E/m4T3h2eEujcKl/1/r4OsqjeMOJvfy7vQcs8qf0JCPb
         gsh1FbsFJefcDu/QV4s01w26mzUovKAfLcU28f/gL/E33k/KV32EnKp+lc5+0pQjcffw
         H+d+6/nrvUcB05qXvxkQHGwNXpTpaqUW4tjwOzwoPYZ1KqmXj5c3kwNS8+YxnmI3HJ12
         x0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh/5S0cVJ1vlFUJdvSjDX/1kNxf1VT7+Xi8aXQZzV7F0pln0KtiKhR1WtE7VhkuOtWG5XXsrK+GUqsJ+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLUBa7+4EKKmmwenWwqfI3Ar2lBTMWU051Aun4AdV1IqsqEoQ
	eyJIxIaSh2V6LyHjlxWQqdFfWUN7aatrkH6b/f8/G6iiY9EDEzzZ
X-Google-Smtp-Source: AGHT+IFnil+UTWcCqyM9NjYstgzVsxFPy7IlsYJou1rBFeOgAM88fn5h5zIa7wuIyMJtqy1fKWia8Q==
X-Received: by 2002:a05:600c:4f10:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-432b74a07femr230288035e9.0.1731494401028;
        Wed, 13 Nov 2024 02:40:01 -0800 (PST)
Received: from ?IPV6:2a03:a900:1000:7e9:403e:7c8b:351b:f333? ([2a03:a900:1000:7e9:403e:7c8b:351b:f333])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d4788c2asm17787935e9.0.2024.11.13.02.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:40:00 -0800 (PST)
From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
X-Google-Original-From: Zdenek Kabelac <zkabelac@redhat.com>
Message-ID: <caa63670-ec53-4700-945a-e282a8d09827@redhat.com>
Date: Wed, 13 Nov 2024 11:39:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: Allow the use of escaped characters in
 str_field_delimit()
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241112175758.114080-1-pvmohammedanees2003@gmail.com>
Content-Language: en-US, cs
In-Reply-To: <20241112175758.114080-1-pvmohammedanees2003@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dne 12. 11. 24 v 18:57 Mohammed Anees napsal(a):
> Escape characters were not handled before, which could lead to
> unwanted issues. Some device-mapper names may contain backslashes (`\`)
> as valid characters and should not be treated as escape characters. Only
> escape characters followed directly by the separator are considered
> valid and need to be processed. After handling, the escape characters
> are removed to ensure the final string is correctly parsed without
> unwanted escape sequences which were used only for escaping.
>
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
>   drivers/md/dm-init.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
> index b37bbe762500..dad9d523f7fb 100644
> --- a/drivers/md/dm-init.c
> +++ b/drivers/md/dm-init.c
> @@ -88,13 +88,33 @@ static void __init dm_setup_cleanup(struct list_head *devices)
>   static char __init *str_field_delimit(char **str, char separator)
>   {
>

There is libdevmapper  project  (ATM distirbuted through lvm2 project) which 
is handling the management of name & uuid with mangling - so they are properly 
visible on systems with udev.

IMHO this escape handling does not belong to kernel and is rather related to 
the actual user space running on top.


Regards


Zdenek


