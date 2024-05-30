Return-Path: <linux-kernel+bounces-195854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F548D52D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519321C24536
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6502C55885;
	Thu, 30 May 2024 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AqCWdk8o"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332855880
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099649; cv=none; b=hOKELFaGGlPVTXiC5AHRkdCUC2jLJoLEO3ZZBr2D8mfsWA94feAlmvoh5yBxPJm4TIhE4SFt2SkWl6PxVEvFYN7enI9iLvZjXZZxFGLivch5hPpYOgAk5L6WP7npgk2KM3i3hbYCdiydtOnPzZOx63zBqJjTXdrJSNd2dokqIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099649; c=relaxed/simple;
	bh=HAXXHdwTpWBru32oCHzyCAukBLhSQKr2SgMI3i3mXsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MUKFfCE2cxKBfdmDvj5tx0zkUqmZQeETHl3K+VIdDuFA9eF4OlLy2tvlaZMuWqiNQLUdbWNt4c0BPf97FGnWZMtkt/bN7WlxiI4oZp0qGAwJ00JUMXqnriiB11+2lU8avaEo6Lg6/Os+Rxac15h90OXVFINNdfpI+6VgFKfebHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AqCWdk8o; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f8efa3140dso54635a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717099646; x=1717704446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dBSARgAmKAsYe1CtiSsRS+cY7+7r1C9cXrxuvC0KAq4=;
        b=AqCWdk8ojh9SAOiUnFs+PDlWqsOC/dWaSNgmSxwfnYrXJDG4CSpgKFteU3X/+Uz6X1
         FarWqx5FH34nbyCy5qTsIG/VCxDHXt8CxA0QSnOEYYkFmDSCIwIo2ZA2wOryJZWshn5k
         XiPo0iCpPEm6o1aJCr9Cz+qRcE/6JGFnqEiBF4PTzJ5BSO3eWU3Lzro2zHe/bwnihWFC
         jgFpjN9xbtP9pSxYWzTiEEcbhkgJ1AUMPQsx1Q86F+EaMkTMypx9HP01OBKZcX4jg8nQ
         BpWWYKDuSWkyKyPzEEkU5LC9QMraLjVsrdE3/fITBpwnbZLHre+9a7rrNTB9xZWIChZN
         Fq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717099646; x=1717704446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBSARgAmKAsYe1CtiSsRS+cY7+7r1C9cXrxuvC0KAq4=;
        b=b9gxjuOojgtsHrJTkY7I8237nNaoEBbHvESl0U3udqQCORSwhGPuMc1vBsQxYPBBHd
         mAA4NHxJY7PaFW4YIQIvXKiA8CB/T0szkPOldRP2XAgjq6F/+a6VlyKgnETgvHEr5YXD
         yEVl/EN7nBzw3DjnLARbzx/1ruq6NoM+ObQW5LZJZWxb8wY7gd+bjjC8hbwI2A6MONWd
         QeyNTAAxjDjlP/5sK5ZiGZ1B1xFVbXb9p8YBfqZr8ZkFF/5hst6MKIQTsxBhvi1P5cLW
         ip/cFdp7XpczuHMQ31WFq3ZCTMu3mMlCtMmA+MJ8oNNbpoImHV2df1PBTFAZhEgwkBjC
         MQYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtJ1eyedIQDqGh5pwQGxjKqFUREsET1Ycp9ZHO9Ozq1tACkQC+WmFnkgTMD4UnBOHUez3N3pGnjD4x1sIvGio2UbtvWWYo1JrKk3AE
X-Gm-Message-State: AOJu0YzLnNhrxWrVB6bnsJRPWkw9bY7DSoKNKddQ33JiDUDvarhUfzAN
	IdI3kTM3YM0o1gu8DGFkW0zxJjl0TWPo5AhUCwUmja/pHe3KCLVm96TSq4i1qow=
X-Google-Smtp-Source: AGHT+IH3H1JF1ubTYtAVpRtEnZCmseFiClQElZoM6+cET5uQxNn5O9aCBCwwa4YvfgNyon8RfBA/wg==
X-Received: by 2002:a05:6830:2d8e:b0:6f9:7f8:9805 with SMTP id 46e09a7af769-6f91147d9f0mr238562a34.0.1717099645871;
        Thu, 30 May 2024 13:07:25 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91059cc44sm81379a34.51.2024.05.30.13.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 13:07:25 -0700 (PDT)
Message-ID: <f8299b20-dd92-47c3-bfc5-071f3278eacb@kernel.dk>
Date: Thu, 30 May 2024 14:07:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_issue_sqe
To: syzbot <syzbot+b1647099e82b3b349fbf@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ae186106196f6894@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000ae186106196f6894@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/24 7:22 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b9b972980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
> dashboard link: https://syzkaller.appspot.com/bug?extid=b1647099e82b3b349fbf
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b1647099e82b3b349fbf@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in io_req_cqe_overflow io_uring/io_uring.c:810 [inline]
> BUG: KMSAN: uninit-value in io_req_complete_post io_uring/io_uring.c:937 [inline]
> BUG: KMSAN: uninit-value in io_issue_sqe+0x1f1b/0x22c0 io_uring/io_uring.c:1763

Should be fixed by:

https://lore.kernel.org/io-uring/c52d9b19-7fd7-4fb1-b396-632b9f0f612d@kernel.dk/

#syz fix: io_uring/net: assign kmsg inq/flags before buffer selection

-- 
Jens Axboe


