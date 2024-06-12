Return-Path: <linux-kernel+bounces-210934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06099904AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 695F6B23673
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2EF36B17;
	Wed, 12 Jun 2024 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhC9JTFw"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD52C1BA;
	Wed, 12 Jun 2024 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718168861; cv=none; b=Nu4kA+PCYPE5PvaJw5sPQLWKX5HF42u6bj5o11UCPSSgCMXKSMqlKjc+niKuRf6zCcNb+PmicsWjDIwvJnZcXk77spSPauY15IbjYVAKsBDIeliMLhe4JpYtnrtDVgqmtbAtVLjoWrZeuenwkrfnFxK8jhpnl8Pi6PZQHDMnLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718168861; c=relaxed/simple;
	bh=WjmktKeZlwW6thj1REFux9X6Fa55rngqfegdZkghqx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0u6F4NubpVZ/rxkdxnFECypeyYS+T9e0FrTJMKypId1ygeHY5qB2u0CIlh9fwx9wHuxg8b7R5nl2MgvDypMMK+uxJOx8zN/PLECFIbRhcb7J4XL9WGqmqPbtiiqAMLk5cCCSvDmP0gxi6OBbS6AGChC6JiZTafez5jn+1l1iTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhC9JTFw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5784861efb4so1134064a12.2;
        Tue, 11 Jun 2024 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718168858; x=1718773658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvq+FLhWYryoGqxlyUDGx6ThrzsXpwXKMCWedG+iFXo=;
        b=PhC9JTFwlWmiWnwd23Ao3iT/jYcbJy5T7oR+7+0Gq0yuMfCsr5+O8+x66a2BOCH/HV
         9uQ+Z73Yi0hUQCUS46ZjeoS5j19Bq4FD3+YRIaUIh8+i7sjGS5ghRnXDIxEeVSlsjLln
         NddAerrKisaYhp0Ua6ZRH7dGCd7c9S1Vflp14yMCf4qpwu9WZqI7VP1fKWz9s24DMrOD
         szylcnoa/lgleiluBhjbFGQDWCxzozZCkxzuuhrpL/qq6kG3P7UKIVBU56wqMr3+w5yN
         TY7qoMg0Fm/b4WSmo49MYHrgDAiFgpWvlXYBcclndSA4k0ceUXTPhIxmNw7Sm/Ko+MgR
         EFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718168858; x=1718773658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvq+FLhWYryoGqxlyUDGx6ThrzsXpwXKMCWedG+iFXo=;
        b=s0yV8/BzzqJlY089pohtI3oyGBUMeLQlLK3pXpNscczzGaDU0BD/g293w100ycAsIz
         22DzmTu0Ivjw1nY7ScaKoLlgukSPgYmsQMyqFimQ2TaGqXD1nRKxGQwb9E8ErkHnoORC
         8+TOrs+yzTqgl69RUIj7pHKZQgbEN0RD1RaW7fYA8LLheyE/znn2amuWOk+fOEKH1swP
         VdqyHcB1lGw7GSxuIDLr9X9P9SlimNyoniD+9F8QZLVhFbcKeUmvdMNbYij9zYab+QXF
         gjatIZLvlKVZlqgFxhodC/mEkuL8hvLrBr3q9XerObfADj9FLftmwCZWnKGo4icNuTpX
         phuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHehOmhsEvI8juZ6Incd/Yx9/cp7YaBIx6okDg7AGsK9v6CY+uMt7FNrPY/y+dSd1Ts5J4O63jtOpmI+GDufU=@vger.kernel.org, AJvYcCWLmIZJO2TtF7RziPV4e7bwdvzYIJDukF/QyeCuTAwLzullH9+nNqiMsop+8BXrrvXeNGibxgvDsrCMAg8a@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7zBEzl6wZTgQ/AI1HQLLRSYxKfcDlnDKbsJnZYy1t2YQ1nVL
	cpBqh40OiYi+IFk2KcgdWWEpymEd07dCe7kmfzoqGU73O0Na7mDw
X-Google-Smtp-Source: AGHT+IGYL/xS9J6m/swK/Sj5RpwgOawzjyVI55GlBqI24z3BUWgiiKtGTAGXgwiptkMdyimmZp3/hw==
X-Received: by 2002:a50:d591:0:b0:57c:710b:22ca with SMTP id 4fb4d7f45d1cf-57ca97497camr410101a12.1.1718168858109;
        Tue, 11 Jun 2024 22:07:38 -0700 (PDT)
Received: from [192.168.0.101] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c8f3a0c33sm2959245a12.82.2024.06.11.22.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 22:07:37 -0700 (PDT)
Message-ID: <f849b64f-eaf4-46ca-b4a0-039fd0f6f2e7@gmail.com>
Date: Wed, 12 Jun 2024 07:07:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: add missing MODULE_DESCRIPTION()
 macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240610-md-drivers-staging-rtl8192e-v1-1-b5d11ee98297@quicinc.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240610-md-drivers-staging-rtl8192e-v1-1-b5d11ee98297@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 02:33, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib_crypt_ccmp.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib_crypt_tkip.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib_crypt_wep.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 1 +
>   drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 1 +
>   drivers/staging/rtl8192e/rtllib_crypt_wep.c  | 1 +
>   drivers/staging/rtl8192e/rtllib_module.c     | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> index cbb8c8dbe9b0..da9e630b594c 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> @@ -407,4 +407,5 @@ static void __exit rtllib_crypto_ccmp_exit(void)
>   module_init(rtllib_crypto_ccmp_init);
>   module_exit(rtllib_crypto_ccmp_exit);
>   
> +MODULE_DESCRIPTION("Support module for rtllib CCMP crypto");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
> index 0244b524a7d4..3969b6b916ed 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
> @@ -708,4 +708,5 @@ static void __exit rtllib_crypto_tkip_exit(void)
>   module_init(rtllib_crypto_tkip_init);
>   module_exit(rtllib_crypto_tkip_exit);
>   
> +MODULE_DESCRIPTION("Support module for rtllib TKIP crypto");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
> index 21c2b7666d6f..eae75d122553 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
> @@ -238,4 +238,5 @@ static void __exit rtllib_crypto_wep_exit(void)
>   module_init(rtllib_crypto_wep_init);
>   module_exit(rtllib_crypto_wep_exit);
>   
> +MODULE_DESCRIPTION("Support module for rtllib WEP crypto");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> index e7af4a25b0be..469a69726c16 100644
> --- a/drivers/staging/rtl8192e/rtllib_module.c
> +++ b/drivers/staging/rtl8192e/rtllib_module.c
> @@ -175,4 +175,5 @@ static void __exit rtllib_exit(void)
>   module_init(rtllib_init);
>   module_exit(rtllib_exit);
>   
> +MODULE_DESCRIPTION("Support module for rtllib wireless devices");
>   MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240610-md-drivers-staging-rtl8192e-0935b6c4b336
> 
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


