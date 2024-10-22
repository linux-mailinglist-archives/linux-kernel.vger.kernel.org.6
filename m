Return-Path: <linux-kernel+bounces-377077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1700B9AB990
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A141C2275E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D11CDA24;
	Tue, 22 Oct 2024 22:40:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372371CCEFA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636805; cv=none; b=O8HV80nNw/wRJpqUB1AOlV4w+eBBn+CCZtD1ZJBvTSF4JMtaxu9f5JDrsBZjriGZe50pNeMBaBIL58TvoG7miApaEBrOi/amQc5O+Au9TtV+JavC4T0r3GcOTrskN+lmwFpjDU/ulOBf2+xyJdbAa+I4slSZN0JYmDegeP6ZciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636805; c=relaxed/simple;
	bh=phBVLes0EV2/53JJr2Gi4gx7fPeuqgGJan2+8ojPUGY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qeU21hR0tTsBKsINgHpqnW6IJFVPp/x9uxhi2c7Ef0vp4bjKfSLwMJziqWMHUqn/eBZugIMlcLit9FGS6pjrfutZwtWepMRq1O01KJH/1PZnYbklhonZikb1eESlg6/IlXilkzKUkKHPuVF6ZiIOE6XOvGM89Wf+zjVq5RtGErk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c24f3111so61448705ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729636803; x=1730241603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0L43JcTxYg6YBJypmDWpXDnBf2fpMX9zvoBTA9Jr5TY=;
        b=aKAFmOzjxwt40W71awNcP1Bo3i0PkHmopdWosMuU8dmeKnvH/BqzwzK8t5m/ug6nj2
         1X/OkWr9zfwExZaA8fbAEN8Q/vsWI3CgrYHWblfa3zcNJS8uMWgkS1dcbAD2CKNZ08UV
         1GdvVs3VBR+h6Jfg8MnIi9pIJ4PPoObmLOn1Ws8dWkVOKHKFgAqmVM3terkYIS+I7fZA
         zT45mULxf8NzXL4H/os/tlNbwnYc7ABi5+aaEqVo5iZmhXql5vATcy27hSpRLdGYooi1
         9LYhrK3TJI2OZdpvOtAj1XuGuqeNFunkhg7twnEe0iZXBiJxGsIz4E6kxS5s85piDCh5
         eyCg==
X-Forwarded-Encrypted: i=1; AJvYcCVK46+QVctsKzvq/W64s9TS2iLCIHKpav0xDSsMZkhv0YD4iWBeZR5HNV3MO1bdwpgQHKRXtVN34G63Jjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKvgC+4BleC/bTMomts29UNkOA9bi2ZV5FzRMuP4RjjfjP7Oa
	1NHrpZo4ycokCZt6o1SXbtLyNAN1VFWpCvmUZJVgrm3mEwyvoKM/i19WrcbCJE2JBsQkH46E477
	YekzUbwKPjOoqKg2dRaSx/crevP5TzimmzJuwCrUDn1tePcbgn3na4BQ=
X-Google-Smtp-Source: AGHT+IFBX2zym8MCNwv6AGAgsdEsKJDBDGVbPUI4+l0N/sAM/LuxywrokX66LEJRVKtBGFbGOcmYsRsQ2MsN1Ut0GTCMeR2Qpzir
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:3a0:451b:ade3 with SMTP id
 e9e14a558f8ab-3a4d595d6e1mr6997365ab.10.1729636803300; Tue, 22 Oct 2024
 15:40:03 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:40:03 -0700
In-Reply-To: <49b1ba71-1c1e-43e9-a012-42c17f0aad85@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671829c3.050a0220.10f4f4.0182.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_free_fork
From: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com
Tested-by: syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f4a640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa3d7fc2fd6ea40d
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6fb1f89ce5e13cd02d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10eb8287980000

Note: testing is done by a robot and is best-effort only.

