Return-Path: <linux-kernel+bounces-226407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C03913DF8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37106281904
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B242184139;
	Sun, 23 Jun 2024 20:14:42 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410E364A1
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719173681; cv=none; b=ogUoky12JjNKBqv4HGI/H8JBuxuoOQbHfc2A7vHHr4Zt03rr2yHlUC4pxUfqK2V/qbT6XKQiQpjmNfVbZJ2VQwRNawNb0z78dxJvzpN6fr7o5b/OCYkIS0m16JZDMY0gHugd2GHUdysc8OkeXDwo/qgvUGM5jc1dO7N/q9kT8ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719173681; c=relaxed/simple;
	bh=FSKipD7cHC4WSSpgaCBSZHQhigNEYwvqozYjy/Hb9X8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=P/GUtjwLHH2aH00MdlubBCjPm7zqasmAeP4FwYQPr0aFzIsDyfc/rh06Gz6tb0My37J/WaxBG+CZOy7iR9EHs4iBVw1N8lBA9bgESF8p4WCxm3m7bMl5qCK+ZjcblQNuVuxuAI7vGL3SkOCs526AKUNEVa/R0LXwPi0V8DQvWhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-375e45a4110so44226615ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 13:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719173679; x=1719778479;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tMg9LYLzLm4VJm96LT1UiY+12xRPI6bDv1tX8aVPS8=;
        b=B5bHcFyCpqjC09FmUHaEzyiHU3nydMIX8uGkoGGF3IFcZmiQXIMGelai0c/Jh8uU/0
         x1BDrrgK07U2ZU4i4Cu77HB4h6H24o+4YQuAdA0RQlvR4p8CIw2friKoKVUTVcp2M9Qi
         W6uUKW2DF27amWi7famxjUfbkHtIXODgNFob47l2jAo68yJ3Py2BDLNIsGuJ5FxuAKNk
         CSGvFhYbyb7p6qY2mIkEX6XEXB5jwfs1zZ3zuVvjht9gCZjNPq3eI4iNxqULgSv5Yi7H
         AkcxT+hINU7cGkf1VgBBO85S62FfiQRvK3zApLBkZZRJLI4eBr0FzPgPqZL3C+9LjV++
         7Btw==
X-Forwarded-Encrypted: i=1; AJvYcCWjZSKN4Vrb+If+3IPxucMsxFI7F0GaPi20uvjWd8BJpBtz4CJrlUKeqUBB2+vYJdnikNVkJ1O4xVphg6N73S35uir1xaboCNchtXGs
X-Gm-Message-State: AOJu0YwkEV15eMEjvHOAvq8bQOKtJcOxZnXX+Rd9QdEZGR0cl+PIxJ9m
	SDAkN06a0664VdVxTXFOj9oID/W2Ha4fqIEU9hxx4qiUs5WrQc/MP2Hnj9pO47PYG5yyzGHghIM
	ghcSAhTRs+MiVuPRsNRD9TTkA6/4yEfnLm3tLr14lsF33kmerM/HbFpQ=
X-Google-Smtp-Source: AGHT+IGTaggorNMy9W1qpcEVVHjCiDIINbq0kH7ResX2z8nGtrwyp0J0PNQjvOTQgZStriGxBtqJgTcYe/wjr+FiGG9wFjrv2M7F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:36c:5520:9597 with SMTP id
 e9e14a558f8ab-3763f70d037mr3164415ab.6.1719173679551; Sun, 23 Jun 2024
 13:14:39 -0700 (PDT)
Date: Sun, 23 Jun 2024 13:14:39 -0700
In-Reply-To: <CAF+Nbmaes3th4TE693Ryo2QE1psuBvKnLxOvPsuKjYL0EbSNoA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a250c061b945025@google.com>
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
> --diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index b133dc55304c..507b92e4978c 100644
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

