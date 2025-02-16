Return-Path: <linux-kernel+bounces-516450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADAEA371A7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 03:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB7D16F144
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 02:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEF4C96;
	Sun, 16 Feb 2025 02:00:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1D53A7
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739671205; cv=none; b=DbROj68haeY7l7mQfIYwJSOE65Nf3QVHZmrFY67VQiFtCSGy2aALWABYdl6EmDiH3bTJdj6eY8LRx1BhsMdz0mCuwoNqgbjQK6WAL03TMX2WRGb6D8+EsFIbJNqA7NK+cPAM9LYG8MCTN3rk7x6Pg+mRsXAa8hqrx3cwO40n09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739671205; c=relaxed/simple;
	bh=geyEhR8lxBcnTiGd0+6bGXiNJr/yXfXkE5/RAuz5C/o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u4P5oFBcszvjaN8x9zuZ6hCeDIWULodMsrqfhfai+6UW21DlfA465OSLzE/SXKfTgp5xg4+BHDI2EANAHG+FcIv513tRt/4EWBxbXUqa1uCG5kU2ph4BGUqvb9jPYsJV3r+i5sKFOPspHLFeGddLTzbLl0GRhJAcCHIWe5Oss0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d18fbafa4dso18226145ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 18:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739671203; x=1740276003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1li1iexV3lz4uywLPUrDR/AzPPthSRR4DBT4jwU49pI=;
        b=KLIz39fTUPH9GCd55BcGkw7E1c9JEKE2gwwtzxc2jVBcZgNxIqFlvA2bhLUhwUguJv
         UC5ZLUC0pJdsxe9RCDRg+Hkv2LitJr8qr5GBlY4NqblJNiGkEpBbTT0xqb1NpHoKgX2F
         8UUUZ8JCe+7XEolNijXk9/Un0h+kI6LeVbnVKcPkBD+WmXJLHnEgzZMZxAu7WjQNOyY3
         GTMMGLnOTWkKZV5nICpA8KtXXuAApTZxWlGAcDcPuXA4qDhKHq5kiXD6XoCp3AZ4mpNl
         dQIiTKEzxNvelcauKDNwQtCgSESwR6uJ4VIVuKtaZLGQUT/6EN4GgVuiYvqV7gqgCaBr
         tJLg==
X-Forwarded-Encrypted: i=1; AJvYcCUXg3IZYhzTghfqiRqKTiK34IFMliRsopfvjqw+TWBJSnam9H0neFUnehWMQSz55mRw6QdA4PTWah95Tn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmYZlWwl6r9qCGBOwumhCyU0DryqrDZxW6kP/5QWO8KPOQj9o
	SeJzNBcPYI9awKudWgijpZs10aHCr2McL3AN2g6FOskREs7NBLlQXvcRxtzv77bbJ0ZyqOMBXfK
	voiXQ26VCH0no2avxRGybDXogqA01cHbXbqGA/OTlg/AZepzx26H91ws=
X-Google-Smtp-Source: AGHT+IF/6xKCZ1hWj6svGPqBC32LXJw7gS4H4+xOc1wmFy65d5jQFzX1ePf7krcagu5kyLsLDVXVLpmyP7hdpoyTibFtzwuVCPfc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:3cf:bbb4:f1e with SMTP id
 e9e14a558f8ab-3d28079040bmr34286745ab.7.1739671203253; Sat, 15 Feb 2025
 18:00:03 -0800 (PST)
Date: Sat, 15 Feb 2025 18:00:03 -0800
In-Reply-To: <20250215234008.2328-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b146a3.050a0220.173698.0003.GAE@google.com>
Subject: Re: [syzbot] [block?] BUG: corrupted list in loop_process_work
From: syzbot <syzbot+c104904eeb2c0edbdb06@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c104904eeb2c0edbdb06@syzkaller.appspotmail.com
Tested-by: syzbot+c104904eeb2c0edbdb06@syzkaller.appspotmail.com

Tested on:

commit:         0ae0fa3b Add linux-next specific files for 20250214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a5d9a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c67242141a7e5bdd
dashboard link: https://syzkaller.appspot.com/bug?extid=c104904eeb2c0edbdb06
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12220898580000

Note: testing is done by a robot and is best-effort only.

