Return-Path: <linux-kernel+bounces-176804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555598C3537
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 08:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E84B20FB4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 06:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E2A17758;
	Sun, 12 May 2024 06:20:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725417583
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715494806; cv=none; b=nZt7QgzxWeMTeR57Wt8BXXNzklgzFz8LZet/+//EB2XTjFtDiLz+Tz32KtA4XweQLUto0JfrPi87b9aGwooGLMWdn0DkBCLQ8ZziFvxTXqrNgxTDbUXKPIs8AL3Sm3UKS3J7hsgXVgsFUjuOLbt0TDnj2546SlulI0sr8z9MYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715494806; c=relaxed/simple;
	bh=J1SI6EdYucnv0q3AP6p42MgackM0eTN77ebVd1+DTgM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AYw+w3nloaT00UvwH1n1+zspec5/MEY3FsZMc1nH55bbSz49qzx8+qx4HHwKJLHS1rEGgaAEoI4G8KQEHxKiFEmWsAtMTd+0SEG3esZDP5YKvnAbAa8xLsSlv188X8t1fjVScHCIq4CRWXDDuzwGzRHfBnroAKKYY3EHasixSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1bdfff102so250427539f.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 23:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715494804; x=1716099604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMXSFsMXrSmCUinUnv1WPnQZZpoIToALPjNtYggTyPw=;
        b=WaK3LwYGHIjyT6UmvIEayiz5J1OezKREh8pniYf7qbnTfHFY/XORCJqDkTyeV0DT0f
         Tphl+d4CMy+nN1hApX5FXXFDNJuZHQVgjXLxLLF/mCsMJO9uuXGIAOcziZ/gBSN1NYmg
         140AU/Oe0HNlnfeiph2YJyI+8bHqgyjYZtkKIjhXq9yjXbQKh+DVednKz1lLGvhjdGjE
         Xc7ZLLikYC73kuVjUYqVhKSZhrVyUSZUnpUzbwXHNdYeuz3JBBTNGHp8HSrf9vP6XuBU
         M1bSdSZp6xUOTJtzzH6lqXRiY31adzt7ujjZ1aLgM3llerIocn7tmPE9rbUHm5uYDFaN
         eS1g==
X-Gm-Message-State: AOJu0YyA08NZglLzwfrJECpesBaZ0UfyCGGo5VYRTsg0lVPFZ3KKsNvr
	cut0oultK2pH3aWdrPjnygi/0XO1G3jGKm/uVwAmsOVk2n+m+uQIGGbIK1CAMvcMk2Soix3a8RS
	bxDpYrxSvfHywtAsctbGJMfsy5aRv09ayQAmgwu866zJj4O84BIW0xLA=
X-Google-Smtp-Source: AGHT+IEWr1ysjAVsqPzSdk5BAgNIUuBusuGVFwD7JQlqm0Jg1zukqS331IytDPt0d6GIZClhdFr+4u4XIZ4kJ8pCJC+89nWMY0SM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4cf:b0:36a:276e:4fe with SMTP id
 e9e14a558f8ab-36cc14e48famr902975ab.4.1715494803965; Sat, 11 May 2024
 23:20:03 -0700 (PDT)
Date: Sat, 11 May 2024 23:20:03 -0700
In-Reply-To: <8ef9e988-7eb1-4020-80d4-c9594c95e88c@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000679dc006183bc216@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in __sock_map_delete
From: syzbot <syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com

Tested on:

commit:         cf87f46f Merge tag 'drm-fixes-2024-05-11' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a8185c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=a4ed4041b9bea8177ac3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149d0cd0980000

Note: testing is done by a robot and is best-effort only.

