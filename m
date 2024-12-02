Return-Path: <linux-kernel+bounces-426765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0869DF78C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC8228156C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7AD530;
	Mon,  2 Dec 2024 01:01:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD03D81
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101265; cv=none; b=oVCeLXtOvvwQoJRCIUKEjqtoSacdKac9cNnsSitx1YBAaS4gCP6uPGyaJJBVMxnOy0xVgjn1t5rKCSiIKdmZd0QZrRtm4LvYnd6SujV+iDrtldrPjkT7xBYtJnD55thYvSn1yK6zN0StSsNnqW1tt0pXCAag6u9ZB5wOfQDzb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101265; c=relaxed/simple;
	bh=Z5PUXNs0UDX53gtI3fvu1O5uItvtENdRXNv8x2bJKBg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R6P5o3vKZwn4SW+Q5uqWZNdmxECUk4/OMiBRFGXOYjqIa4dD7zep2LbSo6jV13HgIhFIQnsVvg0ZpRm+313CtXIPDcRfq/01hiq18mSfRZON33lwdMjtkfWn1d87pjRGSTnlPStZ14GOCNLsv4g20BgfkijONlyM3IE++TNX0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7cff77f99so39826065ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 17:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733101263; x=1733706063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LvFIpu4lWXSvFNgqYGId/xldP0TT3dmI0mpE5KY3vs=;
        b=oueZ2UocwVxWxJX9mLzQiQx3MuWhwLj61JVm4XxMe1gohv4jbsXL6UVM5/v7yH83NV
         AfWpY138eKkIRzLK5RepTeXkHveHw4wKreQzKVNUCWH5h2bGJVqESHb1G8iPkeLphmra
         sPKJLwPNAY140bITtTW1U/e7BKF2eVyC31M+4cIj01sTpxSR1vOg4Qq7ANlM8l4MB5a6
         EnPl/UI2O2ESkPyO+3mjagNNoCrr5duwrvWJPObEPUhfltQqea0nFBzxXNwJWdbTAZTb
         9GxxUV2+HgGUIQ3ubFPQxOecAC5DeC1w7jnKSm+BR3RcU3Gc4wHV9C5eDSMpu/ViWgBz
         /wRA==
X-Forwarded-Encrypted: i=1; AJvYcCVcsGYAu7ekZLcdfQmcew7PSwEJmRre9JQGr57zC3Yhld2gIkQq+bY4sa7lIvCBkzqfSfwuS7jdxtN1CQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxp3PEVBywh1A6AgdX4RNfbfAD2bauRjB2g+jpSeArx3bPiNSe
	FLWlhgJnpSINa4yl+lXLsw8ZRci9lV0Gk2w1F6s9U1exb0Zo9V/m9eLDB0wMMjhCmbw16rp6DNo
	Kp9gBPq6qenMSbY7NXl9+a5LNlX8MoefIC0pUmXNlSXqBTUn+gVd9AZQ=
X-Google-Smtp-Source: AGHT+IFHvgQIL5sGRs6iH6tMhdv5xipZwjHSDXGZyXy+epVf3b0cPZN3VmgjM9ROa1uUzWXPcpGi2js/i0B0CE6vtkTBJ5q6cwkl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:3a6:ad61:7ff8 with SMTP id
 e9e14a558f8ab-3a7c556a18fmr193003715ab.12.1733101262766; Sun, 01 Dec 2024
 17:01:02 -0800 (PST)
Date: Sun, 01 Dec 2024 17:01:02 -0800
In-Reply-To: <20241202004104.20604-2-leocstone@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674d06ce.050a0220.48a03.001b.GAE@google.com>
Subject: Re: [syzbot] [udf?] WARNING in udf_rmdir (2)
From: syzbot <syzbot+5df2d3fa14f2d3e49305@syzkaller.appspotmail.com>
To: jack@suse.com, leocstone@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5df2d3fa14f2d3e49305@syzkaller.appspotmail.com
Tested-by: syzbot+5df2d3fa14f2d3e49305@syzkaller.appspotmail.com

Tested on:

commit:         40384c84 Linux 6.13-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135195e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55aba29dc49cabd6
dashboard link: https://syzkaller.appspot.com/bug?extid=5df2d3fa14f2d3e49305
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17faa0df980000

Note: testing is done by a robot and is best-effort only.

