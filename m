Return-Path: <linux-kernel+bounces-204005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37538FE2CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BE4285E14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E05713F439;
	Thu,  6 Jun 2024 09:27:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171813E41F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666025; cv=none; b=qsCvzYjUng7dQ23kzOZ1YAHSqvDqJY+8Er97fdvgcGklnqE0wKWE74vGRKeDk5avPUREjQM0kB4FNmqGYtF/iqoCk68/AvHvbrLfnZtI4kOUYQ8ezNmqbLBENiRYARbBnbGkqrx5Ug8g3vNTiI0+UUsM7ZVFHfufF71oMSt1XEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666025; c=relaxed/simple;
	bh=Jf6YNm6wcgpNoUzNI61WXOBd/WE+vrMwcZjybE1G2oI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CaV/DmJYIyqLUQv3BaZ/w6py7sPmKvLOIu8/rSTqa7P5Kj5mYvu1Y9dF61d5aqvp+lHxMyBbu8LpNNSNTwS4vE9gYTpdCDR5M5Xl9BhrgfbBXpmkDnyJ+WqeMJOoOVJBI+bjsaCP12Q6kSoNIqbhZvcn8OMe08FR2WKzAcJ+SnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb3d17daebso77559339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717666023; x=1718270823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqObSU/eGOZi0qYtyDc3pFZx7VjJ8yFxF9cwIYYk1/8=;
        b=b6QEaTIuj3GdjMrWoMOMWMUPxcwd68ttPgoni+hHxtrHH6jYiyNn3brzSjluSNCh9B
         b7DcMJMymfV73vAI+QdAbkVjSJVFs0ctoFCI44eVV5UIzFc85l1FGbeqaYd2VswetLyH
         PPN6JXNcIqW3uNDooC8keuIhuMz7XAqVgUxqHhVmj1eDjNkj3bkEtXqIyyfSEfJDpvjD
         jPk1ioCMz22/duKludgtipH73wtxIHNhgi/8QcSDGOdTAZQdPq2Fz8rw9PgOG490SSlE
         M/41voA/axOoKXuoG76UhnRdXSU8g8oM+F9CNUetfHyMUQwL7eJnIZ+RRmcsYyMnus0a
         978w==
X-Gm-Message-State: AOJu0YzsrVhJcpBjMo1GNx/PFlTDjsvFI9pMy1IJt/9Eb6XPi0P85fpo
	xHiqWne8fCfkxcskdovtWvcBiKq++KyU7wV3MqDVkMdeAXLQzBGHNzlt1kSyfFyr97/+xOsWTHB
	Eg6LmwJ18Go3epaGpB4plP8qky3wWL1hpI46sW2Tzlru0J+kbeoumBOM=
X-Google-Smtp-Source: AGHT+IEmKczk8JjuZGQ7pOsBZ4DNzLsMYPbmwA5kelBawQzKSSGzhsL2v7+Ly4Ckodn52Ff+xtFMcsv7o7d+Df4HMflzHcuQcOq6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:374:9a34:a16 with SMTP id
 e9e14a558f8ab-374b1f6ec12mr3009905ab.5.1717666022854; Thu, 06 Jun 2024
 02:27:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 02:27:02 -0700
In-Reply-To: <PN2PR01MB4891AE31D63427B828C79ECBFCFA2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000229e72061a3549ee@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/trace/bpf_trace.c
patch: **** malformed patch at line 7: @@ -67,7 +67,7 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)




Tested on:

commit:         e377d803 kernel/trace: fix possible deadlock in trie_d..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dfb85a980000


