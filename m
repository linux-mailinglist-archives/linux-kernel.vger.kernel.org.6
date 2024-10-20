Return-Path: <linux-kernel+bounces-373091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943089A521D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552A6283EAD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 03:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996973D64;
	Sun, 20 Oct 2024 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm2RPNDd"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F18F54
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729395143; cv=none; b=p9+f26fM0V5p/cmHW4rsCaIgGoRfzMjnsS6pUOywSe4YQubPej7Ig9JXBSm7Iq5oigP8bV/7CbHO2erTxNzmWPiu7e+4Zcl9UkHu2+7F26YduS8gqQrIBRYPEB+a1N7bjbrwRfipkm1wDdnpnPkUTFsZsQiuaDTbttuFbGb4kMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729395143; c=relaxed/simple;
	bh=xCK3AXY8CDW1ReLuuT8y4IcuNqEUNdip/M7kljNMa6o=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s7RfhkXDQGNtPgtV+KLUL/zsoYA3is4XHADj7IcZLI1p6oRP5hTzyWfHXUoAmAP/NQz59UKdV+JWbKP3N/hJkrnU4Y/7h1/x1lRFiAMcYEa7dQQt+wUnle70y3qFsUNyQouq8bZaMviMCzcbfco9DnEzDdSTYizkrY8Co2YxLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm2RPNDd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c77459558so29444665ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 20:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729395140; x=1729999940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arsoYGK56l+bg8s3KsyQtHRFxcfKcaAdMop/4D8FedQ=;
        b=Qm2RPNDdy/WyhNAvU3xTFrtutQMUvxjUyABNtNq3r83QpdHmbNl9+lG5mR4iKRShGS
         4aAVdNa+c3U2cfAZewavqk8RCtKdEki4ZFbl4IATkqdML92q1YUEBxltR6gh6URaSipE
         fe7WLJplClVEqdbNo9oQCDXiNgLaj/UNtmg8+4+BAu2cTGkP8XKV5oy3IiqfbHEM2srJ
         ubTB+r8b9BPncfZJ1iNFM3yhmXG0oJpd72zAw6HGCzda1WHjjnFjxPizNkxVPxr6zeFX
         xOVADnLcy7Wf/ybo/MuUU490cTYDOHXZ4IJoOfpJb4lB3Bnecoc18CKL2C//q0cr9/84
         cJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729395140; x=1729999940;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=arsoYGK56l+bg8s3KsyQtHRFxcfKcaAdMop/4D8FedQ=;
        b=S8U4kehMdvwJdWNO2VRQdkgikpCUv4p3IAw3jH8hwXNC+TxayT91XrM1IQv/CZN1P0
         zw0KZTIlLEQ9LHPDdnK+Xhq//l1rsOhqtF5XHqzvyviOatmOuLXEN0l7KG6zRVa+4NB0
         f3NfmK1b2x8nnSTxj8AKnfqE4tPMpIwV2fKj02Ib1J1U9HsAGZ0Sd5/DyfH2KQ4AYtbe
         9pdBqZw+7eaxuqNMA25joROo6/t5nTsJ7iyCCPiwLPVJ4f1fN6Cuq/czx6Mu2yTDe1lL
         cVJL5bbZ+bJ3MRmoPmjF4VXcGETiPZZrrruRlbKUfzZY5MPKK8od43CJygZTxjXlKJX8
         q+1A==
X-Forwarded-Encrypted: i=1; AJvYcCVwUgZavEcafSi7zkJ/EqzWsA6TLzWX5bUd4YSnTDtOrerU8Tq6+FTys9aN1R6R4Xkj+vVZ7t5Ycbq9WOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIB+Ri9nuCQXBTs63brgfQi06w3SXjUTRN0TDVDaNqgj5n0dx
	YcyCE13pMe+HRA2RfEH2HBZYWmLsw8IRhadjgwMMSst0LT6MlYDh
X-Google-Smtp-Source: AGHT+IHiyKI0dC0d3iVl6Ljx0+V63CQHq38IlTeH2R5whHvajTvEZhI21MSVDgPlrdXlnV9xIT20PA==
X-Received: by 2002:a17:902:d481:b0:20b:8a93:eeff with SMTP id d9443c01a7336-20e5a933726mr86356635ad.37.1729395140345;
        Sat, 19 Oct 2024 20:32:20 -0700 (PDT)
Received: from localhost (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd561sm3942405ad.179.2024.10.19.20.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 20:32:19 -0700 (PDT)
Date: Sun, 20 Oct 2024 12:27:52 +0900 (JST)
Message-Id: <20241020.122752.543927907848385586.konishi.ryusuke@gmail.com>
To: syzbot+9ef37ac20608f4836256@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [nilfs?] possible deadlock in nilfs_dirty_inode (4)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
In-Reply-To: <67134033.050a0220.1e4b4d.001f.GAE@google.com>
References: <67134033.050a0220.1e4b4d.001f.GAE@google.com>
X-Mailer: Mew version 6.8 on Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


drop __GFP_FS for symlinks

#syz test

diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index c950139db6ef..bcd7d1288e2c 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -149,6 +149,9 @@ static int nilfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	/* slow symlink */
 	inode->i_op = &nilfs_symlink_inode_operations;
 	inode_nohighmem(inode);
+	mapping_set_gfp_mask(inode->i_mapping,
+			     mapping_gfp_constraint(inode->i_mapping,
+						    ~__GFP_FS));
 	inode->i_mapping->a_ops = &nilfs_aops;
 	err = page_symlink(inode, symname, l);
 	if (err)

