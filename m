Return-Path: <linux-kernel+bounces-299290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5764495D25C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DA02822C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F818BBA3;
	Fri, 23 Aug 2024 16:04:43 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AEB18B466
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429083; cv=none; b=gUxKuxz8eWBFuuzQOskhhPiOexjXjEjU56N+vgPNBUlZoVK7tXeNwJRIha1dJrcCHQ1nIN40qxRthAHJRuO225F43oP924pN7BQYJk1KaLo9/jO8SS+FsZa+aQws37+FtXVfjHvq4waLxrDFjoxFPXdFA5ISkLwWesMm/9hU82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429083; c=relaxed/simple;
	bh=myxzuBIwG2Mo0coTeeYdtFic57FitjVELZpP0iplrHU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sn7Dn8/SIj3yMGpDwkYraRbYx6dvIJDf9aPoMwWUOUUbmOIO8eOOL0JNpwGRwTn0NOdcWxOxdjaWs1sflKOl7q/j4UuY5tsP1V+wq5SeEt+UHOUJXZoSZP2wQCsDnZhqdTbK7its5vpj4bv1m7GrKUsu7tAcpL5ENEMYjvnq/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f9504974dso192936239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429081; x=1725033881;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myxzuBIwG2Mo0coTeeYdtFic57FitjVELZpP0iplrHU=;
        b=XYe1Te7PCCp7GYzgPX+82jfiWX44INaUtUxXIw5v6btw2PYqMlNi0YkoIBXy6ZNqDr
         y5RWSpk9R+ap1j6Cxp58lr5lKDcZg0k/xKHuMZ6fG2P6gVuulcza0gq/KXlfhwrmdMH9
         NtvTgijXKJ5hYN7lZpXb359noMWajgCs49BKknCL8MDMa0G8Ii5Hno1IhJs1yP3BVayk
         iXSUKhDGRi/riMNgng2dhvyIRYIHO9dLGP9U38BJb+3FzkFFZmauajc4K9S8Ns2lLzcW
         sKa1jdfxb7/BASIA8LcbW5c4nuzZ1KAtCuAOhkvRNk3tBZuA5/hI/T7qAv3Kk/tEWjHw
         euAw==
X-Gm-Message-State: AOJu0YzpZbBB8VBOPCckJXyvnGWkceU0kIrKf9I/sVvsidjqjHWvJcIt
	vUiwNuZyWsbOIByi1vkJ76Z4YOZMYNwZ+N24U0Qia7bqDdEK33r20SJuBACZCV1n/mF8FXiQ/dD
	1GlVVPh0gKPlACrRU+hercbpwXcCp9VGRzQvaf1/Dd3OoB5vV0oKet1g=
X-Google-Smtp-Source: AGHT+IEcqRoC3Lsbae2YHIsUknX1YlJc7v17l4QTKwe/l+virBh6Tuz8g/OL6X5/FzHVP8HeTS9K4OGskHFsqSzXYBEd5sTRGHML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8904:b0:4ca:7128:6c70 with SMTP id
 8926c6da1cb9f-4ce82b6c530mr86089173.6.1724429080855; Fri, 23 Aug 2024
 09:04:40 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:04:40 -0700
In-Reply-To: <00000000000077d29606186c5e99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce165c06205bee98@google.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in decompress_lznt
From: syzbot <syzbot+39b2fb0f2638669008ec@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: UBSAN: array-index-out-of-bounds in decompress_lznt
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

