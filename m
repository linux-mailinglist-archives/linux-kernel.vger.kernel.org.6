Return-Path: <linux-kernel+bounces-546030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35483A4F55D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC803AAAF1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8D015D5C4;
	Wed,  5 Mar 2025 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PrFXm5Tl"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2D8828
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145211; cv=none; b=kau8yTHt/Y1OHnMT+Y6qmQa99CEoEg565cwgaebxK2OUidFDh/ZZfpihMO4gD8eqnrIyGkhZe+2WD9cYiLjyGKULx3OJKms8Yx0gBBDu8JoBG+YfyPtJysS6OQzUmCMMdYLJlqKcKBaRCffrFa+Rl8y0kDjGZDeHrqnzeL1/Kms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145211; c=relaxed/simple;
	bh=bbEei7+FrCui96t1/FVtgiNjItcOM479XXEbS4UhfoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEY0a1n3e+RKNyfMqUpOgXJP6hU7AE2ewJk6G/gFA3Dg2nUPOZhkHfzYF+I0+NItQER+JUHr3fqT6j85T7xjgVlQ5eyfUoTOMN7s1oolIDhRqGYc1VwVBlJlB6piFybIdxLrgxHW5wFb/6cpes1yn2DCA1NjFCKiWmEyNzmKsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PrFXm5Tl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2239aa5da08so55333245ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 19:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741145208; x=1741750008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKFINBa+Q1e4WG77Sg/agAnuGFQablMbFUvpvYj4kDs=;
        b=PrFXm5TlRdgousJnXbLddtcTVkkffs8Grnn4rnARJFtlHBcnj2wXruKqgS1EtPMPgx
         IVJVaq48ut4KR9njEfkHIR+k9cK89hmf13k82HqYzXlRpXHHF45xrMlBQdM6MTOnVr6M
         8s2BDZoo8ZNccyLtThiSIVM3FZUL8M4mqKsQAw9MQbSlbIxzsyHgtFFbsMvVFNc8oPtD
         28PQDnbTfYMup1i95Z3SgGU4osJSfMKQ+HJILwhhFFPFTr3t4JLPSrFzzcfyyEoS6C8t
         dGJ1Baq5XM8nraqkOQ3sL57NFiM4sT227y4b2GY+/ekUrxkoQbASxAgJi3C4FD5cpZtz
         Ipdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741145208; x=1741750008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yKFINBa+Q1e4WG77Sg/agAnuGFQablMbFUvpvYj4kDs=;
        b=Psofuj0Nl+F7yiuKdLpG3tBG7ze95KkES5AerO15jKMsa4WtL3/9zq3i8oqq0g+hAq
         7i+lHtQwJwo+Co8esjTGh4puug3Ojc5e84lfF/0fSA/tq0dmqLzzx4di7QXgO2/KvFDA
         pwHGelapxVuwvViDyYUKZFQsYeWfC9FY3R2EymoeNLsfHWGh6JDiMvMB+ALsLTcutRUu
         MQ+0mgANtWOB8rEu16s/3+5Mfue8miDQOBIXdWHK1fmbISDUM5d6LyFAlEZ9XLhNYimN
         RrmJVCb74VavtbCFjwpVZmPdQLwj0bENe2pyk+LZSu1/qs8o8zMu2i3bGHq8fCXTF5EG
         syIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoK1tGYZ7sH5Ij3ghaeBp8bB/WvbRwBHhmZI32gx526cA49tE0se79207jTjvFn8eW8Owt8w8fG9Y+FYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZwlhPaBkoraeASG2NFJiSTrNdYjFsFFa6lELkVJ7lRwc6NmB
	jxTx+ztO15GS/f9Haq6+OHz3kE/W4MWN/PmBiNiHPtROpxpc++XxUP5WvcSDf+8=
X-Gm-Gg: ASbGnct88oR9rkkcq+XkVrc+/qnzKjny3/6qUWGSP1IR2NRzweEWsK4PosczG6PPvwI
	cNIWKDoNN77YRnVfR7cEUJizp+W0yzFX7ObtEnK5SaVGcnsOBHt4a58QthRZ6hq1XKZ9eGgKp7L
	M7W8uxkqztbQLJNNeNTODamkpzvDH77J3jXxZMF261m6gBy9ueXDCt4LHt250fPt7rrnx7ZB5FJ
	jbj50tGsLSBMkiW4D9jRU9uG/WbiErVTKABnYxTS40Ct2mhTzESDepu4PdzpqznXTnv57o372Gx
	TZ62OSxL11jWMRHe+fV2KlcTKslAescr7Epm2hiRWZTk1njoX6bqg5/sxUqarlf4PcuWDQ==
X-Google-Smtp-Source: AGHT+IGBGORdCLvFd42QG25wNcfjd3DkQHwAlOsYf+nq4bbOhvYPNGfhM8vZksdKWT1yBD7TzeaJwA==
X-Received: by 2002:a05:6a20:244c:b0:1f1:235:a358 with SMTP id adf61e73a8af0-1f349449723mr2570710637.6.1741145207973;
        Tue, 04 Mar 2025 19:26:47 -0800 (PST)
Received: from [10.68.122.90] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003e28fsm11741707b3a.127.2025.03.04.19.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 19:26:47 -0800 (PST)
Message-ID: <a2b3609c-9907-4ee6-a0df-6b4c84100d33@bytedance.com>
Date: Wed, 5 Mar 2025 11:26:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shrinker_debug: Fix possible memory leak in
 shrinker_debugfs_rename function.
To: Muchun Song <muchun.song@linux.dev>, Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, david@fromorbit.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250305020123.605496-1-liuye@kylinos.cn>
 <99A7645C-B8FB-4F28-B4B8-D5372F4C001E@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <99A7645C-B8FB-4F28-B4B8-D5372F4C001E@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/5/25 11:17 AM, Muchun Song wrote:
> 
> 
>> On Mar 5, 2025, at 10:01, Liu Ye <liuye@kylinos.cn> wrote:
>>
>> After calling debugfs_change_name function, the return value should be
>> checked and the old name restored. If debugfs_change_name fails, the new
>> name memory should be freed.
> 
> Seems it is not a big problem, no memory leak at least. The effect is that
> the shrinker->name is not consistent with the name displayed in debugfs.
> Right? But the improvement LGTM. So:

Right, so the subject needs to be changed.

Maybe:

mm: shrinker: fix name consistency issue in shrinker_debugfs_rename()

?

BTW, it seems that the callers of shrinker_debugfs_rename() did not
process the return value of the function?

> 
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> 
> Thanks.
> 
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>> ---
>> mm/shrinker_debug.c | 8 ++++++--
>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
>> index 794bd433cce0..20eaee3e97f7 100644
>> --- a/mm/shrinker_debug.c
>> +++ b/mm/shrinker_debug.c
>> @@ -214,10 +214,14 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
>> ret = debugfs_change_name(shrinker->debugfs_entry, "%s-%d",
>> shrinker->name, shrinker->debugfs_id);
>>
>> + 	if (ret) {
>> + 		shrinker->name = old;
>> + 		kfree_const(new);
>> + 	} else {
>> + 		kfree_const(old);
>> + 	}
>> 	mutex_unlock(&shrinker_mutex);
>>
>> - 	kfree_const(old);
>> -
>> 	return ret;
>> }
>> EXPORT_SYMBOL(shrinker_debugfs_rename);
>> -- 
>> 2.25.1
>>
> 


