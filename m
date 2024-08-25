Return-Path: <linux-kernel+bounces-300607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D895E5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1671F211E3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2F47F7C3;
	Sun, 25 Aug 2024 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBRBqRdH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030A4A05
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724630034; cv=none; b=XWvfq81ZIyWc5mcU1371WAsa9RNF+/j5K1BDI3nxf9+6WXVZGCSVB8ujLVXjQgHMML/Ds75r30oUyAPu/FR577hwW4OqQGGIaWMQxOswp6MrGvAV3tqVCUTT9QLn1mcPhAl1wlPcSMmI+HAvBw4KgXEZldvLE1C/+sccLuoCGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724630034; c=relaxed/simple;
	bh=/jfi1UGgEAx2E3NPgZPiSFl8NXLitbux5PTBNSOGt3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsnWcn4KWPiVprKvYrhP6Ddawf0Rdtlq1JXlr/peSaLeqdgxSPxGK4vKZ9RnndNmeBLjUmx/mgIwdD7/N7UEJ0hoDq68xEGOvAWcGU1U8dSH/evNfZUKvk65wzdbhOaSR8wYD5kHg8neY5Avs/VZcnZuvxsYZQ0K/6FM6FBWY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBRBqRdH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724630031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FW18elXa1PhYvbUZkR95eV9DtxD/XfPxDPcUtrQxbZE=;
	b=bBRBqRdHru6+8Uv8B4p8D9YUByypCavCrwuvSS4loc+usuO0Sa4bEDtP+1qjNAHOB/xZMm
	s0DvJDMQXP1zrBximl2k0QnDkgJIPE3mXQ4ggdbikh/OsZe93tyvv/32awkAlQdTemksdw
	lUGZ7eTWvTz/HYobr0KT1CvSB9bsdDY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-3XV3NYTuMtyG09mcv0xhNw-1; Sun, 25 Aug 2024 19:53:50 -0400
X-MC-Unique: 3XV3NYTuMtyG09mcv0xhNw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7141d43582cso3365069b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724630029; x=1725234829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW18elXa1PhYvbUZkR95eV9DtxD/XfPxDPcUtrQxbZE=;
        b=lzhYSNLPMtRIEE/z7BTFZzJPqR+F1q1lvZ3LaOG6+iiJb6j7OfUeHYyK6W3HlqVPV5
         YXcA8tE4av1e3sUaeLg3Z1znc7yPyYRhruBfI/kW8bMpDiiadLDs/Hzb/deryJWVoSnH
         bqZ2pzxT0+2eQC0v4DdRE1CZa3rzHRbZQrHmyWpgzp3qOmoIYgw446VcxWyMWM5SSpgi
         5kHb/FEj0Lu93Mb53RwIHfRgaHI8GNPNo0wahSAWND62X6xeOAgcA7EM0gRwvL8W//ie
         Itdh4z9jqYQ8ITX9+b1twucyFDquav50mEsS2Ie/qckkn2ydhVs1Dfd0lRMDjVelW7bk
         O3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1wL3vwtFdkURZcZmjbO29RaoUYY1M9sIyKg7PmCl4dXRYjc73j6HBtuehmJDLZqmZpMoY7p4IK7nOOrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCPrtdlY5JMZrxQhyrdTwWrLjNdMPoYngnMr1sqJz/8bcoFbkt
	r8XmMMzndOCaYVoOYBVBOJmm+QovBln0vLkUaR4W4bU5FJAOaUcOpsb2CIy+Y1nYDTX8apBPoyM
	7NuoHsSgNmAmQwapfaMQnIVsx+FGhbr0p0voAU5T/Sp5WieZmOZ3ti9KDbQI5wNFJGJHHQlvz
X-Received: by 2002:a05:6a00:2d0b:b0:714:1fc3:79fb with SMTP id d2e1a72fcca58-7144540ab0cmr7515862b3a.0.1724630028764;
        Sun, 25 Aug 2024 16:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiv9eNyjz/UETJQTU03gyC94z2vtKnzutSo7W0XpyfUyN2ZZAGiHRtFYSZYJBE/zl6rX3jJA==
X-Received: by 2002:a05:6a00:2d0b:b0:714:1fc3:79fb with SMTP id d2e1a72fcca58-7144540ab0cmr7515856b3a.0.1724630028267;
        Sun, 25 Aug 2024 16:53:48 -0700 (PDT)
Received: from [10.72.116.17] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342ffde2sm6304421b3a.145.2024.08.25.16.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 16:53:47 -0700 (PDT)
Message-ID: <d1668ff4-0aac-4727-9886-2f04c5f1104f@redhat.com>
Date: Mon, 26 Aug 2024 07:53:43 +0800
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
 <0205e0b6-fad9-4519-adec-f1d1b30d9ef9@redhat.com> <87ikvrhfa7.fsf@linux.dev>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <87ikvrhfa7.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/23/24 15:25, Luis Henriques wrote:
> On Fri, Aug 23 2024, Xiubo Li wrote:
>
>> On 8/22/24 23:01, Luis Henriques (SUSE) wrote:
>>> If, while doing a read, the inode is updated and the size is set to zero,
>>> __ceph_sync_read() may not be able to handle it.  It is thus easy to hit a
>>> NULL pointer dereferrence by continuously reading a file while, on another
>>> client, we keep truncating and writing new data into it.
>>>
>>> This patch fixes the issue by adding extra checks to avoid integer overflows
>>> for the case of a zero size inode.  This will prevent the loop doing page
>>> copies from running and thus accessing the pages[] array beyond num_pages.
>>>
>>> Link: https://tracker.ceph.com/issues/67524
>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>> ---
>>> Hi!
>>>
>>> Please note that this patch is only lightly tested and, to be honest, I'm
>>> not sure if this is the correct way to fix this bug.  For example, if the
>>> inode size is 0, then maybe ceph_osdc_wait_request() should have returned
>>> 0 and the problem would be solved.  However, it seems to be returning the
>>> size of the reply message and that's not something easy to change.  Or maybe
>>> I'm just reading it wrong.  Anyway, this is just an RFC to see if there's
>>> other ideas.
>>>
>>> Also, the tracker contains a simple testcase for crashing the client.
>>>
>>>    fs/ceph/file.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 4b8d59ebda00..dc23d5e5b11e 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -1200,9 +1200,9 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>>>    		}
>>>      		idx = 0;
>>> -		if (ret <= 0)
>>> +		if ((ret <= 0) || (i_size == 0))
>> Hi Luis,
>>
>> This change looks incorrect to me.
>>
>> As I mentioned before when the 'IFILE' lock is in MIX state the 'Frw' caps could
>> be issued to multiple clients at the same time. Which means the file could be
>> updated by another client and the local 'i_size' may haven't been changed in
>> time. So in this case the 'ret' will be larger than '0' and the 'i_size' could
>> be '0'.
>>
>>
>>>    			left = 0;
>>> -		else if (off + ret > i_size)
>>> +		else if ((i_size >= off) && (off + ret > i_size))
>> And the 'off' also could equal to little than the 'i_size'.
>>
>> BTW, could you reproduce the crash issue ?
> Yes, 100% reproducible :-)
>
> See https://tracker.ceph.com/issues/67524

Okay, Let me have a try about this.

Thanks


>
> Cheers,


