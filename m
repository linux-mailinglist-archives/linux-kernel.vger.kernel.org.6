Return-Path: <linux-kernel+bounces-181689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B68C7FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E404A2842D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3F31C3D;
	Fri, 17 May 2024 02:03:43 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA510FF
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715911423; cv=none; b=VuZjXoB7SL3+r4PkVV5mpp+wjrzMSpiTdIs6L1lfn/eFPGeHDGxceX99SXpJMih7eVoAHcKgL0YNuigjmXE+T5lxpk0ZcR+An+6S8vxO1up0eO3AAzeRu1y3biX3VS8E+fuBaKRTG+3sfrp3Yxl2kJTRcpVwM36FO+KbcIkjNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715911423; c=relaxed/simple;
	bh=AZZ5qPdSKTP/TZ16p15RVM3zBSNxkmPUJBT4uv59BPY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p8HANOSfDA4DlVnd23yrQd85Mr2VOBprhD2B1oUHxrUU2dmbKCAxofg82KxNKcnsfDnl7OlW7SGZS0lQmf90ITWwPqVsIdx2XPW9TAWfxTDi47IsfAkMz3wWzl0xwMlAblUQn24Pty0njZi9IAKOQKB6AIxAdp0p8tMw2BZYxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ddf0219685so1049206939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715911421; x=1716516221;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/VfZMYFvZvNIhJYYCNgTSLbryKxeuK6RRHMX09CEjU=;
        b=lhPh3iy0mVMmGGM3J6h3LKaH1SnyC//dcgHKqvMSKduop26CjXh4g57sOpcCyQ5195
         GZnr2/cNWj7EfGxrNluwn2qdPfma3RqFLFdowFNNNXELOda9x6XOqqxpgeIqP52qZ+t0
         kORNH0FAh88hGlEtu/9qpd8i2ae5oqgdb32+BBVZWPJDFgfflu6D0CmovRlZdE+3qa4j
         fruW3j7Z2PS48HyJ2bJx/uh0P/n11p7BscuCSIALr8Zf68iew/pHBCbEGXGH8gpPP1Mc
         B3nsRxUmZLBxXzMYcfphy/mqe9krxcaX7pyM/tiwp3bcb5h+qKHFSURi48rGPRXVxfyM
         OTEg==
X-Gm-Message-State: AOJu0YyB9yY6qb0A0yFzs2QNn9uyX3G03Pp63Tr1C5VtUO5q806PAfUG
	aRdKvNdInAX8m9PGFSZCeXL+fLotGFIFHKBoTBqrQXk+Kx8N6qNSuRCA9N0cuoulG4fAUC/9XDh
	tBc6VxMez7MLe3bv6KmbF0gWaJz81EAROFvubj137ADDyvB+mKfEMmeI=
X-Google-Smtp-Source: AGHT+IH5lTTxGllN9jARITxHeidCPaSYOR0qXhKp/SazwsvoboHjLllBD2+JQU+tLeOY67ye7cHXyC+nCGd7FVQy2sdbhv0kt57P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26c3:b0:7de:e10d:34e9 with SMTP id
 ca18e2360f4ac-7e1b522988amr128228639f.4.1715911421287; Thu, 16 May 2024
 19:03:41 -0700 (PDT)
Date: Thu, 16 May 2024 19:03:41 -0700
In-Reply-To: <00000000000001ab730616f23768@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb6a3706189cc28c@google.com>
Subject: Re: [syzbot] [syzbot] [jfs?] KASAN: slab-out-of-bounds Write in diWrite
From: syzbot <syzbot+aa6df9d3b383bf5f047f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [jfs?] KASAN: slab-out-of-bounds Write in diWrite
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ed30a4a51bb1

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 2ec35889ad24..d9b302938ed2 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -747,6 +747,8 @@ int diWrite(tid_t tid, struct inode *ip)
 		xp = (dtpage_t *) & dp->di_dtroot;
 		lv = ilinelock->lv;
 		for (n = 0; n < ilinelock->index; n++, lv++) {
+			printk("lv: %p offset:%d %s\n", lv, lv->offset, __func__);
+			if (lv->offset < DTPAGEMAXSLOT)
 			memcpy(&xp->slot[lv->offset], &p->slot[lv->offset],
 			       lv->length << L2DTSLOTSIZE);
 		}

