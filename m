Return-Path: <linux-kernel+bounces-334413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C14B97D6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC981C2265B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F173E17BB0F;
	Fri, 20 Sep 2024 14:32:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4472B1482F0
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842724; cv=none; b=vAG6tSiSYIgyrxrpzFc8gkEgCaIt6vB8zyI5r3OuAuLr/mQRmqBmwqcxzpBN8+IpUtKbsPD3qOja4YiUZhyF0yU7rOJuMTe2/pRNkkUcoAyRob6Q4fT6qrto9wlj8Undt9JbQVwVglHBzUWdo0Y+D1g6G4Xnm34NTkelEAyUM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842724; c=relaxed/simple;
	bh=WidFJb3NMZV9Yy2mH6GHRs1dpNxlRho7VCXoNsx5Fm0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UMisg0DmOXLpUsfU5+TndsaV+I7SRcxDaJmuaJnqfxzt7zn1n/gqVp7pS+Cd5Mu8Hr/lN69AOcDWaJ3I1wXmPT67SfNqPCKgFNyGg4v0sZuxPp21REDz26DRKOH9pt8suReeQD4vlQsFIM8wPuPiK+52rGDuCY578MftEfa7oUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04bf03b1aso27275595ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842722; x=1727447522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fNgf6Nm8Z8mW2VUsN3FJZwGhU83vNsejLxJm0oyZEw=;
        b=QHxc2FQUCnqO2esqZbKI25cAIRmQB++TJNyysLu+vIoS66RAUMMStzgVqPRg6JL0mm
         yp5T5BsX2yhe/0c10UJj8FuGovT1ZpyY7Yy7X7hu0bDWNggIMfsx9dH+V+4moskBI/eA
         KNH1MksQOvcLVT+2RxwBOFpFTT3FTtvu0js2UsW4RbYqcfq4kNmQYi+WdXEr7uNpyhOU
         4lea60/YTW1W9I/5r1F1Gvl+BlLP9DbY0i0rKrvIbYisk9wL9kUnzrZv8pbJmPt5Ugc0
         I4VCgqHE8qbE25s36fcI1LFWN1UQoJztOaNRDzx8viPhNTmnec1ihdfECXu98Ay8eAKI
         FgTA==
X-Forwarded-Encrypted: i=1; AJvYcCXvNxx0bCd7dvb3bCyOqNmkmJxsRlVVYbTVn8JM+6eyR4pE7LqA3ZnJ3A9y7905k6svhmaiVQcBTT7F800=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44bJmXShvErFuJfYVe3hDc0tLdD6yMD4zfWmfHAdiEpGQEFEV
	P68GDV+f0tX7qy4z4Lrq8tn0E+E8EI4/WuR9lDfoSdkNVSsulewioJrhbPo+N/svCotrImci735
	fObv5yAckrOGR689HB0tqegdF0xSzREkdVG8v3HdWCOhwTxc162hvGqo=
X-Google-Smtp-Source: AGHT+IGJMZq7mjfyNUxTlmU84/UoFrrbsTirufRjhkxQzcF2z/O0tAEuBtt51R5vBQPIQNW3u4apOMUDg1tEG9SM5yNSuUFxyaH8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe9:b0:3a0:480c:6ac4 with SMTP id
 e9e14a558f8ab-3a0c8d29253mr40153185ab.22.1726842722431; Fri, 20 Sep 2024
 07:32:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 07:32:02 -0700
In-Reply-To: <20240920142746.3370-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ed8762.050a0220.29194.0058.GAE@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ext4/ialloc.c:628:22: error: incompatible pointer to integer conversion passing 'ext4_group_t **' (aka 'unsigned int **') to parameter of type 'ext4_group_t' (aka 'unsigned int') [-Wint-conversion]


Tested on:

commit:         baeb9a7d Merge tag 'sched-rt-2024-09-17' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=31b069fcee8f481d
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ecae9f980000


