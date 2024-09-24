Return-Path: <linux-kernel+bounces-336568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF95983C76
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226621C22612
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66993FB31;
	Tue, 24 Sep 2024 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bLCASLD0"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8C1805A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156737; cv=none; b=pBvW2aaCe/LijeVp+4PkfXZMwBmdUJBthYVrS6Zsg5ThV5KyDpBLtbYS4PGEBSY5pmaFx+dL3jy+qoyw0g+rfkfxlCbgPSR7E9Y3A1bv96HdoKG8bgrgSIn8A99EcdwfOqIRg+VW3aiOa/zgyYOgSTlEoN5Yxstp1tGj4xEppsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156737; c=relaxed/simple;
	bh=LpTP2rnxbSLA1hB9kb0LGV8f13H1EjC54vcEqO7a7V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4ij1rLsnAOPNi0CvVrr7E7FoilPWEToWNS4dk7N0pP4NrH4D8DhSpOX4OPjUGI0asa/ElR7emLFd31tbdlHxBOuGaBL6JHoBWKwTjtEgti/7ST3LS72aANJmopjFIz57MnXjLW/sL+7kBmSXQIRA+BrGoz4FzjW1lWJ6kakX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bLCASLD0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3146731a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727156735; x=1727761535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeTTfEP21YQMwLAUy4SADnduCcNtF9EPPwDHhlpCESk=;
        b=bLCASLD0pR+LBLNP/GuoJ1MChX80UDsAxxmbTHJWqCCkqO7X/WAJ3tJ5PMbpiuTgNa
         +K3rf4glHfkhS5h4xdn7DQVmtk4Nw61ViJtpZfYQOPAcisc057gh+Y2udn3O4KJPrq8Z
         7qHJpYxQDSYaDRf0W3yqP+80VS0iyZE4/FX9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727156735; x=1727761535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeTTfEP21YQMwLAUy4SADnduCcNtF9EPPwDHhlpCESk=;
        b=mXKG0J9bqNL7SO8PIjef3xh4GH/uaOX0Flpfop339MbxTC+tkEO8R5MqPCvV9d4+TY
         aTQ6BJ6bO+H7ZwSW1meVtOqWLV0PDClu6y1+fvwGLBfBH4qA9PJ5U6Nik64bS2bTBG5T
         wHH+S0Mklmv3cUwQpZ810t67SjRqawhRFipOX67XCWO5qVVAYVg4dmHEz44Lh51AREf+
         7hvVc3bbeSg8nsxMUBbq8ILWR0xIi3o3Bls40Cd+VVyzK+Am0D1xqLDKJUNrd/lqMDWU
         TCC4BiImdEWhKg6twfgh5uVIv2/RbC6UnUTw05EMM4gPs6y5DbIgZjILjFMM/a9+PS1Z
         fkpA==
X-Gm-Message-State: AOJu0Yyci97kwn2WnyrAtpk4Z5W38dROGVVeHC33tDE6p9OcBc66SLOG
	9T57dkbNpjk7lcBlBwlgPKnlA2AngDlHtil1mSd7TQvy/WI9VSqLxqHYBm+VZC506u2czbZYR80
	=
X-Google-Smtp-Source: AGHT+IHdVQKoD4kItS4+wfdVpqyh2HMbLHgJbdjm7D2PWC8fCmmbhRVTMB91oTu1SObo+zpu/O3siA==
X-Received: by 2002:a17:90b:4a4a:b0:2d3:d8ae:67e1 with SMTP id 98e67ed59e1d1-2dd7f6c2e82mr17370202a91.26.1727156734980;
        Mon, 23 Sep 2024 22:45:34 -0700 (PDT)
Received: from ?IPV6:2401:fa00:61:204:1594:dcda:6c3c:7310? ([2401:fa00:61:204:1594:dcda:6c3c:7310])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ee7d330sm10537652a91.2.2024.09.23.22.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 22:45:34 -0700 (PDT)
Message-ID: <6ff0dd7c-0548-4d59-8a32-747b4869e7b9@chromium.org>
Date: Tue, 24 Sep 2024 11:15:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Order 4 allocation failures in the MEI client driver
To: "Winkler, Tomas" <tomas.winkler@intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Lubart, Vitaly" <vitaly.lubart@intel.com>,
 "Usyskin, Alexander" <alexander.usyskin@intel.com>
References: <20240813084542.2921300-1-rohiagar@chromium.org>
 <75f758e5-a26f-4f41-8009-288ca2a4d182@app.fastmail.com>
 <4d6f3331-5a9c-46f2-8e27-3484ba6f6eab@chromium.org>
 <25e56199-7af1-4235-8973-cbc351325b8c@app.fastmail.com>
 <PH7PR11MB76050864E8DC9F7389314BF2E58F2@PH7PR11MB7605.namprd11.prod.outlook.com>
 <4a66eea2-c23b-4c34-a5c6-508bf2a6fc47@app.fastmail.com>
 <PH7PR11MB7605F68E96E24CEF6C92F8AAE58F2@PH7PR11MB7605.namprd11.prod.outlook.com>
Content-Language: en-US
From: Rohit Agarwal <rohiagar@chromium.org>
In-Reply-To: <PH7PR11MB7605F68E96E24CEF6C92F8AAE58F2@PH7PR11MB7605.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 23/08/24 2:30 AM, Winkler, Tomas wrote:
>>>> On Wed, Aug 21, 2024, at 05:20, Rohit Agarwal wrote:
>>>>> On 19/08/24 6:45 PM, Arnd Bergmann wrote:
>>>>>> On Tue, Aug 13, 2024, at 10:45, Rohit Agarwal wrote:
>>>>>>
>>>>>> What is the call chain you see in the kernel messages? Is it
>>>>>> always the same?
>>>>> Yes the call stack is same everytime. This is the call stack
>>>>>
>>>>> <4>[ 2019.101352] dump_stack_lvl+0x69/0xa0 <4>[ 2019.101359]
>>>>> warn_alloc+0x10d/0x180 <4>[ 2019.101363]
>>>>> __alloc_pages_slowpath+0xe3d/0xe80
>>>>> <4>[ 2019.101366] __alloc_pages+0x22f/0x2b0 <4>[ 2019.101369]
>>>>> __kmalloc_large_node+0x9d/0x120 <4>[ 2019.101373] ?
>>>>> mei_cl_alloc_cb+0x34/0xa0 <4>[ 2019.101377] ?
>>>>> mei_cl_alloc_cb+0x74/0xa0 <4>[ 2019.101379] __kmalloc+0x86/0x130
>>>>> <4>[ 2019.101382] mei_cl_alloc_cb+0x74/0xa0 <4>[ 2019.101385]
>>>>> mei_cl_enqueue_ctrl_wr_cb+0x38/0x90
>>>> Ok, so this might be a result of mei_cl_enqueue_ctrl_wr_cb() doing
>>>>
>>>>          /* for RX always allocate at least client's mtu */
>>>>          if (length)
>>>>                  length = max_t(size_t, length, mei_cl_mtu(cl));
>>>>
>>>> which was added in 3030dc056459 ("mei: add wrapper for queuing
>>>> control commands."). All the callers seem to be passing a short
>>>> "length" of just a few bytes, but this would always extend it to
>>>> cl->me_cl->props.max_msg_length in mei_cl_mtu().
>>>>
>>>> Not sure where that part is set.
>>> It's allocating maximum header for receiving buffer so it can
>>> accommodate any response.
>>> Looks like this part can be optimized with pre allocated buffer pool.
>> I understand that it's always trying to allocate the maximum, the question is
>> whether there is ever a need to set the maximum to more than a page. Pre-
>> allocating a buffer at probe time would also address the issue, but if it's
>> possible to just make that buffer smaller, it wouldn't be needed.
>>
>> Is the 64KB buffer size part of the Chrome specific interface as well, or is that
>> part of the upstream kernel implementation?
> The upstream solution is for newer graphics cards and overall implementation is different.
> I'm trying to collect more information myself, it's summer vacation time, so it will take few days.
> Thanks
> Tomas
>
A gentle reminder.

Thanks,
Rohit.

