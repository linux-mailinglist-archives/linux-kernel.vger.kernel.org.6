Return-Path: <linux-kernel+bounces-201837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 951188FC41E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF4B2938E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CEB18C349;
	Wed,  5 Jun 2024 07:06:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12660263
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571166; cv=none; b=OE64OOyvcdD/fSplAhQmob7bCZTZMgZOsuGHNWqR9wpN3P+mc1jmL/LVSyl0eNeQw56oMTnR3LkFf+33Ac2tVqEC4Vulki1AjHzJf7sGsDSRzz3Jzss4NhE1d7grf2CAawde97UpkQgG70QHJJV/nQjkaW+/QAbfvq/HNPunEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571166; c=relaxed/simple;
	bh=oObkjTjJVqS8GoV9TsWzHO6czuFQkspGvLCNZJuUH+s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=C2FH1m8aMxCbbPwL7kpE3NnoVJPWi3NBmsrfg7CSap1Kvap2bq6IFHlROAP3NPqFQdQN9pNWCb4EigL86UAD3zelhsqLo2TA+q+3+VeU8j9wlvXMe1FxYIjXI4P8NdexJRWqPmP3VpmrJxmsI0VEOlARGwLiyLHvVP5/ZkynDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb3978abc6so121455339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571165; x=1718175965;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oObkjTjJVqS8GoV9TsWzHO6czuFQkspGvLCNZJuUH+s=;
        b=Qaav7MNoWOW5E7ACRs906MAnB2gpcCi1a8YOPAnkJYraeHXFs4p3oAKF8PlZZ6RNMX
         87yEW04LCg/AmTC2stBHc09itCrAls4vKaCyOAqwXefeE+27nBPvaF3aJpRDnjMaXeg3
         h2XSgKIxjTD8F6h9j52jwGBYBpurJcnHnGtcr+UtXJcC/K1cChbkIucmzYdP+Rt9ewqH
         nxgAs3+L+wj2ss2IH9SxT/PBZxENzj8RXjELhAkvh1RzM5Z39AC3rGkfQPpTGUM1p62z
         4EKIa9AuwN0T0dHCV1RSnfL6ZghF15E6JwXi8nxCrhweqUW8YkGa+S0BPJOljQwRi3/7
         5TDw==
X-Forwarded-Encrypted: i=1; AJvYcCXcfzPJtA0A9t4eTWno3KUeukZZvMVOsItB0TYN7k4vDAshLVgGWkBf/EhUMtLCGqG40KHbHnq4SY+X3SUAaT/kIyJXzqIPXjtKA0C8
X-Gm-Message-State: AOJu0Yx/+0BHvM2ZKxkp3JB+7aAP6f4f209ehxIZzJCNn883UYwGKLQ+
	FZjtEGJpkvajjkjX2I+RmQsEFsd9ry44f86wWQjGyDV5hHV2GIU29zA5jpPs0yKYsVdZbRxW0hd
	dU/HAR0isUCYJvtUBe7YJxSK0/rsln7Zup+0281nyLz0mPH8+cXnn3lM=
X-Google-Smtp-Source: AGHT+IEeRk3IEHzDNO+8xrLUYZ65TYbrzcDxhPx3x9c8dC/93giCXvBjG2PSL4BWmVC0b/DdPZnPEzJPFI9BSAhcnf3wmHUd0NL+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:379e:b0:488:e34a:5f72 with SMTP id
 8926c6da1cb9f-4b63a82ce44mr58914173.2.1717571164797; Wed, 05 Jun 2024
 00:06:04 -0700 (PDT)
Date: Wed, 05 Jun 2024 00:06:04 -0700
In-Reply-To: <PN2PR01MB4891D7E2957A087F04E16731FCF92@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002789b7061a1f3352@google.com>
Subject: Re: 000000000000fcfa6406141cc8ac@google.com
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: wojciech.gladysz@infogain.com
Cc: wojciech.gladysz@infogain.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test https://linux.googlesource.com/linux/kernel/git/torvalds/linux<=
https://linux.googlesource.com/linux/kernel/git/torvalds/linux<https://linu=
x.googlesource.com/linux/kernel/git/torvalds/linux>> e377d803b65ee4130213b3=
c041fc25fdfec1bd90

"https://linux.googlesource.com/linux/kernel/git/torvalds/linux<https://lin=
ux.googlesource.com/linux/kernel/git/torvalds/linux<https://linux.googlesou=
rce.com/linux/kernel/git/torvalds/linux>>" does not look like a valid git r=
epo address.

>
> The information in this email is confidential and may be legally privileg=
ed. It is intended solely for the addressee and access to it by anyone else=
 is unauthorized. If you are not the intended recipient, any disclosure, co=
pying, distribution or any action taken or omitted to be taken based on it,=
 is strictly prohibited and may be unlawful.

