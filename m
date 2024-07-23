Return-Path: <linux-kernel+bounces-260477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A81393AA00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AB61F2292F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C63149C46;
	Tue, 23 Jul 2024 23:48:20 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4441428E5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721778500; cv=none; b=R8pA5vQktIlmbjIq9WJLrVl3NS6ejU2WHIN8NEufuJDO5JYrNtgiSOxPg7N8qr+wIV2KYprGMMmRZSPXxIYLdw9sgPzwj23e8tCInp9i4LTdVP/X8mAyR7SZEgxVvUxGNUC308gMuKYkPOj3LktYF414zh9Wz4Q+bAXv0JH2E58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721778500; c=relaxed/simple;
	bh=zaU6vsVY9SWz+yx6JEdIByAGb7PCniy7XaEDleWnXXw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jFjkY6u6mDi0Wzp9SR7UibnXu+D0/XILPtuUQQ5JOvPHbzgDjh43ukWQ20RsmTY7VfFj9zA+l8xJuSs+wwhnJIzin06KrfcEUeWBiccDSxMVGG8T5P89J0o/2pE/RHo+Wn6XgtYoVRhGnlCMVzR5Pf27Ib4GpjXeJGregSk/i7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-806199616d0so964519639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721778498; x=1722383298;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4w1yneflfz++ErvtAHzMq2rvhurcJbTA5ZAKzfYTX0=;
        b=ersajlklFPNgMLcpvyE6uoG/NdU01ya8aB9Ypg6L8TNwdEPtEPQA7IrhvV8FgVDYw7
         R/D3MnW3EoogyEVNOwhtQY4XeF880L5PAXOTKm1fk9NH+v16uR9knFTdt6ilbwTnR3xA
         92+MGL5JHfQJwhOdVAyWdla0d96HkWObj/aYUAeYJkD+ci8fm6WaV8okLKjyYjoHwnDD
         UhXZwMpEkSZ4V7/La7KgD208dEjVwWAlT1DBG/l/hOPVIYPdDF89D0qnZFkeYLt9EulN
         AYRnnvllP5IvsYRhVR7tDUQ39cjzeAFT1qt1ooJc/d4obDcnnDpLxolpPtsfWTYcXL8w
         4Uhw==
X-Gm-Message-State: AOJu0Yzsck7tmKwXAcSksSJBNm33kLRtrWsjf0E1hDykOegF0xZ1bJ0F
	bkiqBJXYaTcIXi5qfofra1P8DBk2ah9NnAauQ3EM/d//50UfzTMMj8+XhoGTszrTwJrKHGRk5dd
	KXAlpx2A7sf/Sb6rKGiBVYsEh00uMF6AmZKfOABVp8Fpg16/q0lgph10=
X-Google-Smtp-Source: AGHT+IG+NveKxBkt5WZ4XNaxLZDohksUd304I0vGyA8alGEYz/IHBJoozWtU9LdHHnw6iVVHsKoJ+BrAInTe3ave6cicIkM6ACYd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:9812:0:b0:804:bfc0:382e with SMTP id
 ca18e2360f4ac-81aa7cf6b47mr10385839f.4.1721778497406; Tue, 23 Jul 2024
 16:48:17 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:48:17 -0700
In-Reply-To: <00000000000078baec06178e6601@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b85b3a061df2cbd0@google.com>
Subject: Re: [syzbot] [PATCH] bcachefs: WARNING in bch2_trans_srcu_unlock
From: syzbot <syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] bcachefs: WARNING in bch2_trans_srcu_unlock
Author: cam.alvarez.i@gmail.com

#syz test

bch2_extent_fallocate should not return -BCH_ERR_transaction_restart_nested when there are no buckets available.
Returning -BCH_ERR_transaction_restart_nested causes the sector allocation to retry even if there's no space available.

Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 fs/bcachefs/io_misc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/bcachefs/io_misc.c b/fs/bcachefs/io_misc.c
index 82f9170dab3f..b5b92ef030df 100644
--- a/fs/bcachefs/io_misc.c
+++ b/fs/bcachefs/io_misc.c
@@ -90,8 +90,6 @@ int bch2_extent_fallocate(struct btree_trans *trans,
 				opts.data_replicas,
 				opts.data_replicas,
 				BCH_WATERMARK_normal, 0, &cl, &wp);
-		if (bch2_err_matches(ret, BCH_ERR_operation_blocked))
-			ret = -BCH_ERR_transaction_restart_nested;
 		if (ret)
 			goto err;
 
-- 
2.34.1


