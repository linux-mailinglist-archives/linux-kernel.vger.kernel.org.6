Return-Path: <linux-kernel+bounces-405335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D629C4FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEE21F2216E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B520DD52;
	Tue, 12 Nov 2024 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QSnTK0kn"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199871AA79A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397901; cv=none; b=d/IP9fbx0XFDzRvCWTLmTji8oaoQ5KI7huIQ5IsdUtGL0/Pa48zJFhZvAePdp9t4bZAOkEp2PzCRP116OfrwtPUmTCM8ysDaCiHAvq4rocWrmiGpldXe2udNARa7N8HLlPOHaG1TLLxoy8U8+zBf1npF1F2UaH2EFfu5Ok1T0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397901; c=relaxed/simple;
	bh=SOQfNorVVsJjHaoJN/Z7WI2R38T4DZZ+AcNlfAuW0w0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TvX/TuU9w5rc2tnstcyO1ocgwVE4EfsUlG88x4BzlQCS6jXV/5tPZbJ1yw8lWIKyy9KcDUgqHOTn+NsUYCJxgz7q0ORoP9NwINssUMOjZge44p2sbjTmDu3Nxzsuvb1y/wRWRKYOx6JCi0EB79DM/UwYs3bZZ+LyKzWCLaG67E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QSnTK0kn; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ee4c57b037so3902564a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731397899; x=1732002699; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ah9uRvARHaKS0PcNXHxITpGRNkD5oowJ5tevqNEnwd4=;
        b=QSnTK0knwvjlq+qXErmjVxwUYnQ4YtKPxPlJyS0aB1s60yj15lmp16IYy2g0aztW0t
         nqQOVp5OpxsWynYyIzqPUK7Ft+powqHQu7cNLRlTtxDJC2E9RM9Wc7HZfpos9WvHz2IH
         gGS8bH1UWvsePFkYXyA00JkS1HotByKy0sxTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731397899; x=1732002699;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ah9uRvARHaKS0PcNXHxITpGRNkD5oowJ5tevqNEnwd4=;
        b=vOhBcbVolsHu+lpFz3gQG+17SlTP3EQF7EdqSFZMGINvrqauwKl7Wjd92dK/1v/wmG
         2qf0DuGzzwr1YoQdCVZqI7DEZ4OT+uIZNVe4olaFyz0EO0MfHNELT2VzWvUGykXLAW5H
         iovTzXtlt3XksA0yZaZGAbeB8XEuEZYLDGMsHW9iazd80WrTY4t7pcKroMESDHcKtT7E
         fFUWz0bHyoK3zxqna7P2GiAL74+yNNpHdBXKFrV6eQbMDiqe6cJlok8uR6AhpgufrXcB
         dwXxo28dkjpP6RUq4smSV0sL0OzwyToSJLwutQb7xgzw1VgtKVdE/5f9Qi16XCZogVpl
         sQTw==
X-Forwarded-Encrypted: i=1; AJvYcCWpo/duJ4dZ+l+l5OGpw0mIUg5mdFRKlUGSN8ov2VXvjB5ES1Lygn4OfWWQ68fQyL9XiE8DuPeX0qSegR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4HykcDK48ihWuKRygSlhqXkfu/JQVKuab9AnZ1MYjDqhy1vF
	PoZ3Sxn2x7us1MuXWhRbEVEQ4O3kDsRo3bOdLHwgUMpKXJGE1wTWqndk9cSo2Q==
X-Google-Smtp-Source: AGHT+IGXpgaPU5/8NvVWcNlzMTiVA+OUBN+eD1IgHOHn5CF/T85iXoWOskWC/tdvy66pZvVrbq1ezw==
X-Received: by 2002:a05:6a21:3988:b0:1d9:1ceb:a4de with SMTP id adf61e73a8af0-1dc22a15e91mr22008600637.27.1731397899425;
        Mon, 11 Nov 2024 23:51:39 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:9e09:d4e8:509d:405b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1a9fsm9890857a91.37.2024.11.11.23.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 23:51:39 -0800 (PST)
Date: Tue, 12 Nov 2024 16:51:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: ext4: possible circular locking dependency at
 ext4_xattr_inode_create
Message-ID: <20241112075134.GE1458936@google.com>
Reply-To: 20241112073421.GD1458936@google.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A silly typo

[...]
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7647e9f6e190..db3c68fbbadf 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1511,7 +1511,7 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
> 		 */
> 		dquot_free_inode(ea_inode);
> 		dquot_drop(ea_inode);
> -		inode_lock(ea_inode);
> +		inode_lock_nested(inode, I_MUTEX_XATTR);

						^^^ ea_inode, of course.

---

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7647e9f6e190..db3c68fbbadf 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1511,7 +1511,7 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
 		 */
 		dquot_free_inode(ea_inode);
 		dquot_drop(ea_inode);
-		inode_lock(ea_inode);
+		inode_lock_nested(ea_inode, I_MUTEX_XATTR);
 		ea_inode->i_flags |= S_NOQUOTA;
 		inode_unlock(ea_inode);
 	}

