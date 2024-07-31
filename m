Return-Path: <linux-kernel+bounces-269327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0BA943196
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5713B285E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBFB1AC444;
	Wed, 31 Jul 2024 14:00:55 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA086539A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434455; cv=none; b=pveVRxUJUrZl41mFRBFhrTcdkkUrgPejMgQFqDhC/LkIWfUHGaZ9G3JDLrhSrquDpUUuE5dLTHE8P2Wv5dFtKMcCOeXBBZ99yqhSU2Ylx1QQtCIXWN7K2hywM8GlrZpkg5EDYZbFs2GWmyoV4NnO+GLvo9UsOoIu5KVznCSkJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434455; c=relaxed/simple;
	bh=eZCMowm6c7mmHswkSmEDYF5JIjJXeT70V7J/z2xj4JM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FY8YVFlBF1mQDlkZCEp3NTWIV+CZbQ+QMzg1dnGBehQ7u4QdjT2NFhsCjPhYsGTqQQAlVLtUWjPL/jC7kiPEN+AWE2Q6j8fbKJPO7pjHs1HVcKHCrCylMGlLP31Zj/08iIYxS7b36bsRN5qQPReevw5ueajECdNx5i1roD1w8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f897b8b56so123205139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722434453; x=1723039253;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZCMowm6c7mmHswkSmEDYF5JIjJXeT70V7J/z2xj4JM=;
        b=Kik0/axUXsRfQwjb+dELvpnL1lrQNWRtuF5BvuGPgJoZGQcMlXcy8c/v7r1eWEQuv6
         zn9gO0uW2fAh0Ac52SudcvsJevJ2pSkwCZxCDzw2uO1rckMDr5a3KS7bFU5DWrYCnX+4
         mQ1C2zIJiPyEgjcy/VU7m/v3FBqBTKwE/c1rt/UraicUqEJQ2L+opV8ibJRZ0MpMdgmw
         6Iy+pWOCSZgSlRPbAivlDi2TU+AypfcGexku3crsqZUjWTarmcV52s6yfwL0Vwj4y50n
         6Gnn/obvxXoyYteMIVMH+m6GmRG1MWar/9qgaM137pbn9YEl5SLLZ6F6ZITnqzUfHHfb
         0Qlw==
X-Gm-Message-State: AOJu0YzYaU38Lhl3kSZE4l7SAt0bNGl7Jv+2stsLMp5fvBrW1KilwP87
	hvp9Klxo7HxxTSrwIAeRL7ed8QuaIxp23tvhnmXRqTGP42BzrIOxyUcu3Q6GfOyPjSvilX/wxJy
	98mvsw568b/O8u1V5fjyyWUZuc4pafCSt/6iL6UM/f85PpHsaixHZhpE=
X-Google-Smtp-Source: AGHT+IGrSYtz/fpaGWPBF4ZimFKhyBhcSi1bO+RlogBXdMyOMw4DnYL6iBc8jbUGrEO0n8Ybz2bm56RuxNQ/dp8g074XH/HppDFv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1353:b0:4b9:ad94:2074 with SMTP id
 8926c6da1cb9f-4c8acbefe6amr157808173.3.1722434448822; Wed, 31 Jul 2024
 07:00:48 -0700 (PDT)
Date: Wed, 31 Jul 2024 07:00:48 -0700
In-Reply-To: <0000000000004bfcc9061cd39752@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078a294061e8b852f@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] stack segment fault in cpu_map_redirect
From: syzbot <syzbot+6fc359860535c8a466fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] [net?] stack segment fault in cpu_map_redirect
Author: bigeasy@linutronix.de

#syz fix: tun: Assign missing bpf_net_context.

Sebastian

