Return-Path: <linux-kernel+bounces-201873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985B98FC46F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5428C28A9E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F374E1922F8;
	Wed,  5 Jun 2024 07:22:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0B1922CA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572154; cv=none; b=PI+h7LpWZEIBx65UA1ywkPPeENkVuCV/1fDKg2dwPm2C87vviLETd1t4RhrA8WK+9ckEIYCpWAaEuHv0ioebNPUic8wu9MoVHqXqiPIBmolKlzRWhd2QFxlQCSTwmjdkhMTKz4bMw5TPQVcfK/k7nSZvLgm63cF5sN62y+JJHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572154; c=relaxed/simple;
	bh=lro3mCFjtFUdno1sdsyDe4qop6S9j//a9rrNG06fmXc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sWZvdg4pLzPT8cYi2hSi6b0XlIItwfBwDF0QWDPhDo2kde5VwKsWsqwmCE8Yg+871Aa8cQGjvrDW6OaasRyB6p/NRvRSvtsDU9rJmv4O7ch9PEkzcBqlguHdWsX9OiIFGw9DrxnlpitYS6mGMw7psJUSOuJ1jVzGjiVZiLfxjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb01189491so230464039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717572152; x=1718176952;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVbfPAz7yPBJaOxjtXsyWiEgQ8NG3RgtPQ8WAIdk9AY=;
        b=iANMZNUp4Bh8dqD4IOomt42e9hUqmApdRiQ6AJnPQGV+sIAZWCqfETa++bsEXFdTDQ
         tYUqfWFIcik9Kqz5Dn3SQQO5TaIwJYiSpa9CxUpw92/4rhJ3JC3ncRSRsDfDJ94jD0oh
         wSjw9mmiaDI6vJ0xUah7oM4o7gpWS5B3gOgeBlvY5pnDBBgM+j0QF/nv+kKGRVj6egti
         bGBPWKfqlQmpkaIepQx+k6TlSq8+s+sMgNQhjA9Us5igMCoKltsE1ZC6qN2xybb5LxCQ
         A7sjDNfmB6d1Odx1Dc0XZ+FYaEDf+POiMJN+Y8ijgUmkJfVeCpnkgpiSJLWoqJQozXdK
         2guw==
X-Gm-Message-State: AOJu0YyotORKv4Wn/s05zK3E4mZbeW3eF/qR1fxnE2jloMm4j32N771d
	UhroXcb20Bc4/+BTaWvjQ5nsrXgbWo9ohyg1Nju/22d3obTt7OjlO71/yLY2mOJMaVRVHCZ5mdC
	IAkbY8TYLxz4vtzH6HLf0onV/PgSOvN7wNXdFGP25ZFW/gI062jngwdY=
X-Google-Smtp-Source: AGHT+IE7lS+jL41DSOqGVho1cMvKk4hRl6V6URlMm/jBPHHBxTpswBEkvsBWI2413BqHa9K9qeYVx2slRt4LQNLL7fhHPJ51oRKt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a24:b0:374:9af0:5f5a with SMTP id
 e9e14a558f8ab-374b1f88226mr951415ab.6.1717572152375; Wed, 05 Jun 2024
 00:22:32 -0700 (PDT)
Date: Wed, 05 Jun 2024 00:22:32 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004c91f061a1f6ec9@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
Author: wojciech.gladysz@infogain.com

#syz test https://linux.googlesource.com/linux/kernel/git/torvalds/linux e3=
77d803b65ee4130213b3c041fc25fdfec1bd90
________________________________
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
Sent: Wednesday, June 5, 2024 09:17
To: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; syzkaller-=
bugs@googlegroups.com <syzkaller-bugs@googlegroups.com>; Wojciech Gladysz <=
Wojciech.Gladysz@infogain.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem

EXTERNAL: This message was sent from outside of Infogain. Please do not cli=
ck links or open attachments unless you know the content is safe.

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://github.com/torvalds/linux.git on com=
mit e377d803b65ee4130213b3c041fc25fdfec1bd90: failed to run ["git" "fetch" =
"--force" "--tags" "aa24f7914cebcc04de6104c814c089815e172c16" "e377d803b65e=
e4130213b3c041fc25fdfec1bd90"]: exit status 128
fatal: remote error: upload-pack: not our ref e377d803b65ee4130213b3c041fc2=
5fdfec1bd90



Tested on:

commit:         [unknown
git tree:       https://github.com/torvalds/linux.git e377d803b65ee4130213b=
3c041fc25fdfec1bd90
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9d7ea7de0cb3258=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9d95beb2a3c260622=
518
compiler:

Note: no patches were applied.

The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

