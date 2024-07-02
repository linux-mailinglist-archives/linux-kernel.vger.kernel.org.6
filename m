Return-Path: <linux-kernel+bounces-238368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D1292494A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C9A281F23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2453C201240;
	Tue,  2 Jul 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="s0O4Qnem"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92891B5813
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952306; cv=none; b=TE8Ie6O+MFlN0+8SyNMevumJpkiOfMaFMVbOaU5WWpQmAHVMkO/018MxjpfRMDKRsqpOczWAMwvRf9rpkq0iez7gpmFwzdSfdx9dUuLmmoqa/2evSM/Jov8glaK3ohLxa/6zVNQWTZvvZ4jWib8mSqBgA0jTZzbLLrxRlw5sSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952306; c=relaxed/simple;
	bh=qmQS1yUQ/wnUi+umLTv7YTmihRxnjYhDDclF7nYoUQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXPE88DIUq7kAa3LaaSxy+JuSorriZXV87H9ObF8GalW5vOtYDJK4m4DQH3G0vDY3Rs021c0nq70OpRsR3k6WAJnrnWS3bzngbG/ltrk3u96+p8qGQS1mANTac5tYE2oBv8QHdTC5/QpVGbBOYcAKAHT7+FT7/oHfUoNlYtMrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=s0O4Qnem; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A6DBD3F5EF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719952300;
	bh=yecG/vq+9BYtjz36lLI4ERoY0wUtu982zMGb5fOEB1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=s0O4Qnem0Rxkny5Ha2cjDoMTKgi1KWGMpmXtffn/cQR0XobJNw6FciGcAdI1wW7mm
	 tb7j7Z0PD+tiXnvhhUUFhTrb9Y/FVa+/RY+RGOhFn5Qo682NPp26l0y8LeuZObFCT0
	 nU7b55DapgcV+USwAn35AhCYOeBAKw6gI9tPdpuhaJWv+JgH0WakOaSHrBh3b0GQWI
	 1bhYPIVhZOiKxIi4/CiqX1ELkuarhSXM+t7wk7pjn624Z72EJ6yFpCZnirvePm1u+P
	 W5qBMCRQOpxqz2mv11H17iYngk/YVxhaPHgoL/CuDjVkU8gHz9Os3K7JajU2xPPnid
	 j74V9bxyei66g==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4256667ebf9so32082155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 13:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719952300; x=1720557100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yecG/vq+9BYtjz36lLI4ERoY0wUtu982zMGb5fOEB1Q=;
        b=au7RhgE6QY1Afkzilu+Y77d9AxZzAaqIzcxMQ7i+DwMtFRhdMjnmyU8LagI79j8i8Q
         z1av4IWTdjm4g8sTr1foPExS27F7ZG8dN450c0077QgPE4prlc9aWi6VCYGiVwEiws3v
         jjLSoz5HKljtVTctjGyO3cNMNvkWQgpjHthmXKGVkoEaP+5U4NPyqkuePkrPdhfJPNDw
         3QJ+Wux2/FymIU2d4AuF0R7UZUNl+eH3UDx+cjsCTsOaO/mNShG26bvTiNdBiJRsaEH4
         9D1Gv5xdMMDDOR5lDHCmQvVHd1+JvS29xoX5vUczmC/lHzxeYXcKHKiaKtquv3bAQrSN
         hPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9BbfubSTS48tws23NtQyXB0Tdubsl7v/QDyp3ULpD+OXrj5ASaGibR8ux/nKiZGKkKmNjcKBDEW/1uZQVDB3TohBSRzJfZJaYEImp
X-Gm-Message-State: AOJu0YwAhAjEmd/q/L0HdUUUukF3R2/MOFvZJmglivxQXL4Der1+c0G0
	5ylVenVSea0gDbYjCllEd5TxtDEkSYjh1JGWdbXtzIGKH+PPdwwCcChMtf2SKbW/VMWZWypsXg+
	kO0wyyxjh+ZIgkVELwbW9hOqTlPSxFmRymTZMLVEp6v0K+oCFt+DL4fgg+I9ylmuzVBL+zUNXR/
	3egi+k6Pu/Ng==
X-Received: by 2002:a05:600c:4fc5:b0:425:73a8:2fa3 with SMTP id 5b1f17b1804b1-4257a04fe4emr58572775e9.30.1719952299936;
        Tue, 02 Jul 2024 13:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdmamyGl0FwhQDjyyyMIy94klAbdGmh1y3kOaOfQGUZy5yTBWVjpF+MYdSVPB2i8otRiWJSQ==
X-Received: by 2002:a05:600c:4fc5:b0:425:73a8:2fa3 with SMTP id 5b1f17b1804b1-4257a04fe4emr58572615e9.30.1719952299435;
        Tue, 02 Jul 2024 13:31:39 -0700 (PDT)
Received: from [192.168.123.161] (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257dee5f2asm121536785e9.22.2024.07.02.13.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 13:31:38 -0700 (PDT)
Message-ID: <242c0c30-87db-468e-a3e0-c211a93ae8a3@canonical.com>
Date: Tue, 2 Jul 2024 22:31:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libfdt: check return value of fdt_num_mem_rsv() in
 fdt_pack()
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240701215441.54353-1-heinrich.schuchardt@canonical.com>
 <CAL_JsqKgsD2UN2FTvz3AByc8TSdGsrSJZGUM1Fr-v2yhu0gh-g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAL_JsqKgsD2UN2FTvz3AByc8TSdGsrSJZGUM1Fr-v2yhu0gh-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/24 19:31, Rob Herring wrote:
> On Mon, Jul 1, 2024 at 3:55 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> fdt_num_mem_rsv() may return -FDT_ERR_TRUNCATED.
>> In this case fdt_pack() should propagate the error code.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   libfdt/fdt_rw.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> This needs to be sent to David G and devicetree-compiler list to be applied.

Thanks Rob.

I should not have looked in Linux' MAINTAINERS file but into dtc's 
README.md.

Best regards

Heinrich

> 
>>
>> diff --git a/libfdt/fdt_rw.c b/libfdt/fdt_rw.c
>> index 3621d36..a307701 100644
>> --- a/libfdt/fdt_rw.c
>> +++ b/libfdt/fdt_rw.c
>> @@ -490,8 +490,11 @@ int fdt_pack(void *fdt)
>>
>>          FDT_RW_PROBE(fdt);
>>
>> -       mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
>> -               * sizeof(struct fdt_reserve_entry);
>> +       mem_rsv_size = fdt_num_mem_rsv(fdt);
>> +       if (mem_rsv_size < 0)
>> +               return mem_rsv_size;
>> +
>> +       mem_rsv_size = (mem_rsv_size + 1) * sizeof(struct fdt_reserve_entry);
>>          fdt_packblocks_(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt),
>>                          fdt_size_dt_strings(fdt));
>>          fdt_set_totalsize(fdt, fdt_data_size_(fdt));
>> --
>> 2.45.2
>>
>>


