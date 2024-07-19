Return-Path: <linux-kernel+bounces-257630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C075937CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C101AB21D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8B148308;
	Fri, 19 Jul 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jGBOiDuo"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803461482F3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415914; cv=none; b=dpUcjZaFRhaNY7grOyaDoo4cz4RA3W0D4X3zsd+aeUjb1UkCjMtFN6/ODKC7pdHgeOV9uenfrpeHWzhEvxHHGxtsKqOV0VJ2BbW59/E28+uciUQN0OOq+oG0DF/AY70E4mbWwW2PqnOJANCHBwl06A4QUHgAmPjscfuAba3EsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415914; c=relaxed/simple;
	bh=yBKphk+kO34RoHjQgFpte2hSaIa0wA3auRo+TLhJx8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rt+0OtEqE8aHa6KTKa0Cuj5ogFQoGX8lJWhz4Nqacta1gxE93biBuOnLMSnAffC/p8cR7svcBZGXsZ5JpLWGD9ufmrR18rK/SMvLuWk+cRBeK4RbL2BA+8gjWpJH6uo3EQzZLJF4t6625gV4mUw2HIyFBpvKcW9LnDlP8XmxhJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jGBOiDuo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-72703dd2b86so293893a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721415912; x=1722020712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nx9OdCwMEY2JRvD0bOdHslpOXnBey2t65szlXZcXug=;
        b=jGBOiDuoRicy9n9YSOQdMhAhSmdJViuPq/z1Wri3hDJPCOaUnIWinuw3Rs+UneidjC
         Y48jRZUDk3/pHgqLMHZcvekr0/WXPTmdkeI03oq8qQFAyMj4Y4cA8IMJOthhyv08aOh5
         AWgWLR5ihs7XmQgrrIiXPBEC2CdwTGNWzJecfbhNdQZJFF2eeqwXXZ0MR1Tt7ImsC6My
         atRt4QzH7ozr4pCmVrPDcyNBeympt5r1yzHd5G5PQnyis0WWbEhHQIdw1h4o0QZ9ijaX
         aEfOH3hx+l3N4YnyMZnTTcCi8GmggfxLuG4VWCi7g3hVsH+Ge7aSe9JNgn/GMD7I1DPV
         y7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721415912; x=1722020712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nx9OdCwMEY2JRvD0bOdHslpOXnBey2t65szlXZcXug=;
        b=Uc/WK3pdsZQCwqMesRRTWvF9OGXZR2Ch8QOEqArB7vg1gv8NwHKwR4OUuxNd4uHn5d
         qqck9ZNLWhoTBDOn+Ahq5bHzyo7ChzjnDwvBOsPkVFZZ71AxQT6PLdOjVYvIVj7NK3vn
         uuC3S7ufHzHk6Q2iXmOBCYFRzPQBW/G2xNIJb3GNVIY8LG88ATd1jk/AGFL81iJfXZDN
         8vAKxEPcfN55KYNz9gcQ/wCWxr/i0ceRtpYc+4bLo48u0+mWUSNo0I9UKjcQOlLnV0/9
         pDlIItlahfGrNuFeNtnMx3itpdLfiuB2LCFTFP8xUqc7ObgIUCkKMDcT6prA8q8u8yAB
         EyXg==
X-Forwarded-Encrypted: i=1; AJvYcCUYAaiHDfxEKAunriPi24S7PubYKdt/Z1P2WuMgMZJ91z1RgeIB7YJlBqRxGQW3t0aKs9T1qJhMgbt+6nkfcnReJmMDDR/RsUb54g61
X-Gm-Message-State: AOJu0YyleksieoM7LIsN9f+L9b2+xYt95kIk5WnQlwZNpfKu0gUiejv/
	7th0TePSgTK+x2kpScImM5HTtdLEzugwoSlNN0L2gOcUXL3SZO1czzD1vKoybsw=
X-Google-Smtp-Source: AGHT+IGdhsJWDxm7pZKeryvCYAK1+cTyIo63zWdJkrvVVhI7KSLmqHOJHPUVumTVMUg6S1EE6FkwVw==
X-Received: by 2002:a17:902:cecb:b0:1fd:6d4c:24cf with SMTP id d9443c01a7336-1fd74573b0amr5601685ad.5.1721415911589;
        Fri, 19 Jul 2024 12:05:11 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f299651sm8374115ad.104.2024.07.19.12.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 12:05:10 -0700 (PDT)
Message-ID: <5aeac0c6-9658-4845-81bf-8bede181767d@kernel.dk>
Date: Fri, 19 Jul 2024 13:05:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6] io_uring: releasing CPU resources when polling
To: hexue <xue01.he@samsung.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709092944.3208051-1-xue01.he@samsung.com>
 <CGME20240718100113epcas5p255acf51a58cf410d5d0e8cffbca41994@epcas5p2.samsung.com>
 <20240718100107.1135964-1-xue01.he@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240718100107.1135964-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/24 4:01 AM, hexue wrote:
> On 09/07/24 9:29AM, hexue wrote:
>> io_uring use polling mode could improve the IO performence, but it will
>> spend 100% of CPU resources to do polling.
>>
>> This set a signal "IORING_SETUP_HY_POLL" to application, aim to provide
>> a interface for user to enable a new hybrid polling at io_uring level.
> 
> Hi, just a gentle ping. Any coments on this patch?

It's merge window and vacation time, and related to the former of those
two, any changes for this would have to be targeted to the next kernel
release. So it'll get looked at once things settle a bit, there's no
rush as the 6.11 merge window is already in progress.

-- 
Jens Axboe


