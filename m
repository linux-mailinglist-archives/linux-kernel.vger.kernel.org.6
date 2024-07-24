Return-Path: <linux-kernel+bounces-261527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9552E93B853
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6F8281DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E013AD37;
	Wed, 24 Jul 2024 21:03:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B569446DB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721854985; cv=none; b=EM8NTefQgV3uyR/z/FLnncBi2rJD0yCagxjI6lOo8o4oq45XXD/iNjdvROlNSyaW93TvN1gUu38SCWV3Evdeyi/83UA5NQc34sv6fdiN7CIk90n39OcP4ljNeYx5CIIBpjvkGYnP8bn9gFbd3YySCDsvEq39y0xV6jQxVQ5ohq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721854985; c=relaxed/simple;
	bh=dxxEFPKUPQ/vbMzaN94MYYum6W5jb5eGh5SM4Odiu5M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ao14vm+oMqrokCGNJHzhrN/y0S/Ph46BJNDQ4juWgot/oq7r8wBHrOefI/41vWXtL3gQOQqe4eKXkInpMFP2qkpmh4Qw318iU36B3qtMLMyL7LMVaSTwsCky5HfEpzcnOMe+z0W/NC+c2CcRT+syZeo81PMilpJ6GgW0ZAyn2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81d1b92b559so32704739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721854983; x=1722459783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgzWfHxyU9SajBvvdTvJiZtUURmcx2um5Z9HsNcKvsw=;
        b=g4ae67JJjVrOwi/CC3rO+3TtfFaXHO2A1GnpZqLs74RgP+1320roAuJmG6D2CjGU1F
         gSHRHL5WeB5MRxEcqJHYF/IZGPCcEgTSrIytHwKV6sJkDq/+hx0N7R1yqytWA/Vv03XU
         AztsRbYRv5Ff4iPnBFG5tOdqVFbKPayk/1JjsGW71taOTHNTRhB2x7o7k5pR3MvY0EuY
         ATj+X8E0Vp/PSCIdGBv850cz+3prU70NJbgtl0z2isuGFhoD7dJGmZGxYVd4RdMLowMl
         zDyqTYwOrUR49xq422yywVhnRL6jAeXs9fw6eNU+HrhyxAhexlkA2fr27LjNh+qiFCTT
         hrug==
X-Forwarded-Encrypted: i=1; AJvYcCWxAOx2SeJ6N3KcGI5PzyzDXdvPXKpoDiU82pRL+1ZbLKzSlZVDkFkvxP3GQ5NjGz3B4aJT8nQJC141e5HcEL+3aHLMLRko+THUaX6c
X-Gm-Message-State: AOJu0Yyb07pGAP2EPH9BdaKGGZggkmMdGEocjjD71uDA4QZqrgsHMU3T
	T6GMCbixALSC2iqTH+YMvP9MZ16Vq4ibjCdnrAxK2tWhYQrRR65SxmsoFyUTT/vHbEqwWzzZDfV
	Xs2dcGZAgEINaYpE+7XHFZbTQg9F0Szx6YGfODJJai1MS1sQvFWMrLDQ=
X-Google-Smtp-Source: AGHT+IG7ke0zyo3YDdsAQ/FJW9lT2WkYC2NwIM8te9K7a5gw62GWLOVL34BncEktMDG8ImfaCVs5qV595/3tyTwQjPE2nQhid+bW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8328:b0:4c2:9924:c81e with SMTP id
 8926c6da1cb9f-4c29b6e5a6fmr27071173.0.1721854983463; Wed, 24 Jul 2024
 14:03:03 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:03:03 -0700
In-Reply-To: <64844b2a-d4aa-4b1f-8954-049850e38c1e@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4fe65061e049a02@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_task_work_add_remote
From: syzbot <syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com
Tested-by: syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com

Tested on:

commit:         c33ffdb7 Merge tag 'phy-for-6.11' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d29bb5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f26f43c6f7db5ad2
dashboard link: https://syzkaller.appspot.com/bug?extid=82609b8937a4458106ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120b7dad980000

Note: testing is done by a robot and is best-effort only.

