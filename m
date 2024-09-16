Return-Path: <linux-kernel+bounces-331068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B50397A7F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7589BB21608
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8EB15B10C;
	Mon, 16 Sep 2024 19:52:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC492E659
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516326; cv=none; b=VJ7Bl18EZkqdwZNkjbmguwome4jimWnvPuvWlV6k7B0aybnhGZE3+IP+GMv4k8pgWx/ncWtjgXvvoocMAyFPGrDHtzgopazw3jBJeNwc/S7naYH2eXgT2cRx2PyxA0X3t0WkFiEGrGOJtSzYGeU8n/k/Aryw8n88geFwA6beTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516326; c=relaxed/simple;
	bh=Lqb20Iw6DxcEneSZ02a5YRSnY6pZY+MlRkDtZn/qA6c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AR66s4W9aHfnCK6NBDwlKoLnnnJoSXG32icAOQttEMbcPwFAMDORyzhVQxUYutkBSZWrvQqB7Nzt9NXhRnjwjr2VkSdrIAw2WG0oWm341Q2pNTgkaSPjdNhFrWpEWBW1Ak0AttL7s+neFpLrEepYvEVp1wkDfN9HY/Nz1Tyl7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a08f88aeceso49159935ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726516324; x=1727121124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMTcCK/TKOvRRaJgzia5piux23XuIMyubVFnG5iKmdM=;
        b=cJFFA1BwJOX2mdibq2GwHLMWStALASNW9YePHnWrLDtjciG0YMqrQN89GzxlmsCwkZ
         w2T9vG1I+imqm1hnwCW5+bh5HIEP8xCdKfEAgvyhCXwdxmBb7uCHzS5d62Yc1HAbQZMn
         +JiZUE07gud+mxsIeeWPMB9xYsCb6sHo+VMGdBc8UyCaKi4Q5dEF33/9LgWAP8ALUgtX
         X+M8XF8tK2r5d4wllu+NA7U1JT1Tco07hTQ5n/VrtBL+jjBNcSybMW4Ar2SOj/Hr3ZuG
         BN0w8na6Swih1YlU2Ckl47nxESFHLf6AAMe+FjGPRUSTjmdSkLtYNG3hIFSlmE2NjQ/K
         otCg==
X-Gm-Message-State: AOJu0YwmkJjpLzFgQLjY+4A1Ujrb/DOqwbngjvyj6g2cGfRnAlOVj/DD
	9J7Xdq8R6yFb2h1jPe9v2x1lIZweizsvy+JtTjbMB4Q2RGVF5wdyiMEE0lRzEfWHVBqg4CqEXnH
	VBHT3Jm51bup8pJJhT/Msu0PJG8bcyMf7bj6SKMoi7FpfOFNFeIJJ360=
X-Google-Smtp-Source: AGHT+IFQQWHyo6g9HC1U6R9mw9oNN7TVFl299ajgscJ/Pzo6I4IjksZ+OJ+rtXWPRmA/4M3kLI0FOsK2OupDXYE8q2G5fAG2fFgS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3a0:a08a:a0d3 with SMTP id
 e9e14a558f8ab-3a0a08aa209mr42039025ab.18.1726516324252; Mon, 16 Sep 2024
 12:52:04 -0700 (PDT)
Date: Mon, 16 Sep 2024 12:52:04 -0700
In-Reply-To: <CAABpPxRkKzeNYJJTvXTPBtwCkB63=NN5y4Eh1ED98o8TWLDO4A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034ce8b062241e831@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in prt_str
From: syzbot <syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pvmohammedanees2003@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com
Tested-by: syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com

Tested on:

commit:         a430d95c Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138a629f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9ab5893ec5191eb
dashboard link: https://syzkaller.appspot.com/bug?extid=37186860aa7812b331d5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14abd7c7980000

Note: testing is done by a robot and is best-effort only.

