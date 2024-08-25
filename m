Return-Path: <linux-kernel+bounces-300394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1471995E32D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4800B21224
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A627145A0C;
	Sun, 25 Aug 2024 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS17tEhT"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A751DFEB
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724586912; cv=none; b=iQL8KDtFHHFEyinkaiigA4HLsqlXfehwhNqn38St0ok//gp1ITWM8KuqdL/uybsrWwk+3AM0YFwp8LZV/kQs0+evwdJAY1FYUgl4oX8cFZdYmuboq+grlNnwfO/biNNqgLnt7nL56jhM66+UTVONtJHS86uy/FcUWG0MV536xMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724586912; c=relaxed/simple;
	bh=HcJUuLFpKuijnCU3/u+Arsy2kIWRYNGc2Sm7LJ4w6Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoXLmeVpqGX5H6WZMAQqdEm1IMZGE0fSNoFTn4+G9elJurpeOrqHTEYzrs3izfkCHh7WHTFbKIpuj607CcWIIl/3bh7L2IzsNGKRh4Rb1eAQSqT/c9KKhuTJG/1FB2mwMbr3HEjcKwAjISZOsarpxWv2bLDnWul/ujLrni7jvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS17tEhT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso39484441fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724586909; x=1725191709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/gr8r3z0xbWoFoMR59ssS3HO5X3Ia34kn0VOARppxY=;
        b=ZS17tEhTIE0EkEzPAsNBTu1yNVKvhVXz4hIxfBmq5SoBc5TJkm5Aa2Ff2Tg3ocRd3l
         iD8D5+l2fxMIxbKfYMeIdUFLaTVAPcFhmvE9NoeIimFUaR+dRzHJoj1wj6QsPCreK3ww
         KG3DxK1plnNl04Ccayrpi6ExR3oCieAAiJDquM+MraS/RsU1KNhGQsYbPG5VWPbyNHb9
         QtC8fFX1hZ50upnZdnb3jkgh/NnfMtYgTU2skkxywoWdPpOOTrE36+i2x7wvlTyqAurJ
         g7XpwgXgwYjBbXbww4Q2qQTpblfFVKMF2UYYktHNn3dgFXSv2VM6trHotM7GAoE5afio
         3Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724586909; x=1725191709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/gr8r3z0xbWoFoMR59ssS3HO5X3Ia34kn0VOARppxY=;
        b=QxKUtUEfEdGbEk1d4hF55NuJ1AHsrtqCfmh3R67mOM4ngzMVjo2nRQo6oLD5sO+Od+
         Hok3THKgxvtKaNmUXWpf0paLys7GNLSa1mtFyUTcSyFqxURWinkU8HaUXFx6x+HBOfNs
         Ubl4m5/FX3486PVh4aWLSrHPjtDiDTNgkXD91EAYwIKZvHdFo99yn3OeqghHRu+Nd0bS
         thl+jnYySzQHAYgy8zeiyMRijEiXuLu/1IFJqpSrGuqp6/mXQOWNZ0Lejtb9lmJc2A5S
         pQf50dUTF3HcjbpOfOoIyYjPPtSi7AzaIPmfD83GhVELav6Bf+/aR7XJeIiLSZ76xzXG
         arww==
X-Gm-Message-State: AOJu0Yx5cFXqgJOb27jTFTDE0ImHESewM1UJKp3gmw0WFOjVUUe+Q6rP
	VtgmMenmnKZ0wmyWCoFsw5CQ1RXYhC+pKV6Dck+KoHzO2VsDkYVfIIB8NaO8
X-Google-Smtp-Source: AGHT+IHe+nraT7XwWDSuZHR8YB6Jjz1/lOqN2JwWoPaQpcCk3szSyx2RNl3dOm7+AQfmvNZ/XMsqMA==
X-Received: by 2002:a2e:1319:0:b0:2f3:f828:efe7 with SMTP id 38308e7fff4ca-2f4f5751056mr49827691fa.16.1724586908381;
        Sun, 25 Aug 2024 04:55:08 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047a4edfsm9849851fa.20.2024.08.25.04.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 04:55:08 -0700 (PDT)
Message-ID: <a7ab6f74-08ba-0749-3889-b6d040457ac7@gmail.com>
Date: Sun, 25 Aug 2024 13:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] tools/leds: Add '-h' & '--help' cmd line options to
 uledmon
Content-Language: en-US
To: Rajkumar Vadhyar <rajkumarvad@gmail.com>, rbmarliere@gmail.com,
 skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
References: <20240820072341.41153-1-rajkumarvad@gmail.com>
 <20240820072341.41153-2-rajkumarvad@gmail.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20240820072341.41153-2-rajkumarvad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rajkumar,

You should send it to linux-leds@vger.kernel.org and to LEDs maintainer.

-- 
Best regards,
Jacek Anaszewski

On 8/20/24 09:23, Rajkumar Vadhyar wrote:
> Add '-h' and '--help' command line options to uledmon
> 
> Signed-off-by: Rajkumar Vadhyar <rajkumarvad@gmail.com>
> ---
>   tools/leds/uledmon.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/leds/uledmon.c b/tools/leds/uledmon.c
> index c15a39c1f271..6609235d80b0 100644
> --- a/tools/leds/uledmon.c
> +++ b/tools/leds/uledmon.c
> @@ -11,6 +11,8 @@
>    * CTRL+C will exit.
>    */
>   
> +#define	ULEDMON_USAGE	"Usage: ./uledmon <device-name>\n"
> +
>   #include <fcntl.h>
>   #include <stdio.h>
>   #include <string.h>
> @@ -19,6 +21,7 @@
>   
>   #include <linux/uleds.h>
>   
> +
>   int main(int argc, char const *argv[])
>   {
>   	struct uleds_user_dev uleds_dev;
> @@ -30,6 +33,10 @@ int main(int argc, char const *argv[])
>   		fprintf(stderr, "Requires <device-name> argument\n");
>   		return 1;
>   	}
> +	if (!(strcmp(argv[1], "-h")) || !(strcmp(argv[1], "--help"))) {
> +		fprintf(stderr, ULEDMON_USAGE);
> +		return 1;
> +	}
>   
>   	strncpy(uleds_dev.name, argv[1], LED_MAX_NAME_SIZE);
>   	uleds_dev.max_brightness = 100;


