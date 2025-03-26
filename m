Return-Path: <linux-kernel+bounces-576413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939CCA70EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2753B8D11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851012F5A5;
	Wed, 26 Mar 2025 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOhDP9Hd"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC71EEA9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955562; cv=none; b=HEV5TmWdVPplYXru/9VU8lXMXm6+z63JbGTIy7T+vJWk4KZiFFUGEFhqGaDacrhD8Ly5obCBj3iHWnjwvb3p8xJ+y2030H0cht39TUcsgj83w9cT2Cu+SncBXvUCd9Xu7wDi5AAmdfzzdUw7fVAJXQNLEQ37iX6PQDhYNcxUMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955562; c=relaxed/simple;
	bh=TfxFK9jsSWKqRnxwXCns93febKGMUKg797Y4sPzkXAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmPvVib2SjYQ8Fpb3WtP4oan4/MJNZGpZzDCfZDVpDaGTr1bNM7LrptgBZRO3iWloJPJf5vrQRzJQbLMBuGWwH89r6S0yS4FfVQoI+9eF3pp/T/m0T9ZbI6gtROfID2zlpt2wSC5i7cvUOuNOtXrxvhKbwRZJiaj+gB9heDmAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOhDP9Hd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227b828de00so57999155ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742955560; x=1743560360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAT0zokbIOKhPWn+286xYZMuNKFDGnURedHLTd/KJUs=;
        b=MOhDP9HdOJljQi+AMMOSx7ktDk3KXPuoecwD6Q1RzE2tW4yhiDawPKDFUYg0z9JBnr
         Bjhq0OHEWP0Eqc6Cs5AHewYfd+ZotufUioHeUG2t7wwnjlsMQRZF7T0P/VFiY4EoVzcb
         YpsGejnCdJYJKdgsFvuJnQMc15XNkp1VN/+6PkA3n4jNYPrydo8R85pbL2kosLoIFJnx
         VJK4Ois/LSiEsU9L6+BAEjHP+OeEaRTNgGNNyQlCGInR5AvWAaKkPOdicjGauwp9DD2N
         QGN4MKQRhue7wjORBD5UmLBobQSc+56uK/i/9G/fE7IfL4l8KxRALJ5aO6jT/7KV1IAr
         2N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742955560; x=1743560360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAT0zokbIOKhPWn+286xYZMuNKFDGnURedHLTd/KJUs=;
        b=pSi7mwtMo+nVXZN8ydFD1HCZ74Gqu8CqdwzCHBIN88DsZ9XEMWBpK5JOGj0vtbZeZM
         6XMY8QT/QzRuXe8kJRfKInt4c8O37cQ7RBP4AvbuPWvlqOTzIbKaYQnBj/lW8DCFmRg5
         BCMN0HEmCItAmHyIZEMij2ep0AI6J+v7eyTQbZiO1MJWFa6XGfzlIXiEW/sl4PRlzmP4
         DdPm/TCzcoa0l34zGF7Ov4vB4yXbf8sclPADl107qPZDMU2UUoTZKYHFsaL4Rx/kmb+o
         HLEnyRkFPtcXy42aym9qUeG8m9oVpprGLzR2puo2MS1GhxM+wPODxGzYvkyWb/6m2gzG
         dGBA==
X-Gm-Message-State: AOJu0YwXoPqnRVH5LJW4xXnH+trvZJt6ZaiaSx3N2fSwWkhW9bSO2hA5
	PExW+oc2esg5z/pStajEPihL/K5hh4bIT+gmoKIEd9pokntkQa45
X-Gm-Gg: ASbGncvZR623h6fnfjKznSv2oy1AFPU26bBjAMhcn5k3hhkh1H7hbhXtazjxDN3VOOC
	eZcRZCyFiYa3/DmUTqyKlaTDBcFkDd38LmVPSIBX0ayWuSeepzng9PhTzTPLyrpS8UTDQ/u4lIx
	gQp5/p6pXUc1UG53vFeBkcmqE7daeJaGjLCgfbHbf5/HrbkAFloeiCYiY+2n4GKLLvnbT88m6/E
	99HX6hBUgr9SRfFZbjjd49UTmQsPhD5yrveeDHu+0c+DU3yqlaDE1fawSRbgTWQVrBMGt5Q5SJj
	/A2SuZwJP39VubohI4G47jBEF10AqNmOv0hBGaALhmFQ1GM1262mjWkExTNAQsKAUkYL31VW0Q=
	=
X-Google-Smtp-Source: AGHT+IE9MGbXHDllv+CWXOFGyfbZpdi2K2ZEOSrOrv5zn0f0h35JYS0x/syi4jJWc/3Xk5XNnUraJw==
X-Received: by 2002:a17:903:2346:b0:224:c76:5e56 with SMTP id d9443c01a7336-22780da3761mr286694315ad.27.1742955559733;
        Tue, 25 Mar 2025 19:19:19 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:7cf9:c75d:456:248c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3966esm98323905ad.13.2025.03.25.19.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 19:19:19 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Date: Wed, 26 Mar 2025 10:19:14 +0800
Message-ID: <20250326021914.49794-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
References: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 2956d888c131..c0bbfdab40ec 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -302,7 +302,7 @@ static int ocfs2_add_recovery_chunk(struct super_block *sb,
 	if (!rc)
 		return -ENOMEM;
 	rc->rc_chunk = chunk;
-	rc->rc_bitmap = kmalloc(sb->s_blocksize, GFP_NOFS);
+	rc->rc_bitmap = kzalloc(sb->s_blocksize, GFP_NOFS);
 	if (!rc->rc_bitmap) {
 		kfree(rc);
 		return -ENOMEM;



