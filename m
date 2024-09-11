Return-Path: <linux-kernel+bounces-324644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E02974F39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFDF2882FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F66017F4F6;
	Wed, 11 Sep 2024 10:05:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA913A884
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049103; cv=none; b=EOnf7Rq3Rv0huoIrzbXuwaSkAzHnRIvS2FkETx/wpV0thhgnSv2CTU59/cuYUplAJ+o5DkMdiiSW2mFeuR8fRPSJrj93HEhYWaGQu04jtoxGv6LVOEPDXUx+fz0qKGcDOrsjKS91y1NFIPfB15EGcC5oc7R2gnkSM+moa2JG7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049103; c=relaxed/simple;
	bh=NF0h8nZdsL/Jn+JWd+qGplwElShfyzeI13id89sxNRA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HE/hwb249oJIphVkMiaMHUSwu3ZziLIXKNxVv9fZJE251tDpyftwT7DW+uHzbKY3hDU4a6kwq1H9bDwE0irinqGUUiCuqMygm9g11BnMYEA92FfVqD9S70hLJ0LEADtb+QROVnNRjXuB/yWzEn1srOFI3Io0VB58D6hKuINtayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cea2c4e35so632007239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049102; x=1726653902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWodEHvZnudDxKHGjfTvsvPA5yH1sv68ORQTfnTCblY=;
        b=rxVxZTOcrjqYjG7BNvNfl7jG9SFpIHs6q0BP9L/nwU1aUp0H3loFhqzEG5VY9ltui3
         JHjhpOCGqNwviTJjLCSBmS9EW9MEHHmxz5oiVWHtYGnyyql848NdGgAigShO1k7R1a64
         7sxhVfHrXvdestILpeJIH1jNZYdL0+rNPBaUohXvloDitriZdguIw/Us5CdMZb6jwxwc
         iE8oG+Ph2JL7x4jaXS5x4IAo2C8dMZ2TEICT61Jc5g/qNUjFpELSo7xq0adzjDqxDcGF
         Zzzd4irFr0KSx4wgBr8H5Zew32zalvBkvsFR+OoKCekzoglstiJyNe/Jis5cSoapCu8+
         H94g==
X-Gm-Message-State: AOJu0YyA2+TZ8NlpbK2Uy190EL07dqT9shkpfx0UFz6kIn7MGeWgYPF9
	Jm48MUXE0CYWr9gR1wSBPNtvFeKb7ekuCMbFk444yBT6b+CqttNj6RiuYea9QL06Ga4vnR6kmSX
	tCOv/7pvK+Dl9E+Em8Lh4ZisZmApW95hc8lvBVtcYoexu4vppBHEBJkc=
X-Google-Smtp-Source: AGHT+IFmrBEl8WNHhJgTXBi2PjUo39BS/LmzTPg9GzpjSyWsT/cDRqP6naCUgB+uQKY5H7aeksuQfoE7nOS5giw/GEAl/4Z7+Ya/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ad:b0:37a:7662:7591 with SMTP id
 e9e14a558f8ab-3a04f070a8bmr230266765ab.6.1726049101918; Wed, 11 Sep 2024
 03:05:01 -0700 (PDT)
Date: Wed, 11 Sep 2024 03:05:01 -0700
In-Reply-To: <0d2576ae-f3c9-4700-8cdb-8957944093e6@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095c6290621d51f6f@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-out-of-bounds Read in
 udf_get_filelongad (2)
From: syzbot <syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zhaomengmeng@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com

Tested on:

commit:         8d8d276b Merge tag 'trace-v6.11-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12416100580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10de7f29980000

Note: testing is done by a robot and is best-effort only.

