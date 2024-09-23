Return-Path: <linux-kernel+bounces-336097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BF697EF17
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E66F1C21570
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362D619F105;
	Mon, 23 Sep 2024 16:21:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A0823AC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108464; cv=none; b=koqczAquhToDwsglQx0L5IyqfJkfz9HIjbYslwONZ0Fb6dv6pfI66kt7wGZyntGhvUBoKUTQS0CuWzdXbS/4QJ0slY+aW72bXdXr/8xBfFAWr/NUaePiGJWPlxXJIxoad5SfQ+9trMdD+Gh2Gluy4ThcXTG3JuBmMRimiQ3p+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108464; c=relaxed/simple;
	bh=L+9N+3jNgDaYbqwAlmJ0cEzDvhkQwJ1dQex7ayV1rzM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QwpHRK6IaBDAg5ZvJ7Zmv5Lq+FWIKr8qL8mvhcG/0cgWvEbdCWNKeCsE3EcZ6tlsfNO5x5GZZU1T50yymyJpwxv38QOFq7GRoilTwRWMCaSwZFq/zuLh6nOXNJ1IRTKXY5XG2nMC1VtbZgkwyrD9tRcHWhQdT/HHwFxWKpxiKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cf28c74efso656762439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108462; x=1727713262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyXLZ8YcQWxUiFP4L5BAm3AOQgYVSxXc8FGcwG20glc=;
        b=vgr5wn9Z0yOi/DLDhmrhrBFW4YMgEYZkAlR6FSz8UVwYJgv5mjfNqMU43JRzFneBl6
         JXxrRLg4dOvVMlfUqmkXhDe2MKGy+R6gHwR8pnylc5juGnzI7IHaPMVcURvrYMvJIP25
         FaBu38WvjHkJIN28IOGBVYI+33g3jkazDQ1AFb5Md2L0hRbjsfsY4njiQGxtZ+9nv9tC
         W04Uzhr2vJN7T/y3r8FrF5xx4bvIT+8ofcJIu3QXOiJIOu9DEwlceXOsk3SyjUDtBl8C
         +3WcENV4Odh9igsHq9Bs1ND+CdPmUrsMxS4FiNAhFwhKqM4xXxDSrSryOrnJ3NbMOuLV
         bl/g==
X-Forwarded-Encrypted: i=1; AJvYcCUfAwxc8vb6sLLu7S3AluuxBOKXqdRajmGaAeN7CGn/MzovX54ZOOhF20gj3po3XHO2y65INsjQi1yordY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3sfPPgG4tHrODGOWLFlCJkC19xCspZPEeQSH1bagiMfvjT34
	Bbxqy25tSw/xkK3smFDOlPmlZZLL1mPATxZM8hZBvaRK9Ektc7rxfmY1ZF8u3zCOfxmms+C+rXs
	OXToW9RvR6D2WeRHE6KLM0tTejBxgZ36bMt6f7ldwce2DSiWjxFZEYCI=
X-Google-Smtp-Source: AGHT+IHu6xO2NprjhpjUnqu0sXeXKxSgmtjxkZDyTx/YPDMumgh4eSm+vTEsSa2P8/E+7U5J7QnlEz8tZhaF4o4MAvCRALkqLg6J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:39d:4c8a:370d with SMTP id
 e9e14a558f8ab-3a0c9d70074mr98104555ab.18.1727108462650; Mon, 23 Sep 2024
 09:21:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 09:21:02 -0700
In-Reply-To: <CABBYNZKg28ccCZXqBphNLp0WEOznS89Z-AiShC53JAVbsSsbGw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f1956e.050a0220.3eed3.0013.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, hdanton@sina.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, nogikh@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/bluetooth/hci_core.c
patch: **** malformed patch at line 6: diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c




Tested on:

commit:         de5cb0dc Merge branch 'address-masking'
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f72107980000


