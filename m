Return-Path: <linux-kernel+bounces-235840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D65791DA52
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FF428112E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600C839FE;
	Mon,  1 Jul 2024 08:46:17 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421484D08
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823577; cv=none; b=hFXgWUdnwAeEYzBzvjeE9Xzth7qN2Q9BbSeky59ULqXIVbC2X2LIvR2FcNIlXoInpft2MSYs77Onvut5cSbvV2khEDCiIyizrvXSGDMTEbmYsaFWy8F8KPVVzGZLsjw6niK7JvMLInNt/Qg27TI6ffb6utILfEQO6NCmDaS3G5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823577; c=relaxed/simple;
	bh=gt60oZWUE30Uj+EMsmwewDhMNZ5vHsFjsf3gr7OTxNI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lpYZtGyGJWRwa2PFXBJnYUw+4anxTYRHgpPn0lkS7pXByCgk30tX4wviD/vMkuh+r3saGyhC98M3Xi3b+U/DQMyniDIQw0StBVTu+y+BG43kceHtFFv27jh/h/m2ru0ZXqITOVofXRIWnv3pKZeZal3HKRhPWpfrhAhx+ebXUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f63ce98003so98142439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823574; x=1720428374;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gt60oZWUE30Uj+EMsmwewDhMNZ5vHsFjsf3gr7OTxNI=;
        b=nh1lIlfLmQ6bIVw1g8wQm99cW11J5OzPEzaD8SEEelZi6T/ZnwkROh2gkeI2LtBiqs
         MlC7YPKrLIcLySl6NsSH4nlFMHKZIgUs90yy1r99GCo5dK+jm0Ng3mE0TeZ38C7HD4se
         MqIcN5bxGy//jExlSR+dQO+reX1mvW3gKUyoI0igjvymDTj/utp7rhCMy6nUSgXGAYmW
         Az45ovAbi6gKVJagXLM69OqPZWatohMQ69s5FHq0fUHMmxSnXBmO+VyeE9i3YFCA25Xw
         1YN15426vRHvwsSwjn6gyq8yxJsOHE2bvliTmCiIUHZ56CQMGo1i9O+p63CkeyoR0XY7
         3OVQ==
X-Gm-Message-State: AOJu0YxGTr2ftNxI++JzTcrd+98Spq+qamqdo1gTWjpINlEqMjDS/JxN
	eMNNxVmJwWpHvX9AeBXIGNtJwu9IRMonrQ8jt4DcS6JjJXxavzSiw5uIwO9OUmTa3hjcFHxFafG
	agb5tYJZ9uyzEbUjVyyl0sZ72Coa4Je7Nmk2rtdrL7lBm9lRj4vPPOVA=
X-Google-Smtp-Source: AGHT+IE2SHpzjfU4y4kWUsk1YBckxtyxG7O9/92oZ0g84foklIPhCjMhX8xY3xjJ+foq2OHriw8gGU9qP2Moj9zY8tA/MIaDfMzA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2608:b0:4b9:ae81:23b5 with SMTP id
 8926c6da1cb9f-4bbb6e7c719mr542273173.5.1719823574577; Mon, 01 Jul 2024
 01:46:14 -0700 (PDT)
Date: Mon, 01 Jul 2024 01:46:14 -0700
In-Reply-To: <000000000000f19a1406109eb5c5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d40f3061c2ba196@google.com>
Subject: Re: [syzbot] Test head for issue
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test head for issue
Author: wojciech.gladysz@infogain.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

