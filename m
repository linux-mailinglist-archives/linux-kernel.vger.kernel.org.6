Return-Path: <linux-kernel+bounces-379057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2319AD91A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFA61C21AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CED1F931;
	Thu, 24 Oct 2024 01:09:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D805848C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729732171; cv=none; b=RYR1mG6MrTGuB+yNP2JFW0ZP9TOfw4tBR5j5mnul6/dpYLQmZHD2oUX6xnqSqPEAgxq1h+AvAx99pmIpIUxTURYjjsWWHmqaa9FdtN5RqhNowcqBl3hdpoarWeHsCCEM3KIBAN/ARCkMNfsKinlkloUjCsICGP9VyVEA7Qy21So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729732171; c=relaxed/simple;
	bh=HXSedyll0zUob/iSQa3vzIJIpeDKSnTBya/awTCb3uo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=HeNwGYHP5LdcPLq/cC1c+MuHOLCjbl3ZHajOKQdcL7aXR4qrB0nAmmzbBz8We4TCW9M1wTTKTfNLVqzZpOEP4z6qEMV06WLmBmZQG6hj7PvPTeU5yJ9Kwqh8pHYYftPvX4cXiWeiuVO9s90kCO9W2isEeA1xK0fHavdHMHCtMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c70e58bfso3742965ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729732168; x=1730336968;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KRAh3F/P5bzU1VKjWCGfcpzaYz7AB3FXZckYh8UHaE=;
        b=mP370WgEapEQOKdrXgG8N7P9QiZg3CgV9WX+1aAHMazNkL94h3fxDICy/3QMIr5T14
         kxXXAAWMcBMyw+ZzxZPBKda9kBfrPHyqXFZnitiEO7P07sBzMXS1+04mrm4q+TM7xV+s
         fit0aPb1TCu8Y3HWXok6gYiskNsVaMGSuprNfHvFjo7NWG0NqPbX1N8ZqR6FWmk51aJH
         oaQVtWIjDPin/bG5NyEtZFDV27JOXKf7uWjUf8WXkWV/jjC26tLjunNRlIiJ2N4TMvp2
         lRGg4beadOxWqjiEUFW51pWBVvSJFVm+N3MOr+W+MAbET2+iUMddpeZYGDdEKu5+wCb7
         /7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXVOts3xCqDJPbjdQqUp9OyJksHOGtvq/IXzT50gCFthg1R2R2+0+tzq2WsQWxXCsklzyhVmnL9gyukSHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rQBfLzMqNJeCaRechrusaB/1WobK+ZDrVGJtnOlfi21zQ0dd
	7PvqmBnIdvC6yqZwYqc30IIczQIR6CDHGRhKhu3jmSEcYxu7dViJdyybp/IjuvM7UiplRD6PPSc
	lqo2zQYJHH0++rdv/0ZuJPLyaw8OolkJXU6J5gNNSNntwEWxDYWQ+OLw=
X-Google-Smtp-Source: AGHT+IETRKJ0+mN+4UFq6/PeIRWhiACmIhuIHFK+LqJHjWqzKsADChuGH21FMH5ixwPmCz5JZ7aFXSx8iF/Or5TTaOEgWIHLEaKt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b08:b0:3a0:8d60:8b7d with SMTP id
 e9e14a558f8ab-3a4d595f23amr50809875ab.11.1729732168482; Wed, 23 Oct 2024
 18:09:28 -0700 (PDT)
Date: Wed, 23 Oct 2024 18:09:28 -0700
In-Reply-To: <20241024010924.908879-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67199e48.050a0220.10f4f4.01d5.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_reconstruct_alloc
From: syzbot <syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com>
To: lizhi.xu@windriver.com
Cc: lizhi.xu@windriver.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> #syz test: upstream

want either no args or 2 args (repo, branch), got 5

>
> diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> index 55e1504a8130..717c1a80de20 100644
> --- a/fs/bcachefs/recovery.c
> +++ b/fs/bcachefs/recovery.c
> @@ -95,9 +95,9 @@ static void bch2_reconstruct_alloc(struct bch_fs *c)
>  	c->sb.compat &= ~(1ULL << BCH_COMPAT_alloc_info);
>  
>  	bch2_write_super(c);
> -	mutex_unlock(&c->sb_lock);
>  
>  	c->opts.recovery_passes |= bch2_recovery_passes_from_stable(le64_to_cpu(ext->recovery_passes_required[0]));
> +	mutex_unlock(&c->sb_lock);
>  
>  
>  	bch2_shoot_down_journal_keys(c, BTREE_ID_alloc,

