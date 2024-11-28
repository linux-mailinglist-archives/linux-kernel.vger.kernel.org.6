Return-Path: <linux-kernel+bounces-424221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB009DB1BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3E3B21D12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7C84A5E;
	Thu, 28 Nov 2024 03:12:41 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85B1BDCF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763561; cv=none; b=fC8SML/9nyeEMkMVuQl6Vy/fK/lAOyuPmuTPVSSu4aMoisGYWtOBEQIMetPE35zarHwNrkeWOhHHQwXtGPblEvRrWQBKSbDLxRkBQjav3tbDxJfBLPoHOY4fz3JGxGgsWTi611zzHM9h5aL5jY8sqZbZ0YT97EwHw5jSpmzTfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763561; c=relaxed/simple;
	bh=EZ1pHMHIUkaHsGYlMVlG4MHuiP0q/uzfZWCwpGzIh5k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cPJOSwX+EG2ZvFcm+oFKcBVn8edUwz6NSuuiF4B1C00wFDqTK9XO8aAcDWPQ7T0HN+h27wfKglGF3UFwxvA9xExacUXGAppqlO5cyOsNR9Igho0DtSKYf5X8ILt5/CNnMfV8+OUy//XlLL1Mxms/EwJJf0km5TGwt5jEU0SySs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7a5031e75so4099685ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732763559; x=1733368359;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3/AIYaTVLz68t9D3YstP3JL1YUqtYYUV/5l0r2YU+o=;
        b=aeF51J2p0i4TM8oeoy1YbresZ3fTf7wbkOLGg+Ja1MaDi4wtSFF9l2xcratT8dy1z7
         x2L7ZMjb/47PC3oUfyqc/Vx4uZPLDNxYMr6VXLFs6fFjgEHKNvAnVY9W0Gcb06J3pUEg
         XCrpyMmVHrMNZnnK27inRA8Br9zfYJFYDCS3s3vi4g38mbockXhpnMqhfpY9MCHNXmrg
         fdY1u7JUpO9V/gorhijYy87jILtAOj7/P5usO6ZJ0nJDTRA6J6l2jhTQ/sSRUa3GIh47
         qjB7PS4BhUr/tBG84pklD5/YtxR3XOB+xU2KhowuoqatumS8ICiSIKmcHKkQNovn+uTd
         PV+A==
X-Gm-Message-State: AOJu0Yy/vjs4ClTgr8gFnt/oFrdAFOE7P3V2N+uxmM3hOoCg7TRhY6BM
	+XB717u6opQsmZnvSweFtsoxiMbjt4MlZVyoFkMjfRUWvpP6WdIg+Dm46qHA3zX7qIA14vhaUXB
	L8KdCWfTp3AsNQ6NI/W94+C4zptJSaZ8Htim9UyIntjr7YRzfWbKDjMk=
X-Google-Smtp-Source: AGHT+IHL+4II1alvCDMHlpGZcfNqwDsK+cYNigeHrbAYLbQv0/IyDbyhL4H8RReUYdrFmlHlNhvHaOlHVLvSLKAE4GRMRr8SUxVY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:b0:3a6:ac4e:264a with SMTP id
 e9e14a558f8ab-3a7c555f0ccmr51369925ab.10.1732763559015; Wed, 27 Nov 2024
 19:12:39 -0800 (PST)
Date: Wed, 27 Nov 2024 19:12:38 -0800
In-Reply-To: <673f2a35.050a0220.3c9d61.016f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6747dfa6.050a0220.253251.0068.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+78d82470c16a49702682@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Issue a transaction restart after commit in repair

