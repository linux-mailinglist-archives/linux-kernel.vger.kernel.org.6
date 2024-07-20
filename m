Return-Path: <linux-kernel+bounces-257819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C977D937F5E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A691C21227
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B4917597;
	Sat, 20 Jul 2024 07:01:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8011323D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721458867; cv=none; b=qpV07vuGr6UiyLC/+b9sp86bstVL2V5I+5zyIAxkibdqCmjDlYtNYjvV5DeOn1Mq1YsIQjG7xTVF8iIhpl8re3q42Mgkv4AHNxmxNzDgZQAbk634Sh6dabiYIIYajmOfJXAKtTx8Smk7KhQgsECkUDstDZ2TVKN97vGLqh553GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721458867; c=relaxed/simple;
	bh=Yz1O2g221nEwW1ySzr2gAc3UEWukWUaHJd2+GJti/Ko=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hNh5ZMnLqqrAn9aDsZ7orIbcvKNg/t/ZiSoLhMEF3Y81YI00rhRZ06EpGw06CBHQ6oFLzFyqMiElQzTYU1PxurOIX3hiv68/N5hkI7XSUnqHXg9CW5i4NbC0fl4uTfV07he6bJpfy+QbCJ5PYNrOXKB4Nl5B5NTcmqkc82V0EzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39794551bfbso28540945ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721458865; x=1722063665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRtgiKoJlbWVewhYHDKUC7MKTzVRf15AxwXYdDy3neo=;
        b=XzKtFKX4lZSjs/G7kOgqgdsGmLgO9HiXoUFgyj023jLffKYFtODzDmOyLfnin2sQRd
         2Tqx6qHqiljdz+7cCa8WhdMkjDyn9mZRhO4/NBAoRL3NBOvbuhveJxUpsM7dIepv9koS
         gcRxK4YmG3Av7BhxoIsie5bHgTlCOR1Fq2NAU5FxJ9DiaF1JudhVCKMk1Pg+IRhfpXrF
         KVAJ33dJWxAcCj/830B1In5SvqGyHTLv5nyWhrARiQ/K3whB/DoxVtM3min3WV8dggDr
         UtphuDYtmYehNH5JWYWuXJujXuZReLKmOd9QERvdfZXHOTOx0V4L+mn6up7C81TX7tmS
         sDGw==
X-Forwarded-Encrypted: i=1; AJvYcCXOaOG/BemRVnPTpIUFmBudHafVu+AtPQfi8p8TDy4oZ9CKY6ypWYx9bRUDouTMC/SF+2yJ447iUJfr5V5i+1qOk2SeT3LwobJHgA6E
X-Gm-Message-State: AOJu0YwvFk4CEyeE9gu5LrUWX+BsStPdJbSqRWdCjCWAzy7I87ZZVqLF
	aCpwd4xg6a3P2ebUTn+LnqPWiwxUeaz7OXayhiNEAGxoORvwARKuFn/BeibxVNVnRVoNqn9XeRQ
	8S6nVRz5N6RM0HZkQuSpAo6nZuzfUAfnQKl6Rn8MIKdLDhkIWuOgQJ4U=
X-Google-Smtp-Source: AGHT+IGEDJnDkvcwBjRxRpWrrnKr1Drq+P8VhRF0N5HOYOyde1q36FZz6i6zquqfCx3x8mAPqg+di33554zDN7Pka/y+bTP7g9dD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:395:fa9a:318e with SMTP id
 e9e14a558f8ab-398e17ab520mr1930185ab.0.1721458864742; Sat, 20 Jul 2024
 00:01:04 -0700 (PDT)
Date: Sat, 20 Jul 2024 00:01:04 -0700
In-Reply-To: <IA0PR11MB7185B8D0CCCC219FDA647325F8AE2@IA0PR11MB7185.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020f6f8061da86023@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
From: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com
Tested-by: syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com

Tested on:

commit:         581a87b1 fixup! mm/gup: introduce memfd_pin_folios() f..
git tree:       https://gitlab.freedesktop.org/Vivek/drm-tip.git syzbot_fix_remove_inode
console output: https://syzkaller.appspot.com/x/log.txt?x=142f1179980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16fdddce5d38a1c8
dashboard link: https://syzkaller.appspot.com/bug?extid=ec4b7d82bb051330f15a
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

