Return-Path: <linux-kernel+bounces-552072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8F4A5750D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0368117056B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A0F257AFC;
	Fri,  7 Mar 2025 22:42:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1727C20CCEA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387324; cv=none; b=I2uWiO4YGWFxSdwOF0nd5DBBC6hcOQHdVThld5y0w0pTtRsje8sz06dNEQn8SahqDpL0AaLFV9hQFalbLSi8EJhcaJQE5+brokjRCiVz9b+wLbk13zeFONIpIbfEFBCprMlfCMF5cG4HRKhjCb/cONLs+IUGXhFB0lio2emQlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387324; c=relaxed/simple;
	bh=FIE09kMTKcjOb6IpPw4BV0dkrJbXktb7sivz1hHqVoc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s3U4D/4cg4tJtIBDBbDkUcBZT0anp0nrh4CV1H2WTVolVMqjpvYartqNiU+74VREXAkg1wkXaDtkvUE0zmTVLQRsGQ6z2MRWmoK6PDKRrAt0s+oKEEuM2aTJsjSmjnBehx6N/gz0daz6yj6R45h68gXTEy75tVHyASYbM8sOcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b30c95536so14325739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 14:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741387322; x=1741992122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Cha8nI3yHP4ekbqsmtiYifVX6bODFDBdxD8YqobpxI=;
        b=pfiXbpUxZqLDq5oP8D2LSSKX4KagLWpILqs5MkHmVKxISYJnycdKLW8T2I7nzQli+9
         V8qavlmw2knVEossj8u74+Wg5nfmctnaEcHNyTlMLlzpnXy/dqBNIio47aER+Tc4TRB1
         /DLeK+5fEIy1uyxEfrPaiO4lod5RfRqEqSDZ6dLD5m5PTPYalB4WKIOJ4FU7nOqaidTR
         O5Q8mLBaqiIXVk/o9ib4kX2HPkVz/Q7VZ+ZZET2ORD+gvwcCLTpGsplthNRIffCkhXD2
         2/TR3lSQij6x4p4ZmolUZ+Q/KX/vJvEkKm3/DRKkowN1SzSPBKzg7tJU67AkcqAXsdXK
         TehA==
X-Forwarded-Encrypted: i=1; AJvYcCVohW1IkCqP2Wp+IryafimnKpM5jZdLrSHEBc9rFJGJ9Y9jC2+2L99RM/T/xrF0Yuc8KNKGxJ/Z64lh3l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNHO6aH0KDp1EN8Bq77jNlfPIJC28gIllziuiddwbbmNzT3bbw
	3t83/LEXuCogdtIuZQYyGR/TJVOYaUlanXemJRIQfz7ehP0UBcFTNx3eqt+LnsMkMhfnrsyihX9
	Z5Wrknx4EpkwHAdGMGbl/j4WfJeclCd+GZ+uCYFtDXHO4cJ/GmOQXIaQ=
X-Google-Smtp-Source: AGHT+IHyFZ5xCG7t++nhjLckAX5gJDHtCBeqTd5EYA9ucH+LjWpniikL2yxT2tKfXWWeuxxwxr6C24DgnBiZLBKHtcYesS7J6gZl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:3d4:2a4e:1272 with SMTP id
 e9e14a558f8ab-3d441a46c62mr66847485ab.19.1741387322248; Fri, 07 Mar 2025
 14:42:02 -0800 (PST)
Date: Fri, 07 Mar 2025 14:42:02 -0800
In-Reply-To: <67a4eae3.050a0220.65602.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb763a.050a0220.d8275.0226.GAE@google.com>
Subject: Re: [syzbot] [mm?] [bcachefs?] KASAN: slab-use-after-free Read in list_lru_del
From: syzbot <syzbot+6663075ddb9be85fa6e5@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108d43a8580000
start commit:   03d38806a902 Merge tag 'thermal-6.14-rc5' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=128d43a8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=148d43a8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de9cc84d5960254
dashboard link: https://syzkaller.appspot.com/bug?extid=6663075ddb9be85fa6e5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104d2864580000

Reported-by: syzbot+6663075ddb9be85fa6e5@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

