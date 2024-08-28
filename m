Return-Path: <linux-kernel+bounces-304341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B00961E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4100285922
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE2154420;
	Wed, 28 Aug 2024 05:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h30Qarqs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B01509B3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824040; cv=none; b=IPJrWQD7wx0ZTAix9WFz9p9MCE7Nc8pH9V/G1s/lYuqlMOTStXpHTAIs7p5BRR9IKuD4qdFDABUM5GOp6xwGglK3ArA0bWdE0BJD0TrbEmGq2JGhUlG5wwt1jkkTH9sYD+Xdy5PEChrvifPbQS7bZeUKGvEuIgjyXarmd0NPel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824040; c=relaxed/simple;
	bh=RrLam6mqwyBGcfuSrxWmoW3n5YB6vJkgt4F0ExG4lRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTNOqzizbiT+4a9vl9T7smRFEVu8fGLzQUUXRGj+wLObUuVzNyB8oMtrFHl+sqzPIuftUUu3dQsVKupho/YC9MYaO/AhNHh9y4qG1sKeui0oJLNmMdfyuT/FdpahbczDWeXsv721Y+Qi8URzpZYRVSpeWqP9E0rjnd9tgaa7Gtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h30Qarqs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724824038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckZJuFCVMRgzqQidtTbaqZnRjLzSgCGjaZ05Ho69de8=;
	b=h30Qarqst2ffHmG3/zqbb1Ulb6iAHkGbPQl1dHDbWX4Kw0BekbmuvFnvU/7FQju1CkXoIL
	0daBuH/ZDryL+ffRj5OmEX+Xz+mjwz0krN5Bv2Ue3z8C3ObtGXXHy2lrOyWb4jFJMMX5pi
	yBeOVPwtPoyGJ8FDjeuirMnCa5REd0c=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-TtdCvVdkNK6zjQHRfKPKcA-1; Wed, 28 Aug 2024 01:47:15 -0400
X-MC-Unique: TtdCvVdkNK6zjQHRfKPKcA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7cbe272efa6so6012702a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824035; x=1725428835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckZJuFCVMRgzqQidtTbaqZnRjLzSgCGjaZ05Ho69de8=;
        b=ZyXtjYQ/AlkqWA1OClitJu0uA/E1FnP45Vzh3fsdpZNPBFE5SuOHrJi+mDisagDDM4
         OfDJM+dwbLfM8nNedd2ooII/5eswU7Hwa+8eILw9KPHsaGQ/c11mvs3/o+r6gEAvhBGE
         fAjQkyZ+5CkNxOYXRzDR9YNFwERNyXPlUEmuZHN4spw5sGL88J9XtAxZrd6ML2Cxhz8W
         nCw2BoZb6iqFZXb/1AEZmnnpfoBV2TclwPWdoW/mQuwLeDtebzN6V3vivoswqaLKiTNy
         WK61Epe75Tsk61ERs3QmVdGkP1C52GxBs0cCxY/CYgG7gwQeMCOCfcbeeEMFoCoYu1D2
         iRQw==
X-Forwarded-Encrypted: i=1; AJvYcCX/X/3CvcxR4CGfMP4Q92VCyWSppFuG9Y07DPnuCtY8DdQClUXFWK1vXRrEd6OKsTeW24CSiYUGSsNibjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9nNLcnwPDBDsJ0ovhJ+pkSZYjmpUph8FHRw3CSH/lYT/cqQS
	PHIKC242HT7PQihZjah6FS3PaK/Zwye6u/ZYrpzL8FFI/lT52xMnLcH7s3i2bxNNH2Y4xfCwzXn
	jZ7O93hVNXaF6CNImeR7sHdbHB1vh3xe1FC+Uj7s3g2nSVF50dios7t9FfNLzHw==
X-Received: by 2002:a17:902:d4cc:b0:203:a0c9:6953 with SMTP id d9443c01a7336-203a0c96986mr201053505ad.0.1724824034784;
        Tue, 27 Aug 2024 22:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+eoKXJOfQW0YjvLqpCE/9ty7ghlsendTsMnu/B13VMaWGHQQyiTP0Mu4p+h0BUfBvtZv58Q==
X-Received: by 2002:a17:902:d4cc:b0:203:a0c9:6953 with SMTP id d9443c01a7336-203a0c96986mr201053435ad.0.1724824034431;
        Tue, 27 Aug 2024 22:47:14 -0700 (PDT)
Received: from [10.72.116.72] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385be0e08sm91516135ad.285.2024.08.27.22.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 22:47:14 -0700 (PDT)
Message-ID: <5d44ae23-4a68-446a-9ae8-f5b809437b32@redhat.com>
Date: Wed, 28 Aug 2024 13:47:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ceph: fix out-of-bound array access when doing a file
 read
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822150113.14274-1-luis.henriques@linux.dev>
 <87mskyxf3l.fsf@linux.dev>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <87mskyxf3l.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/27/24 21:36, Luis Henriques wrote:
> On Thu, Aug 22 2024, Luis Henriques (SUSE) wrote:
>
>> If, while doing a read, the inode is updated and the size is set to zero,
>> __ceph_sync_read() may not be able to handle it.  It is thus easy to hit a
>> NULL pointer dereferrence by continuously reading a file while, on another
>> client, we keep truncating and writing new data into it.
>>
>> This patch fixes the issue by adding extra checks to avoid integer overflows
>> for the case of a zero size inode.  This will prevent the loop doing page
>> copies from running and thus accessing the pages[] array beyond num_pages.
>>
>> Link: https://tracker.ceph.com/issues/67524
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> ---
>> Hi!
>>
>> Please note that this patch is only lightly tested and, to be honest, I'm
>> not sure if this is the correct way to fix this bug.  For example, if the
>> inode size is 0, then maybe ceph_osdc_wait_request() should have returned
>> 0 and the problem would be solved.  However, it seems to be returning the
>> size of the reply message and that's not something easy to change.  Or maybe
>> I'm just reading it wrong.  Anyway, this is just an RFC to see if there's
>> other ideas.
>>
>> Also, the tracker contains a simple testcase for crashing the client.
> Just for the record, I've done a quick bisect as this bug is easily
> reproducible.  The issue was introduced in v6.9-rc1, with commit
> 1065da21e5df ("ceph: stop copying to iter at EOF on sync reads").
> Reverting it makes the crash go away.

Thanks very much Luis.

So let's try to find the root cause of it and then improve the patch.

Thanks

- Xiubo


> Cheers,


