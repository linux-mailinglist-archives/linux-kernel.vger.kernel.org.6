Return-Path: <linux-kernel+bounces-524995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492EEA3E99F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D02E3A5E48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3CD3595E;
	Fri, 21 Feb 2025 01:01:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457BD2D600
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099666; cv=none; b=n5aZLNWx/KFLaLGH4idLXbbPGMHa/hNvP9UkPvzNyiDX3pG2uUE6B59nJ2QgtVTn/5b3lFBCWcM2oti/WFQ12/sP4MlsJoqj5Gh/NJkKvfS50w+L20aaBSQ2PdqinVP5DKvzzDJnyd8dOSCWQI6TGCmq6h+bhUzY093wuSF8YhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099666; c=relaxed/simple;
	bh=4/jkSPd+7SkkOw/6xFeJ6XK66kxAJEdbOzjm8nMZabo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dGygT4+RvR/pGdsO3yBlzIeuCoZW1y/o3Z0u8VBlspUlQFbHIkOSLsL5xdi3N7bTIwgb5XXB0S4Fhs6Z8/G3W6WbspCizoS03+tf2ZCJIQI7GZL9jB99afY08s4Jq2BAZX76syl+Og/4xFWzlG5FSqE+lkIljovnbDcWE2hdXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d18a1a0f0eso29699925ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099663; x=1740704463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPfQysImRr+xOu4kExsPqpYVpEICotxax76O4rF2U+c=;
        b=Fi+XaIPSpUBB+OppY8sVv80wptQ0B6J+WDh0vXOcSQTurlThKtRQ+41qs8zkQHzUe4
         gPdXae5JXWOz+7ZqGyUG2KixPO2W53DppBOWlHRFHaaOUxPMSGvjazyy8ZBKqfcJW044
         UeM2JP3mcE+lSQKIkmI1fO6H6WMV5+Xoe5Zm2njSTcYz3GyxIPoHltG7nTH1796S1HxO
         zkgExovQnqje8YLdHrrlsCVMN98xw39EpcIZNH6l3fbCcDLZGOTCXW7H7+WARQpHbdbT
         oJTwGwgdyafV5RKYQkfW7XJdtLFPd+ERF6eGilMpSI1534GsYyGD2SVcWEDV2FUmj4xf
         1Upw==
X-Forwarded-Encrypted: i=1; AJvYcCWedVUr1AwjTTrNi6UF5jvqXjFhkuYmvBYAlbQEIFciaUDlcvgtEDJJ8eD5sxwpRTYyS662kJi5Ut52Ulc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3k0AttAWu7Gl2/AGohkLIZ6NfVPH3kUZb8mdpXgL0z8jj9+PB
	WiqAvyH3m/WCr7hZRGV4oo4vI2TUGp1B1XLUbLR698QXQZmIrus1KMlKIEayv0ud3e3VxfQtcAs
	svwoku5ZvD5nMfXHervkT1EizNs1z8ruLNhnmQ7+EztAHIHMxhpG5Xb8=
X-Google-Smtp-Source: AGHT+IFmlldBkF8QuqaN5ZkFiYY95ZxCZ6cNqSwuC6w7OcrsJlpJZo3bKAh8Iil4mYll5ouOOTyglBqplx9P1Lfq9fPXSS5CINTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168d:b0:3d1:7835:1031 with SMTP id
 e9e14a558f8ab-3d2cae6c63fmr12541445ab.7.1740099663233; Thu, 20 Feb 2025
 17:01:03 -0800 (PST)
Date: Thu, 20 Feb 2025 17:01:03 -0800
In-Reply-To: <67b75955.050a0220.14d86d.02e5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b7d04f.050a0220.14d86d.0303.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in h5_close
From: syzbot <syzbot+ce27f6f75880d7fe265c@syzkaller.appspotmail.com>
To: avkrasnov@salutedevices.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3ca66179e56d25f1e3ed1608241abb487c63e9b7
Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date:   Thu Jan 30 18:43:26 2025 +0000

    Bluetooth: hci_uart: fix race during initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102567f8580000
start commit:   e5d3fd687aac Add linux-next specific files for 20250218
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=122567f8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=142567f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=ce27f6f75880d7fe265c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f2ba4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123375b0580000

Reported-by: syzbot+ce27f6f75880d7fe265c@syzkaller.appspotmail.com
Fixes: 3ca66179e56d ("Bluetooth: hci_uart: fix race during initialization")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

