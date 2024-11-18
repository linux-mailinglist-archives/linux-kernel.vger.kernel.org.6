Return-Path: <linux-kernel+bounces-413531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CAF9D1AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6665F1F225E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B431E47DD;
	Mon, 18 Nov 2024 21:37:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B301DED7B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965826; cv=none; b=CxJZNC0BHSJEsVr9WB5erUZEwce8Zz+OBopOaNAnSkjaPCuEQ1uY3uNxIbngKgzIy2IBSIRvff97pISXC4ej05IGeIiz7p8a5CeNNM+cOcLd0uI46WMN30XDZwqrqCGMOzFUeERJ1yYpHUbXLko7pJ6FrarMX+74tAui+8ijMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965826; c=relaxed/simple;
	bh=AD8RL+a16qS304XyMe5fRqoLGy5XqE4pyAEjYUVdeB0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aMZYf2fwPCF4yA0Lb4ZDXXf6zRNeACeRbu5CW/2jlVyatJa8S3iJ3yJQlDEWRRAYvlcWeeGkiYBQcPEx4mdba4F/YTu5qNOVuWynhYlWhfYr7TZ+dHX1vTI+s9/ZY3vP8p1o9pv2LRdKQqOAadF65yXyhTaQZeb0IJ5CnQENWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a76acda477so15337715ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965824; x=1732570624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nICKXi7/BY4L+b4MgIKYet21aV0bch1WeZjTtJNx1VM=;
        b=hl66n+EmBYqFLrhx6a1tmXlq6X3HoNNT3dXYuJ72UBVeMhF83V1/wejzXv8gHDeXnl
         Dpnq4Zs4fHoYXHTv4LvSRT5y2T05XDnGbdyYO6TFQiC/hvPKeKKyuik84J3PwTcEn4i8
         fDfJG0guybLcjYOkycBoYIXVGKDmIW6iB6ea8i5nIVdOktuNMjWgTQ/FiQLoqJQ+QU6P
         0hhREpClKr0HFYL/0x9B2zqnWLDqv0sJBHPCwY17c/r2XcKoPY3QRv4qK31y7fcse0H2
         iu9Ghd7JVAydukUD4/GzWZ7CASWDZZDf8N22a1XiG/vcA/bLwtfkcnNs0FFPjmvlne+S
         Sq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtfMTytkfu6ZaMJOp9dVmt+qy5WcBIMR6mxFBE3ELk48STCq8IgG1SBpI53l3iLzR8s6H+sGJvAr/ydJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWxDsVa+fiLbflxSMkoViSvfrznIuB9wjniYzK+HdZqsq+BKug
	+Lz4jnYVmtwLdnurrycUdf34AytR8uLTT9iz6n1Y3UVBB7cY/l4lOkSHfiTBzVliYMd9Xluumqy
	HZTCBicjCr+x42ARe/Ai0wUs+O8D05VJO9O9Tv77fuIVYHCpxSQJ+lWo=
X-Google-Smtp-Source: AGHT+IGJW+n7lvA83sJnLZWBSzq5D53guT7v7kIGh3rmiBABzveN4sxuyZ+8da1KEFDylZ92PG81tcaxMFqjeI71tSx+BKKbO1L+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2d:b0:3a7:74e1:d54d with SMTP id
 e9e14a558f8ab-3a774e1d777mr22152385ab.21.1731965823827; Mon, 18 Nov 2024
 13:37:03 -0800 (PST)
Date: Mon, 18 Nov 2024 13:37:03 -0800
In-Reply-To: <CAHiZj8j7dp5L_A_nvN4zv9q9qH865MDhhzgEgtZUBMq9H1gPMg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673bb37f.050a0220.87769.005d.GAE@google.com>
Subject: Re: [syzbot] [keyrings?] [lsm?] KASAN: slab-use-after-free Read in key_put
From: syzbot <syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

security/keys/gc.c:146:40: error: 'KEY_IS_DEAD' undeclared (first use in this function); did you mean 'KEY_USR_READ'?


Tested on:

commit:         9fb2cfa4 Merge tag 'pull-ufs' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=55f8591b98dd132
dashboard link: https://syzkaller.appspot.com/bug?extid=6105ffc1ded71d194d6d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1781eac0580000


