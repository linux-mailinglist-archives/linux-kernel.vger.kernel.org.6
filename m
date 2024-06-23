Return-Path: <linux-kernel+bounces-226410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD4913E01
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22E8281BF1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D560184138;
	Sun, 23 Jun 2024 20:18:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86218412F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719173908; cv=none; b=jp1c9WTNhWzGavvQPbIzgXDOqQNrEYVarUgXjyn86B5oqM6Ikd5LnWqxJpuq+myJtivvuz2nh+baiqeggj0SsKvnv1IW0TL4vV+pGEwY6cCJhOjsGR7kyiuoWBvtM5C+01roL5Pc6kEUkINkBhk44nm1E0kYHKpf12eUI4AC+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719173908; c=relaxed/simple;
	bh=cd0tb+ZdbCDpzItL02MK0AHFm7T1X96YwmC6Vn0N7wA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=L56GRQk7brWe2+TKh/P4LprWEz5XtsXulQ1HtOZONEjTK617S44SEk5+IGvnALysEDaRNq/HqNSslme9SF0VutaVAzWeL0KvFOZDElBuHofpEVqG/19VOmVJQpSZm8gMrKVxxRlAw2EqeGMt1HTUgfrC2JIq9L/vIv10/ZVdmWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3762171acdfso49255885ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 13:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719173906; x=1719778706;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EcEYhRwNSOuWSR2fGFFDXWmYaqzsr2Dg3K5WDNGzDo=;
        b=nRsVZKPFTG5h5MVZCQrpJPe8UY0SzfodNZzZF+uFFL19zP9G9Ex6gT78z2kFBKsh2k
         DrSpr9IwETTOj/jHbprYDavzGC5rBkB5qO6pvRkAO91P+ummw7XvaImEmT+TWTCwFa6L
         N9tCnbuBL2+VOajmMPGMZH5HfpLCgAVam2wQ4aAh9tEyy0/ATY70vgAj6dzqz7CExEUz
         /j8+ZLRFWZi3EE82V45dEPaE9W93fuUtVQrln82cY4o/t+n+LabU/hA1vZY63yMsdevq
         mw67Osx9v2soT4v/Bcz8rFLU3AtQ7Ubqn7Id3/IzoJfGiloJ4JFuosbVTWRhHlmfxL2q
         J48Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd2uY5BW5Lp+Rj7/fPeju0icVC2hCXnRdGXYAgxcTUNVeXZ9qwNBGcUb+g7wQqKic0yvMuHYSQV/OphVxXHsBTwwAH6lOZNIKZSsRd
X-Gm-Message-State: AOJu0YwOBX6NQNyRM61WPOIwbtKH7p1FTfQDaiOQk7V8uuIUmUELXiiz
	d1Oe53ugFgWvmtEGN2MI7ErTOQTxUxiGpy4xmHYwLUQDr+vt3z+e5Rs+/LF+WtVizkOWwJYJSE8
	PknysezbdVY8m5f/rmmanM3iaaax6n8WW/ThB5bZOMU3sU+0GdrtDVAE=
X-Google-Smtp-Source: AGHT+IHhHZCqYrBhfM1km99F0I8lhQO9j9c5JZPykEWOeRLgokmU/OuqSRyvwLHn+QuDZwWpMZuotSw4FkSRKiqT57V5JguOXd+1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ab:b0:376:4523:7ab1 with SMTP id
 e9e14a558f8ab-37645239518mr2192165ab.2.1719173906503; Sun, 23 Jun 2024
 13:18:26 -0700 (PDT)
Date: Sun, 23 Jun 2024 13:18:26 -0700
In-Reply-To: <CAF+NbmYxG-PC9tTrwDV0uFwB+1Ubrbqut=ywk4JDKC2ATAaW=g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001275e061b945e20@google.com>
Subject: Re: KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com>
To: jain.abhinav177@gmail.com
Cc: jain.abhinav177@gmail.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 1

> 614da38e2f7a
>
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1510,6 +1510,8 @@ static void nci_rx_work(struct work_struct *work)
>   struct sk_buff *skb;
>
>   for (; (skb = skb_dequeue(&ndev->rx_q)); kcov_remote_stop()) {
> + if (!skb)
> + return;
>   kcov_remote_start_common(skb_get_kcov_handle(skb));
>
>   /* Send copy to sniffer */
> --

