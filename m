Return-Path: <linux-kernel+bounces-331054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0531097A7CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57C71F23B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751915B572;
	Mon, 16 Sep 2024 19:26:58 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1744C3D0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726514817; cv=none; b=D/Dg7+2gMZKJUIrjRfhiydJYx59HE2Dh6Clb77xvjFmiPfcGMfuPAk+Rr4iDlYTiRvKkwRemy79BWNAerTilazCJOYUtTWL9GIIPpT03t50+w7yqRSQs8U0HQiXBTk07j87z9t7SbvQLEk0CKbIgCIFMPaZ88ci96H/+Vi/zDvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726514817; c=relaxed/simple;
	bh=qFOgVsKCUYnJ+OyBImDjzwZCJjifh7quxlCDCXhx9xw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PLepQJRQUGEC1lPVWDN554KAduZJOnOiaUQ10A0/22sIhfPkHpV0RyifEjaxvWBM8fwFdYZMndUTrv+mWWfXiG55lAtB+61f2KJQBp5ptxStramI//U69OVFmsxukyPIu3WW+pC7gg2J3WReQrhw6AmOnIaLoHp31j9y664YADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ad9fca614so892236139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726514815; x=1727119615;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFOgVsKCUYnJ+OyBImDjzwZCJjifh7quxlCDCXhx9xw=;
        b=WPEEulJi+2bKnIS0+6GA8Tk5MbFkGYj6cksk3MB13eJ+es3rP3+fl55bFUX7Oj97HY
         PpV3ikA1NXTkgZZ/vNymTy8UOcjaw/zsCJfOBWeANU7Dt4Xal8ZZRm4Szd6QLQB3McRm
         wpYCbRdjE/UYxfkdO8QduHIjjY4PqGYUqeMUYCNPQ8zvX7wKiIUjV5QrQbbSA+sKk+pI
         e21c+94dI0VBudHwZvrjQK16ynrAcUVwCPLFSbVw0pNduXVQyHqbsdZ3rWfb44EHUCc6
         CCJ0FdvzbNG4Qlf10gI1k8k3rqcYQgAQ45FjJmnF7I/j787t1m6rWinOM53f69AvecPj
         3Nqw==
X-Gm-Message-State: AOJu0YyU09VsE2DYglViFyFMHpNeklW48gt1CNe1uTJblX4tfhbT67Pd
	j7S3Z7E1see0x2+z8YHjGV7STbv28Da3lwskPaRfZzf1/R/JVMKWr/whOw2PZ4HcTHt/MAhWnyz
	lThkiAeiKs7+il/I6Dj6Qk3qSQCHuGBw/9VUIBaOZVz6vKRYYmmlyotk=
X-Google-Smtp-Source: AGHT+IElEvcrJ7mZeCKK8yPyn4vqT6LDKnngSBJIrZwCCL1tGA1005aPiFLGzVPl0iroCD3bjotg961vOI9UlCrQxYAxkGjkvloR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14cf:b0:82c:ddfc:c57b with SMTP id
 ca18e2360f4ac-82d1f8bc66amr1910572739f.5.1726514815541; Mon, 16 Sep 2024
 12:26:55 -0700 (PDT)
Date: Mon, 16 Sep 2024 12:26:55 -0700
In-Reply-To: <000000000000b5ca0f06223dc3b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047ad230622418e05@google.com>
Subject: Re: [syzbot] general protection fault in ptr_str
From: syzbot <syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in ptr_str
Author: pvmohammedanees2003@gmail.com

#syz test

