Return-Path: <linux-kernel+bounces-197414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436008D6A37
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7411F1C26824
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464B17D343;
	Fri, 31 May 2024 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC5A54up"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE88063C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717185483; cv=none; b=eFfcpzZOIOfnb1AXlHCuowpqtiAY1eW3wdhDWbsz45FKma6s0nbaqXrWtHvXGoCD+xnkU9Ui8uG17nixGHR6PYONzQNneAyNDHMqybzfXS8SmQL1C7PFv+i5ry6M2ggvYINt+sjnHhDujh+y67J8lGOfVB72pIgCeToi4eDfQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717185483; c=relaxed/simple;
	bh=O3IiSbAL9+Pwsd2kGX9sYJ5vsluSfA9Q60apb6/OW2k=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=aRoxumXLmB7TY+rfcOqecKB6qWOOs96SJegNVMshE2nHTyl2oUb7RK8lVdYUMf3TUJhF9U4QAW4mZ4Dt6DbPK/L78Djr/7JeAP5/98zC9j6a6PV3MT1QjLKe/Rj4k0Jlt0GwwTAq40uHLOWkXOunF+VRDtutkdRnkKx7pss+94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LC5A54up; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717185480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nl6Y8hA9tFb67R/Sjk+6a1HT3MS13bvblE3whYJwL0=;
	b=LC5A54upzm/fxk+gge4PTXu2YqJTisTAwKa3cQuo56hoJHAl/bhrdt/KOPMg7RIACURD7J
	z3FDNiQYCEg52yElm4ueMwzEbSCmmSzkQxg7FLco2YuKOr+AWRXnXf7P73erJMumPo1DBi
	NjRu3YyA/9SPdgv6liYm3wAalDF/6lA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-v7aC2X3QMqetX1FceVgMsg-1; Fri, 31 May 2024 15:57:58 -0400
X-MC-Unique: v7aC2X3QMqetX1FceVgMsg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-794ab2615f4so309209685a.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717185478; x=1717790278;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nl6Y8hA9tFb67R/Sjk+6a1HT3MS13bvblE3whYJwL0=;
        b=DwO+9QcxkX0j6s+u5bx7TSHeEqaq3ZToK7zDnXqhFM5u6mA3CWv+hXTCNvJG6cBjkl
         dsi/jv+71kTnXWYGydTGc2qN0Cz3gD1n0E9IL0EbOtS8QUg8gODfJYYzc790dmhtfRk6
         6ZZ/GhyxSjNpUKRHu0kFNUlWaMO84+4kzvpxFoRD7/7Qt5UcfLc3hz7oAkDgNGxx5DKS
         7nIOreSSvb553tjvQ3QIKfQUVW9jjPqK1pK7d3Uq4/ZqpWR+UpcOo3GUucwyn2JElsDw
         poEXPE6ifP4IHUrjaG7ualmjsEotKm3MGDJX6f4oOR21bSwBxZNkG3KFBNgoXLEQ4dB+
         rG1w==
X-Forwarded-Encrypted: i=1; AJvYcCUuquYo8lRjI34Z2QY+5LFzN7gzg6/AoO5SHA5pDWtNpnWMv2qXvmKic68GI1qlFk9f+rzvliwJkL4vvoQ9131wHwqmm3Y+eBG0gUR/
X-Gm-Message-State: AOJu0YwcKKrq98MiD3zuJyZIgyZ1Qmz0vR0jmfT9RRY7+ftjGrvJJsv2
	3MCBAFKedGyoTj+Dq373X+PetHyT85nKpAlmeISEd+Dcq4AzRG2HaaCoq3QCbchL6arTQNYeDIQ
	U3P/S/TG90NplRG17tl8suXapZEbB6Kvzq2q0zCXqmtA1JlKU85mD967Qm8OUYg==
X-Received: by 2002:a05:620a:664:b0:790:c803:7425 with SMTP id af79cd13be357-794f5c66501mr279074085a.2.1717185478135;
        Fri, 31 May 2024 12:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFADsX3LlVJp2rhbpBOhqWa6AFga5ig63FMldaWAgcXQlqM+67tY/cWC3znifvPe3kXDYXLbg==
X-Received: by 2002:a05:620a:664:b0:790:c803:7425 with SMTP id af79cd13be357-794f5c66501mr279072285a.2.1717185477559;
        Fri, 31 May 2024 12:57:57 -0700 (PDT)
Received: from [192.168.1.19] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f2f166cdsm82437485a.54.2024.05.31.12.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 12:57:57 -0700 (PDT)
Message-ID: <a93e9121-4558-0cb7-224b-550738e45641@redhat.com>
Date: Fri, 31 May 2024 15:57:56 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Miroslav Benes <mbenes@suse.cz>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200721161407.26806-1-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.2405311319090.8344@pobox.suse.cz>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 0/2] livepatch: Add compiler optimization disclaimer/docs
In-Reply-To: <alpine.LSU.2.21.2405311319090.8344@pobox.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 07:23, Miroslav Benes wrote:
> Hi,
> 
> On Tue, 21 Jul 2020, Joe Lawrence wrote:
> 
>> In light of [PATCH] Revert "kbuild: use -flive-patching when
>> CONFIG_LIVEPATCH is enabled" [1], we should add some loud disclaimers
>> and explanation of the impact compiler optimizations have on
>> livepatching.
>>
>> The first commit provides detailed explanations and examples.  The list
>> was taken mostly from Miroslav's LPC talk a few years back.  This is a
>> bit rough, so corrections and additional suggestions welcome.  Expanding
>> upon the source-based patching approach would be helpful, too.
>>
>> The second commit adds a small README.rst file in the livepatch samples
>> directory pointing the reader to the doc introduced in the first commit.
>>
>> I didn't touch the livepatch kselftests yet as I'm still unsure about
>> how to best account for IPA here.  We could add the same README.rst
>> disclaimer here, too, but perhaps we have a chance to do something more.
>> Possibilities range from checking for renamed functions as part of their
>> build, or the selftest scripts, or even adding something to the kernel
>> API.  I think we'll have a better idea after reviewing the compiler
>> considerations doc.
> 
> thanks to Marcos for resurrecting this.
> 
> Joe, do you have an updated version by any chance? Some things have 
> changed since July 2020 so it calls for a new review. If there was an 
> improved version, it would be easier. If not, no problem at all.
> 

Yea, it's been a little while :) I don't have any newer version than
this one.  I can rebase,  apply all of the v1 suggestions, and see where
it stands.  LMK if you can think of any specifics that could be added.

For example, CONFIG_KERNEL_IBT will be driving some changes soon,
whether it be klp-convert for source-based patches or vmlinux.o binary
comparison for kpatch-build.

I can push a v2 with a few changes, but IIRC, last time we reviewed
this, it kinda begged the question of how someone is creating the
livepatch in the first place.  As long as we're fine holding that
thought for a while longer, this doc may still be useful by itself.

-- 
Joe


