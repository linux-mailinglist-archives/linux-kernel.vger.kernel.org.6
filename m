Return-Path: <linux-kernel+bounces-429457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA589E1C60
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CFB1671B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B501E884E;
	Tue,  3 Dec 2024 12:41:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D131E7655
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229665; cv=none; b=e6HoCQHE49YP3cTkCmEIbu87uWqX/JdFz7iPrrPjU0p2YOnkDEp2S5Dqb1gm6cX/uGNvUDaG65appYbC9GGUZNztu3+EwG+Wo7bPP4j7GrqWEk/nLG0KG779ecdxqf9LSxHPUiv4jLmJpQ4ns4spDLU3P8D6fdaszaYIjj1asf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229665; c=relaxed/simple;
	bh=Zmr8/cfdoFR6s598ZNBNEHPHMSZYSotA4MpdGs++SxU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uj9zROC/HvcWy112AXmSOz6BCigpMQUbxB5wPEJrS56ZjG4QuMXmJyUsnVf/u72FejB4WAJXO3CDG9kQqGVSOBdpA0j1fOkee+hwquNlmQLIsV2HnbsmWNMAlnUfmWjWtY/82O+IMXx1xMUqgJp4rdHRyzaGBIjUP5fPpNpzKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso483251039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229663; x=1733834463;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n8YF5NvNalSwrD6x2PmWq6RsR8zybKcrW8AQOYgGns=;
        b=Cfoh70hlPlN72JAVcdLOvzRI/IhGkwnHXw12gBmojJNbu41ekkqY0p19fxrlqo4LuQ
         Olx53Hg5WqW3wOlMO7XOWbkoJW41Lq5Fx34jVjSprO9eUSz9HTfJXPvpBJPIj0U1jlLj
         8Jd0I/S5C3upcOrpkn0vgpFtpQGt9iDSx/gEAQD2XzdvsdWY+AAmoGTdATeCnqcFPJyB
         M1WMgM7jCCcvs1IpRmIB0vjvACbjAjJfLV+ybIqm6Ltq4zgmZbomxSctOkIqHcdC/fJd
         8M800e4RCVg50UaPMEz1U7cYVI+ymR6PqGY9M89uCjxI8M2eeFFvLraCNz9nm4mRTQ5f
         guSw==
X-Forwarded-Encrypted: i=1; AJvYcCU/6rN37VgcV1MzM7ZtMY3pdTPefccUAEnaQechgve7wlBhzHKU2r8T72sT/8iCCq33fw63sdmDTSGLFl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPxvPap05anm3q9TO8Dak8SDs3hF0b4bwJN1Zwkk+r83niocj1
	E8b9dIevcF/NPC7PU2XtEqMqIwfL5cCoFWxVHH9Nv0rPEUrTW9qUNROCGrcKCvnWnJvdXFFvvlC
	6Otx+9FmPtD2MZwqIes8sNHW38n34L293nEfHpY4j/sW9aGTDvw9EqOg=
X-Google-Smtp-Source: AGHT+IGQTDrVeBuhOpmkfXsjwxhSwb5WK3jaq663KbPnJdDeKO/I/swTqMrthl+HrUsn0b0GArxBQiLEJVYwhgP9nkiNN66DeZa6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:3a7:e956:13fc with SMTP id
 e9e14a558f8ab-3a7f9c18983mr20819735ab.5.1733229663146; Tue, 03 Dec 2024
 04:41:03 -0800 (PST)
Date: Tue, 03 Dec 2024 04:41:03 -0800
In-Reply-To: <67290b04.050a0220.2edce.14f8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674efc5f.050a0220.48a03.0035.GAE@google.com>
Subject: Re: [syzbot] [udf?] possible deadlock in udf_free_blocks
From: syzbot <syzbot+d472c32c5dd4cd2fb5c5@syzkaller.appspotmail.com>
To: daniel.vetter@ffwll.ch, jack@suse.com, linux-kernel@vger.kernel.org, 
	mairacanal@riseup.net, mcanal@igalia.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit 7908632f2927b65f7486ae6b67c24071666ba43f
Author: Ma=C3=ADra Canal <mcanal@igalia.com>
Date:   Thu Sep 14 10:19:02 2023 +0000

    Revert "drm/vkms: Fix race-condition between the hrtimer and the atomic=
 commit"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13dbe80f9800=
00
start commit:   cdd30ebb1b9f module: Convert symbol namespace to string li.=
.
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D103be80f9800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D17dbe80f980000
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

