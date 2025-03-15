Return-Path: <linux-kernel+bounces-562609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF26A62E1D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29BC179D94
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A01FECB8;
	Sat, 15 Mar 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="oM28RtlH"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1ACD26D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742048862; cv=none; b=X8ambz2HbhVvYQfp49uQA6qP30ZatWJZ8vSd+I8Vx3l4+seMJ78Qur0t4ZG1zcLMYftmkupYQWMaeDhIGUs+Y6m49D/9VAR/jCTqQrGWwQIMKMG4BXXd4RY8x1KN2aMgel9gP0yalDkj/WO8kOVNuhV6Rt1wYq2zsYJWEBuWw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742048862; c=relaxed/simple;
	bh=hXzuzhU31dBnJ3J+QSMHwZIJhmbHXosL4ufMNjsocBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOFfY8sRgGjvhs4Em25gaUN40smpbnS+W9QEfZdlQEqg8cxTITa3bYWufGKdZHHOY2rI5LT24JUzD3uPFJmugrdH6M8R8S4GJuZCfxRjOmP882/3q9bYJxY1ZnGhe+Lp2VqNU2OwVvgKcvhRa0T1pI1sG+rGYbnYElShEtqJ6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=oM28RtlH; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so10574285ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742048859; x=1742653659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85qKjHMygbhbh5ay23QR06Q47KNXbs3nAMboqHenrk8=;
        b=oM28RtlHlTgvLgkVpxTieAJKjtq/GkvI3MJVmMOb5/w4gK18BLpIAb00cmwrb2GUzX
         7ifRRgNIbYl71cdWf7DYezSITpzybrXXRBm4+8aVhCRMjU6qrrHiNctducao4md1XCmf
         O6G5K7Wc8i/N9sXeuEsCfHKn4YzK9WXH9DlIww9rGjZlavBYl+0AEaSZbJqgEujh338m
         ofENIP/YEczXOptQqyfsWKO9CTRjhxeUKq1YSBh4iYk3jLG46CKJ1SMihp7QEd+dpG1o
         YTv1CGyrMNGxeY/5V+umSI8fuY1pHu4irU7o8XJ2jHJ82NMR2eZxSux0ArppdnYsQcWP
         GY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742048859; x=1742653659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85qKjHMygbhbh5ay23QR06Q47KNXbs3nAMboqHenrk8=;
        b=Z9xADORKhxWyORRj/blmOlYD3PwlQbcB7QlF/t87nOPQ4LH0xti0iupSwTpTLm3ctJ
         qG0JGxW+VDra//LRhHyfxgph1z5I7OcxrwkzFXqyo0hq9nhCyE8zgqMeRNivQwPnrs+Z
         uiY12UEcP/v0UGGOY+NkxU68cuf+E2hmcJphZcfapwvmuvMkkgCxZAPm9gbG68vf3oCj
         yRwfqoot3cdP7j00h1N4eJbpVm1AG7PcFCZPNFOHrL3K4eX/74Pn1Fzuo52n3sNsOQmN
         FkgzpE1QX89CLirVyXeCPVRT0NayWgee0Yq6QRML6uUWb9wpjujAT5C/aTJkqt9QOLnc
         Phlg==
X-Forwarded-Encrypted: i=1; AJvYcCVcRNtt2nqIVm1xR0jWQX5s2nZ0NdNEVmzW0Bp5ISc+HMEnLHpTA++MXNsFv/i/ate8C+yGnU15jzAostQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGZjV7IMCmWSWLM82YB7dpJ3WQhRrbHY0qvsgNSBr+PCe5Ihu
	RrAgE0dguGg1XDw3QsvXr4VoAtdgFtr92odAfhdN0Kr+n/5BYjFZ7KzppkKXK7k=
X-Gm-Gg: ASbGncuSLdUwELctbX5pxy1b2oYYa/VtwC89zSohE9nXzzwbv7RYIv1IhABX7/sZXa8
	ifH43Ay8oVYaApWGzuJWjXUx4PVquvQP/7YBi/vmX86QdUwDl7Ff+hrcW3ggE/VRagVfUr0oxy7
	2DFjD1uIydSjiuFTz+B1tozBYUqFSXYmWP8qMr41Xi/grvmWpah14rP8UnbmbLkee2j/KbE+bky
	QryQs+OEgNb1x1pVUnVwqQIiz4iT29A38LUlkwDeyY2bkoLh68W04t3F6o3fVht/pFoz91F5VpW
	6L7ozziQ0ErCk2o2j+Sm5yANrZ+fgBAVmSxMVeplhv7BAdLmCXRPTV9TUfJmnW2kKzTfKCGpOip
	GXo8bvCGPXFvLBDCWgA==
X-Google-Smtp-Source: AGHT+IG2r58Fk3NA3qR81ukfbE2s31irRsv2remuPcZFqo6brrKgODOh88/Pox0h2KHzwYsKGQ8ccA==
X-Received: by 2002:a05:6e02:1c23:b0:3d3:fbf9:194b with SMTP id e9e14a558f8ab-3d48397e87amr53988045ab.0.1742048858723;
        Sat, 15 Mar 2025 07:27:38 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a6475cfsm15623435ab.13.2025.03.15.07.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 07:27:38 -0700 (PDT)
Message-ID: <3c6bc732-bd90-4a29-bcbc-f545b0ed79ad@riscstar.com>
Date: Sat, 15 Mar 2025 09:27:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EISA: Increase length of device names
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>, Alex Elder <elder@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, alx@kernel.org
References: <20250310222424.work.107-kees@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250310222424.work.107-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 5:24 PM, Kees Cook wrote:
> GCC 15's -Wunterminated-string-initialization warned about truncated
> name strings. Instead of marking them with the "nonstring" attribute[1],
> increase their length to correctly include enough space for the
> terminating NUL character, as they are used with %s format specifiers.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
> Cc: Alex Elder <elder@kernel.org>

This was interesting, but based on the bug text I suspect you
meant to address this to Alejandro Colomar, <alx@kernel.org>.

For what it's worth, it looks fine to me.

					-Alex

> Cc: Sumit Garg <sumit.garg@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   drivers/eisa/eisa-bus.c | 2 +-
>   include/linux/eisa.h    | 4 +++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
> index cb586a362944..edceea083b98 100644
> --- a/drivers/eisa/eisa-bus.c
> +++ b/drivers/eisa/eisa-bus.c
> @@ -21,7 +21,7 @@
>   
>   struct eisa_device_info {
>   	struct eisa_device_id id;
> -	char name[50];
> +	char name[EISA_DEVICE_INFO_NAME_SIZE];
>   };
>   
>   #ifdef CONFIG_EISA_NAMES
> diff --git a/include/linux/eisa.h b/include/linux/eisa.h
> index f98200cae637..c73a410bf88f 100644
> --- a/include/linux/eisa.h
> +++ b/include/linux/eisa.h
> @@ -28,6 +28,8 @@
>   #define EISA_CONFIG_ENABLED         1
>   #define EISA_CONFIG_FORCED          2
>   
> +#define EISA_DEVICE_INFO_NAME_SIZE	51
> +
>   /* There is not much we can say about an EISA device, apart from
>    * signature, slot number, and base address. dma_mask is set by
>    * default to parent device mask..*/
> @@ -41,7 +43,7 @@ struct eisa_device {
>   	u64                   dma_mask;
>   	struct device         dev; /* generic device */
>   #ifdef CONFIG_EISA_NAMES
> -	char		      pretty_name[50];
> +	char		      pretty_name[EISA_DEVICE_INFO_NAME_SIZE];
>   #endif
>   };
>   


