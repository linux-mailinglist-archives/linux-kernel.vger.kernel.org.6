Return-Path: <linux-kernel+bounces-210145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386CE903FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347911C23DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6422574F;
	Tue, 11 Jun 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KoCMf8Bv"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED212110F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119402; cv=none; b=ZCOrZxNAi99OW+tuPm1zXySXVp8MLzSQ+jJmxYiBXC4BiIY9YvI4LpukT3/lPvXuMuvQstr0VOkUjz1rnY6sav9F5AmCTDIH/vmbaeOkusZLBx+FXL730Fbir+ftWEGfAvyXiUcOA9wleMt98TwJMsFDz/GHoEiS7aE1Zslz8oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119402; c=relaxed/simple;
	bh=ZEJOzWLv67Lt9koj3wAP6SNyrkJMfABaIM3Sukt+QDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUpGBu0frxjZ23rXt1z6u+/9n79d9lRhDNBT+6o5l8zQ6oysjkZJymv6KTPwOHEcN8eXQ2abrqdVvHrLmdbiPGT7edCcuWZJ3tgsTILp0IWnAqOZ+DJZna+S+20+eO8t49D8tO08Knd8KMFoURMzV0FkV9h+L7MnTpyrQkEvYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KoCMf8Bv; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfb1ac0f03cso231002276.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718119400; x=1718724200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdCqb4jwOd5pvnTn6Ox/jiqyDLoaZHnkqS07QEcqzS8=;
        b=KoCMf8BvvVkBBxeWOcoScOs/UWAWHnNp8zu801CsFL/f9NUM3eW/fhXwJVCUe+gcEC
         AZjZ5W+mUPaZyZyxfXcQTjHmR2K3Bth4FFMGTDGAu+4F2l3WDYf3y++XuIQcwGBkm9Fs
         LNJC79ntThtW9/bEvE3vz0oPT//eF8Dbyepww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119400; x=1718724200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdCqb4jwOd5pvnTn6Ox/jiqyDLoaZHnkqS07QEcqzS8=;
        b=jhxHu+qv/38mZpr9s1836p9jUO9GdJzfTbE4JF5uEtxNwBWrEL0SEnPu+4JwUXK9IG
         IKSzSQcGgH/WqvwgqkDUhMKKnRk9V66GUa1ZSZdhzGreWmFS+mEFvrlyfnt5+uJc5t0q
         5tBQJ15pmf5XzRJeqDI3AEiM19m/xWrUZBEXWzESlY/wlFHiXKwynifSNGo2pPE2U32p
         r9cJiC0vNNeWqgO6jRi+wXFXFj8/mBCLIbEGV3tjAilef5JMx7cBcTpZKB5dDExjGxrE
         8K8YswTeUey9nLw6kx4bJyFUI2S0LzzRpT098ZqX9kY08wYQJg54fg9z1EL8ZCVoc70E
         K8cw==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZHObIJxYRH+xzZtVVaKraseTaLzfPrAOJrJetE863hdmgwjqJrb7FhoA+DvaEZ9qxVh2vWPEUWzKxbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIPg1b2e78uo6aEZTVAQhNuN/jG7y4AKfHBVptZqmH2Wq7Zk8
	vV+QBo0f9Cuc0llH5R76Sgr6AERRHKyREuVd78ePvMegYhQGu4nkJGRS9vnP27I=
X-Google-Smtp-Source: AGHT+IForU65yRH2mMmwK2Lm8iJCItX19a8sBLN/kbwf7a2g2EOmV4suGjU+wzNEWJkCVA6F0nsC2g==
X-Received: by 2002:a25:ab2d:0:b0:dfa:fcb9:8201 with SMTP id 3f1490d57ef6-dfafcb983admr10061824276.6.1718119399856;
        Tue, 11 Jun 2024 08:23:19 -0700 (PDT)
Received: from ?IPV6:2607:fb91:213b:a129:544a:cc06:ea0:4045? ([2607:fb91:213b:a129:544a:cc06:ea0:4045])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfb0823b4f8sm1469795276.47.2024.06.11.08.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 08:23:19 -0700 (PDT)
Message-ID: <61f322f5-8b4b-4f5b-8226-e44846e10c09@linuxfoundation.org>
Date: Tue, 11 Jun 2024 09:23:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: filesystems: fix warn_unused_result build
 warnings
To: Amer Al Shanawany <amer.shanawany@gmail.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240417184913.74734-1-amer.shanawany@gmail.com>
 <58e0539d-423e-42e0-9ee4-8fc8e1eed94f@collabora.com>
 <0910d537-c2e8-4932-8b0e-b5ce381e1ee1@gmail.com>
 <5dfdfa17-d3b3-408e-a8a6-b8dc0756eac3@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5dfdfa17-d3b3-408e-a8a6-b8dc0756eac3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/24 05:17, Amer Al Shanawany wrote:
> On 5/4/24 19:17, Amer Al Shanawany wrote:
>> On 4/19/24 18:41, Muhammad Usama Anjum wrote:
>>> On 4/17/24 11:49 PM, Amer Al Shanawany wrote:
>>>> Fix the following warnings by adding return check and error messages.
>>>>
>>>> statmount_test.c: In function ‘cleanup_namespace’:
>>>> statmount_test.c:128:9: warning: ignoring return value of ‘fchdir’
>>>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>>>    128 |         fchdir(orig_root);
>>>>        |         ^~~~~~~~~~~~~~~~~
>>>> statmount_test.c:129:9: warning: ignoring return value of ‘chroot’
>>>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>>>    129 |         chroot(".");
>>>>        |         ^~~~~~~~~~~
>>>>
>>>> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
>>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>
>>>> ---
>>>>   .../selftests/filesystems/statmount/statmount_test.c | 12 ++++++++++--
>>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>>> index e6d7c4f1c85b..e8c019d72cbf 100644
>>>> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>>> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>>> @@ -125,8 +125,16 @@ static uint32_t old_root_id, old_parent_id;
>>>>   
>>>>   static void cleanup_namespace(void)
>>>>   {
>>>> -	fchdir(orig_root);
>>>> -	chroot(".");
>>>> +	int ret;
>>>> +
>>>> +	ret = fchdir(orig_root);
>>>> +	if (ret == -1)
>>>> +		ksft_perror("fchdir to original root");
>>>> +
>>>> +	ret = chroot(".");
>>>> +	if (ret == -1)
>>>> +		ksft_perror("chroot to original root");
>>>> +
>>>>   	umount2(root_mntpoint, MNT_DETACH);
>>>>   	rmdir(root_mntpoint);
>>>>   }
>> Hi,
>>
>> Can you please consider this patch?
>>
>> Thank  you
>>
>> Amer
>>
>>
>>
> Hello,
> 
> Could you please consider this simple patch for fixing build warnings for kselftest ?
> 
> Thank you
> 
> Amer

Applied to linux-kselftest fixes branch for the next rc.

thanks,
-- Shuah




