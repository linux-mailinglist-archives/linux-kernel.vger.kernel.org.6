Return-Path: <linux-kernel+bounces-404645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B19C462A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD121F22512
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE9F1AA1FC;
	Mon, 11 Nov 2024 19:50:55 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E615699D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354655; cv=none; b=Qgk8p0peweL7J4YJO1W9OCi6CE5YI257vciP2MV9AwdyPFQTrtJDeHhdNCMV889dCzOQGJnKvrmOeNAyuvKPJq1zB4JvDqHCYVBBL9/hjgbpb4wqbCkrfk+UEm9djXZzI3bk7lLiM4mz5nnYzJDG4TcilEATxzpMqN7JpX/2A7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354655; c=relaxed/simple;
	bh=awlBS4uEWwv7MOtK7Tsg64A94yFG9RnTSBCAfQMfIIw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=acZSZM9h+eQHr9pY9hrNat42GRhOetaubZuuBCXdkvvxh6YxmQCeypmVdTKXM2CxXNLjJ7bLrPFlS8nmJduXy3Q/qwIcVmqeEOdbyR/msFng3trnliUh0YbM4msj0UYk8yecwMWdftXDsNPqUPJlK2DWggqFJAUamKq717MY7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so57305745ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354653; x=1731959453;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50jaUbBaJfyYlZA3vINtA4QNrKfUDA6pCOzajeckYcM=;
        b=swrRNL2ioWg72Kt7hC2RDXvFwYDAKWGYmXfBluTcKTwXNTNE9Zd+w71anSS98y82Gl
         hai9THdasXIhspyTPXR3iqfKlGLbzJpPZJvdG1iLtbpU2IROjb1sJFmng6VsuknYJWoh
         hA4pkqLGtU7M7pwEWOVg5mUgSlHiKBGc9XY3UocEE48mmcEHCPdG9kMopx17fErJ7rm2
         SbEDVNRDyypu/XT8sCCL/R5PN6OIAtFnSkBC9jFLnRtLE9CxFTpoh+k7I1Z8y/qFEnBD
         5k0rz6fAdfovP+GNy4/FBShoLxCgomNRVdk5X0rK+yRP7WjVXwHxxtfqiQ/m9mn1iY4u
         YH+A==
X-Gm-Message-State: AOJu0YxEDqmRJb9xAPi+DEE3fwv/Uu3iDck5xLEc7zisJTfPBR8gXNWS
	2yZHqMVahwBfZ2RO8kYJ836zTwO0Fyq3pM6n5YVLlnyn4CL3XzIbn+8tU9XcF6k7mPS550UjJw7
	g1xq5f8PGi1uCj6IqyUVIJHtOxy9G71RHWTeYqMooMO7z09peAbixIDk=
X-Google-Smtp-Source: AGHT+IEgujbNB08tQPl0ZpS/3SAOcL3Zjc0EWNgef263usqUe6sTEkhYhH8FOEd2cynzv0AJRyM0CoT5jfRNrr9yffFIfPCjUspQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa3:b0:3a6:c122:508e with SMTP id
 e9e14a558f8ab-3a6f1a48b4emr136427385ab.17.1731354653062; Mon, 11 Nov 2024
 11:50:53 -0800 (PST)
Date: Mon, 11 Nov 2024 11:50:53 -0800
In-Reply-To: <00000000000005d7e10617c3a3f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732601d.050a0220.1fb99c.0153.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in hfs_free_fork
From: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in hfs_free_fork
Author: gianf.trad@gmail.com

#syz test
diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..c74d864bc29e 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct 
hfs_find_data *fd)

  	fd->tree = tree;
  	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
  	if (!ptr)
  		return -ENOMEM;
  	fd->search_key = ptr;


