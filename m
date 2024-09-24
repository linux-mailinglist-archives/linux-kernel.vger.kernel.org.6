Return-Path: <linux-kernel+bounces-337312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B6984882
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066A21C20CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993921AB519;
	Tue, 24 Sep 2024 15:21:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66EA1CFB6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191265; cv=none; b=TRHs2RCrYfzQujd6q65GstJgSLu+bP5S3218BnnbBRyeSQ8S9Slny01UyUPYpnHlXMdUISOwN02pqexaVuXgx9ZcIiF/BiHn7PSifcCHeU3EuFWDb46nzwQA+K0k3P5enU2syM0BCOR0CKUI6Gws+2ytV5Tfa/RmFCcbW/O8PhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191265; c=relaxed/simple;
	bh=XVIGflvlI0qPH3vQ9w1vkuTs6KWJIruWv/4u2XM1opU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z+h3mhd/s4EKJyBN6O1Jpd+1zJQ0/1Nx9N4R5MxtIs1YaY5Kfc6KkxX4I6vOri1ErHvgNntz1u0LedISYLQc8BX9ysCE/QXlclUd9LLCDcNUeCBk6LhHv+wegxVc4tyXb2rbptAlcYYqVVMnmYwsg/E2tRewXzMavkYIgd/UhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-832160abde4so287489239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727191263; x=1727796063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5/eu+lJjFeHU5YZrA2fLRIPgaHeCUiaWmPkeadJMVI=;
        b=nsE7Xr3JEtS6/v7NuVGadQqVM8tUVcsXzjdmb0FnB6et+wjyR1QcAAM+ooA/9rQMnN
         mmIVA32xhr/ESUwu5VYLjEtVLEK1cgqc6GJjrlpiYREbE+6enve5snIdaDPn6PUM90ob
         TTdl0eFkepcy5WhsYCvtB1Oz5yyl/Kq93LkWj40v71/FQnBRG53riB9INc6MDRso1I07
         FmOZ9sc0FFMjYnFQySXe7er3yt8ONn1jU6TwBDCaxoa9eUtNmgWgscbX/3T1HPVNEW+T
         jcv2FJfCSjoeOELDrmyns9ZM/w/0qKUoXKB0as6yEJTXqjF8AIUahwFhIMq53ovVdha/
         sH1w==
X-Forwarded-Encrypted: i=1; AJvYcCUqWiYoJI5weejP/0cQCYSVlrZoH+SGwyHBiinW2Qojgv1wBFQuP2OKW+dBoy3GNi4FxDPJZ3R4YN+WQtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54C3f4TALucQW6AfavBdKqyxbAgRn+XhINhQsVE1hvxDdxrTy
	ymDPu268DaALWqKei2hzcacyXc3p6mVnwiQ0sxVf0aw0ZzBKAWjr0KD+oxbuhgSQqayoEsExUgX
	DDQ3ry4PDGBRs7i8bKdm2dfXCXFg7FMVqF3Tq3RpPVuCXTmUO+h0Pbek=
X-Google-Smtp-Source: AGHT+IGyyKJ/J+lnMZqm8DD2watvy5npslkktSgTgOM4x/krGjzYYoBdANnU2BVAHyIcH14qWo68hvav3q2mkBjlCWfh1Dd4+xka
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:3a0:b0dc:1910 with SMTP id
 e9e14a558f8ab-3a1a3039506mr28113735ab.13.1727191262984; Tue, 24 Sep 2024
 08:21:02 -0700 (PDT)
Date: Tue, 24 Sep 2024 08:21:02 -0700
In-Reply-To: <8cef3615-5553-49b9-89cd-393b2794f016@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f2d8de.050a0220.3eed3.0030.GAE@google.com>
Subject: Re: [syzbot] [udf?] KMSAN: uninit-value in udf_get_fileshortad
From: syzbot <syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Tested-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com

Tested on:

commit:         abf2050f Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10242227980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b430e3226f77df37
dashboard link: https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126f3107980000

Note: testing is done by a robot and is best-effort only.

