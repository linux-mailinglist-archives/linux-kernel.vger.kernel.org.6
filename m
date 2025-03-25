Return-Path: <linux-kernel+bounces-574814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D55A6EA71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDA21892D03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159392517BF;
	Tue, 25 Mar 2025 07:27:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5214EC46
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887625; cv=none; b=fec1cblk+TYPWFE1Mx4Tw0L4ahT9Iir8VD+dUCfcerW1a2vxv0xYma0JMmcNOFBXiarZpbXliNRxL0h2wd/wWHHdBT96bcIVHuA0tcKSB0SVdVYg41TXilHxvSekBbpJ/l4zuZb0Yer9fOYAafiIPNQW22IsrtA6N61ziK3/VIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887625; c=relaxed/simple;
	bh=SBQ4BsqXnIO4TOj3rwcHfQIn/lE4M0swkBvVKYEovdE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iVGhQbl0JWpGIAFSCZIckLi5e7Mhtl67U2RUabQ8XAKFpW4GvouyldCNsa9RgKPHiC2wHs1aaRohvMlhxiQYpVH+lvR1q9IFU5KkjKifL1mgnRyWqPGl/7RxFVeU+WhAWCn0vsmzREcj6ZJWfaxj9m74bvX/wwRHhfCWcwtg+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85d9a52717aso419232239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742887623; x=1743492423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIOmsZrsv+RTELHEhjAEysHkJzb0dp5ZrqHIDyh5RJs=;
        b=OVm4qGdB7TBgL5HHkFKem9TkVNBd5Ad7W72lJyzAQPF+Oip6wIoHrd/T/s6x16sRhO
         11LZ57nciDMChSaOIIWsXRopud0pl/nc32Oc/Eip3cAmdmTtexH6cEvVH6Vla7POYCzc
         8wBrA48d29O6MlxiJGDLNhssTcPLGnX3SE0dCxZAtnkbpxOYt//1tdGT1tta91FzZU0E
         2BW3TtHB4fyXnZkQ2i3t7wE3yomkWiz2fSuugcW6JV43f12KJqEfl9kCVbNOXBg9HSwp
         T5ZRwSngjBxPeGBamDZg/M/FC1vXKL9NNnEzqzaX6PQzEW0eOEvuGhCIjIIM6yVHRdUs
         dHfw==
X-Forwarded-Encrypted: i=1; AJvYcCXtM0FSNWJ3LLf9d4ElrpUjY1n68nUz9ruTWoogDcyrsNrTKYGFVuu1YsIjhmxylaaImuxIk3AfToFOPfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnTIO9/kyKtwHhZ1gdHISmcfGRF893K8lw4XcQzkcqGuoZb6E
	/3BNawvxotv0qXvXwOaA+lKr8j+M1MelOJSo5Zr99+WgbxpywxKOm7Mf0SF0msp7GxwZi+OZ5fG
	1NOzmR9I0LNXiGykC6VPcX7FJvrZw9WBIZ/dJGo2oCGxpZ33+qTMOVcw=
X-Google-Smtp-Source: AGHT+IFoJZPy1hSiik2m67AzV6/1sFhMCXxZMqKppbHtTdVbq2md0E9W8yUB14AbVztq0rTObTwn3F8pLstyAp1EJijsZ5qXJjZ/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b46:b0:3d5:817d:6462 with SMTP id
 e9e14a558f8ab-3d5960d112cmr154224315ab.5.1742887623133; Tue, 25 Mar 2025
 00:27:03 -0700 (PDT)
Date: Tue, 25 Mar 2025 00:27:03 -0700
In-Reply-To: <67e2455c.050a0220.1f3fdb.7c3b@mx.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e25ac7.050a0220.a7ebc.003c.GAE@google.com>
Subject: Re: [syzbot] [media?] [usb?] WARNING in media_create_pad_link (2)
From: syzbot <syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com>
To: gshahrouzi@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com
Tested-by: syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com

Tested on:

commit:         ed492c95 Merge tag 'usb-serial-6.15-rc1' of ssh://gito..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17677c4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e0ed68747dbff9
dashboard link: https://syzkaller.appspot.com/bug?extid=701fc9cc0cb44e2b0fe9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15dba43f980000

Note: testing is done by a robot and is best-effort only.

