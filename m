Return-Path: <linux-kernel+bounces-320012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 716CD970508
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1002830AF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF303715E;
	Sun,  8 Sep 2024 04:07:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B928FC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 04:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725768425; cv=none; b=Au+/6sdPIb4AmZ8uHow1LoZZdJQJh0UVi5JBiHemq7GeHFJ7ff2WQpdbC/WNPCo47GlbaY9neEOj5mgh0bm6jwGCVMDanC3EAMU6pPn5EMgm5Wjg4kniSIm79AO9wQJwwuKaWo/8NQHo3UXVLsRoW49ws8yKm7abnU2DDx9iirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725768425; c=relaxed/simple;
	bh=klX3N0HJmGDDWAYFlKAffyVuccgTzWS6L5grL4Yse1M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ghdskbVC03+0BFqkCk8XPBum9i+T2YkMyNQ41MS2iL9i62tnqLST4ofGUdmN5oYU4J5XSNauKlBbro2a2kQC0wI+FUvnRWwLSy6id84YA1HG7Qp4ogVyfcM5dayFomwgOvvz3jotJjMa0Yc0Kuy4GgdVrpnAYI/pMCSE3b0/rX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82ad9fca5fcso127038039f.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 21:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725768423; x=1726373223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dF8HtaJAB37nJiTVH7S4KIuA3PLW9CXtv4XuM4V5pk=;
        b=M8UqbWDPJ1Kf0qyO5oOyOFZnybHPn+2yhf7VfgW8ZJMuzSg4CqWAD1SzHnEsmYeWcY
         8cDL7ekzUhN0LOFdtCxqPTnylxC6it+OHaDLBgEJ40zoO0kaE1JcnfEczZQzh8Gt1Nvv
         CAGs0DJgGhYmgUoCMEKAIoUvtHY6frPSQ+DGQzFek1mBHrgRWfYbAWgmmxWDRjyrxfAU
         vhkVWKW4HrR/w4DDIcQhVgBjzsxhLy8asnA2dYaZzYRrn74vfGMpaDPwbFE+PUcufYlH
         QGNuPYbj+Q3iIxkSn+Py4WnrcmCAcHLzfYfT6u8NYzbD0xZDyFuYM4oxaVPPjnKcEW9n
         KWrw==
X-Forwarded-Encrypted: i=1; AJvYcCVmVXf12ogLVOCB/t1vKY6oxF0FbPUgrCXUe/lIDtDLNLYkJngXxrfLKsBY7yArQBCAc6sPbsI0jAnmyC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQw7u4/T0z/S+bdRJCqAIYBo/9iKeRQOiBiFrQLg/eXDO+FdhK
	LuWyjOMA+LnJ917m/xusv6r8LfimJj9apQJmCjVDREh2cnQbwbyqn8GIlHej/o3olFITP3Q+E6C
	xbuZxaa6GFBadW4WmcafkxcN0f0yb/f1Hi4JxlkAb44oGTt5whln4Aus=
X-Google-Smtp-Source: AGHT+IH8omUymT/OITzvTzD9UkD/VVvB6QMVTacgFHYlF5HDOwj7xcM91H67DH2obQ+r651aqYqGf9ASO5mzuhhUHcdInPr44DzS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:3a0:451b:ade3 with SMTP id
 e9e14a558f8ab-3a057462029mr46846495ab.10.1725768422864; Sat, 07 Sep 2024
 21:07:02 -0700 (PDT)
Date: Sat, 07 Sep 2024 21:07:02 -0700
In-Reply-To: <20240908032540.2276-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf49fc062193c58b@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/bluetooth/l2cap_core.c:7595:17: error: invalid suffix "cap_conn_put" on integer constant


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137def29980000


