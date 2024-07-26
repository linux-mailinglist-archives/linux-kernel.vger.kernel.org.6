Return-Path: <linux-kernel+bounces-262863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEB993CDFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1136C1F23564
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC71741C3;
	Fri, 26 Jul 2024 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQX0qMY5"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335C15666F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974299; cv=none; b=ulOb9X8FqUQ13TLNYcikHU2op2pmGiA/jhHrc/MyRmttKuK9C0vU9fNuLVgcbW+shS68oI/pbfJ/QiUtByQhvHrTKcWXt6Mcf2/nkxWeAWhaSFmnDYy+0EsVBYnTAH3F3ovPHNFCHv902GPDSGNiWakVKmx/2WVA9yjca5DOPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974299; c=relaxed/simple;
	bh=EmJe3D1bXD/2gneHHdq6mYyUzAbJGoBzTjETmdS0aeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaHRHN7ujERvwd8J0JL7ZZJXGIG4SzYnLBRdfldcpl6S2aSGvmEWP9DUd+7KQoS+Iuvk7A7TngqCSn3wcazAcSyP5vrTmE6NUud4OPuAeKOB5e+jtljY5s/M0Yw5ZlOps5u0TpK5t0Ql1YzSY0ej6Pbog3Oa9T1sr3K6cJVi9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQX0qMY5; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7092fb4317dso588405a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721974296; x=1722579096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcYYPAG6IdzBLeAi209u5r0ILn1CzN8epM7dkDvfCNE=;
        b=fQX0qMY5rMsJ+bdrrPcwJzF6sRNOVWpxcrXLU32nh0s/xLDnRxKb0Jx0QLErAGZmM/
         PgA6Ze37IPwK6NRAsU8EjdviHavg44Wm9M2otJf+/360KLQNsa0gSfn0bMG4jwLkDnGG
         xA3RpE6M41OwjASvmUkSLJNafcNgWDvs4L2ZfrsdogIWCOzFzHVXJ3Dr+FpHcljQ9PFt
         cuWzN7WGzLbbKe7Oag/hMyH1kn8/uS/E1cporiI7hy+jWrNluUlBBzn99FbXovjhONYQ
         Pvpq97+FFjZxvtSae+pyEHtDS6QHyuEQT+Jc8NmIKBHwYoqUk4EBW5l7MVDOFF19FTsu
         hWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721974296; x=1722579096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcYYPAG6IdzBLeAi209u5r0ILn1CzN8epM7dkDvfCNE=;
        b=AkGmvH9qVdfjAGMoxOsga2PiWsU+e3b7wJm5UutKxLBQT2ip5Sap4A2hGN34pCsYC/
         nXF0qujBTb7iuwWojzKosOlGb2SB8D0ef3AY3ySI30Kqullg9vV2tqk1dkJFiXzh6JeO
         qIDWd0PsnjqolGL6oAUBlAxhblNbWd2gb7gKv0pykPW1uP7t5da8QHWoOQTz3cJ8DrFp
         qQ81w7yHhxwxgZsyd+YWRyP1e7zIymfhY/sELEQrGcW7lEmy6u+0Lp+zlDBO6z9cvyAA
         eDRIpOuE32XatnVGJIvgcn0LZGM7sv6cqPkYeBQ5agowHt+7j/4O+dxRP/1A3NsAua7I
         NPpw==
X-Forwarded-Encrypted: i=1; AJvYcCX+lvw3x+lHF8OYCJYb/Fae63+PkFGVH1D+4O1BjICqKjeJfmd+MxirKTbBxv/m1wcl0FGbheCdvFfaZD8lvavYx/i5I8FMwlykZLx6
X-Gm-Message-State: AOJu0YxCz5Ick6g6nAjRIzUG8Xph99wScQ+s2dErGB2QpoKxNqxS2WMq
	QITBABcVfy8mSF+IWYZntONo5mSsdaOY04d+SId6HnXs1WkRMT4p
X-Google-Smtp-Source: AGHT+IHw1Cjs+3K64BZwFTD53doafg+wR1ix2dtUFk/7grHr815fnV7ZU3SWRdhvvtE2qnybvMjEOA==
X-Received: by 2002:a05:6830:668f:b0:709:3b06:d578 with SMTP id 46e09a7af769-7093b06dc6bmr1198418a34.26.1721974295753;
        Thu, 25 Jul 2024 23:11:35 -0700 (PDT)
Received: from [192.168.255.10] (23.105.223.42.16clouds.com. [23.105.223.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a35ddsm2023061b3a.202.2024.07.25.23.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 23:11:35 -0700 (PDT)
Message-ID: <6fd3684b-1b92-4a26-ae3b-98e5c1800d40@gmail.com>
Date: Fri, 26 Jul 2024 14:11:31 +0800
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
 <bd36db00-5464-4eb5-adb1-0ddfd3be1cfa@gmail.com>
 <ZqJZNqq74NSAI8vS@xsang-OptiPlex-9020>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <ZqJZNqq74NSAI8vS@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/24 9:55 PM, Oliver Sang wrote:
> hi, Alex,
> 
> On Tue, Jul 23, 2024 at 04:23:00PM +0800, Alex Shi wrote:
>>
>>
>> On 7/23/24 11:22 AM, Oliver Sang wrote:
>>> hi, Alex,
>>>
>>> On Tue, Jul 23, 2024 at 09:58:25AM +0800, Alex Shi wrote:
>>>>
>>>> On 7/23/24 9:05 AM, kernel test robot wrote:
>>>>> hi, Alex Shi,
>>>>>
>>>>> we noticed there is a mmunstable3 branch now, but there is no same title patch
>>>>> there. not sure if this report is still useful, below report just FYI.
>>>> Hi Oliver,
>>>>
>>>> Thanks a lot for your testing and founding on my unreleased code branch!
>>>> The problem should be resolved on my latest code yesterday.
>>>> But multiple archs maybe still are fragile in the branch. Are there bootable in virtual machine, like arm, s390, etc?
>>> we did boot test in vm, but only for x86_64 or i386.
>>>
>>> you may notice we also send another report
>>> "[alexshi:mmunstable3] [mm/memory]  f6ba7ce983: kernel_BUG_at_mm/page_alloc.c"
>>
>> this problem was fixed too. Anyway thanks a lot notice me of this.
> 
> thanks a lot for information! just was wondering which branch contains the fixes?
> 
> I ask this because we still have some bisect results pointing the commits in
>   mmunstable
>   mmunstable2
>   mmunstable3
> branches in https://github.com/alexshi/linux.git
> 
> are they still useful? if they are out-of-date branches, we won't send reports
> to you upon them. thanks

Hi Olive,

Sorry for response late, I have some issue to deal with lately. 
The mmunstable2/3 are removed a couple days ago.

Thanks again for your great job!

Alex
> 
>>
>>>
>>> for both commit, we made some further check and cofirmed they cannot boot
>>> successfully on both vm/bm, again, we only test x86_64/i386 for now.
>>
>> Thanks a lot for the info!
>>
>> Alex

