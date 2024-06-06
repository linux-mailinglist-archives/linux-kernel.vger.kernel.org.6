Return-Path: <linux-kernel+bounces-204399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EAD8FE83C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9117C284704
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76412196447;
	Thu,  6 Jun 2024 13:55:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDAB195B2D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682106; cv=none; b=FGxZDJwwvAfhicGnMnUIOb8vhCUhkV93LA3UpKQ942pmBeKXrUpMrAhKnYYjuoAkhoatM9eAwhIoOI+wJTSh9IMM/DAL5KIqTlAGU7ERiptuf9tMoT4MufP5/6Ie+JkG5pOkWBKsKAwDDTz19lPfKWHpfHZaprVDlo5a66VkjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682106; c=relaxed/simple;
	bh=9/fEbcg7dfJgnfXC+UMHR6OcrZ4cg92jkOd0SWRAmRM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=La13geZeVELO/wxkQY4Y0Z85e8BemwrK8bYTeALhXXxKaR3p4pe56JrIeYZC3l8MH1cIW/J9gB6+fGg7byhW+hT6ahtQdJRBeDLOB055CGbZcduOdC9sgHJsZyEKgTbkcjXIlKa3q8ajHE5Stxi///0Lq2GjhGnt6dLlwB4YtSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3737b3ae019so9321655ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717682104; x=1718286904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1r2B/6enEEUWfwOTUI1gkxoZaOyGekIUT203Nb5ufw=;
        b=Aa0SGLY2uDvMA4jBHbpjVeNxZ3Ak9Etcm1rvoQIyVFRThFsARBB3BvLLZQGWR0qdAk
         R+VQ0Sv0Bk7SymAh48bpSZWZzcnZxmZbZZGMrHCVuqDdk+8Ylvo4yiNrt3CdOLfsBv6L
         AwDZc5pLyzdG2QSuhVqZozEr32zSOaHpzAq9fdCu2mW/wNjuTiwS5nfe3Azq3c+WMipU
         7YeYcABj9jSOi7d7mnxELbTUA97KN7TDWyrevknEiPRnEe3w9MytWOw+OrknbQ94SFpM
         5NRDHGipM/g2618Zh+XVmPWCI6VDwpqsK+zuRi3lL9hupvYrJO9ENu+gluCOsZ5cqw/r
         oKmA==
X-Gm-Message-State: AOJu0YwkUF37pIshZq9N2hZ+ajqF2RPpiiIRJYClP+fMDYPvge5kAMmR
	thv0vZ2bDWpkNtwpiufmtYTvXnPH4YMTxs50iPXkLX7sM1nwfGky+VV0jxViPd+gNauOxraXK+J
	CjkFtO7BlICrj87qXvj28RF40hDN6uJTzs2O/DOdIW40pwsuBstM3gf0=
X-Google-Smtp-Source: AGHT+IHX5cu2Lch1dqhZO96IH+Fg86OBU7NCF71UqmVoesKTsr8xIZ4/ysByW8HaVd7uGbKUq5rzdRqIEciBBes91LVH5LTOJOuu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:374:a021:f1b2 with SMTP id
 e9e14a558f8ab-374b1f83ff2mr2948355ab.5.1717682104098; Thu, 06 Jun 2024
 06:55:04 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:55:04 -0700
In-Reply-To: <20240606135139.134172-1-norkam41@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6f3fb061a390712@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norkam41@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/trace/bpf_trace.c
patch: **** malformed patch at line 7: diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c




Tested on:

commit:         e377d803 kernel/trace: fix possible deadlock in trie_d..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150d9422980000


