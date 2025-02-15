Return-Path: <linux-kernel+bounces-516216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B4A36E45
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D4E170FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9432C1A5BAE;
	Sat, 15 Feb 2025 12:58:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78BC2AD2D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739624287; cv=none; b=E6d3v10Y5vXO4gZfYhwNfG976IRXe3DsHQyF1m3ODmlimDUpw+J/zk570nToZp3IHsHWUkl3lyCy8ATKLzodWOmFajl5bzhkG11i2wMv5A+OqAmx0OfxxMJ8y87Sawf/CQvXCgvAyk9I75Z1qHGGzAg4AoyZRXkDstyDa/6Vpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739624287; c=relaxed/simple;
	bh=qUOKmRDEGSnF4Pzp94qlrp32fYZGL4Y9QCx4YwO8/rE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Cvk97Gi6QFWuXNrpjRlNJJV4FCHP0ONiSRs86rE0wLnt53UGCEyqiQft9wTsUdFEQiaw2zQTJ7R1ZLCs1bE9S/Asez1gYfout9wm4ohvZBM/tS83HMfOYcJqFIhkHJpzvmccRzU6YX9zqaUerTe7RIIstUsDWsM1OKNffFzkzyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d158477b5fso19364405ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 04:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739624285; x=1740229085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvIyoKFkKJkE4APFgv1fclSgzQUADvqZn9LSd6dD4eQ=;
        b=YKQjoBZQLAv1PDh+xk87YMHEW3EKPwWYGjIqibDHyesZNw6/573UoN71gv+hTiTa4S
         KCpDqd1y2dZuvIRn/T+bfu2MPtiCWX6Hp9Oe8ZHYqhwCDcSIdgIoN3CXHhMg4NkvSqKa
         fp8qEbJPQixM4VepxjDErP2tv1tEk0mPwF6KhozBGtVI9cRDE5/n+1wTq6IbmP7aP+TN
         eufXhmx79kJMkCpnMYIEoUASuPMErgib4TL/vz2SJab1VTkkyx2Z6kf6G5wLxXpWnw7U
         DX0QsEuIPp0H/OL3UjXeiKhbqQrTFQgu9AgEzL98oQSJ8ci/GrY3X5kM/WCG9KqbjH23
         SxZg==
X-Gm-Message-State: AOJu0Yz1rB8+rtsKNtPeOdGdcRwnz4Act3bgpnwG5PqNcVfFXEs9e/Ht
	53hoiikCmEgA40uLkYpMrktMTCyLSmw2KvS5GoNMTLzz/ypOHMPwNbPnM/S9Ktpsi1NSymZQBGV
	jEqyfA2sAnAVrliO/AbRIAAP490Mnizh+bvfsNDeH6eCLlBvHfVJ7QX8=
X-Google-Smtp-Source: AGHT+IG9Qeomynodxj7mGb0vap3MDCOJDFr5IeFouGgnAPP5NtSRPgJVg+zTijlqg+a1TcLVGMJOEB6PqW0S/DRZ9lMIzeuL6dW3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24d:0:b0:3d1:966c:fc8c with SMTP id
 e9e14a558f8ab-3d2809066demr22350725ab.17.1739624284978; Sat, 15 Feb 2025
 04:58:04 -0800 (PST)
Date: Sat, 15 Feb 2025 04:58:04 -0800
In-Reply-To: <CAMp3bLVAx01Kd_UEK_sGTAd1ZgXESUcX497bumaKjt+nX8iqwQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b08f5c.050a0220.6f0b7.0008.GAE@google.com>
Subject: Re: [syzbot] [ppp?] KMSAN: uninit-value in ppp_sync_send (2)
From: syzbot <syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/net/ppp/ppp_synctty.c:502:23: error: initializer element is not a compile-time constant


Tested on:

commit:         7ff71e6d Merge tag 'alpha-fixes-v6.14-rc2' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f20bce78db15972a
dashboard link: https://syzkaller.appspot.com/bug?extid=29fc8991b0ecb186cf40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124f99a4580000


