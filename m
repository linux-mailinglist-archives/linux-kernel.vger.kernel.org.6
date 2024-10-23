Return-Path: <linux-kernel+bounces-378324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D359ACE79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9F4B2A48A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC521BDA8F;
	Wed, 23 Oct 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbSGPSpx"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B419DF53
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696687; cv=none; b=SeiNyms++i1C26EmdcgY+gw9gB8rRWRe3AU+f2f3StlnoYDIjmXxyBjtnhTgF77WVr6R9fPhXIxY0S3RUrscQnQQND0UwKpZM9oJKs/S+50BNCCsWoPJ5bJ3pzscBsAdhUwyYaaNjXv+qDCEuXPvJy6Lf3J8EVNiCPAc7gkGIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696687; c=relaxed/simple;
	bh=dWdoZzHszW3brg8gAfeu2/QMJlLzydhP1dBj7+cHP9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6KmE+0gVP/K/LPgTFCj055d81ZxS5lw+kHnd7f9eBxjvjUtCJRrZIH7zp54vkg/C8yLDh3pfqhXh1JnxCx1e/idoSqy5IaBDNOOeoxbQi6LAfW/B3TaO994KbX4y+up14zdyVrNOCTWqqbpahHYUgfmIlUgPWKF/kLcFkQ2ZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbSGPSpx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea8de14848so4367074a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729696685; x=1730301485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiDJdCKva/Tyt+f+8HI9bLffBfsYVSYNNBQW6B2EfMo=;
        b=XbSGPSpxvR3O8hyIbes8U/hHlK7E29a95C83Tzc6oPmkmxhm6io4I/qBewVazZ7cac
         t15Z1jhT+8lnpqnSxTBf1kL6ng7XXWtFercNXATXCvldXGDwr8gpFYPK4VgBSz6jfDEe
         dzIhGFbPgho1oChNy1UkgwKfuBoiaBl4bLszwPoDdW+E8v4sWNzcmloiz0BRyfYQfnQ3
         X7GJw+l3G6scyU6Jc+zsS36gXFpusnAvLuhgwkMlxYymYoFgRhvdvwyU/RQdbY/F2eT7
         MNT/p2Y3TH7hvPINK/PLyIJ1emoIhuKhXHsLDQ6MaIJhbvb1bdITE+jpa/T2x1wDAEnF
         +9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729696685; x=1730301485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiDJdCKva/Tyt+f+8HI9bLffBfsYVSYNNBQW6B2EfMo=;
        b=iJYfM6d5ckasyDzny7dy+Yk94VU/SG7fzEpXFo62W74fikUrUYN5EVIS+8t8T0R0G+
         fFV8KNQ46xd9GevGMMvXhcNWRf/hlRXDasrJMOaJbWaFnH5fUaFumZ/g4YTZCNA97Arh
         GGhz5VTYwXiiUxQooRIQ0t7XT2Mhw/kGIwuG1cu4AbqcdYj4SSA5PuYQ76Kdoe8MK8VO
         5lnFtOTBS/DIkJaduZxlOKlSGhnBdzKd7NcOjKbDaPbSUQMaFuN8gqO4cJho7/2gcWmz
         ffn1U7PdKlnTo8CH6ZLFnpc6knX7VU7/bRt/GlNkAR+7k4qDgy+iuIE1IKfSpIZeyigY
         wX1Q==
X-Gm-Message-State: AOJu0YwVxDA++K12gYIU3cxFhjWNnRMEV5VRCwGVClHTcXd6FUxHuh8j
	Jm7JDStmom8IpN5WSdDRbRYlO4iIW/wcuH6TsnlajSK0YCAywuvbt8BEtR4j
X-Google-Smtp-Source: AGHT+IHEaJH5ChuU/A5/XmQDnGBCs+BowRlygo0U4P+/A492kj/oAc7o5lseOYzFOfVwf5gdn7fYeQ==
X-Received: by 2002:a05:6a21:3a84:b0:1d9:1584:9131 with SMTP id adf61e73a8af0-1d978bd620cmr3014112637.50.1729696684912;
        Wed, 23 Oct 2024 08:18:04 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407d8dsm6472756b3a.186.2024.10.23.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:18:04 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [bcachefs?] KASAN: null-ptr-deref Read in bch2_sb_set_upgrade_extra
Date: Thu, 24 Oct 2024 00:18:00 +0900
Message-Id: <20241023151800.61444-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6718a343.050a0220.10f4f4.019d.GAE@google.com>
References: <6718a343.050a0220.10f4f4.019d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/bcachefs/sb-downgrade.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/bcachefs/sb-downgrade.c b/fs/bcachefs/sb-downgrade.c
index ae715ff658e8..8767c33c2b51 100644
--- a/fs/bcachefs/sb-downgrade.c
+++ b/fs/bcachefs/sb-downgrade.c
@@ -143,6 +143,9 @@ UPGRADE_TABLE()
 
 static int have_stripes(struct bch_fs *c)
 {
+	if (IS_ERR_OR_NULL(c->btree_roots_known[BTREE_ID_stripes].b))
+		return 0;
+
 	return !btree_node_fake(c->btree_roots_known[BTREE_ID_stripes].b);
 }
 
--

