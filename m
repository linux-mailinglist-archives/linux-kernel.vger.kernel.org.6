Return-Path: <linux-kernel+bounces-198616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E628D7B13
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC69B21803
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A2822092;
	Mon,  3 Jun 2024 05:49:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71192208A8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717393746; cv=none; b=OsK+D2lvdukrlpUjCR2SUgAjRgsF0bOJWkR0L26tE3emiv5NGQeVDYsM+oJ8CdH13r9uGZLQeUxLnwfJwBQ+1iialnZQNtZDscCNz6rSWlWeaOlTfspZwbGmVlPyW+MXI0BnhEdpj4MH4SEzaYM26+aj/t+uLFYpooRtgwjRgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717393746; c=relaxed/simple;
	bh=DAIabyCWGmVQk6Lpu8b7hGWOKIK8rzxi9fkwViNzR1E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hKvx1LReQSgUUMNpMTces67xaTVH0hVNoYXLn03Hm1JZAO565CW40MmxlTecmRsRGajk2Tuaihz8HTTET8brjyzM0JdurhPXAqrXZ1eBaQCHDUqeE1AxVf0SBHyrdtICbRJoXSh5+SpLA72ERbUF9x/tI1Fw5C1elt6SM9FDltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1eb98f144so506002139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 22:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717393744; x=1717998544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0L0w6oTOhy/MWBJmoDLj9z9vug9kj3plB0eBEkR1I4=;
        b=MNe4YocImF3bdNsAcpCAnQe50bvBo9FL/NCSd4fzFmU2IaLcBbB2EzdSnQ3IYzIR0b
         G8m4349jyDB/n3EfBNb9/Fezowfyt/igVNbppJnI0SvryTMH68KCGhdeRBNvQcnkhnFl
         C1TERNIz4pjvRXg3O1F5lYuBEMMXJ6awJNAtl8qrn7VpqG49oMcL4r0UYVkDXu+OidAE
         nPt55juB+0SrabP1P/3rH92UTLDWbwD1NbTD/mAhfkNrcFt14olStZOLfnDPmEkzFlQz
         2+P3o3yp0Be9yI35QE72lhcdoZH9LLFZaIjD92o8V0hYWPuoR13aDVsQsQ0BhNmURC6y
         HGyQ==
X-Gm-Message-State: AOJu0Yw225UXfuaW6sPAdksKDLEvfp5781u8Zyxl/QT1oxdzfn3N7UUZ
	wNJcKvf2fOzfm287BF9EnMCTioPmmX6/yeSc1yPQYxBYIZdC5s1Je5Fb8iPBeuPIlxO6wr541Yy
	3cDMo6oXPSHuDz38Ed3r08+WSzL0Jfi54iI6IBWTV1wbb3uS3JxD19mg=
X-Google-Smtp-Source: AGHT+IGQRVPMJQ+X1vwM6E0DxPl4GVfW3krD/B/mjp2tEJhydobTosg17X0/74fkrqKP8TRPtFjJEdFM1sysc5qK/s0UU3DC5h6q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:374:81ed:b5d4 with SMTP id
 e9e14a558f8ab-3748b975c57mr6074685ab.1.1717393744711; Sun, 02 Jun 2024
 22:49:04 -0700 (PDT)
Date: Sun, 02 Jun 2024 22:49:04 -0700
In-Reply-To: <CAN-2BNR=xVQKPU4k4EbP5o5oxW3g2Rj2AwaDBrAZ+wuoNWbpWQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017e4580619f5e4ae@google.com>
Subject: Re: [syzbot] [squashfs?] VFS: Close: file count is zero (use-after-free)
From: syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nightu.pwn@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/dma-buf/udmabuf.c
patch: **** unexpected end of file in patch



Tested on:

commit:         861a3cb5 Add linux-next specific files for 20240603
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9c3ca4e54577b88
dashboard link: https://syzkaller.appspot.com/bug?extid=b2cfdac9ae5278d4b621
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a6e206980000


