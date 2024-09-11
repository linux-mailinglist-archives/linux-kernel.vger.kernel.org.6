Return-Path: <linux-kernel+bounces-324622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ECF974EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFC31F2196D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D120F181BA8;
	Wed, 11 Sep 2024 09:44:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F6155A52
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047845; cv=none; b=AgwsceR9TdvEgVRjgEzRILIzKvn2FmVybm2rpXh+XkRYd+W0s3nMCa9c1Bdh7rAvvBaBfOyxMEG36Ab4YgeZRJAxLrHz8MfIeLh56PUEJhgzzBydzWIxpmLfNOOW2QHSMksaHsjjjUC/PjLTsMGN6Ow/rdP4POwDTB+J5THubaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047845; c=relaxed/simple;
	bh=v8K/X/4eaAAVtMsUr1GVS3W2ec6EtOV1Y5JyyFg2oJw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QfT6O1dCc8qj1jnKczLbtGSKKP74iXE/ua7G9z6wSVtuU//MTEEvr7pmPbktDoTSdnIdm11SGYOtkbcndonJ2Qk54XJzFS9ybFfkiFykeGurHr+hZGvUCWNeyyamkZeTGL1z3rGEOCHLPCHAM6HabCi/RObLirwigxwFf9GDGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0448fa4f4so149201955ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047843; x=1726652643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXOeVXC/7ccCd215gkshLKO3A1iLFtTv02K+llXYg94=;
        b=w+6sU5jdv1iwJpKkxkWbaRAbDwBGF10l4LQxgTos14aWp+UN3ZP0eKd7+7qHPj+kcF
         08hLYJ1OWZyU10og8bjA/I5IRQ7UV/0pV8cbwX8VbyiaxGGqznFJkyRLf8USoMCUH7Lm
         ajDRY04fY/aetfRR83aLJfxt2+8DzJLpm/ISLqIYk+oS3MKD7Tm+GMRK+sCjVMYdzlxf
         KzeY0l16p8I+pd4ex9a9IUWuSuTAv87Wa7R/QWJsJl+gN2RWMstdC4pqWjI42QprZnUo
         yB5gAccCCEeC02eGxQMG3TJ0g2xHpBS4QK6PVAKOshVEZsQJ2BxlN1z659lGA+1zyAl0
         wRCw==
X-Forwarded-Encrypted: i=1; AJvYcCUbIhpb0fu+Fb0aktwfvARLg00VDrJCqnQFxurBhfr6qwIi2mCa9pIT4gLn8eTQ8rEayg64s321X4iNZOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrd+qIX8toLjUmUCGm72pAjy+ytPgpZmWjy9fiAcd7JjdNAJy
	hxcK58AInipxEQmNPWlhUIKsWvs6/6QRJl0nbb16c5a8OmFh1T19sZcf0x1o/ufbruRCyQJfs7B
	wkyc5UHG90rpDzMmQhlGsysO5D3PQ0SAepcssOKUMpoLZmj6KAHw/GJs=
X-Google-Smtp-Source: AGHT+IEBk+wXiOPDzqUMrejQcBNntLrioWkSlSxO9AiNLz0+VLcvi0YUKichnrCScej6FZQ2WpHjUfh11mEd2ZCA//1IAmgkHtyK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:39f:5e12:1dde with SMTP id
 e9e14a558f8ab-3a052399e54mr133214095ab.21.1726047843298; Wed, 11 Sep 2024
 02:44:03 -0700 (PDT)
Date: Wed, 11 Sep 2024 02:44:03 -0700
In-Reply-To: <bcb5d5d6-fac4-4297-91bf-2d40fb023153@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090c9f80621d4d4ae@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/smc/smc_inet.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7e3e2c7f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=dde5a5ba8d41ee9e
dashboard link: https://syzkaller.appspot.com/bug?extid=51cf7cc5f9ffc1006ef2
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a9a477980000


