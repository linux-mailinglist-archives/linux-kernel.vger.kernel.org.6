Return-Path: <linux-kernel+bounces-435213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4999E748B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D360616E33B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AE620E326;
	Fri,  6 Dec 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N2TQL7G3"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7320C499
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499321; cv=none; b=M/O5jSivPNr+nQ0LxZLWBKsqZqTZFmxJgX/r8/w7R5AOXb/6VfOdjDVuQlf2sGqmUn8L9JdW+Fjx95n6a8lbBfFlTMaj0SsJrVbk7OlpQOM/59WWmb/qzy5VxJ+bNbEarXXFr0pKf3+FQTV2WQxygKgcbuR27imDj2UqDxFJx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499321; c=relaxed/simple;
	bh=wVuh8+K4TFQZo0S2vY5lBgaZcol7ldJ/JWHAKBR2WPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QM+lbpOD64E0jpsBhxSygKIqr5XGaVFplmVy4MwS6H4lWtG6pebXLGonpdFs0aD1gQWYJwGTOVzajeyVHRfjmwqCsWJwSMDITD8UHiMIc7cXIAu+jqqLWmvXmhUj1frcJF6VKvXyuxuEdkiQy70KiQBMw1ve7h0ShjcBbWGeY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N2TQL7G3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ea405aa7b3so1037447b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733499318; x=1734104118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pd/MBI/iG/yKICYtrTjJIzBxjCvgZpwJbnTssb/3+lU=;
        b=N2TQL7G3L+qo2g/vM44HKMgujSZHdqUQJGc8MH+BmFerzmA1YeXbwdLzJog/ZX9U+M
         mzKrt/Dg+8acdS3WXLBE6aGQTuUb9YGtnIUeq52ssR7dAk9LuTFA1zD6WdmdVKCsmkZT
         otahWMaVi4CTqmXb6srxx+etUD82eu8C3/VazwWj4VY31XyEZHTnJqkVb2mdikfDhfXh
         RoiYi4GZMoAI4bdeV3iKMA5XAivXT5wT8e3BUE1nkWKTCnNnUPXMEOh2S60GWOkDE029
         gdm/tVhUK4+GI6E3StTal8ruqHPh9NX+L+6bmpqT6gxqeaj62hqdOyxgicT6j/tOOhvG
         nDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499318; x=1734104118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pd/MBI/iG/yKICYtrTjJIzBxjCvgZpwJbnTssb/3+lU=;
        b=X0gfTAfPDNNaoF+Qqm3Br+43C8hX0cEEzcEovs8tQUW84QYD3gY07/p6Evt8E/iNqC
         OoZ2WyyLVBy39eh1VDAlbf0eGmOoRoaazIdqW2JQ3tiEpHzC7K+KHDlbw/I3EjQznOB+
         OLJI7tHKx37PtkuXCG87RrfuPOKm/XdOxBMfkAUKN+DfeiZdTNHgeDzA2Z8RidWXIWbi
         QhOHAcA5gvOWZzFHsh0/Y5B8g0B/GGzKHulhDXFTBfKmh3TJKoJoY7CLBttsyFQmIFv4
         ypCgW95nEZT3TPNzfz53YZuvxggXZFWz2l0apMQuS4ZLNHTsEDSBFx/hik29CkDwTUuU
         AtrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX26TCliWbLqASxSd1A68jMxVL8hFJaRo5bi4FVecBIm0uy5X2S43zrMFiLCoybhny6VpC3MGmlaBtprwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/hMmCC8cUEKngqzNNog4cxzDZ1pgaCN5D7v+dqDtTsZDRHuF
	G7h26o6raxl1fxcjRzOQXwdXfNmddKQoaBQPH+ZtA2b6dk/oELnvDoYuPT85D28=
X-Gm-Gg: ASbGncvFiATaF4HmOP4RSaru9H42FmgDPN6Kq8vRhG+jnSD6S0pumsqYF62Z/YJPESP
	IveqjmbgCP3+xKx6KShYrs8Jrqdt0UJ9ySv5OZFI23eSdkJTHUCizvnGB9GLvdfGC1vF2BFr5BE
	h0b49Mx0KPysH3X5zT1IFydXMfieDEMYUXA+rfCJaLh2MIF3XewbpD9s8BXLLLKLpdxeT/1jaBi
	y1finUArNrnILisvI99PTqxz2XpfxdxShl4wo393VDH/x/goFhGfcI5SWSoSVkJyOL2AMUdCMHz
	v8Wfrm4MKOY=
X-Google-Smtp-Source: AGHT+IHX/2FUAEdetGNLWNVrIoleewZYFhAZnP1cjY6rVq0ZSaR2VfNnDu3mZcvT6ej2tQL4aqDj7g==
X-Received: by 2002:a05:6808:2f19:b0:3e7:cb02:8468 with SMTP id 5614622812f47-3eb19df8422mr1568872b6e.33.1733499318151;
        Fri, 06 Dec 2024 07:35:18 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3eb076fce8fsm781131b6e.32.2024.12.06.07.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:35:16 -0800 (PST)
Message-ID: <276fcd4d-5066-46b8-8468-f63d35b74894@baylibre.com>
Date: Fri, 6 Dec 2024 09:35:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: Disable all channels at probe time
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Guillaume Ranquet <granquet@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241104101905.845737-2-u.kleine-koenig@baylibre.com>
 <20241109152438.0135f0c2@jic23-huawei>
 <7did4jkzbsvovlinkjimbn3zdqrwi2mrs2onukfonjeexnumvh@xbzcdad4v7kd>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7did4jkzbsvovlinkjimbn3zdqrwi2mrs2onukfonjeexnumvh@xbzcdad4v7kd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/6/24 5:04 AM, Uwe Kleine-König wrote:
> Hello Jonathan,
> 
> On Sat, Nov 09, 2024 at 03:24:38PM +0000, Jonathan Cameron wrote:
>> Sadly this has probably missed 6.12, but I have queued it up as a fix
>> for early next cycle and marked it for stable.
> 
> I interpreted "early next cycle" as "This will go into v6.13-rc1.". But
> that didn't work and didn't hit the mainline yet (as of cdd30ebb1b9f).
> 
> This patch was included in next as
> 64612ec9b909b699293b7220c634f67a9fc12e06 between next-20241111 and
> next-20241128 and then disappeared from there.
> 
> What is wrong here?
> 
> Best regards
> Uwe

FYI, the iio tree is currently missing from linux-next due to [1].

[1]: https://lore.kernel.org/all/d707cb3b-1569-45d9-bdc3-dcc98eb88bc4@sirena.org.uk/

