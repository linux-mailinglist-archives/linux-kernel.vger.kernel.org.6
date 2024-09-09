Return-Path: <linux-kernel+bounces-321655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC905971DB4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81BA1C232A7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C381CA9F;
	Mon,  9 Sep 2024 15:13:18 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E523749
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894798; cv=none; b=HrITba3/R6MzPeA08MpSDRdt58IcLtyaCf07Nl7Z1UP3Opcw/hSsKpR+DovJl7bJtZ62xPrXWG/jtr0AO31cNRTXCyOEydSu2rwF9YkDMgYBO6JKmegiXzGL+PL6SJkpf1VipD5PY5Nw8mx1VltS1jQDIERzYPb3HGG4V73UafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894798; c=relaxed/simple;
	bh=8VMUObhSxKa4/Mc2ky8AqZOVGBytrzQVCxzzbxrq7jI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qq84dZmNZjlbP6qrrFclc04hAt65iDaK3v8P9vKzRDZUGoPeIf0yD27dSHCJW14sWPR8yocVCzFecXFnuy+h5m6KX+XOHhEtB9r/L5cPSUh0/4CENWkxZ8MzY7+EAYT6lF4QyRYQDnn+fLIS7HENMEld0eQzO1Sn1wcatycjFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a050af2717so61315725ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 08:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894796; x=1726499596;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ex9yXfQw1EyCs5QEddTZ2cXW+Wj8DiUPSeKfCC24bw=;
        b=I5d+gWzoXMvcpUkXPl7tT8w2hsr3TMD7XRO5VJVFmXBeILMq18ApWVTTY2vd2kMhvt
         o1vZRe9MmbItrRwcNo47aGdO2G9gUwIqiVWQPkjEN3fGiSbmlMib9hyR2Fm+gcJBmU02
         zMH8bT32M9l6pJvg626J2Ln5vHqWftosrxFHlBKxZ9TYOKfs/s+MON99e24jNBVeFZ0u
         kf3i9cVq3AAlWi2i1a+z1W51frLDNERrKuhDo1k0sQALKKQMDe1hJotLH6S6SXZMOloo
         ZVVGdQ+NlB56/10UOecZGIEh44GIK1WF0aRkBGzJeEUzGIEdIzn5JD0siHYUq6MpKCLx
         0F0Q==
X-Gm-Message-State: AOJu0YxY8Oq6HXqBYxiC8qwywSPWner9ket68KUUGluOtaydRXjFi/Bw
	ghMjfpI8q01NvOQEFEUclbIR6SXuPsPhCoH/RYEyu3efap1Eb9I3DXiSe6LtK0PJBaeQitmhSa5
	JOpnv+K1PL8Ez5i5e6YcWKZWmPWF25R4sww0IOfX33De8vf3KmIelB0Q=
X-Google-Smtp-Source: AGHT+IG3dyyiVuy0dmer/REifs5/t+2RnCSX+1/hc9pbZxaB2/i7A3fTranOzCKFfuDG8JynjrLjXxlOBZ6dHowxSj9xrf84rrCk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d82:b0:3a0:4603:70df with SMTP id
 e9e14a558f8ab-3a04f07e7d9mr132542825ab.7.1725894795647; Mon, 09 Sep 2024
 08:13:15 -0700 (PDT)
Date: Mon, 09 Sep 2024 08:13:15 -0700
In-Reply-To: <0000000000007a66c5062140e8f9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036ef650621b132c1@google.com>
Subject: Re: [syzbot] possible fix (linux-ntfs3)
From: syzbot <syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix (linux-ntfs3)
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 7d4e54161291..41c7ffad2790 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -102,7 +102,9 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec &&
+	    is_rec_inuse(ni->mi.mrec) &&
+	    !(ni->mi.sbi->flags & NTFS_FLAGS_LOG_REPLAYING))
 		ni_delete_all(ni);
 
 	al_destroy(ni);

