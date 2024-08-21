Return-Path: <linux-kernel+bounces-294809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8745F9592F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F85A284CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127214C59B;
	Wed, 21 Aug 2024 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YXDNKMjB"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2B2B9B3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724207989; cv=none; b=ueSixlxBH9q89SdNztYU0Rbunc/Gqa9PfTEdwjtRrz5PexkLhBVWOsaaEjoFsuKL7M4lcfPyBJvAeKzYMZutGKIg3XYA5NlkDpyGNgJPgTcDQ0UFfYg7wliFCyaFJdgppA1BKApwzgGhTKVaXVehosvIyXZ4LR3Gsq+iCdeY+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724207989; c=relaxed/simple;
	bh=EtQQAVX3GwJ7qAKmImobztHO0L2sHL/F/d+8MdB/t+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LATtZmDFpOqMccyHeX+JGtxp32ccubUqXcU2/6hhGe8cFmII+zcu0LzMKV+qKdFDWQSNURgitAO84eT8qv5aLM5cxWYpfofUfjN3RJMQOu5oyZUrxNuGBzhPQk1T2O+NXF4nW1QXFDh6VjXjWMz53EjVYzsjePvncc/we0kWwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YXDNKMjB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371c5cbc7c8so40236f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724207985; x=1724812785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzqNjKXw4GB1hmL31K3QO0CK6YmKcJ4/8qF1DvRA9zE=;
        b=YXDNKMjB9Q78mpgpLOa3SIA6O6yib9amWpf247DarF2baUV1VoGTZm3ro/x6MSyJEa
         i3nPzFGNA9Q9Xa1Op7NTe8pUF3p2UeaeA9wX9RHZyOc4/l7IMlG0KE3Zu1GEmabsUtFP
         MhCDb9eOchbkkd8leGd/6jBXQ9qCb0doqWTnJsJRIx+Sy7sgO8PrFNA+KGp9bGtAExE9
         Im6eT81PIMWTQt4yESPu4e5SyfaTlzRM729Mr1eVGOjDKav8/EFD1fHfeXEPtAcDc+D1
         wIgmTDNXsN3z27stylh0afCQMJ/UInQfFccVxNNFS3OIaHGb3gnVY61PulF5yj+wEfCp
         DS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724207985; x=1724812785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzqNjKXw4GB1hmL31K3QO0CK6YmKcJ4/8qF1DvRA9zE=;
        b=aQR/kPykjTR1tSsPD72TdCl/d4UxDFrUq2qWq65S763G2sirIzirQCBwLNCes2tKy8
         3h5cAJS432K7MTB1jCj4K13wCvmSI1obHQ1X9ae0bi9PqLbQB9IF6U1Z6icF9T7/U4f3
         tdG0mAyyw4EIOZhyNIwBuygBmvlzLNlxdZaMUVFJxXQYhnYxNMniiydbM3Grp3uU8qLC
         S6xQdHuiIoSk4kwCIYVZJvjMYasZkocS0hwbrpVtSEm25ddbcG8juUjrJNF/FaOiYXHY
         wCXkYGeR6ey6aPwbAlmqKM8TGgIoE0VcyTHXF+v2WOqV4BsLXqy/Iat7FZWswgPVBc5z
         QeQg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ70BySMw94vlgUuJDUQeLQ7MY0E+vrDE9ONwD7vCnWiSlPChg/DjiMSGfcXs+D3VvVWjh5QhlK7oSlSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDPAEaIOb7iXOFTOxi4joeZR/Pb/EmFy87/fyh34XeZhpxHxr
	/QJ670m54nRkI95eY4wpfVOjTvweRy++vuGQDkJrHO5zKG4h89QOU3AA8Oe4Ny84y9FacgSfYF/
	t
X-Google-Smtp-Source: AGHT+IHYJCrabfqoq6HEID/rZUxdkVcto5JDM35M7hdVtQrhH1CDWQhq+BLjTnVh81pXTal/OhJwrw==
X-Received: by 2002:a05:6000:178b:b0:35f:2f97:e890 with SMTP id ffacd0b85a97d-372fd4d3feamr271662f8f.0.1724207984217;
        Tue, 20 Aug 2024 19:39:44 -0700 (PDT)
Received: from [10.202.0.23] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbd9d72sm383568a91.49.2024.08.20.19.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 19:39:43 -0700 (PDT)
Message-ID: <7d0d7bbc-6265-4f60-ba2c-a9c15771e95e@suse.com>
Date: Wed, 21 Aug 2024 10:39:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] ocfs2: Fix uaf in ocfs2_set_buffer_uptodate
To: Joseph Qi <joseph.qi@linux.alibaba.com>, Lizhi Xu <lizhi.xu@windriver.com>
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <980b3f4d-f265-4eb4-96a3-8f1a75588193@suse.com>
 <20240820094512.2228159-1-lizhi.xu@windriver.com>
 <20240820094512.2228159-2-lizhi.xu@windriver.com>
 <7da687ce-ffb7-44e3-bddc-d5c2f4f48c95@linux.alibaba.com>
 <416247e6-5da7-401c-815f-a4cf8ae37d51@linux.alibaba.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <416247e6-5da7-401c-815f-a4cf8ae37d51@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 10:34, Joseph Qi wrote:
> And this is not a UAF case, but NULL pointer dereference.
> So I suggest change the subject to:
> ocfs2: fix possible NULL pointer dereference in ocfs2_set_buffer_uptodate

I agree with above too.
I didn't care about the patch subject in previous review jobs, 'UAF' is not suitable.

-Heming

> 
> On 8/21/24 8:08 AM, Joseph Qi wrote:
>>
>>
>> On 8/20/24 5:45 PM, Lizhi Xu wrote:
>>> In the for-loop after the 'read_failure' label, the condition
>>> '(bh == NULL) && flags includes OCFS2_BH_READAHEAD' is missing.
>>> When this contidion is true, this for-loop will call ocfs2_set_buffer
>>> _uptodate(ci, bh), which then triggers a NULL pointer access error.
>>>
>>
>> Or it may simplified as the following:
>>
>> When doing cleanup, if flags without OCFS2_BH_READAHEAD, it may trigger
>> NULL pointer dereference in the following ocfs2_set_buffer_uptodate() if
>> bh is NULL.
>>
>>> Changes from V2:
>>> * Make the code more concise
>>>
>>
>> This is not the right place for changelog.
>>
>> Thanks,
>> Joseph
>>
>>> Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
>>> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
>>> Reviewed-by: Heming Zhao <heming.zhao@suse.com>
>>> ---
>>>   fs/ocfs2/buffer_head_io.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
>>> index e62c7e1de4eb..8f714406528d 100644
>>> --- a/fs/ocfs2/buffer_head_io.c
>>> +++ b/fs/ocfs2/buffer_head_io.c
>>> @@ -388,7 +388,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>>>   		/* Always set the buffer in the cache, even if it was
>>>   		 * a forced read, or read-ahead which hasn't yet
>>>   		 * completed. */
>>> -		ocfs2_set_buffer_uptodate(ci, bh);
>>> +		if (bh)
>>> +			ocfs2_set_buffer_uptodate(ci, bh);
>>>   	}
>>>   	ocfs2_metadata_cache_io_unlock(ci);
>>>   


