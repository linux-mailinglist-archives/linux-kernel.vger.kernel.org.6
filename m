Return-Path: <linux-kernel+bounces-440778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CB09EC41C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A629E16839F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5BF1BEF74;
	Wed, 11 Dec 2024 04:53:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3932451CC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733892786; cv=none; b=KFQ61NPvGoXp6N+oxDehT3TfhnDUT7+fuujGSC5TkP2OZk1TKH1yOR2LjCaxfMCPLr+5mi6bvafnIMD5yuU6DB0wXXd+8R73HRQwNwTTv0sAmvRHcAKYdGEp5Nb9qV8+SwNskfRdNI4F4sspU5Q6pXk86zYs1DhPlqpR5ISthPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733892786; c=relaxed/simple;
	bh=xW6wxUs3kEXcKosYbFtd1hsMjGncGTwCuyM05GX8CB8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VNgg2E2HoP/qlIHqQfxviFR2IgoZik5M4WjSO05JpK/Ms4JswvS2bX77mcMwPTVER3HOvptjaFDGNWK8sI31ZQRuzISQme8od7k+KTDscQkgQsWLwLwKz1mv0W+GmANQ6RlkC/BhCirKQWmO5xpIhdrIKOlvEbMl9otV7ax+Bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso3321225ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733892783; x=1734497583;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcvbKc3Wmur1BZCcQljjzub/iad/yVGdWwzhd3EQZAI=;
        b=LMaC1sY6Qipr1egQSGd+VWaPzFDGjeFrvhY+wOKS5APJc+kWOROUpotnSHyC2xeIEg
         YB4cbhfXBpG88/2RWjgsYhvO0gepGYZDpTpFg3u3VR0R4NP12pBkNHsJZ9imWBWEXXv9
         6lhpAczoJsUfe0SIz+frMOSC+bmklqd/Ko3gqRKvq0/wfsO6BT9rVySYlpjQfFme5wdV
         NaL6c20xad52wCFciJP1rQGln4VVh7muVDpluYAtumv5ewbU/FysOf/mZTzieJ3oHUlN
         ca9r6uhpRBBFGuSMOEZUPhsHuVx7iiLK5EWH5vSaztP7HBN6MMS0tkuPKdh7mWoPALzr
         6rmg==
X-Forwarded-Encrypted: i=1; AJvYcCW8NAFdmhdO5EtKSEypiaSkPa/UxURKIPxc8mBeXVH3cIg+1yGZGeft9n11OSjZwhBhKi9Qz15JToIxJCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFQ9BNt/vSmDATmtjWTsGUQSOcAGyR3fanlNg/SVVAMVkImtx
	67W3G9bOqNGaTKOlasGyJc/F4KlZN662DHw0prR737vJeLASWIvTP4/HTbYGjaBrQumRgdxhlRw
	r/wWaVg3NLIS1A3Swy4pL9PygDzj8jaCbjNFpsIHXjgwoPdBGDNPhC/8=
X-Google-Smtp-Source: AGHT+IGyj0xVAynRLlBa52mOPmJzaztfU+ThjbewWx/xawpaRVRJvSVgHE6xlGaWx4ZWMpVo83rTg+gdli4kQ2RJz0bAOhec2E1D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:3a7:e786:afb4 with SMTP id
 e9e14a558f8ab-3aa189d3195mr14523195ab.2.1733892783627; Tue, 10 Dec 2024
 20:53:03 -0800 (PST)
Date: Tue, 10 Dec 2024 20:53:03 -0800
In-Reply-To: <67290b04.050a0220.2edce.14f8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67591aaf.050a0220.17f54a.0014.GAE@google.com>
Subject: Re: [syzbot] [udf?] possible deadlock in udf_free_blocks
From: syzbot <syzbot+d472c32c5dd4cd2fb5c5@syzkaller.appspotmail.com>
To: daniel.vetter@ffwll.ch, jack@suse.com, jack@suse.cz, 
	linux-kernel@vger.kernel.org, mairacanal@riseup.net, mcanal@igalia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit 7908632f2927b65f7486ae6b67c24071666ba43f
Author: Ma=C3=ADra Canal <mcanal@igalia.com>
Date:   Thu Sep 14 10:19:02 2023 +0000

    Revert "drm/vkms: Fix race-condition between the hrtimer and the atomic=
 commit"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13bfa5445800=
00
start commit:   cdd30ebb1b9f module: Convert symbol namespace to string li.=
.
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D107fa5445800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D17bfa544580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D91c852e3d1d7c1a=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd472c32c5dd4cd2fb=
5c5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D117440f858000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1659b5e8580000

Reported-by: syzbot+d472c32c5dd4cd2fb5c5@syzkaller.appspotmail.com
Fixes: 7908632f2927 ("Revert "drm/vkms: Fix race-condition between the hrti=
mer and the atomic commit"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

