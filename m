Return-Path: <linux-kernel+bounces-285811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93E95130B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC4A1C212A1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BEA383A1;
	Wed, 14 Aug 2024 03:21:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310F394
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605664; cv=none; b=B0QRox6NjIAZzhjG1IqGdowI7dDx5+r32do1WJtyBbWFGJ2WRHd6IUnzbdAzQ+IjXwyrcVA+MTs1EdrUGH85vwiWVvi4Mm+4oj2J2/rv3WoRdb9e/yF9GR0IG/2nFIAGL7lysR2PSoDasfLutmjSsIxo51MboouOutzR6pG1nKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605664; c=relaxed/simple;
	bh=3QiDnqCHEQ46lmUl9YmleytrkQ8uAgIxKEHEJOmI+Zw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bC949gmMW0ba+hfphZqLouz5Y0FUClf0i8R7p0UvgSGVk31Kd/m9G66d9NZbokCsV0TUTBxlTbeyTYeODqDctvDnxwBt4bTXKDK1014zWvCISoZy18MQ1Vi/8WnazPRKpnRibyybV9gGzywnlKHRF9pjfDU8ViArg7gF5K0V9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so819020939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723605662; x=1724210462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeOzwsxqi4uut10yzktkikUuXeNCFeLLytVzbuzAQVc=;
        b=qNA2Txg9zJtkckgoqEObCWpkP6ajfcffMAcUh10Z9Zpv5m6LFqC527Px3Q96gmLPKP
         RnI9TvloPTdzqqUTexlLdpHWjPPiFfau3NLxgxq88oBssdljVohWSQVUgVbTcOjlGAlt
         ObhxtPgVY6OlVH7oFXKQkg8/1Qi4MfU1iuBCCMe2f8EA4D+PXho2npHMlHcRlMQf7n1l
         qGV2h0eb+hwXh64Xw8rPNvyq6lvaAQAk10FY1ABKNTPOdMYGlMi6JsljymJqTO2S59vS
         VFjGJrrIhiupTQYYvRNXTDxoxJsSF0R71V6vPIqFBPaO2qjOI67YOjtvD3pozdkUwYkF
         j4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMi8YuNkXOZb2B1/P3DU3mwEdrRBn2yWimzMv4bxJxti+xXzRfz7gVmleGeV76noSK7BNpj8tQw/voAzS7U34zhnpL+5wKbA8HxPCX
X-Gm-Message-State: AOJu0YySwvm1WtsDD76jgkmxJJbbR/UJKiX5NLCgVd3sEM/3yAVVuw0X
	XfRetKCwqnVM5Lja31ge0rZFvs/aPuF/g5tJjhngBV4cdK7NfSRQFc6MTmoikA/qxToTr5kSRlq
	0BqxYrTENHtbYTjYyW0a8jnOVfgj6DNax/N/Hu1diLDQL2Jxg3hzgsAM=
X-Google-Smtp-Source: AGHT+IFxkSO3aZTNJt8hWQTD3LoqkCKnVNyDTj/OWSvEOT8GzebrqSfd43uiKYo16jcstJ3dEOq2saHmdnj4TPPKy6dnZ0iDaJm7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9827:b0:4c2:8e08:f588 with SMTP id
 8926c6da1cb9f-4cab08327e2mr67442173.2.1723605662600; Tue, 13 Aug 2024
 20:21:02 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:21:02 -0700
In-Reply-To: <tencent_E51B7925E5BAF4BBCF33739E5E1BFA4B9F08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000409ec1061f9c376a@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_commit_atomic_write
From: syzbot <syzbot+78ff2855f26377625419@syzkaller.appspotmail.com>
To: chao@kernel.org, eadavis@qq.com, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git on commit 9e6869691724: failed to run ["git" "checkout" "9e6869691724"]: exit status 1
error: pathspec '9e6869691724' did not match any file(s) known to git



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 9e6869691724
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=78ff2855f26377625419
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f2af7d980000


