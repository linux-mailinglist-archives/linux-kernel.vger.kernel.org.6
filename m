Return-Path: <linux-kernel+bounces-321780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E679E971F56
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC5CB21399
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAE16A957;
	Mon,  9 Sep 2024 16:34:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4B161326
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899645; cv=none; b=Belw0sx5OdLYQ+62a321iYJvmiO3pdWQ//FYFvfU1ptkdLcODyRviV5rdFsM7gDxgFzDn2EwF7IFUiYcV7LV7o41Uk6jecJFIYWSfQMqd2G2/PL2PTJ9gfjepJ+xOirsTrKxg9oVrZ2DdPPSEU87vaertkvKMOlTXuQHuyD+nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899645; c=relaxed/simple;
	bh=bMm8nUIUhcEHUYKUu/zCWqgYuxv3KlDMXvGmBOnbsJ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c1l3bNJMUQtdKJaVo1GRidw/L/IWTuHNdi9pv2fdvCmlOPlTH5lUnbug8vaUNmcgyN5Qu5GDMpzXVCjcmultAhnqzgz01bPDIu9mPK5TV0ng6fsEx4m/SdhUyJA1N3KN+hN4I50bK1gEBVrnPwbf7VU6w9Iq6E6fvucKL9Oumf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f53b1932aso84804265ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899642; x=1726504442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKcArl0aleLbq7//pws5EB69V+31Dkl1QLyi4LU7uXc=;
        b=Beu4t3iO/S8STN2ob0fnX1EUC24zlDliLxSPliq6OTXPPASMuIRy2KOjqqp4RFf6c4
         2uug+FgaxFoO5MixYW1PLn1RJFDxwCTERMaC7KUKnmSUJ86U/PH1lQRG2FWlXlGhRPbt
         mI/ZLQ2p4HjLpCNb2kQym9lbu7skB6RWYAqLT3ivQK5Xoh0GSXHpsxjB1jUUeYxlbf2f
         TdLY1d5Ywa9xZOiVzWtLBZGQDfPPU2AqdI3e2YB7/paoCJtVzgHBzJBmVcnwqszXRIgV
         RyTo4ClSD9p4C4+rOpfFZUIo3y7KARu6d0M4J83H0o51kd2Uroi92JrJpICQy6lKPndZ
         x+qg==
X-Forwarded-Encrypted: i=1; AJvYcCWYtXO2VnVP9b7QOOjT1L8CiNJEjm3fp7Gj6FYuFOCPWFLQrlkcd8dgtrSb6FnsD+WMGFnCJfAIOmmzidI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4C3UZfFaP0wb1Lk1ArpRq7HdEap70ek0pfTdX/IRGHynIhkr
	yHuIgaYctDRL4RSgvl33Ox19HWd6bHm6GsFCJVXz1BAmsdrggDthI55ioZviI+NMNFkFAEzLKyF
	iewaNafA0jvV76LmKPIupNYglrGp+E5/mbyoFGrhtFYqbQcmKGRZszDk=
X-Google-Smtp-Source: AGHT+IE3i2CcjujjVRQP+NueJTkbEhuNV0cRlopfSe6mtHn25Tn4pCgRpqlLw4vzmMYCi4pHH2nu/8Xr2MaZqRuJ3B+9x4epeBxa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:376:1cf6:6be4 with SMTP id
 e9e14a558f8ab-3a04f08ba31mr152557585ab.14.1725899642770; Mon, 09 Sep 2024
 09:34:02 -0700 (PDT)
Date: Mon, 09 Sep 2024 09:34:02 -0700
In-Reply-To: <20240909151305.7057-1-almaz.alexandrovich@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020284e0621b2537e@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in mark_as_free_ex
From: syzbot <syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com
Tested-by: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com

Tested on:

commit:         689ecd06 fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15b0449f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad2d7cb7797ccc55
dashboard link: https://syzkaller.appspot.com/bug?extid=3bfd2cc059ab93efcdb4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c52200580000

Note: testing is done by a robot and is best-effort only.

