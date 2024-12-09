Return-Path: <linux-kernel+bounces-437948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D99E9ADB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F3A282DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C384D2B;
	Mon,  9 Dec 2024 15:48:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF627082D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759284; cv=none; b=mDmOcjAuqT/iT/NT0uFtkPNSFVH4A/mAPacVmR0tKJz4MsEyzLW9yDtASDSJ36QdzEXGQOvOWZ/jPSKuY1tDUOs2GOUUb0j6D+t8+8+g8+yFV3lxzUmizE/VvtkdtyluetUwxqf/D9mX4YPONOSb7KmcMsvJZFkqX5JmG6jGVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759284; c=relaxed/simple;
	bh=2Dedd2vUs9wtEkS0vodNwo3Jh1txyu+cCb548r41asA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R6GHO1OOXdbdPH/Na6RHS4uaMw5FnmoPk5Sh8fWsNMHA0Sre+IlHxytAMjkFSmu9Si+Keimrl5UcTknFGwglH7DYQKfHpmefhwb714drLCfyj1a0u0YXPSdFv5krOHOhLPA+k9mI1OroyYalyUjsiYNXhWHcSv/FYeIsseY6BBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-841aa90930cso412139039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733759282; x=1734364082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tF4g3pt7ky2erV0F6R9jVr8caMJGAFPxOtEHV23Ad4=;
        b=CHxmmvKFFQ1r7xHONFRDgmHrOmVO0OpCj26I3Ri7BL3GrkpHLo0nzxmFx68Zd+dihQ
         ptqCVziYKKOuTOMCAdQlnxUO7oa39r/zFNizOkkLsWmCOpBlzcWzZ7Awa4w+TZxFjlAl
         oMUStgo7V6PhcRMFAEUgyHRvo58aTkF3hqinzvEeMzdnNIvgKv3jRDMhXdCsaOltVAEm
         vDNL1OqaxQrJn1zpG8VaOkDmd/WTRfU77VPUcWqyZdpZZPDmGU865dYaqALTom+wFw6Z
         /Fx5IuZex88ZOXNg/jXlA/Px2v2UKVuvftABF7PQiD4EQ1n3q0EJenNE74YYpWy4cvnE
         +BVw==
X-Forwarded-Encrypted: i=1; AJvYcCXdgIyTIzb14tGofGCkWEJp/Oomud0p26PxQPO9WmX0aCW5H0B9kbQVDD5z1OEGtwgR9UoXNOMZlLQKqKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1cnaZU19cd01KkJo/58hfomDXsHt+7hdNqdcengLBZAbAyA2
	efGQgKXX2vORcUzJJiO/0RCmwtRyo1l8BVjfkiB6dDxPCSDg6hKi+0PV7+IK84RBrXJq41C5CXA
	lq7a0lu8L0iaES34UWkc6niPp9/RGjnVHRj5xdv9jtLA9J/khG71StOY=
X-Google-Smtp-Source: AGHT+IHN1EMFE03sgaQqK4y7BbVOLdBHTae2KEnIyygrmJwPzDii8aQ5fklIsfK7D8aVF8hHDayL40VUi8dbax5ZXENxxSpFylmm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1682:b0:841:a1c0:c058 with SMTP id
 ca18e2360f4ac-844b51b2564mr112146239f.9.1733759282294; Mon, 09 Dec 2024
 07:48:02 -0800 (PST)
Date: Mon, 09 Dec 2024 07:48:02 -0800
In-Reply-To: <2132559.1733758162@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67571132.050a0220.2477f.004a.GAE@google.com>
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_open
From: syzbot <syzbot+885c03ad650731743489@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asmadeus@codewreck.org, dhowells@redhat.com, 
	ericvh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+885c03ad650731743489@syzkaller.appspotmail.com
Tested-by: syzbot+885c03ad650731743489@syzkaller.appspotmail.com

Tested on:

commit:         fac04efc Linux 6.13-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ee54df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b041310d53c18b96
dashboard link: https://syzkaller.appspot.com/bug?extid=885c03ad650731743489
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f654df980000

Note: testing is done by a robot and is best-effort only.

