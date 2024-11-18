Return-Path: <linux-kernel+bounces-413221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257629D153E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02B22834ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348231BD9E0;
	Mon, 18 Nov 2024 16:22:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AAE22F19
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946926; cv=none; b=JrEPZxiQpQ1bwWIjRRABFAdIFBXjUT/CcXOs5Mj/0WkML8n69cE48+UCzJZNcQ5mXsGxZx96mNsJOHyEe741mwFStWz6zqaztVwwaPH0vXnkXGG1szGg5H84RUGCbNcvQaauujtNWVuudrpPiL4pYwb4oLhQqiCTCx02M+DU+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946926; c=relaxed/simple;
	bh=HBqa+dyHp+JWQfTMxG51GNFgsk0+x+FM1VXMuvUv34Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CzehmI5BkhTZDSkSgjPBYK5+8ec3WgSZMPT7K+du/vOW9f8tX+6kPNwRL7YbLb1+CtnhAiCYyoVPJ0Ydv8Elcz9fmc8nxrlPlcAEXoZC4EB5aNcpmNbxuab9+DAwAhsEbFlpAGn6huvFR7GleruOXwjtal2xX3iy3od6K1tjDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so33659905ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731946924; x=1732551724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VO6x8yo+/9leiWoU/onzCw+ANv08Uw3GoKpPFkHalfs=;
        b=Fy/psoTf1fgYwJgU1A/mFfDd15yisQiLM9RbP+buJKs753vyxiEF3mz4gtJGJ2+hh6
         0iB37tuqT4fuuOi+vN5V2mr4jnNI1cpQypOp1WksImlySZpIeysobwBFwypGTafJvWM7
         3lJ1ctHDykwuTUqVCV5BGz+KH1NE5h4riTb8ebjAbT226mvlb67ssGJLPZ3FTg2PstNI
         gIHsVcSdwcexQWODS8raMvaHM0yc0CbQcB8CkklIeK3UGuPCbA2h9LzN4s/QyNYbuvID
         4omXdf30/bgQWa1YADrE6818AqZEAAMWxowz4kACupAHSm/0hs+gH2HOKeu00Py5ZXCb
         C1zQ==
X-Gm-Message-State: AOJu0YyEm5kv0R9uxp2o3yHQpWNHDQTTRmyHinbCjBCZ+8xK2a9NZ6tI
	pfnjyN0Gzs9hlV04ot2sXmybByVUKhWGEcv5FDe7/RA9Zg+VLtIMh5+9xV1qM96sWuEVuBg8HM0
	1jacQHR+k7XX33t3RTAPxbQoNer4Oq5KfCgsNYFK7VKmtLug2sfNdTeY=
X-Google-Smtp-Source: AGHT+IHuvFppAG744L6xVKHmyokyL74qoLAJKdT84tSyW4IkDxEf5RFDGArQRaOvoKR82bmXLEr3i0kgGcvYFaV5LpQ0XzH1UWGU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:88:b0:3a7:1e66:ea32 with SMTP id
 e9e14a558f8ab-3a74700ddc0mr144020855ab.10.1731946923997; Mon, 18 Nov 2024
 08:22:03 -0800 (PST)
Date: Mon, 18 Nov 2024 08:22:03 -0800
In-Reply-To: <CAHiZj8g8JxdvFOTfkyi6nzHVfirswrdVkrmOPOCFPpqSf_rRqg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b69ab.050a0220.87769.0047.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com

Tested on:

commit:         adc21867 Linux 6.12
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14664930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e31661728c1a4027
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e16ac0580000

Note: testing is done by a robot and is best-effort only.

