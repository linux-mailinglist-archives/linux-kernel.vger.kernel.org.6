Return-Path: <linux-kernel+bounces-362854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E060F99BA28
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805F81F2194B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63354147C86;
	Sun, 13 Oct 2024 15:45:11 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B612C478
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728834311; cv=none; b=Kdu96DICPlmZGsw5KH6ERNWAFWvesAoLgLYergEpUADin6bHwt3mtyGSWRsw2f1N/24/hpCtCbtO+spU5tpIOj1zyBn202Yq4k3gNmf3D0JCHyYbKPoROPrt9FAM0PKpXAKWOzGc1G/FvxiNR4KrmkLPYmwdommFY81J5CHUbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728834311; c=relaxed/simple;
	bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FXfoXkp/lIxgQ1KuejmwDfTaHpVlicr0dPuKAF+PWfdE+OMCDxANGUJBgKvuZrzNTjcTxEc8NoY7TH6RdaYFrsyQESP189UTLgeG99Tll2lWOs378CmdN3ZvWrfGajhl3Mta8P0vWA1ICa7ls/Ms4KyjhfLk/APiba/f9lBHn4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3cc9fa12dso1397125ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 08:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728834309; x=1729439109;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
        b=II6YofEjHL/457Z/3/BqNHIQtziYxtr26yhQFQvQgn82w6LGHrG9FF0JcPijngs9gh
         H0lR7JTpB6kEYxxiy4eI1dijWcc1AeNByGXyhHNgxv1NPx1ZEmFlcvRCoetMVZuq3gPt
         L3Ku/mreGqyjs2vaPjw842+g2z5E0Pb89sIaSe5yGgcAHTkg6Iy1x+8iBGpnESTRi7vK
         HJn92dRDAIf0bDg2CRkPJhRCRR8KwCAOFeGbLmSDlPSgr/HZHE1ADPm92u4Xkd9nWJja
         x2KCzxq8wOofI3U6F1Loy05fVHDmFzCCCPAvSM33LSzKgyD6AjDBns1ZGPlw67Wu3ab+
         fBAA==
X-Gm-Message-State: AOJu0YzCcnkm0pMumwh6hVVlOyXpiaDiaeyjTdsebwh/5YH8Rh0HqhG3
	1eS3N1dTTKCx2zT0BQbWuBuFkSDnOK/DWyxN/TIHqInavhWte3MnM4q0t4ok+rpu0OTejalmyG4
	d43Npkx2buKfjGKjnG+fySZK3vxQAeUNJeFPOoKKsF54EJ49tflIxrJM=
X-Google-Smtp-Source: AGHT+IEuO6FFvmePUkfk+8fNSjOh8rVYm147viwI/P0YKlzFKJsCt168bbc0c5Ve768k+etlkdT5dWR7MSvP/Wqwo3zXVDqSvW32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cb:b0:3a3:3e17:994e with SMTP id
 e9e14a558f8ab-3a3bcdc0bdamr46043485ab.9.1728834308681; Sun, 13 Oct 2024
 08:45:08 -0700 (PDT)
Date: Sun, 13 Oct 2024 08:45:08 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670beb04.050a0220.4cbc0.0032.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Author: cmeiohas@nvidia.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

