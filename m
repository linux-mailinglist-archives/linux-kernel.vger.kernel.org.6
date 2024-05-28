Return-Path: <linux-kernel+bounces-192804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C983C8D225E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4301F23EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB1174EC7;
	Tue, 28 May 2024 17:24:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24C7D07D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917045; cv=none; b=Zm9+yJ3OP29wDiY73GDqFTDNSvT5EKzW6vjgry2Ycgi6got8BxkyQpKuo+HTs6oHI8ExPF54+GMq4usIkzZCjJK7/+zZg+BIU7Ej8BfSxgmDGEWKP87c2BYny6iaP61aheqYnQcHZQNcSSjjmakWiC9i2Sxo9mrCBkI21VjdceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917045; c=relaxed/simple;
	bh=NwVtVqmDmpgrpeeU20NOiY4IDvcu6si3adnNSFoLIcw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hmu1FJx5qBPnWvZqlNL5kNXyKKFaxCER9hTkujugxtlBnKWDvwYNQEhp4tqLGtoR+l8GOuZ9TTjFdcwK6f091rbzgZzo0/UlWrzZiguFbsH90ywsKvQEq+r5McgGX41D1UAOEE8//gEVTMrMJ0IwLLNt1Q+l5F+vKlP237tkp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ead3d6a782so96859439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716917043; x=1717521843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yNlsejU5OKeaQhEzar8+GaIUKly5Zi3CGh7ZerUnuo=;
        b=IUJYqPim8ojmy5keqHqF66G8YUP0Iyv/ApSjZ4ygjHYQaxtpFRhrrRYDkLMvFMEFsV
         sglnXT1zA8nwPdV2SudI1humE4QiIPrj9QfHrGzEstEK7sCoRt1AlvyV7dDdSpSbDBGJ
         HbfqlmKslG2NPf0nvuUD7YciZTjx4YzHYsIQSV7JOPc6WFNsSRKmtf0S/pR84NJDqpIx
         NfPdQDrvFgjBrm61ApiWwhuEazlemJKQ87WBcDh633psT7VxuwZglhIRfVJlvTN2+b6T
         2CgsWRkU5e2uBoTmrKUYbSC9VVsYLuUNQ8gkG4SiVvRleugKVWXC4egK9nquL+1jGsDW
         0f6A==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9XvIsedjt0C65H7UAV3n8b0lqaB1uP0FUNLsUeVPlUlYsYsoL4Zv+fl+MOjlS4dJUiyTylPdpCKqpHKMavLLC7XDKn+dWY8ex87y
X-Gm-Message-State: AOJu0YzNYUKzhvoZSsNkJKDER47F1gO1IxExTxG0IhxLIJ1R77uYH+Vg
	VmiK+oJp94teBCIYECP6xl+nfipQbKD7xkm0cwBnPQGjiaRR44ziHW69eJwU81NIniqw4zqCbZF
	GW0rt5vJfV60TXjnTixev9qXvb0cjfKaDt1BbFulY9WxN+BqxPOcm0y8=
X-Google-Smtp-Source: AGHT+IG30kQLtKtkvjC2J6X5T5H0ua9sojkjqLBvu8WWwXDx31u9u2cxlt161wplXgK8/zmVo2ftC8Qefn7vAEuFgzp1fcfrBGmL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cc1a:0:b0:488:c743:c19 with SMTP id
 8926c6da1cb9f-4b03fb9b001mr473972173.4.1716917043060; Tue, 28 May 2024
 10:24:03 -0700 (PDT)
Date: Tue, 28 May 2024 10:24:03 -0700
In-Reply-To: <ZlYIoPEq7avOkjCW@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076009c061986e67f@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
From: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org, 
	osalvador@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com

Tested on:

commit:         c80d58cd mm/hugetlb: Do not call vma_add_reservation u..
git tree:       https://github.com/leberus/linux.git hugetlb-vma_resv-enomem
console output: https://syzkaller.appspot.com/x/log.txt?x=1763ba0c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

