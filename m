Return-Path: <linux-kernel+bounces-553872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D85A59003
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E218F3AE2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D3227E86;
	Mon, 10 Mar 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpVojWJm"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303422758F;
	Mon, 10 Mar 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599765; cv=none; b=HrxTQD0qZgbhJiZO4C7+njTXQwomSKJSL5IpuI+yBOqF0UF28Ej+xgbwUnurPbN//ZuzHcAA4oczRQU68hIBzdRDB1MEO366LnOYJFcEE5N52q3mO19l7mg3d2H95DVq7fSUyHjS7vwNYj0BK2GvO0uzdVzlehyDFHfi3A2TCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599765; c=relaxed/simple;
	bh=h1E0/A3bjATDwXlqdk725GKR6Hwuu+h4mOX6XmeZSLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzz6gpnTpAXRbF9uegA6G0jfmqKrphJKiRA70HyfQ+hPfgW9npOiU8+EzA34UlHaS+iQhQOkS6B0Eca/IJV+ef/SNxjzCrxlxPkSvJRGpEpN12tTq+kQ+OXWYzuza8Zey+9sAqapec7cA5RTBm655Xdkj+Y0/tgO16M+hlkkGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpVojWJm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so702500466b.3;
        Mon, 10 Mar 2025 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741599762; x=1742204562; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMClGTb/xowiN+wUj5f6h9i/suU0YoMn0juoJl6ktWM=;
        b=DpVojWJmneojq2ZrP1u99fpWNf0SBdT1DibjcoP7GeQR/NTxu/2QQCVNqUDZDd6eBQ
         OWTjm61pD3LzLs/P2FqPJg+KpIKT5ZF7lPYGo7Nu6hSnKNhR2B3a3oZCBss1FIQ2mK2i
         +Q8JOnI28+J8cWH1UBpcyT1x+C+fIpB8V70+o+wtz0+Z897JA7Qiu4B35mIyzBMDUqHp
         JLlbrS4zbL2Q7Vm35ZZEhJhdlwW01u0emD29BM8OPd6ut+/yc44pAuEL2XC1ZVmtyQYi
         gv3YCZQxkvawGBMumXu3A4qZmi3ksEbF4TPbQpFnpvUOJXWcROSNOLUBXmjchYtrPEXS
         RoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599762; x=1742204562;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMClGTb/xowiN+wUj5f6h9i/suU0YoMn0juoJl6ktWM=;
        b=tBj/+/vIEiNXqyg+aNSjXb8/YqT1JoVkzMS+2VUV8QyBgdIRqOnv4azKmTGtGh9Nks
         fLRR4yUGcV9JpiLSWkP7IowUWC2LJufh7um/Pdklt0z+6BOmbs6X5TfmctSZSS+TSQ8o
         VT0ggAbimzXreF7G1aY1I0nLnP4PaAVnoJD9HUxKmUboZQSiaPdtfSEubfxBkXUYrgIH
         WlguWGUIKERn0EtjbM7XXFVzQAG5mA/JthENY8UrUT8C9KU7+vFK2Swf0UxGKWH6JeFB
         91W0uzRIbdQae/JCyyIneh2oTzOn5tcuO/QuzoHNJAasxuAyVL/7AYm4eWBVqoQPvYM0
         VhYA==
X-Forwarded-Encrypted: i=1; AJvYcCVc8WBsmP8BxAKIvBUXMh2XnELTvZjA/9r/wuACZsiPFjqVlueTlUEpIgVnSYoCbOdkNDNGZJ45Yhje@vger.kernel.org, AJvYcCWG2frz4YnptvSZPz1KjwamSH9OpS0u833hzcUwwwlTwDHeTRVRjudQFx1YCVjtP5R2dLpkvTZKi5qOIo3y@vger.kernel.org, AJvYcCWRr+/kG8SiXzADS4RLuCyImdp/1grl4/F2slmv6KqTr3Wpt4h6PhJJaKLIAuH1iBym0ZM3egnNFAQ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4j4FdZdDpIdbVIICUGa79VBUPfrP1lIIiLoh6Ep3J8EsKphQ
	ssFnLQWf3YTVR6MD+siccCjeIg2vlGM/3uXKNWyX7QOuEfAuc1B6
X-Gm-Gg: ASbGnctXSn2hWWQ4Z+us1LfqkN1temS8lVu/YsOXXkuvzxRl3duA4JA8edhvaqqvHAP
	0rQJ55VJqhT+n3JMgMqArmFQsI4jShIOokMkd+e7WGPbvRCSlNaCVESmkQVGR3s1J1QcJbCDWs0
	o4PTuBQTqVybJ094LW7Fsl6mg99noal7ZZodIF7j2eF4w2sLxyux2wpe7In+LEhKOxujG+5y9jF
	6R8JXVizYuvqx8veNChElJT316amYJACOieWFwOB6tqsVPVyT8xUEHwdjkwy+VhnDw3rUllFCxt
	5I6Lr8SptTA+NQb1nLeK3IFKjmF3RBKAca9SCe5WOlkF
X-Google-Smtp-Source: AGHT+IGr1BXamH0TMzryWGEFJPRvklcDIRXonoj2fHuOVeIPkUnC7Qwd3/v9Pu02iEAlM/2ZB1tn9g==
X-Received: by 2002:a17:907:3f96:b0:abf:62a4:14ef with SMTP id a640c23a62f3a-ac25274a051mr1561659766b.9.1741599761642;
        Mon, 10 Mar 2025 02:42:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2b0daaa0asm28863966b.38.2025.03.10.02.42.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Mar 2025 02:42:40 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:42:38 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 02/14] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <20250310094238.lgsiyqci3aqdzrhj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250224013131.fzz552bn7fs64umq@master>
 <Z711VP45tjBi0kwx@kernel.org>
 <20250226020915.ytxusrrl7rv4g64l@master>
 <20250310075627.5hettrn2j2ien5bj@master>
 <Z86ikkLVHQhLmBWj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z86ikkLVHQhLmBWj@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Mar 10, 2025 at 10:28:02AM +0200, Mike Rapoport wrote:
>Hi Wei,
>
>On Mon, Mar 10, 2025 at 07:56:27AM +0000, Wei Yang wrote:
>> On Wed, Feb 26, 2025 at 02:09:15AM +0000, Wei Yang wrote:
>> >>> 
>> >>> From the above call flow and background, there are three cases when
>> >>> memblock_alloc_range_nid() would be called:
>> >>> 
>> >>>   * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
>> >>>   * If it is called after (2), we don't touch memblock.reserved.
>> >>>   * If it happens between (1) and (2), it looks would break the consistency of
>> >>>     nid information in memblock.reserved. Because when we use
>> >>>     memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.
>> >>> 
>> >>> So my question is if the third case happens, would it introduce a bug? If it
>> >>> won't happen, seems we don't need to specify the nid here?
>> >>
>> >>We don't really care about proper assignment of nodes between (1) and (2)
>> >>from one side and the third case does not happen on the other side. Nothing
>> >>should call membloc_alloc() after memblock_free_all(). 
>> >>
>> >
>> >My point is if no one would call memblock_alloc() after memblock_free_all(),
>> >which set nid in memblock.reserved properly, it seems not necessary to do
>> >__memblock_reserve() with exact nid during memblock_alloc()? 
>> >
>> >As you did __memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN) in this
>> >patch.
>> >
>> 
>> Hi, Mike
>> 
>> Do you think my understanding is reasonable?
>
>Without KHO it is indeed not strictly necessary to set nid during memblock_alloc().
>But since we anyway have nid parameter in memblock_alloc_range_nid() and it
>anyway propagates to memblock_add_range(), I think it's easier and cleaner
>to pass nid to __memblock_reserve() there.
>
>And for KHO estimation of scratch size it is important to have nid assigned to
>the reserved areas before memblock_free_all(), at least for the allocations
>that request particular nid explicitly.

Thanks, I see your point.

> 
>> -- 
>> Wei Yang
>> Help you, Help me
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

