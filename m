Return-Path: <linux-kernel+bounces-361750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A970799AC8B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9741F22F29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9001CEADB;
	Fri, 11 Oct 2024 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2JOYndaw"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB101C2327
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674410; cv=none; b=A9jHXjxz7Tlj2NI9fGqjEfjAhqAw3Vij9oaUhXj2RioMsjlYSa+OIig+UwIhoino7AbTGmr5HcsalHu4mjY0gF1vEvmWRzcTjAWsWvy2OdPdWhaZYixjTzIzTNvz2ar/42KA0XKdL6t8KC6plY6PDpNxEYa3ZaIOLgZyP2V2F7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674410; c=relaxed/simple;
	bh=hSO8F54z7AXgu4M0sCia6XcfpbERXrgA6aaOw9lItY8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rwu7baAYeNBvz88M3jboDB91yjnH6BvdZP3Td0jZyaURSQ2fAdI7dBPM/JBVuy6wHUafnownsQ7DQGD4hOlODaplEw7NqZiWcGkGr0L5VPpAO1y5kGFsYBm/qcKs3kTWgFbK+0ei4Ec29GCEa85hYa5JipYvaIt/rAlSniKHTDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2JOYndaw; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a3b463e9b0so4703215ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728674407; x=1729279207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oT1prsBkAd012k0Gk8qhOERI3EHQIENMfq0Ps1/4ZU0=;
        b=2JOYndawj1OT9r3sRuu/wDgZ7/zg4CnKu1TFwiDSzR1tvrh64PGLtSAga6XXHx+rim
         9/LYQM6kLtKrzjhn1Bv8RpnRIzChL7O9w+z0b4R7gSJjGRlNZT1OTgROOaI46lZYI6Ip
         fnIMWJJlIwCi752Q/v/3HvPbzVYRbCLhFbXFtvEF2pPgfP2bEIF4/ohFWqP76HomT52p
         UVzNSg6VGKgxQgU9FQJryPO2gqaxgohIaWkuiuiQwecgg5tcCWXJoBSqSpLAYeCROo9B
         9vtRQvxVHwZilDMWkW4WTjGImfXg5iaG48IUiOkrGtyo94aBbC5RdoJ40TR2OtJJ+TUF
         62gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674407; x=1729279207;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oT1prsBkAd012k0Gk8qhOERI3EHQIENMfq0Ps1/4ZU0=;
        b=tKfmUjsgaA1xPVKkry7WZBwZU/KOxUq1YBl5qfGqPiWK4cac40rn662jAA4XiciDCx
         bgRFeZo7TUmhhX2fuE3RhWol+MvauyWyJWvgliyDMKJEGcqUK2RSqDmlK6gRJFcmWUCk
         jCKwQxInJWsNzf3pOnFdh8C52xq9zU32mWHPRemTtxQVMEpEtfCp/TTHl19MwIrp6q/7
         hWifoiH8RLFgu+NlbK8GU+qPJfYHdO39oyToQIGU5J1huV+NWEKC+tA35D2CtjuQioKO
         GjL1HVVjTr7wbzSR60g2uKDBNMi4ROEP6a4qhPBqont86kEoCIDlUUi/uJvurPHPwCGS
         HmaA==
X-Forwarded-Encrypted: i=1; AJvYcCVG+/Oh/a5lGy38r4rA9D/thVfuxdPCtr9UXaWCsn+LteBABzRDa2gYcL1VU2usq8u13qcKMm2rQ4GxE/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dXUQ/u31mIKiWnVTI/Zgev/K74+NAuzM2BBySqp5Sxl9euM6
	12Vy2Ii3MiEC9T+5olitfk4TxTASkbqnwKw1MHTDEfHHnSQ7kobbtu5EjPigK64=
X-Google-Smtp-Source: AGHT+IHJCQY4S15CSNZOvjdShR1v9v5VtCIeFH4+NwizkG5m44feO3fxUOWR2boSRGMARocBXPGjJw==
X-Received: by 2002:a05:6e02:b2e:b0:39e:6e47:814d with SMTP id e9e14a558f8ab-3a3b5f1c0f0mr25160015ab.2.1728674406776;
        Fri, 11 Oct 2024 12:20:06 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada8436esm756067173.94.2024.10.11.12.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 12:20:06 -0700 (PDT)
Message-ID: <d7b91d4c-8498-49a8-86ad-27eceff18ae2@kernel.dk>
Date: Fri, 11 Oct 2024 13:20:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
To: syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, dvyukov@google.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 pengfei.xu@intel.com, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
References: <00000000000047eb7e060b652d9a@google.com>
Content-Language: en-US
In-Reply-To: <00000000000047eb7e060b652d9a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Nov 30, 2023 at 2:17?PM syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1006f178e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
> dashboard link: https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ec6e62e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11964f7ce80000

syz test: git://git.kernel.dk/linux btrace-fault

-- 
Jens Axboe


