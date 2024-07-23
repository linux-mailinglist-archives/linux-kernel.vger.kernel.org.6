Return-Path: <linux-kernel+bounces-259744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD4A939C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8B81C21ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C814EC47;
	Tue, 23 Jul 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lscL5nMK"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A114E2CC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722988; cv=none; b=rDSnE+XoWfEIQL6pW0Set9uY5t6TMJgfh3o8ZUW+bVRJL+wffG53GztgL0sH/UffUBhaY+9HXa6YzotYtfga+j39ZZhA7Q0To9nSeV1BQNO6xjkY+Q+B3NR0YLtwWeZj4kyVUJowCERdMWJnx5Yn9lOggIORCL5WMkZtxS7OfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722988; c=relaxed/simple;
	bh=yiD1Yvi1ZE9QNvroZdUc1EcHgOWM7mxmMWLED8Vy1ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQF5aZ51Kmz5P2kgmmLuTKdTcLaSjW/bIYT/uAHsN7dezKZ9P9PezHdVwPmBI0SrQu1tRoMUAvHip5BGI0SPUJLtGDUTrXkfoHYQI+u95hbENDz6RU3TlS624r0DSMvIBTydbpzwEGfeq06NFhOr78s1H5dL7h2i6kwaDUBpjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lscL5nMK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc692abba4so4161165ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721722986; x=1722327786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQRavVjrAVA/k1fD3x96f9wCcknVkCt9b/ogig2zTSQ=;
        b=lscL5nMKFGnGvksHVlouMr2GwaRtaBoCyfAaDECLNK4AiriNLeCdrgSFYobPnsxUzF
         6KlYVFUnO1sz8syTLQ8TXRl+j8x5+CxscOAXepBMxJ1/0qV/vo65F2I9nvKQ0he2JyYo
         5zGz+9hUu5WqhVCAOUWZKDbwbQl+zYMMWWCAxuZtQaMMQyVD4EMjFy9rw9WTamTubLKo
         TiUFHJivKsOXEFJ2L7xeGA00f0kWdy399Zk6w5YXza6vjd0XdnHijbO4wKfGL4plhSpt
         q71v9ODeGwMEQ0iVvNssgWajVBbfloQXGvtMwi8jONTHcgK2GZGcK5iFmdfTVSc28HH1
         xjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722986; x=1722327786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQRavVjrAVA/k1fD3x96f9wCcknVkCt9b/ogig2zTSQ=;
        b=ZRs0acKHLtcIDy5TJ2rD68lXwexH5U+EvLr5b0WbIN0tLQ8Le1J8uNwkPQ7GOhyqC7
         7D+ZjFb7cBCYD0V5FpyqHF3vDnq2L1CBQmQFdG2XTr1JFztFB3sM07IYx3KtKU7QqNkw
         uCKtggbPH5hM5EpM10t3rGsI8SRYSjicnVcFvU6eb+4ohz+p0LpMP4QpoROaGce4PIMB
         FWAE0EUw1/I9QaKMh2y095wPuKVZRK7nPsBQILjJvbthDu9G/SOAS+sBEQ7lfRUP7pI5
         DofGomGeoykXhHq0shZ1+k9Ic+u3UCo4aOJMNwRcYWF1FzEwrRyFJC1Fr3kleBaWciD2
         y5IA==
X-Forwarded-Encrypted: i=1; AJvYcCW1TDXB20sGYXdDmJ8T2e1m5nVYJZgvEuO7ViSO4WQP/NiHmgNwLPfdTQnbgzUdH33xG73ThpavMiM1tc2UjrgfZFo80+GF3+Qfkrhg
X-Gm-Message-State: AOJu0YzOtyw2FGBXKpfzDN50qcXfzUdQG4eZ+GX8l2uTOsNdltXbIxtC
	3W6DJI+9LisUL05noW5dgBg9DS8C2aHn3OFpfUBcgdgXmpW3M/q4bXrJNdDSFSo=
X-Google-Smtp-Source: AGHT+IE3SkgRs2aAwGEYJvvZ8DOocvL0c1mLCviVpZrLrYMDwLE14oS1NHUWcTOkKb5cr0jYDal9aA==
X-Received: by 2002:a17:90a:d711:b0:2c8:820:71c4 with SMTP id 98e67ed59e1d1-2cd274a8b13mr5370453a91.29.1721722986119;
        Tue, 23 Jul 2024 01:23:06 -0700 (PDT)
Received: from [192.168.255.10] (23.105.223.42.16clouds.com. [23.105.223.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb7754a888sm9530824a91.57.2024.07.23.01.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 01:23:05 -0700 (PDT)
Message-ID: <bd36db00-5464-4eb5-adb1-0ddfd3be1cfa@gmail.com>
Date: Tue, 23 Jul 2024 16:23:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [alexshi:mmunstable2] 934c05f8c5:
 BUG:unable_to_handle_page_fault_for_address
To: Oliver Sang <oliver.sang@intel.com>
Cc: Alex Shi <alexs@kernel.org>, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <202407221607.49138a71-oliver.sang@intel.com>
 <a634bf58-9195-4c6f-b3d8-468d47e71033@gmail.com>
 <Zp8h/ZZTQ0lwmcJa@xsang-OptiPlex-9020>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <Zp8h/ZZTQ0lwmcJa@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/24 11:22 AM, Oliver Sang wrote:
> hi, Alex,
> 
> On Tue, Jul 23, 2024 at 09:58:25AM +0800, Alex Shi wrote:
>>
>> On 7/23/24 9:05 AM, kernel test robot wrote:
>>> hi, Alex Shi,
>>>
>>> we noticed there is a mmunstable3 branch now, but there is no same title patch
>>> there. not sure if this report is still useful, below report just FYI.
>> Hi Oliver,
>>
>> Thanks a lot for your testing and founding on my unreleased code branch!
>> The problem should be resolved on my latest code yesterday.
>> But multiple archs maybe still are fragile in the branch. Are there bootable in virtual machine, like arm, s390, etc?
> we did boot test in vm, but only for x86_64 or i386.
> 
> you may notice we also send another report
> "[alexshi:mmunstable3] [mm/memory]  f6ba7ce983: kernel_BUG_at_mm/page_alloc.c"

this problem was fixed too. Anyway thanks a lot notice me of this.

> 
> for both commit, we made some further check and cofirmed they cannot boot
> successfully on both vm/bm, again, we only test x86_64/i386 for now.

Thanks a lot for the info!

Alex

