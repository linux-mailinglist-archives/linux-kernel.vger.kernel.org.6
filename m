Return-Path: <linux-kernel+bounces-396547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D799BCEC2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F01283763
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02531D86C7;
	Tue,  5 Nov 2024 14:11:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DCE3BBC9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815888; cv=none; b=NXp5oSFZcmq3AaLABBtxJZHAZXbEcD9HhBIq9xI2QBOrctjkcJ1gi+HbykyRSmWu2vctr33AjHWobxSNbR0c7L2vJGMQHVbZpF6yOthAKzmN4tqJfWzVXI8Z4fPo0Jx47IMSdBeMEXxmhSZS1HTXgFLz7J5gx8mmmrlJ3FiQHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815888; c=relaxed/simple;
	bh=VVvd6wnliKzyqOd/crm3avu2yr82yXazf5eFet/rH8o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hS0U+ravbFW0UU/uRG+vAN2lSV8ww/xFPKt/hNCjNdhHIY76n4mPTWooiJulCQ8jLUfli9+WsM6fxCGYL+vNbzaLiSSsKHX2JtqrgjOcWiAw8UsiXHHjgJjGFhbKjYKLCneifbwdaLQzdAe63p9f6ihRR8PIMUQ+3X3WIYjQQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b563871eso46509835ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730815886; x=1731420686;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aLZdJxea6FUcuU9V1mSzT+dQc9l3Q3A3KKXOSXgY/8=;
        b=n/1QeyX9Xqir8g0XTwcziHEgqSD7q2q5lsf1WHW3gxjFEZdHz9hWC0K4dDVYHBvHPk
         RB4N82hNCercXbJzntc+yn5tmEti2vJIunVb+xdh4VLf0ZlmCmzgYKeJXz7S/48DNUWy
         SC/w9qtRprcBxzQxloKeVGTjCGfFEyExoqpUAvBQ/OFQlY5tRahHHS7DxcA7hJZGMv4N
         BFenTjjnsFaC4fgJUNC3YX8gNMVv+XYBFRyE9wUCQcgIkdTYipcE7Prqj2mvBU3mxGXm
         X3vivHYV+CdJ+b74yeEA/YImM9M1whsMUsQQcGfW7nXnQdHOPQzYfgbZI7S+WCn1rNqu
         I2XA==
X-Gm-Message-State: AOJu0YxXH+RlFJ+6Z0p0prQMAQL82zmd7Hw9k9iX5JW4FOO0bdaCErmx
	m6YvAjqqyLy6JXfJztr6LcTbeZ14PEH89flfd08LnFPjsvXuX/4Y1A6pR6034PZY3Ido82anlsE
	JfdLE2e7vgk8HAj5YGngXScJIa4Vp/YTPXu7SkOmddcmw4g0DEmbabJw=
X-Google-Smtp-Source: AGHT+IGtdEnhwdnMUO6XmmY9xzRNsWSWeugVhwgjK0ZuMmrcC7Zo3NWQ2+MCJJKMTyfZR4s4F86jGfLtAXDOtaX3T8Bei2DCsEt7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d16:b0:3a6:c493:7395 with SMTP id
 e9e14a558f8ab-3a6c49374c2mr85678245ab.5.1730815886090; Tue, 05 Nov 2024
 06:11:26 -0800 (PST)
Date: Tue, 05 Nov 2024 06:11:26 -0800
In-Reply-To: <671d8887.050a0220.2fdf0c.0230.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a278e.050a0220.2edce.150b.GAE@google.com>
Subject: Re: [syzbot] Re: UBSAN: shift-out-of-bounds in ocfs2_fill_super
From: syzbot <syzbot+56f7cd1abe4b8e475180@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: UBSAN: shift-out-of-bounds in ocfs2_fill_super
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2e1b3cc9d7f790145a80cb705b168f05dab65df2

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 3d404624bb96..9852067570e3 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2319,6 +2319,7 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
 			       struct ocfs2_blockcheck_stats *stats)
 {
 	int status = -EAGAIN;
+	u32 blkszbit;
 
 	if (memcmp(di->i_signature, OCFS2_SUPER_BLOCK_SIGNATURE,
 		   strlen(OCFS2_SUPER_BLOCK_SIGNATURE)) == 0) {
@@ -2333,11 +2334,15 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
 				goto out;
 		}
 		status = -EINVAL;
-		if ((1 << le32_to_cpu(di->id2.i_super.s_blocksize_bits)) != blksz) {
+		/* Acceptable block sizes are 512 bytes, 1K, 2K and 4K. */
+		blkszbit = le32_to_cpu(di->id2.i_super.s_blocksize_bits);
+		if (blkszbit < 9 || blkszbit > 12) {
 			mlog(ML_ERROR, "found superblock with incorrect block "
-			     "size: found %u, should be %u\n",
-			     1 << le32_to_cpu(di->id2.i_super.s_blocksize_bits),
-			       blksz);
+			     "size bit: found %u, should be 9, 10, 11, or 12\n",
+			     blkszbit);
+		} else if ((1 << le32_to_cpu(blkszbit)) != blksz) {
+			mlog(ML_ERROR, "found superblock with incorrect block "
+			     "size: found %u, should be %u\n", 1 << blkszbit, blksz);
 		} else if (le16_to_cpu(di->id2.i_super.s_major_rev_level) !=
 			   OCFS2_MAJOR_REV_LEVEL ||
 			   le16_to_cpu(di->id2.i_super.s_minor_rev_level) !=

