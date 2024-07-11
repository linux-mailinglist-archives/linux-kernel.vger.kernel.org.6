Return-Path: <linux-kernel+bounces-249071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C983292E5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C34B273C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4D3161904;
	Thu, 11 Jul 2024 11:11:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FBF158DD4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696265; cv=none; b=hwwP+Az2C76G4x+02GRd3uOvVyhmGaoPt1si9yLc6tnOSqoVdaYZtp5zw4x8d0UAdQxdWHZ/RqXYvnz0XW/lRgZAgAkTVd/nblLIGTptOobO5g3eMqBz7asLxU/AfSnVT47ltJcM+mVtnKmZ+/aGtL2oCMmQ1030LDMKuFJuYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696265; c=relaxed/simple;
	bh=0ZwX0N6cmTcPU6cUOhbMilU6Yelh76r3rbVgmSzYq0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h5zUySlR6wZVgrdepv/dDFxw61QjWAy984keNusBgKZVumYw4/BLb2kfryzV3S6ZyQ7GjdUhofzfGKA5rFjyw6C77AmbTJcvfUJFf04oU33NXBGInp/DnXUW/5IcwX4caq3pcIvX91kNwgZkEMaOHtzAwyN7uwWIGe8yW1oU728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f9a5529d33so82284939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720696263; x=1721301063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxg3UJPkzx7M07gbZ9SOx2eod/ecUaN/p77xgE8W3KQ=;
        b=LQhyto3RAmwqKRy/bCHS5TN37IZxan0IwnV10kkuV8v7A6JkYPSDi4D2SWKi23PlvO
         3aT7hrFJEZHFb6pEeAEbocRihgePYWcYKuuHmkUEEKG1gp5sL0G2kbFbvTg8CimounJ2
         Qo2XaAp+up3/eVw0D/B99XVWzEvNfuKNRzBNOEqXQFYlPBBBn5R64vZIC5KDgWULJHaq
         tlq9EY7lrdVxPrZdiwdKWUxcEwv0SbkaUs2CP7d4uSS0Ck4CpZaj9J9sFMI2SwYHW+Wd
         q6gdfImjyqLOFdADxrMovyA8OQ+0fV+UKHRrzMH9YIbewvDgCmlB54GkNr/6TbTYNMLh
         w5mg==
X-Forwarded-Encrypted: i=1; AJvYcCUPx60MMGOuCpqLuxwCx7ttCHKQ5r9GNNmtm2HetB4Fp8CKjcvudTKJoxOQlmNri05grY4/zpS3P3E2pxhtsoWqwrNUWXxMj/79hTbI
X-Gm-Message-State: AOJu0YxE8PU0zUa/EYmSaFQr4NMeppDlnFmgTr2Dy3ACZejcMFOsvU+m
	S9fEqcnwJ7ZO/xqtVs520QijfsKYkLDUcRL6HTEPBp0c8dwUYga2ki0Biws2VbjqAyzmRvi82w2
	o47LKqX+uhAOzSPREH8Qtba3+qZ114HK5Kc4Qbeyzyne0XV1kWDPHwN0=
X-Google-Smtp-Source: AGHT+IGBjGi2u0vQwkoJ9T1yTRI18dBxcqWGmgtHOfjU9ZTmOOpU364A1mpSXTEejum4DWNhNasVTJ0VRDyOX29dVNI3xFSozQ7R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8601:b0:4c0:9a05:44c4 with SMTP id
 8926c6da1cb9f-4c0b24e9f62mr482571173.0.1720696262760; Thu, 11 Jul 2024
 04:11:02 -0700 (PDT)
Date: Thu, 11 Jul 2024 04:11:02 -0700
In-Reply-To: <0000000000008ac77c0615d60760@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000822b8b061cf6d171@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_wait4 (4)
From: syzbot <syzbot+6969434de600a6ba9f07@syzkaller.appspotmail.com>
To: alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org, 
	broonie@kernel.org, davem@davemloft.net, dcaratti@redhat.com, 
	edumazet@google.com, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	lenb@kernel.org, lgirdwood@gmail.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, oder_chiou@realtek.com, 
	pabeni@redhat.com, pctammela@mojatatu.com, perex@perex.cz, rafael@kernel.org, 
	shuah@kernel.org, shumingf@realtek.com, syzkaller-bugs@googlegroups.com, 
	tiwai@suse.com, vinicius.gomes@intel.com, vladimir.oltean@nxp.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fb66df20a7201e60f2b13d7f95d031b31a8831d3
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Mon May 27 15:39:55 2024 +0000

    net/sched: taprio: extend minimum interval restriction to entire cycle too

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10593441980000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=6969434de600a6ba9f07
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1091a5f6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a22c13180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: extend minimum interval restriction to entire cycle too

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

