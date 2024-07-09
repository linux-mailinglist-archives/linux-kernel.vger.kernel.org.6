Return-Path: <linux-kernel+bounces-246641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDAB92C49B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0151C21327
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE7152515;
	Tue,  9 Jul 2024 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HajKmWjw"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E82A4D8D0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557323; cv=none; b=fChACDd9dpOSX6ptotPrWrZWde+zZWRP6HYDT6dNRVMjF9I+e0O+/hKV3AXueLTJfkmr4iC5j4JvPn/OZyccuQXYgupoFyiDoEkCOe872mOsubF+xFgSFCNyU+ld0eNMY7kp4ByuS6xgTA+dIZ6Tjs9a+Nie8V4KNrVqloDS0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557323; c=relaxed/simple;
	bh=B6TBOvniiIY4yBsFeLV75HI56BIl5JHOPJ2OBmxRZh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkayyXBBEypFQGq34Nz2fBi7WEUBi0U6gjqtavkRfHHSK1QsYaD3i84K0Y4c9snI/pXUEXDIto0ADGsw42MdGt+dLtf50BlLK2l4gTpgBvvp1/w39M3AmZARr4FdRos/nGDMgyycZ68pbI69Tr/UK72wy4hDkW2ggnCPHRouCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HajKmWjw; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7eb41831704so19914639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720557321; x=1721162121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Uw/sa6sLips5jCn0SIjbZbXatTX5nFO4bBzPwrcrqQ=;
        b=HajKmWjw/ch4Vae4Cl7xxoiIcrya9ygDqxUisu2DoBZ1oWrle6OQluls/Lemt22Kbt
         8xoy4LYiIeYrA73Nx6vQlU2SA1uf2uPh10mpz7pli8WZKE3rtke6qC+bQavtNnCf1Lsi
         8OPUYa9kAHLULJyd6elfQCGjp6aXigMBNLg/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557321; x=1721162121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Uw/sa6sLips5jCn0SIjbZbXatTX5nFO4bBzPwrcrqQ=;
        b=FjnKLRXCz41kz30ih+kPpzktbrGZCm+xZYNv6FHcx5+BXeuxRcyKjl3z7nMrWp4bjr
         VpXT+XwwEqmUtsIeTWgPaWGhzKRxHI8+gCczQAfFGBlC4x3ZB4Wmmkx3uT+lQaGHTBxU
         ro/O8UYfEigtzzQqsK+AV5NuHUSiW4Gb0SOLSufYeKAqKGfEUzzQEFn68uKkzc4xdQPx
         LC8F1iNWp1Z5VcbnM803WeuRciK+gRI2dU3iAl9vbHI5SLY6vrtEp7pqvV4c+0Cm2C+/
         Iv5I7fEA3aC/ZFjL4/3wKAiw0vN2JJHXRhA8Oe6aJu1VT/rko6QL+2sZhsspkVF0UbMj
         7viw==
X-Forwarded-Encrypted: i=1; AJvYcCXDv/qBmi7dXjHQux8luKUNb4lkR7Amx0yvLvH2BnhPJUoF/EL+F146iuOkbPHYPAF7gQNOm7xza1lE1lCBaSWrH9WYyAma1w+dv6kQ
X-Gm-Message-State: AOJu0Yy9w0zgsuEhYfnQQ5miNq1Zbc9nztsxOBQdXWVgCZUQ68ZzMSI/
	ucxOT50yseeRbBR9MVkQlJJ/EcxrVksVgmBWdnjgbQT+zvOtnAS0aWYoWhepPB0=
X-Google-Smtp-Source: AGHT+IFSFdPJDDf6UfJgdzx9C/1pJLpTxO/0uyjQPpSaIATfc7XdSOsrOKq9Ub2TUBKnYOM2bXdgxA==
X-Received: by 2002:a05:6602:6103:b0:7f3:9dd3:15b2 with SMTP id ca18e2360f4ac-7fff92c5be4mr394599039f.0.1720557321484;
        Tue, 09 Jul 2024 13:35:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c138eesm683371173.151.2024.07.09.13.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:35:21 -0700 (PDT)
Message-ID: <b8af74c6-1489-421b-8495-0056ecf144d8@linuxfoundation.org>
Date: Tue, 9 Jul 2024 14:35:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftest/timerns: fix clang build failures for abs()
 calls
To: Andrei Vagin <avagin@gmail.com>, John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Dmitry Safonov <dima@arista.com>,
 Thomas Gleixner <tglx@linutronix.de>, Valentin Obst
 <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704025247.86418-1-jhubbard@nvidia.com>
 <CANaxB-zk-j2E8D0_4x04WL5Jbe08SD39jqBLbehBYWedFg+mMw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANaxB-zk-j2E8D0_4x04WL5Jbe08SD39jqBLbehBYWedFg+mMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/24 21:44, Andrei Vagin wrote:
> On Wed, Jul 3, 2024 at 7:52 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> When building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> ...clang warns about mismatches between the expected and required
>> integer length being supplied to abs(3).
>>
>> Fix this by using the correct variant of abs(3): labs(3) or llabs(3), in
>> these cases.
>>
> 
> Acked-by: Andrei Vagin <avagin@google.com>
> 

Sent in for Linux 6.10 fixes update.

thanks,
-- Shuah


