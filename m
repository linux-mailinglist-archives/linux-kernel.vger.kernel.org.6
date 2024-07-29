Return-Path: <linux-kernel+bounces-265422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D59893F0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0164F1F229B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1245813DDC0;
	Mon, 29 Jul 2024 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ZpxhdfW9"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5C13B783
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244968; cv=none; b=N0DwtE52itoqJ7oB9CeKNTJmesbpn3wAEmc2OvoApQzrD82bKz5vm8UkRWRZzjuy1AgHS8ljYn7J5hRTQJJJ0dops448GQit6srG6tpwhbad00aRew39RlmFPHR2Bj62X96yoCvGgMOr9oMaJvCaPov5/oEOuGDuj8eWDiPBE28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244968; c=relaxed/simple;
	bh=Y9BbDaXldNlLgOlmUpDYUDIii9dGvPaX9HZL6LpJ7mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxwSPx16s/p2ulTXmbRjfo5G8ihtyO0fGlGH3vSCldZwLtdsSmGPCPlw1FM4bM3GoKl9wjejIl+Svazh3cSKZ48yZ2ILsydQzV6nlK1InMz2URlliiXMOJcJyN2ri2zpVgpxIo2HSaQsDayiy5kAmyR8fBEbcFA5SjQgvS2u8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ZpxhdfW9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70eae5896bcso2542155b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1722244965; x=1722849765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i8EAifb5Q+Cho1w1hS5y73GUCf1y1+VSu7zJITVC30=;
        b=ZpxhdfW9X57wHjjtD6bH1sNvqIvUwO7Yya72IYVOeWegLBTUAzRfEr7Wyx20YxbfXR
         ERWWXTnB9a58PKvH+gPSdGsrQEgjs65t/o8+SXvFb7s+Htj735kJzXDiWqQbzQ/tjKZU
         dtdwkDHBxkggIa70o0EJyAU5amaQ03urq9HeGI8DsjTADK7qWT3sPSQEnz61SyQkc50h
         tKf0kq3UL7/bkoS799DptpZKcZs7K4vBwtcQv9j/iLOZPi2gX0UN1OGRVOz30Bq9NVO+
         dOIcnyUQIr1Ex8XXRrC9/cMqp1/luIN834pxM8Ba/5bFogxg/ASUu34sJyXE0gnnDEHk
         y83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722244965; x=1722849765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1i8EAifb5Q+Cho1w1hS5y73GUCf1y1+VSu7zJITVC30=;
        b=PshOwdr2GyakJNeZtrrTHTMfzRzDD34q4k4xX9ZccdlLJEm5EYsuIJ3+1fSB4RHad5
         LYQVm1U/Y5nU6liUg+DZr3uT/e45RAQx+b+y5yLpSgdwGnJQCneNNPUE4wmfjmxKXUGz
         3AErE6c3iqMKGxat+o/VhW8jLQAAVL8hktail6H2OyDqgFJ1OdvOwibs2oL/+4QgsSrO
         978W8NQvu87Mf4vB8UuZS+6eAzmy0viCDU5diWraW8tYn52vAL4W8UU85YR2LAECltIF
         kH1aOjPx/guk5PInExDQ7p6RYo5XR3c/MWmAiTwDeccSprWMwTmINZrqYl6fJ1Foq4m2
         4Zyg==
X-Forwarded-Encrypted: i=1; AJvYcCWpv3ZsbevWyBkwBki9xlhE73HlTjN6SH5VmVa075ZizYG8yOf37iX4eh+bzZwiaejzjK8LqqV4a54Qg5COGkpZs5WHNNJx9VmV7nlg
X-Gm-Message-State: AOJu0Yz+LI38+lFWzUmOUj6+yMLXURC8FIy716G7dAbi0RiMOnxhUN+3
	EDcOVwQmqbw/qvi2W3jn+yhXnLJOULFl2u2WlU3JxMBmN6LaqQqpv49cbbMIBJU=
X-Google-Smtp-Source: AGHT+IGhEUZLiACZbdBW6nXsiQfCe+UvbYtq+wii9DR50uCySyNKfbex9nS2IhnqxPoziHJ1yN9D1Q==
X-Received: by 2002:a05:6a20:9146:b0:1c0:eabc:86a8 with SMTP id adf61e73a8af0-1c4a1183fddmr10157272637.5.1722244965493;
        Mon, 29 Jul 2024 02:22:45 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28ae2d51sm8051429a91.0.2024.07.29.02.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 02:22:45 -0700 (PDT)
Message-ID: <fc34fb9b-8afd-4f83-9e5a-e648b3358e90@shopee.com>
Date: Mon, 29 Jul 2024 17:22:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ovl: don't set the superblock's errseq_t manually
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240729034324.366148-1-haifeng.xu@shopee.com>
 <CAOQ4uxi4B8JHYHF=yn6OrRZCdkoPUj3-+PuZTZy6iJR7RNWcbA@mail.gmail.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <CAOQ4uxi4B8JHYHF=yn6OrRZCdkoPUj3-+PuZTZy6iJR7RNWcbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/7/29 14:43, Amir Goldstein wrote:
> On Mon, Jul 29, 2024 at 6:43 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>> Since commit 5679897eb104 ("vfs: make sync_filesystem return errors from
>> ->sync_fs"), the return value from sync_fs callback can be seen in
>> sync_filesystem(). Thus the errseq_set opreation can be removed here.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> 
> I would add either Fixes: or Depends-on: to prevent accidental
> backporting without the dependency.

OK, I'll add this in next version. Thanks!

> 
> Otherwise you may add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks,
> Amir.
> 
>> ---
>>  fs/overlayfs/super.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>> index 06a231970cb5..fe511192f83c 100644
>> --- a/fs/overlayfs/super.c
>> +++ b/fs/overlayfs/super.c
>> @@ -202,15 +202,9 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
>>         int ret;
>>
>>         ret = ovl_sync_status(ofs);
>> -       /*
>> -        * We have to always set the err, because the return value isn't
>> -        * checked in syncfs, and instead indirectly return an error via
>> -        * the sb's writeback errseq, which VFS inspects after this call.
>> -        */
>> -       if (ret < 0) {
>> -               errseq_set(&sb->s_wb_err, -EIO);
>> +
>> +       if (ret < 0)
>>                 return -EIO;
>> -       }
>>
>>         if (!ret)
>>                 return ret;
>> --
>> 2.25.1
>>

