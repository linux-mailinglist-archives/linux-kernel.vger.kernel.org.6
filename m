Return-Path: <linux-kernel+bounces-407830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA99C76E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E277B2BB93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEEC13AD33;
	Wed, 13 Nov 2024 14:58:19 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3491CAAC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509899; cv=none; b=B64erbgMaA9deLgXHIHAMzPiGJQ0TZKflALxFHKCmBYA3a4ncql5QfSf6PjaneTgQksmpJXUpbs6bp1rTK7meqW3ustvZ0sEinbN4qlWbbowHy+RHrzEXPgPukztJw2fUyShh3qSoWdCqLk/U91xTnovF1QFV5MwIt640ldECcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509899; c=relaxed/simple;
	bh=exdh0jen8gJ9mpwejxT+xqA37fK0mhqlMiPwb78cBzc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cbLg41UusFItNhIGv+6AXa9BJka2+jsocbGCDg0v4NlhSppc86K2ojDix75HAc+jQY4jqY181B88R/uQx919JPGjZGXxAKbmMygARDpKlAkr5l5IldwdKjMJZOmoJI7js68XJsUpAe8Y6Qk4doEJta/N0OMu8zsK+pqPkO1o7b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6ca616500so76504225ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509897; x=1732114697;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GJ/SEsOZ1L2zRPT0EKbNi1emDrxhVhdS5kZc6L38K8=;
        b=Dq1C052ZHQgWCFm4hSnNU1ylSG411VdigWgkPPae2VL8aN+B75SxHeRaofdVLkeeBC
         qAnWBWOXuZcK3+eoJAIlbq7TvSRlQDCh02dz3gQOP+ijz9Yi4o3qaC9ew+XwCltzUyZr
         ApCGVkmEooQW5RCpj0khrlNv1WthZepP7n/szJxswKkldwc5050eTyIe1bsUoj7xnG1w
         ra3mNc/Pp+QceGHeDEGE4zgKxQBWKvFxgy2jFszWSUuVLU236Jg/Gptde34KPcWe1cEY
         nelviJPadFkVaKpsabuSM4eAyI/OtcG9CEpYEXpPG0i+oEHCvhzOOhbyrJ5xbAgg4QmH
         2mxA==
X-Forwarded-Encrypted: i=1; AJvYcCWKSQfOUy1jcvDiEb72/63KxfXPT/qb24ZGl28Y3FlJaWM8qDn8YKZjgFymfYMCLvq8sOmFHtcPuDrvUks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5Oe+jX/DIvIwnOiH+hjD81PG+aexxZjxieMtqeMJc7D5xo0G
	J8wcrxmnr/Ko7Ipb1gfuEUbdnb+2DnHxzGP+zU1aooIhEQogXbLenUJylH/SEryMg/4aTrW5OWM
	B9aKYy7qCGeEReu4Dvbw4t46CfZFyZn240TpxvW/7fAoMiXaI1ddHSA0=
X-Google-Smtp-Source: AGHT+IFdpJh7swVHysfoFHkNwIHE7i3Gm322gFw+xNV0Im9qT4AgjHK3u54DyfAuje5rwqoW2/jpSgUiJFCeBK78tF2+EyGpGd8U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:3a6:bb36:ac1f with SMTP id
 e9e14a558f8ab-3a6f1a45467mr205631175ab.22.1731509897270; Wed, 13 Nov 2024
 06:58:17 -0800 (PST)
Date: Wed, 13 Nov 2024 06:58:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734be89.050a0220.1324f8.0049.GAE@google.com>
Subject: [syzbot] Monthly crypto report (Nov 2024)
From: syzbot <syzbot+listbb9cdfe92636134be785@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello crypto maintainers/developers,

This is a 31-day syzbot report for the crypto subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/crypto

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 107 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 228     Yes   BUG: unable to handle kernel paging request in crypto_skcipher_encrypt
                  https://syzkaller.appspot.com/bug?extid=026f1857b12f5eb3f9e9
<2> 15      Yes   KMSAN: uninit-value in sw842_compress
                  https://syzkaller.appspot.com/bug?extid=17cae3c0a5b0acdc327d
<3> 6       Yes   BUG: unable to handle kernel paging request in crypto_shash_update
                  https://syzkaller.appspot.com/bug?extid=e46f29a4b409be681ad9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

