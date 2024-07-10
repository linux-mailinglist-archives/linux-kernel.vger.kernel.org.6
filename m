Return-Path: <linux-kernel+bounces-247050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4962F92CA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91521F21314
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B974CB5B;
	Wed, 10 Jul 2024 05:58:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474715CB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591084; cv=none; b=W/SjC6B3XQxGfT/pKmV22GVapaN+6CzMujrKtlb7uzhllE2fdR+M8HhqA3Z7lvx44OuL6WoIuJZKGiE7UnFe/pPG7f7mEbw9WpkvkK6YDDdKHL/zSV7CXJq8mfg1vq1kuUSZfxvSJcUmBadkMBL229V7aOIyZ3NDC8DAvX3g9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591084; c=relaxed/simple;
	bh=w8T5YygczvTvh1Cyd/b3UjLs0wSJqa+eEa/BWx1EmiA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mp44rLpixm2YuL++DjKTIVm3jRmgI/3tpf1gSA/z1ZaIACvOejKJRF3meo/7oOU6jIRvWo9G8V7kMYW8ewleQgBclC5s9u2rJiyG5tS4887iy2cnNJh/W+D5I36IaRxbnoW6OZmQCFgWFtl+qm0x/9EfAlLv63sAyv+VnIqGyyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f92912a614so445868539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 22:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720591082; x=1721195882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZRaWiSuApHR7Cdh95rQ4MOhuAIKWOEP4j9iChuV7u8=;
        b=IL2vIkzxuxBparqZtmhfeu2hAj0KW/IARsS5fvz8ea5j5Ngsh1MyG0iWsFITMsDwF9
         mMnF2WEW9bylNczmhJZ+aCJ7JpK/yfE/sChNxMrY/vgYl33Da2GKq7cBT9xnVm+F7yw9
         2YeiD69DnJHt3f6Xu1jfkvXIT5ExJEXbkSDCW3OH7G8qojO5XwsxA+QpRwD/tEOQVs1b
         /SQ/KYf3zJq/y07jd1TF0GINjpfgsruSrFIuOIZr8kZA1xCQjOaaw60ebv77pBeI/wtk
         SAIbSywE11oUq17FIa84Mb28jVUnClX9yPX9gWa4sDu9mlwGIccnOT5Y7KOT7yPa7R8q
         eA2A==
X-Gm-Message-State: AOJu0YzLrW3LSlFmX88udjSCR2KUldQVjPCDeBwlH34WU+a/aL+LL8g+
	ngbD0KtdGRYqrLBoD6ee2oiJv/Fa0km3nzVIXd0TZbngteadpVu0uI9KbN+VH94nvxuHmFRNMIk
	w8kbTzXhUBUOyJ18ds13z7EoB0B8lruR3a6kR/+gi8jZSoRKKGtvuUnQ=
X-Google-Smtp-Source: AGHT+IFvIzs4n+JeGSIao7Lg0IssLLsco9pTgVElAggkqd3fj67S1HfyiBSx19MTmQDnCF9CEHaGXwjzC/NcugmlB24PHgq8BsXM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1694:b0:7fb:ff2b:5116 with SMTP id
 ca18e2360f4ac-80004cf563bmr33594139f.4.1720591082115; Tue, 09 Jul 2024
 22:58:02 -0700 (PDT)
Date: Tue, 09 Jul 2024 22:58:02 -0700
In-Reply-To: <CAMc0M-_vJiih1m6dT9qvRtfLLkRwKq+0gmrrN84k+Nm_KVhwqA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040dfaf061cde5483@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING: suspicious RCU usage in bch2_bucket_ref_update
From: syzbot <syzbot+e74fea078710bbca6f4b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e74fea078710bbca6f4b@syzkaller.appspotmail.com

Tested on:

commit:         34afb82a Merge tag '6.10-rc6-smb3-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1492e87e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=e74fea078710bbca6f4b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e2e87e980000

Note: testing is done by a robot and is best-effort only.

