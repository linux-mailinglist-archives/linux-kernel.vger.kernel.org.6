Return-Path: <linux-kernel+bounces-355601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0217F995497
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B273283A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F1F1E0E15;
	Tue,  8 Oct 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhs3hzaI"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FF11E0DD2;
	Tue,  8 Oct 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405470; cv=none; b=O4huEttDP3zs46VvTBYLbxENchMd5a+6DPwkTmOwKyi8dXTpE8Wk69YwE89tPJZJqI9TMMR2xYq/uiJi7aV3+X+xng3cewcK+4zM8XCB6XtGWSO2s8SsLPO1hiWhJXI2MJ56pPFlXAw8Wyhp8ayBa9LOtkwUEq8/AcM7lYxEO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405470; c=relaxed/simple;
	bh=DPMXNGGVVZ0zuzRPm1fEHgCUD4Ztb6SibEqDYs6TxuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFBpNcsXTl7F7MItQ8zhMlqKTrwTatrp9cIA6zztosD1XwcvWQ6MoMZfnoNbTvQqF2j7aESBcdIkBkTMhT9oLWwvdUzuBqbiPiLlMZCP7uaBBVtAfeiLcV41jgozYUxXsffFsFSIQ5ZsFIq/9b+0JRg8sPHYDhCnbqhVWk7Zpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhs3hzaI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20bb610be6aso64744065ad.1;
        Tue, 08 Oct 2024 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728405468; x=1729010268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t9rEvCyhckXqLNa6MeDm50Z9xU+F8nq6lCPjn5MbNzo=;
        b=dhs3hzaIsYCQLzlJ/qDTskC/rp9qf6wMMv2pkj+4UaHn9emX5n/Z+QsUjN+p89tPn0
         JuX3CU4uzAFoz9CCvwNDcczXKt1/WWEmpxqn1MGD0BYpXcR27Pbce1P3WJQ19aBzdBBX
         jkvrOa/oZT0/dke7LA4EIFsv/3OnPoezN8BeiV7hOUY+bk/EFswzHK2eNCDZPEqi7zKK
         gvxX9bA9kVjHuvkXjnhxdTiWknuWTRvrQ/rLmi4vdXhZYC8IUJI0wFs39FGKkYNpqyFM
         7vQUWtTXaKVIBRGvFn528KV2N1ecxkfaFuQ/yDtxemjubZVW9uxAAXChXlqvxgQlVaxC
         l+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405468; x=1729010268;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9rEvCyhckXqLNa6MeDm50Z9xU+F8nq6lCPjn5MbNzo=;
        b=i0H/5dOcz9Xy7O7iyLch08gTPJfFhBUNl8mi6vdigcGfsZu62soCM7Nm0skx0EnU+z
         OFZ+cHkylK/Wry4BEGNvzhUBZgwpoe8KpfE2Woafo9biYz53TxzHc9uecWbklhD75Uaa
         pJg4t1bQubbPYCIYQ3f8wdQfJ2Ae5Z5g8reY9ntxeYZaFUY9Ki1qXvsvNT3/0o056hpZ
         aLzfP3RUxIwnwxPcadU27ADB2ygiCodU69rgzsw3AD/mIk8FYeJBKryFNyCHHmBmQq/o
         TJyF44sKv5i6s1VhuVgI/PyrfuavWns5MP9X+3G+YqG5vwavO3l/eEOkOZLnrPnEH8Ru
         zdZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUak3oq8BUe3uaq9t3Pp/7hiC3OT7WAv33IrcQbEBNdsHvW6QOaN3whavVQ3rHQnVhntW6Ow4cdlyXiEmXk@vger.kernel.org, AJvYcCXp6gYTxHnwAllbZ7FO66/o6nwecUKvImDWoj13Z72HSKZmBLb2gzqMlqUTwuGGYOU8389gQQhanHZ8Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfQqQ+KDe97W7oDYc3NnJRz4wuDDjXxvi0rmM6gsDTa/EVNT1
	UFh3j/rqphYdJSJLRw+EH5sTiLEEbegG9e1W1Lx9k/l+YSCA8Yf1
X-Google-Smtp-Source: AGHT+IHSVNPcfoAMG7OPmgqrsy5iAROmJ6rV+IiIWeP6Km7hpt9dNYchrL/k9Kn2CjGE5SJKzJQrOQ==
X-Received: by 2002:a17:903:1d0:b0:20b:5be:a403 with SMTP id d9443c01a7336-20bfde64ff4mr212644145ad.11.1728405468439;
        Tue, 08 Oct 2024 09:37:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c5911cb76sm12046065ad.43.2024.10.08.09.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 09:37:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <15bb07d5-215f-4144-8e8b-7834957e8382@roeck-us.net>
Date: Tue, 8 Oct 2024 09:37:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux dev-6.11 1/2] v3: hwmon: modified ina2xx to match
 SY24655
To: wenliang yan <wenliang202407@163.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <935f564b-fa3e-4cdf-bf12-19b897369a07@roeck-us.net>
 <20240822074426.7241-1-wenliang202407@163.com>
 <0a1df032-dfb6-4a26-a27d-14cc301cf12c@roeck-us.net>
 <7c155638-8c33-4873-9534-17a9454c83e6@roeck-us.net>
 <28adb212.c4f4.1926bff2cf0.Coremail.wenliang202407@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <28adb212.c4f4.1926bff2cf0.Coremail.wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 04:58, wenliang yan wrote:
> This change makes the INA2XX driver compatible with sy24655,
> 
> involving the reading of average power
> 

Your patches are corrupted. Also, please read and follow both
Documentation/process/submitting-patches.rst
and Documentation/hwmon/submitting-patches.rst.

The most important violations are in both subject and description
of your patches. Please use imperative mood as requested.

Guenter


