Return-Path: <linux-kernel+bounces-180592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6698C7092
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 05:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC49281990
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 03:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134604436;
	Thu, 16 May 2024 03:15:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64623A6
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715829309; cv=none; b=qZmCwRegHtG/i64MGYf+Lmt07Lwy/OYpz4fITlu8t91tyuu6r/5SfPmN9pu5zk1OLBsOATMNbwqzXPkDLRchjtsmcPKq2DhKras+TcTQ+NPRNx6LCCu7KU6PhSFa5UMqHq1REXrfcLwwgh2fJjPbCpdLwVhZJcL1RK/WNWYe/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715829309; c=relaxed/simple;
	bh=1yw3XpZLGUoO2qQOr3I4kX9QmYuJiEIoMytGrMloAVw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QCAJA5YBGcTCSlJHHwgMR3iO0vYeGPHX7Kg8Eh8RyJz3pm2prhHcr6JU617cCy67BnIw//vuEhdUjsbE0Ki1pcCGKMlisDDStmgLyzArH/Gb8P5i7qVTPFOONKijLzQV10Zpjpm84dGxiDCdd85kQpXFqO4NjxVSbf0WpE5Jdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da42114485so878953639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715829307; x=1716434107;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eH3WMOMqxTdZPDY/Z5BEhSb0EhhkpBD5NwLk/16yKEc=;
        b=tq6NfApcL4yFwhEEJV1cwDy8daBLAdmRfYg4VW0hqfe9whJ3APHZ5rB+J2/pj+zWcK
         x1a8psB8AkkBrdszQUwSqfYp+1SDnB4ZI5QW3Pki66Z7kjESMFkcsjgNHRnTTXeJwQRf
         NQXZF8Z4uKQDeWeuxOtM+wKqU4twUh66jcbaonZNnYanHTtyRC0sCWtNq2nffBmKkRmH
         ZW/KKvY+v6tCEP/og8ZYifXhjPy/c9B6mX2auZJ61YjB4FWanLvJFzltc9M7lAraVgpV
         eFNQQwHrriSa81LUMXDF4WTFY8XUrsCSKqUzrlnp86qR2nxic02y3AyqDj+wNDHut56q
         L8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUVP3BCI73pFAFUTFloIpZl5ywRSQPyMleYoyyzQpcnF1zSYAwMA+SoWMOqQEzPfXPUeQWTeHn84j/JvWjvrFQGKYmoQqBg43tZzF4F
X-Gm-Message-State: AOJu0Yz2o5wtKQoIP1Sg3HurAiYchxsyC6NJQxCE5+tX+t6MoB/RTgFg
	QXNYG6kZYsRIw92q0DyBVHDHl6eBJHIgGT5v4KjCpK6+1Fgn5Y6aqFv3SGR2cEx3Lz34xOeFaC9
	f1SXQmMJyQuK35Ii0lEQiAIaKuJ5xrXAZmrb0n0HZGDc4nreePQYr6Wc=
X-Google-Smtp-Source: AGHT+IEIBLWpoSPhCBd9STvIjrVsKaqV6Ind6L+wNI+R1OFJndmfPSy05DCySGaUJqbt1Dzt0Rrz+/gB11MGnv6rGx5/lNmRSZRJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2510:b0:488:c743:c17 with SMTP id
 8926c6da1cb9f-4895a39dbf2mr1455198173.5.1715829307410; Wed, 15 May 2024
 20:15:07 -0700 (PDT)
Date: Wed, 15 May 2024 20:15:07 -0700
In-Reply-To: <20240516015201.485387-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d234c061889a4f2@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_fs_journal_stop
From: syzbot <syzbot+10b936c5eaee2819b49b@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+10b936c5eaee2819b49b@syzkaller.appspotmail.com

Tested on:

commit:         82d92a9a Add linux-next specific files for 20240515
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11c02034980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6e710494e484d15
dashboard link: https://syzkaller.appspot.com/bug?extid=10b936c5eaee2819b49b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128d04f4980000

Note: testing is done by a robot and is best-effort only.

