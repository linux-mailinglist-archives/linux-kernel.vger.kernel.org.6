Return-Path: <linux-kernel+bounces-283538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBA194F60E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6221C21BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA4187FFA;
	Mon, 12 Aug 2024 17:47:56 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64925569
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484876; cv=none; b=V9zUDXHIm3EvYY7CsCjg7nORxVjnLJLkfTbYy8PBN3oVcf6GRuTqcbmlkSS0h3Oz7SDYmwC8zNwA1spYPRYKtA3hGTXZJeFlnnEednRiSbsjeBiqnTHuHwZRKSK9/WkV6HzsmTmsZA9qV55QODe3Y3Urnyw1+x3P/GdZ1LrSgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484876; c=relaxed/simple;
	bh=M8QW3qggC2ri2206bkM4K7Pb25tdU6IwrX0H34GS0vs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=NIu/F/dlpgkQE2ZVOA9yZ/v3gT9WKzlNj1q/hdHUdsQFZI0tfnoAUtmJKxzqB2YpBSLE2fUskCPT3Ygs/Nv2La6QKZkWBuB4EBjpLPlelOIjB9+jz5hiEy3k4ejLxuYVBn7wPRc9qFLQXq042tiUumzxcJoyPGM9WA8Nc8n3Ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b0bee2173so63085345ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484873; x=1724089673;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVajZmucujcyrGFjdAU+EtbaLEfYU6YvoIj6x4wWw9k=;
        b=gopd33Mo6M6Tne0hOGB+z1i76Mm5t3P2tK5ARvDK4Dyz0al2ulCXq7lkDzhKhsX9ll
         aeB6v7Wmk29u99mO/rRnA+6bYN2mbcUYvgwszTuf7z/TEwi21Qn6oCIacq6LBVB1D6AL
         NBJ+vFhGExEh7gGEYQpaYlk/Rb+89Gtp0RbHdJsLbTYRVuLghS9zBc8fBu/8lZ8xeH1W
         ieyo92PCBVHMyy/z3yMImopHAHUJYuqp5EC/nuS4AJw/RZJ0FgNSXAA4ayrUE6CajPfq
         mB+1p9C/C6C+YU5qZE3In2Iii4/y4tD9W88xDRbDIqtgpFkcW7T1hmbXJrd6W0kPB4OA
         dunw==
X-Forwarded-Encrypted: i=1; AJvYcCUGbYG66ic8uZm/BfcDk/vzilZmLNmOTF+LrYQylVilZ3EZwiT0f7kwQyZMRtnOIWdp1UgW4IGDO7SPIZpun3lIyrnmlWJm0ZMuRalI
X-Gm-Message-State: AOJu0YyoldUgnakjvKrsaBjhLpCE7sYM2pUnKfk6VOy8Z2q0ex7oC940
	oT6cFPRbhwO7jaBN5uYGelQ+JopvcysDOjZ41PL4vAepooD9iivnL+6MbPmyGw7EeljSBin/tVN
	m2V6JjsmI9cU1FBKFoY4jQrVsRGmuy2LRUvg/ITjRQCip9oOnWsdUKVk=
X-Google-Smtp-Source: AGHT+IGBQjc0n0b50Y0TSAWuTbB8NEcaohrWdfb3J5xCh/d6aSCsQtY5YCA6rP8ZBm46uFQjtTr0RVEAVGkirAa+wCh8EGuIwBCc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1383:b0:376:1fae:4604 with SMTP id
 e9e14a558f8ab-39c47921d75mr741335ab.4.1723484873718; Mon, 12 Aug 2024
 10:47:53 -0700 (PDT)
Date: Mon, 12 Aug 2024 10:47:53 -0700
In-Reply-To: <CACzwLxgN3SvzGo41texhR4y8OS1n7wQM4DSpA3fTHyKbNzo4-g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac9238061f8017aa@google.com>
Subject: Re: possible deadlock in __flush_workqueue (2)
From: syzbot <syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com>
To: snovitoll@gmail.com
Cc: snovitoll@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git fetch

"git" does not look like a valid git repo address.

> https://linux.googlesource.com/linux/kernel/git/torvalds/linux
> refs/changes/82/25482/1
>
>          Sabyrzhan Tasbolatov

