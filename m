Return-Path: <linux-kernel+bounces-192675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB1A8D2089
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCAED1C2352E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934B171643;
	Tue, 28 May 2024 15:36:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923C1DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910566; cv=none; b=t5WadtjcPSAn7Ash4rCIbNCyJCqmH/rY9KLCuvnO1ZYCGYvHHKv+EWxVf02Qy7jxiF0As/kW36CN0i/peMu1jZMKrwIZWyrzPX5f/DTBWXHkaj097dfsauDSxMFHl1oDKhRtCzWdxE3wqY8qLvOd4L3GFsHVm/ke6PDC37mB4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910566; c=relaxed/simple;
	bh=8rnuhAuoOY4+BX2AUDdTnyJdZyLTSdhV44tJJs1mM/w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OUX3pCCXXH186Frh1HtHC9C829PaNHo9IKJiGD6lDShyX43oFE6M/5aLTiZZw60O/5r16lRcI1oea8dI+AVj2qbRg+YAmzJgMBp0aSzDJDdT0OOfaEprYgQ2kNWHieYexysf/hIRZm7AmNhe5t9WgDDl144EkZCZlbS83QUcn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-373809cc942so11412805ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716910564; x=1717515364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQHTyKrHplm0juBKxb5WUEglNyabr48Hpql64BnOGhE=;
        b=XCzqIPbjyPLCvNkdkplrg0Itcl2Gx/i/KtifpHSilyHViucLlGNsGNjmgWN66aUfo9
         AZ1RDlsgE9caAtNxbb+E/wcps0MdD6K/GdUUibv7iNPyB7jGDViEgyxzlW9iywxzxqxN
         VbOVpf8AOUyEEZoE6MtPNV6qkQP90xReb59cSFoWqScv3OKah/ny4KnrWiQ5d3FiHM0v
         3IWL5utTA38R8XdBCVdvHgrY77WHHEGOpuz1fQ+lrHP+iD/iL+A/GUTKQ8J+HqPCYcSj
         y8neAvgBcj9B0qXnY3AQON/8d2YI7cGUdJ6IlKgjC2CH9galM+3Dx40TF8wh3dYI3B5h
         SRVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTeF/z5vspdXWwSMuWb4jVVpe97EgthGRcPeeK6tYFUI2cMpIbyp0+GJNI8E6R3SHDVQA9FjGGBpEUwoE1bRcXGZnqCHLP9Wk7zKeL
X-Gm-Message-State: AOJu0Yw4DvmrE/ODlNYMql7GVTCtQlBevW2cZXOqU4AqIn4kfJI02tA3
	79/jFJOBtslx6MOcpnZ6QntXns+zgdbFDZU6JgIHmt6mujxH8ojaKYB+L+LbDtqEoe9S9QpFq9Z
	8KXh8mg0tLwvGGzVhNp05DSdzPtt91vsoTRdkSuKw+/xYqydkEq+kYm8=
X-Google-Smtp-Source: AGHT+IGjSjQ2TzVZnr0zsTuk4c+Am6/3KFUFuPq2Q/w3Cy2bX4yQZmLuDmLpTnGzLwEYqbldtBfvmIHX0TtyA5SCm+3QXwrz+ryb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:371:30f1:96be with SMTP id
 e9e14a558f8ab-3737b1cd625mr7322685ab.0.1716910564041; Tue, 28 May 2024
 08:36:04 -0700 (PDT)
Date: Tue, 28 May 2024 08:36:04 -0700
In-Reply-To: <ZlXJOfSLb-2iuJeI@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047f9230619856425@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
From: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org, 
	osalvador@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/hugetlb.c:5772:51: error: expected ';' at end of declaration
mm/hugetlb.c:5782:4: error: expected expression


Tested on:

commit:         a2868b0f mm/hugetlb: Do not call vma_add_reservation u..
git tree:       https://github.com/leberus/linux.git hugetlb-vma_resv-enomem
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

