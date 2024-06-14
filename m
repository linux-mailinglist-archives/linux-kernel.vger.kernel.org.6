Return-Path: <linux-kernel+bounces-214968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55444908CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698111C25ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73098C07;
	Fri, 14 Jun 2024 13:51:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2879CF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373064; cv=none; b=U9KLr9r1vLa4vnYIbKqooQkrJ5rkqajDRa4xqdIzkBCQeSyIAXlLbVxCWAuRfY4lzZbWEej+0fM/fqPQhl60dUYt6TExScVkwKyXOWNlzttvIQ75LxCBQpmIefnFzv+Oc0WJLcRtHtpaWWShNTCORgojjVxGPGdkqcoNq1W4A6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373064; c=relaxed/simple;
	bh=+6DR/pJomE+6dtB3kuMO5pmZrhTXwpqpmGPrDFLpGXY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WOywU2R/+xKgM4M+kWg5z2Mmz03HqISbZCyIWRozQn4nvtdZWue98Rhtr18UIN4K9MeIh66u830jYRnRMTd25C1EWPn7JN8GQc4D6Kwh5gJ7HM4jjlOBx5uvAJf8Sh+a2Jx/5uhz9mgt17SM7R3rqO2f6JjlaYqdLjdqwKYmr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb73f0683cso212074439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 06:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718373062; x=1718977862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiAh3e/a7oxd1QOn1qlvAXctsN4zQwJRgAEMfeD8KyQ=;
        b=IuIyjvDqDh/cIWqws0z+K+7eWHn0JhZgQH1pIGLOC6ENxnNn5yex6ZaXC+qVkERwHf
         rRnt5OZqtgOEgI5Fkodw64yP0zhaDlbPlEyboMpj8Pv+Pv4egmehpisnhaHRUvVbT/OL
         IyJRNbi0gX5iAJ7BEoNnmb3+9v5zI+UX6NDZGApIIISmy6zt9cOlhSx0KtSiq35gBGLw
         xELs8PNV9lYrAzBjWxiRbfzn7KmM3aScaKeE0D2Ej0fvm295yuMhdKWaK3uBiw3bCf/A
         MAWLOkOGmX/Siu0TiTafzqZJPbVqwNVDWRZ+A1UpHtNynDx7f2HtAsZw0JCLjXUw3qni
         btKw==
X-Forwarded-Encrypted: i=1; AJvYcCXN+qtSNe40L3ECXVQeqkLHJ6o+Y7R09px723oZxeY4pRjSWexvIZ3NIlHq3cV/lueq2TKu9Qsl03+OkBY87xE60fbK5PrudRmS97qO
X-Gm-Message-State: AOJu0Yx0dnCga6eJ0gde8+WM5NAzaoFAYEDk49fpVODuMIDLk+aXeiSz
	x1Pwa9vIiqzwc+lpt+HZg/T8FXeO7Rj3IHpkoBwTNKUjzqpt6ylkugbylZzS3vTFirhGFd+tlZh
	ewDNnAB7PSUyUiv+8L4jc59xDNPs1TVvSAvY7MCvUxgyGTGrztbpQLu4=
X-Google-Smtp-Source: AGHT+IHen7M/XVIMESwQ5Fga8IBRUVc5ttqAh8dQTSA+uPwSB66hYAOximAkJ4BoYBMOPnOh2sSEu4VAHaxXE//7IBsVRb7Hu7Xa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d81:b0:375:a3eb:bfb5 with SMTP id
 e9e14a558f8ab-375e0c7409amr1449295ab.0.1718373062176; Fri, 14 Jun 2024
 06:51:02 -0700 (PDT)
Date: Fri, 14 Jun 2024 06:51:02 -0700
In-Reply-To: <20240614124811.689-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f68397061ad9e77d@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/open.c:962:45: error: expected ')'


Tested on:

commit:         83a7eefe Linux 6.10-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b61e46980000


