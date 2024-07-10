Return-Path: <linux-kernel+bounces-246804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D542792C6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6658D2819B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2510F1;
	Wed, 10 Jul 2024 00:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="VeS5qrJW"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA5A32
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570385; cv=none; b=WICUyYQkAHidCs9k7ucpw43DjrfXJMqhUDW9/6r+Kzm0iNLXSobxhnY+urtbkMbJ0uDPZNRExOWZbomwMNHcCA68BuEexp1cz3Wid5RSGdx9QcnH2HDA0Oknz1quRuxYzFXqdp7i/xMG43vpmC/yWr4z+mNu9wSHPKEJYIpudwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570385; c=relaxed/simple;
	bh=Lxs17QnPWqide1kuu3+MFXHOtxROAxydfMblGjRRX3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xs00EOHu9agkjOCTjDEIvUuzGw7ZSOAvtzpyzDIEt1ntOcHmt/9Qqm/XBagJkXN2M46nVOti/7TMHicKNEGNn0XspvDLl6vhrZvaWDyFpTyc8vUZQYHX1t5HaU1DzFPcg3CMUclSon1Swe5gWzmsjaHnCZXaKqNpM1Zr46ddAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=VeS5qrJW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb0d88fd25so1809435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 17:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1720570383; x=1721175183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tSpW7AqjpwQU1YZlBwSC0jTPvLt58lOmnA2ZeLiWhSk=;
        b=VeS5qrJW6hwIqh0g9jlMAJ2L49ZwfDmD5C4fpmz4faMOwe5B/LUwS9EM9k+TbRSd/n
         WxvfM6TggK3Yw5BetpO8LL22/eMkK+qR+OLguYkC0J9lcjY+rAoCMismMISjmbIEaoN1
         6FkYEYmxk9sfr2vbKO3sHxbLbsg0WChhzR5U0P2YmXbActDcQjKT3wgomN4WSfL2Q9a2
         AvAjBkJ3aJ4TU2qcZRZCFeLJP2gsvlvNdKurbiZBa/eKVsPDhoa8Mt5nqIXL5K074J2L
         eTT+y72gLOCNEEn+VJRCcMumYxFU4R8ptpHa8JyCXhk+GGt4VWWgutU8dCIbP5QNKt6X
         vMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720570383; x=1721175183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSpW7AqjpwQU1YZlBwSC0jTPvLt58lOmnA2ZeLiWhSk=;
        b=hClOHPKJpa31crn7zQNBStne+LZ5gqJV4xy7FB98UyyNa6qNSjr79xqaz9dN7im/rI
         F17kgWZm4H+3YX6615AiFESfbH+GVhv+APY5vv5GdSPqhhZbEU0t6GCGjRKrYfIxkwzs
         ILv8dhWOogiG95osexoAhB9pVw43rLJ11IuF9y2APW+FdgWPviiPH1OjMxtvpTUcl0cN
         QhUojSEUKVkf5l20H9wq7SOks8wsn1j7p4MXwlWqQOeV45Q01MSGc2SsTxIPyRHDu1Y7
         ePhCuHkDJNH7MQn1k0CdWcS678E/bJ+n4jkDGcQ1W9riqsazTE8yX6onykGWvTOG3bXL
         kX3A==
X-Forwarded-Encrypted: i=1; AJvYcCXx0JnZiiMhNuB1xEnnQAXWg/njaWWHfjWbEUmyODGmnpjop1xYv7AGgJc9LJ08r9+HySc8sK0EsHTusf4d5FZIzH0c37xVpte/AZZp
X-Gm-Message-State: AOJu0Ywsma8AhmdTLfAIq/kQPtc5UIVVrIyZhiCiSI249Z+HlOYRVRVr
	cYtOKTDGoocaQ36O8iRgZMFew8wWAYYdutaUu8MQd3hV+yUBycHfPrcd/JiNrRU=
X-Google-Smtp-Source: AGHT+IFZ+U0vwKEkq0hOtvZ5jJDsUtmCIT4kTMkBa1V9TXiL/6L8Y3rUPlhGyo845hlJfZURvkiEMA==
X-Received: by 2002:a17:902:f7d1:b0:1f8:62a1:b6af with SMTP id d9443c01a7336-1fbb8019531mr41100765ad.21.1720570383350;
        Tue, 09 Jul 2024 17:13:03 -0700 (PDT)
Received: from alpha.mshome.net (ip68-4-168-191.oc.oc.cox.net. [68.4.168.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a34f9esm21740765ad.114.2024.07.09.17.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 17:13:02 -0700 (PDT)
From: Remington Brasga <rbrasga@uci.edu>
To: Dave Kleikamp <shaggy@kernel.org>,
	Manas Ghandat <ghandatmanas@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Andrew Kanner <andrew.kanner@gmail.com>,
	Osama Muhammad <osmtendev@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+e38d703eeb410b17b473@syzkaller.appspotmail.com,
	Remington Brasga <rbrasga@uci.edu>
Subject: [PATCH] jfs: UBSAN: shift-out-of-bounds in dbFindBits
Date: Wed, 10 Jul 2024 00:12:44 +0000
Message-Id: <20240710001244.2707-1-rbrasga@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issue with UBSAN throwing shift-out-of-bounds warning.

Reported-by: syzbot+e38d703eeb410b17b473@syzkaller.appspotmail.com
Signed-off-by: Remington Brasga <rbrasga@uci.edu>
---
When nb = 32, `mask = mask >> nb` or shorthand `mask >>= nb` throws
shift-out-of-bounds warning.
`mask = (mask >> nb)` removes that warning. 

Link to the syzbot bug report: https://lore.kernel.org/all/0000000000006fc563061cbc7f9c@google.com/T/

 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..636aae946e84 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3020,7 +3020,7 @@ static int dbFindBits(u32 word, int l2nb)
 
 	/* scan the word for nb free bits at nb alignments.
 	 */
-	for (bitno = 0; mask != 0; bitno += nb, mask >>= nb) {
+	for (bitno = 0; mask != 0; bitno += nb, mask = (mask >> nb)) {
 		if ((mask & word) == mask)
 			break;
 	}
-- 
2.34.1


