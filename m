Return-Path: <linux-kernel+bounces-176848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539838C35EB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 12:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F2C1C209B9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 10:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EF41C6BE;
	Sun, 12 May 2024 10:13:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D51C68C
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715508784; cv=none; b=JFD6JYjb1doqUFydSCkPlQs2nra9XE4vMtSN8QIfF794UcuGejaG//rhIj7ycmW6YoBU786fHT3UCrPT+/M0CxVxSDxF0FwfaDrU4npslyo4crwAh/B7bJ6ytQyDTdaa1Iu85BsTnLnpntRXtUhiGJWXmEiu9+xyV+FMC2gjdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715508784; c=relaxed/simple;
	bh=IsynHYMglKSyjOPjBLyBhGcETIRkx6+ryX0wq5WL4ec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sg+sLbQB0+rm+r5IUpKHCoznD0YoB0kCkYxDrrQQYn5Rjze/9IB4IHhnAkOEr9iatN5obWRewzPG43U7oR/u2TtvA8yDc7eWHMEAb+acSe1mpikFCTYury8HsqPEheWckClWF7mD+iSUCqBsJJE4FUvtpZTCmGRsI+PdBMzjldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dece1fa472so382328539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 03:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715508782; x=1716113582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SbtutK/mGneFN6ZbXRp7/lhip/C9OM7lR1IPBTIGQQ=;
        b=URlDybXlt1WL4i1iVyMkobCZ4aNFFxA3C7lBMeQfPH8czxOxDBcuJRkPjxM0FOdfGx
         WKpkScKj6I4y1c2/Ch6lCesyP2AUXFnV0TrzCdb9QlOHnuOaBs+z4dq1CV5QkWHEtKhk
         rOwhDtZ5lAj6QqxAz+qGwW/yyjq3KtNuvUm3A6LOjxpkHqwxV0yy+hAiWtCritfPvdoL
         1nWhhrpb1UTs1UvV+RvK8He8vB1IEsP979I6NQh4t2peCB3DygVjME+dsNSojVHAJU/+
         DNOtASEXuHGKeR2gJGhBj42sBCy4VD7JpcW8Owv0cTwf+NwgT7u1akuUExx6xoUfPjZ3
         SCmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzG2vrusleY9Oj5HURCvBpOttz8D/TKFm7LuzrdY6SSO51E5qveWuFAjollz+84Uah04zpUI3ukUZ7X9dOWH9P3CO2qFdK0STW4sVs
X-Gm-Message-State: AOJu0Ywly/z7SqU4swpG0ZDmGsWA9pE0DIA0jLZ5Av2Cs5DaCNFtyADI
	OEikykac2SO1RvW8ztUlqpcn1cR1vilO2nd8pi6vzQiES2MkT5Bu1Z8320lNPGk2IPPIY2Xe3fo
	NoEc9orN7D8heyWAH1XQ3l5pls9S4pj0OrjNG6fjGAG0fAMUlb77k1Xc=
X-Google-Smtp-Source: AGHT+IEbPOYWcb6BwwAJx8WbzN6+LpHj8obs0SwBkEZ0MuAl1GySFWbJuHR+6Hwd4dNxzHQr1bmxTBQHvSYpcRxomuGUZETjg2XX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:77ea:f191 with SMTP id
 8926c6da1cb9f-4895868b5dcmr398991173.2.1715508782476; Sun, 12 May 2024
 03:13:02 -0700 (PDT)
Date: Sun, 12 May 2024 03:13:02 -0700
In-Reply-To: <tencent_6BDDD81904CFB50DA5A5BD0D9612535DE607@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096bfdc06183f033b@google.com>
Subject: Re: [syzbot] [bridge?] KMSAN: uninit-value in br_dev_xmit (2)
From: syzbot <syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com

Tested on:

commit:         dccb07f2 Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1617da5c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=a63a1f6a062033cf0f40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1205acd0980000

Note: testing is done by a robot and is best-effort only.

