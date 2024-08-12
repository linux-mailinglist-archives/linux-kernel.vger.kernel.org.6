Return-Path: <linux-kernel+bounces-282846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F9994E962
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DB5284B99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD116CD09;
	Mon, 12 Aug 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lw7u8gpP"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A6916BE16
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453829; cv=none; b=ZyB7AA0lexzl2AmrOVLH4Yg9JcQ+bAgDztSRB5WeIZRYhtnf0lo3ZpaFQjojOODQaAk0VL77lYDR+XY4i53nNlJ4Z3On5xVaIvi3QBKZ9bma3+XLBvgcLGynQnKBwibfhehrhpImVbu98G9s+GSV1Vp8UUs4f0+LGTdjDhD42w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453829; c=relaxed/simple;
	bh=C8ZqFoZjc3jhQMbR9Sj9M2R4QFP6NAeqGMoPX12I9Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLvYSGPLYXwcEwJ8j4s6QzahgKZODW7C8XsSXc+IsH1ianVTamqz77JGffiMrkVC4NC5Jgknm74qCYWm+pFCGVcRYoVB8AJR0M1EINyIpXzsUlSdH86e55QbcYZeA/RYfjyUqsFxJTzD2oyqEAK1/gWCxTcOknFRjv6xWqx4Tz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lw7u8gpP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cdba9c71ebso845838a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723453827; x=1724058627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSbIaV4k0nQpcrTsiNryERKM7dddbOV3rySHcmAMVI0=;
        b=Lw7u8gpPYgNkwE8yJJt0rXLRWvhMs02LhShb3EVC183KinLZS1OkCpI1SGRW0rgUEy
         XCyDh2UM72kjEkYwMgAH9GhuybghgQ2JzFF5vwnRhEEd7t1x/yne6ec5wDQfH+eCaJCw
         zeETWhOku+yD1vAbCmkOkoZvoqciRUjt8HSDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453827; x=1724058627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSbIaV4k0nQpcrTsiNryERKM7dddbOV3rySHcmAMVI0=;
        b=Qp+omug9vLs5zCc/Ul9LYdzaj5ZRHVP8qvvCfIC88kkB4PBRO7VTBV1kT8yTZ/e32K
         iqSP4m6yuE10+q7Ue9ityeQBxCN6i3FlUPmjOieHzotVj4iJBjXFy2ychIGJRhR5mLpX
         G1xy9SyY4D/2A/4BE4XvGIIz3pSB4UEE4xyWvYrDvyrHiij8tqISOCQyAtHbwfKeIDuj
         LjSXiaUV159yDCJQDf1A06LvDxZbsgIOgBW9IV4/yjl96LNMbMjZMEvsZ/DHOgI4hQtT
         l9JEnm5WOp7MYmI6EXAyWNJjvBGETZn+9EtJgJFF3B6uEYv0HmYzAPjSGu0lmxt+9AmX
         ZdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkY2R5yM1j+cWpb+yL7mmgVL2PRqVRB4iWUaCeL621rZ12Ea+9tNvnUutsWDJPG107QSdQO63qF3GNHWnPTaN21H95AnWWJUAE9BAw
X-Gm-Message-State: AOJu0YzqrBHK9hPD6FQ+Dh1tUVVP+QFtOZfeWOR4G6s0ShHIzIGxiSQn
	nEq3x+IPkwu4p8guk76Xv0jFB0/gZohzB10d1kysuMv8bi9JBR6i4Zttqy6SIrtON58xtZ9cwm1
	T
X-Google-Smtp-Source: AGHT+IEjlyfzD3rOAfGa15TQWnu4M6+BUQPxNGvHda3bmxmKnNswD5Yk8gh0gGRXeigQo81FsH8qFA==
X-Received: by 2002:a17:90b:4b48:b0:2c9:36d3:8934 with SMTP id 98e67ed59e1d1-2d1e7f983cdmr5946341a91.1.1723453827310;
        Mon, 12 Aug 2024 02:10:27 -0700 (PDT)
Received: from [192.168.104.75] ([223.118.51.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fcf06792sm4542357a91.27.2024.08.12.02.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:10:26 -0700 (PDT)
Message-ID: <f32eea28-9d0c-4315-b9fc-776681e10309@linuxfoundation.org>
Date: Mon, 12 Aug 2024 03:10:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm-crypt: documentation: fix Unexpected indentation
 error.
To: Eslam Khafagy <eslam.medhat1993@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240810211557.42874-1-eslam.medhat1993@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240810211557.42874-1-eslam.medhat1993@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/24 15:15, Eslam Khafagy wrote:
> this fixes indentation error at Documentation/admin-guide/device-mapper/dm-crypt.rst
> when compiling the documentation as per sphinx documentation: Nested lists must be separated
> from the parent list items by blank lines

Include information on how you found this problem. Write change log to say
what is fixed. Check submitting_patches document details on:

"Describe your changes in imperative mood"

You are missing documentation maintainer and others - run get_maintainer.pl
script.

> 
> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
> ---
>   Documentation/admin-guide/device-mapper/dm-crypt.rst | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/device-mapper/dm-crypt.rst b/Documentation/admin-guide/device-mapper/dm-crypt.rst
> index e625830d335e..dc6ded632b22 100644
> --- a/Documentation/admin-guide/device-mapper/dm-crypt.rst
> +++ b/Documentation/admin-guide/device-mapper/dm-crypt.rst
> @@ -164,6 +164,7 @@ iv_large_sectors
>   Module parameters::
>   max_read_size
>   max_write_size
> +
>      Maximum size of read or write requests. When a request larger than this size
>      is received, dm-crypt will split the request. The splitting improves
>      concurrency (the split requests could be encrypted in parallel by multiple

thanks,
-- Shuah

