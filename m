Return-Path: <linux-kernel+bounces-230308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5ED917B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C551C23DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833A166302;
	Wed, 26 Jun 2024 08:39:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5335F161304
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391143; cv=none; b=WI179FglpbPN+xzG7JhbO7rFCuWwVvfVDg9KWBdcB5dxiFhZB/0NbtEJivjOfnBx+2mKFQr2wMtoWjqclKokXlYAa1smG1zqVJ+692ZD4DhLl1GGSPtlk7hDLxj+8HqQxNQRzAtvLlHMGFyzucDP/z2tuvgAvAtWTrXjlAI6E8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391143; c=relaxed/simple;
	bh=pKneCHe5SunQeF4kZhf26wXuY7csMkwjabd/cThdPc8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PslT8zH3dyk8sTzdRLsocsOFk+LDv7dh6/MzPXjjYJ6SN2FMOlyNYEEEECR7fYCE5t8+7HYkS2S6nH+TDUp2yQ4/bHEZ7fqfX7vrrFPhYGWggI5cnl+ThTrism8fM0bKnDa92POcZkJRo8P3KdZd+clVMwFuIgG5n/DG4xtjzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-376117f5fcfso81855375ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391141; x=1719995941;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKneCHe5SunQeF4kZhf26wXuY7csMkwjabd/cThdPc8=;
        b=ov2FfvwZEryLEXXi/zHE1XScAscaxRlRruIAJ2rSNrim0ZLipeMLdbESZPlA/DTEF5
         sKYjfapOgtK9di7BCnCzoRAG8fD1T8R/G8aqr+4koY4KctWWvY9IGk1LgaY/ZObC2r5D
         DJOb1VdT+qXyZzp2m6KbfVO0pPxolYL2J2w6I0DPOX1VdKiSEujZCzgIvf3Fe9HD/ozN
         85zatjuSYQ8aAmNNdeDknYDIQELwMpfT32sE44NUcGNRbibnxD8g8iSRyzIvcYcoVlzV
         b7QHXMCgjm/B/JsS/UQEFF9eRms0ZtB51iOV2ZfbeGCubY8v5dSSm5At4bymCG3gTfa+
         3dxw==
X-Gm-Message-State: AOJu0YxXrQMkDChPMlRzQ8SmcKrQ37/S20r8BwaBxta1H+aC0JTyQ/Yg
	IupK7NL32CTYlavOOTJZMNg9AGZt5ATkICr9n4v+AWSKmyt6HCHvxTPG29OAAgEstgXsdzzFBLw
	og5L+Oi7GVElhqVJGXgZkIJkqN/GJCpyWmnWzGkEs6qUUls0DEwZlq0c=
X-Google-Smtp-Source: AGHT+IHCMw5eK6tLV+VNd7j8HmHqNRTtsxfdWaAi1QfbDj1nX6uASqcwEr9SnYpcxGLhJW65zU9fx54iLIGuz3R8Pxw+3V+7W2sz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a1:b0:376:46d5:6583 with SMTP id
 e9e14a558f8ab-37646d56846mr9480135ab.5.1719391141488; Wed, 26 Jun 2024
 01:39:01 -0700 (PDT)
Date: Wed, 26 Jun 2024 01:39:01 -0700
In-Reply-To: <000000000000aaf7ec06186a8d13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037fd9c061bc6f27a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __ext4_check_dir_entry (2)
From: syzbot <syzbot+11af34d3c0711f233fd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: use-after-free Read in __ext4_check_dir_entry (2)
Author: norbert.kaminski@infogain.com

#syz dup: KASAN: slab-out-of-bounds Read in __ext4_check_dir_entry

