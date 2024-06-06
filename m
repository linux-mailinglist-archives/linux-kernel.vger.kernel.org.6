Return-Path: <linux-kernel+bounces-203969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 197A28FE31F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758A6B25BF0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E8016F0DB;
	Thu,  6 Jun 2024 09:15:58 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2E16EBE3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665358; cv=none; b=fL9afE7EshFri/UzBEfWglafDncg/wIodR6y+K3BNVWWRLvCNDDbq7S6BwJK+bmApCw8rqHFbN/BZcymbtKAVgpBC3cap1w43zLZyc+j4GCKP+Iq2Z7osBcMzomVhDyEGXAjv40Qduc7Z6Sp1BJA+y1VlGlr3dw/ge5CPEh3zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665358; c=relaxed/simple;
	bh=qF/jBa0Fntjej7YZy5kCrSTjdui+yNXZunZlGffXaQE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M1aBHpB8ipXWLuEBUC4OBFO8wJZjQSFUXPT9cnSLtALchQkrupHVlOEWgKRSnzEP2K/r0KEcyTYTe/QjE2+G8jK06Z76N3z6xskDh0Hqoe23rWOrENLwzglUuIStVed8Os6LsrkSXamDWhY7iAXGdY6t1nGRtc+2YaEZmWIRJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3748be0ae92so7410225ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665356; x=1718270156;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qF/jBa0Fntjej7YZy5kCrSTjdui+yNXZunZlGffXaQE=;
        b=vqlBiFYpn9N7ZPC+Fg0/7etWs2yGr2d1xAu4CiNdmfCyWoppGCxYXbV29qsa89tjBa
         t4p0o9UM3+01d0DfPWnA9NB/+ViDHE4qplOIV92Tc6AvOhB0hOQ84Cps2WoC5QW/ECkD
         RDMvkLzqnksNc798/Cu0jkGL0IfLysmaRyfcDd1559ZNzQCsoB54RVbot6cx4s9ZwpjI
         x9kyfiH4r/BDdPUoyCC0j2ZTNajWsy0h2Ti825B+4xnfRiVl9MehpZELzEv2JU5WXw0G
         LdKpjC9fMpQ7kauSqCSJAIPMvv+HWuh8K1BOSIBZ2wXFMjTq/7y2MHNm5VcAMkhOwplZ
         XxIw==
X-Gm-Message-State: AOJu0YxtVQFFfmVyy3M7whCz6xgF7yFSKiIoPPtSzNgUN4bWyUdifo3g
	QyiIcG2kUIfcP+f9osmUIUS/Ql4Cg83CYhrvd6n+8wVVAxvqUf0+oIHSRZeEC3NGbczKzsdtQxE
	wP5YHyCUyDvoXWQLOUJw5yr94KX8IH4MOgVBD4ef7rsJmKKCw45Jkk2I=
X-Google-Smtp-Source: AGHT+IFCBTaEX/vsOjQcoALRp4YT1RNsCCyWjvtaPfQf3pYffJGeG7cLBdnEjYwmBmAfqUkruWmiPTtNgyafySKJrNGDIRJEeTUu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:374:81ed:b5d4 with SMTP id
 e9e14a558f8ab-374b1edf447mr3366785ab.1.1717665356191; Thu, 06 Jun 2024
 02:15:56 -0700 (PDT)
Date: Thu, 06 Jun 2024 02:15:56 -0700
In-Reply-To: <0000000000000fe556061725a7be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000662c20061a35215c@google.com>
Subject: Re: [syzbot] [syzbot] [ext4] KMSAN: uninit-value in aes_encrypt (5)
From: syzbot <syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [syzbot] [ext4] KMSAN: uninit-value in aes_encrypt (5)
Author: norkam41@gmail.com

#syz test:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
45db3ab70092637967967bfd8e6144017638563c

