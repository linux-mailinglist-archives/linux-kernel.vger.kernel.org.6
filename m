Return-Path: <linux-kernel+bounces-241408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B484927B20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E40B25D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C981B29DF;
	Thu,  4 Jul 2024 16:28:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419971B29C5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110486; cv=none; b=YhnkiHmQ+GQDnMdw0jOwjiZmBr746dl4C2egpwYEin3jL4xZ29RVDo+ABVYk7mBuCo7OI3nR+XzDDoaRV9l5FWxAwB4k1F++sXmikP4zG+g8HZB+o8iiaOn9Jw67NfkZWWa9vt3ZlU0siJKEsX+5b976NKnXeht8UHZ4PyxgQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110486; c=relaxed/simple;
	bh=LA7+AkXGX6lG+kB7PeQYSn5eNo8hyKnXt+PodWs1w1Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oK6P9O4wJyrMJILbIToVs/INz6YW4yODV5YOVYw7b2liurDH/jSpZc1ct0JgIQwyRXrmx48LJ0jFIkpsVivC7JGRw8lH2Lyx9BDdUCuNT5OLUI4lD63lohOorFdMtRDZytEMo/udDEkuwiTYq+6oPyejUyUcW95odZNcrbP9f0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3c9711ce9so91939139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 09:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720110484; x=1720715284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0PsN+14R4XPmzHfvv0lxWeqpJo4NECYb3Gj1ZDxrik=;
        b=ZQ8Ly4vtbTT2N9cpfpjoM+hT/IsK5S6eZH6KrfCYELd/7Af026BLSX6hIsuru6/Wq2
         r2rQiMvoyodUNWqyW+7iRgiqHOVGBsAhE799gSp3ShyBH+k8j5qLRKYnRSFDhCrhnhDB
         vsnfq5R6Sqek9+63or4MqF2coo6QiqjIB4F7btSvWob/Pf3Oryg6+Zz/HAcqNQTWx9oA
         eOvdvXc4EtHY3IDOPCJI6K1gAL8MRrG+zytDV/aPHQBTfPpZ7iSRJRuguv/QWmmxhXdO
         E/pFS7wPDfd5vZJzTxHPMZB9Cf1SyeTUc+YzqW2O7Xt08qsiwBDCC1+NEUbRB6U0NMmz
         8p0w==
X-Forwarded-Encrypted: i=1; AJvYcCX35ibeTY+VDKDBD2pYrImrbCQaoZ4XenOXjbi02u+fFbIWLsu/W3nRCSuAJZClxwD6Jc6yhQY9BpQwliQLyNd9bFuDybrX5P82P+cm
X-Gm-Message-State: AOJu0Yw6W7/3o7rYTVp1JUbY7K2lyMMqWAXqaQJXcva97t+fbM2o1NOW
	HO30YfmKkqZp65VH8z1kXLWAo5vqi3CsBjxLtFhtGf9u7PjEPE4cZw8IUyntbodJHG3z0e004BS
	iLvUX7hNs3vtJj9ndVMna0dnPwxDkFBCWZHOtwmkDpueiAqGrwIyODEI=
X-Google-Smtp-Source: AGHT+IG00d1VfDS0iAhB0XvDIrCrb23RFTBNxAhPcdGZExfqWAUFENmW1qwWSvs25GmCxIvIZALCdkDmx813nrv8djLS+VcwWX/p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2043:b0:4b9:ad96:2ae1 with SMTP id
 8926c6da1cb9f-4bf5bd59404mr125811173.0.1720110482396; Thu, 04 Jul 2024
 09:28:02 -0700 (PDT)
Date: Thu, 04 Jul 2024 09:28:02 -0700
In-Reply-To: <20240704110254.91612-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000472ac0061c6e6e50@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
From: syzbot <syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com

Tested on:

commit:         795c58e4 Merge tag 'trace-v6.10-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13bf4581980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104920a5980000

Note: testing is done by a robot and is best-effort only.

