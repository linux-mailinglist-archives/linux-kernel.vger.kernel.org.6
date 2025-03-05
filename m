Return-Path: <linux-kernel+bounces-546670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E401A4FD81
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2EC188F051
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BCD230BD9;
	Wed,  5 Mar 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqJJBcB0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0A226D05
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173745; cv=none; b=g55I994n1i5C1P9X6H5e5j7GPlQ8gCkMEs/PN8sM79eXYSkbgAcwskMcE08MFfsApzHZOYYej2jP7nFC7qbweC1Ofa9b8tbwnmWrAFD8WzTyAuIRlOMLv6bXaJc6llWupuxa6uUd7v32X2jtvAuk5QhhBP0qMbsGd3NG0QlvvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173745; c=relaxed/simple;
	bh=PL/unZm/ZH0RJcs9KK1xQaDQzz34LrfPAoVz0gOcWGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RYDQmOcsedZxs0AZ98gfiplgYYho1mbYspCeyRXfUeUMqPI4Rk/4QBDfPToQv0iZ9exRjWWq2CCs+T+A8cOat+WZWP36nospmo/BUKhWP/e7AqGiPNuWxxRjyKnm0EZRHW8fVL3lvimJJ3UhL3UH0ok8KpfCgMHx2+yAJPyfoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqJJBcB0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741173742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EynjiZwwX8iiFZPJPCgUXCVQenFN9tz9ovB65nknNg=;
	b=KqJJBcB01qm2s0Vu8r2GMNFXlicxgofmRNBvZTcGGUkejHvfUL7DcsLC72Yka3/qlXj5eN
	8dKcehIWZG3Myi2rO8AftTExhvhbjlctE4VCybWfLrf1sYR6ByskdNIAwIXp33F3/MLpzV
	qoQ1Y4PmSXNAuPGFu8U0xfAJMGgh/z8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-wcQbpmAlNOSs1LnUVqb87Q-1; Wed, 05 Mar 2025 06:22:21 -0500
X-MC-Unique: wcQbpmAlNOSs1LnUVqb87Q-1
X-Mimecast-MFC-AGG-ID: wcQbpmAlNOSs1LnUVqb87Q_1741173740
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e4cc705909so3353548a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173740; x=1741778540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EynjiZwwX8iiFZPJPCgUXCVQenFN9tz9ovB65nknNg=;
        b=aNBBfCkoXkLXQCEzVaLQ/Klk3Rbl50mHEsM1veWuxCmC5Ecl8FzYIV4x+po7LLSu8K
         PRDolrG2oJItmo2Ildr+ViDk8rnPA/sJSwPYeP6lPuRMREuaqN19BVim4oxZ+MYF/sOJ
         aFo90afFJR8rcgDiw2kIS7DRphnBzyVtUCP8Xb+aBdT3UDKZEYoJpRrsyv/0H5GP4+Q4
         w4gx26i6hX5XaHwe9ugrVlFcCVasJfMU8fpRm/24vcLj1shz7Yx/5qJwYGsfKshKC7Jp
         ekvAFbL9UXsAMfbhLQwb4xIIe5QM+GQSTmPi9jTiCkD92nz6mOJ8bIGa4lQW6o+N73yg
         EnTw==
X-Forwarded-Encrypted: i=1; AJvYcCWcqWQMPgvfNLPrU2xqP/imvgte4JjUa6X6ZjFLf+WoKwX4ZxQ2GyedUEX8TQJehz/1aeGq2uXzyR7exss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJJODqWpqdaqACKlRI4kKvv7xuya+vkvP15AQqk2WBxjJULmy
	tnPthQupaZU5rs+E12YwafWRSe21yoi7YxuzS1KJmvy+Dec3SosbIlrJ2lum2QUArnETjAMQCuC
	ae1b0dW9UgvEYlaS2phtpZRq7FbRbP3C+wltcrojS+QfqmZ4b1MxrAoCFWdSXKR8Vvsn9Hw==
X-Gm-Gg: ASbGncs9OAnf0n3nELDXENWWZ1pB00jAhJyo0y8/FgKwjPVlZAhGWymKsG54j74ygp7
	FreGOMQsKwQX/FQ2AxCciOWRlRUAUdymUVRfOZ3sZUzv0wX5LCjXZtv//a+zcx8xpqmLO6QKmNQ
	i69aTwzImmsZGDCalWSzhkyMXLYz5pPEolEe6YEDb5rX6rgTLBvW18XSgVc6Wu141iy+eZXS2ra
	MJI3EBsfXjSN7cPUf/3YG73+QrJjJNaXy7rGkYJWV3IfCWRQ2NPZOUvwF7bgiRvmSCgkX48wXXY
	gpWK2I6ygyv4nqIaQ0ypjLhI06ggXKYMlHD11h6oZBJSWu5JdL9rIBFTMW4n4LAduNf7g3WzcJ0
	EhvDxEgOf6qteRE9w4Rq1C0yipmzwuVWCsed3oDZr4ONH6WRcryZf4biAuNG/c7Z5Dw==
X-Received: by 2002:a05:6402:2811:b0:5e0:9254:c10e with SMTP id 4fb4d7f45d1cf-5e59f3c5f17mr2555789a12.11.1741173739715;
        Wed, 05 Mar 2025 03:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtcx8PqIt8taHhLXx1S9ltHSnaqYkEwukF+XNfDCZA3U76w5JdSb35Lct6h2VK3o2px+7X4A==
X-Received: by 2002:a05:6402:2811:b0:5e0:9254:c10e with SMTP id 4fb4d7f45d1cf-5e59f3c5f17mr2555772a12.11.1741173739399;
        Wed, 05 Mar 2025 03:22:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb7251sm9377742a12.39.2025.03.05.03.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 03:22:18 -0800 (PST)
Message-ID: <b8fb489b-bc7b-405a-8ff9-f7438d855c94@redhat.com>
Date: Wed, 5 Mar 2025 12:22:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger:
 Make symbol static
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On 4-Mar-25 5:06 PM, Ilpo Järvinen wrote:
> Sparse reports:
> 
> lenovo-yoga-tab2-pro-1380-fastcharger.c:222:29: warning: symbol
> 'yt2_1380_fc_serdev_driver' was not declared. Should it be static?
> 
> Fix that by making the symbol static.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
> index a96b215cd2c5..25933cd018d1 100644
> --- a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
> +++ b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
> @@ -219,7 +219,7 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
>  	return 0;
>  }
>  
> -struct serdev_device_driver yt2_1380_fc_serdev_driver = {
> +static struct serdev_device_driver yt2_1380_fc_serdev_driver = {
>  	.probe = yt2_1380_fc_serdev_probe,
>  	.driver = {
>  		.name = KBUILD_MODNAME,
> 
> base-commit: 432c2adb9e2f84f81c4b218acb07a2cd3dce64a9


