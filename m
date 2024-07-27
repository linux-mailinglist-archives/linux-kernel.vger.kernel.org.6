Return-Path: <linux-kernel+bounces-264087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E630E93DEE7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB411C2137A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FA760275;
	Sat, 27 Jul 2024 10:55:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563F40858
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077704; cv=none; b=n9J5PLPyvtaRj03+vS01LhkD8OXHejAeEo8s4znAp7D5TYwdFnp5NHuCKol2j2DSkvFvg6QOF9wAdIkHdGQVBbL8gOqBSEogTndaUyY7Y1R4z7vRThimEg5PwZik3qxi/Vjkj436/9rR3XGWN7E6C2qf6WG1u+O8mF4OTb/2FRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077704; c=relaxed/simple;
	bh=mN9JBSFdHUtWmEMJd3AfrtbvHUm6FDyAS6LItf+96qk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FS8Z+KmkWYMLqdOKK75xho0hA0Wx84ecvVZUg5eXl2AU/RdQiaXwQknr3a6bGHQedRV1c0fGDJ6yIWyn6lhHso4Zov7lBkReAQlLzqkdbItBl5vpL/Z97tocAvD9nVby18DkwDjYSmZ1XeNtwjetQOukznjGEqUuGHtJQ+YbzpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f81dcb634so281696839f.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077703; x=1722682503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIf0WCByCZdxcxXAQVgPW7AkJ2Ukdu13lE4G81WbrCE=;
        b=cg2n24dsWnPxWDlE8CnH3hfP0RA9htrrQCdwigRjXvFQLLGInx9QeEkmT9muB/aM2d
         Y1MNaDE/3O56kGXb/7a1k3gZ2iXfvkRXg6RF+uKE/2zVrdQe3oJl1nwimsCEauXHvNOt
         P/2ObUui9gV1tYI0Fu6k2KeK5M8kph1hr3RDgNpJtZRJU37bhz0LPgShiICJpYlFgCPt
         Az9p+Qi5nN3mdA2OPlhFAvSLuFWx32y391XFJ7eQFglPJ3tSTHzKiXeCkvg/XUf7pp28
         6+4yWYnOwLVNIJ/vsFFgE0Jo8x5U/V/08aTcnseFHFaioeGPtxEX39sb86ohyr1C0YBv
         TBBg==
X-Gm-Message-State: AOJu0YzZ7//MQbIstUHUDiFYmmKfjyNfhry93JwFKmzcfaDJ0nQvaaKz
	hM/bEzf2CDGWW5Ir6xURG1HVjaUcXDapAMVuQDJuRC6n2CxnBbgSSfqEwvGzVAWPF5u/27xwcDp
	Cx1qfz66Oe2TLxHc1HuEHokAldHRq+3Onm2CWbzyQYImUNUfWAnR6LYM=
X-Google-Smtp-Source: AGHT+IHALXdOA9FWx8hi6/bkEYyV1ER0MEOWXKNg6J2o48MTWPv3Q+JD1nN3irmn57b2Ew0cm1zhMu8I+UVJVzDNDf2C+PxlBYyd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1448:b0:4c1:b049:25f with SMTP id
 8926c6da1cb9f-4c63eb2e764mr81653173.1.1722077702731; Sat, 27 Jul 2024
 03:55:02 -0700 (PDT)
Date: Sat, 27 Jul 2024 03:55:02 -0700
In-Reply-To: <7490ae81-f90c-4d24-9d84-120dc7c30046@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf4808061e3875cb@google.com>
Subject: Re: [syzbot] [kernel?] KMSAN: uninit-value in profile_hits (3)
From: syzbot <syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com
Tested-by: syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com

Tested on:

commit:         3a7e02c0 minmax: avoid overly complicated constant exp..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1560a373980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=642d8255eed2a7f8
dashboard link: https://syzkaller.appspot.com/bug?extid=b1a83ab2a9eb9321fbdd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=166fde11980000

Note: testing is done by a robot and is best-effort only.

