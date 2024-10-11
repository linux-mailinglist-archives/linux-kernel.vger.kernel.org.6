Return-Path: <linux-kernel+bounces-361768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46399ACC4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD4728A62A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC481D0B93;
	Fri, 11 Oct 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rfvhGJSo"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D601D0792
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675242; cv=none; b=Bv5a35j7ls1UtcICJPvHoYwMsqpFXKeDhT1dx72a55kmwAPKxSs88KYKxU9WLgyO61tEJWCqbRkZJWgkNeNz46AI1XHZNGHmLon5oY/6VYy6e8234ielo1f3RlVhri06eOBVr81ff8p3dDUQqKNeMu3/+ySXSrnOo7ouRtH4XZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675242; c=relaxed/simple;
	bh=Mv34XoPb8SO/44r2xuX3vTXabFMKEFFMlDAUXdeg2Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYhE/eqzpUW1iueh65Iq1LqRUyTDegpnrzB3LGYThwfp6GLJ1hMUgCv8nCmuE7H8wDV81/av9h7g+zUQWcwC3j912UkXPk7bTvg50LwE4PA+ykzHNHq5FTP89R9wDQsQhwK0cGp2YKZDmuWhkT3kOY8MgJTJcA2VKPu+rKnjF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rfvhGJSo; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8354845c5dcso104052739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728675238; x=1729280038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPa1knGds+0VRhRWd4ASXUxj+iufZjH7WlsAY4DEsSk=;
        b=rfvhGJSoXczstoMXHJCk92lS6we41Ttb4QXnntY8sQgz88cXdfOgt9WUMlQ0NAu4EJ
         xlDrtxExsHs+7NBLE4oV0CVJcrnVRIAPgr7/a5bV5M6ezyv55yrZpQWf4bma4fO1sKRF
         P+NifO9VsFiCP+AXAKx5IJeTcvO2BGweGjj2u17C5zpDOK4mh0bFjDYpwIeBqF81aZl0
         lJO0SCP6cXgOMSGHagwTwPWpQMEZxZsTn6/b4j5v5SCl2YOdKv/OFxNjnARD42oLQh/v
         Lqh/kdb34rKb30BYb4eteQsCCWwH6F8oDNgu9iuOD76sHC0kAuT4FXozQLX03BHS/hUO
         6e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675238; x=1729280038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPa1knGds+0VRhRWd4ASXUxj+iufZjH7WlsAY4DEsSk=;
        b=CfwmzKvVBUScH7CaBonuxN9wT69efAREvVcRKszoQPHwECfrvBfYtzmfg2bWob3jKs
         6v8OWXgu8zNS3UN1gq8nw+LJVt/ayU6/wGWSUolvTl2P7ASr/klqCcv822zNMWburyCq
         29Phuh827WsdqQvJM/WWRpMo8NevL+OB3DW/VaL4mQGZuW7iVJNiHhyEBn9Ywb+qE9iX
         N76wZ8FN0CdOzgU83r/Nxt1mdMY0/QqVKmSBZfDmhH2CK3OY+sn3kKXdhJ8zCsijGJQj
         Okr/RSKHGpvMY+ZNWB6pOFPJ1mJvS58/wWKquKpxeXPrvxCdOfB3wmxrne88CQwgKAGW
         ITlg==
X-Forwarded-Encrypted: i=1; AJvYcCXl3OKI+ryq4pzdhabGDIngNVc+o6Qt1owIHDy78ZZbnx6zCqruNGHf1SB+xnh5qAhqDxFro7g7jnlhuVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FasSQJq0xnLfQBdU5QvOV4cD2j123YpDWFcST9xz/7OBZl3Z
	GtrB8BeIlBaVsZsdhHZrtLnm/Le5Nnv3Ou+p/s6ebOlCGp+2ogiU4E0vSs7dkGE=
X-Google-Smtp-Source: AGHT+IHvFXYmo9QvwWqf6qHcIHxAVkWhsXaFaLzwajkTLHaUWP8D5YXpsPjfxDBKjsx10d7uTxiG9A==
X-Received: by 2002:a05:6e02:1ca7:b0:3a2:5b:7065 with SMTP id e9e14a558f8ab-3a3b5fb2f71mr28962365ab.18.1728675238531;
        Fri, 11 Oct 2024 12:33:58 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada84379sm764009173.91.2024.10.11.12.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 12:33:57 -0700 (PDT)
Message-ID: <4661f4ef-44a0-402b-864b-83ef8d31f07e@kernel.dk>
Date: Fri, 11 Oct 2024 13:33:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000047eb7e060b652d9a@google.com>
 <d7b91d4c-8498-49a8-86ad-27eceff18ae2@kernel.dk>
 <CANp29Y6Zvqt7K9_LWEPQ4X-n1WOJbN0W83wx7a6GRhRFuX_OLw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANp29Y6Zvqt7K9_LWEPQ4X-n1WOJbN0W83wx7a6GRhRFuX_OLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/11/24 1:32 PM, Aleksandr Nogikh wrote:
> (minus most people and mailing lists)
> 
> On Fri, Oct 11, 2024 at 9:20 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On Thu, Nov 30, 2023 at 2:17?PM syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com> wrote:
>>>
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1006f178e80000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ec6e62e80000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11964f7ce80000
>>
>> syz test: git://git.kernel.dk/linux btrace-fault
> 
> It should begin with a # :)
> 
> #syz test: git://git.kernel.dk/linux btrace-fault

hah thanks, I always have to click the link to remember what to type.
Guess even with that I messed it up...

-- 
Jens Axboe


