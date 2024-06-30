Return-Path: <linux-kernel+bounces-235150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B5591D0C9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3304E1C2098E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D22212D744;
	Sun, 30 Jun 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lnkK7fA7"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E139ADD
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719739028; cv=none; b=cR18Lqwty+D+3/qVY0IVLDxSw80JHCkSywOgqpERj19rGBZjKTp2tEQYRfOXF85VtHWq+hChUL7pjk+wOUSz+j+2KW31++nBZhmEpYOogV78Lkp9thuB6RrLwhAhNj3gGIXvCSLXtFLLGJpuPhVQD6rc90Vfcm3D/MSb2kJSKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719739028; c=relaxed/simple;
	bh=bX7ZFvRHPigz2PpOmz+R/1fX7AVO6r9sR1w2lkN+3j4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=prSHIVqyffd73AtqZBi40Tl+ernDK0Ud3JRSUEBDY1axhNvZ9ljr2/MiRG97pw2p2AWUi+HtX2I5Nycn9LizZe5STJaEuvOMXrdjUU0R7ZXSojVETg02dFeS8VtDpcEwkPwa///ixzDt2lf92Cbh+R2Sx1iFWvFsdBaCZDj929c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lnkK7fA7; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719738716; bh=j4nZJ30e87StHskzMgAYoeekGmN/efAr1X8jXLvUZ1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lnkK7fA7r4aS0el4fTgJQ4xLuHDjlohF1Jx6MdeDGgTmck0qebRvY/SLYYeOclf04
	 l2EuIk06iwhbWDoalA2+Pm/Ga8mrBrpet0kKZ2ixkXrK71jJ4JyuEFWByclS/SR0Dy
	 Q+Ofm+8TJ33KeZ3ZHTS4XOY0vuvYBYQPnytoQAOQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 269A8038; Sun, 30 Jun 2024 17:09:41 +0800
X-QQ-mid: xmsmtpt1719738581tymvkb127
Message-ID: <tencent_17CBBA43BB47335B9E931B5D4BD11B062508@qq.com>
X-QQ-XMAILINFO: NY/MPejODIJVSyOQupuGHmL6ioAjaQbfhBwMCtYfTZVgLwBqmA5G3wsYsPTPTc
	 WjUd2GEQIe52oNZN99u3HUMIPz5eXvE+kWdxoLsVBhjyHU3S0kHtL1mW2BsP32oMQZgLKRxm6n31
	 6+Oi4Wwzm58PUT026GSIY7abY/yZvhruFsvcNlQn6Ml1slsGnxuF26QLOcyrhlOYW35Zl0Lc2ZIO
	 x2EBbV30tOM9Vljn8ymXEKbeDxaFN4YQUDCBVnrufw6kczcqOa3+NkMvnEGyYSHWHnTuuqeGDw0r
	 322BoI45poRpxfPFpqVJjQCwLyll3UoSCVrKga3bSqOnGcfMEd10pZvZkfrELgKqr8PlXeb5bqjM
	 J9zapCfKwT9X99nOGszp1zBPqEiQsPSQFdhLAOKIR4e1++MiRUsmfANUglT/J5NgkavXyWugvzNz
	 XtlFZbnA9DYsYjAwpynUujxYpgoyna7zrT4e5IZtm6BgicdvN4OAVWM1dFVMM/SFIG1pZJJ2Xyei
	 gk5R9spSe/Xp2idvAhT04MnsAEeVjdY947VtE7zhvsLgCbfPusy0YyykHF7qYEmzarPZ8ODNbNEl
	 /WKlYn8IbXYPNaBk63UkWXlFKctHMXsDUebOfdGRaY5uVSo0DENSm0+tN8gUzHaDuBPlsad/uX3l
	 gU26LF72FwLMIEJcpNk/WYZTAmaBH+y2XNLrE3QnuJtTy3tucYEN4dxGvDFXiaAsf8OHWfZOorwc
	 m+T14GAij2VT4msxVPOYkIqjHKG9zxTC7eZXfGlqJTjWwnufAmfvwVOzWMBLINlwJwnHPWtvGBmD
	 UUQkYRsU7CYAfqlX+Sxw5L6eVkA60PDpINf+ZLKPP9PD/dri6B3UtUvi4T2y9J+HNhcLsATOJ7Zp
	 rfL1ROjkxrjl0C5Tm6e/o8YxUcI9GRKg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [ext4?] BUG: unable to handle kernel paging request in do_split
Date: Sun, 30 Jun 2024 17:09:42 +0800
X-OQ-MSGID: <20240630090941.2411923-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000075a135061c0480d0@google.com>
References: <00000000000075a135061c0480d0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if split is too small, such as 0, use it to calculate continued will out of bound map

#syz test: upstream 55027e689933

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a630b27a4cc6..0a111274dc4a 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2043,7 +2043,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 		split = count/2;
 
 	hash2 = map[split].hash;
-	continued = hash2 == map[split - 1].hash;
+	continued = split > 0 ? hash2 == map[split - 1].hash : 0;
 	dxtrace(printk(KERN_INFO "Split block %lu at %x, %i/%i\n",
 			(unsigned long)dx_get_block(frame->at),
 					hash2, split, count-split));


