Return-Path: <linux-kernel+bounces-425181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCA59DBE97
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D65A16323D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348D514D6F6;
	Fri, 29 Nov 2024 02:15:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3514F108
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732846504; cv=none; b=aMVeYYUe2gRo5wCsR4iAh/S8GNABzAQPWg9qZ/wj+Jm/3hU90OxU19OlFkIPrLAZQIxxgTLwUoAp9LLrM7VNqTpYAbgRxMZDPx49TZPaUrqo+mSclBsPi4YhpypediI3GnvtkXfiwxAU1FpgArdkI61RbdJOtTSfUR2gmBTDaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732846504; c=relaxed/simple;
	bh=2tjbjzvYZ2R70GSvhfHIBbYgRQX2MKWBE2rMDCLEZJk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nEamc4VgyRGai+1x+PW7qoOU5hpx8oUEb3HLKeOtjXol3p4MmRvVHFv04pjQyw/p0yW1mCPAmH5AhIr19uK/XsdEuMXjX/Gh4aFcH6acHFSVuLvX2R//6cCb48abE9s1+dXgTZQvc3kuZXYFgWYFyE49WFnCznedT5j7d3ewUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84188ac27bdso119644239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732846502; x=1733451302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U5Vwk+xmgUg16bNI7cgcYet1n9cVlG4cMl+uwsNt68=;
        b=A5XEmRN79k6bS48kyz9ywCtPuBeRc9D6VRFPjX4YOTcOZr+7Miq0Mf6N6VKM8g1HzX
         RzeKgGczbP2vVhvBbujpM4ryQLVg5ws/T3sc7CuC8OzEpnYvybSLJ28nV2SOXhcAs6HV
         DCWc96YvQ/Xaq0fjj8Q8SLjxhVQTxUrPBVWK2MnKZPZBAaiHZVDWnxBq0dFO6iyMrC6T
         fayq8MPqp0gltZatdoTsyRezpX4WbZclPytb3sv5Abce4bz4c/8ecw1q8DowYjINCuAf
         akA0+OFHuo7x6EV0mHLk9r1wDDmeaDbli7Ne3BC5WiiX4QNeOUZjo5NqXyupFacgXE37
         FeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVeK9klGzAnuGoz8zCP+6ByOHug6ywmgVOsBKmRUAmCrebX1CtFLh0UoI+qKy/B2BwcAq+fvckNiX1tkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyub6IKFNHHBNQ3ScIZrMad5mkChhY8nFXZCtccI9e4NxKjQXlv
	OHM1awHtkGPV+9O9EzF/zBIony/C2NWbSZIPKh0xC5lLVoS6ABjR41aelk1iy6fqVhLs07AksXx
	eMvV+1D/RbYjsEkTnCN7Ti5KgRuCbNfXg0sL4sm3Mxyd/olcCh3/rlJY=
X-Google-Smtp-Source: AGHT+IH/DdTz75isy8RV/37m6tD/qSowhIshhif9giIusPOeKOKFPh2HQQTbcQx13udkFzvJLhnmeLfBsIR8JGrJlRIPU6rpVBop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda2:0:b0:3a7:86ab:be6d with SMTP id
 e9e14a558f8ab-3a7c55d9ab6mr103087595ab.16.1732846502474; Thu, 28 Nov 2024
 18:15:02 -0800 (PST)
Date: Thu, 28 Nov 2024 18:15:02 -0800
In-Reply-To: <20241129015151.595085-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674923a6.050a0220.253251.009e.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtSplitRoot (2)
From: syzbot <syzbot+99491d74a9931659cf48@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+99491d74a9931659cf48@syzkaller.appspotmail.com
Tested-by: syzbot+99491d74a9931659cf48@syzkaller.appspotmail.com

Tested on:

commit:         7af08b57 Merge tag 'trace-v6.13-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b489e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d9390a3931bdb72
dashboard link: https://syzkaller.appspot.com/bug?extid=99491d74a9931659cf48
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137f8d30580000

Note: testing is done by a robot and is best-effort only.

