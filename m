Return-Path: <linux-kernel+bounces-513412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB4A34A75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8423B5305
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644D5212FB6;
	Thu, 13 Feb 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mnJDTdqL"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD320409D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463531; cv=none; b=tw0kJKLl/P+VToZ5Xc6Vh1dFw+KNvXk35yhgbghe7GOB8pYQh+50cb5qLo9yJKYwa1wWXEsGubmIygYXMg2rto1J+HCdTU8EZPmjuWAzeqfWAYQlBjpIvxLZ7a4Md111uSuFfX+EnXCqRS3n1fpoPte1r1NPpf46/XFxA4C891I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463531; c=relaxed/simple;
	bh=FPEZM9FyvR3U6n4xCdl/NKl6rhtE2PyRI2Op+6EI5MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7U+BDYFsFjAieKHPw31KSki6MDAU4nRifIXaG2Jo0Mb7B+sYhUKZJdsxrQuuaNcbBaUXtn8XWvPUaDfMZ8+v5pZxnnU/yHVqf4f/CJgvnqFGAi4SXZ7RCQO0A38uuHnNiKM7CviMTMe1oAZRGFw4UIf/h+ednqkjGWlAyS/3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mnJDTdqL; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-726fec215d7so675544a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739463529; x=1740068329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wk0Ke649msGfj609eFpxLZzrb3zbWSGeBEU/UMBg818=;
        b=mnJDTdqLOdB8K44ye0GFUh8u40ijPypdKkXPA8svvypjDgZ3hyYZbRuROW1vdsN5jI
         tFh9PtX5YWp0yAHTkdRDN8BYiuoMG4b7CWQ5cRHZcRSfKERc8AgnrnnPUfzWha6YtHPM
         Y3M4uqd8eVPKcT9iA5z3Qgwzc/N08CuGTRX+9uAWRCC/FKM4XaqUT3vyw7Hi1T4TOpJt
         r+6WPb3y71ygwT1WjJzxb4Y3SMFYfow++Gkq+o9fs284aRFKZT22Zy8rccCZ+OdDHak9
         BAkd9ZyxF61Q5UJOXEobm6lpmFo0QChIowkaIluJD/ewf5/DZEXm/Cqur9PtN/X/ltQ2
         vOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463529; x=1740068329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wk0Ke649msGfj609eFpxLZzrb3zbWSGeBEU/UMBg818=;
        b=OuY7wsVYIGzqWYT0IWDFDNth4cv7/iCsBR0xW8KTO6jANviOHObryRrGv7MfDKyfGJ
         NzoVje12ypN9ouBucdArBUIUBX91TFrTuLpHkI5Ag/6NGsWFzkhIbv3w4mJ+i1AvIZOe
         91KwX3zrojb1ZmOlPyjI7AD6+yaWJEiV34hCDd/FJMvrdJXf8Z/oZYYFeWq+Jchu9l2b
         PCBtTV5T+cghXtLe9T0LBc0VAP7DIomLQaoTQuLJkoyrKqeB16z3BpXuXDpr232XgW+P
         JorG9qPuTQsyuX9MT+uKnmAVf8r88wndbGfC0Ug+Cl6EQE3JbUeCeCShE4o9LKioSbZg
         OHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIXoBzGkUqbX+3oIESqBaAhv9c5QXh7KmN8+up1MhKu3oF7k7+rbN4i6IKkOHMDQpIhNya0nzlqFSAVN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfS1K50ECArrm6wLcjuyRAkM9UbQeRt39rvDgJZQMdYFzEIk+
	rGibCzkLoDDRLxHEdKMyCsf4jhlXJfDd9yrNyLRp2dlLQHBoag0RyMozOhQA3q8=
X-Gm-Gg: ASbGncsH0q5YF9DNn+h7x9cfNtkSC/BL1GhaVh3rz3p5yrEJGVj6qByFKlj2vKZhE5K
	fLAe581BIXotplgkwDgpykhywbrL+FDbfpnG4WGTvNuLuSCgwvqnmiqG+5hjpI5A55C+iWe44RX
	OvCFlOPwiROTsHOhIUUpDI+0heDHUJ9zn6H+daSMbdEoWPXDamrxx8GL7vymkuKFsHD6vOdBNMU
	et6FrGcR5trtPmHfxTDaCf6MisjWbEgfk9R+uWzmdUteczoIUnrgrphIP1anJAIlGL7aGNtXTqA
	IBwbY3ZeKVSgVcMM8Eqctr1OK94bLctrilcvfpBjMgKrrnjSFI4j
X-Google-Smtp-Source: AGHT+IEGLLAr3ZCm1qk6HJfeJrpeKZVxdyf5Q+R8bhFa0Q5GeLkClKacnVaUNLgJ0z38uu3iJ2EimA==
X-Received: by 2002:a05:6830:6487:b0:71d:ffa1:6b0a with SMTP id 46e09a7af769-726f1d18a26mr5080482a34.23.1739463528835;
        Thu, 13 Feb 2025 08:18:48 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001ff3absm693643a34.39.2025.02.13.08.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 08:18:48 -0800 (PST)
Message-ID: <dacc7cd7-961d-4c30-8b8c-4622132d2cbc@baylibre.com>
Date: Thu, 13 Feb 2025 10:18:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] pinctrl: Support ROHM BD79124 pinmux / GPO
To: Linus Walleij <linus.walleij@linaro.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1738328714.git.mazziesaccount@gmail.com>
 <3d85fe979fca352bed4d9841e3233c055dfaf154.1738328714.git.mazziesaccount@gmail.com>
 <6867812e-7269-4686-9fc2-55afd9fa91bf@gmail.com>
 <CACRpkdaP6biD8ueeezBDw1P3LP6ARoJw0zfkmxC-QKK0fw79YQ@mail.gmail.com>
 <a52933a2-8b87-4e49-a346-91266fe3b675@gmail.com>
 <CACRpkdYMytiXoXrjTX3ts6ce1T6Xf4rSyk=sDP9fYz730Q-3bQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CACRpkdYMytiXoXrjTX3ts6ce1T6Xf4rSyk=sDP9fYz730Q-3bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/25 5:53 AM, Linus Walleij wrote:
> On Thu, Feb 6, 2025 at 11:09 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> 
>> I just realized I should've shared the link to the v2 - which may not
>> include all the recipients (because it no longer touches all the
>> subsystems - and the get_maintainer.pl probably reduced the list of
>> recipients). So, for anyone interested, here's the v2:
>>
>> https://lore.kernel.org/all/cover.1738761899.git.mazziesaccount@gmail.com/
> 
> Well it touches (uses) the gpio subsystem so the GPIO maintainers
> should have been on CC...
> 
> This is one of the shortcomings of get_maintainers.pl really (also what
> b4 is using): it does not know that if you use some specific APIs from
> some specific .h files then some specific maintainers need to be on
> CC.

Can't we do that with `K:` in MAINTAINERS? 

I see:

K:	(devm_)?gpio_(request|free|direction|get|set)

to catch use of old gpio apis. Maybe should add 

K:	(devm_)?gpiochip_add_data

to catch anyone registering a gpio controller?


