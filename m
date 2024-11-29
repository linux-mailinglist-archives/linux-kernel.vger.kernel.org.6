Return-Path: <linux-kernel+bounces-425998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ADD9DED9B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50049B21AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC11A257A;
	Fri, 29 Nov 2024 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zr+fQ40d"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D5158527
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732923073; cv=none; b=icTXqLRRX675lMPz9uu5T7WLkdd/hZYiQ0xABzr62Y5eGKRlfNs9V+MVwp5go3aPvGewkqD7Zn6Dit45wY2AbW4MmH3WOsMwrJh/RJHqT/McGR0loqbwiwLHtq9X/Wy7wTtLx8Qs717DkgXRhElgaNzMoo07hrj8fRiX22o7U7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732923073; c=relaxed/simple;
	bh=TzeLF3QcB3Hf0datyvWeAMYglj1yvT4eY0FnhcZxwBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DK/t/rK1yjZeHAz+nU+PGQsvWnW4bpk2/0Rm2+1s3vYbyD1alYU5KOMs/3WSgtDVPOy04DM1EVWPAaAjDzU1AMrOQb2LdaLhNcZxeQ07EOZELwWMBEmJQ9SEcSXW+Vxbys54M1LJ01kqsIAgb3FwUAm+0c4da/2kWugGAnG9b0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zr+fQ40d; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434aabd688fso15094925e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732923069; x=1733527869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fwf2ZpyKf/ZtBImPmb08+6DmBeOBIjCMYguEVZ/4P84=;
        b=Zr+fQ40dl0sC1Eh4pSzOJ4uK1FzBZrQ7eWXHmyWD//HEI1FaO48TvjJ0hn06SsPdN2
         +M4KM5DoS9008fGk2+3P++o6grTTYD0WtYuAv3OtPNnjcPVtex278fkTpqYXU98xRdK+
         MMLjk0NY+zMqB82VCOHu5dTHTrYv1+zp/fu7T+Iblyghavj+P+K4APDq0HpNfOadctkV
         MaRUQAaSpMiCVCx6oolbJtxlpWTKQlnSY9talsqG7qpYfbM5ZHJuUv7raXg+XOh8bmNN
         IoPHD72JPXutfQBiSi8pEUzSTJhbuILtx00Xok0HxQZBitN2OJsUh39RYbKLCmWKjaCi
         KV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732923069; x=1733527869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwf2ZpyKf/ZtBImPmb08+6DmBeOBIjCMYguEVZ/4P84=;
        b=P5fW7LpxtRqigQ/qB7aPLhLJ5OyZ2aaLqF9aJvgfs9lGnKiBmGcVHEm6nf2/nE7Rbb
         G0nEct27cVZF7O2TrSU4wRB9CKFYxbefPcUfNDr/TGLArhnBN7RHo+KY0QCqWaFimoSV
         HNBanW2OWcbQ8/iXdFJ5yUDrK6OeNSWg/+r+7ymY4YG1fMlZbpCjSZG/SgCg1DVBpLin
         YwRmmW4wqD8NgWylxcCgv3tHK360fDkSUCeH2ttKnnyCIk+jcZIi0m6/U1SHnCkMfQtb
         gftCuwWQWmofDFOpt4YYn1np0Y183c+VwmUF2Un3H/5fhzGbZYn13PKi8z/UMH7zij8/
         AaPA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZQOBxmsLOpbnRYYSyJ+Zw9ZrXFx4PrI8TAMHvRBSTRmd1gnQ7xuYy15QtDaZzjrXktQLRotgcSbduOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgbnMKtxEr7jzfAKrFVRm58ra4qHGilWVRi3mLKgNevHHijFv+
	Seao7oHQaAtxoPz5Ko+CihgDn/rxHs9W71QDYW0FW4uaGo88XpoQyf9VCkBtXJg=
X-Gm-Gg: ASbGncsxCZLkp/UZeywBL81YU0sS2+biUjJxWM1jvl8OBNSSFgYb3hOKcmGU5AVQdUd
	Va35L8XQ8+0GZgEsVs37TnxLCI9tW+fyacNDV1QG7+HJKfzKj5oR7FUP6TeNYn+yggkx2DKM1H7
	MrWES1dw/f+j4vxiSrNcYIbLeXGadgnLT8s37TnyWjGbNCahCkbXUQiZB6Kzdk4TULfb4JVzp1v
	S8VnwhNnrJXcilPN4ENzWFLEmzN9tmlyaFzeUCwNLTHFSOkk2RPI1ITLHXrqfjVtSDpQVaNG0wW
	X1kedDrqHfMbI2JkrmqzTU3B
X-Google-Smtp-Source: AGHT+IEykCxTGZMCKJYW5Uspz4zr6yyrHOVmE4xBgO7Vj/5z1tSmuzot/DIJMWX3+1MAZ8NoNO4Q3A==
X-Received: by 2002:a05:600c:1ca7:b0:431:5187:28dd with SMTP id 5b1f17b1804b1-434a9df6aedmr110283385e9.28.1732923069512;
        Fri, 29 Nov 2024 15:31:09 -0800 (PST)
Received: from ?IPV6:2a01:170:117e:fc:8db4:3ffe:8420:e745? ([2a01:170:117e:fc:8db4:3ffe:8420:e745])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7dccasm66191865e9.43.2024.11.29.15.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 15:31:08 -0800 (PST)
Message-ID: <b453017b-d719-4984-91d9-f28d34352d8f@linaro.org>
Date: Sat, 30 Nov 2024 00:31:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/23] kbuild: use absolute path in the generated wrapper
 Makefile
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20240917141725.466514-1-masahiroy@kernel.org>
 <20240917141725.466514-22-masahiroy@kernel.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240917141725.466514-22-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Masahiro,

On 9/17/24 16:16, Masahiro Yamada wrote:
> Keep the consistent behavior when this Makefile is invoked from another
> directory.

This breaks building in a chroot for me. I usually compile the kernel on 
my host and then use some tooling to just run the "package" step of an 
Alpine kernel package definition. See

https://wiki.postmarketos.org/wiki/Compiling_kernels_with_envkernel.sh#Packaging_kernels_built_without_envkernel

Since this requires mounting the source directory into a chroot, and 
then symlinking the output directory to the package "src" dir. It relies 
on the fact that make can be run from the output directory and 
implicitly relies on the include being relative since the absolute paths 
don't map inside the chroot.

I'm not sure if breakages like this justify a revert, but I noticed this 
issue in -next the other day and thought it was at least worth reporting.

I wouldn't be surprised if other folks with other build systems get 
bitten by this too.

Kind regards,
Caleb
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   Makefile | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index ce646a6994a6..9f0ba07e8f25 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -643,8 +643,9 @@ ifdef building_out_of_srctree
>   
>   quiet_cmd_makefile = GEN     Makefile
>         cmd_makefile = { \
> -	echo "\# Automatically generated by $(srctree)/Makefile: don't edit"; \
> -	echo "include $(srctree)/Makefile"; \
> +	echo "\# Automatically generated by $(abs_srctree)/Makefile: don't edit"; \
> +	echo "export KBUILD_OUTPUT = $(CURDIR)"; \
> +	echo "include $(abs_srctree)/Makefile"; \
>   	} > Makefile
>   
>   outputmakefile:


