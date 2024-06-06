Return-Path: <linux-kernel+bounces-204322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A14558FE733
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69FD1C246EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09386195F2B;
	Thu,  6 Jun 2024 13:10:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7E195993
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679404; cv=none; b=S44zaize5To7BjDFWegJWCmplfcDOEGzhUDA7R4HY8WNKjIf0PaTk0yHbLUfKNHH1oPaU+V1WGUhlzF7PNYLZ6iCFG+03molmmlCH1abXQN7333+imAe5RvOI1uFJoGw4CDIpicJRRFsSbmfohgelTFYT3Z3/pETIF5EhiviO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679404; c=relaxed/simple;
	bh=ipZTFsDn9/5ScMtcIfc9zumasMug3TbHMItBL5Vu32Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C5BphRLzZHa3usRu6iluD0hZjIcaHaTXAVmH6GwAoxxJ+OwqxEs62sqe/Z5z+UxbzVuTWss/dvjSFp2LKlicuVv9QRbtnArrAmXZYOeyxpWMY++NeqOpMeasiX/fpM+9wJkKFy9gWMstJ5iC/oFPYlaQlOguIlGXm7wBX9oTIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-374ae94e8a0so8924985ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679402; x=1718284202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJdW/Oj9WN+vKGWvAOMQbEWGgE8IPpZYVc5jZ4z1/QY=;
        b=CZv6pa0cv6fAkmHwJgcOBcOmbAhvgTct46CkdTdWYtsaMNgepQDszycCiHqvLSIcr7
         8abZh/K5AQZN5ACxpY/oJ/cYbu2Ika984LShG6lrofhDjg6ZsFaJroZNYaRjORPRsOvp
         qvWIVSdrMZgv/+lvf+d1WXVcqwhXkoXab8lmDswADa3TJA8AyHIGi20wotVEEvjW+dSo
         gpRY5Grqdspyfic4MWrJK1BXTP9a/dOsUsHCQdm3JoqgMePdS0X6GOuRdVsnHrEFrxT/
         CVodMRMDzWsZZUPuq3S88r/8zZiyukm1drbQA09eTClMiycqj2UzTsuKDDRM1EkZE8lS
         BRkw==
X-Gm-Message-State: AOJu0YyXg+IHK2BVgslgcfnf/gP64VBQl7CzGWDLrYYs0JewKwgvZ36Q
	whVEMel2BbhoAbzFV94lG23o2umoV563c/pC4LPK3OmBhXUDSZ90FHZDpLHwpGLEYiXKOfD6iY7
	Z1DMNifkHuF4cMLdGRgCjBPn4RmiR8jr4gfOYGYrdFGonufGbBoToAHE=
X-Google-Smtp-Source: AGHT+IGFPxDjjppwaluo+PQT85pSak26uMn6v8S+uNuxKVTzkbNeXx+OSxjNJHMOH9HFR4OcBX8a6CVflG1DJSV12JBY8dd5T4Jc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:373:8d34:4ad4 with SMTP id
 e9e14a558f8ab-374b1f77c26mr3689955ab.5.1717679402600; Thu, 06 Jun 2024
 06:10:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:10:02 -0700
In-Reply-To: <PN2PR01MB4891F53CC6107BBDB25C8C09FCFA2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a162c6061a386629@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170e179a980000


