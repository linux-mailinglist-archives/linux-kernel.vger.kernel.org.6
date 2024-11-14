Return-Path: <linux-kernel+bounces-408628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAAD9C813B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95495B21B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2511E8829;
	Thu, 14 Nov 2024 02:59:42 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853881E25F7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553182; cv=none; b=U/BSa/5hV/OvBBdgiMKT9AZcQCRKPwF9wjAaKZeD8vLdExNkZ9b4ZspffVqmlBxcANAhPqOPNqOvI4nki701W8pa323sFo//dFR3QTqSSjWPJiV4N7o62xvd54ylJlQIstRot+G71shvUNU1JiHrW94FAD6tSmfkL+XUjGefjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553182; c=relaxed/simple;
	bh=5Jqj7mYF6QFUFz5IyDvGOJLG72N7XSnIfEC/G2hrrYU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E2eUeS3unBg/vYAvh1VEtEwUJ0z03WaFfj9yF/lNUlqicZpWLV2Ed5ULWFXVNfgLPYgsVSB98kwpESNngavnVnMDk0ByPSUksx8ELXUI+jmAq/5vAGZdLRJCXYJ6KOuqck8ohIXKLnT+YBkV88wfXS3bdjN2NrizdZd2L+s6GsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3fa97f09cso1763825ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731553179; x=1732157979;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3M9BWLOjUMrpuE46SoST2BJggQAssUyAqN812Jo3TS4=;
        b=NSplHNQvtmVwuuW8dsSx0PLkJGjbFJK8cIxN5ViDy/UGnLouHe2ikdw+U5KZl+30Xk
         d7nGdEyYr/km1H4vmT7Vsnb68l3pnMZQXniAlWsWxSYA8IGrGo/kT7TJ6JzcExIn6Xip
         AZ6KG3GF3puPg3L23Rjquvd4SReoqReolSZSjfekhMzvqJqmiNqter6gjTImed3vTyyQ
         ZdWHkwLZ7HSDIOFqhcUUVd0dadcu2vWLxVLMsAU0uPpGXu4nlM83C8nkXR6XtiT503dM
         aOnp5+nZtg2ytcmOe6iCGKqcwFt72lFjxP9d/TNvlZ6FDK4fNNkMLhEFZGdsaMlPK14i
         KvKg==
X-Gm-Message-State: AOJu0YwKvofq7ekYTnDKbmDBWlN2zrkcQlcVJatVNClqE06bpFH1aLHo
	Fa+qo643A6X55eHICzrvl5YbbY4ifokvH3XOgS9/oMEpFW4/gO6cHBCQjM/gES67eJjma/9rOoV
	TPVt4Li0mverN3l08ZXFXxUEmLa3jznDyPtHPBSj7ltpKGcBZCx81kl4=
X-Google-Smtp-Source: AGHT+IEq9SVvfiZTSkmK7Td5mF62fqWchlDJLXGI1UxOUveyqDo8Ndu7deUIsI2rlp6QOTkveTjx2Hr+1hFnL1reTapHegqROZdP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9e:b0:3a6:f35a:ee20 with SMTP id
 e9e14a558f8ab-3a71fec6cdcmr8215085ab.23.1731553179703; Wed, 13 Nov 2024
 18:59:39 -0800 (PST)
Date: Wed, 13 Nov 2024 18:59:39 -0800
In-Reply-To: <0000000000006dd465061ff836c9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6735679b.050a0220.1324f8.008e.GAE@google.com>
Subject: Re: [syzbot] Re: kernel BUG in ocfs2_set_new_buffer_uptodate
From: syzbot <syzbot+453873f1588c2d75b447@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: kernel BUG in ocfs2_set_new_buffer_uptodate
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0a9b9d17f3a781dea03baca01c835deaa07f7cc3

diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
index c4a4016d3866..8165f9f2d324 100644
--- a/fs/ocfs2/resize.c
+++ b/fs/ocfs2/resize.c
@@ -574,6 +574,7 @@ int ocfs2_group_add(struct inode *inode, struct ocfs2_new_group_input *input)
 	ocfs2_commit_trans(osb, handle);
 
 out_free_group_bh:
+	ocfs2_remove_from_cache(INODE_CACHE(inode), group_bh);
 	brelse(group_bh);
 
 out_unlock:

