Return-Path: <linux-kernel+bounces-447341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823AC9F30D8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9931881A54
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2141C204C3A;
	Mon, 16 Dec 2024 12:49:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52864201253
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353344; cv=none; b=a5iBj2tKvOaBfh+yDBSqGCh+2z2qC0cWbGzGtn1IkGYjYAtfAgAJESUgREIapXK36pfCNQCnbnBmIkaCUi6edeXPQF+BQWwjZadb+xInhPZSBdYHfEcMwewjDtbh/F4BX3PcBdd8MBQcia3zSkvXvwWMINDFubwcNa+sI+6zjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353344; c=relaxed/simple;
	bh=ezkfwuyhko902UPw/+R40j1VtNlmOuNG21cB8SOqqvI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NbajmCV+fIwTX2mRXVLzdFCqICHBjAot+2JsQsZ3WlZZqeLznzTSmb7tXljnpeL10LVH/soDdkWpczMJWV8OEoFzQzh5cikFIq19wwN2SvS9WU5VucaYkDzWk+P7DhZR1R5PmtnPV72hjxGeZbux+QsQp5BCjT7p7MF+uAbZBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so37511425ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734353342; x=1734958142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWTEIyubml9O8xAX8dt+mKgEMR9325mr5LqgTAD/eJg=;
        b=AAJi81KFD+dbnV8TbrISQKiGpva3YT/jKZ0e/MrXktaeeEvfHZftm1m+IlPjSX9iZz
         8PF+X/ijUc3+Q/jSd7caep42J/SAi2xYF4ugnDQDq3L5MQ9cfqrsofUfmBek/86+SZey
         p7SLZ9F4lsVfQmLFxr8rrjiM+IPen99kaSuZ6o75yPNY7eUOItnYD2YD7mVTpdBna/Ap
         zxrfo5Uy8Y1AqHtamteusDd0vrYySlUiEPOw64Sd7TXt3nM+GwHkSIU3x+BBsk5xBCx3
         McJOzTg2Mjt0qTvzRWmrRBhw6rabzfocVbc3t55J4UrQ5Ic74qU5ti+4Ze2Qn354UINz
         x4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOWFyXBOxaKFoTuny8Bp0+Ra8femYsz9P8hfbJE80xIYDYmaaDEDO/kQkt2V53Tov3VR86Khl2FEkhreo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1OV+12TtpO9QYImbr1OL8Se7P9hsTAtkZmfgE1ung6MNnPvf
	YuzbgDwS6wsAzoHYP5PReLhU6Y99aU98S6VcC/3QZ1Wt/Icix9cCwT/XtxPUN7Gl6T97cdfz0CX
	q4gAcnTBZ6dUEG/d8+mfzi5/e6Ct6HHqTgzir1TrEpy3+j3Vbr33J4ao=
X-Google-Smtp-Source: AGHT+IFFc/VGaLiW6Px6JsOi5WIH5AncFJK0AG2sXKlsHCNHRIcotSPgpDTRnNsiJ/dGt3aOzt1D4fYZLie3LCsA4bqBfogX6dp3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:3a7:1c73:e18e with SMTP id
 e9e14a558f8ab-3aff2dd5cfbmr131261485ab.21.1734353342476; Mon, 16 Dec 2024
 04:49:02 -0800 (PST)
Date: Mon, 16 Dec 2024 04:49:02 -0800
In-Reply-To: <tencent_ADCFBC7BBA6D582D356CE49658E91EED2A0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676021be.050a0220.37aaf.012e.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in bitmap_parse_user
From: syzbot <syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Tested-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com

Tested on:

commit:         78d4f34e Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1713f344580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cac7e24ceea492
dashboard link: https://syzkaller.appspot.com/bug?extid=0aecfd34fb878546f3fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1003f344580000

Note: testing is done by a robot and is best-effort only.

