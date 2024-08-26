Return-Path: <linux-kernel+bounces-301613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7873795F332
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FC5B20B75
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBF417C99B;
	Mon, 26 Aug 2024 13:47:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E6B10F7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680043; cv=none; b=ER0HKVhQ7+IM6Ke2N5SLrpDtFPRB4307+qAiciJ6nOytP+oHdHiKOKfONW7bcpiM/FNeRfvcqm670ydBYTKFAKg9L2hJJcv5UCkjfN3QMKaLRdtU+DhK+O3EmA21ABgRSzvQsSaa3KZhqixZ7rpunhCht1sojxvqzXQSvn0Oaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680043; c=relaxed/simple;
	bh=GrLK19NFTDZi0n7+WwEX7ZFQ7xccyFq2j2t2PaorsKo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gwqU24I9Vsn+GcB7U+jxB9YlmUpaPiNOtzil12Kiu/cSwh1//eFvNhp5t/DkWhyy6eE2dDOTdy6IFgdXPvEMeQgIlhgDEJoKGwVfCUB1zEw9BZ99cwe7OHDU5j5Vug4Qm0JaiNaIb/LUZTWQ5FiMv4VOtcW4OvG3Ai8MZNgyfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d2df2e561so55740605ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680041; x=1725284841;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/v4DElyEzXK/XGFg6yIMB6qgM5jU/tl2EiZvQsE5kQ=;
        b=Pbla8ttentkdMX4UbWAK8LpU4YyEj1XSqQU8yYGLTPUtK+2nVPiJEo6J3E4JTyZsXC
         uzEt6/Ni1HSY4ORsfRsy+cFGn21DuIZi+DT+g2LneN6SZKiH7khgzp6mjvFKYfyc6siO
         6d8LOZRKYpM62mgEgOAX0p8gp4ypr7SipjbJ/j/VeDbs4JoI1dBG/Xs5CdvmK+TyBO7P
         2WGeU5HTXaxQQpfCFmtB2QnyRm+L2lZ1XcjsRBqNhEKajqmY+daakQdZfzM5B+mqT6x6
         kj03dtrhS5QnAfK1VgwIRkeZXqBp4sMRcbA2ednsm1Y+wko6BLMk0wXc9Y7erxE/CnP+
         ks3Q==
X-Gm-Message-State: AOJu0YyJMqmGYlBxycF4DNVXfm0HQCG7mAUDXqJ5O8cixtRkL78ktJN8
	m31oXGlZ+CMZdTRS1/iAYb+67vd2gzr6PvCiQzT+RBJaFF/9FYGwQBhxO5P7OtQ5naEXBsyD2kL
	siztW5FYOAHD3DlP5qqBY4dFtJq7KEntfM7+1hkDHbJb1/YPUpokBvSs=
X-Google-Smtp-Source: AGHT+IGOYYbt7z1oqdAjWn68/nHeAdcfKU+VkfNGz/d+8uKjbo6pu6GEM1SxmtobT+lrwQx7IbDOKVEGw53NaicXz2Ij6mBY8VRY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:39a:ea7d:2a9a with SMTP id
 e9e14a558f8ab-39e3ca0d1c2mr6727295ab.6.1724680041185; Mon, 26 Aug 2024
 06:47:21 -0700 (PDT)
Date: Mon, 26 Aug 2024 06:47:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034d59d0620965db3@google.com>
Subject: [syzbot] Monthly pm report (Aug 2024)
From: syzbot <syzbot+listeb96f98dd6da9fc4b8b6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 202     Yes   KASAN: use-after-free Read in netdev_unregister_kobject
                  https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
<2> 2       Yes   possible deadlock in dpm_for_each_dev
                  https://syzkaller.appspot.com/bug?extid=2a03726f1d4eff48b278
<3> 1       No    WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

