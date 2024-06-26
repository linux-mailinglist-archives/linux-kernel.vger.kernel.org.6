Return-Path: <linux-kernel+bounces-231450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A46B49198DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42C0EB22BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD98192B65;
	Wed, 26 Jun 2024 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="YDC0U6vN"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B215E5CB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433108; cv=none; b=VAAjBPTxLHGQdsIE1khkjM2M5iX9i4sFYyBua4Yj4VTBfSd53vOYSA+HquUGzYrhY+8l3TNWvZr9MJWXSmWUN3uJGgoJxjttCpsyOi7drlPukA7KVgJtazJHucP8ZGUm7vlwZFaMKVjqACyH6R2Q4ami3ghaijApYZSKZUkYiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433108; c=relaxed/simple;
	bh=Ftq67nm0JfYOkpiAIY6KRhsDW2bsJuzJxWDFtGcclIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnRh/UsrVzi9uk2mwSvpQky3XGywj5vKAEI0PmUBcoWTe+82DytXx9MY9XbdNvrTl5jhMW6pZDw4VhjNV7yfPch8jeX8E8wqubz1p6fBFmLUpriD2Hv/T8tec1+xSzACi+toOEVJ3J+QpobSomBdVvnTn6eQLQz/1ier+ytcuTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=YDC0U6vN; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so918332a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1719433104; x=1720037904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwK1TIVcZa2quDepKblugLh91hcpk5uPsbaDfQj8P3Y=;
        b=YDC0U6vNHOEV0QUJ7OfHKQMNWEEFUDhnF8sctvxsERXvt52YoTf+RjvlCYPfcDj0qH
         FFwneNW6ESqv1c5MPlEeKasEokVEb2oFKsizyqPjnD2zaRit/0YN9KSUEAOXeN1aMQwv
         f2NUIJgJlb+IURByE/k6c8XsvqsOCs0UwTQGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719433104; x=1720037904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwK1TIVcZa2quDepKblugLh91hcpk5uPsbaDfQj8P3Y=;
        b=J5qjwlao/7A7vumOEMjy1xrptnLDF+kWyC5tE5cmSBR0CYjfSj7GBISv4dDT1eVyOW
         6+rGELkckyXwn/CPZsxLrt1oRQ1ujuGHEtm4QHcNQ+xS2QyDlKDajl//2+KT2ydW5qSf
         V2OFtO+MXWKwk77YIJLskPSRCI5o9nfuqdszqoP+f8r9klHi2wozXaf5NFuqHOCwY6nz
         CcSkbKA1aypPf9k17LrQ5ITxR3Nt29g4R1+VCUXdVEQkgL3JcDpGZvLBGUTJS3nnwMYI
         UjNcr0cFBak/2DpMeBz5/VF5lf+ff3EJKygHoPwUcG+uHkBIWgG1E5SvX9fQnEaIOBuT
         PSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDJdjX+EbjeMxSCNMAePsFm14cS1pUtOPfWunAmnT2FgiGnO0luubcfd7lkq4vWXPnCUCh9bMnDxSPGh2o3Ycc46upUfSXBKHRE2rk
X-Gm-Message-State: AOJu0YyHr3c0kOFPKVbiJBxcJDk3MwjSQlmVuREm31lwhAswCwAyxVmY
	WTLMYZPtWbkkTZ+FpOm2t0pGojbfRu8n3c2x08li/xoEbFmnmxb6zWRzznZyPA==
X-Google-Smtp-Source: AGHT+IFkPZrAZf2Dv1I/tcG9HNqylGU3EOg+zPZYcuRIs218Pi3Cs/RkddJTLupYtqHQps+mECBsfQ==
X-Received: by 2002:a50:8d4f:0:b0:57d:10bb:b42b with SMTP id 4fb4d7f45d1cf-57d4bdcba20mr7272393a12.26.1719433103808;
        Wed, 26 Jun 2024 13:18:23 -0700 (PDT)
Received: from [10.211.55.3] (p5093ccb1.dip0.t-ipconnect.de. [80.147.204.177])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57d30534b25sm7513702a12.68.2024.06.26.13.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 13:18:23 -0700 (PDT)
Message-ID: <a132dc0b-2b2c-41db-9d09-4676a3f88535@ieee.org>
Date: Wed, 26 Jun 2024 15:18:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Johan Hovold
 <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240607-md-drivers-greybus-v1-1-31faa0b21105@quicinc.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240607-md-drivers-greybus-v1-1-31faa0b21105@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/24 3:56 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/greybus.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/gb-es2.o
> 
> Add all missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

I would drop the single quotes, but I don't feel very strongly about it.
Greg can offer a second opinion (taking the patch or not).

Acked-by: Alex Elder <elder@kernel.org>

> ---
>   drivers/greybus/core.c | 1 +
>   drivers/greybus/es2.c  | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
> index 95c09d4f3a86..c28bb973f67c 100644
> --- a/drivers/greybus/core.c
> +++ b/drivers/greybus/core.c
> @@ -375,5 +375,6 @@ static void __exit gb_exit(void)
>   	tracepoint_synchronize_unregister();
>   }
>   module_exit(gb_exit);
> +MODULE_DESCRIPTION("Greybus 'core' driver");
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
> diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
> index 1ee78d0d90b4..db4d033925e6 100644
> --- a/drivers/greybus/es2.c
> +++ b/drivers/greybus/es2.c
> @@ -1456,5 +1456,6 @@ static struct usb_driver es2_ap_driver = {
>   
>   module_usb_driver(es2_ap_driver);
>   
> +MODULE_DESCRIPTION("Greybus 'AP' USB driver for 'ES2' controller chips");
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
> 
> ---
> base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
> change-id: 20240607-md-drivers-greybus-a13b64e41256
> 


