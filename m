Return-Path: <linux-kernel+bounces-359151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFB998815
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A5B1C213F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F21BDA90;
	Thu, 10 Oct 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaCDxwLd"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6134A1BC9EE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567850; cv=none; b=eneekY8g8DwwKX1+hsB/bXBQUXMqiYTfT3Jk0+RDRCCi5tktsjnVfsGZX5HeGZZi6LZbz6B3YcqoIVWMASM1mSlJc0UFO4H2eOqjHt/0LUGoZ7a9l2cCJRrSU7dDkOhoRcobwFOpvWlVnwkZXDR8idVBuxULJBHc/sZVxsWmqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567850; c=relaxed/simple;
	bh=xaGjUnViZSpjo8sq0YQ3PVO4ibwxxVApYoNjX9S4dwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V8dHDA3LNnCshy+t4aom/RctuGcwFrsoB4g9+BUsVsQfShW9+om0yqLHx92eyO/d4WsgYzAenW15bBpDHlxRMcNmFokOuFM7PjeGA49z3rWxH/3QX1zgRYmBeXvTIlsMWLT+2JivQyZIVY7lf6uaxZMdqJ0uaE36OB474qjsqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaCDxwLd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e01eff831so712458b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728567849; x=1729172649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZYsBI4rHRPGslnn0OIAOPnwZIxsjJhLtfW4Z5UU62w=;
        b=iaCDxwLdBB2+XEZvwhRrskc5NzMNP078ci5vLkMHLYmlWa9qY+KfJoz8bgOTOSnl3M
         T4p3sFGdqlxvLOAZ2d9WEmcRqG5q2VYJsJLbBOuDL2VAi8FClUSDFF0AJZ+2QOKhKAOp
         19GuePhOBK4uTOal3o78gOASNmOO2swPTwpXR9q6354+2MndSaE7ScBG2JdfL55YjtOd
         J7GsKzy9oEx0h5pDpNGEb6siyxjt7XbOs2ZsRBQ1psdaryvuSoAfySiHjXxlpTRbt0J2
         Zee0ETc/LHZdlllcxcGVBVu7s5hdThxu6SqzVkeWt4usJygwf3ZE3vvYIU6GMt/PdbyA
         gS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567849; x=1729172649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZYsBI4rHRPGslnn0OIAOPnwZIxsjJhLtfW4Z5UU62w=;
        b=oQRsfQdyYCym/Q5Nkm+WTA+yXU5Sf2FPssZAsGpW0Os4FX3KDGBxLX4Bj22pmiUSPL
         LA6CU7kiWhK/iqCOkieITkmYlm7VE7vp6HlWmj2HY/jK+/cke1PfAu4IvpljhWqR0+wY
         Y17IIGwvfO2jCyxac9FPR+YzaKyEEZlrOPsFcZ6AW2PqEDw7QS9qi1tKT/yYsaAzA40E
         KRY3I9AVOhNkaFXwjvHxGqcuzHjDK9Cr64Ry5WxwabsQen4I0nwMhTm/aK+3Q5qwi+s+
         MJINBvLhwgX2Th4Jqw5sitC0/p+xhc92thQhuev9+hoZg2NdY5m/HjFRXJg//vkctxkK
         GfSA==
X-Forwarded-Encrypted: i=1; AJvYcCX+tRbodniiBnAQz9uPI/syDTzISv9dIx/h8wyO2T7N18tQN6ZUtXbrhPGUrTO6HwrFYxoErXSWsKpD0J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHW9RxGTeRHP//pmf+6G81+ThT1o/5R2lpPW9qgAenBnVPK6hy
	u/sUXG/xyAkRz3tz3uPwit1PZGYRdOdOvJprUcfynzjpBSrlHKUx
X-Google-Smtp-Source: AGHT+IFDRhRD26iK9dbGob0ICijU5Wrp2L8RYyhXI1JN9HjKNoxD2M9E1WTsM6tZ6EDS/EKycS/+Og==
X-Received: by 2002:a05:6a00:cc2:b0:71e:a3:935b with SMTP id d2e1a72fcca58-71e1dbcab26mr10435507b3a.25.1728567848504;
        Thu, 10 Oct 2024 06:44:08 -0700 (PDT)
Received: from dell-xps.. ([2405:201:3036:a902:cb38:efef:96cc:3acf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e95f9sm1034508b3a.39.2024.10.10.06.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:44:08 -0700 (PDT)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: shaggy@kernel.org,
	osmtendev@gmail.com,
	ghandatmanas@gmail.com,
	eadavis@qq.com,
	ghanshyam1898@gmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix array-index-out-of-bounds in dtInsertEntry
Date: Thu, 10 Oct 2024 19:13:51 +0530
Message-Id: <20241010134351.1884580-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of p->header.freelist can be less than zero which
causes an error in dtInsertEntry. Added a check in dtInsert
to address it.

Reported-by: syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5f7f0caf9979e9d09ff8
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 fs/jfs/jfs_dtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 5d3127ca68a4..51bb3e14551b 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -834,7 +834,7 @@ int dtInsert(tid_t tid, struct inode *ip,
 	 * the full page.
 	 */
 	DT_GETSEARCH(ip, btstack->top, bn, mp, p, index);
-	if (p->header.freelist == 0)
+	if (p->header.freelist <= 0)
 		return -EINVAL;
 
 	/*
-- 
2.34.1


