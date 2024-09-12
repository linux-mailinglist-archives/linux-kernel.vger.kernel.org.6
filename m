Return-Path: <linux-kernel+bounces-326689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EED976BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA35285E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C21B1507;
	Thu, 12 Sep 2024 14:16:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226751B12FC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150590; cv=none; b=QwECDwY4yPfiOTgGYPRoFCrZ6qWOpk19JPSXMGM4002kQjWHr1EdoM8TifwNTLsYLrFMSrWcs9VxE0km7XWjtG3Qld1aYBuo2QT4mAnA5XvpdU07GbxlvHif9h0A0g4vHWWI8iPMf0Hg6CG1MTAHv1Kgjp4qIsuqpGtEwGKYNBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150590; c=relaxed/simple;
	bh=FrH7F6eRwG6ae7eC1yC1bTvsPrIboV2TWCHIdmrYS54=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MhrjAyMzaj2hmTHO/pgEXckzakQYcEJIYfLD6sLIzrD9NPv4Z6iI4H5mYfGcgdEsGeJH18PKBUc6q+hXLOsktAwcYddhD0UZ10N4F8Y5/0S71/yMTGvUTtw/t+txj2uzh+EvgFe63HP1w/tO+NzqG/M21F4k62JNWlJ7BQN1KCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cf28c74efso168877439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726150588; x=1726755388;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrH7F6eRwG6ae7eC1yC1bTvsPrIboV2TWCHIdmrYS54=;
        b=C8aY0ArTLjebuoiTUFQ30SMpPJALfszbA7zGD7unKr3U1JiQe3f+vk3IqrRlJF8SsV
         Wl1J1oPG2dDngoGjXD7tj+QKKhKdPG9Drl1S4kZh/H0in0bhnhy307fvtgRAByzmvuBv
         YvoFDtTNS8kC2CGs7Tb/bhjYuZQRjFAPbr0oMtPC3hch5kn6yJE3YMS4kQnQ9kJKSArA
         8UQh/lXoK4Esn0DuxCXpPMObtI1Gg6x8y8NySenNv45ahL6TXZ45v3lvzlV1lj6/UZJm
         XPn7JWpdGsTbiehj0mFtcfb7hjcDPQV4Q0NukfVhhrS1Rx3GpAy8a7hFl+dhntVqUDjV
         UQzQ==
X-Gm-Message-State: AOJu0YzhOKquNabLY1UsKfGiregiOAdJjh/e2ZDsCaBUhQsTwIGC571b
	B+pLyyORc7jM3vY0rOC9EaBYiFqDRvLQ+3VF5XaFBf175lzOmTbDOBtwTvtcS7X/sevMdeH74U4
	tynV++ebOEANKKRdzmEmzRzTVOg1i+eNxeZczhh+y21q5q9kVlfct8vQ=
X-Google-Smtp-Source: AGHT+IG5zBVAGQmxlTTJ6AsyIlTLy0bf8s6jLaFVyhvoZyxCmuzT2p4uZahKRGszH7iKZ7SEj7y2sKZOTvLfKmWpNIqhm5ljZnEG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:39d:4c8a:370d with SMTP id
 e9e14a558f8ab-3a084933c7emr29500795ab.18.1726150588064; Thu, 12 Sep 2024
 07:16:28 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:16:28 -0700
In-Reply-To: <0000000000001fdbd80621e28ae3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a172110621ecc009@google.com>
Subject: Re: [syzbot] Re: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
From: syzbot <syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

