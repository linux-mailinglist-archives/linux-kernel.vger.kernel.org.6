Return-Path: <linux-kernel+bounces-420501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC079D7BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B566928230F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 06:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDF217E00B;
	Mon, 25 Nov 2024 06:52:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD11E517
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517542; cv=none; b=qVeKWZXU3vTq8LQE8TqeliP3VW4wM9vkcSyKJ4Tdq5xeocVXpy8e0voAJlEvKfLqr+lFsUxdrX5bd9AZk9pPJgsLHbsAT7hsxcygXe7Zpj7ML1ny/a6xuUt/ssasgtX+YwDwLNjhRcMUMyLvwsS+ga5LNSBkLORTujYwIjNvr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517542; c=relaxed/simple;
	bh=mMgVAqhu1fQHTTYWTeN5JGmbUdn+pOcD29d6wA/c2u0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fUO7XpD1S2tjNKVieWw3ciS0l/vd/7Oghr2t70jGb6jLkjU+EN3r8Fql9WsU8QdeO3ZGBZdln9GaR6bz/pVqzSEyV82X4piKHlMKnpSRG2CM0MIucXhh3198jkOrPaLPK4TkN5oUgCoWy/NEtarCeAvbMIl0NVtcJ0775jvGgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7b30b03ddso9881105ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732517540; x=1733122340;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jp+FH2s/+n03tgMkJKMveqlzEPZJBrD+fjFEljdsW3c=;
        b=aAhEps+Wux+kPc6EhQTuKBkX9hrsJiod4tYLBNasEECRnPvKf7QR2RA9Mbz1GAKznD
         c96z41LxU6KW6Fg9faM2/KOC9lKnIXhRxac+mQqUNNnBsvqkaKY/G3ngZvS6u1M/DkZ5
         ZusvfkMsSmBfkm5ZZSDknXuJDF4uA18Gsukt5z2WQhovDvPKhT6u7CUl/ym86VK1ipID
         gEm48in+BlUf1UQE2Shlm5UIWAb7fu4FhWRj3zxDbZDZhK8AKkpbtQnvge8Su8qCTfDE
         m45fFaDGvNKtE1jR/JTteZsQ/7a5gWwdbvjb7QrTbeBQAA3jWtKXNOnDTEbDyHu5qPyk
         6koA==
X-Gm-Message-State: AOJu0Yx3uRhIr9uFsrLNoULm2nJkczSE/FrzU88FFL1pzTja7tCqvBEs
	9XPZFxeAWIWv/MybKSEYMrYwbxHOaUvvkn6QZct9GjJ2OBdtKIgu3R9InAOETo/7zuOA7Ou76EW
	eAZw46axYepQB0cHBYZO88e8cQkACQs6AfqoRjUsY9cG3jXzfDQEamp4=
X-Google-Smtp-Source: AGHT+IHGGOkLZLdfm/6Y/vunYYCa1SGJ863cNbZ+HvXHGtLaHEaZO9vC9mYBSWoMhf6Nqv9JflA5S+Tkri50rWsdtzF3Q2RcIhPt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:3a6:c98d:86bc with SMTP id
 e9e14a558f8ab-3a79ad100fcmr138619675ab.1.1732517540346; Sun, 24 Nov 2024
 22:52:20 -0800 (PST)
Date: Sun, 24 Nov 2024 22:52:20 -0800
In-Reply-To: <66fe516e.050a0220.28a3b.020a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67441ea4.050a0220.1cc393.0064.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+dedbd67513939979f84f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix dup/misordered check in btree node read

