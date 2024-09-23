Return-Path: <linux-kernel+bounces-336303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B6A97F1DB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0D3282288
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B781723;
	Mon, 23 Sep 2024 21:06:51 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4F745CB
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727125610; cv=none; b=KO6DxZLd35srmzg6WfyZxkgVQP8OduJHbqVMdHSe4+oxwrZz3sZnie/Xvxyqw4M/Siwof8DDbW4lpPZ3Csf2j1s5UQ6omCNtzcXpJm/R5Avx1VDeoyd0z2HUaqOMuDUX2YXx9qcycKG4RcfXkG+7qI8eH/syzWA16v8W3dhl+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727125610; c=relaxed/simple;
	bh=xJ27YGjTb6kEt11ds9Hc+m62X9fLlydZs1frEZeqeSE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E0516lT2u7VEnx6TnBlxubMe3JDwTSf3lg6eQzVSqHOAe4cv2aDWGWY7iQEobROtpB3sy8TK/pvth1zgjJG9fREwSvKN9nG2ZrW19FIs1ZKyhHuIhwUBfJcutT4sZ9uZzTmvtLM7OQiUlX32HTGAFT+kI5JTcfmbbiO0C23dILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a195122f09so18879405ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727125608; x=1727730408;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoARvqBaWs/tgSAO/fFg6+y31YQ5jyrR2UUlodLQxSg=;
        b=N/1VwB4i4M0Rql+iKmcd0MV+4lSh9Z9Pez10RzTSNSM9uABCCPrPJ3L5oZTrSAmZd+
         VGV+64lIwGwv3EeDxr2Ol8yfUz7UC7ObyjAcDal7amNHssaPDrEnTNqsxSBEbLQ20MF6
         5lie1/8I72xI66HywM3PTQd16llA1MUxIOe+LLEkd+oSQ7ujKeIE13OzKJ7aUeqMKInt
         hl38xPxJ/LUpmjiGnGsEvNuKnDbcYGcqfzKHIqmEQAh69us5ASAuZyrK3vAr8vGuT8OU
         QqIkny43/TrOOFi4RIlzziEEB4FQ8G/wahRCoLzQTMlvcqcsVV3+ifTZUPZGZq/QFlZA
         mfiw==
X-Gm-Message-State: AOJu0YzyRGRTen1dRYNu+TlYaiSvk4fJ//DSj1wprOeQVWHv4BtgGdO2
	Syg4LGCXtTrofsbhIMFs2gV1ugiK5kw8kW6zsyn/kyHgqJPmR4v91w25jSdY80ekBtnHO40M/rt
	/Ezd9jTOFxbFrGuICfy22ZFfrqKZKoi15fclqB2fOGNaeeGjdO3ZZM0I=
X-Google-Smtp-Source: AGHT+IH400ei/QuwhYBXgOIj6ZOY8s3XJmqsZglIugfqu55Uo7uacrapZkjz2DHwMAQNkxlr/vAYY/tfOYZTU/22QXhCcdIySdtb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a5:b0:3a0:a1d7:791d with SMTP id
 e9e14a558f8ab-3a0c8d679b0mr109252485ab.25.1727125608417; Mon, 23 Sep 2024
 14:06:48 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:06:48 -0700
In-Reply-To: <66eea5a2.050a0220.3195df.004b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f1d868.050a0220.c23dd.0017.GAE@google.com>
Subject: Re: [syzbot] general protection fault in __copy_super
From: syzbot <syzbot+18a5c5e8a9c856944876@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in __copy_super
Author: djahchankoike@gmail.com

#syz test

__bch2_read_super may return no error code when a corrupt backup
superblock has matching offsets with default opts, the superblock
is freed and is later dereferenced causing a fault. Assign EINVALID
when checking sb offsets.

Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 fs/bcachefs/super-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index c8c2ccbdfbb5..fbca0bd302db 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -796,8 +796,10 @@ static int __bch2_read_super(const char *path, struct bch_opts *opts,
 	     i < layout.sb_offset + layout.nr_superblocks; i++) {
 		offset = le64_to_cpu(*i);
 
-		if (offset == opt_get(*opts, sb))
+		if (offset == opt_get(*opts, sb)) {
+			ret = -BCH_ERR_invalid;
 			continue;
+		}
 
 		ret = read_one_super(sb, offset, &err);
 		if (!ret)
-- 
2.43.0


