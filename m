Return-Path: <linux-kernel+bounces-259400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F72939551
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79AF41F22553
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A63538FA3;
	Mon, 22 Jul 2024 21:16:31 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E208F70
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682990; cv=none; b=CG1w0Jw+Oq4t4Oy+pnGGfjY3RKm0G8txBrvMh3oCLnuR2YlFTfKz88OyIpHy/yHjtURCXaxsm2ILCUB12tSn/n0WF2rrAAP5MTfGmtOz19r4v/kykxuRvlqAKPDSRwhh2FhEYSxW9YyMn1Pkrdoolt8ISnY9liAiTFZT4vO4fhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682990; c=relaxed/simple;
	bh=1YiUrEA4gfdPdK1EJw2xEROGIhjaV+yyi2c/TaJWhlQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qDNaJaWE/co3cDoPKI0cJqIznzYdLmBucjh05Obody7mPmyzSuWUoam8VrDg7jMhz3jVc7gc5+RcdwRkZ2tPzSN3mY3sabzO+57FPDGo94h4kvih6qjNP1lmdR4rbrlkheXXgM5b+p6t2or0bDzhQXGTb6alBz9BgfRuWc2o6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-804888d4610so757444039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682988; x=1722287788;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xs94mEAkVlrVSm/7w9ZANGfa7Un1bHL1xCgm8+AxyAo=;
        b=LVUP1jV/uQqSVs3OMtwr/lC7bEKC17SikZu8fo1VAVVNApnTp+mbCkeD1wkl/ZxdoK
         AmR95io9Fs9LcL+VjoXM1CpOnN9ln+OZZ7c9XHcH9zaQ7CqQhOuhayRZkg3sqWJmU7tt
         OgjKIjasI34tkjEQT0S777yPVJZ6KgrucqkNSL+qH6KPD42C/SJS8R03I2rLGSon1ljh
         LtjLSySkxKCQmXN1n14ZXK7tvuuEyYfOFoYXnY60ID15Z03JlVcgUw/JOefz5CE8fQrO
         1DLAXMADa5bB8fC8+0/Am9+J1DCe0J6eN7POe5MXqkgvvOjS0Rx/7bYryU8tiSZXXi0h
         ItDA==
X-Forwarded-Encrypted: i=1; AJvYcCXgfSrKyNdLju8/f/kcdtfpArchLyfrzuqTAsA8QYVfVEDajCTYJzGJgo3AF9hUR/GJB8WFw0hqx1ceQWT2/0wTQDy+1H01+84K7OxN
X-Gm-Message-State: AOJu0Yz90wv0nKXXKTLk1vRxrjPAHj9YoMnyo3ubwJvHbSAqPkRekAAX
	cQhpTFeZgu0c55FYkjBb165XPPVdR0gCPXnJ6ppG6Ff+ayZgJIRiAs9e8l1Kzb9TOykMdiikExN
	QL956OJZrKxb0Ho06641E+PLHP0W/Hw7Sul65KPXuq9kF+XNwHWR0bsU=
X-Google-Smtp-Source: AGHT+IEF8DnLDcBpyXNlwE6OPF+4WIFZxxmb3DPFkI7qayDNlGZDm55N7M5gyEaBZwJ8I/aG8iSbV+0Lf9+jewOx65+pmO+nEgNl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2685:b0:4ba:f3bd:3523 with SMTP id
 8926c6da1cb9f-4c27999c2ccmr3221173.2.1721682988573; Mon, 22 Jul 2024 14:16:28
 -0700 (PDT)
Date: Mon, 22 Jul 2024 14:16:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f335a5061ddc8e96@google.com>
Subject: [syzbot] Monthly kvm report (Jul 2024)
From: syzbot <syzbot+list9a13c0072a3919a6debe@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 1 new issues were detected and 1 were fixed.
In total, 11 issues are still open and 121 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 40      No    INFO: task hung in __vhost_worker_flush
                  https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
<2> 23      Yes   WARNING in kvm_recalculate_apic_map
                  https://syzkaller.appspot.com/bug?extid=545f1326f405db4e1c3e
<3> 5       Yes   WARNING in vmx_handle_exit
                  https://syzkaller.appspot.com/bug?extid=988d9efcdf137bc05f66

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

