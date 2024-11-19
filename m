Return-Path: <linux-kernel+bounces-414477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358199D28AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D5DB28A09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133E51CF2AE;
	Tue, 19 Nov 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ONhr9nXX"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DE21CDFDB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028158; cv=none; b=Xy0mMuloDU3UHgux86+dGMXB8McNunw8M5OGla5+U+GR7YmBeKJ0ETi0p2Z4/OPWWb2/2tkB0DKhJKFaAAN9B2lwN/tkcLIoFJ3DEJNmDdpKEWfRd0kZpF5vMpWG+FuMTxdfDccPXOn2aZx1KkkYbuMUD7O+p/gUlPXYlayBB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028158; c=relaxed/simple;
	bh=OxVU6fdvRJM870VsECfjhS9jC8VVGbQfVK/nb2bH0oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYtHchqU8IiXGJKoucQS8hN1iAmC6AkeY4cUwRXiVdHqArXDX4GTXnKzCcPC3HR81sv2qlvg1/jHTEE6c6rjEiVK+GF15+BQaR32LhO3v1jUhEuEHlHRprVS3O5GUBi+QEZOSuUyerXsjs0EhIkNqH+l7JvfePMW7RyQM8ao+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ONhr9nXX; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-296b567bc30so201896fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732028155; x=1732632955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LktkAfw5nudE6nbrJhBTzWsrFqXjzNWNBN7QeProhEc=;
        b=ONhr9nXXl/GNIVIsXNX7aOZFj5/0YRzBc1vBUGl7zlVfu3cr5gmjw8jyGTpa7TkSgk
         EG17P8mwQrm4TnWayLIn7XXsXIn4KQszq1Xm+S4lvL/CmmTR/TPDTEHhm1s4aZ2OkcVv
         7PEtWn5mLZBOy42VLs8G1W3FTKMWwDzW2XWNFDECH9E4huhnhkPvzF4ny4xTIWhXOR93
         GuDEsf3zUMbkbkcmHXwnkBXG4hU8rv+Ldb6BK0K9fynJXloXslxIPODZdNafdyZBY5Sk
         eJbN+T/RqwfwgOO0PEvk7/fxpDfblm7I6ywZAuSM2irNgzivFHdtZRduGT64v21QQDgG
         QYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028155; x=1732632955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LktkAfw5nudE6nbrJhBTzWsrFqXjzNWNBN7QeProhEc=;
        b=H4qfqBgKvK2uYgnqFUdLmxV94CUHhy2nfZRwQr9r1XEllbAQxiwdv81tneLyvVVq+9
         RUhA4N3FtQPmxqG1pNN4URJ9dvWt0ADjxSyVczHd4AQBIYxOgpjJPSO0tSdwFp7e59UK
         EKc9JTBSOD75YF9ZhasYMRXD4OreM9l4s/MIAAMtOBEWSVFsjL6v6ydF6gHQP9N7fDqI
         xmxxJCUSswJKdstc9TMNfr3sTxZVEdYRbKxD6JZJ987VX1K0UTT4vybIlKPqB+TGlfW9
         pFQIZKyAMxGgbZmhAfKIv8M3Y2G0x1MIYfi5ukfQZU1n99vAwf9C6loryl/LMvaO4/sn
         E8hA==
X-Forwarded-Encrypted: i=1; AJvYcCXK2I26PHGfW32rmUZDErsOB/AfyloP187LX5m39ls9h2yGwQwDv9pGlk/Z772B9moKzemivbYGHL92Qaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBzbt4rOdxDSp0lfIKf0KLKiSvjs0RLiZx1wnjKiUY8sOQDiu
	js6L3EwbXlvD8bGDzc1dqHSEt0odreG7jFeciy8H6cs51RgwaWtQmsMKfYG1ALU=
X-Google-Smtp-Source: AGHT+IE8qzEXfnTPzwb0PqKCnhNPR5defBoMubruiOmwQhR+ZOIqjwCGNRFKeFF3MSKLGnJcwhDaZQ==
X-Received: by 2002:a05:6870:32d4:b0:27b:7370:f610 with SMTP id 586e51a60fabf-2962dd498f2mr14226298fac.10.1732028155354;
        Tue, 19 Nov 2024 06:55:55 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac87cfsm3523543fac.39.2024.11.19.06.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 06:55:52 -0800 (PST)
Message-ID: <85d1c1bf-623e-4b93-9e60-453c0bfa7305@kernel.dk>
Date: Tue, 19 Nov 2024 07:55:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [exfat?] possible deadlock in fat_count_free_clusters
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com>,
 linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
 syzkaller-bugs@googlegroups.com
References: <67313d9e.050a0220.138bd5.0054.GAE@google.com>
 <8734jxsyuu.fsf@mail.parknet.co.jp>
 <CAFj5m9+FmQLLQkO7EUKnuuj+mpSUOY3EeUxSpXjJUvWtKfz26w@mail.gmail.com>
 <74141e63-d946-421a-be4e-4823944dd8c9@kernel.dk>
 <87wmgz8enq.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87wmgz8enq.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 7:46 AM, OGAWA Hirofumi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 11/19/24 5:10 AM, Ming Lei wrote:
>>> On Tue, Nov 12, 2024 at 12:44?AM OGAWA Hirofumi
>>> <hirofumi@mail.parknet.co.jp> wrote:
>>>>
>>>> Hi,
>>>>
>>>> syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com> writes:
>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
>>>>> git tree:       linux-next
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1621bd87980000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a5d8c609c02f508672cc
>>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> [...]
> 
>>>
>>> Looks fine,
>>>
>>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>>
>> The patch doesn't apply to the for-6.13/block tree, Ogawa can you send
>> an updated one please?
> 
> Updated the patch for linux-block:for-6.13/block. Please apply.

Applied, thanks.

FWIW, your outgoing mailer is mangling patches. I fixed it up manually,
but probably something you want to get sorted. Download the raw one from
lore and you can see what I mean.

-- 
Jens Axboe

