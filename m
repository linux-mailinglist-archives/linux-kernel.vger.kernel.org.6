Return-Path: <linux-kernel+bounces-258252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86B6938581
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D0A1C208F1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCD1167D95;
	Sun, 21 Jul 2024 16:38:33 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C62629F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721579912; cv=none; b=d1m9tGleO8VCmAJgPfzpB2nPutFew66rTdj9XJko/vqzb2edkB1ayJf58SQeZSwGSNvYxrl5kNrrSbiZ4hvSQmYQmwtYBsnxN5iZH/7pB6FVGkHGWWJEJQ/KRCZqJsj21qHg4AJH24QlU5r2A2pLqAlwju1LH3xOO3w1djrR/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721579912; c=relaxed/simple;
	bh=QD+UaMIAPuTKDuIfIxuY+0Olav+TSbmFl1QOk4r27MQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bK6NGqIpiT/UvcNNIUPkk0vvZbAZARREif/+j2r1B5ZxPItx07/YmMhaKOc0WJGJZoz5gKdbCiyzsBEZ7vEKfjmen+eddYARP/Trb3RKm7dRVZXDWgBJJDGDMhDc/2Me79O9mF7bOTvl5CMcg7XoiTlanwbshfSxt5qoiuvqokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81ad0e64ff4so304750039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 09:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721579910; x=1722184710;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QD+UaMIAPuTKDuIfIxuY+0Olav+TSbmFl1QOk4r27MQ=;
        b=bUPSKPhdyJobmffEPhtVS3YmnTClFg4WME8EUpiLW3V8X/iBf+BqIKNFYgV56JJfUx
         l2BI9BMlr6f37BxwGz/Pav7iyG7MB6UnUzC5o6h+u0vmEaqqRsrDXVedR7jJbASqEzBO
         65cEuQ3l44FN7ZeHDFmEPw3jOeXRwXyXeOpCssZlDsJ1QfB1Bz3mY+lV/fIhgwB1tG9w
         nZrsSZR6gVHrjftSNWvDNS6bHT5F0thlj7NJzrt7JYxKpOY5fNDOyX20uVc3jgveAgM6
         Pb1K+OA/aWH8ne+OucoxJG9d0SX6VNQEMbXNwlNncJ93Kms2HAF06nuarHQwkAwHn9Re
         CzdQ==
X-Gm-Message-State: AOJu0Yz6g0hN9x6+sAXm6tdc/001vYi6JTjhVObKlUFnK2krxOk+OdU2
	aBJPZOPrlcesx1fMkR/dph9slBgh55copsuNr+u3Qsc5r0Su1bj7Ij3Y0rrR0ztMzJ7zL/Rtx/l
	miJOlBTVg2dCPSfgYXkGAdl9XWilhBDscZCsnda6HaxuAn106I3MfDTQ=
X-Google-Smtp-Source: AGHT+IEfZTUEH8on5afYHR34Rfte10keUCFqBA1HyEpAlEF2k+DswhYjcE3YsKzx5odgUwbsd0rDOw1O4PA6q4rLd6XcuAXNJfX7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:375:dad7:a664 with SMTP id
 e9e14a558f8ab-398e83b1fa6mr5508575ab.6.1721579910007; Sun, 21 Jul 2024
 09:38:30 -0700 (PDT)
Date: Sun, 21 Jul 2024 09:38:29 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd2a83061dc48e02@google.com>
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

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a6fcd19d7eac1335eb76bc16b6a66b7f574d1d69

