Return-Path: <linux-kernel+bounces-204387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC798FE80C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8311C25C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E72D196428;
	Thu,  6 Jun 2024 13:40:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD313E048
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681206; cv=none; b=sde/zPXmEBPf/JxBw0bR5Y67POUcfQYhV3LIDZL1vwquQ2sRLcgySyjNCauO5Ug6+STqWa+AFbgoDG0PEB/478TIep0/QAh8Swa/MFDGDnmWR+IEnEMRBzrhMGmIN0Oqjuc2orLdZmjB2Y0hd1Bbx1WUXW7ixVVPquHZzehVXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681206; c=relaxed/simple;
	bh=+jgM5CPyogfcEJrhCxPlKepwh4WfCrs8Er9aArjULcA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nfuYE5kqeWsS5OJ26wPkjlqF9uMn/UcDqQZldQkKTMWQhwBia1LYgoMEDC5Cta8lkZHAOl7aN839JCCGwEWqjIGuH008WB37BguC1kHRnS452f1lVx1Hgsh/BSBzrN/jChBVWcfXiQ9/mULNLJxN/cgH0mMzEGGxp7uIsWRsTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-374b3e81d6dso9730225ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681204; x=1718286004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uU+ESHl/ns52zXGCjciN4nv5yLfnC4wyWdqvwN+Src=;
        b=wuWa1P4u9LOSkIoEmWjmVUrX2pWcvScMlfZqzQo0rkbSte2FdP2M2akdyoek0UcUXu
         8Q/Jknn39pHsu7YO/tT/LhAJIxKg4o3RDJPDS1/aNUBHULBhF5O0Q7QuultdVcXwUazN
         GR4IA1PItM5J23uUIpX8GLcQ44qI8NkPem86k1AqsXs52t6Cc1C5FWIx7XLGeMASAY2F
         3z60OT6fUKAX0B3qCnrt4Rm9w7wL4yA5ZiuQQATSnhbf87VP7CzQy/D78aEiTiS5Q5Al
         4qNfG2L5PLqTO8WpMkfJhCg/973cK4w/tX68rz1qlYwSyjcd2h8Mz+BSTCJkERBZjGIC
         seKA==
X-Gm-Message-State: AOJu0YzR+gEXmWUSMXc1y8T26LdSzZ74s+H3rlfSUY0dT1viftyatvDp
	lz8kkQLVWxwxehPb67jcH0+PmUbs/ySya74d04trh/q68F7NHBcGlBV+TfEC1pCB41WvqrWysap
	N9iJ7ebb0ey9mw04edJNnUT/Aa5038QuqkmeMkr4xy830tDI1NpSI1wU=
X-Google-Smtp-Source: AGHT+IH04OQPT7XiRcP+WS1C8mSn20WP/x+88ODvxVnbLLOwORA5DN3XBWaY14Ni0sdYxbXr80N/7OVGEAUfRd0tyhZuVo+7QAJb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170b:b0:374:b18b:5214 with SMTP id
 e9e14a558f8ab-374b1f65ff4mr3644115ab.4.1717681204104; Thu, 06 Jun 2024
 06:40:04 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:40:04 -0700
In-Reply-To: <MAXPR01MB316750CFC54579A6A384FF91F7FA2@MAXPR01MB3167.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000224a7061a38d24e@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norbert.kaminski@infogain.com, 
	syzkaller-bugs@googlegroups.com, wojciech.gladysz@infogain.com
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d9f026980000


