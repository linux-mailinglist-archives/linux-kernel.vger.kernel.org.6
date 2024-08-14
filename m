Return-Path: <linux-kernel+bounces-286516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6FD951BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A45DB26F50
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AC51AC435;
	Wed, 14 Aug 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch0FM+3o"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D61B143E;
	Wed, 14 Aug 2024 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642540; cv=none; b=etNjtrn2nRhf5Wn97/glWlg4k8NXEp7BfJgBskhck4WhDe3E7FA5b+B74hLwIX1cDI83UA5NM5a/8mfNWjEsVJWKr6aC/Nh3PohSj/84cINaUwE+YLldOsfI8yURrm81HiENVMFDLBqbDVvhLSGfNeWPOI1KjLNHwwigpu/dPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642540; c=relaxed/simple;
	bh=S/zIiy42wYWO1Sut5X2WceNkWc9AbBbKBZ5kmTmvTKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlrtAMkaR+stD51dPVbNh4dUyVOcB1d/18VHAf9GLqlVcFFilNNhqJmiigN9qWDW9DT7F0L+2ICCw6VegmfPtrL7OElNfLsKYIGRd5eE0dDujYcDalCGFMdLrGqtGiRuYQU+ZJ6hPIDJ6XZuJVFDe1ZcqFrSr6VrhTrMgZPoZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch0FM+3o; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d2b921c48so5085579b3a.1;
        Wed, 14 Aug 2024 06:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723642538; x=1724247338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/8zePmdNyrEQSqQAUATf9uIk3IL2i5bmjy0HiYMffak=;
        b=Ch0FM+3oeR0RHqEyrhadJVtfKi18qxeZzJAa6GjsmzgD/c0iF7svG+3u9d0IhfBLQV
         WA0BTY1MTJR8tGVM19sDrzzek+sjSffzxklKhsPccsRh7IBf1yRhJWxLpWdfc4Na607D
         7P2YF5WkjUk5TRmol/g9YW1eoLeL4NQTJF8uOwVo0pbBz0AmRNVWkr31Y1ByNSi/qEWX
         BPrqQH7Z+h9g55vFOiGe7kCu+zZJqvRlSC3TcFOJvW96jKcgt0RPsxpUFT3cv8pfyV8O
         xZkBKHY1V5YF5+dIaqVOr1+EZOVkYq+X18Oa+SF41BHJIZCfhPONCn3iKZYtRzipRX9W
         TAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723642538; x=1724247338;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8zePmdNyrEQSqQAUATf9uIk3IL2i5bmjy0HiYMffak=;
        b=F8uluAsszmh7WpTJTRXNTpL++hvM9LEuuFlBcuHYpyT08wYbVQMEj7wmHC1g+1scc/
         TpOod+RScqpRFR3vVAHSmAjvIX8C5i9LpWhw96G4D0a9lAVT8oqovqSULiUOcciAT6dN
         2V2fZu/iGFmnJkneVqN9atF20xOdpIJn/E/dkAUY1O5oGvK22RZ5JoR5AUXslP5ZwXXZ
         gPneD2s90vQVa6dCSus3WhnuV6Lel8zT/HMw6evQDxCs23cJ9ymiqihPuVY3GJwjdQpK
         HU7EePmV7NqOsvG9YLnqK2XgLmXn3gsNNxQP6VztUwH87UR2Q1P/Zg/Q8/nTpY754aSZ
         3jLg==
X-Forwarded-Encrypted: i=1; AJvYcCXckup9+gZicg9b2JxjKBm1e0spywS/LBNSWVD2GbBAgCb8nwXqpbCzMlgRP5KmgVx0Zzd8Q1wH65ybeR3q94eAy6eNSi5g0eUecJYkARZIIq6kZHqZlAgJnXYkw5FJVLRk1P0OhOugxRM=
X-Gm-Message-State: AOJu0Yw0I3MjEyx0fnp2v/R0nw1ZzWzcZZfUlbUH37g6Qn8tCNhxDYwG
	4klyM0/9z6fvzVwSRGeVIMYZB49VwxIV2ExGkkgsnbD7u4Wx5vWr
X-Google-Smtp-Source: AGHT+IE0DQVievfpHjofd7g7jFDdfLteDHbIpHlIEKdATcd/rJVMpRPBYT7SR9h5ZhIQpxz9spaXDg==
X-Received: by 2002:a05:6a21:3a81:b0:1c4:cf0a:ee9d with SMTP id adf61e73a8af0-1c8eae81669mr3581302637.19.1723642537860;
        Wed, 14 Aug 2024 06:35:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ac3d48sm7332973b3a.211.2024.08.14.06.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 06:35:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6048b4d2-8d15-4a85-99c1-13b176d7404c@roeck-us.net>
Date: Wed, 14 Aug 2024 06:35:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] hwmon/misc: amd-sbi: Move core sbrmi from hwmon to
 misc
To: Akshay Gupta <akshay.gupta@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240814095954.2359863-1-akshay.gupta@amd.com>
 <20240814095954.2359863-2-akshay.gupta@amd.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240814095954.2359863-2-akshay.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 02:59, Akshay Gupta wrote:
> This is done to support other functionality provided by the SBRMI, which
> does not fit in the hwmon subsystem.
> 
> - Move the SBRMI core functionality and I2C device probing part to misc.
> - Move hwmon device sensor to misc as only power is reported through
>    hwmon sensor.
> 
> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>



