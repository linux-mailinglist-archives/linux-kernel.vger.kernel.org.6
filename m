Return-Path: <linux-kernel+bounces-306685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276196421A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357DD1C24933
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584CD18D644;
	Thu, 29 Aug 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p3SZ36RW"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04322189F58
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927983; cv=none; b=dYXEBG7mOTNpwomnqrMChQM9RELPS04dTBfWakojhEf6H9FZ6xAnIcPkCA9U6NTRlAyqxArhpNqLkP1iv/aU8sDs2IbReCp1tMKI2Mqpj/nyOu/S2qrHpA5k8o9oGlF0vNoTUkV9KSpkZJki07RJXIxbokgBxMCI2QiCPyryqcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927983; c=relaxed/simple;
	bh=H4ThLHPnoX33maHuj+G5p19yhTbbU8UuyNF2JahecVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LwRx1VLizTkaoSW46Sx+znU68ENDtRZbFxXbcm+4l6vDXBJNVA8cNJ3DsbCB4T3/8FQaARbh7pTCQJzrELc0uRDluTPomwm6g7X+rIdpFGeMuCpbG5HcxxnR4RiVnX5FFUUHe26+ZR0AMvDGO6nZv+P4qVTgGJuw8cOVb/1dbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p3SZ36RW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20203988f37so4888995ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724927981; x=1725532781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJT7cCqC9KSi/JysyxzXg5pGbqUdVqvpB8/twIOhti0=;
        b=p3SZ36RWioY/VWimRYjYeBIsgB3yTM5TpHSPYSlMUAMX4jneqJZ4l04YY5frap6DIB
         q/u/ZrTbXdNCEUXxf+qBGROxhn/0MQk5UdBQdXUxL8dObjsfPRcvYDJZNncplPgbuHoY
         smVdFPygPlGMHbQ2jH1L/4Ol2lJM5Kc0y+V8Pyo1/+IOoiCARN5YhbhxR8pk8gTOj+rM
         k42kPoefX6gnoAmnUctcQqgjBqH+WJ+5ZGiMrw7EJNVL08ToOMRrtBWHPeQr4EIpf9Rh
         NuPesB05ZO6FbmPIPpv5iishGMdU0CPFfnsxwcOKQPqqfdRW/WYI7RAgVO7pVYJ3d36j
         M0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724927981; x=1725532781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJT7cCqC9KSi/JysyxzXg5pGbqUdVqvpB8/twIOhti0=;
        b=JMv3jk4CDv1bUOSwTbzEfJCL5J/MQqgWlHS7F5XusMPhYJpSMaBf7u25BtUQ5Ns8NI
         hifXmpQBBL9l3tA1n7cydCsbdG7+rRIY4X/wTw4s5lmDWJJ7PZo8WzXEAyXpH/gPetHt
         n81TUa1hNqYIhUvFWG+buzug/j/oBsl4Zc0w0x95fUVBx63BgJcRyx1F6L3mYitUOW5t
         VsSFNviHMlthqJaF1ubwX16Q5dCwdRLcvnOaAnFCdjfnhtfvCGZiCiTZNv2czURgfrWw
         Yk+3GEc2JRpJOrv+Nj8nrIb6jgqXHNxCAHVugOP8RlBwZN3KulQC9ugDucll9BVj1nqx
         5XDg==
X-Forwarded-Encrypted: i=1; AJvYcCWQH+8uLQP1AhU01ssP0GvB8ZhOCOESpCj9BA7/0iI6G11DRNVkrvQKTijsEGMegVY9aNSCTQrd0qeglPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoyu6uFVFmPo+S5D2FPwlUVumDKul2x1NyLngNaKCBjI5suLLe
	XzvgeIuqa0L9eDDdsq+6rtCdh75zGSpOImvu/kbeem0avKOTsqpr2mhY8RAcI+U=
X-Google-Smtp-Source: AGHT+IH9Bqu0fGCXqPP5kHE33n6VLGa/iqT2gAlJIPQyRuWJXMXfjh/9JMcbV3KNyOF7ot/Nrz6qxA==
X-Received: by 2002:a17:902:dac6:b0:202:3cd0:5ef2 with SMTP id d9443c01a7336-2050c4c385amr29508955ad.63.1724927981310;
        Thu, 29 Aug 2024 03:39:41 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b11cfsm8764085ad.1.2024.08.29.03.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 03:39:40 -0700 (PDT)
Message-ID: <b8b52b57-c80b-4165-8a99-ff5f40cda41d@kernel.dk>
Date: Thu, 29 Aug 2024 04:39:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in
 ext4_inlinedir_to_tree
To: syzbot <syzbot+46b0888255f68622d309@syzkaller.appspotmail.com>,
 adilger.kernel@dilger.ca, asml.silence@gmail.com,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tytso@mit.edu
References: <000000000000d133670620c640fe@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000d133670620c640fe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 4:55 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of git:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1660edd5980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
> dashboard link: https://syzkaller.appspot.com/bug?extid=46b0888255f68622d309
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d4ae09980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158d6609980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7569f02310fb/disk-d2bafcf2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e30fee7b6c1d/vmlinux-d2bafcf2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2ffddebac153/bzImage-d2bafcf2.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/e4fb4afad539/mount_0.gz
> 
> The issue was bisected to:
> 
> commit e5598d6ae62626d261b046a2f19347c38681ff51
> Author: Pavel Begunkov <asml.silence@gmail.com>
> Date:   Thu Aug 24 22:53:31 2023 +0000
> 
>     io_uring: compact SQ/CQ heads/tails

As mentioned before, this bisection result is clearly bogus.

-- 
Jens Axboe



