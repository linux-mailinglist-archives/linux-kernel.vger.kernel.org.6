Return-Path: <linux-kernel+bounces-266738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A883F940619
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C92D1F21DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78D153BF7;
	Tue, 30 Jul 2024 03:56:09 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED21BE5D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311769; cv=none; b=pywV3DNXNjFBqoVAo9QTs2V1IctQdnuwZOmNqTbAWNPaKU0vNTFaClvXWLh1MorcqDUkq0OUXEuxHIa2ANxpN0Fj93Kl0WfOt6TUpgdGmjDKgx9A65FJZ9R6hf7lx1Cn57KoyzEqgE6UAGzfaHdI+r6/VVt8UFm7iKT7TUQKoh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311769; c=relaxed/simple;
	bh=nxOa5uDJVJ6voQPM+/ZPkm8t8eRRtqAiZDJPuBmo+XQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sl9l0/NXnfQ/ae4pXRtHM8Z+nTjZDnuz2NpRHSPwkaUz5hKHPWb2XVDLXMeklyp7vyKPY1cAo4ypCmj+SAVL5hT+wbigALKPI8BnTk+xMM4tbnkj6dZBAL3/1EmPI/41/QvtxD6W4c9zpgQ/ihra4/LRud5yXtIrfWRs1aKYaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fb21a0e41so139545639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722311767; x=1722916567;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cWwNCo8VRV8OZKutRegBpafz97QID5MqriRCXBEg9Q=;
        b=XHfHklr2kTKFUAR67q2RSk44RLgBb26RremuPtFTeUUAvYNfmGPrfOro9Ngka6nlWS
         X+7+mqgDNEs8vdBeOfzL//kt0gjj9HiXJPQGVXkTQzc0ESxhHInMKJVKuaUL4PkPoMnF
         inlQzD1AAoQI0/Nl2kKH4zSP3cCY7dPFuAbsUPAyP8ZtH9cKub+PWLjmqSAu3Znlb7vo
         ituJ6t3UxDpZsk5bQRwVaaBQiTbCnh6sy+3ONg2+EdYp/FJaUJ773zDFqxzzV11bpHvm
         fs21zJg9L/odYKOewc+OIGuHTGHiTNSBzYo18Cy6egRdFjB0NneMNw/74AtLNB/WlC/m
         CpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVseN8mgmKdM3MnJ6dMWnR2rVsuDTTtiHi2IhQg7LoSSsrIudRtxrSm8pOFSbJJ8WJPoscGTDXRQHJh3nliVOATglPt2OOcZWueZ5+T
X-Gm-Message-State: AOJu0YyAAFmPONBCyq16Pdhq+KPQLAqTFCXHOboMpNXRtf6qlz6I2akm
	pnCnEtYsiX5zsWwwfzZr9YpvgRN3MtNyG0KDUh7CKw8/XnzrErG24XehEhfElvFM1ytlmZ/io7e
	YlNib1oT4fGFknlx0GnmMOE7/1DYApLoylZbFZrEpilFjQf4s2/M6HaI=
X-Google-Smtp-Source: AGHT+IG5uSjschugZgnRLsfKnB5uBx5/DykLHRgsy9S6pvMXwG0jphKUxW8FOL62s3+aHBY2l6EynEP+ocdPGdecc6FGTH44/JJ3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15c5:b0:804:bfc0:382e with SMTP id
 ca18e2360f4ac-81f960dc663mr23424239f.4.1722311766846; Mon, 29 Jul 2024
 20:56:06 -0700 (PDT)
Date: Mon, 29 Jul 2024 20:56:06 -0700
In-Reply-To: <20240730030757.109700-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e4110061e6ef5a7@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in hdm_disconnect
From: syzbot <syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com
Tested-by: syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com

Tested on:

commit:         1722389b Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=163ffdb1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3044dca4d5f6dbe
dashboard link: https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1057af03980000

Note: testing is done by a robot and is best-effort only.

