Return-Path: <linux-kernel+bounces-407339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814499C6C22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DD828A494
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C421FA25F;
	Wed, 13 Nov 2024 09:55:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D121FA278
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491707; cv=none; b=UbcHfj7OLofJDjIRJuR7D6B7LjPApijzkfWkFAOfn8wYLDDXkLm/HiDPaoSeuXPRlhJ2+EwpGBL8IVMNeYohu3S6UIj8V/da3lOaPSa3dO8NdPzC5VlxN/RIRazMi5CYLIXg+Nn2flxIkvNaq+G/pWetY3IfefnJ6JX+JEeqq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491707; c=relaxed/simple;
	bh=p/U33DStNbGxmGap1B1YFe1j3MFsLDaLtWL3WRosyzY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XhnTrygtT/t9LwWTsbJzQoc9YV8c8r1Zihapb8Qby5qt7iD3u3o/W/LHGc9idWqo6kpDFNwwSqNH+lxgyeA9DAJUS84wLJbXS1M0dzci0J1VNRwOtc75NWzPPnIiNn2z3HKOcbQwZZMtWvgJ1GspNkpsTmJPbBhCOd7Qc6zWP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ab434c629so673558039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731491704; x=1732096504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=La6p7LDFTDd20P9Ap5B5ZW0+Q1G46jQaAsRpKQVub5U=;
        b=jDKfphVS67LY5OmjOPDEliFVzOG8g6KbFRltkCUTm4W7O83kzb6d+J43DAvE9vZW1P
         W1Gzp7IBGSKtXqWTHIn+f+R+nnmYjy90sQCuOCKMj/gZ7zmwaUxmo8OeunUpCiDmmirj
         RdHP3h3imHaQgaD/6yoE18saU0GVVZ/xBJhczYWL9ySV3bRFk/eQYb/0PJVoPFoWNS14
         3kaShjKfKuHnfSQqWhxHhU+anHESDyJk5k4aB7+nowIH89hIuJu9sDox1W9s7oebg2NH
         QAIJYluwHNPW3m5x0IvHJP+V3xcnJbqo9dVmKChUDnOevRmb9jsuOoBuq5339NzqeAe1
         N8iw==
X-Forwarded-Encrypted: i=1; AJvYcCWtsSmQh6HkXqf0OuGZCQRpGSM0THqIKYGnWHAc+hNWppm6rsIas7jqGgMh0zBjv2d/4IFYwmibV/qR0dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+igkSlEZbQWAffvxDufIAKenTsESARHTC+PGCKis5Qtyj/iOA
	o8aIG+2r5uryZ0LpP7JZT/J4gXO64VftUhL13k6qt4uSAO2FkoN5rz88U86efeTd5+zIlshlVZp
	4JidVVf29Nrw0UTSl0eWauJA/DTlvw9sdkP8Z9bxx8CIEpoUYm5whPiM=
X-Google-Smtp-Source: AGHT+IFsfEUMQL1mZoWQN39J627bxb6mJ5re6byZtSmb+hK9QxIgcOD6z5h6xMDBkfPWZ3Gh1tpqOPLKWi/vH24BMdNnJ1sNMRxd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:3a6:ac17:13e5 with SMTP id
 e9e14a558f8ab-3a6f1a1ed84mr204243095ab.11.1731491704296; Wed, 13 Nov 2024
 01:55:04 -0800 (PST)
Date: Wed, 13 Nov 2024 01:55:04 -0800
In-Reply-To: <CAFj5m9+GAv4JPX=ABgwUo7RSSZ4zNsBKpiJOfuxmmwg+GDP3wA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67347778.050a0220.2a2fcc.0006.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
From: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

security/apparmor/domain.c:695:3: error: expected expression
security/apparmor/domain.c:697:3: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:699:8: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:704:11: error: use of undeclared identifier 'new_profile'


Tested on:

commit:         6d59cab0 Add linux-next specific files for 20241111
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20241111
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

