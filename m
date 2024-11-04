Return-Path: <linux-kernel+bounces-395304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901219BBC01
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559462844E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6646C1C9B62;
	Mon,  4 Nov 2024 17:32:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469251C4A04
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741527; cv=none; b=X0K8qKMJk0jrO493DpAG95gkPFs8/FppOHEgWoPJ3Z5X8Y0LqQ2P853sZmRtRlndt7W7+4n/uaim5YqusSBNAJPGuNk4xgZs5oBrkO5ygc3WaGogewCg9Xns9D9HE0ZhIKvujWvzMTKk3qaI8x+LrOTy+FbwDuHrZylfO1trdr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741527; c=relaxed/simple;
	bh=DkJFdr5UdE8sba3QNUIALfED+FlVHx9cbenGKOqi0TA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A0kVW9a5U2+gYpNFnqqVHIoDaO9t3XYH3qawxqEMcYVNOcMbr16/RuHq05uu9ds/Ohm2Pd90OCMFTZZE+QtemdhJwHnZMKSj9Sw5Fw9g9d8sv6Bq45UJsF4vRxF9GmxwCLNPqXrvFI2QCxmg1wGmY27Sk9Wkgy458d2OB33uMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c48f1312so22420845ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730741524; x=1731346324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29/cx1y/26J9OHaviQDoceLugVQJEcsCBYDh9IQ7zHw=;
        b=UZ0UuH9Y3TglBmhzGas3Ulzvqhz3JIgTv5Di84B+SczrQQC7TEv/1R+UsclD6iLR/y
         nrPF3wQcBlnBdQVxGdBVuTvd4cAksix9BLhxVQzO6fvCE+S+JJ4MQCnp/E+KkT7Rjj+1
         bGL1mEGQU6yzNSFLd4SGoXGIZg7EwOi1ho7RgUhtSJy0Ris+K5fEriL4/WqyMwDM2QXz
         9ZaFeLTOHG7EiZknpjMaBlmZnlEm3zdpqTm+p9iRLxVYkLk81N77Y4BdYYvAy3Jp7mEO
         LS/6vaI4iK9blen5ZWyxwx3eYgWBkjVkyVHrhkz9eOp7R3uweM35S2ox7UA5s/K+0nUD
         69qg==
X-Forwarded-Encrypted: i=1; AJvYcCV1k04Zx+TUNOHKfuACrm7uwhsmpqTJYT9B66T/WMb1yYkcXisZET8i80TV9ARVA2agF5GM7jpB9y/wwpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xIOCN8PkI2E99BpU+M2ieiNRscTsF4Zh2qumLMW4VMjPSyt7
	/EunHURV8C9bVfUgIlVrAS39+hQoOOFIZXbjL/LtnTu1kNUyt11gkLS4xVrMqDSNoJexlUNx2Vk
	CjUP8IDyoez6AWWxl3eKI897iC5tAvULW/kJBJU6sPrHtzTlbkXnePac=
X-Google-Smtp-Source: AGHT+IGgSxT+Fptgb86l9hhn7jiITeR3aWXiKR1J1GP+gYSr0rsRRDr62ASLkZEdVvsZxXNWzbVaC4dm5X5OeZesanLsPK1FASwQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e09:b0:3a4:eccc:aa5c with SMTP id
 e9e14a558f8ab-3a609a2afbfmr166327275ab.5.1730741524447; Mon, 04 Nov 2024
 09:32:04 -0800 (PST)
Date: Mon, 04 Nov 2024 09:32:04 -0800
In-Reply-To: <zgopoeun6qh6olzr7rogagibyhpdr4n42cakznftggwq6dwss2@4lyki4vw2dkr>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67290514.050a0220.2edce.14f7.GAE@google.com>
Subject: Re: [syzbot] [kernel?] kernel BUG in binder_alloc_deferred_release (2)
From: syzbot <syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, arve@android.com, brauner@kernel.org, 
	cmllamas@google.com, gregkh@linuxfoundation.org, hdanton@sina.com, 
	joel@joelfernandes.org, liam.howlett@oracle.com, linux-kernel@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, maco@android.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com
Tested-by: syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com

Tested on:

commit:         0012ab09 fs/proc: fix compile warning about variable '..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/ mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=11a42740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=dee8aa54cb2f5a150f9e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

