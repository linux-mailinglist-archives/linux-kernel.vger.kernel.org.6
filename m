Return-Path: <linux-kernel+bounces-180242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B768C6BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A368C284906
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD1158DB2;
	Wed, 15 May 2024 18:09:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EEB158845
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796548; cv=none; b=tJQIwdy1TUOQW0IddPDX6sZHhnsjEBK5ZL2GhfwgPu2lehpcLqqOA2hqU2SVEQXsxeceM7Dz01ibOtzTMOpb1zR47lnrwGCcMZ/obrS6rPXBCaOvWqh7VCYtQdelqKXOTg3lhp8UUClMiKEzqA1UTzhdUDS9Cd0aq+7IY9Ige4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796548; c=relaxed/simple;
	bh=ueDbItGrH33QV5pwvOmlravQoxM3OzojO/of6mwTwVw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iKsGa8Lv5tLk9Kf3OsTei7XUQYxLnMrhZv3IJH7mcT/vSdDkLnPP85hQe8aYeYWCU+NWtelLC8xcIsD3al1X6R4ehOsC9j9KRpOxhTWiNh5OuLe9/NmSlp91m1nhlVib8S/CixrMtDUSFafGu5gVk0Xvy5sKPl3B4t8VS2ljjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1e05c39easo417668639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 11:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715796546; x=1716401346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP/Zme8K3zbj65CmkwRzzBghWXaR4LwXbXZFUjpvzgQ=;
        b=mHYXo7fxTjdQlXGKfmL7AkJzqbBcDSo0T6tFDaBUFC/svGQ5HkS2Mkl9rAfmTkxyR9
         SI4LCQqpgRo54o045bRorC4ArWFH/cBb/a5wy0X6qwmeMw6XU6tc/ZTFfBv6miiXKQ4Z
         1xtjhuPJXbISaXipz2yVn9k6Uk0XfgV6Hg7nA5tvP0DT4J2hHjtxgpsOWe1U7bCFfO1A
         YsVQ3eN9/N+g+Cudyd4OWAIoqJO+ZuABAvzrYdhXKQd6A3MBFkgVxfap3hWTp6ikos20
         WJH2yR/Zu5S0qconaU44sN44vZaSmx9DOFDi5H4dtv8l3yG4E8xtknLERcmVwCpHWPdn
         TNeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+ag9fH8NtfEQPyda/knwNFQ4r5VflKJFXLlnN2Y+asjjJ+vqQdMnVln1V1cEu3GY+dHGB9KlZSiEHBnfYX8Xj2fbjBlRhbX3a2RJy
X-Gm-Message-State: AOJu0YyW+uhJQBw1OvuAuFEO/ktlKAEFsfv7t2P8joXewoG35M508IeY
	aPkVa0hFxotMf+48vIlMzeSmuqQN8bSgbaAv9WaQr/rN3RTp5rGruluGiTVSEoCu3DDY6fBFXyA
	JlKm85XYh6FKp2c8R6fuFTZolGwBUlEiaXuBcZWio0M2qPl4dJ9e1o3s=
X-Google-Smtp-Source: AGHT+IHOCF27ZW2apmHXxCAoQnwxV4k4QFP68S37o2Wer4Pe+c8vuaPuujGjKICC6/1Amh/kyfL4GE8KDPFWP/DaV2DfVcXts2Z7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f85:b0:7da:18b8:2790 with SMTP id
 ca18e2360f4ac-7e1b52175e3mr74949039f.3.1715796546040; Wed, 15 May 2024
 11:09:06 -0700 (PDT)
Date: Wed, 15 May 2024 11:09:06 -0700
In-Reply-To: <20240515103325.3308-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a245fb0618820327@google.com>
Subject: Re: [syzbot] [kernfs?] [usb?] WARNING in kernfs_get (5)
From: syzbot <syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com

Tested on:

commit:         26dd54d0 Add linux-next specific files for 20240514
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10bfc034980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8af44e051929224
dashboard link: https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1208dc7c980000

Note: testing is done by a robot and is best-effort only.

