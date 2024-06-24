Return-Path: <linux-kernel+bounces-227131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BC59148D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D921C1F23ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DBF139587;
	Mon, 24 Jun 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlVCjkRj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC2138495
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228842; cv=none; b=PCS4WyigrNFXvCZz8c2p3z85vThk5bJF3vZbuEYyPXk/9595w3/xcMsG3TVpQg9TmVEC+5ex1XyyNnRgqWhYIxiVZz7+6qHhGD03uWtswQpmcA7VUeXB/ySpBGGgjBWBGGfKSr1ybW5LDorb4NkbJbLb1kKPOnRJ5xahQvAl/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228842; c=relaxed/simple;
	bh=E27VeBp0L3wh/lWcmKu18PcxmDIts+AAE8lfLuX8e6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW5l7bbwtT1vIn51CjLltcfl4BzoXx4xMgxZhKCyO32HHreq0tNr4oaRqJUxx5DRABcEz5Y5/r//Ooe1ZhfU8WMaOIlkoZxQDykC1OWsA0vke4PGY3djD4uRTPskxqg+70EWU/ew30rI4ajJvHSATS22J4+VCN5VBtgQawDfhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlVCjkRj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719228840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ihp+f25iG3MeuRzLeQNN9+ypX1FQGCz6g9Ryzz3fUzw=;
	b=VlVCjkRjf8FirulsRLh/nyE2UFuw/eXSwHl93QZf22r1z+3yUP05SbY0VtjmjN1vsUl4yk
	jggDHus5dXD5uhVabHMnTqN601CRWriAFq8vJhW/20quH1LLJrbX8bsW+T/I3aHcfJzTeP
	ohoLkgOW5fiIppMBD7AMRLcgkJ650XI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-eQkcTm08OBKTHEQLo6Qung-1; Mon, 24 Jun 2024 07:33:58 -0400
X-MC-Unique: eQkcTm08OBKTHEQLo6Qung-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57cbf06fcddso2114875a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228837; x=1719833637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihp+f25iG3MeuRzLeQNN9+ypX1FQGCz6g9Ryzz3fUzw=;
        b=rzmxpW4TZgzKGvczNHpL1EDAPr2PXiYlNTXEHOAHCZqS08NZ4XTzHTaYvccJUxeuqA
         +Kj0AGL2e7yVTpQhsEg7cKaNc+rh7uQbucgXjMudZxSY2T8ZEmvVamOJsqoPgAMITcLh
         E/jam2kmrtSIomXgzCCQsNiQ7iKsCQQ/NFeVlPNnT3yLkNINsG95qDA7+UKQPloU2SEH
         JjvD3JUiTWBU3GYZh59kotIY1czoLzjWvLR9iP2rpaGJGZvqrisf+EkV8hOIXdou8LOi
         /0FqfpHBLJHL4HJ3iIaIf2vNWHU9AoiH03KbxF4W0VGuOXd9F18URc4xMlCnv7VI8Nq0
         dMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfNzOMdKHBniHq3HugU+TyMf9+OeTanXWtltTWhPmGYqMXutrvr0Fn1VMydGPK5wiZ/C7tJF3zuGJwECjC5w6beXBi8YdmuHu8QE2e
X-Gm-Message-State: AOJu0YwEq4iU1mv2f+pApcFURtc5r/hCJAS99wq46Pp66WxzD3A036k4
	8F09axBgHNWAxf7IxGKUcJTOmafX7mqRq+AylvxsVF3H2s0uREYOtac7cbjcpwv3+gntwKDT9SB
	L+g7mzMUMLkT+h4vAOFYRpIxK2d0L7Ji7jLwL7jDpuNXr3UTZGWeGFSpec6SQRA==
X-Received: by 2002:a50:d552:0:b0:57d:4d2:83fa with SMTP id 4fb4d7f45d1cf-57d4bd53811mr3457367a12.9.1719228837652;
        Mon, 24 Jun 2024 04:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOAkJEJmUJrVPcuILZOvyw7ds3cfckFPT0OK/leclOB4nL8YBWpcF86g6vY2d4xNKx5JPhDQ==
X-Received: by 2002:a50:d552:0:b0:57d:4d2:83fa with SMTP id 4fb4d7f45d1cf-57d4bd53811mr3457352a12.9.1719228837180;
        Mon, 24 Jun 2024 04:33:57 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d31f33086sm4406438a12.61.2024.06.24.04.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:33:56 -0700 (PDT)
Message-ID: <7941463e-1d2c-4d5a-a772-bf8f60db58a7@redhat.com>
Date: Mon, 24 Jun 2024 13:33:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/siemens: add missing MODULE_DESCRIPTION()
 macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
 Xing Tong Wu <xingtong.wu@siemens.com>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240611-md-drivers-platform-x86-siemens-v1-1-b399d7d6ae64@quicinc.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240611-md-drivers-platform-x86-siemens-v1-1-b399d7d6ae64@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/12/24 6:25 AM, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc-batt.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

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
>  drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c  | 1 +
>  drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c | 1 +
>  drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c      | 1 +
>  drivers/platform/x86/siemens/simatic-ipc-batt.c             | 1 +
>  drivers/platform/x86/siemens/simatic-ipc.c                  | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c b/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
> index 31a139d87d9a..5edc294de6e4 100644
> --- a/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
> +++ b/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
> @@ -45,6 +45,7 @@ static struct platform_driver simatic_ipc_batt_driver = {
>  
>  module_platform_driver(simatic_ipc_batt_driver);
>  
> +MODULE_DESCRIPTION("CMOS Battery monitoring for Simatic IPCs based on Apollo Lake GPIO");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:" KBUILD_MODNAME);
>  MODULE_SOFTDEP("pre: simatic-ipc-batt platform:apollolake-pinctrl");
> diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c b/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
> index a7676f224075..e6a56d14b505 100644
> --- a/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
> +++ b/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
> @@ -45,6 +45,7 @@ static struct platform_driver simatic_ipc_batt_driver = {
>  
>  module_platform_driver(simatic_ipc_batt_driver);
>  
> +MODULE_DESCRIPTION("CMOS Battery monitoring for Simatic IPCs based on Elkhart Lake GPIO");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:" KBUILD_MODNAME);
>  MODULE_SOFTDEP("pre: simatic-ipc-batt platform:elkhartlake-pinctrl");
> diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c b/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
> index 5e77e05fdb5d..f8849d0e48a8 100644
> --- a/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
> +++ b/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
> @@ -81,6 +81,7 @@ static struct platform_driver simatic_ipc_batt_driver = {
>  
>  module_platform_driver(simatic_ipc_batt_driver);
>  
> +MODULE_DESCRIPTION("CMOS Battery monitoring for Simatic IPCs based on Nuvoton GPIO");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:" KBUILD_MODNAME);
>  MODULE_SOFTDEP("pre: simatic-ipc-batt gpio_f7188x platform:elkhartlake-pinctrl platform:alderlake-pinctrl");
> diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
> index c6dd263b4ee3..d9aff10608cf 100644
> --- a/drivers/platform/x86/siemens/simatic-ipc-batt.c
> +++ b/drivers/platform/x86/siemens/simatic-ipc-batt.c
> @@ -247,6 +247,7 @@ static struct platform_driver simatic_ipc_batt_driver = {
>  
>  module_platform_driver(simatic_ipc_batt_driver);
>  
> +MODULE_DESCRIPTION("CMOS core battery driver for Siemens Simatic IPCs");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:" KBUILD_MODNAME);
>  MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
> diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
> index 8ca6e277fa03..7039874d8f11 100644
> --- a/drivers/platform/x86/siemens/simatic-ipc.c
> +++ b/drivers/platform/x86/siemens/simatic-ipc.c
> @@ -231,6 +231,7 @@ static void __exit simatic_ipc_exit_module(void)
>  module_init(simatic_ipc_init_module);
>  module_exit(simatic_ipc_exit_module);
>  
> +MODULE_DESCRIPTION("Siemens SIMATIC IPC platform driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Gerd Haeussler <gerd.haeussler.ext@siemens.com>");
>  MODULE_ALIAS("dmi:*:svnSIEMENSAG:*");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240611-md-drivers-platform-x86-siemens-9e7c20b9ca24
> 


