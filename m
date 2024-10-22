Return-Path: <linux-kernel+bounces-377057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F09AB957
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88CB1C22B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D71CDA3F;
	Tue, 22 Oct 2024 22:09:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168BB1CCEC6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634944; cv=none; b=bBdeeSM19sk3dNN5W/sHTIwyWCi7+jylbvAHMECQ5MKlgF+9Wzvi6hADohZFPWarcGG9DkLCXiBP6w8nCKNPoRuu+a3kuQ9y7oTkvaS1SNUntRbsJBQWnuqdkmZMBLxOGXfBZ4e/IPbQy3PKKpmNblAwdOWgs3EuYLnFxafB97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634944; c=relaxed/simple;
	bh=7qFnZ0Os8NTrFYcTsRW2WxEhbLN0bVszViEHqACQc5c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EZFHnU1ENzbn5GHFDsIKLFR92V/ik93qjGj0GoOHtt0pstVpFrNBBVo0/4nWihyfqQ4sE2cR8W/Zuz1Bbq1zQuM+Lsnuu1IUnKSO6fB7xcSokTyd01RJMMmeIoLcLYp35we7KiNhe0EI64VjI8zosfDKenbbhxVTePMn20+N2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b2aee1a3so56829625ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634942; x=1730239742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ1ilRmzVCNdCSMlzy9bgdlmlXko8EZqRRz3Q83UCcU=;
        b=BPHeU8MREOn5zqoouRJcGwYMGi5rXzWHyhFpwNJJxM97JQSjuUWmhMofwqkRy1EdcQ
         wrle0LfgmTDhcCW2ztkVjYzpbUSLNhjq9UeIMQS41+bLYLUcE5oPGdydX6wq0Q0BcPBi
         BlhPRxm6MZsWlXORIRea8gs5Xkm5CAsH2MAtP7VQDMn971oacBaqGdJZpPOCMfspM3Ki
         BXcvdzYHuJdBTsgsknv9riLufJ4TXFhDTMHcKc/zYsXgpuQtR4bUnu/7p7cPtEuzVUna
         QdqV92h5lyLPLicIRE1NzGmt+42q/wggtOucGb3NjOT+amwBuDMuok5Ag3ZErk2hox3x
         AEQA==
X-Gm-Message-State: AOJu0YwrF2Bau5PBLdPGEB6h+pDmKzDMpsKVabfbkuZVrcbIV5mCTvy1
	B5vg6GJRQnpCswT0bGsLpu7csHZwNqgDf0cQIxWibDNMyNBn3bMWq1yVxgIfEj3s0AJz8HMfbBE
	Fy+L2mH4vnRUFr9AVlyktdXsJvqRxX9Lm4+0ikF9aXv4TnKUAEgpJP1o=
X-Google-Smtp-Source: AGHT+IHJU5L2OYPEaqP7Qs8JBqqg30MX7N9p81zg736bKvJWf2N+sN3KX+b9Fx0/gRNlQc1vpS12Nfd1AVUiA3LACs/UwEYVbWqX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a4d59fccf1mr5273135ab.21.1729634942285; Tue, 22 Oct 2024
 15:09:02 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:09:02 -0700
In-Reply-To: <c8IH934n7hOP4OxexVl1FkZewtnxm09Kgns9QF-3xW_f7GUGVd4D7_wOn8UfrXCO5gWdnY1OZcvJKd_Wmty8-9u-nnEq0ZCiKCx122GozyI=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6718227e.050a0220.10f4f4.017e.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in btree_node_iter_and_journal_peek
From: syzbot <syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com
Tested-by: syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ab8287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=005ef9aa519f30d97657
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1448ca5f980000

Note: testing is done by a robot and is best-effort only.

