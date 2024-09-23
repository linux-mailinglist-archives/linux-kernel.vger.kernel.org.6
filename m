Return-Path: <linux-kernel+bounces-336410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE635983A83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8F21C22613
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF94B12F588;
	Mon, 23 Sep 2024 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3czMKhf"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBB84A4E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727135574; cv=none; b=qk04kZDXmW7wPS1pP/ou3PpERYqMEiF2DVes3uF6Qk85UyPrVM69NnOIBWN7/My0GIpEOk7l4OMCN+DZlLUn3mErR8K1liFDC4/WFC6YdUX2c1+0VR0dvqptYetq7xe8BxeJtPo+vNeZHtHTsyyAe3hkoWrm9ds6sNghKKdoGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727135574; c=relaxed/simple;
	bh=+/ux1JsTtDUNozSK2mbcxAMdcVnIT5JMMoYZOdn2Yfo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lHWixGkvxHqDcBxurlvs3ryZAGXk6Ah3xrfHOyFF2FlnCa6rHKjnSK+Eg0By3hty/HVJbgq5KFqIZ+zRBH7E2F06wuraxPTUpaCRymk9awLTDuq46R74XQDUyc7fM0voCDQK5aeuYirDeHDrigtx7wMjChAPKer2DSqdXjCtA/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3czMKhf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db12af2f31so4076322a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727135572; x=1727740372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kGFLgzLfUiSkEGVatcSHqWTMHNsWk87oGXki9SJkkQI=;
        b=T3czMKhfd3/vpJQ97AxUnwnCuSpnBu4AeYXPFginq6ta1fw6XMfCjXl/3OcTWo3LYt
         44gQ/QFaaCdHX84oNRj/LWmw0+7KyhedXIcHtHMXuSgPHj4zSpOIPH7uhzumM3VMGmrI
         S082ZJaHq0ISckJYU8P9ep/w5WqnZTTeOQ5a/0FA40S0+aYz7G5yD3iFKaGFHkT7l0Fs
         Eibp49kvbCrmomoG+5CtIxC5s7ekVjTC5a2kHpLRyeSti1tmk1ulxR4FnPJGWTLUFtW4
         wg2vZ7YlQcnwA1dsaxq1YTN/Lier9BhwVdnd0jKb6OwQKadoVHltkh/qUk1av2oakWta
         nc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727135572; x=1727740372;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGFLgzLfUiSkEGVatcSHqWTMHNsWk87oGXki9SJkkQI=;
        b=Ml8c3WXCFcqV/AS+Ln88cHuQm6KpPXF69Y4D8R2iKMTod+mVNOHOIzR60KictK21+6
         tfD0+o8hB+tvQ/Gufjg9ogRJw9I40kp4t0lBlwc4rPAst19+Jtq+3KAPkyqZgSIwh89G
         unZNLpfjjG3fwk48AxFA8Ips9cw7+Yeo6CgoQLcRl9jaZffDjrIC1A/ijqON8PadSdIS
         QmA6xgI48MC/Foq0/SMuk5G6U59r+rRA2M6qbwzkb6QKXwnoFMx3V2vSzKGKGFEE1bwG
         HvkWlKg1rYQeHXhy/W70tR5I9z1mnkrLYY5XtZNGwyy/YEml8pQj8ozyg1Dze9Dfeo/E
         VUCA==
X-Forwarded-Encrypted: i=1; AJvYcCUytKxXgyLlEnhcVKruRUzvexI9ybdH7Y5A94d0wMy+SWqWDkchdwt2MZs89RhRh6sluoVHYlZPnfB8ucc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2zOMwHUU+3FSS+D/r1O0jAvxfz9vsY43MJyLKZjYa8JrRLvQl
	XzmhWW8gw9O5aQTReP/rSwRBPlsbb5PQjMxBDzpQmGzppLwMZriO
X-Google-Smtp-Source: AGHT+IEIqMd5M+bhxiopnH6R39U6RNacA74d0EMLpoKn9jDBJs/k9QpwXj4OdKsluRm9lQeUYk8Y9w==
X-Received: by 2002:a05:6a20:e18a:b0:1d2:e78a:cab with SMTP id adf61e73a8af0-1d30a9be501mr22072150637.35.1727135571793;
        Mon, 23 Sep 2024 16:52:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9cacc8sm151219b3a.211.2024.09.23.16.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 16:52:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <203f0d01-d25e-4436-b769-b89edb1b57d9@roeck-us.net>
Date: Mon, 23 Sep 2024 16:52:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Make SPLIT_PTE_PTLOCKS depend on the existence of
 NR_CPUS
From: Guenter Roeck <linux@roeck-us.net>
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240923142533.1197982-1-linux@roeck-us.net>
 <f15ff981-e725-40f0-8d2f-856b4b6a65b3@redhat.com>
 <4c2cdf84-9794-4722-8417-cf924f890797@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <4c2cdf84-9794-4722-8417-cf924f890797@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 15:08, Guenter Roeck wrote:
> On 9/23/24 08:23, David Hildenbrand wrote:
>> On 23.09.24 16:25, Guenter Roeck wrote:
>>> SPLIT_PTE_PTLOCKS already depends on "NR_CPUS >= 4", but that evaluates
>>> to true if there is no NR_CPUS configuration option (such as for m68k).
>>> This results in CONFIG_SPLIT_PTE_PTLOCKS=y for mac_defconfig.
>>> This in turn causes the m68k "q800" machine to crash in qemu.
>>
>> Oh, that's why my compile tests still worked ... I even removed the additional NR_CPUS check, assuming it's not required ...
>>
>> Thanks for debugging and fixing!
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
> 
> Apparently it wasn't that simple :-(. 0-day reports a build failure
> with s390 builds.
> 
> arch/s390/mm/gmap.c:357:16: error: implicit declaration of function 'pmd_pgtable_page'.
> 
> Turns out that
>      depends on NR_CPUS && NR_CPUS >= 4
> 
> doesn't work and disables SPLIT_PTE_PTLOCKS even if NR_CPUS _is_ defined.
> I have no idea how to declare the dependency correctly.
> Sorry, I did not expect that.
> 

The only solution I found was to define NR_CPUS for m68k. That seems to be
the only architecture not defining it, so hopefully that is an acceptable
solution. I'll send v2 of the patch shortly.

Guenter



