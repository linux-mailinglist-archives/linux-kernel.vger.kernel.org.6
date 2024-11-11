Return-Path: <linux-kernel+bounces-403532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A180F9C36ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F711F20F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9332D1448C1;
	Mon, 11 Nov 2024 03:14:36 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91AD13E3F5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294876; cv=none; b=JGl5TBFTOCfoty24BgoPVgMufSt5G7KRE5TN0xBnzg/QzQIr+nTmbDxtG9G+2HCAg8gBi0kvxkFjl2gy0OnDiuwISB98tSbx9XLBTmSz8wJMZc8XX5OS1gdyy+8aYO8DXYgmh2BtFPakybbmqWW8AJUGoNLtluiepXo5PFbz4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294876; c=relaxed/simple;
	bh=I8ZWVMbXdOCAnMhVFqzWalAfu8hk7zYS2lLGuqtu9kc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BXi2CoNp7OFD3Y9jKbKG36WkaoT8QnVebNHbrFvZHrn8JjfuQx05SWLSdDaDXNeOG40LcgdQ3shLWyif7eVTIJmVAblSrJFYmDf+i4SxMNpHjEhsxpgswgMr1Z7fJC+6XyzpQBVZ1p82pkSHhA1Q+IX9/Ntey5k7KD7odxp68nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso54871645ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 19:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731294874; x=1731899674;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbPhtWGffHaY8lZT0rLrtS02zuRE4KpaAMyDDzVNCjY=;
        b=k346fFFFqQNvseZmq/iUJ3p3CPIwZMvAC4KmCQ1vhtj4snJS3ENpxbXm5Sn0jh4qlB
         HM4qVwuOEKo3tSbU3J28V1POSzxqYwW7WArVeeFUhdNTBX/5daz3Pjh7AUYD32HX6ZiI
         UUHOTbl9OvDRqHsOzw9QVH+FcHeEOPj9irjFEtcUejy14P8OSwywOvenWwURTTrBupkA
         yVRlLR2pcQAkUsj8Ruq3z2DI7nGS6D5CAtN/i37XKejBdMxZQtPQtNnb7/NucE0OMUxB
         g03ysGuPygrd2AGYViTxYHzKO7lERbgcDXE+cfAl7h8xR3W+XvQaZlClh7uuS3cJFbRh
         uvEg==
X-Gm-Message-State: AOJu0Yxz5pWC4FcNR2C0GRISNqC1F3nRAQWpWmh/EX9u9/noF/ZjVqpx
	M2dh18UIW9Ftu9EhDGgEwiA0/7SI+zMUku2z+1PQEhnXeftYN902osli7WuISG+ncm1YFag9XA+
	2z5QdCYXy0hk/w1dUA0KpO9w1PgjKaSiETicT95S6F0iDUxNJnHC/WQg=
X-Google-Smtp-Source: AGHT+IGLbbdU8/eAUTBrPoaZA1nuGzZ1yLy7hjPusXQFSQP4pwbcO/SZ9A0GtOY6Z0yUcE6mR4QppKN/wRlKtapdaA76Pz/R/iQk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d8c8:0:b0:3a4:e99a:cffc with SMTP id
 e9e14a558f8ab-3a6f1a481a8mr97260715ab.20.1731294873941; Sun, 10 Nov 2024
 19:14:33 -0800 (PST)
Date: Sun, 10 Nov 2024 19:14:33 -0800
In-Reply-To: <6718dc39.050a0220.1e4b4d.0088.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67317699.050a0220.138bd5.005a.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+eff0acb9087ee995577a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix missing validation for bch_backpointer.level

