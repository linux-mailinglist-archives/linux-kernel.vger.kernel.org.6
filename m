Return-Path: <linux-kernel+bounces-348256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D60898E4B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81755B2232D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A888197A9B;
	Wed,  2 Oct 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv/MfdwN"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753419412A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903819; cv=none; b=t6iiZGub7PFnDx1cHEm8RFgvU9/QuZMNF9yrO2k/H8Df++F8sMbPLfT+nfMYklt/OOsbaKL2rGynlquP/Xpy+Fb9Wmvltcu4rTsiAYH5cl7Tb3h6SVcjsN8YMtyWQkYjmzlwgXLvaZocmbaw+3JJ29czLsr40Ckm7/DnQeFZjxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903819; c=relaxed/simple;
	bh=RfSFHWADYneQcIf5xGLIwCziXwiZM9RcFvth2ODB8Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MrSCettZkTG+6Pf6ZCn26loXjz0zZZcM8HIAorUAt8aOHwIdxrYiydRZKf73+va7ETCj4Nt0ZOnBjjHMIYFXAYH3HiwcXLw2Aacm7FEkzKy8JC4v7xmtg9QyoB48s4ihw21IMg37HXVvGR5Z06/qNWNpdLoeoNJGf4qM8JH9AjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv/MfdwN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398d171fa2so262065e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727903816; x=1728508616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgE/GtN6XpPB8b9wKIT09hMuKMKhba6x+FDLpjkpY94=;
        b=kv/MfdwNrPQli39gMZ1bV5iCT7/Yj4xNwgrF/kmsVnU2asI4pryo+NXQq3+TTnN23a
         JlrJklG1oBst1W2bGcyDlmQylY3dO6qiJawqQ6x8QhCB+hhuGqoxRKntSSwqCjFLQ2/T
         m4O7IRxDXEiRKiBn8mcthclf0KzLBQEfJ69aJd5lE+f3dgkMW+2NVZ/pLYBNwlfNb72m
         gHv2+XJxk4MD3wo6ne3OND3yj/MJPNcXEgRxPE7sLc82uB1j13ZSiu7MHViRJS7PNDwp
         EDJ3Iux7lVbFS2sfPNLx+2szcwonoKsTt4a/s5MpTNYgg7NH/T3Y3aXgn6OfT0oGfYMD
         /Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727903816; x=1728508616;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgE/GtN6XpPB8b9wKIT09hMuKMKhba6x+FDLpjkpY94=;
        b=Jvna3QtzTKfXn6t4cFxjWfEUQwTebwmGSVSKk4sj0XOeVZz51uATqs1/1KArAIdJBj
         nSXzLufGWI2o1sGQBiF72NQVe51uykqBUWs1ojOgOCreLg7VWQOyAZHsdTfS0QlismD0
         AgWAGM8Dz2A6jsfX0EcLOTETewRWw6kHJnwQDAfeyTXxrhrRSIFpBkYO/o3Sxk3KWKRl
         9oYKWtvkSExEst0PDdqpwOsoaxsbg2VRm2WWM0Ip+mm5LOJzu+mgw2AcpOMvrTnH/ZlK
         01SJfqe8hSpMD/PLzoBS6HzsP+phORQd2IwUtP9HVMDaV54TXXEtuKYed1v4i4idEOh7
         IHBA==
X-Gm-Message-State: AOJu0Yx7oCgIhjRAy0H8xflpP9QJyogrba/KhFGi2W1Nn3MUIM/j2ctm
	nsXCpN0Z+oZIEWHVmppqyl4pQES47w69fUM6ophC3yTSJsTnCpVf
X-Google-Smtp-Source: AGHT+IHjmIvHN4V1JHjU70ZSan5qy07G4qGodauov/TvWSY/1Tjmp6n9XWNa248Gy+ER/DKan/Zbrg==
X-Received: by 2002:a05:6512:b89:b0:52f:d69e:bb38 with SMTP id 2adb3069b0e04-539a065e0bfmr2930273e87.2.1727903815552;
        Wed, 02 Oct 2024 14:16:55 -0700 (PDT)
Received: from gmail.com ([45.250.247.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27d198csm918719466b.86.2024.10.02.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 14:16:55 -0700 (PDT)
Date: Thu, 3 Oct 2024 02:46:48 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: chaosman@ontika.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Build failure with GCC 15 due to
 -Werror=unterminated-string-initialization
Message-ID: <ytw2hroanhyyvrh2ps24l2a6qsdke5m67ynfqcqpzo7wgp3ibv@spvsq3mzltnk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

I'm building the latest kernel with GCC 15 and got this build failure

fs/qnx6/inode.c: In function ‘qnx6_checkroot’:
fs/qnx6/inode.c:182:41: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  182 |         static char match_root[2][3] = {".\0\0", "..\0"};
      |                                         ^~~~~~~
fs/qnx6/inode.c:182:50: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  182 |         static char match_root[2][3] = {".\0\0", "..\0"};
      |                                                  ^~~~~~
	
This is due to GCC 15 now enables
-Werror=unterminated-string-initialization by default.
This is not the only error, there are many such build failures in
various subsystems, some of theme are easy to fix, while some are not.
In this case I was thinking of something like:

--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -179,7 +179,7 @@ static int qnx6_statfs(struct dentry *dentry, struct kstatfs *buf)
  */
 static const char *qnx6_checkroot(struct super_block *s)
 {
-	static char match_root[2][3] = {".\0\0", "..\0"};
+	static char *match_root[][3] = {".\0\0", "..\0"};
 	int i, error = 0;
 	struct qnx6_dir_entry *dir_entry;
 	struct inode *root = d_inode(s->s_root);

I'm not sure if this is the right implementation or not, but I'm always
open to better ideas (or just increasing the dimension of match_root to
[3][4]) and would love to send in a patch.
-- 
Regards,
Brahmajit

