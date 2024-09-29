Return-Path: <linux-kernel+bounces-342741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180BC98927A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 03:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38BB28539E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 01:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B39B665;
	Sun, 29 Sep 2024 01:32:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31F1CD15
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727573527; cv=none; b=dm2uMxJE5G5fJwo/Xq8G0W5JU2cCDvBXsW65icjOc6q7JFP5rNDRGz07HCRqEeFzPr7CFOuaqEg1v1Zwr4NCP1pQoi6kurzrOClZJI+PPzkvyf+XmVOzp2zTeuVfZs2C1NEM7LNk3BZ3vEkaVXsmGtdvEbSaJBeND8rwDfYIDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727573527; c=relaxed/simple;
	bh=3q9spC/BYH6lGZ1EKzMuoZyrbYV+N4gleC4Mp67gnR8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WZevBb3xnTdRNzeaTXGAfmZ1z9Spmn9IjDFzg5VEtVwoh5GEzXIcyU+rOsCmULMrjmii8XLWjk7exKwt7rjyFuwRRKVxXZakTP2YnRV3pHIfgwclq8cveGGEm5aLyGNUtKJTUv1DC444ujhRcQbsImNil+loaac5vinYGle3Fnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cedb7a183so385524139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 18:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727573525; x=1728178325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RifMO2rO2rzmg1Dt6pWPzsNfA0wO6+U44TE+I78Cw1o=;
        b=O46UrSKWN3moeVG6rGc5KW8eMBNg0jDj2JJtKmyRQ6VQQMerabUwYnGXSnXcMnhBq4
         Hobg8ODFNQTKrS/qi0JO9osONah3BSKBXXLa7Uhrlxd+dtzyJOz4j8+8SAW6UDxppVM/
         zLkNr1Xw3KH1qhBsYjbktoUcGHEpQtO3Yepu+Uz/lmIOWMeZEgnT8oPNxCldTC4sA5ey
         RkkE1/Z9w/O2AImgq/PzUEtN0B1ulISPHRwUU0y5JqcqE1g1j5jXgMSGh0A18M5rZbi4
         vidEOVJEmhyFW5GuIa7uNMgjMiuaDykYLkZ2boSue9Cao/G9U+PLgkt1r65bGKhY2MSK
         +Z1g==
X-Forwarded-Encrypted: i=1; AJvYcCWXZYWT5o541rnd4sfts+xMnbeY0V6VpO/E0pjEHFj+qXDnn/glReDcwDDjJzyk7zoAvWTb5LxjOKaNjyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vBr+UbSiJjDkc4M93IYqY+vXCzYt8hLvCVx+7qKqwFStPX51
	USG7ZwGco66FbmPO6AGntsTJrr4Rb8Gnz4xtr2+wyutXvZk9bTjWhRX+AplhGQsH6fizcZq96ao
	0XZf+5NIc5dPl0WrLoNR4kpnbIV6T4BFNZhD2xdT2oL+YBxUWqQW+8K0=
X-Google-Smtp-Source: AGHT+IF/BTOAKowJIqs7B1vHQtH+HUxZcAQcJM6r0/G8C/zrz3+t0bh4J8rv6/3IMa6epuIc+hntsF6737VF4RYQTuQ9woEsXjBA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:3a3:40f0:cb8c with SMTP id
 e9e14a558f8ab-3a3451bb951mr64932965ab.17.1727573525469; Sat, 28 Sep 2024
 18:32:05 -0700 (PDT)
Date: Sat, 28 Sep 2024 18:32:05 -0700
In-Reply-To: <66f8a340.170a0220.2c5856.ac87@mx.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f8ae15.050a0220.4a974.0012.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
From: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
To: andrew.kanner@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com
Tested-by: syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com

Tested on:

commit:         3efc5736 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10fca6a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=682609d015fe2e17
dashboard link: https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1118b507980000

Note: testing is done by a robot and is best-effort only.

