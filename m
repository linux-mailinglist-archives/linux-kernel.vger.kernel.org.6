Return-Path: <linux-kernel+bounces-334563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A797D8E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C491B22F86
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05017F4F5;
	Fri, 20 Sep 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjoliJ6b"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430881428E3
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852455; cv=none; b=Dd/scTfIARZq5VztdY9Nuo//EwVjX0Foou/5M48OiHCebecnQ50ZisWytCY3NKvbWjyi13F63FxLL9Oeik4XMHM9sw8M7eGV3pyO5kpQXWQb/PkCCP5WkNtw+0yUDnwA+N7+rzkguUphsuAYf3m1RP7FLdGgnjKDFdfDu5gdUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852455; c=relaxed/simple;
	bh=NbsWkdKZapI5u/K/ByhuiHqzqQAr+84+x0EVM5wlJRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGKjtfC8vaJPPmCRfWoTPhLue7olXa0t8Z1pV0sJzw7bpDISpHxj/DD4+LBRE8ePu3vCYca19ZMBHa+j/kGR86yZxgAVtVlxESZu5h+Jlk6FcGgvFNJmiriQOMz+X4dD5zxryOvDrs/sucV80me3t0MWrgt3e8DqwlFYSd5uVV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjoliJ6b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20792913262so28746685ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726852453; x=1727457253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9GpAYEXTR32AtgiCpBU024/rX1SOh8LuZTvjZQtj0E=;
        b=mjoliJ6bXSDlxEqk9nEQsZUhLGbMhXrqUaG45FAXYPWWBea9qQAov4xBDUh14yHXBF
         DG+T1Vh0WaxMtaYn/KCvpsEJGtrgD7dDco5NaZUJgEH3H36Ji34jdu6H4961p/5EizU8
         /i5cVxwK52cg8Cd7AN9NhdQmK0hppIqPuNcVGpAA5hNpw4iogXBVccYnVvkZ7Cz9y9mC
         IUlZkaqURwcxzSmC3JOs7MQ1IZpYM3F9zBLOr2TZahXY9fHetf4f+SAG5K+VgQgPdsE9
         zYJFw/TsXqlLVQ8nOGnTL4qAcYGkD//pN10I9IWM/I4Rin5ZRRGxgeNdUiWMK1mr9xe1
         Ovxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726852453; x=1727457253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9GpAYEXTR32AtgiCpBU024/rX1SOh8LuZTvjZQtj0E=;
        b=wXIS0k41vulWhiGLTT7U5ZkQA45oBrPG3prY8Ld5rmQ1vpLac6rNeQgbZP2eNdXo6e
         GdGf7cKrq84x3u0PmWUIlPVYKRpF6kStj8uQhgfUtgDDQ2/BZiQI0JsRmy6cer2sUpqg
         +KdAYlRFknpnwuuzYkkVKzWwYQQvxWvt7WSGuCkrrAJAUI2lEeNGWh8QaNWQNCL/zU3v
         fB8wyoc/GpzDHTqSkuf4cWwzZRCDN84T9yZ1rgD9SOthrj1atuG62788hE9In2aQmFku
         y12bumF76pIAQ1A2KSQVWLO3Gk6V9ChmzZ1D1//hjpFLtT0YVCyP5kWysOh55clV7lz6
         UZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWdD6eiN7S2yHE7aDTxZ4pAyg7XGm+NbFJQIE6MCOl7jPGdYiVv7uqF9LwaUn4EWoMAVLVCzDZasbLE6GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzH9+rlQpSkE5gdCXkQmdA9y9ZxuvtU7jqJ/Myp8UC/y35bRuy
	6ighkm8CZv2jpmzvjEI9kwr8/JYOnXRhlB48Lbq2Y5BwmbtvhElp
X-Google-Smtp-Source: AGHT+IEOEpEvtym2EOUeqwklFBOreZPtvCX3O3xjJugnh42tfpKyvF4d9XA5qgIWcgauefW8qATQZA==
X-Received: by 2002:a17:903:40c7:b0:205:56e8:4a3f with SMTP id d9443c01a7336-208d843dc46mr41105015ad.61.1726852453509;
        Fri, 20 Sep 2024 10:14:13 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946010e4sm97855685ad.73.2024.09.20.10.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:14:13 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
Date: Sat, 21 Sep 2024 02:14:09 +0900
Message-Id: <20240920171409.4054-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <66ed861a.050a0220.2abe4d.0015.GAE@google.com>
References: <66ed861a.050a0220.2abe4d.0015.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master

---
 fs/netfs/write_issue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 04e66d587f77..8e708d1f7c9d 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -427,6 +427,8 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	 * Also skip uploading for data that's been read and just needs copying
 	 * to the cache.
 	 */
+	
+	spin_lock(&wreq->lock);
 	for (int s = 0; s < NR_IO_STREAMS; s++) {
 		stream = &wreq->io_streams[s];
 		stream->submit_off = foff;
@@ -488,6 +490,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		for (int s = 0; s < NR_IO_STREAMS; s++)
 			netfs_issue_write(wreq, &wreq->io_streams[s]);
 
+	spin_unlock(&wreq->lock);
 	_leave(" = 0");
 	return 0;
 }
--

