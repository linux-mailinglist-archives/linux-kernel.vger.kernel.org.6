Return-Path: <linux-kernel+bounces-260247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C893A4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FC61F22909
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF01157A48;
	Tue, 23 Jul 2024 17:31:49 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079481E522
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755909; cv=none; b=JdybYylLwQ3i9EjkComDJVXasoaKQJnVLPwPXWR9TQs+pA5BBZfCeo76g8+Vz+5yMjq2koO1u50Aw20B0Ul98y8HmPumKCLDSxXJmnE5jcvrCjc+/RQGHqZgCGxlZNm4F/md6fkCaxQu0x6L4BGKN1foOS9fr5HI9Ea22R4QxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755909; c=relaxed/simple;
	bh=owk4g2otJ0Q7bo0nzbZd25kaJTzD/DMigYqW9dPCAYk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IL58RIh0WkZjjSq7aTqrbeH0mcc/vcWoj6UsBWN3pVsAx6flK+zI4LkdYIoZCCYzdsVa0Fo465OdM6jkUQB9/CdxW5aO+bUTZZgkgn4odnYyxlnv+uZZ7fKWRq1tNa0fawgS657EgfEvpy/N1h+oyIvyFniOxMIjR6AA52VCWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8041a66f2ebso908977939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721755907; x=1722360707;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owk4g2otJ0Q7bo0nzbZd25kaJTzD/DMigYqW9dPCAYk=;
        b=pKz5qz6F56Om2lbB1giiYEqMqLJUpNLCqJv8OZECstc8N3VPuh0m0up3IuCBpRzKA1
         IxjZ9tzW4LqrR/YgRLto6tGRb8zvT9NxE9oOiMvcgTPcVJBawl2X/hOvYa7tUYlGYxiW
         hqj8XqUs734d6XdYQAN21uTWRIG2AV1KkSy/x93YxnpMDu7Uw4T0PHGMZHH7wwFSJ2zd
         /iYhw6YT8b6NrHISuLagSTfPp2Ah7gPx0gqWyEa1Zvwe13hB/stVeaO5SHhUpECWNhhy
         3wPw/fVy8ROXd0EIxeRSXPJdfgXv5OABLeSpLC3wZQ5uUpaIrZHBVwaWCfMwqDS9Mw2Z
         zsfg==
X-Gm-Message-State: AOJu0YxgGGSazIjTNWP/e802pjlBjFOoOGhBOKzbvrasS9Uhph1SxAPa
	y6p0d/ZXKJ4sV6l7DPwyveMVThLvy+c+27FlYReR+La6hasGN/6D9aqSgX8/UdDFzDvqz5JtMjY
	yX70KzHr0aDJgg1t7Co9H0MNYD+bR9LSobrtmNnzxe1TyhkLbtgWzGp4=
X-Google-Smtp-Source: AGHT+IGgva7BrNAntRRVgOypao/6E6gGk+KP4wvH0gh6YNkpquUijpORLbCP9IAZCWOfPWNwW4fxxU3FPxqlpVA5JryMEF1wIXCj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2bd1:b0:803:85e8:c40b with SMTP id
 ca18e2360f4ac-81f6d23e0e2mr470639f.3.1721755907224; Tue, 23 Jul 2024 10:31:47
 -0700 (PDT)
Date: Tue, 23 Jul 2024 10:31:47 -0700
In-Reply-To: <000000000000c396f805ef112fd3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d8bad061ded8998@google.com>
Subject: Re: [syzbot] hfx: Initialize directory subfolders in hfsplus_mknod
From: syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: hfx: Initialize directory subfolders in hfsplus_mknod
Author: simeddon@gmail.com

#syz test

