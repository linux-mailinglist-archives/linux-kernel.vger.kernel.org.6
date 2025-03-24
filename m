Return-Path: <linux-kernel+bounces-573069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA5BA6D2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C2B16D596
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A72C8E0;
	Mon, 24 Mar 2025 01:01:46 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB742F2F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742778106; cv=none; b=G/6YuAeOmyuK5+pwdX7Pag9LmPbcLPmaN1sBCrrkBIrwd4SDeOwDsC3uUatxNomjQTqDtMABV0isBMFcDesdiSy1h1Q0NohFp8hpy+x/2O1oeb2ic/GvDE4z1+ABNZg/qjlXPjdq2bjrof5n3LD69/cjE51Mww/g+ieQxdkHoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742778106; c=relaxed/simple;
	bh=ZPypl70RmryQJ99rsBMpVzKrPrEs9pgfSCay+ksmuuY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j7dfZMCL3fyQuHH8soPNsS0j7jGudiIOM5v+Zy3nJJvxlsoWZpZE63bXF3wW6ySx7QystEJuTrL3MDDTqzlqMy0A2C+b5bV6kz4x7fpxi/Cj+kHc2f8wkDafNAAGIo/950TtDj32trHDABn2ySr+d0dhZGmkEQEvQEe9SHEWEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d43621bb7eso47382875ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742778104; x=1743382904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2cpqAHPztZ89XlKz1rnL1cPb1uwahHd29N0j69/Qxk=;
        b=j1f8skMzMT0irReJeA/Xf5GdTgPIcxqeIJxcenwOaOTyCbKbINsqgttImYxc+9CuSR
         /71HrIAGM9PwhN0U/h58HuyufeYuCURaYot5yoRbmOFgPsjjJZ5SjdUlyjFGSZzzCXI8
         pLj2/I19EaQ4qkIPGNU+sg4VCEe48QeRM5tCnSMaKpJ8lyiTBDWVMYahQpvUNUjZVwdw
         XnUwBBhHuXGdwf/Nc99buBZOtybhmwP8s1MAMhEOAwp2JeGJsojLXqSciVTqR0CWoeVi
         jGxITenTUnrNNpe64L4rnEc3h5AlzZ7emeLz5BWKlM/RYq6uT6n1b5sM3On9uei+mXg8
         3GAA==
X-Gm-Message-State: AOJu0Yxob/5WV5kRpxyQ7b5tnQ/nbU35PvMtybXegj0QfAZQuTzM6Z9X
	l0PjClyHo+vLPL4B+ZiCwurCBD9UKby9cX94YAR+jjMWocEAWOKuU/VdJlnvVagjEusiQZJ8E/a
	sozObf/KhE2wb4MNmhngKHhbviHbLZUGaaL6wtXfoe9fyAy0/L4AJk9I=
X-Google-Smtp-Source: AGHT+IHyYMYpQSAuC+Ivd90qhjJ0OeYJzpFte2X8Lk0dunSSh1OukqtK6BjPewm4FLO2wGwskSlMaW+7DNfm3/3PAe8eELo18ww+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:3d4:6ed4:e0a with SMTP id
 e9e14a558f8ab-3d595eddce7mr91123065ab.4.1742778103816; Sun, 23 Mar 2025
 18:01:43 -0700 (PDT)
Date: Sun, 23 Mar 2025 18:01:43 -0700
In-Reply-To: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e0aef7.050a0220.a7ebc.0007.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
From: syzbot <syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Author: lizhi.xu@windriver.com

#syz test

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 2956d888c131..cc8bb0650b8f 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -309,6 +309,9 @@ static int ocfs2_add_recovery_chunk(struct super_block *sb,
 	}
 	memcpy(rc->rc_bitmap, dchunk->dqc_bitmap,
 	       (ol_chunk_entries(sb) + 7) >> 3);
+	printk("bitmap has been memcpy to rc, %s\n", __func__);
+	for_each_set_bit(bit, rc->rc_bitmap, ol_chunk_entries(sb));
+	printk("bitmap has been inited, %s\n", __func__);
 	list_add_tail(&rc->rc_list, head);
 	return 0;
 }

