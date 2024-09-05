Return-Path: <linux-kernel+bounces-317124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E27F96D97E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5247EB21940
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B41119B5BB;
	Thu,  5 Sep 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeAefCmn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F90719AD7B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541062; cv=none; b=iZ0NdDECRkUQES4bE26x8BP3QlSeByeP+3aNQnCdiL9jblK2MMg9pwh/BBQ/G45xwOWZmJ3skCL/4O7LsB51LmVcbUO/fb5uii3rXOnE7zmDWhPWp93b1gEHADfMi//3VHglynrEgDCFA5f4qzdHsFazjwsGq2RbbEbjpMj4IFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541062; c=relaxed/simple;
	bh=xKRfiLFsy+X7EJ3F0XimXN9rM1nTecm8jJGN88kB+mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svC2WZmJqr2ki3QRQmwOBN358ZPVDgYUmRg1FxGbvx1JGCszs0wUTe1gaDXm9r+6j3P4JBWwGCGYDqtd/TrlhsQHFf7OYlDQsijuYdPlU/vO9N+A7uIpmp62wmZCXFn1VKQGpREqjPMHGLtewHfrkcqdw9nc0NQX82lWvnEM454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeAefCmn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725541059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HC7DNBeTE0rMvf380tBoSGULnjcQlOiQ6D5SLCKyY/A=;
	b=NeAefCmnCBGu57q7vvQhyMaYGFVy53QxXaLp4n55Nd69EV3ZVaYZiqaispMvCincSbOubI
	8ellah9qk3/5wHt1CwLjNuy7g+BHCmh+7ZND8137Wj9Q7MZ1dwSfUGAw6/p20AVwjOYwE5
	JxZbD7QZfwnZygawZ4hxRm8eVF6aIlU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-m1Uf_WKTNuy31DqwwMQAiw-1; Thu, 05 Sep 2024 08:57:38 -0400
X-MC-Unique: m1Uf_WKTNuy31DqwwMQAiw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-371bc601737so476418f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725541057; x=1726145857;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HC7DNBeTE0rMvf380tBoSGULnjcQlOiQ6D5SLCKyY/A=;
        b=jbpaI3wcaJ9MaTDzIL1bxW/QZiMr1oRoFrkc4T1MhQxmM+01EUxusPAlJO73+x/STN
         YXXgCQGRPTQW8LQ/xiqgLwrDVmNv+tqjtL7ec63JeCk6kryoETS5vvasQ9gM0Mwsmkd1
         MkwmnKv43vGmc58cLiDY112Fnltv0Es1BB36/l3RH53BBQpEusiRpau2fK0JGYK1Pkld
         ygHcydMv3S9X0NL168hsSsr4wmkrTlEyXlkx2T/f7xxLUoR+YePnqxczTQGMnYw4Ujor
         LYwW+im/MrDurN0rZFnmkuIHM/ij2mtnINvqgtVyvgbxspZ+BbNBs3T4RIfxNBVLH/Mq
         kTGw==
X-Forwarded-Encrypted: i=1; AJvYcCXaanE/tk/5uYmunVc69PRsSJzbHp54rx9X0SZuL/h8avJzED/hfATINRYaJ5azRAw7oZVT032tDHoqVMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/YuaCEZD+vtlyyur7I2jEAQZs4AlC9XaZOSi14PqcFLOQdd8
	AvS1Az3iAKat5nwX4Fo2urYbEI9bJ6EFVr2vIyNEYW71Xk5C3g0qihA3jQz80jKJVqgWVhtXl4+
	Q9Iv1TC8Q2GRVi17sv2lBTGYQV+bjAz1jTqRJoJS3r2PZXz7ship/Rz8ApOK3SQ==
X-Received: by 2002:adf:f98a:0:b0:36b:bb84:33e2 with SMTP id ffacd0b85a97d-374bf184398mr12216059f8f.37.1725541057167;
        Thu, 05 Sep 2024 05:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUrvgpMzWuhmEBanz6AJFCwGfMD5kMirVqtryS963qETW9P0ukfnSGIibr1cxMmlbdge1udg==
X-Received: by 2002:adf:f98a:0:b0:36b:bb84:33e2 with SMTP id ffacd0b85a97d-374bf184398mr12216028f8f.37.1725541056500;
        Thu, 05 Sep 2024 05:57:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:5400:6c12:d0e2:3757:2963? (p200300cbc70854006c12d0e237572963.dip0.t-ipconnect.de. [2003:cb:c708:5400:6c12:d0e2:3757:2963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c15705easm13894428f8f.33.2024.09.05.05.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 05:57:35 -0700 (PDT)
Message-ID: <922e97d9-e16a-4bb8-90b0-4bb3347174e8@redhat.com>
Date: Thu, 5 Sep 2024 14:57:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 "Huang, Ying" <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Baoquan He <bhe@redhat.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
 <65838cc0-9a20-4994-a0ef-9cd50bb00951@redhat.com>
 <Ztmlw1q3Djn94MRQ@smile.fi.intel.com>
 <09d44b21-9739-417b-a76c-5383fcbde96b@redhat.com>
 <Ztmo_EITDSRewSka@smile.fi.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Ztmo_EITDSRewSka@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.24 14:50, Andy Shevchenko wrote:
> On Thu, Sep 05, 2024 at 02:42:05PM +0200, David Hildenbrand wrote:
>> On 05.09.24 14:36, Andy Shevchenko wrote:
>>> On Thu, Sep 05, 2024 at 01:08:35PM +0200, David Hildenbrand wrote:
>>>> On 05.09.24 12:56, Andy Shevchenko wrote:
>>>>> On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
>>>>>> Huang, Ying wrote:
>>>>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> [..]
> 
>>>>>>>> You may move Cc list after '---', so it won't unnecessarily pollute the commit
>>>>>>>> message.
>>>>>>>
>>>>>>> Emm... It appears that it's a common practice to include "Cc" in the
>>>>>>> commit log.
>>>>>>
>>>>>> Yes, just ignore this feedback, it goes against common practice. Cc list
>>>>>> as is looks sane to me.
>>>>>
>>>>> It seems nobody can give technical arguments why it's better than just keeping
>>>>> them outside of the commit message. Mantra "common practice" nowadays is
>>>>> questionable.
>>>>
>>>> Just look at how patches look like in the git tree that Andrew picks up.
>>>> (IIRC, he adds a bunch of CCs himself that are not even part of the original
>>>> patch).
>>>
>>> I know that and it's historical, he has a lot of the scripts that work and when
>>> he moved to the Git it was another long story. Now you even can see how he uses
>>> Git in his quilt approach. So, it's an exceptional and not usual workflow, hence
>>> bad example. Try again :-)
>>
>> Point is, it doesn't matter what we do in this patch here if Andrew will
>> unify it at all.
> 
> Point is, that this is exceptional. And better to teach people based on better
> practices, no?

"Better" in your opinion. I don't care about a couple of Cc lines in a 
git commit. They've been useful for me, apparently not for you.

If you succeed in convincing Andrew to change it, then Andrew can fixup 
his scripts to remove all of these from the patches he sends out.

> 
>>>> Having in the git tree who was actually involved/CCed can be quite valuable.
>>>> More helpful than get_maintainers.pl sometimes.
>>>
>>> First of all, there is no guarantee they _were_ involved. From this perspective
>>> having Link: tag instead has much more value and supports my side of arguments.
>>
>> Link is certainly preferable. Usually when I fix a commit, I make sure to CC
>> the people that are listed for the patch, because it at least should have
>> ended up in their mailbox.
>>
>> Often, it also helped to see if a buggy commit was at least CCed to the
>> right persons without digging through mailing list archives.
> 
> How is it better than having it in lore.kernel.org in archives where you even
> see who _actually_ participated in discussion, if any?

You might have to dig through multiple code revisions to find that out. 
Again, I used this in the past quite successfully.

> 
> Again, Cc neither in the Git commit, nor in the email guarantees the people
> were involved. Having Cc in the commit just a big noise that pollutes it.
> Especially I do not understand at all Cc: mailing-list@bla.bla.bla cases.
> They are not people, they have a lot of archives besides lore.kernel.org,
> only waste of resources in all means of that. I tried to summarize that in
> the submitted patches to the documentation, that I referred earlier in this
> thread to.

I, for my part, never add "Cc:" to patches or cover letters that refer 
to mailing lists. I add these manually to my git-send-email "--cc" list. 
I though Andrews script also fix that up, but I might be wrong.

Anyhow, this is a discussion to be had with Andrew, not with me, so feel 
free to engage with Andrew to change is scripts to throw away all CC.

-- 
Cheers,

David / dhildenb


