Return-Path: <linux-kernel+bounces-400899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F196C9C13CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D506B225F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C291D1799F;
	Fri,  8 Nov 2024 01:54:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1613FEE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731030845; cv=none; b=uW10OyImCCxIpNO25BnHysmgiUVCyrh+Z9XYO8hVUDRLumtWQno9uZtkFTJyJv3reBFIriK8bYphFP2SAzZX7utfByN7YNn/4WKDVPK5bEtEoeBNlOS3WOrhpqQnlg6g14qnHh+scAmWdyYWRUFJSBfi6rddKe4xng9PRkmhxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731030845; c=relaxed/simple;
	bh=lSeClbEmjV7ZPYY7T5qrXT6W6dXFaEwAPIbP4impF8Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jdAjh2pNVOuYY2ZSAQcC7NGD4hkeReu9a6aRhe/DbgljTCYLcLLCsndPRw9tzqjL0iQZym59MagAVXfMgxEzsYI4MlTPznwFn4+Uw3qHSEj71YDZFPK/J/1tkIqj+nZbmx5pJ8G66v4sGtqGs9rRTkLAvIeWxCXgo+rkl5cIw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aaca0efc6so185102539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 17:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731030843; x=1731635643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88RoppTRvu3rv5fNtA1ICkFfVZi81KmTsCyzMjydAko=;
        b=i+mBOB90I1FChsfXdHHkDJcrZYmigt5XBpM8WUngMiMoVA57Yn5RaKtyo2OVmP9XXb
         XcKcbqkgkZuKnPS+68DjaH1XOffAwbtAlEOX/t5x19F33grXwleM2z2mX7ozW2aMsIyQ
         fY6jsXUGl6yL6ZTWhPlmM1CUDU8ILVQvkPWo9OB6tA4CqYyWaA998dlDOByGkqA9/mbQ
         ipJPAR7KF8NaSPzhFyl1h3Zb1DLC3GDvg0/o5xVi2Oqvl4MaApQ/sgSkacuTks+U766H
         CK81/ixujpsYuND0Cdk4B5kuV1ekMiBfiBApdJDJhHd60JW1SD49ThH9VTQpAkoAwlLg
         dsgQ==
X-Gm-Message-State: AOJu0Yzg1IP1EzPaFN5iy7zltH1+OZdScOwillEuMKwzsbnXigzsbeio
	FI4SEtTJu1lL+0GSpJ3NPnIYTath6X7H+BqBgMN5O2qSdfWbOpJ14h392f4Tr8Da+Ch80kTqE1A
	vgQOslgW993SFcEk4ZAOsoA/qio//kLONFVvpKdbx+M/jFYV4s2yHZS8=
X-Google-Smtp-Source: AGHT+IGqYbqKxMBuZChqKwhHWKihb9pnAGPGnWfkMxCTV+KOPd7ENsEYm/B7G3jWqcIekRwC69h/X1CGvvTTpFFPO0ymYZ1gO0HY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1486:b0:3a6:bf1a:17d5 with SMTP id
 e9e14a558f8ab-3a6f18cdbacmr17717245ab.0.1731030843196; Thu, 07 Nov 2024
 17:54:03 -0800 (PST)
Date: Thu, 07 Nov 2024 17:54:03 -0800
In-Reply-To: <20241108014747.2901141-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d6f3b.050a0220.15a23d.01a8.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/netfs/read_collect.c:522:119: error: 'rtt' undeclared (first use in this function)


Tested on:

commit:         906bd684 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0b2fb415081f288
dashboard link: https://syzkaller.appspot.com/bug?extid=1fc6f64c40a9d143cfb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f96e30580000


