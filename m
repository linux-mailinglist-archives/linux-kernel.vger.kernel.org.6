Return-Path: <linux-kernel+bounces-446854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C13699F2A29
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A8A166857
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C61CCEEC;
	Mon, 16 Dec 2024 06:31:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F11176ADE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330665; cv=none; b=I3xxBGK0calM/WHDXTSZgaG/sFuL2mQVKLMsB0wV+yKfTWZZyU7UO3KwJ8TjEIMfdxNOWoV4DXEnkj4XwnEP0n2ElzLndhay2RJemx0UKLLwdkZnWbM4uRo3w0ydfoisMKElWqjPuokH70HPLvX2t7/8nL7q8JEmMDs3dFDFe3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330665; c=relaxed/simple;
	bh=3E2pDLSWpHz+qKRsyOCvMIVk3xBO/le3IAkheabOoFY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nadFhiYCPPafablJSb9eWzgcHitUitj//lh4rP37NxOGYpu02RSIfKGKQha+oEJsCb8VKjOfqTXIV7/5UMIrd8vtCdeDgxUhQgsPP1jP2r4QJjo54TB4WfPa4CZVtguehPDjL8pXfMawi4NLtf1rYw5huMsdbCcfK+l/KDVGQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso37095445ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734330663; x=1734935463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGgwY9doc2BDYdLeq+Akm53OqV4dukJ6miTwWudPyro=;
        b=E38c2UKxT9af7QdKBlZz2NwCDDszPC7mitQlzLDSIh05x1OivNCZqU6I8whyuyWwJi
         29FBguqfXAeST4yqT9ISFBznjYIlLK3Z62Q55I3Hb7jEFLXGaUXciJl6cwWui0gKYZpv
         /FAYsCE+9o3BsFMfLFs7Di+vN4SI6eqnjEKw/uAgTaDCSCp19OR2Hg1xvvx6VAWTXAAc
         n6hbVtoExoYcP6nhUP2mKObum2jqPMuQFJv3WXGh1NCQ7EwURgoXGDHk7ainuMzmYGuu
         6idisWMXOtkJv5hV7Z3N0X6TzcNQARqcY4c58TVq3qx29mBGne63DKqAlWpiJdYUHUx6
         yX1g==
X-Forwarded-Encrypted: i=1; AJvYcCUlIeVp7FvqUhlfovgIE6JpMXyoYmGcESu1fAes30V+/WLFWGDJEVl/S/AT37wlsP921cKljzqIdAnTF1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3AjYpHZjVvlmo47owr0iYqf5xeIojmXyrfLpjzi6ZqRfm1Qgu
	d0uTDmXrMOJVJl1ChiAe7nd5byOZZpgijnOEOw3U+xzEsgMy0wYyBZnjNYF//qvYoWoR0U2p/BG
	QFNGbhc6i6ro2I3reErFA3z2nx1kBtidna6MwjoMLo7aAr7ZumaIU3G8=
X-Google-Smtp-Source: AGHT+IHqyW8xz9AMDJraQb4QIo+grq8CirvIaFyaiu/OxyxIYJNdfxD/b3iOyQaCcqMOivRLvs+i9Vhs3cxNSZWzH/wAGnEz188Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cd:b0:3a7:e592:55cd with SMTP id
 e9e14a558f8ab-3aff086d9admr103467895ab.14.1734330662864; Sun, 15 Dec 2024
 22:31:02 -0800 (PST)
Date: Sun, 15 Dec 2024 22:31:02 -0800
In-Reply-To: <PUZPR04MB6316F684BF023564B7DDD812813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fc926.050a0220.37aaf.0116.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
From: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
Tested-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com

Tested on:

commit:         78d4f34e Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11259ed7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe704d2356374ad
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105d1730580000

Note: testing is done by a robot and is best-effort only.

