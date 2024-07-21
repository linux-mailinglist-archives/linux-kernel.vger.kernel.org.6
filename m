Return-Path: <linux-kernel+bounces-258249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EC493857D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 18:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B002281216
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73841166314;
	Sun, 21 Jul 2024 16:36:42 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03026AFF
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721579802; cv=none; b=qqCb0QjBYhR1c3ytQk5mU2I8gGx2tcQUfiwvBm7w5QKvLxalrE1d6lhEC32e5gb8qcByNhN34XSA7ffwEwfK0x0SFZt+5vYCCa4lRi6ASKZ5QDLaXsvVu53Zb/Vzh/3mjYGtwuurreurQfRXFRmmfJjnTdbI98QHUmzz3WNaEHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721579802; c=relaxed/simple;
	bh=2YwLNxddluGjrA4vtlMadoo1UAoVBHINyeJOH2vP+ng=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bmfuDFFRRjMnLExVsRGqeW/J4tvJu5rHBzR9ghx9fZjcR6iCNsX/7+zu/Kt1004SQ5hz/kOaXR27khGNdOOt1phwxIMEtTLJ7MDUWhtUAgc0aaKCRUUZhl9QomIDfMuS/828EypbccETnBHIyahceyhuZXHSHGj3b9zuOiFIpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39945779edaso14446615ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 09:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721579800; x=1722184600;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YwLNxddluGjrA4vtlMadoo1UAoVBHINyeJOH2vP+ng=;
        b=N8pmOEA6bZFZiMkZWAQGAw2l8U4gbNg3DyhH3UzJRCqYGK3vs5/sWOhQeSAbHFxDoE
         G8VbIW2jOGo3VW0JUavP6rMy6wlYggu5BfSDhYwTxvNqGp8sskMEeY379wpcdTbvOuWv
         vMq5v7a0X0lVvJ0fdrrgrx0zm5i2Mk4ZW/7pPRNQjIKH6pikP2PkW2oRtw/odPM+6ZNn
         zAFq6j16PLGHyhtCVojv0RgI7HMjDF35yCoKWqRvRV4vgqzfcJOJRUFXIhmn93x8Liwm
         tS+PCTAbOajgZeC6YDn5cEM037KnoVciGl+YeQ+ev5rk21Is3DwM1vqq0D+jOwp+3x+M
         0A6g==
X-Gm-Message-State: AOJu0YxtE2uUeLiz7m1N8plJCw0wWuZwMSxKT7s8YWQ05WVqtaEne1aM
	xFIT2SNJN8u5f76O04OPKnDf9lkNYvLsMMmG+hftgLBWJkdjvG5Q/xWJEbO04DnwbEbpeAo9iIA
	sQWc4XpVT5apGGCqtazhS/xaer0/eBVEY51etncejUrZY8YeFLjEeffs=
X-Google-Smtp-Source: AGHT+IGJM5zi+NxwBMA1i6ZWH62Ju39cHWgrM0AEkjLbv6jG94v+3FvhgDSg7bFvlYuohOurUpL8d69dAfVDPAkxgJkXZz5A0uPg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154b:b0:382:6a83:f4fc with SMTP id
 e9e14a558f8ab-398e7bfb7d8mr3221865ab.5.1721579799968; Sun, 21 Jul 2024
 09:36:39 -0700 (PDT)
Date: Sun, 21 Jul 2024 09:36:39 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e1072061dc488b8@google.com>
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

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 605c96997d89c01c11bbddb4db820ede570581c7

