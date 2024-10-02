Return-Path: <linux-kernel+bounces-348331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F415298E608
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AE71F234C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A441991BD;
	Wed,  2 Oct 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O/mbSIQM"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CED8F40
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907616; cv=none; b=sjOLLKvUXpsWUJTYCDjbF7kS/3IyzAR8s2Sa81gPBnS7h5shhnJFPurpBzf7xoUou1XhOoirS8M/EN1jlQt2KTYf1cc/AXqMe+p0Q2vNvbwbnSdYZvNQHnCWPc6OqcDo79NSGeAHKj7fUvzDSzXSHvGxAADw/X9QSRVp8Ily5Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907616; c=relaxed/simple;
	bh=7H/c8DqDGeUoVTEzBDQsVvgIhMXeNGZTH6mYdkdgwlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCxP2P2VinD7fX9npzuUNy63KOYzCZKwNqyBxtBZpVEZ/zbi5Sj3l1TBIwFrM/qLQ1PeOvP1KUDS94KwrgSQaciZOOZk7q9Y5CmuFJQJRqAxHp0dES8cGs/oAdFIP/BGEP1KHMtTOa29yyb6JnpLQdT/CERasYcFLw/Av0i6NRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O/mbSIQM; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a27599274eso921345ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727907614; x=1728512414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42cqLii5n03T3fFdLU4Qhg/rBYfKHFULaZudW4b+uhQ=;
        b=O/mbSIQMqdloWa8GmRbjF271ayz4U7kCY021zMIi6yJYVxMgBgaoFnZvS70clIGu6l
         +h7JGJOyL7OA9JU0QKnj3QkNNOPJX19ubgc/A2lTiKShcWX3euQW1oRpFNGbtOgYcRbp
         EnY5YMPNsRFJGuamrQef/eEnBWsogvg2npSrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907614; x=1728512414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42cqLii5n03T3fFdLU4Qhg/rBYfKHFULaZudW4b+uhQ=;
        b=vf6aUr6EjiyphPromD+D6t7S0LWQU+tcTnER52yylBX44EzUrkOf2HlPg8/X5aIDx8
         lswOMQuRImyZx2GGEfG2Zgx8MeDQuuVdbdiXdOu11w4ENIlY2myrCZ7PyjWVd6rUQelq
         sb5dMJ/gBftPxUIKdRIZLoHhxYPbpU8UhNABRhejhpzbxYtEo2XXnVb+VX0vBwHFj+UX
         0O3oCPMH6dlIn5xXLEuJUi43n4JwH2v2eQkzjfY31LJMIC3DO2z6kWjjncwOf4zNZo2y
         GmLey0sEsk0bcIK+pJSi1KmwJifJypdL7dYOKlWQbRP5vmyL84VBzTxZsUaL3TKigDyv
         g7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUHSt+X+ZTpZS9Ky8GX0fFRwMxG/f9/Vcz6FwFsT3OQCm5bpotYGe2RCoP8KAZK/VBpXy13xatg2UTV3/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOE4bO77LNjKkm2wG5hmU0hMwpwcF+QjO0IB504aY2prWNQw5a
	w1e+zBoGMm/5SEFzLrVIlLYbYca3ZlsIl1N4wJ+/+Mo1aZxzvpa+/Ot1wi8Z8ZZCHeCCPa/vsYi
	p
X-Google-Smtp-Source: AGHT+IHwsCbAAEg4Kr6kLUMguFm045nL6BAzdQbO9TWhucfeSaitKihVVV9tZ/9qE2fEK2XfKBJ+PA==
X-Received: by 2002:a05:6e02:1a01:b0:3a2:e9ff:255a with SMTP id e9e14a558f8ab-3a365953d85mr44775055ab.22.1727907613802;
        Wed, 02 Oct 2024 15:20:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55969146sm7135173.70.2024.10.02.15.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 15:20:13 -0700 (PDT)
Message-ID: <6a403ccb-1d77-4c90-8e7d-35cbafdf5633@linuxfoundation.org>
Date: Wed, 2 Oct 2024 16:20:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drivers: nubus: Fix coding style issues in nubus.c
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-m68k@lists.linux-m68k.org
Cc: fthain@linux-m68k.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241002132820.402583-1-sayyad.abid16@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241002132820.402583-1-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 07:28, Sayyad Abid wrote:
> This patch series addresses coding style improvements in
> the Nubus subsystem, specifically in `nubus.c`. These changes
> aim to enhance readability and maintainability of the code.
> 
> These coding style inconsistencies were found using checkpatch.pl
> 
> Changes include:
>   1. Improved comment block formatting by aligning `*` in
>      multi-line comments.
>   2. Fixing assignments inside conditional statements to improve clarity.
>   3. Correcting the use of tabs for indentation in specific functions.
> 
> Each commit focuses on a specific aspect, as detailed below.
> 
> 
> Sayyad Abid (3):
>    Fix use of tabs in nubus_get_vendorinfo and nubus_add_board
>    Fix use of assignment in if condition in nubus_add_board()
>    Fix use of * in comment block in nubus.c
> 
>   drivers/nubus/nubus.c | 94 ++++++++++++++++++++++++-------------------
>   1 file changed, 53 insertions(+), 41 deletions(-)
> 
> --
> 2.39.5
> 

Why are you sending 3 patches for these changes in one single
file?

thanks,
-- Shuah

