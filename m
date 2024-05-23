Return-Path: <linux-kernel+bounces-187691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025658CD6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862F21F21715
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CFEE546;
	Thu, 23 May 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtSmpxNU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F0D2FA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476878; cv=none; b=LLpqmOZVAbVLOZCX+mVrcQ/w/4ITTdbjKvOez+tMcdIVSnbmx1kS3DEX97TAnJU/N6du4/HUwMGLTiqZGnUtuN/dtyH5jmFUq91Xjf7ngKc/zIn1dBHVI+kH8ChSWgVe3UCRP07Cde7LNU/tsP6+5X7IXJwdlhIGoMooIhnvmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476878; c=relaxed/simple;
	bh=aSvFynA2aGsdOCL6sHpBnQLWYMlxb/Kj3MJFAJ4NFOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8/5OvdTerIM5GOwgexqtUCzOlHjPlM2PBE9UBGDTSBxBKtpIcMEhhYIMYrEzz2ImYT7c7JYqCRTuhpi0KJzwNq+f8/kaD36XmNha3g3dj4F1/YpbFrA0O/nv7q4NeVIQHOzYzUtIKgtq/2nBIE3FmYiljy0qk5HPCa+G8vuSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtSmpxNU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716476875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WUlyczYiNQvC4jIocd6nnAbZ0E5f7+hM6D+POKlamBU=;
	b=gtSmpxNUKNrpaMcqEdReIMYkXbIAnaCGTJMy2s3Rq4s3A1kYO4YzMVahhOn5L3F45gu8hT
	XTyM8BCVU75jCLky311xv5gpiF4A6tHyRW7+s8at0/iXuCcxSDo8Tpkdq46R53WVgzIZ1a
	ga7lCWUS0nEd6EGY6ZuiWpLk6IJIhsc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-_6pWf3eOMembq1EB2U2zpg-1; Thu, 23 May 2024 11:07:54 -0400
X-MC-Unique: _6pWf3eOMembq1EB2U2zpg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34d99cc6c3dso9056409f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476873; x=1717081673;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WUlyczYiNQvC4jIocd6nnAbZ0E5f7+hM6D+POKlamBU=;
        b=ozW8K+e9nrbDVbjlAxTVasBAURptLFJiFCtvFE2Aep2IzjMUMcNr01T4IrkeEWk8RG
         wt4NDQNV4NxTW5pGPJnrbbq9wV4QIutw3TDPsEEweLd/u67jNPXPC4hZ0+rm+DvBrRWO
         xAx9+BJbZ5WDJqzIyVTAwqQEj0jcmyNLY7eYsrJFeS3ov28rO+LapHREUIEo1KrCbZuz
         gnipHvofWBlVGMco65UhQZQm78Q2RW9weTrJnczjXw9GGGxnctmuNuMKmobhX6JEGEbb
         f3iHpe6gmUQVj3KEeh0dY1dm3WzRr+LLSdAr9e+EnS+kQ1KsMOmoY2coDC65UeSu3RWn
         cTxg==
X-Forwarded-Encrypted: i=1; AJvYcCU6MuuOsr1qGqKGBzA2feX7fEXZpNskhEoiz491ddsQm53Oy5+DfmJZAtdqyluIRx336VOolP7Adj/oKr8cCP7jTt3YLpGKLm6jAjsQ
X-Gm-Message-State: AOJu0YyJUPrUT5z5wCt1NkoK9RA6haFyfbRHeLV9fI2ld6U+Hf2MHfk/
	0cOwQj7jr5NGGMziKOKwAu5/Lf10xRD12DbJPwHfLUP5Jz01P9ZjPMZjNJmQumDV/9Jv7zwCL0y
	9R8jwauLWtiHRQGlyjp1HP80VcjUTHSmUOXx44HgJGw5sp/jdDYHZL5EGcxUDyw==
X-Received: by 2002:a05:6000:d1:b0:354:cdb5:a9ad with SMTP id ffacd0b85a97d-354d8d8d9cfmr3909240f8f.42.1716476872929;
        Thu, 23 May 2024 08:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4r9tx4gYU9CLRkweFVydIiZwZzoflOexqHsM7yc80czwYP/kbJ6cyPpzexiI05C13Bn7tkg==
X-Received: by 2002:a05:6000:d1:b0:354:cdb5:a9ad with SMTP id ffacd0b85a97d-354d8d8d9cfmr3909210f8f.42.1716476872470;
        Thu, 23 May 2024 08:07:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:5f00:c949:6700:cce1:e60b? (p200300cbc7175f00c9496700cce1e60b.dip0.t-ipconnect.de. [2003:cb:c717:5f00:c949:6700:cce1:e60b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad0absm36820581f8f.69.2024.05.23.08.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:07:51 -0700 (PDT)
Message-ID: <8387d2d8-921a-4992-b622-15ddd89bf8d3@redhat.com>
Date: Thu, 23 May 2024 17:07:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Dave Martin <Dave.Martin@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 James Morse <james.morse@arm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, "Shaopeng Tan (Fujitsu)"
 <tan.shaopeng@fujitsu.com>, baolin.wang@linux.alibaba.com,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 Peter Newman <peternewman@google.com>, dfustini@baylibre.com,
 amitsinght@marvell.com, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <b60aa6cc-7396-42c5-9a42-db8d6e8bfef6@intel.com>
 <ZkOAhH6tm1NXpre2@e133380.arm.com>
 <64113803-e4b8-49a2-a217-e1be790872fe@intel.com>
 <Zk9aUtGmeMN04+nD@e133380.arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zk9aUtGmeMN04+nD@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.05.24 17:01, Dave Martin wrote:
> Hi Reinette,
> 
> Apologies for the slow response...
> 
> On Tue, May 14, 2024 at 08:56:41AM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 5/14/2024 8:17 AM, Dave Martin wrote:
>>> On Wed, May 08, 2024 at 08:41:37AM -0700, Reinette Chatre wrote:
>>>> On 4/26/2024 8:05 AM, Dave Martin wrote:
>>>>> This is a respin of the resctrl refactoring series described below,
>>>>> addressing review feedback.  Many thanks to those to responded with
>>>>> feedback on the v1 series [2].
>>>>>
>>>>> See Notes and FYIs in the individual patches for details on the changes
>>>>> and outstanding issues.
>>>>
>>>> What are your expectations regarding this series while considering [1] and [2]?
>>>>
>>>> Reinette
>>>>
>>>> [1] https://lore.kernel.org/lkml/ZiE8%2foXyjBef2qTy@e133380.arm.com/
>>>> [2] https://lore.kernel.org/lkml/acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com/
>>>>
>>>
>>> I plan to propose a reworked version of the fflags and string parser
>>> stuff, and take a look at the other more minor outstanding issues.
>>>
>>> The series does need rebasing, but otherwise I don't anticipate much
>>> change to the code from the Arm side unless there are further review
>>> comments.
>>>
>>> Do you have a preference on how this series should proceed?
>>
>> I believe that I already answered this question in [2], hence my confusion
>> about this posting.
>>
>> Reinette
> 
> I guess James and I need to tidy up the loose ends and repost this.
> 
> I'm hoping we can get a v3 out over the next few weeks or so.

Finally having more time to review this (I hope ...) does it make sense 
to review this v2 or wait for v3?

-- 
Cheers,

David / dhildenb


