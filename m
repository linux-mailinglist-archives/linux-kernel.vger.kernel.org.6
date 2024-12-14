Return-Path: <linux-kernel+bounces-446215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767599F2137
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C323C1887D03
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1D1B4F24;
	Sat, 14 Dec 2024 22:21:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1221B4F21
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734214896; cv=none; b=axSrUZsYCwvc+jGHJDvVCbh8v7udXQvzlWrCoMUvYEAEtbtT+3hfNs95y3xkXIQpmlYuRfWwBtDBgyFWi5lEVat4a7CCHa0pT+1kgNY2UQnEfjZQ4XMqeQD8xP7rjkeYGuUVecTH/3tgRmY+Wv34iF3oqysQiL0s1NdoC8b//pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734214896; c=relaxed/simple;
	bh=jmOfGx8i6WqW/9e9eV0esQhvVw6dNrC2SZ1/lyEA2QA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=is4hbFDO7OAtBEvVk5Uw1G0htKlm5Xr8UzOrPgsHZbqRbj458ZiR+9hLjbVK85Fy8enI1XdU9t7nOLQzwHD+VhRjCXsnrcoZ4+77mOH+FtOUo0Qa3lkHyA41TDy/5qdeoKUyK/wJNr3BKAz2RAGkixmdxj+MpRfff7hGOLCB8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ae31bb8ee3so54995315ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 14:21:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734214894; x=1734819694;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bicnoxgy/OVG1OfhR8q3/VJAcXZClP4+JgLbGeU2LYg=;
        b=ObAtAzdjdEw1hAj3LEIwtNvBQWrEEOG9aeHN6NLvTwqmtHmYG81PqHjMg6lfz78b+3
         BJe90KcamEMYR621SwsASElgm90ROk3/877i9tIH7tpeBJjFkeHJ4dcPVB092CM0Izaw
         KSGR0c3M1LvwRmbJ022E3nuXmIDKOYx9nwYPVOwF1MvIpQAT9NWNLs3v67qsyD3YvQSm
         WLRpySXDi6j2x/eH5kTWkmbN9wS4CFchT+IFE2w7hYoitxHX5MrnXrjwLRw2dKxB7lKE
         YBIBajGFdVXP/C1SlP3CVenkl+nLvxjhSDB02Wfh6y+kPvbv2oBPYb9hoZDZLIZ8mguR
         miBA==
X-Gm-Message-State: AOJu0YxvBC+2B9qlj92sSdvnyHB05xMGCCAMs8VoEVdTi++c6DZDfVNT
	vEFziRTTNEvQiWn8xE4rmKc1lMFUXnLN/cBQgLpsveplTxMce1m2aQ/ukbswS9k4Ma5FzMYvJST
	T6EvMT18ASbRsrR7C1CVXUzesywKzrFQs+E59c0nvDMNFFV0Vtc6DDVg=
X-Google-Smtp-Source: AGHT+IFIcgZNuGjBVOpVeQclPPAFBruf8Mvjdidw2jTeRtO41aaTuhtSGQwaTX+urtaDDTpV9ggI4BNiSpTI96KJcI2ZefqG5FQ2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a25:b0:3a7:e286:a565 with SMTP id
 e9e14a558f8ab-3aff1023494mr111270425ab.23.1734214894316; Sat, 14 Dec 2024
 14:21:34 -0800 (PST)
Date: Sat, 14 Dec 2024 14:21:34 -0800
In-Reply-To: <67409854.050a0220.363a1b.013f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e04ee.050a0220.37aaf.00dc.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: mazin@getstate.dev

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

