Return-Path: <linux-kernel+bounces-186834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E108CC9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE27F1F21F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CBA14C5AA;
	Wed, 22 May 2024 23:44:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C57824B1
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421448; cv=none; b=gKRk43kOTtKi5zTJcbNqJO2qHEN4OilZCcW51cyp9sz3P5+eAfwYo8L6xTZzL+899tB3XidwaWFI62xj5q0pvf+VO07T5DTlEfjSpB+Rw/sd1/HEyzHi3dmtNcVWq1vPHFRG2KfdmUpm18qUhtdZEXwIzNFZ62mz+baVHYR9BAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421448; c=relaxed/simple;
	bh=5cRgqLhnmRmdK4aejWxtS0oasA7MXCMUasychzY5exk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U0Pte8rRGfzn28+Y4qNouMQICOssLJKe/QOrBWB0C84YtGggmqxdGqkuWdsHvfBU51uXm0ymIFNuKl/uIlaj44EATZUYi6YjpYcOFshRQ/EjcZDiV0A9jTbwIwOQuN/98rbM+7vsyyhFtM6Ua0gPbUGGjUk8a2m/Rhw6ncLiPAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e212ee8008so95102739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716421446; x=1717026246;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc2MFBhwlsHVuQtz8cTFgP39zvHjmAPHFY0rODoSqj4=;
        b=aSLMXpzVATb8eQqToeoAvyAY/gR/HechmLnk0u20f1h3sEsve8PWm+NnhtXMzszmp/
         kibyWoVZRQSLquqSnrM/r9mmxZbS110CnfndLwhvoHKLbkrHqvnfa64v+vv5l23h6369
         zX4yEbLZmuWIRLFbtvCRFrXx76Vf54pMAtIsjC7AlYSRSwOB/zi1I5fvfpiTcrj0ylAb
         jhmZ31/182POLePAijJ5i12k9HR22w5cvv+DpjAmPh+EoKC3O5YdENkLSizOn+MLgtFa
         wc0UUVtkXylkF+nlVxetUBBBE+BMBWFQQhPJmiyZSJ/s4+T1VZcD3oFEnve0aT5TKGdf
         9Bqw==
X-Forwarded-Encrypted: i=1; AJvYcCXhBTjat+VKHd2cB6kWkaD57rkEy6FMzTR1WUYU9KepRGyGAYnzF/OefejO/8crV8lqOYO4YrZ9xOouUInKbqONUjcYlUY7IO2E5Dea
X-Gm-Message-State: AOJu0YyQDRDXyOlSQnJ5rVi3kTHdXstZkwLveVe0gg6OSg+XbUSiZ9+t
	5IQIlSbh6TSsq/2uCZGXmbHQ62Y5VFNURx6ucDS+Uc9PfjbEhf0nZXJ8BYxQxWE4VKS/jree41J
	yEacQH7b3vFKJkmYbR/Yd67hrvhTudf1//tLd1zU2UJU5ZretUwOpMlQ=
X-Google-Smtp-Source: AGHT+IHiGU9PmZriZ6f3ikyc/VDs3Af5et45t77EKLpej4NeZlnSL8OSpJLRnhKWR0NfGJI/AGv0RU9eMpfUo3pZxfK3+2cJYe4s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2182:b0:36d:bb86:f6a7 with SMTP id
 e9e14a558f8ab-371f8c2c19bmr2733395ab.2.1716421445976; Wed, 22 May 2024
 16:44:05 -0700 (PDT)
Date: Wed, 22 May 2024 16:44:05 -0700
In-Reply-To: <20240522231944.2312-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092914806191382ac@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
From: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com

Tested on:

commit:         ea5f6ad9 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=107aef84980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1cd4092753f97c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c7a495a5e466c031b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b12b3f180000

Note: testing is done by a robot and is best-effort only.

