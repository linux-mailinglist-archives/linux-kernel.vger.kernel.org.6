Return-Path: <linux-kernel+bounces-274036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D0947197
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE201F212DF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78A13BAE4;
	Sun,  4 Aug 2024 23:16:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1222086
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722813364; cv=none; b=ITv1NdXVNxPK5t5OZarDSUkuAti4hj1nTPINK6PjB5iatwRmF+SvUnd/eyRoaBDthkLz5alDOj05GJc021E/67nHKTavgSAXmJ12cW0snmz2/RaJHW1fnZ6HqFumYiBqjQtBH9Lc/zB06PwgdLSkx9fbMpVH0JAl3LQgGKglRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722813364; c=relaxed/simple;
	bh=9PV9AfTpJZbNBBWpH/BCpyTS50q62l5g3ctRYxZW8MU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BfN8JSczLtf3CejxecGCWFn2X0ZRyw4fNC1eG8PCARgcQ7be4iu2/I9eEDxi2NtG0DdrAtzY/OGRQLpq7EAoryzl5gDlFHazfcrwMHI+JZdy5AE+3ug8KJ2anO49n5QjdHp8iUykBpszBgrVCo81KrhU9cFyj6q1raRo3zyi910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso1370580039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 16:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722813362; x=1723418162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWk/0YoGbb8Utpd84fDk+7sPr8KnZbi2EHV8pG46Pv0=;
        b=Z7klC1n9YTcx5LnxcZWJznSjUkSczyQ7MXHvIfz7I7LPxnSFhgs0z0gnko7RKvRt2S
         YZLy5Q1IXaZ1YaW5ooluBTPtUlDNP9ZxB2MkTbVAhdcgcACNCWF8O76EpWqroTNZEW6h
         K49qLUczZdTsCOo7B494+L1orY2ian+VmHt6PWQ8JDymKZ1TXrUY7KgQ7Iec2yBkv0tf
         6Ou9rBUoA7Rbxv+8g/Y2y5oNwBldfyt3LEBXnXrwDnwWoKPNBOY4W2dgyiKcdpwO2IVE
         HNRhx/Jqen3nVopdIeSVYctaRy+AGDnn0KwXuUyp2/KT06m8/eWOLN4lpAl++0ulcFmz
         i80w==
X-Forwarded-Encrypted: i=1; AJvYcCXFiIBCRB5eHyNiOHGnNPC0RsNbjPPc9HtgWKTB1xdrOGROo99FcGxej00Wpz0un3SZgB1atvacDdGhrX0QYyx76zDm49Hohmcs9dIH
X-Gm-Message-State: AOJu0Yw1NpLR+MuGGWuNb/LAovwoDEozpAFfjwxzdPUgBw8tVe0mS7o7
	ERrFUFwC5pb4UxFomSZoIOK16TtLjJnNsRweVpPqk9V3rnLOG+QmOb7IAVdxe1l8ATpoTZhWG12
	RyQD8kHsyPAjzfEhZ7EWtixHFXWXxSt1knhfBWgMcnQOx8OezIzFfeVU=
X-Google-Smtp-Source: AGHT+IHLtfiZv3zhPfytIBJAweL1MBhjeajwYmXHFLBYFEydLENCH/5+XTQ0AiXTN+fjkLLxWMOr/wqjKPU6YlTMfp0FVgeHvUTJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d5:b0:809:b914:a53a with SMTP id
 ca18e2360f4ac-81fd42b997emr30452039f.0.1722813362094; Sun, 04 Aug 2024
 16:16:02 -0700 (PDT)
Date: Sun, 04 Aug 2024 16:16:02 -0700
In-Reply-To: <0000000000004385ec06198753f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076525c061ee3be52@google.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
From: syzbot <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, dai.ngo@oracle.com, 
	jlayton@kernel.org, kolga@netapp.com, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, lorenzo@kernel.org, neilb@suse.de, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 16a471177496c8e04a9793812c187a2c1a2192fa
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Tue Apr 23 13:25:44 2024 +0000

    NFSD: add listener-{set,get} netlink command

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16af38d3980000
start commit:   ee78a17615ad Add linux-next specific files for 20240606
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15af38d3980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11af38d3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a8c69ee180de0793
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e76d963f757db40f91
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173f2eac980000

Reported-by: syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com
Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

