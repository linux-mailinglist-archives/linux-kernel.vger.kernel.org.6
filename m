Return-Path: <linux-kernel+bounces-173858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE888C068E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FCCEB20DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BD7132804;
	Wed,  8 May 2024 21:51:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D9084D2D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205067; cv=none; b=qkMctRYACBepeyXPuloAxajZUaLgWAYRa3Qf539qrYX15xVPUDAIAYLFsd5vJli9nJcQ7h+u/1jHLzyLdeKF5GjIRsF/rjREZAwp8ShW3ceSheP3+VKZi2DKcy/xw6CZX7YxQwHvmL/b4TAkBIXsdp1hgVoyuoBvDM9ga1BY5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205067; c=relaxed/simple;
	bh=J4SGTaMSac4AOuk2IFTZM6WXxK1Wx/hfHmfDy9gk8Ts=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UoVGpc4aLN/XgdGGGgw0AStDXTgPGTKwqpYwv6L2pdfcngpwWCFCbJNUsst7q1CcdcZRngVwTfE6P7WXo2o8+dlAsnXzrkJXTH2LFRzzGZ1nKGNOk9ARdzGcBluV3eYgqSMG+9VJlb67bqHBi044mBF1gaKVW8kzLOZu9RgSsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c96503424so2324825ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715205065; x=1715809865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DPru2/nmRXe9zGL0TPp7j7/JT4pqXr4/J1Rpjxd/IU=;
        b=ftkmwDc9aeQJR3Aw2FDZcORIEPRT9xpyQPnwCl1vTxr9Mu55YHW8JZcW0uTPkNyXIN
         9eQoyCrauxquwqViDsl+QU8Nuwfv97DKvT3G0CxmP0VvUEhsH74eQYa1jb5LY4MZzK3d
         c/65cr6MtJQZJn1zgPPdhq75qXMwVCZdpYf47hhbcttaP2PvA93PSVO4yflWiPh7zhem
         ORaUBzepSh79qRxMzVXXGpqjnG4HqxC16RAhyImvnFoQ3MNGNfO+S4wAfqoAQTt4KJJO
         vBXN/kVCva0nCxQqL1iNwRy77DRmK2dmxMFPWwmi4dHswott5zjIOMe9oqe/YJvlT22e
         Bb7A==
X-Gm-Message-State: AOJu0YxkcFWemOzYHjYztwoDWgdPKOP/Ct0T1/b6w7PITeUTq5TjbvIB
	X+aOmYX6Wdw06UMX2yYpC+/V5Ou5xZPDyt/2MVjhJhD/xXpHZl6F+W/hY/cF1xbzYasf37plTgS
	n5xVfgYhuXy3PIyuAQi3V9dCoShx1Igr4RkzO88X8sCqxu9bgq96oXqM=
X-Google-Smtp-Source: AGHT+IEzCVdUZ/ChkdA+Oe0gcxoCZCFKsNGshZg4/63QCEwogiqTGdjT15DMC/FcbLT8+JVYbzK+KmA25GMHPSx69S5tc5O0D+lT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:36c:4657:bd62 with SMTP id
 e9e14a558f8ab-36caed76262mr1947665ab.3.1715205065271; Wed, 08 May 2024
 14:51:05 -0700 (PDT)
Date: Wed, 08 May 2024 14:51:05 -0700
In-Reply-To: <ZjuVaxrV8P7pUpva@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1fcfb0617f84ceb@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/master: failed to run ["git" "fetch" "--force" "675adff2843877c2da27b36b2517f827bc9915ea" "master"]: exit status 128
fatal: couldn't find remote ref master



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13df2fff180000


