Return-Path: <linux-kernel+bounces-361839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D639299ADA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878C11F240B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CE71D1311;
	Fri, 11 Oct 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LJrgdAqD"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33D1991DB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679428; cv=none; b=YzmsqX0R6wEYf/COop88/gj1n+gB6K8URCOhjxumqlB4xwEnspwQe7q5N/RiWWG7IGNJIFk9vuzLh/sulnm+5W28IXZBvIRl0ErGMNhngZY6pXwnwrMDN/EP3yifV0Sf8Z8uMWLZsLZbzLP1xkiZJqqECrOUreHxTm0NOxQlfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679428; c=relaxed/simple;
	bh=E2JU9n1dMZqGRtOK8MkMT3CODlIBMZ1NutgbicfM3B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvoHKVuMhPGzyMBLVIzWWkyElDA9b2chEIDz72ILneBMoxc065nbtl1Dvwa9ZeGAvTnlzNzRCPO5mZTfagjj27y8hArZtI8ADHRFk4jZI3T+E6qLKxV0LD98IjYCQjXV3XcNx+BgiID31aTF/PGTdc0ivOMzmsN6a5fHvgb6DTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LJrgdAqD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e9ad969a4fso1752526a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728679425; x=1729284225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fjOSIOVoS9iV+9IyTbnrQoIAd1WAV+Gp+FipOumIyI=;
        b=LJrgdAqD1DruXoTZ7eCUKlIPONnoK/Zg93/T8ooLmQ8YG32RaFu2RCiE9NRBVCr2wj
         AYxcTh6UggiWN5ENJEFRCGVGy8aUyChX4JpbXznD4F68wAm8/n/6lcN++g68Kjf1eyli
         5HANillc4+Or4l9Cx+xF4B3ulcZhNDGeFA7lmAr0A7ugqS2Jgtm4K7/wwebfdGgnOKIz
         ANE1lxnON760VGE9VyXNYVLtIeYyKdvGDU0oJp1lbKBfPnsHBHdefYLEvd1v9Lyux4+V
         XERlrv2OS/eNFh055f1LC0miYZWSEBO7zskLDFXi/L2wlO0VhSgUDP8TArdshzMrViYM
         tNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679425; x=1729284225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fjOSIOVoS9iV+9IyTbnrQoIAd1WAV+Gp+FipOumIyI=;
        b=PIjAZadC0UErtVsSK6dPkKOpSaczldkwt2ahWt/ttn7H8OEvYeDCl+RcC/fKg985BR
         vZc4Ny/tcoJnOvhpK7DfopPxMukrYPLTmmU+bVcXCGrbtpeeqQmB7PXigPTGOZ15sP/y
         Pty2kbpXm3JPGqkttza7DU3la2EST1zhBHLXmoVFSXNJt55j8Rx9Gp1BWfF2/Lwt9WXN
         4i32XnU4e/4f/SdKV5sK+mDgWbunlolbAIEelXwbrBC1vB8Z+zzL1QI/U87PryKtrbk8
         7EWBPQTalGDcseiDZ+0wAJnfVbbQkn5ww+8ytnMaGlF7OV2L3ocGfn7rRy0HcA5wXemA
         qeDg==
X-Forwarded-Encrypted: i=1; AJvYcCUO2TSyodQDH8R4eZJextQoVoJSxg+H3V/g+XtyLN2LXlmtRKquMGvpLL/F4+1MFZlGTwdoDZgj5Eprn+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyhhpPFHjOxVPH+sZL8aMV4NDPnmyQ/9zC6Upwsa8AgFf8u5lt
	R7I77J2alYo5KzmUKhhAEpO7QuH2UPFBrfr/QKb9tg/QLK8MKMk8yr7Ups6TQB06zvAjzBognro
	8LA4=
X-Google-Smtp-Source: AGHT+IHCn6+awvw92uNuYQw4hacFpLyBgIPV88AaKB4lSsi2GN1JPrJQg+fD4Q4AnVP5uvyJZiUaSQ==
X-Received: by 2002:a17:90a:e2d7:b0:2c9:5a85:f8dd with SMTP id 98e67ed59e1d1-2e2f0aea0fcmr5310470a91.18.1728679425051;
        Fri, 11 Oct 2024 13:43:45 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2e6ef1ad0sm2711939a91.49.2024.10.11.13.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:43:44 -0700 (PDT)
Message-ID: <4b163281-7b7e-444f-a1db-a14b24afed30@kernel.dk>
Date: Fri, 11 Oct 2024 14:43:43 -0600
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
 <4661f4ef-44a0-402b-864b-83ef8d31f07e@kernel.dk>
 <CANp29Y7HT=+R-J9tL2v0Ekebe7eKMAPccmf73jLfMa_-7myCaQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANp29Y7HT=+R-J9tL2v0Ekebe7eKMAPccmf73jLfMa_-7myCaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 1:41 PM, Aleksandr Nogikh wrote:
> On Fri, Oct 11, 2024 at 9:34?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/11/24 1:32 PM, Aleksandr Nogikh wrote:
>>> (minus most people and mailing lists)
>>>
>>> On Fri, Oct 11, 2024 at 9:20?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On Thu, Nov 30, 2023 at 2:17?PM syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com> wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
>>>>> git tree:       linux-next
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1006f178e80000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ec6e62e80000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11964f7ce80000
>>>>
>>>> syz test: git://git.kernel.dk/linux btrace-fault
>>>
>>> It should begin with a # :)
>>>
>>> #syz test: git://git.kernel.dk/linux btrace-fault
>>
>> hah thanks, I always have to click the link to remember what to type.
>> Guess even with that I messed it up...
> 
> FYI we've begun to include a small cheatsheet of the main syzbot
> commands at the bottom of each syzbot report. So for the newer reports
> you can just copy-paste the commands directly from the emails.

Ok question then - if I just include the patch inline in the email, what
do I type? Or does that not work?

-- 
Jens Axboe

