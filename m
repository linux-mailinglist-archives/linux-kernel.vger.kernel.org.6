Return-Path: <linux-kernel+bounces-539861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9F3A4AA05
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8C21746B7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4AE1D54C2;
	Sat,  1 Mar 2025 09:26:37 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D21C5D79
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740821197; cv=none; b=RIL381Xrxw6Z0j99WAUfEdLpHIKf3z/bC3Lo/WulxGxVXw7MHMlqEMBZstjcTZ5huGnJzc4nLlfjPWhnC9MlXOi5wsLJhzwCNv3xodmKXoVRtIteJ7/quGClsTVwymbti+5UDoEa8vZW71aoLqFKr8OuWvlVFu5Z6BP+PZGOGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740821197; c=relaxed/simple;
	bh=QJaox352Ycg4ji4TTT6HqLTFL029xkbI/FSW0iYv+zE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=eAJ7oFKGE2VkWQdcBF3QKtTzEQI77JAC974J91uhBQcilcmdzxdedN8QcOaOFTDG+0xlzS+S9OiZJvSRzLlq66efXtIrX8lWTzhJii7I4tgUP0HCPxW6gwVTQXwsrbIvXiRy+qZ/uaXeWXMWGxC65pdNMdp5IDfdLqHodMN7MzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d18fbafa4dso29253925ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 01:26:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740821193; x=1741425993;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cTUFcfA4nD0TA+byzfmiBfeOCVzsCiVGYn6UQ/fn7U=;
        b=EXG2jLx3EzX8BiG1wXxslklgnNsONOCcrjunzF7fSUZlymWKEOGTEE7pSkjSbxktcN
         2h1HyYOILODoIYvbch6FC5Ffesh7yIc0T5rSTJMbJhJ+M86dpPTzRiHyBGmNtLQyG4rv
         Fu1i502eEMcstqZ1XDmSdL0GsWwxLbEEoJ57OQdzE6ZffPhBYO+mLHxZTSFFITL/ShuY
         E7exIpeXXePHvYbVuq+Ffec5tlTskkL/9EnLfCPuZn5+n7vt+4ptqedOr+kxUM/4ebj5
         F/Os8y1wzdzEUQALAwCPrDrmtfhc1s6mB/UV6RaUBWk/LlGPDc3nEe1spVzm7XC61pEu
         To6g==
X-Gm-Message-State: AOJu0YxOOCUptnjV00Gu8ALMyc0ZgQKa1NnjehX6qbTqnH3ALywOCMEP
	bplcTLsMCPj8bfWOYMvCno/Mvi9A+2sZ0wdQZk7w0lm5w0ihPhs7Ip5aYhFjjukzVJ5KCQ78Z4z
	FZu7B7Y/minu1VkybasxLmU4WYPykYOMgvctMrb697mXKWGsfHxC/bZ4=
X-Google-Smtp-Source: AGHT+IHJw9ko2BtcVjE0Kpc25vlmUqs0Y33A2bsVGXQEK1thpAJlaYqlI1kxhQiFKP2rRdl69DFfNsMyuO+HJ8ENh4PIkKA3wZTx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1906:b0:3d3:e11a:3a8 with SMTP id
 e9e14a558f8ab-3d3e6f3cf76mr57538475ab.14.1740821193620; Sat, 01 Mar 2025
 01:26:33 -0800 (PST)
Date: Sat, 01 Mar 2025 01:26:33 -0800
In-Reply-To: <6610cdb8-072e-47fe-b9bc-f4f5b9a79f8e@quicinc.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c2d2c9.050a0220.dc10f.0161.GAE@google.com>
Subject: Re: [syzbot] [sound?] BUG: sleeping function called from invalid
 context in snd_card_locked
From: syzbot <syzbot+4cb9fad083898f54c517@syzkaller.appspotmail.com>
To: quic_zhonhan@quicinc.com
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	quic_zhonhan@quicinc.com, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

>  > Hello,
>  >
>  > syzbot found the following issue on:
>  >
>  > HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
>  > git tree:       upstream
>  > console output: https://syzkaller.appspot.com/x/log.txt?x=14e3d7a4580000
>  > kernel config: 
> https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539
>  > dashboard link: 
> https://syzkaller.appspot.com/bug?extid=4cb9fad083898f54c517
>  > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils 
> for Debian) 2.40
>
>
> BUG: sleeping function called from invalid context and
> raw_local_irq_restore() called with IRQs enabled seems can be
> fixed by below change. if it is valid, will arise the PATCH.
>
> #syz test:

want either no args or 2 args (repo, branch), got 4

>
> diff --git a/sound/core/timer.c b/sound/core/timer.c
> index fbada79380f9..5290c1b9f2b8 100644
> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
> @@ -767,6 +767,7 @@ static void snd_timer_process_callbacks(struct 
> snd_timer *timer,
>   {
>          struct snd_timer_instance *ti;
>          unsigned long resolution, ticks;
> +       unsigned long flags;
>
>          while (!list_empty(head)) {
>                  ti = list_first_entry(head, struct snd_timer_instance,
> @@ -780,10 +781,10 @@ static void snd_timer_process_callbacks(struct 
> snd_timer *timer,
>                          ti->pticks = 0;
>                          resolution = ti->resolution;
>                          ti->flags |= SNDRV_TIMER_IFLG_CALLBACK;
> -                       spin_unlock(&timer->lock);
> +                       spin_unlock_irqrestore(&timer->lock, flags);
>                          if (ti->callback)
>                                  ti->callback(ti, resolution, ticks);
> -                       spin_lock(&timer->lock);
> +                       spin_lock_irqsave(&timer->lock, flags);
>                          ti->flags &= ~SNDRV_TIMER_IFLG_CALLBACK;
>                  }
>          }
> @@ -805,14 +806,16 @@ static void snd_timer_clear_callbacks(struct 
> snd_timer *timer,
>   static void snd_timer_work(struct work_struct *work)
>   {
>          struct snd_timer *timer = container_of(work, struct snd_timer, 
> task_work);
> +       unsigned long flags;
>
>          if (timer->card && timer->card->shutdown) {
>                  snd_timer_clear_callbacks(timer, &timer->sack_list_head);
>                  return;
>          }
>
> -       guard(spinlock_irqsave)(&timer->lock);
> +       spin_lock_irqsave(&timer->lock, flags);
>          snd_timer_process_callbacks(timer, &timer->sack_list_head);
> +       spin_unlock_irqrestore(&timer->lock, flags);
>   }
>
>   /*
>
>
>
>
>
> Thanks
> Zhongqiu Han

