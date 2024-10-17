Return-Path: <linux-kernel+bounces-369163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 814169A199E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8926B240D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE607DA6C;
	Thu, 17 Oct 2024 04:18:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F922E634
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729138686; cv=none; b=n5wWDQ4QeLG76Uy2a68lGkOJrAvxhm2dBupysu+LP0xXaJQ0zreL5lr0F8ubqHL/wY3aP8yJ/lGr7eCi17/LDnSYpQxya4EIFWl2mNeLTZZbmC37Kl4OCuCY0wiUa+Q5XDC599C91TivJDn64zDY4HiyIGfQfrBKtf17dd0f1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729138686; c=relaxed/simple;
	bh=1OU3n6Oq4M7nhUUx2iIxEh0l7ukW95iagzuvOHRgB+A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nl4GM1UnQVpV3DaU+Le02znDBd5ZNb5uZl+ndlClwB2nJxOfEXLmqjGao+DIDSpS+zknI5YhkLpxy8U+uO3gxIpmbMhih5wjMwVlvZ/Hp+dr+IV+H1k4J9Zo5CJRqPp51VHsGIh3fjkHSz5qcYMpbZCZWgPJLMz66v0kqx2+Niw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8352a3cc8b5so53426439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729138683; x=1729743483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jY61h8LqdmtDNf/l3f6Fa7vLNIRrdlFHFmkic/5tLgU=;
        b=OAl4JDaZPC7hygq1eu52xeCtVsIXrCpJeZZDMhGOw5jGWNfKX2urr3fNs3GtwwtFlR
         /9J63R5jHFUtZnk9AnSreA3tv8HQ/hUT7G9LSCyuMJy0WZBj4LcKIBDgFSDiGdDtIfVR
         WDD2f01y0dI3JikieEjwuEsB8NNgz+jpPBpa6Kif9S+AceB3mOJ59EPeTJqFLHmE45B/
         GQEttnP10ql7uGmjdgiHan47N1lFiB9aHjDUO5x10NIgQzkuXs0ac2i/xwLuDis3oG+X
         pY3If0f6HK9zmbm9H52B126T9y7SBRlwe5MBIsQStMbaYfwFHHouq/BpPYGKoF982rLK
         o+4A==
X-Forwarded-Encrypted: i=1; AJvYcCUULcqOy4RmfjmbxnBvvCBbSmJo8BPKhUSCuAs7k8XonmRRT5TlEFuyfzY/0Z3LTU9iKVsKqUVD8nSN9KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbU+w8sLU9QaLngds3UX39ArrZl00jbG3u+aTTlS07DRGN8nIH
	i1vtisMPNNN+ESJveQrkxOwbfP5jcDSlyYoSCDb4Pb0Q9FwlIFXwSz99JkmJ4S6BVlF9FD237DA
	Tdp1pHBhNMykkKi7QbW+CjIVG0p3JVJw5U6GWGC1E/vy4ftfTT/u7InI=
X-Google-Smtp-Source: AGHT+IHecXCjdNhKl7trxeGNO/H1tW6w8QYfFSoocTY3Dx0XEd9VtaLK94WhYDh/oL4TAV/MRqJ5eZL6zMp1j2JWD9vUrLE/dJdZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d06:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-8378f64c49dmr2521392539f.0.1729138682825; Wed, 16 Oct 2024
 21:18:02 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:18:02 -0700
In-Reply-To: <PUZPR04MB6316311A4447A7FCDF5A796E81472@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67108ffa.050a0220.d5849.0020.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com
Tested-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com

Tested on:

commit:         c964ced7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ce345f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ca345f980000

Note: testing is done by a robot and is best-effort only.

