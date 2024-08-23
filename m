Return-Path: <linux-kernel+bounces-298592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF8495C92E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B53E1F24744
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A314A4C3;
	Fri, 23 Aug 2024 09:26:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23414A634
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405164; cv=none; b=CJjPH5UeATBfl6o1fFh+lWDGNhfy7PUWQ4vgAK8LngH7MJ0wNs9cGzP9WhYduUj/0AHnct/vklP0i08i2NAPE1qLzj9QZP8ADmKfEV+QN1a7KpZlBGRMcKa+8vT6l2VMNSkMZVaRC9E/KBNRWv3OSYZriZmLuOJsVCfUZKcTMX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405164; c=relaxed/simple;
	bh=bnKPLzvdn1IIvW3cRedJY3wi2FxEff143T+dgpV8U1E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DYEh55I7G0GBJGeJ8Z6m+mELKxvDpq+rS0RppBgQXsJ10Y3x0BhS4/CIkZ5gzwFGrXBERVL7KVxFwvFNdsmEvps+dmWGj+n4UqPG5NN9BhrVeqadFyPtOrOgu56KKR6LX3Ba6cQVUWoVmtiwreDnfF1w8sPJvT2x5C7keTiGQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4c656946so19062865ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724405162; x=1725009962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj5FRPunPXg+GOvLH34rnKhn3AXqvTWV4s+3rx+P31w=;
        b=FnvByFeq9hFvSZ5p3JSAEBPT6q845y/Wr6Cr8HlAWprlkwQODpzB4HtVyjb1x4ptl5
         enzZCGlUx8Obzq1pZjUqtDZK/1yxAHSscNhHFbYM0S/Cc9WPdo3oUx//W5PM1gZvkAAt
         ZHbTyQlowT1ICrR7Cjg1Fpn5ie++AV93NFQhYeSN2FJ6QG9HZzRO0XqznfAFYS3TpEhe
         SIMkWprbHHp9CXZ8evy/7QLO/cqMmJ7NJ5Z+j25P0nmtCBtSU+zqCR1MobUnLKSy9Gi8
         hnRQfKPurm1ms+Uej5ARyhA8A9lOQ5u7+qrUqbBeXj5Fxo+U1V7VkplD5UnqYYLNma3V
         BLPA==
X-Forwarded-Encrypted: i=1; AJvYcCXuyjhYcpXeQ8HLY0vjARLaq9p/yXf3tYNxBQ1qRPA+bIr+E7d/fZ1GZ7GLC6N2PSqGoLuw25w7539tJk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxobsnTnP9xrvflczHxVbo4sjWwN3JtDVIFNH7f6tcXb+oSvY+q
	MfMFYeyebjZuvHttOtxTue4+w/xDzAhW9XKM10R/6zxzbe1v2e869EJb+KOBYtIahbPXnVq5aqn
	wpvMvRJrscI5I16WZqrYBhIdUdi6ebOQ4qC+y3WUmrM+JPCgXEVY8F+E=
X-Google-Smtp-Source: AGHT+IEa2BS3FP2XA340VVTPB8MTr+VD6fGI6JWWn1x3qPMz44PlcTbTEAaVHvf2G4JPleIu4FbVB0+p8TSzIaMygA1W1WcNw1mO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4b:0:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39e3c9f5955mr1075175ab.4.1724405161846; Fri, 23 Aug 2024
 02:26:01 -0700 (PDT)
Date: Fri, 23 Aug 2024 02:26:01 -0700
In-Reply-To: <e80cfc67-ff1c-484f-bf42-8c9d72408c36@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001efcd70620565d36@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com
Tested-by: syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com

Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=164f6c33980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2fa1c21de29b7e1c
dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

