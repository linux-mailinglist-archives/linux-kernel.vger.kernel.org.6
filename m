Return-Path: <linux-kernel+bounces-254882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57889338DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127941C23064
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A07B39879;
	Wed, 17 Jul 2024 08:20:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63C38DD1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204435; cv=none; b=TV6NKjk5oPBFjVANMTTHhm9Q+ZxaGolAjH2cO+9m0dmmMzEvZBXwDeWcFjD4Cq0vd2h8zRajKfy/6bZsXjsEYo+F9Brbs9vg1Oy6g8JPRKVnjpOm10HFTszUF/l/0Bp8jWcOe5j+Wy+CqQqGPR81oQw9F0Yr8Qpsy8NJft5OM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204435; c=relaxed/simple;
	bh=HpF/ZYl90LHdP2u1PLXoFmbOssEGuN5d8iqzxLhF8Q4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UVkEvmTRTGJozlw/xGhpR3vme02XuqBjAoccYDVjVfS9HctrYmTLgUk3o4tTpY/FFMj6TRq1nOWm8ogf9gQGY75TBEBkereERIe9sH7Gxq1XtTZ5OOhx306ERw0O9/Ot3Qx86waXtJu00je9QJp8DWjH5t9WxjbaHeut/e9LgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-381a6b62ab6so10054435ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721204433; x=1721809233;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pttqESYBnWq2N5iJTw4n9qK0Jw8VyZxJ6WsovAk9m1U=;
        b=KtWOnWCaGGK9VS57payLPcN6GEvbPBzHxSP/tTq++tIodo3tvmNkrxI8q/FRzQCFSR
         L/khJukIDgxQrQUxosqYwYuQmgXHBY+3w1GQbO/ryUijX0q0hcfK8K1OLBfxwrxG/I1u
         +EjE5fLlEWVyI9qjim+W6kJC+vYv26DCSpfz3jnWCMucvg46ygMvV7iJF9bMCOkkxwRH
         Y6had0AAkmZ3mMRDVXobckpCGLL+9+N0vNFapir4WyaN1vr37iIPnoM0GLSDgBOgQz+Z
         M5Soifsx+1KNNk3ZA51zDPDMg1Z2yStlTPjvXMkugGkD/JYhY5MvtRJrQrd0hFFDzy8Z
         IvHw==
X-Gm-Message-State: AOJu0YxuqlCH1m+TpcwLjwPkB9EdxaQsA14izvf5AbhcON3R0c8+05LT
	U76ke43k3RPQHMJ+wmSNBpXy1xbjYYSbe57L6iw60j2F5huXOSUz1pq6A4xfPVAYT0ZTgzqZCnr
	i3BuzzLQUlyXpfl0RlMjTdVtANlUVsTM6Ycz2P9UgJzaynrJi5wikNIM=
X-Google-Smtp-Source: AGHT+IFmipf9zm2AKw7KVUzJIu1mOTHpZCWRvSlx6eM8ea6+idkqE6uEQnKIIu35DdhieyQMdyTiF9xHkkj6oZZQJKI+H3fWOzqP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8f:b0:382:56bd:dfbc with SMTP id
 e9e14a558f8ab-39555800336mr894555ab.2.1721204433740; Wed, 17 Jul 2024
 01:20:33 -0700 (PDT)
Date: Wed, 17 Jul 2024 01:20:33 -0700
In-Reply-To: <000000000000be9914061763f17a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc1a53061d6d2258@google.com>
Subject: Re: [syzbot] before possible fix
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: before possible fix
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git 
d0c3df62779f875b9af953790e5e18bce2aed91e







