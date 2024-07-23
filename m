Return-Path: <linux-kernel+bounces-259990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F3A93A0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90C71C21E10
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F7B15278B;
	Tue, 23 Jul 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMkfmWTB"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9977150989
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740305; cv=none; b=KRYIp88sWFoGZNS6SGaurogRUlRS25f1KicC1Rkilzdnmjap/QQwfe1tk5oQ5xjtOfrBlwz1mvD6G8TkUo0gkQFjW7ECuGWVCo1Zl23ShIvbn6Y9A7wjCl/dsCDdoZidTqNuK7GP7wWxAVn3JZq9r6DgQ04t1QDGKEpf4xHAkh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740305; c=relaxed/simple;
	bh=tqg9ZDnn7abveVBNBGqM0xGeg6E3o4gkwa1atwwkjbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1zvUJC+t73C+A1AljuKpqPuZuPKJVRxkG8DkyHS6Tva+lERGHnO8mVMzuLJ97ekS6xEAe0wa/kBTK5oXG8IZr5nc1b4uoSIf226H6bVVx7jc920Pc0Xqc0mldDChmvaY5B0/QvgtbVp9tI60EnHDpN/Sp2ORuxUT0qs/UK/IJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMkfmWTB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so4494817a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721740302; x=1722345102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFtSsxWtRthRuaPHYKwLiagJ8YkwPf9cDZq3BkTUzUw=;
        b=DMkfmWTB0CXRF3jDelWJEQfnfSRmHjWx/8//Z6DGDYFd3bXxYxaONtypKivPgeGcCI
         nGXGVPfiUuraa7YKD53cS5mlCQPhW1vUSQzQ20uh6spKTvYX/XKUOxo1VGAlcRFfX92U
         yudNAGMQIbjM8lOtwinVuBa1VVvZ7SfEgYD8AOUO2Q/3wRz5SP7OlHZemG6gPMN4dlKX
         43Iufj5JGF4ro8oOA53hpzHwaInI3sL+0zQXP3fi5sVOtbuwxcv/bWM1NSeLjz/6suWu
         ZMs1epXuakyZG6kFNyL1frW+Qd1rFuLy+vy1UHFaYLohYWIMG4g0teEG+Ou96S6K2egQ
         axuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721740302; x=1722345102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFtSsxWtRthRuaPHYKwLiagJ8YkwPf9cDZq3BkTUzUw=;
        b=nBB4VTHqQpKcPhBKWoAC8eXqUhw21CIPBTceNU6QUjEleSrgXIp2s2xGei+4bX1V+P
         +aHaAsrLHQoekxIo9coqM2RzNo7UFcYf+mxci8H/eCtNYqX4OZ+bWKRBw+V1t3FH1OBq
         687fqNrgS5V2c6NJhVxt57pzqCNK1d2jtzn98y9iT56YKR1Za2EqXHKNmP+RHQhUTfII
         1MhpNDwvhYFA6ZgSiKRjRhYPT03Niyid0iJXRaFIjdrYthl9qF+V7E0OzieaI95UK/Je
         3iudiCRLf3EFx8rJq7bM0lkgWIajJI12VnPvExYMdi6tuqgaXaZxQWPcSgCTkqLWTnUM
         okUg==
X-Forwarded-Encrypted: i=1; AJvYcCWrTgsdGbTAoWtFDSnzQcHspSunfcJ1Lsq760Z75cIuuu6gDeAekvEgI5t/fzXtDVYspYv+tFuSD/8vL1+YszD9qf/ZXPovfNx4hjBk
X-Gm-Message-State: AOJu0Yxfs9aN8VgizjtLU82VGmrlPAEOyn4g4va/v+4x3OaSMLa7h6AU
	vpx2BK1IkTTH5YtQCEc4dgjpi1l9o+mRJoDWNw+FXZ/CAEvNgqfn
X-Google-Smtp-Source: AGHT+IECDg37JXoANp03eWcpMeYZacIl3j7qii6dBzTLX4GZA4N5VX3DGNBDx5+CRyudmU0XKQS+5w==
X-Received: by 2002:a05:6402:4303:b0:582:5195:3a79 with SMTP id 4fb4d7f45d1cf-5a3ee8a9f88mr8449710a12.6.1721740301837;
        Tue, 23 Jul 2024 06:11:41 -0700 (PDT)
Received: from ?IPV6:2a03:a900:1000:7e9:1b66:bd88:3ed1:3fd2? ([2a03:a900:1000:7e9:1b66:bd88:3ed1:3fd2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d6bf8sm7494317a12.18.2024.07.23.06.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 06:11:41 -0700 (PDT)
Message-ID: <99266e5d-de9d-4d31-a1f2-d003bddb7b44@gmail.com>
Date: Tue, 23 Jul 2024 15:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] dm ioctl: fix erroneous EINVAL when signaled
To: Mikulas Patocka <mpatocka@redhat.com>,
 Khazhismel Kumykov <khazhy@chromium.org>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Zdenek Kabelac <zkabelac@redhat.com>, Joe Thornber <thornber@redhat.com>,
 Heinz Mauelshagen <heinzm@redhat.com>, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>
References: <CACGdZYKbdyALADEMDV+Vg+eog+UjjgGigEpmJTSKw_64RM8rbA@mail.gmail.com>
 <20240717231833.2090430-1-khazhy@google.com>
 <34139e33-3e7-4895-bd4-2d9f7727e9fb@redhat.com>
Content-Language: en-US, cs
From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
In-Reply-To: <34139e33-3e7-4895-bd4-2d9f7727e9fb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dne 23. 07. 24 v 14:51 Mikulas Patocka napsal(a):
> 
> 
> On Wed, 17 Jul 2024, Khazhismel Kumykov wrote:
> 
>> do_resume when loading a new map first calls dm_suspend, which could
>> silently fail. When we proceeded to dm_swap_table, we would bail out
>> with EINVAL. Instead, attempt to restore new_map and return ERESTARTSYS
>> when signaled.
>>
>> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
>> ---
>>   drivers/md/dm-ioctl.c | 23 +++++++++++++++++++++--
>>   1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> v2: don't leak new_map if we can't assign it back to hc.
>>
>> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
>> index c2c07bfa6471..0591455ad63c 100644
>> --- a/drivers/md/dm-ioctl.c
>> +++ b/drivers/md/dm-ioctl.c
>> @@ -1181,8 +1181,27 @@ static int do_resume(struct dm_ioctl *param)
>>   			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
>>   		if (param->flags & DM_NOFLUSH_FLAG)
>>   			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
>> -		if (!dm_suspended_md(md))
>> -			dm_suspend(md, suspend_flags);
>> +		if (!dm_suspended_md(md)) {
>> +			r = dm_suspend(md, suspend_flags);
>> +			if (r == -EINTR)
>> +				r = -ERESTARTSYS;
> 
> I'd like to ask why the "EINTR -> ERESTARTSYS" conversion is here and why
> it isn't in dm_suspend?
> 
> What do libdevmapper+lvm maintainers think about it? Does lvm hadle EINTR
> by restarting the ioctl syscall? Should we return ERESTARTSYS when suspend
> is interrupted?

In general - with suspend failures - we are just stopping whole operation - 
and restoring previous state - so user can run operation again.

There is no special check for exact reason of ioctl failure.

Regards

Zdenek


