Return-Path: <linux-kernel+bounces-381009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E79AF906
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D255B1F22FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC60718D621;
	Fri, 25 Oct 2024 04:59:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118018BB89
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832346; cv=none; b=HgElQ729fTh3gsGZ55cBNnhRVI7kkO0WrxFbQcbboUvhEor8HMhLYdtXtH6VCtYJeGXFSbrIup6GqolggJDuiw3JJJahaiSRvunAXFUdHcUAsdor9519Y/eWhX/E7vbIpI7xu3K4CN0kZWIQ7jdIJNP3my8fmXYk9xK8QMpAE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832346; c=relaxed/simple;
	bh=vY18EJ4z0Op19yBMfQIGh9p7AZkaSMwndll6XWs11e4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k6pRkIEr3cTkyMeHd8XbNZiRqvownmFzZea8BAVT1HTLQiAO7PO4JjzXtBPIGYgsTbzovkWwo7eAnlSwdRNsCSdnUakknMlLilgBZthZBcx8rsSa4+wu2+XZ+eYVqNb+weCq5K9Xwh/5KlT4nSGaGqSr/fE+33HaXPcWqR/Q7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3f7b8b116so20856505ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729832343; x=1730437143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XccUVO3qZwbE84EvnjTtajNNpK23t2mWRxb+KvTMwI=;
        b=fcBZr3wGJeVqyLQIjqCBjH66ES7E7bksVIInqZ2RhzRS+X5eTcVs5Z3VRMg1CLi5YB
         gpS9K0yOqksw6y6xx1QOtuYwtuFoN6SaRv9tLWFZgbzLXwZ4mKMAaGGaTIl2NYHvlp8f
         E08+76544RtuoIwsS6UN+dS7ifOwI4HtRM/OT7Oqr2sosstP7D6mqJ8PIfRcjdgqdotR
         lL//BhBUYoxQqhdJHHhtpPuurii1PvnXGLeyVMKtCYseGqswe8DwCfKtgd1yvNnsJcIL
         bOXi7TOezuyT308M9UhzeWEbDv1gM7U55CF46uS5xNiZQnz4+CSeC45TwITj5mP92JIh
         EtDA==
X-Forwarded-Encrypted: i=1; AJvYcCX89mOB8Eoi681bw70teHkrGMCD+FowhBiWHSaHlaJbLMm1ZzaQR05gPdBNj2c+gcJn4ulagmTqKvYS+ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC+LiOaomIQMHuPZgd/ldUsFVJyw4NoOlJoZAgIL5RF5ZfYqRS
	/uSdxYul6mgCNOTIbQQoO0HVNwNqqWSF5Lr4R/t07fz9NVO5iBMLVZeqmkDpWcwb3djc/0d/37U
	uS17C45V+286BfchXiVKIkz87mOtJS61+cLvF1MWLlIGTNYaGAQqQfFI=
X-Google-Smtp-Source: AGHT+IFFCpZ+t8Bjue0Mc0F+VuEu7hi+JTghqCDgCsAahLm9Yx810/2WUSeF5aYj9VCf/oX2C+3ZvFnLD0+YEl3+I2DS33SQN4iG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5aa:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a4de685e50mr24788195ab.0.1729832343706; Thu, 24 Oct 2024
 21:59:03 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:59:03 -0700
In-Reply-To: <20241025043848.1981317-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b2597.050a0220.381c35.000b.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_search_slot
From: syzbot <syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
Tested-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com

Tested on:

commit:         ae90f6a6 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129e3287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=3030e17bd57a73d39bd7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ca0230580000

Note: testing is done by a robot and is best-effort only.

