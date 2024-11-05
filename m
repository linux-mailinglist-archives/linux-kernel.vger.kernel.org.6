Return-Path: <linux-kernel+bounces-397156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DADC9BD775
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713DE283E1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2B215F52;
	Tue,  5 Nov 2024 21:12:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4121D9A48
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841126; cv=none; b=VQ90cw245/sAhsIa3i9rl6YMKwaHBcX31yhkf40arI8rAa5iIR0UzWtbijzBAsNIEbT5mSMZ0D6X1gq/Jv0Y2zSAAGAcJZWasE+os3ncJB03iSpQ1RqxZ32PH0SI+HtYuAU2vwtcTAnhzhdk/PsQlRWtt3C9kk1yfLPsQaOBgFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841126; c=relaxed/simple;
	bh=C772U9iMokHzu0JrOOk3mMzSs342g6hcNEPrF5NjuKw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hDZ52J6L1Q95Fm3F2OJfPjRKmrtBtsYxiKrDKMhNM5jgv3lnrr3bJUwcq0q1fjr+QW4gJjxUplFXvoDtzZBCjZBR2NhS7YHorAB9lDVW8mg9UJyow7xQVje2K22iAZkqsKs2badk7YEVj+nonhpfJmRjYKEZ1DTQoZt7ZUkGWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6ca616500so32417535ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730841124; x=1731445924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiqZxAbiHRA/vYcOpw+I+nowv69WYJnI52m84kBzOKM=;
        b=dqTGO7Xm6IrdA3/58/UjM/mxlno/29zGIOWB1nkRzdybrcPq3P+QlzUVxMTo3TPKmS
         cds2f3lRdo+b43ycgDzvNzxCZVeHN5loQSkPNEsHXZI/1tDMeugG1fD7l/Pk5Y6OuFFr
         9kAUFH9WD/91temh/QNeao04eMdUy2/oMVQ1Qn3/CptVsJ5szDHo7H9JqBmIxX/ZYACn
         A56BYmjoHkoBfRDU6DGvxTI/4aDfJcjgdzZ/NqLYaCTC/HzWrMtVt8HxW+OS4GrR6wl4
         sOpTLIF46CAkFOrEMj3bwmMA3Naz41UxEKF0NHvdVtj6t/fCJAVmlvroyvXw1o2DVCT6
         18IA==
X-Gm-Message-State: AOJu0YxfVGgbi8hfQ1qVW8ivvIGB2b29EkFxvC8eDSFp4oPX+fDjtu+C
	zn+Kj43PZe3BfBu8GX1q/6mrlFGrmMt1DgDesoGuhSeQmOLEiJQH3cgNbODKkSKeU7D+Q2QKfrr
	2sk2WpcvRfwvDSSeOXW0GTetivD5j+uyVufULOdzS12DgUPnfOANjjww=
X-Google-Smtp-Source: AGHT+IF7dlBlsLfX2yBqotKhQiGEnHyL2khEfUYLXZWIobYeCTMxIeCA+XzDlQ1FcaBDnFUhLHMk0AGea0WRK1CqHAlBHt0VCyPX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220a:b0:3a6:c89d:4eb5 with SMTP id
 e9e14a558f8ab-3a6c89d50e2mr104266175ab.15.1730841123917; Tue, 05 Nov 2024
 13:12:03 -0800 (PST)
Date: Tue, 05 Nov 2024 13:12:03 -0800
In-Reply-To: <CAN=OONwWNfETusinz2A7yGG2OFtS8Nnn8z9FhUTpPuugHKnMkw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a8a23.050a0220.2edce.1511.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sarvesh20123@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/hfs/bfind.c
Hunk #1 FAILED at 23.
1 out of 1 hunk FAILED



Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=85d8f50d88ddf2a
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1433ed5f980000


