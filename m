Return-Path: <linux-kernel+bounces-411956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122E59D01B9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E59EB21A67
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29618F7D;
	Sun, 17 Nov 2024 00:31:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5971392
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803466; cv=none; b=SRYKzfRezBMUruhDW08O9Fr+VKQVIQH5y7eIdgFTkeAVkhIdr53v53P/qAI84IzS/I6g8TXp+SXxf/xmDJhgH/SFIJCF/m91EOLFcts8L7boTAv+tdR1+N43GUvQ1ZVuBPAmHOT+RiOJi6oOne01OmiIBb8RdCDQ3VUBVwUbmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803466; c=relaxed/simple;
	bh=sI7b5a6iTkhpMHVQJepvoJ0f4eMFIgx7fCmEPoMEbRE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O2+9s0w9d4tgwTQCZOmGPO4N4weCvJVoI/cMu0tx1k59fRwFUraZwJdc2ZVyx7AH22KnCam5p+dO80lx6/AoFojwXNERu7CNbJO6wsVTJBR1QhKn3QdP8UtZfbsiJHLkQFi9HxGtNzagIbwpT5VoOgtBW/83YQhZwjpI1XP0LCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a71bdd158aso33691295ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731803464; x=1732408264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tr2ApS7S+CUgDuMHU/p6U+lFSkiCWC69u1BREs+Vyqw=;
        b=TKb84quhUEF/C5JavcQUPk1ih1YasVa1n447UvcPJEmn+oBAi9njz/j6ncUB5R6lSN
         qfAoJOkrxZQrEbl9kx2uOZsLPoT4FwPrbEV4orSH9r0hZqAsM++VRWJGnVm6NEmmg9H2
         3TCDp9w7vGzcoqnlFmUmQdAu61VpbYQXBcg3+u3UPtQKbmpWl+bmX//kf0lV1jcagaZT
         A0OSIpBxpGw7LU9+5Gk9NLt9v3jda4VR2GSugu0RdAGUjnAuGYjrkmT8swH/+KpjPKpz
         hFbZnU4gXSqBV0VlrkEPWV4w9TmavehCY8Yz6QFKQhdUMZvoNQbO8kpXXAUTcD8F1pKE
         VY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWh38c2bC6OVCRhJ2EEVGT28Ae0ZKiUE16eTWFSnm/PBf0XVNz2C6kOQ5MxApNG7fwPMCQrqJYQL0GYyUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvoD6keBp0a6j/xCsm0adeOGf6FFpib5roVzkpJLWuiayMgek
	HyCeOZyA/LUBJU3VAmyPPPSu6tzxwOUSMerkAZ10G91mfVXNNGTnJMayvqn5gw17d8lte+DLtds
	KGpQYy+cHbAC4AMR296CTm78d1yQ8C2OIrF+TsKcVh1ca/2Xw+qUfnbM=
X-Google-Smtp-Source: AGHT+IG+P6EzasY3ux65yZJ8Urc1Uawvv2MSLGqg4lRdTZ+vhEmeIMJ6UoXesEcBoyx56SEfdGbaA/ug2Tw+8zhdcFU2Fuz23L1x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1529:b0:3a6:abdc:dfbe with SMTP id
 e9e14a558f8ab-3a7480377bdmr62581145ab.14.1731803464086; Sat, 16 Nov 2024
 16:31:04 -0800 (PST)
Date: Sat, 16 Nov 2024 16:31:04 -0800
In-Reply-To: <20241117000154.1285-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67393948.050a0220.e8d8d.016d.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in sk_skb_reason_drop
From: syzbot <syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com
Tested-by: syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com

Tested on:

commit:         38f83a57 Merge branch 'virtio-net-support-af_xdp-zero-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111c52e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6d63a300b6a84a4
dashboard link: https://syzkaller.appspot.com/bug?extid=52fbd90f020788ec7709
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14789378580000

Note: testing is done by a robot and is best-effort only.

