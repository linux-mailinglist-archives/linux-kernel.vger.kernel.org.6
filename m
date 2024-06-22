Return-Path: <linux-kernel+bounces-225608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3D29132D7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F6A1F22C3D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697CE14C583;
	Sat, 22 Jun 2024 09:10:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D71422B6
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719047405; cv=none; b=k4z7ILOMLPxcCv/MOkm8EO4PV3b3ZmcGkzjj0Y9eqQYWfQ4hq1Uf2AH033l3Q0aKQRUk0H14AmdtySoX3Hqf3LtQNfNgP6TLYzkoSTJ4Vz/dPcZfOoiM9JuyuyGx7yfxl/ZEYcOTFzzZRY+H4czlpsZ8rS+QsdhK/+j+6WHdyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719047405; c=relaxed/simple;
	bh=Wh3zmu5z2djoOGBNUwRpnLoZmQn+ag6XmedmK9KIfpI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XEhfUiqPTJ6MEKfMY8Vz0pOMb27R/9diU6qND4MDnAfXRANxThd+Dwd+QVI7PLYSBbZsRNAJEvEfsUrhLpJWCVUyAl+2bW9ousmEnMfkFv2X1acWmhw9wtqW3mT2RdiBL60hNp4Lzl5oMyjzp32ynRXQoa+BlkTFWy5BZTvuN90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-375da994725so31428355ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 02:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719047403; x=1719652203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5G90YyfFpGjQDgbkrENOgmrpaj9OnL8ok6Nvs/hKDI=;
        b=kTorHCPIKmG0LotMkYEMH1qWWPsMGyhjeRFrYLk8EtBodn9k4XaKZs8+OQUiyaEeXh
         0T8qeOMrhketHUvZnmV0gRCVDImQrIXym9VkL86+uNYf0MKsUwkW87CZu2FkFqZM3xNc
         u6wUXnqMEHCuyrOhEjKeQ1ySXutp80NhJESLdjFGf3nvjn5UBgS23QNFnYyMkJPZOJK+
         wTR6D4FYq5bfLJaCUSecFeeuZOexst91MVJ8gPM7+nCPQq+lVi4YDrYMGON+/xFJHUDE
         iPrxBgx3VFA9o/2qAFKfOZ32VohK+i8zkVW3ojmLq4Gajt2jok/mPkoSjIzqP0auO1sy
         9z/g==
X-Forwarded-Encrypted: i=1; AJvYcCW2o5zL+8qCG4NXj2yygTWBiytzpMet7KYf2rNyok03Ss4WbPeRMiEDDzt0WO8TwjSTzSUeYpqeLkhUA4qa+XEEXLT5BNhShj1OTl0V
X-Gm-Message-State: AOJu0Yzba97dbch0deVL6WmBai/XyPJipsjVS9qkCzKYoSdWo26h/OgG
	m/1FHWpsHODbhs8VT4PfLScmUtUK/n4SGcqWPh1JnaAjr2YT8FItCYbLI7fkcZ5A2u5lCXgYwbB
	BvU8s1Meoi1kmRRZxlGsMXwBY0/XU5YRTZ9Pj32g9eI4tAxEiGfCb47w=
X-Google-Smtp-Source: AGHT+IFGYSi+fHSaiTEYZoWx7vxskYG+0R1CskD6z1hwNT5X625ZmRdKelkUrLE2N/ueJBf6kJuj5NdM0UW1/loAI746qGwUFtJK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0c:b0:374:a2db:d6b0 with SMTP id
 e9e14a558f8ab-3761d6b8850mr6564685ab.2.1719047402755; Sat, 22 Jun 2024
 02:10:02 -0700 (PDT)
Date: Sat, 22 Jun 2024 02:10:02 -0700
In-Reply-To: <20240622082433.1865-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb2a2f061b76e9da@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com

Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=160a0aea980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1190d4d6980000

Note: testing is done by a robot and is best-effort only.

