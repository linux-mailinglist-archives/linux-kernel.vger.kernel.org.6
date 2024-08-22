Return-Path: <linux-kernel+bounces-297835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBE495BE48
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E0028414B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1471D048F;
	Thu, 22 Aug 2024 18:35:14 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC171CDFC4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351714; cv=none; b=N7fn7SROwx4pSMoslX+TpMzD1PVyE14md1G3UVL4tNIumSYh7XMG2Eg65022C9DMTWseOneejzr+iKHfz8f3b0Pl5dgmcYZG+4FVOgneukZ2P7jelXfsPVwKou1IoyE+DyuTKhetdwCa34hDpJrpSh8yrzt/r9vLKiCKOyWy6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351714; c=relaxed/simple;
	bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uLsqsqtqZGScz1/t6QyuVtu6xsJbFTntvAzSxi2mpZboXJYvMiFHkJGfFBQGFn4N5nD79pzDu56GpqX+4Oiy6sAnOpYUR8FJbPvcccwlGjMVQmbyxDjOvhMBkqJj0sGDvGw4+O16hIeukcr08HjP18h+S+yiNDdyxAyJoKJzZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-824c925d120so107793739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351712; x=1724956512;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
        b=ep+IF1g8s9HyzAkWS1dy/oRNAT+4k2RkaZq1myW2y9GjLv6u01AaJMaXtJONRtE4AR
         n0DzEPSDMu9/ke5cVynC+SZW8Lwvu0ZskUixJAXKFcRt+ygj1wJxj/aJq0CHc944gJHS
         8mvgEY/muwaY2l4983RtcdwbzsMIK+hIGRS6glCyO7ZllOF2jKqz/8SsATWBlSagzzCc
         wEhquLlepPj6yOlMLHS7B2ufk7A60Rv1Zk8Pu5IGZ3Pj77MAMOcXqz9axOJBxYqCWkrX
         lcy+fY0YWWXpjBjyx8pZIoYpiLe77wVKlsZsELiggbgl0zgLweqUDLBqFv4WZuUBYDp1
         AwGA==
X-Forwarded-Encrypted: i=1; AJvYcCWi/AW06TLexhw610yNSecqq2RNrqTWP3Nxk5KPOBwwck/LWNgsCzXiAoHqw1y2qj/P2rEWVkJUCKdk4rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XR+LgcPSSGxrBGgTrKM59AeuEGM1bg7hfbgA5TPijCEzgYs8
	W76HJ9wS5BtoMBZ3qVjZ3dRBgW0HhqYQE3dM6EQgVuCJahqFm//sso2ikaIUJ2aEJX14sloQ3rT
	aCZy5glUb2mcgJR+P4fQdDIX9D6W0352K5tdDBlfxmTCI0GNqlAI5iVA=
X-Google-Smtp-Source: AGHT+IFfhm4qInQC3CXdMFXwuZtqryfRItmB36SvpNd0wCajLJ3q0lN3HzBbBjitkvyoakyPRpLfLoayP3f+oDOcYttr67W9D01i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8720:b0:4c0:8165:c395 with SMTP id
 8926c6da1cb9f-4ce7f50abc3mr31071173.3.1724351711918; Thu, 22 Aug 2024
 11:35:11 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:35:11 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041ce16062049ebee@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

