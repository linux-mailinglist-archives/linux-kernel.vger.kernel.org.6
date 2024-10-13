Return-Path: <linux-kernel+bounces-362765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9B999B91F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483D71C20AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ABA13CA8A;
	Sun, 13 Oct 2024 10:54:16 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB48136330
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728816855; cv=none; b=DkuqeQlwWGjrsbtVCNleJZYVCdM5TaTn1WghclixWRZTI0TBUTE306jf7aoaqg7IHCSCosxEDwB5ubzEzaP+qjfGAuLdH71iqaiSkvFCKam0YgFwytcbYJJKAiwrsbMACd4OPxoGgXzk/7jGU/QKOOB/0LmaBppm9uU38xhphGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728816855; c=relaxed/simple;
	bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rs99KuwZizzTaVzz1yW9M6dEcCsy8ub/gqtF2Ocz+SNlpXUCFp+s8MDlz7c9D+yuwHI9b+acw1YfqDsyJgkoR5P/GGcFEZoyiZTKXuB+dfu11QU7v28rp/LbWZufp2ngvlxGQA7LGxOQVYoJVHGNP2L+6uSvHbmVm2vufr3R8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83540797827so236880539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 03:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728816853; x=1729421653;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
        b=n8IBEu1xRbjGmcvWMz1polR9kIn50iN67mY7stDn/BL2NzosJ6OKDX9ezo0qhFzk6E
         bkxw6kUwHu0vouPnl7fRr1UqIHhtLMtzVlH4oU/MK6wmiR9B1DviuF4wSZKhG5YtPJNn
         xmI09f5QmGvNNA9J2SFGpBnWhHuKgSzxBHLDwldnJwd+Cb5cVk79DaPshJ7lUUnRfLc6
         ifur9QjcnPZFSIcNACfG4KWd7Zpv7Nczrg1GwHl89ZraF/4VwIYYlOJVXAenbtXhKlqd
         ETYCLtxxiu6xnlX8dSX1/oK1fciv3x1h6HItW9vqEajS6HRIsXgR9hMT2D2AvbDp/Zze
         pbDA==
X-Gm-Message-State: AOJu0YxO2Rc9fNwPGqIPw2hNUEMY/xtIXae3QNz7ofh0CnMZS8oyHXcG
	BIjFFJPUXqlFg42SpTwiHhY3PqNNJB2NPbZ5RaW/8mCY4S6dzXHyb1SeeHsBQ9TR6DT1EKczHSU
	n9eqtbWD4ykiMJJ/SAcPP4mZaIAxa1atthFhtpQC0syR902rdvqScHx0=
X-Google-Smtp-Source: AGHT+IGRt+NSTfUjQgHpEqIhmAyd8pgLdZibcd4TXYa/G1Uu60yLZTue1y4UOZ7Kdn7Stk4yiyn7dK2NMsM7feTu9jSrT6Al8M79
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1786:b0:3a2:6cd7:3250 with SMTP id
 e9e14a558f8ab-3a3b5f54d02mr50869005ab.10.1728816853364; Sun, 13 Oct 2024
 03:54:13 -0700 (PDT)
Date: Sun, 13 Oct 2024 03:54:13 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670ba6d5.050a0220.3e960.0039.GAE@google.com>
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

