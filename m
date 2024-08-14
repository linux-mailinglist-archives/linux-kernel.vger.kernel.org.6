Return-Path: <linux-kernel+bounces-285833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0AD95134A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE3E2815DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0422548CCD;
	Wed, 14 Aug 2024 03:58:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C2F4D8B8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607887; cv=none; b=lh1oCZIdjwvDHu2LYVmottUPfIatWZE6yKuR2VwcmvnAqX7jiabl+ykOzyt3AB/qLwTOwSQOf9TobFhyzFCq7+6snFCVeBwdeEMK7Kgvv+NJHzQFJNhkxK7RE+9DpA7t+FS2b6JE9F9NQl6i0/NMW17POWF/lO2jVpkYoe5mNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607887; c=relaxed/simple;
	bh=xarmgX6V+hl2GirLV804l2UeUWf2Msf/HBqIFnl2ZnY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Cc/dy7FchUvB+P4GRuZjQmSLDl0xVEyMg/7Ms+RIUfL7p/qPFJbpe50Uq5qD83RseDJxOWqLOv6ZTBd88feCz6qIOSh/Grdtgfi4DHtaSrtcGdZ7rVTbkSt+SoNvZX1g6fsw3AzJbFO8uxM3777fmXBaqbYKnPicxGt9o5Gump0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso746511039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723607885; x=1724212685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zy0kH3FtvEAY/lJRx6KNgcCBe8IP1JXRYh966cn9lQg=;
        b=OYsJy2SzncesqoqZ+2E+1u6fj5cERmhr1HZ4UororCM+jMVSSs3E9kOH8A+NjgDYKu
         UaDSVfNkYk33vVDU+aSWwUmnd6MAIIicIexomq9fp1fA/+tq+ING2G9WfYsi0liW8a/H
         Zou6qk2s79x52eYcfoNKG3LnVtyXy2jXZ/Yi0jn3qzVVmvB/fKobhHW2Tp4OyERs0JIO
         VhHEoUt8NtI5z80lDClLXR79FAbK+QlfxrkYBCmaOjwHUHEvZoJVwdzoCZ+u231j2G7C
         iQDLYY2Sq2VHvZlbF5besGc9R3hET3lfC2Bgeg1mVo986hbz9O5M/x8/YjzrzfCWp1MV
         nEEg==
X-Forwarded-Encrypted: i=1; AJvYcCXCCfD7Xf2oGzAa6pjH5dlAFkSZpxNGWpcNyuOCinrkA/NpGDOcGN905GBvVk7A7BzLMcxr8YNPlKzqV5A6KUCdEMaKLPlTFcIm4uhB
X-Gm-Message-State: AOJu0YyePANlfs4IhNjtuUWbx06hwx2ypX/AX7FG0h6dm88cmh24RdOa
	GPHcIM8KJ+GeADIpMY16c7xhDyhjXK0p+rdGZLUOSFiOkXcNf6eBpQsyMBurcVgg3GnydyK4AjZ
	9GTUP4SZRPYEVphdIKefISiyzjTs9C6u7XVqiXLlDyY46r9C6AXAYYQ0=
X-Google-Smtp-Source: AGHT+IHFZmitJwYSrclRmM77nXJngzBqWFbFhT3GbBL5VpnHUUerM6xB9Bcn9YVLa4N1mqTxCklpADLkH5Ps3ncucznXbcYdEIhx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fd5:b0:808:f0f7:c8d9 with SMTP id
 ca18e2360f4ac-824dae3c898mr2949839f.4.1723607885226; Tue, 13 Aug 2024
 20:58:05 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:58:05 -0700
In-Reply-To: <tencent_001B304B341B3D2501BAB0BB2733509E6A08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb32a9061f9cbb46@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_commit_atomic_write
From: syzbot <syzbot+78ff2855f26377625419@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com
Tested-by: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com

Tested on:

commit:         9e686969 Add linux-next specific files for 20240812
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=126f95c5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=78ff2855f26377625419
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1279c9ed980000

Note: testing is done by a robot and is best-effort only.

