Return-Path: <linux-kernel+bounces-229851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC091752C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877291F218F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A73ECF;
	Wed, 26 Jun 2024 00:12:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9EF7F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719360725; cv=none; b=XrzV7WDLQy3MJcILviNOZYrVXQzaf5TKyHbE2sAYpQle5D0DOtaIJIkwri4E+Fv0wLItsWmic3iXR+qxo9QMhfoPEct8v1kRdg36tVdFnEHZcVV1r2BQjUnBAzxro092jEJkjEw3b9gmw7gRJqeLUpOvH4VTPyetyZNCZAME8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719360725; c=relaxed/simple;
	bh=N5d5mGPYaFZcI4PKUpL0MZo0/O+sJUGDzDx2B8Tv6yI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A3vlFYe6NapaL0rHWT4YfXpeE7cLkgWQQpaeKjFl3jE7z5YtDm4gJLroQ/MZuk7xrIRJB5Y9AANUlWR01r/fwZ8fmVKKAQPPt/hwvkvXjHPN8hwmPR/e3dX/nDstr9joXiiqKm2Q7wbuxRRePFpNNOiHojbNYs7SAFsrvTtcZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ebff1004acso770312339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719360723; x=1719965523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wNDzpOvjU23Xb9gyWLJ9lNTYA8nnWJGKNNlbizL8xY=;
        b=UMJYwBPbeQ2g7n/7cPBCrSSBtBZLhetweq/2mm0tduUNce6AhNGiYguVQZFS22+NPU
         i+6RDmjWoLeupe0inwAq3E+a/hNx7zL2OiEG9KeE+A2QpobOPU9MHYhD35yikwhlGxGt
         oOIv5T7mR0WqGjgkiBrUQgv1FXJxtoJaJ0ALFVfXvkdkXs9N/aDwu+tnzMQDoC0Q+wgw
         eIYpghzN+Nw35wRZqtZ2aZWZnE74U4kAa1vPvHZiy7I04rCOKKmpeB70b7WPc7+gUBnp
         7rS/cbZ+K/Vrh4uluAIvq5HSP/wzOlpAE/bgFNnJ2+LCKsNLoWDB0PNI3sRJJO6l0yya
         YIbQ==
X-Gm-Message-State: AOJu0YzaYc2nnoo6+jZCsPGLs/0bp7Z+GHauHZgtTExf7sOf4Brylo4N
	Om1z2T8PeOx/ACf355WMgYWuuWZbWPY39tHbaRPFKMccEAjoqBtIbZ6X7Bt7OllZWTMC1pefH6I
	73ho/QMao3u45XuSU1LWZZClyCvkckqI1f8o8O7zBfPzGmM+PQzMnrpY=
X-Google-Smtp-Source: AGHT+IEXCpWuKyVmok53XsAucC2S3qrmysQ0+EnSbSEN3mm5idyARJNZEQzK/Vta1MR6KuZpvL+VYD/LOUWEYaZIJkZxFaHnrUEe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14ca:b0:7f3:a80e:8cf8 with SMTP id
 ca18e2360f4ac-7f3a80e8dc2mr22217539f.2.1719360722961; Tue, 25 Jun 2024
 17:12:02 -0700 (PDT)
Date: Tue, 25 Jun 2024 17:12:02 -0700
In-Reply-To: <CAMc0M-_mB+uvhQvZ=u3KjFNREwMzSRiEKKUDnzQMhrOsbFtUvQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000221663061bbfdd71@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING: kmalloc bug in __snapshot_t_mut
From: syzbot <syzbot+770e99b65e26fa023ab1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+770e99b65e26fa023ab1@syzkaller.appspotmail.com

Tested on:

commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f3a389980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf5def5af476d39a
dashboard link: https://syzkaller.appspot.com/bug?extid=770e99b65e26fa023ab1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170174c1980000

Note: testing is done by a robot and is best-effort only.

