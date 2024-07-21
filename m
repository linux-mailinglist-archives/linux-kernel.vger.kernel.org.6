Return-Path: <linux-kernel+bounces-258248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D793857C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95351C20A1F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D28816630F;
	Sun, 21 Jul 2024 16:35:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D226AFF
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721579731; cv=none; b=flc16etPh2TvOGdGDFcQ3MSmClXB8fZWiBR8y1g264x/WXgrF+4cMQe07Q6hkQkskla+gG307s3K64Rixs8rH9lT/wCQ1HG/MjdmWINboyDz+SFIn4rrwfWQ998cAoKYZcCDZwSiNE3QE9Zb0tiYTthanJSdgbW9gfmjj8Htngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721579731; c=relaxed/simple;
	bh=dNU/yQsoqjHQ4Dbzrnuh+vE3oQPfN8hTPrBej9KHCqM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fxlpuQ/iuxtbwk+A6U/fS6xynA8beyeuO6AWFrvf4ajpe/WYVEpxaZ0F2AX4dxQRSWVCUdSyGyxIIRaOYMG9arGezRLZwljE8jShwdTmGZhlkeBmEBpiAjaFZ4/ZT243x3wDRORUlnOV+ynOeiZtgQ/Nic1+WFK+Z3EtdxGIfUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81ad0e64ff4so304315339f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 09:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721579729; x=1722184529;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNU/yQsoqjHQ4Dbzrnuh+vE3oQPfN8hTPrBej9KHCqM=;
        b=EYWYctnutq6HoPVFKN9HjlS9fUtwv7tdUhxQsn8680cDG61mU+ZqgGiVXj9JS4TWKO
         WjxGZlwd5I3JGK8CXODvgh04hhl+vKDADAPgDDe4bJCZf3Er1b3o6qmRpe+ZbEzamMah
         RrcjS4sAqJjEThrTkrS7KdN7x6OJ6pAzpqvZmtDD/pD3jruc6BHNnjHiYfhxRaOeSG8H
         XZRARrNuqF46gTdg0b6tDb7Vdynk1LOxn06fwWm9yv8BtlqrEyh4NKDgTrGd3n0/eMJL
         6CswpcrDVT0lh+dScLQuU7+cFq6owgp4L+ZAS+pCTbw7q00X0ZFiaa540Ezax9NXGgh7
         3rAA==
X-Gm-Message-State: AOJu0Ywp+oJJh0g2D5mW2mKul6Vk9qbmJXWsk+Pnz2YRtj0HaFczJrZX
	tktRinHPrmftBqNlMIVe1KREWQAR7SeUV/YVA9Sid42l0metrKz/qBfHZzBR6iaH/Fw4dMIsy/W
	GD8IAI9nZNF50G5MTAq3+DobVAYwQAbR+whl+6Gh8pIZyPUJtHJXX9LI=
X-Google-Smtp-Source: AGHT+IGFwRAKmCZFBQzqB20LCs+xx3uskAI4Q1DShU5YJMuS3bPkqGUYwmsI3fPhv8AFkH9tYftfUNJ8zwsyCSBrA5OZ9s36xTae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138c:b0:397:5d37:61fa with SMTP id
 e9e14a558f8ab-398e4bcd071mr4813605ab.2.1721579729186; Sun, 21 Jul 2024
 09:35:29 -0700 (PDT)
Date: Sun, 21 Jul 2024 09:35:29 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036009a061dc484c3@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free
 Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fd8db07705c55a995c42b1e71afc42faad675b0b

