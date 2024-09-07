Return-Path: <linux-kernel+bounces-319590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0AB96FEF1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B271C220AD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F6DDA0;
	Sat,  7 Sep 2024 01:25:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60978BE0
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672305; cv=none; b=nQPpRw7QmnTfAig4Hxt8M42lY3zD8FzI3kAvEjhVfPDkC3/5B1QkKyi7RFx298N25FDs/y90uHN1ue9iDoLJ81WozS1KEPGo7ebpyZoWfiILNRPMm0iZIIdsKDaY+Z27FGbcluiebbzHjq21e6FDGB8pzOy1OfbE4yk/9KPoPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672305; c=relaxed/simple;
	bh=WLle0+fDoxoBNckw20EbQvko7yd7AxDTtsKIvNw59+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jTNMBx61AnOCY4oOmzm1p4Q43uPdObgu9nuU/9l3NtSLc+w8xTxJRleCpEdEirpjtWXo3F4wmLH9Zq1FUeBy1pjDaoWaHD4dy8UWvildDTqJ923eFOMw5osoTmxuRPVVL4GGbCiOgoy+Ru6DBcNEU5FqOBEOGCD5aiJ5v7GWO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82aa467836eso44045539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 18:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725672303; x=1726277103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8EwKQSOTSQrGhAzP6MilFLXjme4RWJsUG39WZTsENo=;
        b=RN4tXN4IjNwJ1EmSzHqOCk0PSwYKe3A+4QKsyZfyo4e1kyxK4SVkVYt2G8NisDWyBY
         pMeVii91STIJb1PepSFfaGL3W0RVpi6JXBD2zevoJxUWWLm3JII+9+M7YP25LJLOU4Lr
         Mwa10FEpe7x0CRTTdA0yvhpPp7vOR0jdkWwp1fsyYXLBS6ppCs6gSijrn9bHB/j8JQ4X
         apbwbUNcI4qu+Bi7Pgc2/PmkkhrgSgqCPotrrUEyH1Fauz9uXkXfVAtBNASGgKvzcXcK
         PxBzbDAeHJ1gEff+miprf3WJHgeaQM85N5CFtQfg/HWSamfHe4a8CPAc1rIvE7aH7nKu
         Lmvw==
X-Forwarded-Encrypted: i=1; AJvYcCV2bILx1Z8aszMevpTEvMn5EEjp4Z9C+htVdhy1GS9E5on1vxDRVPgyJw6zN0gzMtbF0XCd5LI6PxDWl6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyklt73GBysZiBJB8UUmlqAZtocS2Psp5H/jVCTtUvPYo1T+X5
	HSTiBQ+LGwHbJHPacLmgAacRezXhd+i+kVdnGYbGwk99ti76INc342EZT98k3d++OBQC0nofiad
	wrZY7c+SQIeS7/3NqxtdIESwJWSKGciV7DppJUANppUqVtvQPg7I7szM=
X-Google-Smtp-Source: AGHT+IF3xS13Scuuju2TukwRAEuY2ohBaLXQ9P9aMCeel34X7QMhgA9VOajYFCjDxN0i2Z7vMkwGmxf1cZG3Fs5YrVGqjuqjvXDm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:248f:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4d084fbf257mr257340173.4.1725672302984; Fri, 06 Sep 2024
 18:25:02 -0700 (PDT)
Date: Fri, 06 Sep 2024 18:25:02 -0700
In-Reply-To: <0000000000009e614206177b0968@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e4fa906217d6447@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in folio_unlock (2)
From: syzbot <syzbot+9e39ac154d8781441e60@syzkaller.appspotmail.com>
To: boris@bur.io, clm@fb.com, dsterba@suse.com, dsterba@suse.cz, 
	hdanton@sina.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 478574370bef7951fbd9ef5155537d6cbed49472
Author: Boris Burkov <boris@bur.io>
Date:   Mon Jul 22 23:49:45 2024 +0000

    btrfs: make cow_file_range_inline() honor locked_page on error

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13bf909f980000
start commit:   256abd8e550c Linux 6.10-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=9e39ac154d8781441e60
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12984185980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: make cow_file_range_inline() honor locked_page on error

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

