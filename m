Return-Path: <linux-kernel+bounces-213988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA051907D63
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820211F21AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A04114B96A;
	Thu, 13 Jun 2024 20:19:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21E12EBF3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309945; cv=none; b=W1C+Trg8t1fgpopd2OhKf1oW2jxAQB2/Wbeb6tx8DijyA+qeqF+l4WjarBPSlOPZdvhs5rf7J3l+QzVsLUh40k2CwKg2zh9Bm9SYpQNImt+6mc1OinTUCwc36cHQHUxaehM2zFERAvBYWUtmklX+AIy0mes/jZRmrpL1T8HuEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309945; c=relaxed/simple;
	bh=3eMv7DL13ZCf4yys+63EEQ2AEUW/IgfiRQCSfBzmLzI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c+EqfQMAH2EWwH3Wa3f5xlA4X1vLMtwZmsB29KdfZ0/Bd0dhs6KBYpwGgouJXuzZOiJFp2BgAW7b9sKNOa4XR08Ptas4hwarapFzt0QFxkRyNNF3C7vWygC8OS9FY0ud5pu0xdD7LPVZB/xj+QH+foeJRXfXgW/cWiUicCfwsfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb6fd69f7cso154159339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309943; x=1718914743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZr6Co06KvKRHiMHcD6McYVqxp2MyMT713pL9kkaxCU=;
        b=o40s5hy8l5fOiPQpIjetoodQDJxyy+LlV/XzhfuKyQwdjyfRjeRl959QjWgPPDXi8Z
         QkmkPI52VWN+uZxPmJTr0pQfVVBtTmoPUTXXWrQW19oDlRKa8egWIpWOWakNydFGRSkD
         XMgLTA7zl1p+yWf5QyNyBWzxqAC4nw3vII/KUAWLubBhGWf01OcF5dfoQUICSPn3Imh3
         YxM/N7myE394UcLWk/AHWUMYDXmnNKvWuWR9vqlKEgi6sjIDdqUTxBp/aMwbrB8oxa/A
         JV86UgcphDe+FmbqIYCrGu0Z2RW+K2z6PLx/T+KLcTkc4AOqrjOTbtCCcUy7fFAoWNLT
         U54g==
X-Gm-Message-State: AOJu0YwRUCyytPbRlNc2skSII2MnHCYEr4vq8q8Wqr7ktOx1wkyASDTI
	PR84b/Nl1lC1tJmBt/y7dd8sYzMrR0PXQHHbskbJHQQMGhEmDtSxB9tP8W9geYGlK3WiP/aCzzl
	8xD5qYxnme1Hl43XQm3EAHG+V7dG4QUOOekbkz8muiiS6r2cuWJ/f+Ow=
X-Google-Smtp-Source: AGHT+IFOXnqatbycfH4K5gFhHEb9rhcQsjKhtmVRO+a5Ib6mQVtHf3uSx4UFGiK6P/O5fVBw5nBJI+q9tzi01CyjOYpy89ynEq/9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1581:b0:7eb:db06:e07c with SMTP id
 ca18e2360f4ac-7ebeaef25bdmr1020239f.0.1718309942916; Thu, 13 Jun 2024
 13:19:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:19:02 -0700
In-Reply-To: <PN2PR01MB4891B609F58042DF0651A21DFCC12@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c31424061acb355b@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/bpf/helpers.c
Hunk #1 FAILED at 139.
Hunk #2 FAILED at 7146.
Hunk #3 FAILED at 7230.
Hunk #4 FAILED at 8748.
Hunk #5 FAILED at 8763.
5 out of 5 hunks FAILED



Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5bc506ebba90cbf
dashboard link: https://syzkaller.appspot.com/bug?extid=1971e47e5210c718db3c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127983ee980000


