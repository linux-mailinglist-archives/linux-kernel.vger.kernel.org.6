Return-Path: <linux-kernel+bounces-241125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD81492774C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67511284692
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A671B11ED;
	Thu,  4 Jul 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pzz7/Ilj"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF21B011B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100213; cv=none; b=mbYYLuTH/RfDpOtUR8dG6tveUFoAqxKKE1pg7WLzmdDRwJgf7mrtP2VOQ8B/HLhKMiyUZxLegJi/8imJ47MCPpeEyG/4yb8eNLSnmJX4wBkaALsa/bSp3uyZH07zXu6EMy+QHQ6gArsm8DZH2NI7k9Bvt3hnM3sT4natJ1ku0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100213; c=relaxed/simple;
	bh=V2tOAHaVrYonStI9abDwgL3tFaJn3HXhUBB56LP2hL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHX2pCqCTncXI1n+gb4OzPpxe4qXsdmgFgN7u++8qdl2/zroYc7r6P1CQCVtBQ/4ai+sM+mgxsntgED4Ef4ppJnF48QO/smj0dUdt1hrW6GPRduED/OsmhpSjMkIt0oPrIoIUSeyK1SGxdUCte77wEss3lL+ZImFVf/P3xUBfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pzz7/Ilj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ce08616a9so2519e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720100209; x=1720705009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqKWhDVIpU54/3Lm4p0n8dZsoucJ9m4r5oxiQez9CN0=;
        b=Pzz7/Ilj1w04GL34Szws4M9O6AreAnw47HuYtYKtPbzSgtaLgjMhYQUKP03R8it125
         CYku+anocFMD7gmgIa8lQL3cIe4W+DyixYgNqG/KMJGOB3rN4Xz/dWTIeAlkfsA6yjlI
         vFdJ59kY8stS/aWTud/fBaGAyjnhAU6svvqsse4JxUd+OXxKNdrErB6xnj7oaFCdbI9o
         PUuXgF5D/srTGjaP6DZcpTWtArdR4eCCnT4sScXZDl6f/1WH6cpqWUGngeqFxprsFTGz
         4djQvDjQtvWY1a6Xksaaq+Ko9oAWDjrkCbLdMoAS+pmv2lWCrUN7THMFYI0s9lgKVmRT
         dZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720100209; x=1720705009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqKWhDVIpU54/3Lm4p0n8dZsoucJ9m4r5oxiQez9CN0=;
        b=JZxBqIZhEj6BmEgv+MCOqNazckhZ5n+uhi6JfO07JfTHywbI9ruigh9wtd2h3QEvRU
         4R4QXicC7hCYFOieZfPLsNY0dNqcXrwXknlGi1x+Q2j5IbOR5pGfDtY8yjMl7sMPjeDp
         D9VWmj5ApfxP5SHXWbPCNANWjUa9/wMO62KpXwZn66klPCOpCxHQs6bN+hgJ9SmuuN0j
         JPE3sAqJwhwA6GQVBtkYwDcmPIJPOdd96/7+VxmpXTVgprQOooOvqwoHYxoDAwGKTk+0
         JkSIZRKF9NS1b6H8JbczQPW7Zw2NwwkZkdUsRB6E74PFJX5ZoR2bNYE62juG+7bhHK6r
         vuGw==
X-Forwarded-Encrypted: i=1; AJvYcCXK1bYCYMISCG1GALxt5DUDYE1eEdjeHZalCLtMGlUOUP2Wjx9T3T/u6X6p+C43+PpmXhiiXAhtVuEWsOIwePMuKNtE8PAOBhPQfh1p
X-Gm-Message-State: AOJu0Yyoepl7Dvg1y/Va+dr0YOUzVXSUbVr2aqrZ5/OTdVOx7GO/8xut
	v9RinHrIX1QbXqemLtX2DFhfY/gQzGZXsCcNh8oBE7EZJaBmRyZuOUbiE6Uf8F66xpzrzRVoapx
	nDcc/C/GHu/OCIkyivEPq08nya7tE5eJaP0mOZcPM9wnQsAz9u9aF
X-Google-Smtp-Source: AGHT+IH6SWc1AXTl+5ysSGba6hAiJwdZ9zfcwMC0vSQ9DYlubLUsWHEgrhDgFV9pvmLBGi0YR6GhhmlJxdASvzp4g1A=
X-Received: by 2002:ac2:596a:0:b0:52c:dd94:73f3 with SMTP id
 2adb3069b0e04-52e9f2a8ea6mr93485e87.3.1720100209127; Thu, 04 Jul 2024
 06:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000037162f0618b6fefb@google.com> <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
In-Reply-To: <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 15:36:37 +0200
Message-ID: <CACT4Y+agurcHCQnLTrVjLXr1-kEj1wbmXCHX6LPM=J1-o5wT2g@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: fix uninit-value in copy_name
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 07:28, 'Edward Adam Davis' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> [syzbot reported]
> BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
>  sized_strscpy+0xc4/0x160
>  copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
>  hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
>  vfs_listxattr fs/xattr.c:493 [inline]
>  listxattr+0x1f3/0x6b0 fs/xattr.c:840
>  path_listxattr fs/xattr.c:864 [inline]
>  __do_sys_listxattr fs/xattr.c:876 [inline]
>  __se_sys_listxattr fs/xattr.c:873 [inline]
>  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
>  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3877 [inline]
>  slab_alloc_node mm/slub.c:3918 [inline]
>  kmalloc_trace+0x57b/0xbe0 mm/slub.c:4065
>  kmalloc include/linux/slab.h:628 [inline]
>  hfsplus_listxattr+0x4cc/0x1a50 fs/hfsplus/xattr.c:699
>  vfs_listxattr fs/xattr.c:493 [inline]
>  listxattr+0x1f3/0x6b0 fs/xattr.c:840
>  path_listxattr fs/xattr.c:864 [inline]
>  __do_sys_listxattr fs/xattr.c:876 [inline]
>  __se_sys_listxattr fs/xattr.c:873 [inline]
>  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
>  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [Fix]
> When allocating memory to strbuf, initialize memory to 0.
>
> Reported-and-tested-by: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/hfsplus/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 9c9ff6b8c6f7..858029b1c173 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -698,7 +698,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
>                 return err;
>         }
>
> -       strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
> +       strbuf = kzalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
>                         XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
>         if (!strbuf) {
>                 res = -ENOMEM;

Hi Edward,

Was this ever merged anywhere? I still don't see it upstream.

