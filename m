Return-Path: <linux-kernel+bounces-318881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0071C96F492
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7513E1F27E0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E621CCB30;
	Fri,  6 Sep 2024 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AObLpjQg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6B1E511
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626906; cv=none; b=fsXQctlJN1oJGL6jFSbXSaQHEBr9K2A/Yck9aP3NyMk5Wi4xkTTmLUvDP6tl6NHhLWah2tjW+jpUnyi4WKKCesVhFjh+f62xdVhftwvOR2n2U2+FIXILI7Fw8icCJpa47kVDFMtO6NAfVhC4WmW8/fHscDWYYafqlbw+DbndBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626906; c=relaxed/simple;
	bh=1YwdWI4SxTBGk0/J0qjYGGxIvNxBjfDUb5Q4hu2E1xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xnx8c+u0R+z0xuIPkdU8xP2jzI0Z5n1140mfVU5jzIdYbAN/44lggzDW/VqC/nV32NkOclWAujpD+jim9rFbIq4tG2nbpIJ607IvKjc/YkE1XYADMZNN7ZSx88ueP2u5EQIQ71FU7sh6YIBCwqlIoLRY5v/8+I9ctVmUrcWr8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AObLpjQg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725626903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMckFxnNPflZ4rNmGcRAMslCYWQbbH8yLwun1LJ+Z5E=;
	b=AObLpjQgTzxCBd2gaJ7IwT1XqPrFkSItwnxR5Yvr2xqQrOwn7kqk8oJgMTBZri8M//WPQE
	wftvSpWYYwn5vM1PcZmJTmNh9QC/rWlN5aoxRx9w50UqnerhpnYdPmhcmJuzVWvDKlectQ
	xKRMiAPmJE1fonjrrU9dEPhFJiVLC1E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-TtJcYmx_NSyhFfm00M4LDA-1; Fri, 06 Sep 2024 08:48:20 -0400
X-MC-Unique: TtJcYmx_NSyhFfm00M4LDA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-205428e6facso25388025ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 05:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725626900; x=1726231700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMckFxnNPflZ4rNmGcRAMslCYWQbbH8yLwun1LJ+Z5E=;
        b=G9LRFTQdNEC2LnT18dkHvvxZzIjVLXCgbYhH6aj/LhimvOaWcm2ovI+ZwCUUtaQ6cg
         PGxakCMIzVkYedjKCnOoXarnUorC+7Xz22Z/wz94yDvuCwJiNy3dEvul2e4o2/XpZkWr
         yvC/ysDHqSlcF9oVasLlvmzomNeC4Qfyj5VhHpYnk76HrhGarQBmXYZd64jdCLWmL4+Y
         5/Rk0pRCmE5o1kMM9LCEdohOaZhp/PxcS4t3mh9YXOoI/IPpiGhUZW6cQAQ12oqStpbm
         QfODlcoyobWJUaEV4hAtU5f/aLWX73bcEdrJT7JICrlDAPF++m/aHo5EFXvtHIFeiHud
         wqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkyh/Q8lGoV04PFQTAvTRcvvHYSIVr8yccyEbw6t3TXPeAGrCy8tsa6HbyISMDx5QwFocE2jv6U8I+h4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5vfOFnWXi4Rag4yhuqWdzGRUAB8E5gEa9sc/eawb//RQQ5504
	pIKdt4E6lFOVKsu2/g3q5bCJo5ON8r5ovpglL+dP2/GTDWFOKkETvOlJm6yiZo+BEK8n/H30efY
	W0ubyiTB1+3/nd11VJ6RzqsYULNHvkc4c62SCPdiIAUJkzyXee6t/oAGOFV+cyw==
X-Received: by 2002:a17:902:db0d:b0:205:4885:235e with SMTP id d9443c01a7336-206f05b1527mr26207435ad.39.1725626899731;
        Fri, 06 Sep 2024 05:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFZJ24dg0qGHkaTDQnzkspR+EyM42irNnK7ogdIDDHMh5Ocbubbi1UyEH0axueQD5eFz3AHQ==
X-Received: by 2002:a17:902:db0d:b0:205:4885:235e with SMTP id d9443c01a7336-206f05b1527mr26207235ad.39.1725626899386;
        Fri, 06 Sep 2024 05:48:19 -0700 (PDT)
Received: from [10.72.116.139] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea37b03sm42926865ad.178.2024.09.06.05.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 05:48:18 -0700 (PDT)
Message-ID: <bb7c03b3-f922-4146-8644-bd9889e1bf86@redhat.com>
Date: Fri, 6 Sep 2024 20:48:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] ceph: ceph: fix out-of-bound array access when
 doing a file read
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905135700.16394-1-luis.henriques@linux.dev>
 <e1c50195-07a9-4634-be01-71f4567daa54@redhat.com> <87plphm32k.fsf@linux.dev>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <87plphm32k.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/6/24 19:30, Luis Henriques wrote:
> On Fri, Sep 06 2024, Xiubo Li wrote:
>
>> On 9/5/24 21:57, Luis Henriques (SUSE) wrote:
>>> __ceph_sync_read() does not correctly handle reads when the inode size is
>>> zero.  It is easy to hit a NULL pointer dereference by continuously reading
>>> a file while, on another client, we keep truncating and writing new data
>>> into it.
>>>
>>> The NULL pointer dereference happens when the inode size is zero but the
>>> read op returns some data (ceph_osdc_wait_request()).  This will lead to
>>> 'left' being set to a huge value due to the overflow in:
>>>
>>> 	left = i_size - off;
>>>
>>> and, in the loop that follows, the pages[] array being accessed beyond
>>> num_pages.
>>>
>>> This patch fixes the issue simply by checking the inode size and returning
>>> if it is zero, even if there was data from the read op.
>>>
>>> Link: https://tracker.ceph.com/issues/67524
>>> Fixes: 1065da21e5df ("ceph: stop copying to iter at EOF on sync reads")
>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>> ---
>>>    fs/ceph/file.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 4b8d59ebda00..41d4eac128bb 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>>>    	if (ceph_inode_is_shutdown(inode))
>>>    		return -EIO;
>>>    -	if (!len)
>>> +	if (!len || !i_size)
>>>    		return 0;
>>>    	/*
>>>    	 * flush any page cache pages in this range.  this
>>> @@ -1154,6 +1154,9 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>>>    		doutc(cl, "%llu~%llu got %zd i_size %llu%s\n", off, len,
>>>    		      ret, i_size, (more ? " MORE" : ""));
>>>    +		if (i_size == 0)
>>> +			ret = 0;
>>> +
>>>    		/* Fix it to go to end of extent map */
>>>    		if (sparse && ret >= 0)
>>>    			ret = ceph_sparse_ext_map_end(op);
>>>
>> Hi Luis,
>>
>> BTW, so in the following code:
>>
>> 1202                 idx = 0;
>> 1203                 if (ret <= 0)
>> 1204                         left = 0;
>> 1205                 else if (off + ret > i_size)
>> 1206                         left = i_size - off;
>> 1207                 else
>> 1208                         left = ret;
>>
>> The 'ret' should be larger than '0', right ?
> Right.  (Which means we read something from the file.)
>
>> If so we do not check anf fix it in the 'else if' branch instead?
> Yes, and then we'll have:
>
> 	left = i_size - off;
>
> and because 'i_size' is 0, so 'left' will be set to 0xffffffffff...
> And the loop that follows:
>
> 	while (left > 0) {
>          	...
>          }
>
> will keep looping until we get a NULL pointer.  Have you tried the
> reproducer?

Hi Luis,

Not yet, and recently I haven't get a chance to do that for the reason 
as you know.

Thanks

- Xiubo


> Cheers,


