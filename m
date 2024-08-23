Return-Path: <linux-kernel+bounces-299340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D458B95D32B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C40C1C237E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69168189BAE;
	Fri, 23 Aug 2024 16:24:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172F134A0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430244; cv=none; b=qjE1VXvZ4kYaD8WqjC2O8zWGY5v3OWlg5M6LCoTaqzQzu5NS9g5ZzZsWeOGU5oxXsoaUmQL5elQ/Jfx14brv22MweFziknkH8Vvq0jMv4y/ZVWk1VqxNDrgBz8nWgf2HhhAo+uV8Mivaq24xheRqokGCSDSv808E+PI9BYX8ss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430244; c=relaxed/simple;
	bh=+dUcxZCRPp9sDzc9kWJVrJIUXSx9K+C1tMGdjM0XZJQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DIqxhGK2YrU0Sq4RnBw/TUABTYc+msB/nfiCDH8r+L6ejKiOi2fceAusZu7rQ+n8rTkTywUfzTIdXbGHk/67vEuljN/Vx+5NuRSLxKU/wTcOLTj86mOJgzpli0w47xyaBrF12Cm7XRS8rwlBLP1n43X3Gmyq0fsIbhotqmKdbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81fc0896188so220166639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430242; x=1725035042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R49eMCdc1EeKu5shIzC0L4dTA6JLOlR+2/tzRUfA6dg=;
        b=rPPNx54sERXBUwgVOCulheNkffU2BOuGtrtvr12mloNkkqR6PKa/d0XES33ulPEOOo
         Ik7gmhQC06efERDa9/rmXtXnTktl12HbBsRnZsl/tnCJ6hB5ikkusUxq4JyaZTN4I1Jz
         dvggq3SYBHBBqQv0YH8A65ieAUCuNcZzbP2uYG/Cwojj4JBY/DBQwhrahs17uESV4dCq
         i3KU/OtuupDJhe5lnrtPJtF43GWhHwKP5CCt5cW+whqEqfKWdKGSJfB5wgAN6GM+HCcK
         1m77kG2WrvMn2LF3kJgfb7K98Vv+ygqnr6ETMl+qFY7YanQDuARPIBSp0oj40rMgadM9
         5E+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSbNM3GIRfV8dynbRVSQRTUvsdhOj4f4faiMFnfb9nk//vewNmybOTy3rrseOWU+AV+YsJn+uxhFhaxVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+EkAdN0YL66igI+LbxZ3gN0ylY4ziSkiK9KGeUbIv04HF1fG
	FQlACtLPm7UeeCEaNfX75TSF88VTrKymmNvbr2wSOsj4Rr2dNIm9zHceobxptnX26Ul172FYpp2
	h+UhDvVR4fDZ4zFlWtjRK2qqEiShyR5knR45av5KPKVMK5LOFs2/diMs=
X-Google-Smtp-Source: AGHT+IFShC+bD+4HNPXEYRtxC4W1Me34JrhJ6DCmFIbfS1kNV0N6Z6tK5ZtH4uXNIUjF6soLfuyDC1UljN6tRtulKznzWCsxGAD6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1485:b0:4c2:90d0:b311 with SMTP id
 8926c6da1cb9f-4ce8293ddabmr142387173.3.1724430241758; Fri, 23 Aug 2024
 09:24:01 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:24:01 -0700
In-Reply-To: <5ff534147df14a938c79911a34fd52bf@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000252406205c3432@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_mark_rec_free (2)
From: syzbot <syzbot+016b09736213e65d106e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+016b09736213e65d106e@syzkaller.appspotmail.com
Tested-by: syzbot+016b09736213e65d106e@syzkaller.appspotmail.com

Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14fd6dd5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af26d0d182db8829
dashboard link: https://syzkaller.appspot.com/bug?extid=016b09736213e65d106e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

