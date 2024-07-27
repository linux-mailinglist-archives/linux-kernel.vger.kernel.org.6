Return-Path: <linux-kernel+bounces-263958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A716293DD2F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 06:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62074285411
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C554A15;
	Sat, 27 Jul 2024 04:01:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4A1FB5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722052866; cv=none; b=Y0rGLPH1k2TimBADp5ecnzP66D9X/I7aw+5b811BVG82fo1KLJFuBHuzDHufC+OnoP9eH9I0uEwpXsHr9T7cD1uGb4zk194gNQ5wOHLziXn4+koPCJjc3xlYVjhfSijxAHuWq1dQTkLxJNC73HIRnOgy8ZFlvyu0aU9fk2fhevo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722052866; c=relaxed/simple;
	bh=VVK5qiiXHynEeUXP4H2skGGyzv5kDvTscRuofbVBMKg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pzmoUW2+5L60AwOqQNoUNrLw42e0hXMYKSnvtdm8LkCYf5KCN9Qq5zAdP19GjujWDhxMdmtx1jXd0OpWCBkSWExmwPmrssgBY0gcXjyksZxPFhkKVUqSPZuqFiFgaqfp639Q2mUyGyShD9L/6FDcYJrx+qMpU5PMMY0NthBfOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f86fc9fdaso271858539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722052864; x=1722657664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCn0UAQC5vYxpdQ9MTsPrzZ9A5eOXhCSx9TSJ3TDDMU=;
        b=ZpddmnahDchyOam55dbNrpu8rJ16bUqhQFhrXAwj4Lgb6TMi8WMT5g9i8U3NcEMaD2
         xhebiJTyaiaUiEKZF48r0vzErv0uERRXZJHyFI6Dy1SST2wX93WcFDZoEpaPwpLr7iIv
         M95m8C6EirqEHThi5JCoQVphSjeoNi2RWPkxtvXWmLy7+basgMotjQvTEYISjj3LYklM
         JDU5v9xydLHP7imlq4pCEWOqJbCk6uiHg+3vt3ZiaZgu1oQKxg5lV7pnFiCYT+nHBMOo
         AtcZuTeZok2H4b19niXrb+98ZqfAdwTu6nwDYSQAvBxK3Bcb7xO6GEXEi0NCF0NVIqsd
         JBQA==
X-Forwarded-Encrypted: i=1; AJvYcCVN12lsQXes/p8NXaqJOvYzhbbtQ0UFtlDuWfCGwULzczv0rylne1HxTbFVAikg+8N/P/HAB6hXBFM44KzkW3+vKz7yvGcI3Sdfdybg
X-Gm-Message-State: AOJu0YzR7Q26qLg5ekdloDR6UDyzNa8n1Y0qaZ9bSaWafkPO/tsup2uA
	LOEUPnqlzfcggK+ICP3C6LX/9/a1k4v6xsEiS1816ZGYFQd2fdMiSiIbJlq5UiYpV0RYuUykXfW
	pRh+xJonDz8wstredFaVaDYdc5kgB759vatb0LNEvGh4W6FHWkEv3jT8=
X-Google-Smtp-Source: AGHT+IGe1WDiGsFllS/6d264+CgOGkK1wuR1RqWhjV6+HJYv9brh6Vr//BkJl6fP2kBaLGYEM8ZKeLAxxYQ6yoQLBORk9nKKxYqW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56e:0:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39aec41b90dmr1174935ab.4.1722052864297; Fri, 26 Jul 2024
 21:01:04 -0700 (PDT)
Date: Fri, 26 Jul 2024 21:01:04 -0700
In-Reply-To: <tencent_42384B7F1B3425E4BA97BB4133B29E341B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042da79061e32adf0@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Tested-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com

Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13bc41a1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125559a1980000

Note: testing is done by a robot and is best-effort only.

