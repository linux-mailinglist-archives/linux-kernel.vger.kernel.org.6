Return-Path: <linux-kernel+bounces-439768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A49EB3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D54188C832
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF011B85F0;
	Tue, 10 Dec 2024 14:44:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1891B415C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841844; cv=none; b=TDNSuOJCUIwTcwhvYY1BXiQvgOzghbbhn/x5wavd7LaeV8pIgUkPLgjNhynvo84Vk6JUOY7pFHlzcD89lY3BfjGMcwVoxgKaK5Xxl4gSKpk+HmGSzKjINujydOcxtCOv/EeHemH5GRE4gxuHyMLW5kY33kR71Rx3Jfm/28gV0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841844; c=relaxed/simple;
	bh=UJwFBO9vbEOarQQdzEAtnm6eWrTvYdifQjQmy9S6VNk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sk+vA3WNoyr88lpzwfLIrA0Mu51gRgvKav1Ax/zx9KOm6Oxtse5mrI9TjqDCTJRTVxjU7Vib3cIJwiXTpvv/VNTYnqdRBWqN4/rur+Hvx1UMjOT+oXryCq9wgTBkT6Z1woEO9wA71txKLVQVB71SxgU/GYekOUyqB/xOZVkGbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so22333595ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841842; x=1734446642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHRmglB/uTlqO78lWJ+GcsToPOMC3b4XV7WsgLDkrd8=;
        b=Y62tIpEXW3NfDhtXVy47YIrfcm0h0zsntzYhk3k4fS0pnfuOsHqLxbOct6ZrYiXNTg
         7QoMAGbf/AqI5iwE/PLjsUptVocnY1cynDyn77Nnhg15QIWzg9iiKWfLnhpqBNEPgs+V
         HDgDCvcTosnmcw8wujnXmm0LBWJM1oZSOycZUt3iv523RToeUm/4ctSQu1m4QiGaBLsJ
         EsKhYerIi9kT93l6UFx514PEhHLTLkp8cMMUpPVlASLuZCP+n3paJbVqf1aYXEks2ZRB
         q5HI/SDOG6jnBIsgAwkmgBWnui5+uUKCA1LlJwpVxNluonZECm3vjPou4QcBwCdA6nIR
         USbA==
X-Forwarded-Encrypted: i=1; AJvYcCUfUIgCMx4Rvp7NGZbXhE+vq1/UqOix6O+TWDCpQHDHKRjqbjefzEpng/Fo41cjw87bOAWWDHF+j0bAe1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9iIkvma2O6Aq7l6SWROE2+oq4wGEi1bosR1oNMpbptlhKuN+U
	AAulllEJzgq5TkGgAPOB6onzqFTdhMIjSB+CSJM1qUbooQyX4E2ycAnyuWE6FgeXpvAiVpS+uht
	2QRTIYr8htfGeNsvilM5tgnV1gXsW/58zbMm2oFl+iGqU7ZOPnInS8EI=
X-Google-Smtp-Source: AGHT+IGGgYznzK9FyGa6Y3SQoRd69Sy14L/LftCeFxE3fEamhn1CYv6QsyjuW4JiisG7CRdwe3bBn4Sam8D0BTwyfYYIVTU8kMOm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1786:b0:3a7:a69c:9692 with SMTP id
 e9e14a558f8ab-3a9dbb2b21amr44928275ab.21.1733841842547; Tue, 10 Dec 2024
 06:44:02 -0800 (PST)
Date: Tue, 10 Dec 2024 06:44:02 -0800
In-Reply-To: <6757fb68.050a0220.2477f.005f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675853b2.050a0220.2477f.0065.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
From: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b341a0263b1b804d329f864c2dc24815364510ec
Author: David Howells <dhowells@redhat.com>
Date:   Wed Dec 4 07:46:46 2024 +0000

    rxrpc: Implement progressive transmission queue struct

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bbeb30580000
start commit:   e58b4771af2b Merge branch 'vxlan-support-user-defined-rese..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=147beb30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=107beb30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=ff11be94dfcd7a5af8da
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cb93e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a3d4df980000

Reported-by: syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com
Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

