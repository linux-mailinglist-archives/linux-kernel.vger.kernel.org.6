Return-Path: <linux-kernel+bounces-314035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A4A96ADFC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169461F25AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F05C153;
	Wed,  4 Sep 2024 01:39:01 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40277BE40
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413941; cv=none; b=sbghD5kBR9iVscrP5tXbSwQxr4WmOnzAHNO53AV+JKNuuCTiDglJiP9u6gdpQ21ONU//hrGQHW4Hvwrl/o3HNOUBkrGdEiPD1rH+lohSM561VxB7FeMecFOmcYGRhF3d+IsBTI/lV6S9wTT0OwApKjJuSTQHFptoubjfeFRjO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413941; c=relaxed/simple;
	bh=dbbjY550F/QeMObcxG12FPiR8xtkvDK6VwrIPxV3wbU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ew5BlAYDeISN6by5urs6zGn1OkpOwLKXjNEUGwXW0z8blkTnYam72/A6J7L2m+rRuJDMNiWU6wwWf44+U56NCe2hw60fehOFz+ru3kIJxjet3ktolbWDqjMh4bSqVWXzHBPAIU1MIVlEXJn/EBqgqNtbHSPoCSD74gm9Hx5MfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a1c57f4dcso776659739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 18:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725413939; x=1726018739;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EUPZmeZh+qqUcV7hVlN+J3fLNWuEfzw0szL+D7nHxU=;
        b=mSqbS4wCw26ayyMgmbX3Ui68GGr9MDVG1ndoHG3o5zM0ex3JeitK1BxchlnALgp0eL
         hAygoQYH/jHXzBtuTwA51G0nmuMtA5x61hnSwhZyQ6nZtzRm2WWq8BJZw6lHhYgzOoAn
         vvyMASO9F6P4BlcQ0jqj+47k1NwsXb/4JgrC5vb5jMyo6DHuCL2YIuJ8lqAhVhX5MoWw
         vdpYxqRnTQ7QteLiDXM6s7I6y2/TTGrwf9gWv4VbaKkW8MtkMyfuiUSLxRZhSPwyQl3S
         JP9/NLqRzB93AFOhEH1QcoeNgZ72AQZj/PjLLdwot+4mZJwgZmBa8eJImZcA0ggTngB1
         ZIdw==
X-Gm-Message-State: AOJu0YwltKccOE39f4KIeWUk8lmeuR0KN2aQU3St7/kwPgG6jFZrBgng
	G2GIrO2Ea3CuFMbwEr/vSqfsyFLOQL4jVVG2hiicY8/N98ZYZw5+U/ITC9pRZ2iq6IYxNzbe0Cb
	Jd5n6Zchzl+lb9K/QglbjlGl7yf2cy9PAsb64CMGjsDaMlx+iJIf+66A=
X-Google-Smtp-Source: AGHT+IH9vfqC4aTIubmnqTp0TXyi1q0oC3roKf7lJQYdPM/SuPD2o12WmPu5DXcToX6q3rEOrCHram6MDuVxbRi8CUYEPqzdx3a5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d87:b0:7f6:1e9c:d6f4 with SMTP id
 ca18e2360f4ac-82a262d23a9mr42841639f.3.1725413939394; Tue, 03 Sep 2024
 18:38:59 -0700 (PDT)
Date: Tue, 03 Sep 2024 18:38:59 -0700
In-Reply-To: <0000000000001b6052062139be1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2ca920621413c5f@google.com>
Subject: Re: [syzbot] [syzbot] [btrfs?] general protection fault in btrfs_root_node
From: syzbot <syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [btrfs?] general protection fault in btrfs_root_node
Author: ghanshyam1898@gmail.com

Added a check for the nullability of the extent_root variable.

I am not sure what error code I should return when the variable is
null. Can someone help me with this? Thank you very much.

#syz test

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 9522a8b79d22..e613420cb079 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -1002,6 +1002,9 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
  return -ENOMEM;

  extent_root = btrfs_extent_root(fs_info, 0);
+ if (!extent_root)
+ return -EBADF;
+
  eb = btrfs_read_lock_root_node(extent_root);
  level = btrfs_header_level(eb);
  path->nodes[level] = eb;

