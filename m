Return-Path: <linux-kernel+bounces-306108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E0E96394C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44210284E35
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2F4CDEC;
	Thu, 29 Aug 2024 04:19:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E923BF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905144; cv=none; b=HpYT3KKPjTuqBX3i5Jhk6Jmdx0CC/sLr+JvUiUqlK/yKav/XIOu3/MzjqwMlqehf39y89XaoEK9gfJqgzEDqyv36W5kdkQ5aXRfwfYo7jErBeBb9KTO2YkVcjzXMu1QRkIhu8kAXiQljfIRGPDLJioMULtsLIPUxNAGQOxwVy8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905144; c=relaxed/simple;
	bh=WOskauwVtlZNTV0xQ5mszVRb4DYFfUIlZlB6wqxkrcg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IdKSFzvkt7t9OvDYMIG2vqdOLGjwBaZUMudZLQeUN3SF1Od8VB0dHIb1MEX+ju1mECZpe8fjEvgXW8G84tcxGihYrb6ITR4lfIa4hLP6ObU8BdS2yuLW3uhiGNM694NMw7dqOGYORhWi62ZAxaAH7jfx44TnCV61UYAEo8w4+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f37874297so2190675ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724905142; x=1725509942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahOHss4qlH490rWYJj7PhdRDepLOSeZOKX19Y77t0Sk=;
        b=ab0hhByIjQqndiz2CJwfvT69jgmikSHpcphnxH1mChKea2m06rvZtqrmDhiiccwAQN
         vWB74pMgqD8xdURwUdAtDJ4Ji2Hd4D2liqC9NdYm5L+W1CHvMnwQ3iU5K9oLqcI6rx3i
         G1r699HPUg5TWdLaCA0ZSd/UHxK8DWRQpEC6ScWvif1B2GIWL3qFnMSDdLqC/McoTIds
         kvUYwVXfoPbiX66UYAUcmPGjLi+aenme2FmFbF6ZBm9ydZfziM9eUjBqNeapmOOsPyi1
         3QV6NHtb5S03cR3FPbteNjwRra6GXeEalxnmYpb4wPaHAduclCW4fm5ssz0ffzP2ttsP
         8+lw==
X-Gm-Message-State: AOJu0YziJmBibg00CBO2ZIpBCmCO59MT8Jidvs/XROgCAmknV6emnv09
	eR+PtuH8g+ComZNyVd+ag52HVTdO5DuSsvK1tRZBF5Tf+FFo6ZROTstS+4AviX8wWyTniGcnoNC
	C1nMJbWjdfrXbX2dg0dTAdTqF08BXRE5TNdapgK2OaI9+HRWUM9et31o=
X-Google-Smtp-Source: AGHT+IGhCRtWE3+5pMxg3p0l+Q/vFqv2GYMmH9BwdomLO7GQzCBesjgs8MXYElHJwVEaun90skdiGoqk4s7UI2qEsV06FFhTF/QG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170f:b0:398:d1fe:9868 with SMTP id
 e9e14a558f8ab-39f3787cd28mr1462485ab.4.1724905142046; Wed, 28 Aug 2024
 21:19:02 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:19:02 -0700
In-Reply-To: <20240829041320.3047873-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000435ccf0620cac605@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io (2)
From: syzbot <syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/btrfs/inode.c:6961:75: error: no member named 'block_start' in 'struct extent_map'
fs/btrfs/inode.c:6963:89: error: no member named 'block_start' in 'struct extent_map'


Tested on:

commit:         d5d547aa Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=ba3c0273042a898c230e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1230ffa3980000


