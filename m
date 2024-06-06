Return-Path: <linux-kernel+bounces-204256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF908FE646
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5627A1C25954
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D99195B00;
	Thu,  6 Jun 2024 12:12:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060F195974
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675924; cv=none; b=hF6qTNrNqe5d47X8IZgYt0G/9XEIXhBrKKx8ie/7m2v470xqTrWr3XUgIT1bQs1Fb+z8+5NiWpkwymCg3shG7HJOJ5ITvSUgMervz+lfBQc1W8+CzrwD8ALp+M3eF9h40BI2EuGoN+uwI97lheWWEQv3nr7sBtr6GuY0AeTxxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675924; c=relaxed/simple;
	bh=m52GtDMaWNFJPbVvEr1BqKWeqCzBW1XLBj9Mj1hpv6A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q9S2XxBQgjm0qgzEvrT3//VSBciiPMGynAdfQKYVxx8M6GBuaxtYJfmWVOH/XHV1OnvSgOCXjyILFdPm6hcCCcV6IQxng0nUF0gTUs77lNLa2tenHnPGTmj0RBTL/cqen/GwjXpJU6LaImpp/B0rZZ2HDFb0OaWgmTEIdnuvyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso97654139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 05:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717675922; x=1718280722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cmtViuffhibisuV0fSAjJBtmK+abDGs/C/E1xBSgxw=;
        b=jVOB6eaZD7xsBUKA3ITUR7C3WuTF//XErX/SM4whUG/wsR7Y5mF0lJYz0PI3Vu4whs
         1LOvf13ht9FsqYuxI36h8iH70cR/rzbiT1bUZN4NiBZRD8ogkf6seAu0Y/J5hAodshya
         8jY5HUXsS5YUQW4tBRIY0SZmi9QDqVe6cgL3C9NxJmWQEyGCZ2oP/tsrChE2OCLZvFdp
         RRK0J1VsZopwVPrqckrmVmQ/gizZPWrTJzN5zaOmQuZSe9EGcmF5J+NMN8qWV4gcX5gE
         hESA6DM+TJQNBSPA35NQ42EpCb9kOfoxjp1fnWallEDM/rP+Vrvgw4Zw5Rrv+sV4ZWO5
         RRzA==
X-Gm-Message-State: AOJu0YwP5xy6cQ7+6YHlIBBQQtTy1jq0yrKyFxQpxpCzL1GVRWsMNuos
	KeT4VCRr1yTNFK0YTRN5Lb5rtZ6FnqOuoqQbWlWDDdlu2/cwfyEQ8HnzNt1im4tqp+H3lQZgflD
	N0GWL5sg2WbfkeNYJfAp+I6X8spt4HuRrXshOC+tv1EJJPryK6t6+nJI=
X-Google-Smtp-Source: AGHT+IHvdgXErweO9QVy7F4GcjZqL1dBliDMdAC1zHJ44zW/UuRFa5UQxEUKk7mVkV1CDdw9b1EmsrC8HBWqgFG6DLbJizoFe6te
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:841c:b0:4b4:65d4:ad40 with SMTP id
 8926c6da1cb9f-4b63a8a6a99mr175284173.3.1717675922799; Thu, 06 Jun 2024
 05:12:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 05:12:02 -0700
In-Reply-To: <PN2PR01MB489190072C2A23C3C1CCCE2FFCFA2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037cce6061a37977c@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/trace/bpf_trace.c
patch: **** malformed patch at line 7: @@ -298,6 +308,8 @@ static enum tp_func_state nr_func_state(const




Tested on:

commit:         e377d803 kernel/trace: fix possible deadlock in trie_d..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109b9a16980000


