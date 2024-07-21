Return-Path: <linux-kernel+bounces-258262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FECF93859D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A7B20C35
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0C167D95;
	Sun, 21 Jul 2024 17:11:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA714F9F9
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721581864; cv=none; b=Xa9a1kIIzKVzjycfqCaXM/2T4reuqwF5FePbeIfS+rlKLROIcUlxXyfTv0DdKkhx21ueXT0EjCUR88X2VVPeZRA4l1O6q1HusQx7EyYRdwC58F6pjtokDW+GhIPtE+gmMLlI35S3vN9JXdB2W1uR6r6vbGDVfa/5SkGWUmNkWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721581864; c=relaxed/simple;
	bh=Pzr0k01oUFgnHshjfu8lDpigAiS96d1MbC4X5R0VfB4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qhrwqlKcB0WjHd6TCnd5w8UcaxMynkMeI3vm4ZV02SJcVTBCQ0c2eIn4cl1Zs9AMzZQ2m6i5Gps2P/t8SFJHwIY33LW6t0J1t9Wf0JsCi1RYpLvF04R7NEZZu3Ib2K9P6sQt6EyAstbEYbadFbhy09yCEYIWHiu3Dwvkv4IGx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7fba8d323f9so602307039f.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 10:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721581862; x=1722186662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyxVEGhIiKJkbfH4z/x0VFCtxcldFdWW6brc8IkPBPM=;
        b=VW0x+EH06whuRfCOdqdYHIrEBbNL02k79k1z74Gu3H+awXHK+OZhR4Lqro+XDxMWEg
         sW92+vkHzduxFlLZwSYQqQdE+gyKi9SRnqwtyxvVsSYTrFZTd0xlkKyvAY0H6ELGfzw9
         ioTT8ctv6HPIdkupRtLlsS+OV2wlz6RL4o/5auHC1iflSRSSkoTFv2xOSk4rTrGxyBIV
         f+teZwHAvursjH93ewOQpj3O+EB8ncTSKSFt9EE9i+z6Prn/MIDpdXsCVB6wD8fXiu82
         15szLZaZbXL/MHIxu7mQGmGknrGewoB9ZTzqvGcnFRLHyNDVDEz7hlFnQOYA1gxDVqV7
         L/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVW8C2p09HvLhOlJ+ZlUK2owRx8bXk8kYD5SnTaEGrfc9od5FJ9iynf/eStk+ZmqLd7G8n+k05/dM891k1YRVS/poWA0z0j+UcsGJWO
X-Gm-Message-State: AOJu0Yxl17N6Rk3+edDMC2N6k+kzK5Edyttsv3fGuz5AviH8gRgSi4Gd
	UaaJAuVa6kCX2pjc4LQAuV8eBft18pelLIXp7EixE+EbH/TwSw1Fxkm7eEvoC4M2lQKUv/Ugye/
	JfUva3uFjbt/cR9Zsf41nOOkq4D6on9fjto0njDgONcfF/9ll2/aUpH0=
X-Google-Smtp-Source: AGHT+IE2etpHPTrxAL02sL1iI1lNIA6NTuzCxiZ9FOvJnnPSwiPz9Jp25Iy3Fktw32lUiQrHTtKqVIKqAla8JSsXY6st68AV8RE9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3706:b0:4c0:a8a5:81cc with SMTP id
 8926c6da1cb9f-4c23fe461f0mr443247173.3.1721581862188; Sun, 21 Jul 2024
 10:11:02 -0700 (PDT)
Date: Sun, 21 Jul 2024 10:11:02 -0700
In-Reply-To: <20240721163522.2416-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000590db9061dc50359@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com
Tested-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com

Tested on:

commit:         fd8db077 bpf, devmap: Add .map_alloc_check
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=152f62e6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=909a84ad1424a029
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

