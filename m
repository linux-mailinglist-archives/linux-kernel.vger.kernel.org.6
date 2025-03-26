Return-Path: <linux-kernel+bounces-577092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06605A71843
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C96B3ADD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF7D1F0E5B;
	Wed, 26 Mar 2025 14:17:35 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E51F2382
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998654; cv=none; b=hGwiTo7OxJddXDeMek2lPlZtJIaxaQjBR9upKBzpLiXP/hQvpRwN3/hMOCBA8imVgLgi2j04pSc2hBQuCwkfXVgl6c1Xe7uEDyoWOjGEmVbwg3AIlfetSUIb3zmUDJEwpUQU2i5jgrw339ILqmefoWsuchKGSKunFART3/l9RV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998654; c=relaxed/simple;
	bh=43Lw/8aXLHUMl+LA8kOiJpVGSSPHh5ZxjaGrS5oWVSk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GP6GPt1CISIVQgkAdDx/CeR31DjzhJ2Kc+9EyT7MGqw7X9eTW12y+rCB4aaU28GLfz6IBj2+zxoQpCCVBR6jeSCLOZyUSeCRZ2ScABgQyBJAsvl8srrpCLGk2NEgJAePxM+uAu537vJroNqhj5WRn0+km9YutbPAJ/MNtJvAyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85dad593342so622035739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998642; x=1743603442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43Lw/8aXLHUMl+LA8kOiJpVGSSPHh5ZxjaGrS5oWVSk=;
        b=sC2a2HEKsCSq7pMG8b7udF4YdMZyw+1/8USToVQ20Nam5MCCy44vgozGPWZUJc26Wh
         Rle32xqxpilBJUW4UDhlam9X0yDREkEzorJuE71MiX9PUwWttQgHIT0cTGcmIZTmexGU
         l4jKm7uWm3U8yff+dX8rw1SqU00frguDR66V4oMdlVi5vW2NgPxoAxo7exMe26SE3Pz3
         imWNrN89nqxmPmFHYMqdjRWluJub4WYyrQb7xf/OgGLtqAJvyBqd80mFSXLMTPaC68j3
         eX65+Jo2FqZH/QR0Rn2RQzCF6xG42/4hWnqkcgrffn6V7c6/sIa/7yu9B93fWrkThMgv
         /aow==
X-Gm-Message-State: AOJu0YwH/4vhdvfa6/oEmufIO4YZtJ0D1u1XJ5pFao+fCBJmSUe1L+ln
	BForjikrn19RqxZR9CP7kAgmTmcOPWnugI37yLJQgkklKq5raHdwq9T3xsZHhI4c04XywMZ2Kbg
	nEcIIVw53L7XVtg8cU1KZcsYT/vC/Ho+YBQPL/pkjmdpnOIGRyKAcW+c=
X-Google-Smtp-Source: AGHT+IGMpIuopBI236y6xM8NeLW94YpRn1r21DwrceP5lhxrbQcw0/JtP2Oh8ABH035zoxQBWLAFU3JjFFtl/v1HA/OWuZQJ+dfa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c264:0:b0:3d4:6ff4:261e with SMTP id
 e9e14a558f8ab-3d59603c620mr184011385ab.0.1742998641845; Wed, 26 Mar 2025
 07:17:21 -0700 (PDT)
Date: Wed, 26 Mar 2025 07:17:21 -0700
In-Reply-To: <67cd170b.050a0220.23b02d.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e40c71.050a0220.2f068f.0006.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in
 bch2_extent_crc_append (2)
From: syzbot <syzbot+79e4e34c2a37d5a9c1f7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_extent_crc_append (2)
Author: richard120310@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 38fec10eb60


