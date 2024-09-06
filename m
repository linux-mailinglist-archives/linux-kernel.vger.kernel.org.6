Return-Path: <linux-kernel+bounces-318968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA9296F5CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A81C24101
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5015852B;
	Fri,  6 Sep 2024 13:51:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9351A270
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630664; cv=none; b=rChwTRtHV4Z9htGzhx21hqyn0le0nrTwEa1TuJMqb6ezyIngLm2PPeLUzlzO35NzGfzIkdFG6PQBTGfOAmoGZC6a7w8CYuy7kRDKvzOoa97uDG2zYWomoAzr7ZiMKJasnkRmOqbz8w6cjI/0o4kc6JLKJl4sAqMcJDHpnSd7dbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630664; c=relaxed/simple;
	bh=jV7JE6LQ9QEedtAxCDCFbWNpY0RoY7LB5NLAZoyIozA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ISTg7AqTt3+OeS7g7G0zQd9Rdzs5yH+BO9eEOZB/9D49WwAbwM23YA28RNGXMuYGWZJs4kvBZojzlmyMJdZbNp89XEYo4wICnhXqsDRPaWl41kK2jOQKJxzWKNWShuGK9oOZWp/kxem5ANk+lPtGhLQRm+9vitLZ4RrV2tGrrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d49576404so37126045ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630662; x=1726235462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkmS85jfaARBa/4oGFZ9rOuWPrJWaa/RkMIGLv/cExk=;
        b=DN+XJ+n7QFD5Avs11JizHZiY81YE1Kddl8kBHLVLYa/e3DCABdG0ltNeotP9y0Zhh5
         rVyWQ+g2n6Y0+WDcLCWFuakzZj6B45dY7IJacVM9Q64v7NmfpVEX7vfZvha1QX/n/TYD
         FE8qEnlbp1rzAHUuJxQydkIu5lc8cRmsnfTdZxp9lAWVfuK65E2EEPZm+Mc8ad3y8m95
         GDTYjk/Jvyrb+3H8xTrkhmzsUaHvpzV2XvoZItAhNm4I5/dLYuvk9SkWSIasOiNpAGid
         y69nGNF4yoWuf5sEjbNOUaPO5AP00AWKYHT6ICe3FDxDXUYaekDTbA4/BmM7sktUBqeb
         F7aw==
X-Forwarded-Encrypted: i=1; AJvYcCVSmaesAeLF7CWhck0GF1inhjwV/w81ijOzIaCiVlphvSdKZggdahhh69Vx17Byh2rCsyzYMaWWTAfVt0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80d+68I2z6KJc9fv1vPWMmkpC3qUp57K1H1ygJCd8ccf3R+l7
	4+QDLqyy3Ys6eRlUiusCFTntMZkdBrLqI35a3jjL2hn52i1qdbLjbV73OL5Dwv6MlKUjX3tgmyE
	9jmJ6RmTGdQ9IuAA9sZ9JfjbNT0H+STtdDwJ/EhXEjk0LAwLRr0rskgI=
X-Google-Smtp-Source: AGHT+IFlq54UeL7HCvIeplUW5HkKnmw2fLWW1T/GzN2wHn1pbqpy3d2OADOsEc2zzBlLrKOOsAju48nVXTjuC2G5JMydnhAqtSVV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4e:b0:39f:6ec9:d918 with SMTP id
 e9e14a558f8ab-3a04f0f59a2mr1241995ab.3.1725630662559; Fri, 06 Sep 2024
 06:51:02 -0700 (PDT)
Date: Fri, 06 Sep 2024 06:51:02 -0700
In-Reply-To: <tencent_157C251EBA15BB1533CB9E1C1B254BF11B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7df7b062173b20d@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com

Tested on:

commit:         b831f83e Merge tag 'bpf-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110e8d8f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16be13fb980000

Note: testing is done by a robot and is best-effort only.

