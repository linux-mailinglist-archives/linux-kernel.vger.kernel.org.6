Return-Path: <linux-kernel+bounces-254730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF6E9336EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690581F23C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EC315E81;
	Wed, 17 Jul 2024 06:24:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BEB12B6C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197464; cv=none; b=iMYD8oKwooDihAFKharWxbGWoVdXXx+mbbJVnZ4/7f8SF8tbfVe0WYzZgHiwOdL7AssF8fZOI9zmwImH2E/zyJ2Fvq6z3lfV+aaldU1WKpwA6/HxEPDWL21kR6kH60udRVY+YX7NQU225acKlgQ+fl7elpE3sOQ6KJMTm/A87zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197464; c=relaxed/simple;
	bh=xJghMIDSFZMQwcT/bSxKpvABpwSoalmPwzGjPqwQMIM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fapyViqKLJPhMBJHtpyBsjyZhyzjsPZDTUWU8KdMTnt7girVXgloZpGu6/hdWhNzWKGstgWLwnPM35QTlPCc0Sn5A0xlTkEhrU0kF1GdWvYZSzGhI+AsTPHHAuyVeFY1MZxa8FVex1C7jlIdciNDIfLmhGKP87MVj8gkJmJsOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-382e66d79a4so9244505ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197463; x=1721802263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0Nn3s13nczj2fIBPcpMuDTEigrtwN2HthLoUAG4F7w=;
        b=q46Kg+FhOoDa4HaOKiuuIGupCP2ukZS8YR9Qu0492nMmGSHeYC4Y4peO/tUT0zI/O/
         7MML6crvIvr2KNkcDuHnOuhmPrtvkm43xszLJcptO7MvZ1izP3InBqsc+VcuvKEdioCc
         7NHz6bW0TluTJTWYwJgvrCONLzQZ79Yoxo1bgv0JyLFt1oHCpj3cLQUEJhAWPq4Ii+iL
         4HEqVQioPXKU1UcSuKKdNd1QrWDlyPDgGsPVHXFCJOd+3OeWmRNmEWEE0bUGL7h1a4Ed
         qgIliQZBKSj1ONSdR41/Af2lBkOyVgMdHVOg5t2mQ9bL6rl2pxKQys7X8lj5/1s0Da1L
         xHhA==
X-Gm-Message-State: AOJu0YwVj51bh2gQh8qX6Mp329rgNucWEJSCgV4Tyw/+o92FF2NueN7w
	p76++WUhgbvw2pil9qFR9/REWmErGrGDJXzdvBgznn8uYhwG16HhCi0nKYaY5bBn2lt3MY4nGXw
	/PjNyo1D/W6uWaNWQHxGNaYG3j6aTEy0MaP54f/4+DQe7ZkNQRGEa5Yo=
X-Google-Smtp-Source: AGHT+IE6QJ0/v5YV+rCMt/sV6/BfPeTLhjTleZGm4wWM9J5kefRmV4qJGJwCFfbbRZIIfZN/Vtod8CnO8oVA7YN+3hh9MbxDBio9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cb:b0:380:d109:9abf with SMTP id
 e9e14a558f8ab-39555800cddmr977325ab.2.1721197462712; Tue, 16 Jul 2024
 23:24:22 -0700 (PDT)
Date: Tue, 16 Jul 2024 23:24:22 -0700
In-Reply-To: <000000000000ea9fef05eb3621b6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a8530061d6b83b1@google.com>
Subject: Re: [syzbot] possible fix
From: syzbot <syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git 
d57431c6f511bf020e474026d9f3123d7bfbea8c




