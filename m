Return-Path: <linux-kernel+bounces-318741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB2796F265
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EA41C23D02
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9B1CB154;
	Fri,  6 Sep 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFlIG761"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBBF158866
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620902; cv=none; b=Qa0uVbG6aYq1IRASTzgg83q3KglYJH+eoFm8eG/WF5l3J70/xAYQwaXODbMIWZ0LFTMDDZ5LjBvKXgTKIl49O3qakWzBd9ZkDmzkx1274oyfzXOg9sWzdg373VLkA8PqDo8iNuZxXHhX0DKPKxWBqD0DtaScKUjt38f3C7IWU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620902; c=relaxed/simple;
	bh=sp0PUDAHe1LsU/dOmTDXh3aVroBfNkbAwF5uny+G8t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UR2RQ9TMVoj/k8mChwk+6efLn5JPj/14/nkE1YFCzvOeuzOe9GG9VGFHln2L2xQFuDCD4OT66zRbfaJxBJZe+V4djJOnzLd1sudapMl2rYYmkp2C8q7p4PMSX0jfNtXBc4HURivjlwtq5M0E6sFyH5U5wwYmqkbsAPZEW19hAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFlIG761; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725620899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79koLWnyiuAx5HyyaWgllpA0MrCbe47/Wj72Rbix7Q4=;
	b=cFlIG761O9ZSPBcLI1TxhooxqhOpOpqUoCLLFtkzXKW7OPKsP7TMwxIZApQKS+H7IR8Mxm
	XPDux83FfvBSFr4IxisTgxeXygbYZCZmlxI2Mvo9oCkh2K+2B1oLMPxw5bXogySCCvDRRe
	DkOQbv7tRwqGgNU0uTulklRhcpUtMa4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-_GlKVYNXOdKeKbxysZRtVg-1; Fri, 06 Sep 2024 07:08:18 -0400
X-MC-Unique: _GlKVYNXOdKeKbxysZRtVg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7d50ac2e42dso1683560a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 04:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725620897; x=1726225697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79koLWnyiuAx5HyyaWgllpA0MrCbe47/Wj72Rbix7Q4=;
        b=fT8a1XqbAD8DlVgiffoI5Tc4vgA82lVsb1Q5ct6IB5SqcgxKM2V8SnE0dcSbmcjm+j
         ifBNWePIDYb69hdpsT4J8EKUfUioCRNMIqRn6o8iYPEjROYnfn1ChTILi6c9Lo4DE6ri
         FIhmlnJSbVG1BVCJNJbVnUtahEl0iR0rHLwutHlFky3cYcdU2qA415IstBNp2GNdTVMW
         yRvHPQvkpZsgAnO19zFcOZBAuSgTDvBrLAw6QguZC3sIggnkREDUO3dOzk/B+VejGCNQ
         InFoTmagEVXqo0iFgOrhtvLBtkSd4j0AyTuGqJ3Iu7dZ4bhAwe6hFiiEeu52vFqQb9rw
         hS+g==
X-Forwarded-Encrypted: i=1; AJvYcCUAjK4QaVFdb1oQLVYiRN4Gv93/tAb/7udkmf9XkZI7gZvxXQE9DxoYgh8MecnkGz45nU0Y/Ha4cO67J1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Kwg0bwoHoKHsTqGI6hTCO0oFptiT0JAVqFdf1/YBYD0dn6Rr
	XHy7+e5gE+oMze8cTyTWJ5O21ujt7hZiyPCmIivHl8hhL5NhcEGlX9n4d3HgCMrcZe+uDruA9kX
	IDAPYwkKKV9Aoa+h1K5RYAOUYdaJX0q2gMULrUIqgovscGBZ2SGKR0iCOhOOR2Zp+L40vMOj9
X-Received: by 2002:a05:6a21:3414:b0:1cc:d7fa:6ea6 with SMTP id adf61e73a8af0-1cce1097977mr26799891637.35.1725620897412;
        Fri, 06 Sep 2024 04:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtKTY/hCl1nyjS6JBFEmeSyv2RTFm26yXsWM7GeAxmMrle/6nQKgr0nGSKHT/1r/DGWZJC9Q==
X-Received: by 2002:a05:6a21:3414:b0:1cc:d7fa:6ea6 with SMTP id adf61e73a8af0-1cce1097977mr26799875637.35.1725620896996;
        Fri, 06 Sep 2024 04:08:16 -0700 (PDT)
Received: from [10.72.116.139] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd84e73sm4055976a12.11.2024.09.06.04.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 04:08:16 -0700 (PDT)
Message-ID: <74b48c13-712b-40b6-be1c-a79803aee07f@redhat.com>
Date: Fri, 6 Sep 2024 19:08:12 +0800
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
 <87mskyxf3l.fsf@linux.dev> <5d44ae23-4a68-446a-9ae8-f5b809437b32@redhat.com>
 <87y14gy7ge.fsf@linux.dev>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <87y14gy7ge.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luis,

Sorry for late reply.

On 8/28/24 23:48, Luis Henriques wrote:
> On Wed, Aug 28 2024, Xiubo Li wrote:
>
>> On 8/27/24 21:36, Luis Henriques wrote:
>>> On Thu, Aug 22 2024, Luis Henriques (SUSE) wrote:
>>>
>>>> If, while doing a read, the inode is updated and the size is set to zero,
>>>> __ceph_sync_read() may not be able to handle it.  It is thus easy to hit a
>>>> NULL pointer dereferrence by continuously reading a file while, on another
>>>> client, we keep truncating and writing new data into it.
>>>>
>>>> This patch fixes the issue by adding extra checks to avoid integer overflows
>>>> for the case of a zero size inode.  This will prevent the loop doing page
>>>> copies from running and thus accessing the pages[] array beyond num_pages.
>>>>
>>>> Link: https://tracker.ceph.com/issues/67524
>>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>>> ---
>>>> Hi!
>>>>
>>>> Please note that this patch is only lightly tested and, to be honest, I'm
>>>> not sure if this is the correct way to fix this bug.  For example, if the
>>>> inode size is 0, then maybe ceph_osdc_wait_request() should have returned
>>>> 0 and the problem would be solved.  However, it seems to be returning the
>>>> size of the reply message and that's not something easy to change.  Or maybe
>>>> I'm just reading it wrong.  Anyway, this is just an RFC to see if there's
>>>> other ideas.
>>>>
>>>> Also, the tracker contains a simple testcase for crashing the client.
>>> Just for the record, I've done a quick bisect as this bug is easily
>>> reproducible.  The issue was introduced in v6.9-rc1, with commit
>>> 1065da21e5df ("ceph: stop copying to iter at EOF on sync reads").
>>> Reverting it makes the crash go away.
>> Thanks very much Luis.
>>
>> So let's try to find the root cause of it and then improve the patch.
> What's happening is that we have an inode with size 0, but we are not
> checking it's size.  The bug is easy to trigger (at least in my test
> environment), and the conditions for it are:
>
>   1) the inode size has to be 0, and
>   2) the read has to return data ('ret = ceph_osdc_wait_request()').
>
> This will lead to 'left' being set to huge values due to the overflow in:
>
> 	left = i_size - off;
>
> However, some times (maybe most of the time) __ceph_sync_read() will not
> crash and will return -EFAULT instead.  In the 'while (left > 0) { ... }'
> loop, the condition '(copied < plen)' will be true and this error is
> returned in the first iteration of the loop.
>
> So, here's a much simpler approach to fix this issue: to bailout if we
> have a 0-sized inode.  What do you think?

I saw your V2 let's discuss there.

Thanks

- Xiubo


>
> Cheers,


