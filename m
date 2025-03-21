Return-Path: <linux-kernel+bounces-571896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C2BA6C401
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4AB189DC46
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4344822FE1F;
	Fri, 21 Mar 2025 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yzfYBCdn"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817A22FDE2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587926; cv=none; b=FslrCVSNoOfAYbjkPPUEb3n7pipmv1yHEqC9nw/X/4fZ+BET4rVm83qIhY+AtfDE5Bb7Suqq8s8vkzFtgMIPO8hp8raAwxYlZXZmPtJJ2eKVewwqj+N4xikgxZIilVaVVShmFQzngl2bMxCWK0k1kuDUZNpEhH/Fk2ASERC0xRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587926; c=relaxed/simple;
	bh=hgo5F8h+Z5rr3chs5DifIfiWaOyXhg0eK756Iet55RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poeSgyidpE6TOxEr3D4swIj7CoBGkmRUIABi5aglnsHAxs2pJO0dEJY5u5e5B9ArbuWLCIQi7SyQDsbYgMgcbn/OKls7xMOv7JFphmlMeX44OZnVtwHJ6IUIrldUZGo/8gTeAb6zZbpgWkdTT/bAv8XT1h6w3I6d0GmR8lqOK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yzfYBCdn; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f9832f798aso1408769b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742587922; x=1743192722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccG9w73MG8ltY7+ND06i6LTf/TTQC5xPKuyTK8RSyKM=;
        b=yzfYBCdnjhTKSeFe7OPQn8MkiJvsEGYsBrqIXNiwrs/0oj8DFd5eVMmEb+KLw0CE/M
         FE65h8/8mqo0nFoM9tdwfZpgEqcgAl4IPzss16QbgQg/gZTFC/5RieZ0Sc9IB0+ne6MD
         WyYQyVzgQEenluGgtVXsZWkXe0yz8PKJLcJDWjcm+UylkMb8VAgoD/IwpKCei5nr2i/S
         Vzl3sY+jSAwcMyXoVh2Pa5V11ne8i9DiqL9q2pPfgVYAU8B8WJp16e0utj2NTleq/r0F
         TsoMcwnKS3wonax50KAIDKqpiT08TylJ9KGKBl/4wPjerGXSXaNlFbyXCpL1Ndk/MUTX
         7Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742587922; x=1743192722;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccG9w73MG8ltY7+ND06i6LTf/TTQC5xPKuyTK8RSyKM=;
        b=DXL50faJWCakxw3PWklKfzRwBKA1hQT72h7ucLUEzDWPvYaZl+pmV8YhriuJcKUvQ9
         hQ/h7FfIUi6CBEtPzungdaK8GOuRuSTpAHFLIDSc2YrW+auTWBAFrZkpDBFrw0dlYL5N
         L6vpgVQOL5xiviNrmnVo9eycullbSq6NEJSjlpTUc+PTLMKCRitRRZDmtHaw34tFumgR
         wojQAD+9qvNgUaMA+xKqIuq7GOad3meQhq63PdlYEarFF6rUeR/vscYUO9238/S5vSEV
         TAMsQk3Ikjh5dcSXafDfcyCx/3b2SrDYad23p4B4IHNXFVWpmlPjkk4MUGnGQd90LZLz
         iM+A==
X-Forwarded-Encrypted: i=1; AJvYcCXo36d1SNXtijzxSv69FlNkdBXdsdN401mmgazaM4Rzb+h4ZDjZAOMW2aPDdBt4k4XhR85Qr8ey3ejrzUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyodec8f2RELTTtPmZ6fAtkfIeW4vrmEvU08YEVoWPDXHEVHKYs
	/dOePARja+9KszFXTLK6mLZBt8Iz9QSy/+Qqw97IHNo8JqQxd+tI3IArcyvQFt8=
X-Gm-Gg: ASbGncu/jjB0qDaPoEdafSVLb3hauVHaHy3cS5plUBE7Tj7HIpCmivnV02c3O55yJK/
	px/hL28ke8b1Daou3QBGBH98S0sw4E83PPPKJqXGJkBN19KqIqdUcZ970ZrAEX41bt5ujIURiIx
	1P6LcS5/QjGun5szoHKGJnjv7Vr89wyzNffoGtKLhqeB8dfZ+cCantnaR/hqs5fawCNueVlNbRu
	BXd/2Q7Ol/JSxvQVWTkpQYqZc/LMR98NJzYVts5baI8nju9msAqnZ+NgbfXrOHnLVZuKXuyHcje
	5n2LcPt9CQ9gHbgxRKK5eYENcDKsikzAAVDRPjKNtlx5+Wb6IOm/tPrlcB/MEb2Cl26l4V5CACV
	grZ7y1HCaXMcimhzk
X-Google-Smtp-Source: AGHT+IFiaVUXe/AFyDJjh4bHXe5rna40Jytm7qgCzXcdV00KZLBzj27++qjiSCFI5MNnva14T16qnw==
X-Received: by 2002:a05:6808:1a23:b0:3f6:aad5:eac8 with SMTP id 5614622812f47-3febf7091damr3077556b6e.6.1742587922167;
        Fri, 21 Mar 2025 13:12:02 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf79283dsm481347b6e.40.2025.03.21.13.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:12:00 -0700 (PDT)
Message-ID: <336f3db7-6f8d-4eab-b28e-c8389a3d05c0@baylibre.com>
Date: Fri, 21 Mar 2025 15:11:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: ad4000: Add support for SPI offload
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, corbet@lwn.net
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <84843837a2acab58f8853152ecaa67c79b9a9666.1742394806.git.marcelo.schmitt@analog.com>
 <c449fff5-ef23-4094-8306-0a6b27a22c1c@baylibre.com>
 <Z93D8CAmgKSO-Ta6@debian-BULLSEYE-live-builder-AMD64>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <Z93D8CAmgKSO-Ta6@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 2:54 PM, Marcelo Schmitt wrote:
> On 03/20, David Lechner wrote:
>> On 3/19/25 9:57 AM, Marcelo Schmitt wrote:
>>> FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
>>> The PWM IP is used to trigger SPI-Engine offload modules that in turn set
>>> SPI-Engine to execute transfers to poll data from the ADC. That allows data
>>> to be read at the maximum sample rates. Also, it is possible to set a
>>> specific sample rate by setting the proper PWM duty cycle and related state
>>> parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
>>> trigger) is used in combination with SPI-Engine.
>>>
>>> Add support for SPI offload.
>>>
>>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>>> ---
>>
>> I'm surprised I'm not on the CC for this series. scripts/get_maintainer.pl should
>> have picked me up due to K: spi_offload which matches this patch.
> 
> get_maintainers doesn't list you if run over ad4000.c.
> If run over the patch file, get_maintainers lists many developers. Some of them
> don't seem to be related to this series, so I cropped the list to avoid churn.
> Will CC you on the next versions.
> 
I use b4 these days, but IIRC, I used to use the --no-git-fallback option of
get_maintainer.pl to prune the list while keeping actual matches from the
MAINTAINERS file that shouldn't be pruned.


