Return-Path: <linux-kernel+bounces-311396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D21968899
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F0E1C22334
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139F920125D;
	Mon,  2 Sep 2024 13:17:42 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7813C9C4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283061; cv=none; b=YfATIw+tK2+7WWVqsJR+sNkMX98VztD2IgKQQEr8nPQjHclWl+D2TlsPta70crS6wUOScrc1YdtID830UJmUNZzN9RvtCrZ8aRKwDT9qMUWYYQDXe/YhPW9EJtX0oAvGcMlzWBRto6K+Y2qbNjJoJXBgZskipvv0KZGCPrc1gt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283061; c=relaxed/simple;
	bh=qZJHaGRU7fr5/0CkMOOyFtk62bXQuyuBDL9Qox2dd9I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FOLITQ2Po1Ik3s1L8crDMI1Y+JYb8V6ZSwukJ+38k5/T3iC6xlCf+D6FCqUR+Vp6QA9a265lqf5qWTK8YpqIh23lJ4jmHp6o+gpOkrn0WZnbbR42KUGt4qgp9RhkPG/NKSesZDWE9MIC+VvSFOUHmqlAGuR+QgXdfotKVpZvcWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a1c57f4dcso522705239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725283059; x=1725887859;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kv0wDtxKWFi02CvI9439oPf+UvQ0ITGAg99rJeq7kAA=;
        b=JEO2YA1YpY8+YmoEqFhUT8Hj9ZCMd0ETpB6LI3xpnfSUuEVpBqVIMW8Dkp2qXhnlXU
         SNBnqTmDrfxs4RCUM/6oza9r8mA/8Y7IC302H9JFTprh/AA+u47EQnIf1jDAMq/VrG4r
         HRZfhQppXDTrv/puHiUxF2bP54kouerUR/1C+KD2l06TB3tAOSiD2FGcAE31FmJHuCzC
         g/zbd+o9gpUKnOMkIXirm7PFPkeYCk9qCkSN7CVSjqwCsQTW9zM9H186VA1385Kl3weD
         R+e4/DcCjLHNq5gTsu3gB44fzguf6bTbB6KWSR1QxLSpai0Q1OqAYVHE4JnwZivH5uvN
         jzAQ==
X-Gm-Message-State: AOJu0YyLoAa+jLyKEEa6p6xJIEiPt/7L03tGdObA8SSmarAystIr8d6T
	b4vdwTJEC0PbbPqJw+O+sVTEfNIa+XmF/YXYgOeA5H03AGefHiczvMOKcUTeJS6zNfSn3ET0jpH
	7PSdzj6Ri8ORL+1fKA7a8uE/F2CCGKC+0ZfYCPmxjkA7e1bikAqbvZpI=
X-Google-Smtp-Source: AGHT+IG/vrgEctPPj5Jq5Xluh84NsJeuNLH/P2w0MDLygfY10KiqHeAR4z7EcNN5w0lqEHKeWfYq3sfcoLmsuHmxsyhcCZJtynz5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8721:b0:4ce:928f:adb1 with SMTP id
 8926c6da1cb9f-4d017d9c55cmr507433173.2.1725283059399; Mon, 02 Sep 2024
 06:17:39 -0700 (PDT)
Date: Mon, 02 Sep 2024 06:17:39 -0700
In-Reply-To: <000000000000b6f58d05e9f95a0c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e48a89062122c319@google.com>
Subject: Re: [syzbot] possible fix (linux-ntfs3)
From: syzbot <syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix (linux-ntfs3)
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index fc720ad9c57a..aa7e9d70e32e 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -81,7 +81,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (err < 0)
 			inode = ERR_PTR(err);
 		else {
-			ni_lock(ni);
+			ni_lock_dir(ni);
 			inode = dir_search_u(dir, uni, NULL);
 			ni_unlock(ni);
 		}

