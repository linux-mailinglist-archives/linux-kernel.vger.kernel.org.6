Return-Path: <linux-kernel+bounces-539661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B6BA4A6FD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA6B3B60E4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831F8F5B;
	Sat,  1 Mar 2025 00:31:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE1A29
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789065; cv=none; b=mLXXd286aNJ/5XbDU08PF4KkUBNVnJxOyKuZQUaalYyDNI8YGDsGNi2qzpBTkuk2Zh2fFFVwUYMHQoJIeW14X/RJS/EnigqpF4bIUqQogjOwmaavTv8HVzt6ydJyG2+U/VJkcxPo5b/PQ+s+Dzr3IHeIpGA/Wbls3yW9KqZcy8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789065; c=relaxed/simple;
	bh=zYiqoApYTO1d72QOg8flh5uP+GCo/YUcjqlnca47p9Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lY/owi++PIEWg5H96xSWspv9tJpgsBtu9u5j+bZpktycdi9hAJRJZ4czzmnS3kfm7yvVtVnb5sCITREZH10JWV8CEskb2z+ehLzVPC5Hv9BWA7WRlHDp0aOQw4M0j8TYKFjec4TP75WOVVhWRKdR+AZuGcChb+W70O9EN/kWzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2a60faa44so55017815ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740789063; x=1741393863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/dRfXDkbs3xu+jsOQOum5t0Om5w261L5I5549LrZjE=;
        b=DdKWd0SZC8A751VZhUHhdQARcNY7HQ3FmWeiCYFcDTuCdxEkEr2wpFoH24xfRcf/9c
         7mwsDKN6AK7+YGrshFZbzGMb3tDLIYeLrF+xlrN+VFLTGHB5mqk7EyLxQp1nvJyMc/NG
         WmPgBVdAUwcksA6CAzVenfN0FKalN9WuqRCnk+ZYxzoVSykftJZsfx1sVXUwL1IK5pqp
         2zHDaGbBm4ggw+Wf5zvg0ERzD1f2zAjgRUOnQN9OrqeRDwmQdbTagICqYTNbRKnGDgq/
         KelvyVCS5Qocl+tO5+LWljmfpuVnNZu3aB+hlzXvCVxTheBD+qESpRqraPF7dJ6cJ1cI
         XyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAEFbQqTjw7gh/YvimZxrhyq82Y4dBiTDj5KrYh6cpLwQGBzo1FiFIG8igE5txYRC/HhYs/SmdovisP0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YydiYNeC423xWXQ49jaDt7F0N0uUGWNm/E0Wm/0SeleheKDHCpm
	/Yr6aRN2B5cflVUBgaBTbPDrQW1JDRYBbn4fcUI+46I1xuPM+O9MSqyGw3s00+QCGk75TtJYSha
	WgUmdQRs9rIOULZjO+x8kb+trrTYsBSlPqiLaUf3Ft6CSWGnEpiqw20E=
X-Google-Smtp-Source: AGHT+IHkWGxk17Su7Vo61nbJ8Jx/OJ9rhvRwOScut1aKqOiO4dBNROd5Z1j6fDEsvaeyMhoINjq2dtoWsOdb52NhjPwf1/DhTaL5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:398f:b0:3d3:e41b:936f with SMTP id
 e9e14a558f8ab-3d3e6e42d82mr72324575ab.3.1740789063222; Fri, 28 Feb 2025
 16:31:03 -0800 (PST)
Date: Fri, 28 Feb 2025 16:31:03 -0800
In-Reply-To: <20250301000552.2827-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c25547.050a0220.dc10f.0155.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in task_work_run
From: syzbot <syzbot+aef8e425f1a85ee5ef1c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+aef8e425f1a85ee5ef1c@syzkaller.appspotmail.com
Tested-by: syzbot+aef8e425f1a85ee5ef1c@syzkaller.appspotmail.com

Tested on:

commit:         0b936313 bpf/selftests: test_select_reuseport_kern: Re..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b38864580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=aef8e425f1a85ee5ef1c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12132a97980000

Note: testing is done by a robot and is best-effort only.

