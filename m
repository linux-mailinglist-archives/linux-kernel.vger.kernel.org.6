Return-Path: <linux-kernel+bounces-348292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961D98E55C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA404B2553B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53F217338;
	Wed,  2 Oct 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ1u08uo"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5DD217332
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905017; cv=none; b=rrriXo/Q0n3a9F9cg47byETQZH17dVpZ+H/MqXWaO2dcu97F8TufzammbhNiFKZwLQ/mvF4jz9k240zVYIlDvaR2xq/DFynOQ/QIBboI+24AlSXhRBum4lhpmca7oMBIcXtzh5rfbwCB9q6eWkMwoX4ZsYeenaW+XWt+0DY/QCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905017; c=relaxed/simple;
	bh=f8eH6Ybx8LSKFcqkab4pn7PDoiV9fXL6SleAYLs52iI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tRXAOIPXJXwixJdNsh5dGgpcvBUrCdRCVvLp615iNRXA+aoYci8LHLMQaHL4IZOZgb/S1Adrn4X7ji2UadhWA2cBn7gWSi4iT8Dk1XKSYI9ICM5n/910lO0Fc4J6vffSb9p/4aY+GG/036+ypCZYuPFsBcGvXW7X+fS75aVZ7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJ1u08uo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c8967dd2c7so172507a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727905014; x=1728509814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sar03Xx18E12/skAWSDYresQgN9sZh+UNUUvCkNCZY=;
        b=iJ1u08uoyVQAr5JVqtkuLHYcb4no3lhcnx/u7MwJMHWRRcjhGn64Yog38sxhYNlanG
         3v93wV/zya7zdNb6qedQjejzQ8VPup2HT5Ga+ViPL/2fa/h8W3GMkAMuEPhfEjpG05bS
         H+y+ozmVTzGiF0zVaGZtdTOyqk0jA4izz1eWnMQsjJdWl6In3c7NIuXN40SKtqs6poz7
         9BYS5uN5Ra5ML3L5GjgFEV7rbshkjRibirIdf3s+WqI9OYEdKts+u1gZCBegBoKzaUU8
         i+XoWWl+xKyRNYkjGUNctzX31dhwj8uewlKTq4CuiiCH+8nwK984YFDshTDfmJ6BUvR5
         s2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727905014; x=1728509814;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Sar03Xx18E12/skAWSDYresQgN9sZh+UNUUvCkNCZY=;
        b=F/GoR03J/Rq6Ph8FzbeBPsVbO0LScI69Z3wt54UY0fyuV0HajJLNfSG4v5RRrKUrlX
         8iyw6TP1y0bFmGMaZYk85WC5hUMC6AXihdgsfkyT5RSvuVcsm6pEmMDn/Jbs9s45JXwV
         eeu2WjmOS4BWpy7JZaoNCUBP3QNUuSaQC5y+i1RBE0242pnPW3WwE9A0x9KZDcR71mWs
         EKBw32mUZq7rH/NycI5w2tbDbil6sAvLKsfiYOxE8OW/AX81t/8u0Z/Shf9h5+NAdsEp
         B/OFoGcpGuXp+r/Nz4mvuTLOxuEbJnxFlnOHn5vkPiAg08aCr++aDz8Ss0GWlOx/+Qqf
         8V9A==
X-Gm-Message-State: AOJu0YwczwoslGKNf/DHc60nWJu15t352cTXTdwiMDsr8lNz9GrfXPJk
	AH5yDAic+wCrFAvIRqG+4lvE66bTKfnqqA92ymlyZ9cXZEPIcUWLLv8Qimo7Z+A=
X-Google-Smtp-Source: AGHT+IHD/GGR2oTIbslossFg5tzg6+jiViiAh9Mb4uUB8P8JPMBUvXB1r77HOHW1FyxWu0aPnRBSVg==
X-Received: by 2002:a05:6402:2185:b0:5c7:2122:50d with SMTP id 4fb4d7f45d1cf-5c8b1b8ec54mr3770235a12.35.1727905014022;
        Wed, 02 Oct 2024 14:36:54 -0700 (PDT)
Received: from gmail.com ([45.250.247.85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051c2sm7953098a12.19.2024.10.02.14.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 14:36:53 -0700 (PDT)
Date: Thu, 3 Oct 2024 03:06:48 +0530
From: Brahmajir <brahmajit.xyz@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: fs/qnx6: build failure with GCC 15 due to
 -Werror=unterminated-string-initialization
Message-ID: <x2x2thdwjzglhh3gb32au2ih5w2a5lbh5mulgsktzaa7tb3md7@zlyopjxbr5vz>
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
listout

