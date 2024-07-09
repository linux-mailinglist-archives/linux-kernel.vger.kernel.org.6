Return-Path: <linux-kernel+bounces-246670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB13592C505
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D1B21208
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA644180056;
	Tue,  9 Jul 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bNiLcKjE"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA61B86DD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558514; cv=none; b=CVdOYYeI4tdUmpAYfNT33/6j/UYJTpZUoWh5Bm15aTTmQpSW6nOspA1YRceP+p7f6Ct9nhXAhBaI+K/bQghm6lWd2Di46nbWKJCKgmlRFBMW4o5ShfrP4ieg6+j4ci1VS/ljRqlP/z9P+kxvL+VSMbMIPna1XoYZ96vcJBDwyGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558514; c=relaxed/simple;
	bh=o+kjmggQJg9k2C51wKggJKaDqzA0Rap7ZoYOuaO1xOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDS95/Jmp+3ZmtujUiHvGv4mOxHrEmovg0nJDeilvVnyc0r6yfDTIGi0AIR1xr7nwImIhecTOCw/Gi/PddG0vpWedfsvmDa6EeHjgO593GiO5vA7BiYa7JEXDvUGbh+3/Tq0f7qGEUPyUFoOFG7ZjK/eKHuBRtN5Cyiuc+vqlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bNiLcKjE; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f95c28f2a7so9849239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720558512; x=1721163312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojllmUSpZm6yrskg60MuCouRkTNtpmyHnalLRc4XlN0=;
        b=bNiLcKjEiUicPQpwDjybJj6Lon+olKxM1ydDuvjC7guaewUnyn5aZUS05xgkjKczZN
         Ej6O5Xona0klOgQ+NW6G47+pdn45/caQt8deL0U6PXNPKwuIKTp5g+lcNkZP8mRu9r9H
         5b6XikVbGlz8OYIhyObqanUOlMIcEbNdjq/gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720558512; x=1721163312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojllmUSpZm6yrskg60MuCouRkTNtpmyHnalLRc4XlN0=;
        b=J0LBVBMM4dlw7xYh6kR3wyIcaf3URQ9oxTqjEX751gKc3PQJZrOZLpaOA3D6XClFZ/
         lx0SiEEkv0S6m00u7CWsj/+LCmLZhjfB9Yt7cuobAPDtXFxw26j/D1cW0pjsobXpGFIJ
         75P8OR2zaIB1ClWWeu+ArKS5JGpX6uJXeqlBDmQ1OoaGNhAvCgRkEhcQTHmFGgRCyaeo
         +7NxXTx7qiqUsF5t8+9v7O11TzOSSDT04VmasvWeIVS0wYt9CdsmsSSvhpKCwL9Ulm9J
         aDnIevW2DQCkiAceOF+EM8ukMCf0jhWdqzJfiYM8ZTthyafyCzZ4gejcIyc1BNKtTa2o
         ZkdA==
X-Forwarded-Encrypted: i=1; AJvYcCUZqZzYlhKUJgjL8T/ePJGaZ1dVe0cMcodsNYJqPtaym6ECv9IN4xSkRP4gPNtgXeP4zN/ZAoyndq5GYOt8mlummW+SkKezJM9WLnAr
X-Gm-Message-State: AOJu0Yw/fdPxs7BhCqvETzfyvFATQoiD7lBEmXj+ctdPOldYlj6tejC6
	uDTYXbxzVjkvPUXIJ9xHASoyl4CaWT/GmV33lk+thc4fE4g/G9w+VAfhrWPzO8k=
X-Google-Smtp-Source: AGHT+IGsTMwpROjo3tzdIGl+v6KmheqJ1Zkqq2lQFdbmodzrdfcJ5ZovcBQXKo9Hg/rrSAQ8WBlnZg==
X-Received: by 2002:a05:6602:6103:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-80004dea088mr421983139f.2.1720558511891;
        Tue, 09 Jul 2024 13:55:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1b5c55fsm687026173.77.2024.07.09.13.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:55:11 -0700 (PDT)
Message-ID: <0ce444f4-8d49-472f-a687-34804347296e@linuxfoundation.org>
Date: Tue, 9 Jul 2024 14:55:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] selftests/x86: fix build errors and warnings found
 via clang
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, x86@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
 <a08e6846-2f9e-4fb4-910f-b33fe779fa01@linuxfoundation.org>
 <49c14f8f-0c08-41e0-b987-7c4253edf6de@nvidia.com>
 <78c3ed1e-32b2-43aa-9979-0479fa524018@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <78c3ed1e-32b2-43aa-9979-0479fa524018@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/9/24 14:51, Shuah Khan wrote:
> On 7/9/24 14:40, John Hubbard wrote:
>> On 7/9/24 1:34 PM, Shuah Khan wrote:
>>> On 7/4/24 01:24, John Hubbard wrote:
>> ...>> Muhammad Usama Anjum (1):
>>>>    selftests: x86: test_FISTTP: use fisttps instead of ambiguous fisttp
>>>
>>>
>>> Usama and John,
>>>
>>> I am seeing checkpatch warnings in this series.
>>>
>>> v4-3-7
>>> WARNING: externs should be avoided in .c files
>>> #210: FILE: tools/testing/selftests/x86/fsgsbase_restore.c:46:
>>> +unsigned int dereference_seg_base(void);
> 
> This one looked new though.
> 

Never mind. Looks like there are a few existing warns - pulling
these now for Linux 6.11-rc1.

Thank you both for fixing these.

thanks,
-- Shuah


