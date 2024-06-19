Return-Path: <linux-kernel+bounces-221140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B709C90EF63
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9631C21726
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3414EC52;
	Wed, 19 Jun 2024 13:51:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6613DDAF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805086; cv=none; b=SZXkYKf3bIHrX98Tk3phDFUVHU8Ak25vR5LXWShsrapgfvQHyennacPB3cUST0eg+T9xj5KUWrZJfMAN1Pcx3UDSlrsYk51Lt19eq3hsOFTHZZGmGrR0P9MTsyoxj41GzMPFD9kCfP8/KSlHOhkA80kC+94q6Cp/Uq7JPxZdc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805086; c=relaxed/simple;
	bh=0rILnc5eYGBaa6rf76Vo40Z5d2IlTHwSurhnGC1ZPcE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ny3JgWXsn+t/H5VDwxMntSCQk2TK3e1s/5hYkWBC/ZX2tmYRb1n5lHwPV6hx8XWzzALpR6N+t3gKEhr34v7qoErMRGz1FVRhYGEuWK3+KtdxSZePDd+IWheCWA6t1GLATWF4Qqdf4xNCzm68NM0FuOAhoFo1oUA4pBI9JaoBxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eee4ffd19eso406644439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805084; x=1719409884;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rILnc5eYGBaa6rf76Vo40Z5d2IlTHwSurhnGC1ZPcE=;
        b=XR4KLlFLB1jWj4+oM531pGGWMKIrRfDvMXq6O+BUzOAkhv3bYs3IgT7qSluDXs0xEo
         jaiUTJ8PQoTlQm+XFzBy98IUluRXtLGGWp2ii8YY2OGdRHu706nQuq62BIm9pniZwpFM
         FfFazkjP251GCuscJNSBPmWMIEhacTeXSg/RXn2s3NCkz+/MmOr3H3SuDWpiQ28IwEO/
         Ts4la0Y8SRmk1xOIU7kISXfi2oNYwJIkdtcEInpBxt/Tdg/llpNwINyeDpVTeP7RD1S0
         Phbnp3l0cmQgQ0ufN+J3HxttanJR7P0CRYmsGrTMv0PcOQ9zQFdDjma4FJhtScG8tQNS
         KsXg==
X-Gm-Message-State: AOJu0YzhhhPxI56Jm+jbrfAAeIUPLoYSrBNdnA1bAWDzY1V9AM6qmiF5
	t5sFvfeBENTTgnSC9NIpEiiHakDYDvW6SIvJWljCgw1kHEzE7PT6YNwS0z6PQ9V8JLLD9/vMKWv
	uMiIvDhZQ5O6kKsL5nvwIXqu3SCBzSPXnYdfP2nyH4hfAMNzfgbvYtng=
X-Google-Smtp-Source: AGHT+IEaOfSybRFbbK7YqIfK1U6N/0Jg9uOEK3kMzqLN1hTJkwsBnWc5O0UbMrqfluziFW5ChjbREwViXyH3YqKcYzo6NVadzPqN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4d:b0:375:8fd0:c939 with SMTP id
 e9e14a558f8ab-3761d61dec0mr1802445ab.1.1718805084731; Wed, 19 Jun 2024
 06:51:24 -0700 (PDT)
Date: Wed, 19 Jun 2024 06:51:24 -0700
In-Reply-To: <0000000000007a5ef50610c5799c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083931d061b3e7e07@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in bpf_probe_read_kernel_str
From: syzbot <syzbot+a0fa177e13690b663c74@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: BUG: unable to handle kernel paging request in bpf_probe_read_kern=
el_str
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux e=
e0e39a63b78849f8abbef268b13e4838569f646
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

