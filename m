Return-Path: <linux-kernel+bounces-375367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6AE9A950F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E31C21E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137161DA32;
	Tue, 22 Oct 2024 00:44:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D59322A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729557845; cv=none; b=TcfwZ3fhTe+t6uToylgq9RkAIYLRwrvw2e3kSeMdPomDlnEm9emK/Ih7K4xrtmHt0dNyED2/yv3Et/UdWY+JIqzTt3Uh29umXEiJLujLbWGsUVxUP/92aIvhQOVHcF5aHTh/yycZ94Ljqe4GBOh02XHCqbgAVx7GQ1ihfuv/BAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729557845; c=relaxed/simple;
	bh=PSIXcXrrc0YrhAglfgt3/FPJqu5CYSHYFjyNT8+vngw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J80jmYbD3/Wp9JUIKEg7ITS7L3qfw/JQ60CHkTMCB4DJiel3NOfv3OCSbTj1QPBepgA/JgvZakx1t67LNZ8UOGPNSM06DEzJWzoHmKgcBZapLfL/fAeYqe6uccv+yLepEvh47WyT9R11jeHCS/5gb43Kc3T2e2BxnGICbT3UMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so29165445ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729557843; x=1730162643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyAktbuIEJEi5CtyKb3ZsZOSeiKyyn7qmkW9Dgeztj8=;
        b=QAV5wOg8T72hRcn/0ZQRggyyNh9QKolhGiWrhewG6KjwHumkKt2dS/Z/d4ZSda1N3N
         RCtfLpZZYTrReyXSbWz1Qo1CSHSQf0KPxZ4tJtzI1PdouqVUia6vx5TLMssS4DfgsNwR
         U06xDIEMokyDEahmP/+aoI1ZfJUUma3JwV10WqgV0EQ9hv2RMCTzvhAdwVmxKgoZeAj6
         f+OOvXJXxlnQ3AlQIpccqTNA1kTY19yoZXuDEd43aaIsj2KBtDiiQFTLL7Wab21lbmex
         /nZTgmSHcwA3CJATL/7Vq5+9ggHyA30ohAic0eiKYF9GwY2gE2GbszvqR4+Rd3dH7HGl
         sPKA==
X-Forwarded-Encrypted: i=1; AJvYcCVrZ5ffxHP7Qvl9tnw9tNGHffRPyvLX1qgn8SC/uugY5EnMD4vSAGQ8l2R7kpIlaQqvtDGOO2i+caB8PfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2wt8PGprtVM/FFgRF4VmO+briZWJCvAKQ7uyMj4bg/KVxq7n
	GrtFljIGEKKlBmy/y6MqXAki4IkiY/xxyY+ayvkg8NKf8+LgWwUrDVcRNEftowuYYSGJJkgGLeQ
	VaSvlZbe3W+61gW029VXdvD4jKhY/HJ5U/tmatbDRYtQfCdmVstCWHBs=
X-Google-Smtp-Source: AGHT+IHpZ4PNfZmrt0ylE+E+OUWCD1A9/jAIKt2FvAYG2iUrsBulIk7xepNALMn/eodDl/vH2rCqDfh3xrZk0jst+gC+dFxjZVtD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c6:b0:3a0:4a91:224f with SMTP id
 e9e14a558f8ab-3a3f40474d0mr105177225ab.1.1729557843276; Mon, 21 Oct 2024
 17:44:03 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:44:03 -0700
In-Reply-To: <96ad31d0-7b3a-468d-8525-5246124b7801@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716f553.050a0220.1e4b4d.0067.GAE@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_update_tag
From: syzbot <syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com
Tested-by: syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cd5c87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=8743fca924afed42f93e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

