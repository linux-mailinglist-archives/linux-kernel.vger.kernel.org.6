Return-Path: <linux-kernel+bounces-282223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1294E108
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E5EB2107F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8328481AA;
	Sun, 11 Aug 2024 12:09:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A43D97F
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723378144; cv=none; b=Y6t+b+Z/Ned6DvLehnQGFi1Qj/e2Np5QHGuF9/xhWG2dCXRkdQrm5Chq7zAiJCyYLIxKrD35J9JGEJkoCEgyM5SfbQBjpsqKqbo9D3tx6E/vBWY/AKuqGJi8Q0i54oye2g22K1pe2zDUV1vHlddD21pb8LZ+jSwD/hT7jvmU0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723378144; c=relaxed/simple;
	bh=cRFt/455dtLb3deLpa/GsWxYyr3M9Gzt5NvkbQV/kG0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XN8CP5Iwr+00BYoP8V2TcAb12mxWgJwQpSzbhoQXM3kCcBXD58Hv2C5VEHpHuzua2xH70c+tVzGj8DpawFY1iN/XKxR3wkqGebvXqQGvhzq8ydX5efB2is27YI+GiyNXXQfcdcdjNXzXQrA4fuRO/IabdvhLlcmP079kwrdjvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39a29e7099dso41828655ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723378142; x=1723982942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNJWMSTq7AKne6ddtQ1DuGXMVZvAGrAMay6uEoFIgqo=;
        b=m6NdHezwZHl1Es/w+J1565XdYvpxCPLHi7N8T2765giHWPtYKaAPcbI/LtqRumC3AN
         PZB8KvOaS+0RUqIM04IrsBWwmnLGiUpp7Q0Bo5OHfjYURyLbfcMNrv7zlidrYvxedN97
         uz5ed+UPs4yeXdaeGzeiQ+pMA+pHe7G97MgTNbYCNW1L7LQcUDK6iVHDAbUPuQSPqXao
         Kptvv7nz7V377DU0aj3lGMlEKKlM+fKihKxSw11CjAVYvgq4HDNaLp+jyGBfsii4OgOx
         foAi053GalhZGfQUom3Ba7YDBuCywx7tbYH+3cKe1MBgUu8P8RQSVexjnIvwX3xZyVfa
         xR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEbSsqZMe+uiB3NdffeekxTamurWeZJnAPNdKoC5eEPoVRaFuiEJSBsrcD3aefAMVwfw9BpMeFSn3rR2GttuHPG73iUeqQBW5lF7yk
X-Gm-Message-State: AOJu0Yy4TAtLoYxMTZSN83jvOUxm+ilWas56vk5k6JxTA2x5wy0j0Y44
	WXEwXDHGfjugRIfz2MQJ6MAd6XutGFCTHfDmjKLhsMb0rLCxxN20GbJ0Wo80E3Yxr3VkzOmRTPj
	yQCLsSMsIq5bXLopBSHM0Jx7tG05aqlAAbABe+NicICxW9XYiXg9wI7U=
X-Google-Smtp-Source: AGHT+IFNx+7Qw75X6hLIrMBqd2IogE0yvlL8R4IIgTVpIg5UGYasohXHeOC7X71OpkeJu1q4EXtFmiSKc77pYvKqO6SMksYWOQEn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a24:b0:395:fa9a:318e with SMTP id
 e9e14a558f8ab-39b6c114ac5mr7017465ab.0.1723378142058; Sun, 11 Aug 2024
 05:09:02 -0700 (PDT)
Date: Sun, 11 Aug 2024 05:09:02 -0700
In-Reply-To: <tencent_2006D092E8066B89AEEEC42ECC4CBA27D806@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8ac4d061f673d35@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/netfs/write_issue.c:506:14: error: implicit declaration of function 'mapping_can_writeback'; did you mean 'mapping_map_writable'? [-Werror=implicit-function-declaration]


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c6c96d980000


