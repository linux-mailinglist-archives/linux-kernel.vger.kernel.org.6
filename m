Return-Path: <linux-kernel+bounces-204339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F8C8FE769
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883481F26CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18C4195993;
	Thu,  6 Jun 2024 13:17:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE30645
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679824; cv=none; b=nbCp3een7RVm0E/sImRY+Xveh9WVLXBLAQ8vORKf5Y/Zs7dBW9CElVLypDjm/VfObR4XEZ8D172kJeSKDQEDwokxKVOF8HGgnFHnKUOXK14wpYbXLAj0DCcYh7yWogKdBmLQ8oQ35X48IK6bbVOnpRs8pSIYF4sZqrQdoH7PhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679824; c=relaxed/simple;
	bh=NSR54bD7P5KNnPSlPs4dhmlt/V2i7pKFpYXVlC9JkWE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eeSUxkLpctP0QCfpmAmv2c6itc357aGqLocAH0X3vjfHmP5t80VXAqWy21Tn9Mi8ZjlbpZCaAwLUk53HXD65bU2LeMgrXmRoZjVB66gubuAtBolsdSLV/r0aS3ZinWJsIDFeK24GRTArtDCdrlx743lBTomjX8uaWKROCzTe0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3747f1b958bso9616375ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679822; x=1718284622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beKx2y9tr4j0XFeY8QaqlP3ofACHCvbC4fKCms+Ea/w=;
        b=Tgkt3EaFRBwf4Lc0bbCf8JrBgs69KeojN0J6pSePaav9Oahfn8X0As0BJUsNMEkZJk
         ZaccOlkeUFrcSFTUgw7i1FREkceZEan0C4bNsdSV+NfnDLV2oX+e9n09jMDI7O4dPJHG
         4ZI/VvSisuOs5If3YbmrXjaI/a4aV8TQXAYzMFfHnTalmQc8/Sc9Tbksus5hF/m9iVvr
         ozPT8yWsPDqhVQ43HLsmNVDjYYpA+jl3dnE8OQSqRLvENK0hFpHLepDFHtYOUa97uCFS
         yKODAgFbhY1uJ+d+aqCX76JkXp8dKloDM8s9ZIgOPiQXncqpuf5moyQgkYpdnSD19IOm
         i/WA==
X-Gm-Message-State: AOJu0YzYUVK1k5c+g/grd1uvKDuFUSPID3kgHTaBXo8tUduH605qVLCw
	IDmwx1CUKZrkcTbo4qPQOPUX2t8z8ERh1O2gN1uEBLeAZ8iymU7vvlb8t+gbCc2uVGmk3Npo9D4
	Q1bxSZtJYhyHrFd20apVxslXP1cI8N6wLGgqmEo0/3QfxMWiMp+cLm6A=
X-Google-Smtp-Source: AGHT+IG8BjAG7qxkCE/A1O3XYjuFzwSAADE2SK4KNxSXhdnC7/mplwOvcBgCMR1G7QqbA/MYYc+cQxcNK/FilULG7Vo7IEzwJM2h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b27:b0:374:968e:7ee3 with SMTP id
 e9e14a558f8ab-374b1f59084mr3446575ab.3.1717679822243; Thu, 06 Jun 2024
 06:17:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:17:02 -0700
In-Reply-To: <PN2PR01MB489146FC0041ED737236BE64FCFA2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a49ef5061a387fd3@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14224362980000


