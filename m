Return-Path: <linux-kernel+bounces-240490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B9E926E51
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0845B22B5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD4E1B810;
	Thu,  4 Jul 2024 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="OquwXcS2"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BDCA41
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067372; cv=none; b=hgKaXRtmid6GT/kY/yGCnrWgnhk78oc7S6/v5yvoPsbKsiKiTR2udJ+ChW3w4PXeT0LuWQxF1e3/YwbyUZ+sA4QYiX3IQ9piaE4WZDgiPiq21O+E55g1/H8AnhYaBKbNo89V+ozp3UpLMhjRh5uYoeAopfiztWMjtKDCZorUTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067372; c=relaxed/simple;
	bh=+yRqvyR1p+ZCtAk0YX1m/3MWWdkXMJ3dlJ3d0eJdkFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhROM2S2LP6Iho9mTQoCAaX7i2mfPJUDJK3TuRVjlYhRK/ugMHVd8wXDKGHaxs051xojDtn13Gllp3QM+YLyxQk2yNdan/n7SusCnhTaK7EMtNAvBEmVQcrPV/sXJBrFeLpN58SJ5w6hNDuhtECdj4q/OBhEPTTcRZmVu3jLpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=OquwXcS2; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-380d8ba4548so129065ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 21:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1720067369; x=1720672169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/x8uqtBWEOzlRCQu86kjjAnrFAC8DqXpnxLOvgdulDI=;
        b=OquwXcS2FVQj0uOdZPNZcRLaHGmrCZROuGwDIf0nrsd46bU/pHCXE5aEBUce/6NIN1
         MjZbixyGWuuqfyG9Wbg1ntQfjoYyvn4M/AWy2D1IDl7Vh+5YclwzqJQmk0p/z3Br1O8O
         PWzJI0wGJmbfVS1JqLwerzmDcU4dFJeVKAHAJlJi8ZIhS7D4STVH/xTSoM/CaYZwzCse
         YLwhsF10mWSwBmgSWh6IVZ/15OXeis7wvS8ynHs6xFh1jfxavQkS2OYt1PFs9sB9YVAV
         4Wu2nqyZQh/TcXQQ73pufmU0aACIXyIV2MAyd62XQU+/oOGi8VF5QRuVsSj5WAXlMQPS
         ecsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720067369; x=1720672169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x8uqtBWEOzlRCQu86kjjAnrFAC8DqXpnxLOvgdulDI=;
        b=TDEiTnV7XSO3+QYzBlhv6O9thDXqA6IpX8U0rK4eAQEIxKyccl2OKWrHwGAsfqayqc
         ywPX4T0q92fITr8NVL86S6GKDfmaWwcQXgPVdqMjk2nZkCsJPIO8HnTKEa37+jG3Z/ma
         Nc6j4Oe//hBmPzwmmOOKH0kvsaD+7JrrAzlt0fqmLRVlY8Mauo8kznT9JNlQ5mr1kDEL
         +Pu7pEBZ4QYPAVEaOutKO+d3hou/ZFbRgGFUI82w2g2fZUhcArHe7Zz2eNZ0325djr7G
         sYCxUECxACeZgKCX2aEYfj6Eghpgh03TeDLfNyJtJw1YtZNzSG/RiOTqDFYMzce/pxOc
         m4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVBIxXRUNRgKU9t1fIKgqV97FXGK+wVBurGuxsLILPhsGL+uZBnyrA/Yl2JmD5HR7hAAjAoO2FKwGdtqPzOr7AhCHzaRBPKyOZ/sa+y
X-Gm-Message-State: AOJu0Ywfe8N/PnKGQoEHqa2v4mhzuNu+PCCbSad3p5RNEmnonE8IC1cv
	ner0niSfPFoSKdZcmrsuAhrh9tr9PfGkesyaealVmkXo2NLaIUsADGvWPU70Vg==
X-Google-Smtp-Source: AGHT+IHktRWVslmmx7Xk3Q69c9B87Qql/AEyNyH9YU/soO+uZ55IsjIvet+79ZawprWgeW5wyoS5IA==
X-Received: by 2002:a05:6e02:13a9:b0:381:c5f0:20d5 with SMTP id e9e14a558f8ab-383953e23c4mr9787485ab.0.1720067369370;
        Wed, 03 Jul 2024 21:29:29 -0700 (PDT)
Received: from [192.168.86.39] (121-45-188-148.tpgi.com.au. [121.45.188.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6abbcc26sm7527085a12.38.2024.07.03.21.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 21:29:29 -0700 (PDT)
Message-ID: <23ce05ba-105d-480f-968a-1ecc2e482634@tenstorrent.com>
Date: Thu, 4 Jul 2024 14:29:24 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: vdso: do not strip debugging info for vdso.so.dbg
To: duchangbin <changbin.du@huawei.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240611040947.3024710-1-changbin.du@huawei.com>
 <ef2b1430475140c88a929b1678338726@huawei.com>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <ef2b1430475140c88a929b1678338726@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/7/2024 11:57 am, duchangbin wrote:
> Hello,
> Is there any problem with this change? Ping~
> 
> On Tue, Jun 11, 2024 at 12:09:47PM +0800, Changbin Du wrote:
>> The vdso.so.dbg is a debug version of vdso and could be used for debugging
>> purpose. For example, perf-annotate requires debugging info to show source
>> lines. So let's keep its debugging info.
>>
>> Signed-off-by: Changbin Du <changbin.du@huawei.com>

Looks good to me

Reviewed-by: Cyril Bur <cyrilbur@tenstorrent.com>
>> ---
>>   arch/riscv/kernel/vdso/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>> index f7ef8ad9b550..960feb1526ca 100644
>> --- a/arch/riscv/kernel/vdso/Makefile
>> +++ b/arch/riscv/kernel/vdso/Makefile
>> @@ -45,7 +45,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
>>   # link rule for the .so file, .lds has to be first
>>   $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
>>   	$(call if_changed,vdsold)
>> -LDFLAGS_vdso.so.dbg = -shared -S -soname=linux-vdso.so.1 \
>> +LDFLAGS_vdso.so.dbg = -shared -soname=linux-vdso.so.1 \
>>   	--build-id=sha1 --hash-style=both --eh-frame-hdr
>>   
>>   # strip rule for the .so file
>> -- 
>> 2.34.1
>>
> 

