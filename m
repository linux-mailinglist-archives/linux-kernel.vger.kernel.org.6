Return-Path: <linux-kernel+bounces-373183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE179A536F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBA61F22044
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CCF83A19;
	Sun, 20 Oct 2024 10:08:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC902BAF9
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729418886; cv=none; b=AxdW9naPko7aOvnsVHZZRaPrbX5vyJ96aPsDaMiuaXdDiJDsa9dfMysAIFxWEiJ/2uPKzy7CwF8yIe+CXiXA9GG/tl/1NXL9T6FLUWVL99LLiulV3T3UpvpSsXbHWrz1gEhucOkboR4eDlW6XwjgJKp0cVW7saFWSOpuNC96oZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729418886; c=relaxed/simple;
	bh=QqqWWdK5oRqdeOqWHtbZ/WMn1XhxH0GF6hdq+17CIxI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q1HKxEDUhD2dGUmSrDgsBA420U92oNFBvgWiqVeJYRUqwVdKnXELX8PYm0s+7W9V6uqIhMCnbejZVGnDPnj7yzbtHxbUEMBty2WKuR9As2ApD7N2USiDYCqPEdtZ0MDUOPnrYxf2huvLVHGkCQ38N7BfanjSCeDZM33C1ArB6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c70e58bfso28236535ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 03:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729418884; x=1730023684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jN8ckLTIPTUwP25Ye31kzu+M+HZrMXCNwC5b24P98sQ=;
        b=eyLG5C40xYd4YZFmf1IpImXCRs1PthJL22eRMv7hS+eokJfmXeOBhN4R+4bwJkSIOO
         JEgj5eWjikDqX90tva+pO2qLBZ09YafLMvTsw0jeBMI2ej4Psaw9dA1jqNuJuJR5c5X0
         3W3NSijmW+CL9Qk2nAvD424CJTQw0/6DT9+QT/wzGDG7dr/cQO0mich5k6kZq51iwt0E
         mlx2uYJ5x1TixcMoRwf5FGlyKq2XSSmMng6v98OpA/dZyTK8cuHijHXFrhEMpt/uQje9
         7PC8O8hU1h3UK3FnM70qw2AHsi0IM8Q/XRufnY3Db5911cMXJ5UyHc+Gc6sSIY+mAOuX
         bP+A==
X-Forwarded-Encrypted: i=1; AJvYcCVy4aQ3/hm7wHl5DK5BmeYUa/lPenKNJ+t79O/4mRaIbw4mqDwBAJXpaYZkezA/qsHsQlBt94aG1HBbQjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoy1lPeNGe6v6Q3C4FiCLYvkdrugIZWqQT+6Ou2oHGds81YdzL
	gTNmmiZT794RCRW88ogO8vYZIXWlI7UkB4GZ3YXOVRs9qdJmMaxdEXvC3DzAwNg8woOcac1R8Q0
	+7GScH24TsU+FeQTXfA6pAbW458QEvkL1kGyS4plbVs+dxBq/F+efuXw=
X-Google-Smtp-Source: AGHT+IEadGs/x7MObHoL4gq6S553k8y/+iM/aD2Cdp2VEjN4zq/jgI7Us1oiST8cAPYTFaYvlo13CkprghfFIZss+cIs1C9XrFfQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cc:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3a3f40b1441mr68491755ab.24.1729418883552; Sun, 20 Oct 2024
 03:08:03 -0700 (PDT)
Date: Sun, 20 Oct 2024 03:08:03 -0700
In-Reply-To: <20241020093903.2182-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714d683.050a0220.1e4b4d.003f.GAE@google.com>
Subject: Re: [syzbot] [fuse?] kernel BUG in fuse_dev_do_write
From: syzbot <syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com
Tested-by: syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com

Tested on:

commit:         f2493655 Add linux-next specific files for 20241018
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12852430580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=838d70a59aaad5d2
dashboard link: https://syzkaller.appspot.com/bug?extid=65d101735df4bb19d2a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1323825f980000

Note: testing is done by a robot and is best-effort only.

