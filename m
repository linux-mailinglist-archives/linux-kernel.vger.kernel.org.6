Return-Path: <linux-kernel+bounces-336338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE17298397E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 00:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54C1B21365
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF5D83A09;
	Mon, 23 Sep 2024 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLkTi9uf"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA32C95
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727129318; cv=none; b=gI5bq7naD/WpxhowOU9tayDzts/VXZGmR2cmfw0EgYX1yjP08PjnOkemFHlR7T/LYUfPXl7ZZP60BFGs3899ITRZbR5h184RIwCVxg+txXOkcmByI+tbnT8xhqmehdwsGw3wuVhtwQsuznhFBw2N9nXyPRhk8/cdn+5FWITBVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727129318; c=relaxed/simple;
	bh=3JKSlR9faFzhYBaS+nzOXH4AqYeyxECIARoG91TFBzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaUqPH9ltfGJD4UdEpoT/GPVSqxiMptGrDy/zr3a2zgsPKl0LMUqyxifrIwqcVHPt6w+PoxCl6t0aMm8c+i857RG9qxNpK3GLVqYRYTgDay9RfUf8OHfnW+eR7mCSW1FlNtkE9QDJaE3eu9goje3uL1ZSe5dcdDZnFYmo/I7kHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLkTi9uf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20551e2f1f8so55549655ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727129316; x=1727734116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V3//eEMxbsgUSahWoP7K716GeLpmNt2GzuMEZxOwtXQ=;
        b=gLkTi9ufCCYiKXXLQYX1Hu9A6kmWzEpOVsvRgE6oKcJcKtoCZtx+e283sLLfcZ232p
         8ReMcPFpybEK9trR9osru9n2fGaFg1nc0OffenCPktUuJhkMeKwF7veU4l1KsxmGiGLk
         ZU4IB0hRpNZZkhYzO+acSrSD0hinh5VGsX+WW3TUUDdsy3drnq9YseKJGdu9BSeVj8aJ
         VsJJmWR/kyZax0i0kD5SxEVeYcQwCdLoc5N/VvPkF4lEuvUXWm81ZQLlOj1I4P1kWWjT
         Xg6EKOkUcBECvrJ79VJZnH2mXq5BrLlrH+rZi5p1osntu3sVwktQO+5bePX9dG2xYhIf
         mY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727129316; x=1727734116;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3//eEMxbsgUSahWoP7K716GeLpmNt2GzuMEZxOwtXQ=;
        b=t8MWyR0uysgRZfNn8Wg4l9N4QOAc/fR3xKvCMyqJqDLh+7u9pb2tpfUEwMHJP/7GJ6
         zfiFoywbWcnC+sK3c7h/5z+yN6A2GvTw1XYCxTFItprwFPsTCxTloN48efuZ0CppeLxr
         2CaXUcVAQEtkTy5MZfO6O5zg52D8JsGmz4szVEk+MKJ3BVUcJ0u4vTo2JdQ0Bg1F3sWY
         /ZiFppD20Fr4h09pukocVlGhZRVuOZT5dOzXyxoUoCOISmg18KQuuZM9KZOvpKQ+mM2X
         03rCQzjWO87xcW3FynznSVSyv4esRmBU+kvEz+mhm5jQNNAP/RZLDGxz8EvOKIXTG/Sk
         R5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV7MAIEjCHNUx81DCGF7o3rUIh3GgMRWX0SVs46vPq+fqX0x50oLlkyhUx67wFuBK8Vc+oUDOteLc1qBYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yCXuaOzkAkIt5p/aRrirVcp5xfxxIo4oHL/x8tVcVq/TFoWk
	1ADb4D4yXeEmgHV4HYcz88aHIYRZhXUEdeq74TatoDoXg3DGnWTG6Nki9Q==
X-Google-Smtp-Source: AGHT+IEdQQTT7l97c+EIqCCTDQGZIiQunAvA+FHxb9lDhCcKbpsJOwMcALfmB6zDaP6Y7i+Sza2RTQ==
X-Received: by 2002:a17:902:e551:b0:202:2d:c87 with SMTP id d9443c01a7336-208d833b3ebmr215572725ad.12.1727129315592;
        Mon, 23 Sep 2024 15:08:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17e25c2sm435545ad.128.2024.09.23.15.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 15:08:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4c2cdf84-9794-4722-8417-cf924f890797@roeck-us.net>
Date: Mon, 23 Sep 2024 15:08:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Make SPLIT_PTE_PTLOCKS depend on the existence of
 NR_CPUS
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240923142533.1197982-1-linux@roeck-us.net>
 <f15ff981-e725-40f0-8d2f-856b4b6a65b3@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <f15ff981-e725-40f0-8d2f-856b4b6a65b3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 08:23, David Hildenbrand wrote:
> On 23.09.24 16:25, Guenter Roeck wrote:
>> SPLIT_PTE_PTLOCKS already depends on "NR_CPUS >= 4", but that evaluates
>> to true if there is no NR_CPUS configuration option (such as for m68k).
>> This results in CONFIG_SPLIT_PTE_PTLOCKS=y for mac_defconfig.
>> This in turn causes the m68k "q800" machine to crash in qemu.
> 
> Oh, that's why my compile tests still worked ... I even removed the additional NR_CPUS check, assuming it's not required ...
> 
> Thanks for debugging and fixing!
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Apparently it wasn't that simple :-(. 0-day reports a build failure
with s390 builds.

arch/s390/mm/gmap.c:357:16: error: implicit declaration of function 'pmd_pgtable_page'.

Turns out that
	depends on NR_CPUS && NR_CPUS >= 4

doesn't work and disables SPLIT_PTE_PTLOCKS even if NR_CPUS _is_ defined.
I have no idea how to declare the dependency correctly.
Sorry, I did not expect that.

Guenter



