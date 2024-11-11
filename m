Return-Path: <linux-kernel+bounces-404867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B899C495D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8341F25886
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BD91BD4EB;
	Mon, 11 Nov 2024 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VmsTHvRC"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B541BC9FB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365642; cv=none; b=JhPNC1m9zkz5Q3h+w94lRPsldF89sCYIjv9oYeFeE0Kat5h8ZAIjlb9qm5/t41TqetikvygFm39nCPsNV4iS4ZRf/zcoJjJfhrG11cKQ6F3f33uEM5AEJ1zEIOgn7PYw7qBYL8TNcEOBKa/8OZYdFvpUFIlN9+px2AbYxfQArvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365642; c=relaxed/simple;
	bh=GUxdK3bWrbQNduznuDLaYiQ2csEsHVvbRbbUGA4YOcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clzn+BhFv8wotIPG7y7eE+CtmpTP4XjRG47VWnqi2qFkP8GvSWzSP4GJj1yTLf/Wx7/TsxMe1ZieW7Pp+V5xABEvnUw3Jp8UtXolWJX+Djq3vE3lh9u2HEj/2rR6B+YEGTCU81WWXouq/vvTL8d7cl33/K31HX0k0Ek0QTIPemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VmsTHvRC; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e6105886dfso3165307b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731365639; x=1731970439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qeQLVqGYO4ALLLE6OpBa6NKUVcn6gN8ZfFj0qfpOGg=;
        b=VmsTHvRCTngDbzqmvItbFrkMs4u8KzvVbvOI6Qw4gUBzPpMXutGgJBbodRuHSSA7y3
         JwdeOBB9egDRZRAqIdWG81+8pRglKUAcSr1EI4d/7go7kA7+dfFGf5cDeRFmcWxII9JO
         9kTjSHq+OXbIpk9g45HTd0D+B29yXTjA20TC8nbWP5BYQrJNtgi7CB9daZeRXguEnNSN
         u/WMJ4B92+AoYTItPZUhYTaA08W+t/l3B7EivmepKZQyMDXYzjJH/KvLbsw8QCyN0w9y
         ByZKOMV8ugWBT31R2F50RqPmbFLgzVYFYDaguj2ArRvZw6RHod3LDR2SDiL+Ck7HKEs8
         EYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731365639; x=1731970439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qeQLVqGYO4ALLLE6OpBa6NKUVcn6gN8ZfFj0qfpOGg=;
        b=JzSnMwVG088HYeS/F9/ogDmIwhstal4X0ayzuwF+2my3D0s3QySeIIc5FR2GvTLqKD
         1q/SAwTkEyRk9HC8Xa7KR7rQzUdER7RUbaCrrex1tQEuwYEeHHWKo6dIcOyMQdjZhZtI
         WKEru6RfM+fjwIYil4Qh1ydFHXLZoJk9T0tBb3US+FtbJMlZD81N2Q2CQKhxGYnxrcLQ
         G4/SGJsJJgiHp4L00JBcpUuY0sFR/wOP+BxJKKXx/ad+7b/p70ZJi4q1+6FtrEB/iU1A
         YJZQ674TY7367BPFNSOGOfNkcwyDI+Io8gIj/YhTcbacX2dB+g3tyhWoMOqF5JEzIGck
         +8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXv+wIB0Dnh5ZCCNOCZjcQOPYJa+YRIEBHKi3Ouo1JkHOhLwGAN8Ut8LVI6sKcU7gsoJiPkOK2t+d6tEhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDyImVQhDQsvfRLOmwo07ltHiYj5J+rxK9WzsGTgre97HwKxu
	5tgLlUveueHNN6qpzEw/Tkps601d1MrSplYQ79s70cKSZsH4KXQq0WmdVdz2yyc=
X-Google-Smtp-Source: AGHT+IFI70O9qWZLYbfZv+s3z1ZWen9vEBjFIao6aaE9nVOytwkkB4ogTBF3q06vdafFfqOS5zD5bg==
X-Received: by 2002:a05:6808:23d2:b0:3e6:4f60:407a with SMTP id 5614622812f47-3e793ebe322mr7790726b6e.4.1731365639507;
        Mon, 11 Nov 2024 14:53:59 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cc803a2sm2249913b6e.15.2024.11.11.14.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 14:53:58 -0800 (PST)
Message-ID: <f02fc95c-a2ef-494a-afbd-5af78ad1f489@baylibre.com>
Date: Mon, 11 Nov 2024 16:53:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iio: trigger: stm32-timer-trigger: Add check for
 clk_enable()
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com,
 tgamblin@baylibre.com, fabrice.gasnier@st.com, lee@kernel.org,
 linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241111222310.12339-1-jiashengjiangcool@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241111222310.12339-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 4:23 PM, Jiasheng Jiang wrote:
> Add check for the return value of clk_enable() in order to catch the
> potential exception.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


