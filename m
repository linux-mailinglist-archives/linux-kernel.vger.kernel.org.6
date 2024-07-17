Return-Path: <linux-kernel+bounces-255730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503593446C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8175B283375
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10B139FF2;
	Wed, 17 Jul 2024 22:02:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B97628
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253725; cv=none; b=oifDZzmf9nlFx67GimfZASSL6eJkDt3aLYK0RlW8cnXeawWllMWjWE/L2E9zQPTdnfJsCCrFoT4f4A7v1ny6NBUXgCfsQBAuvN1ZWPZXyRIhDVyYdKEgOxkwr+ZBUpjxm/XIVuQWaR64BtD6Q3RSOeIqrN2soy0u6f0U6UGxXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253725; c=relaxed/simple;
	bh=t1RYKRNKKjwkRvXjvRk5Gon+Mwt/Q8IhWOIa1GvxLBw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OElUfbxGSrAzeVqqqM8oDBFPCgkfK0A63X0PAwKdSU+IYDTgY/TjnAA60BWyxtgEiAxgjuViQIlWbBUDByOGbPK6d1GfVcwEjSrTKER8U6B28p98mNkHkDIIbsNimAI/EDAr4/nLuO5ezfhnyqYvTAE0EAbEBJN426VZw7Im1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3762363a522so1591045ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253723; x=1721858523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/r66CUcZxVA3tY/EUwYbQThd2o0wCp6U5Y10cvfxnY=;
        b=fC3IOrbw9ZmJGM+LzH+fXPd5US7GtwRNDpwMQDEbxUB0HlFaTprQ/UOUixWTvHGclz
         60wxC52hAIWJJufyR02FizyVwOvywnIw6SvJq8Uh4QDK6ATa2SpUW7kngm55q/BukuYh
         flPrAZTPw8H55J2QzT4dytdIqWnffrvI0f3BQIubYH3zU+h9QQG7CzIDteLPAMr5XSM8
         aDsNOmC9ZYFIJaiS1HkwZ7sdw+UCScrfLCE1IdzB0FdJ1haE5FoDqAe+/eIoT3jtrBP/
         Cgv82gCyflcoSpUg3OxlHfqkQDhujjYBp8h8/Tdbzj10Rbi/Dc1e0eCcIUDMnYGEge7R
         VkVA==
X-Forwarded-Encrypted: i=1; AJvYcCXOXwE60Gk8oVwDfLSgaeTMFcpQnrq8Lo+6BnNcfOhFYeLvPHW+I43eflL1gv6acdd4XrPvL18dbatlKRMCk18DXXTOxLXZjWv7GaBR
X-Gm-Message-State: AOJu0YyGKgRc0kqMlO5i1F1TrFruLpoyQc/CwulWZD+pByAcpY1GFhAe
	vNlWS2ak/gi3yyxdYeygZqWs8GVGuX9XSykqd+T0kox/0H2p9p/wLKfSGEwj3bY7JoT87YsDcMG
	KgyrkJwetsjTtngfO2QQm6O5hEelhHli4rsHGFNWGTLOZ0a3LqrsbjKI=
X-Google-Smtp-Source: AGHT+IEL7vGgibQnWLTaeitgdW93ObrEMVf90wo8xo2fEGKjh5OncJEINjy5eHeD4v61Oo2j5/boSSJ1TKwIGIR20QZGaV6o7sbJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:b0:385:ffe:4516 with SMTP id
 e9e14a558f8ab-39555800662mr1662545ab.2.1721253722760; Wed, 17 Jul 2024
 15:02:02 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:02:02 -0700
In-Reply-To: <20240717213200.1245905-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6c6e3061d789c96@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_journal_stop
From: syzbot <syzbot+4093905737cf289b6b38@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4093905737cf289b6b38@syzkaller.appspotmail.com
Tested-by: syzbot+4093905737cf289b6b38@syzkaller.appspotmail.com

Tested on:

commit:         e2f710f9 Merge tag 'ata-6.11-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131258ce980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f87f8b8afcec45
dashboard link: https://syzkaller.appspot.com/bug?extid=4093905737cf289b6b38
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168ee43d980000

Note: testing is done by a robot and is best-effort only.

