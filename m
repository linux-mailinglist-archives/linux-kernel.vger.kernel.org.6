Return-Path: <linux-kernel+bounces-348475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4083298E81D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECB6B25913
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B211CA0;
	Thu,  3 Oct 2024 01:20:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2350BDF49
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727918404; cv=none; b=oEVQ+B9YkN5iANNp9SppsrMuOODBnN9xTkEl2jFhfPQgMDZtxUoUdVtE/0OqCofo/NVwuHLmtSdKwPux6zIgIR8ujquQI1DOkFFC9iryaKmBWVNPForrCTx24auoLjv6/I0vJXQuG4omX8Sd70ptVgAETaWSkNJXEZZCU4pyON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727918404; c=relaxed/simple;
	bh=VgxLcjVqLId1nwjERIUwdNgWnVC3KfWn1HLPFd36T9c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a/tizs3tNHw9zqriBBjisTg4ZTUo4OGZb0pu5UiUiCBxZNsdEkWmonGJ8PIMJGFxd1BtmM8VrcT28guOerjiCGci72Aj9ZCqbHi6LrzUrMBc9xSZT02N1874zFWDOZlZQEdp4LnVFA925VeWhNfPh4B6dRf4ks/bLVh7S14OBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3479460f4so3808055ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 18:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727918402; x=1728523202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLg4WjkU//b62h2ZX0FxgDSBVmbNEA2iXphVFPi2ilE=;
        b=D2l8v1pdOk8r1uhqvt/gNppzRBG/wozmZQlZVoGiXGBIJZJBlPBTXIpChelQAm+r1c
         fRLNnLSoINz16NH4wx9qnf+XznLARTsL45YinPQkNmuHIxAdp75byu3iRlN1pjcHa4Cw
         6GyBd0yQzy5ea9B64/yCXDhtNPWggcW/IDqqMES4Me91VCdpUSbxpGCwKW3VJ5yxyCE/
         NNWdccDe/TzhCgsvPPYMactfednEg3F6iFP9EeeAKyxH3D03zjqDTKZtrVgflmc2M5VL
         QZQ3r6nQKZedo8ei4GkQfxGmB30AwQOFAB+ul10aTgXAYAstdnybcVhlGve0h2YfR+FG
         9v5A==
X-Forwarded-Encrypted: i=1; AJvYcCW9TWwRoTB/JuQTCXuIdkT2TqixzDZCtOsVvHfDC99VmWq9nTjDiZ9wpz57ru68nqFWYuu2xo0e54aY/kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8N30v94LXHGND+VyG0eIElnNwyvu9wHTjB1KHOehuzxb6GoU
	R/NoqCl1kU1pNtXDIYNWaMI1DfCfCsY1n3t87iuwnD6mKFkwG0E2CC03bwjkwLoOyaNU1flz9r9
	9HmzvpfozefXsTxsghseeqqd2AwmwcmgTJM8u1wJFOLudwkmpvgzALuE=
X-Google-Smtp-Source: AGHT+IGqViwkcEVS8PdMA4PRbv9APJblCXNII4LxpvRx87WBi+qRDLtteGj05rHamd4t24+sAqM1WTmuFRSebAFN+SqR2vjKyYK2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164d:b0:39f:51b8:5e05 with SMTP id
 e9e14a558f8ab-3a3659441d3mr47181185ab.16.1727918402242; Wed, 02 Oct 2024
 18:20:02 -0700 (PDT)
Date: Wed, 02 Oct 2024 18:20:02 -0700
In-Reply-To: <20241003005956.1869-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fdf142.050a0220.9ec68.0030.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in binder_release_work
From: syzbot <syzbot+9ba7a8cdae0440edd57b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9ba7a8cdae0440edd57b@syzkaller.appspotmail.com
Tested-by: syzbot+9ba7a8cdae0440edd57b@syzkaller.appspotmail.com

Tested on:

commit:         7ec46210 Merge tag 'pull-work.unaligned' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f22307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6248f0ab12f33349
dashboard link: https://syzkaller.appspot.com/bug?extid=9ba7a8cdae0440edd57b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1005339f980000

Note: testing is done by a robot and is best-effort only.

