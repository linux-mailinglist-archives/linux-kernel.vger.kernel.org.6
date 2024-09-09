Return-Path: <linux-kernel+bounces-320603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21782970CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD901F224EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4F1AC8AD;
	Mon,  9 Sep 2024 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcgqcxP3"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C01DA26
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725855299; cv=none; b=q25+C/C3SEauGMS8TiBrmZrcR2N4oxw1POROH0s+K0rO7/5U+Tw4fh8Qj+T0DIY+OjfJWnuV72DhUyvSHYE1GkILRZMjg/wl//moSKM4VJztzlS7jwVwtycjtkGvdGlPu4vjMm2oGC4/S7nFcCZ3zBfkqOWbTtUfhuMT0WOSKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725855299; c=relaxed/simple;
	bh=iDOBJvjYerLoJFU3XA583JOfDG/o+TB80A8346WHUJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hw+ZrG2YmcRB0sz9V+Bi/0Iul4AZvhmC+Xj37gWHA899SYfYnqVt1wURqzUBYcCQtDnwc+FLiCG6aNAlLm+bayBdFBlR835NZeJSN6nGr/kpv/UuYyeSbOvSMRnXLtcqQuPAyP5QpsL805ycxpH3xPgHg5CeWJptBZwZ1+HfCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcgqcxP3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718ef6a26dbso160860b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 21:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725855297; x=1726460097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoGm47A6uDXokO5FjgQ8D6E0GeUc128l+0FCXA/X69g=;
        b=KcgqcxP3VLisqlnVEApoWGPTd2a+Vd1wYGzdjO0wUB0+0QsLlhlXmjCHl9YvnreNld
         NSwSN0c3mpIcts1DCPwzRPu46my/QapQDO6FQGjzV6KXeibahZfAcon/a3YgxiM7xOrF
         foMwnpZROXeFIC8FxEhS6gRhdbd8caam7tb5vQhICSKsvXV+49o9NwDP0oJaT28v28GV
         bsg5LaTibgYhLdzzcQ8O+kbAGrHDHh195Umpb9Rkh1EUanN3HiGH7zQSJ0YUKKLPg/og
         Obq6F9xoDkH5q+8aIl61l9HcK4d7EYWOn1L7rN81gbBoJkKW0Dyj5UN1oTneoNSWtsDX
         DmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725855297; x=1726460097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoGm47A6uDXokO5FjgQ8D6E0GeUc128l+0FCXA/X69g=;
        b=IjmY4+0ZWBgbSccRSuf/O5Rea7f2YnPPFIwFIzJBIHI7GbFe4975z0axqKWYEZqJNg
         wTFkSM1CGZXi8X+Pbi2QC23vkQA+nlha3hG4svkFOvPfrS+iWOTmRYUfuZMdhC+4YgLc
         GI/FMJcU2yXEK7pEHZuzSVejK4Po47ubyRBa+6PvyRhicEc5A28MGU96j8pIieCHK062
         i6n9e20GorqPkiB2D6+ZHMYVOb/GM9rrSz/Z7JwWin6W/1fVo/C2KX1zXaw7gkIzeeM6
         6/N5qn41UAuNGRSfVjmq8DmgpLQSZBzp8kqY1H/7gELAW22pVop4na8txOqXYlh08jMb
         Rnyw==
X-Forwarded-Encrypted: i=1; AJvYcCUUAfCf2XhHTiQr2m3LAUozWd5qe35rOb0Lvyo/oF9tGDfigbJQZuaGtloxXp6qLq6Y1OqDkgxI6KYMYtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxLH9MqHvyzY1C/v5PqdG0tBSySVGIjNwZPV/5xEzMmgcTxvU
	PG25izaVGGkQxwOH2u/rP1WfaEJ1O8dUf+8xr5PglNrxrkhumH2gqjtD/oM+
X-Google-Smtp-Source: AGHT+IEBxC0qBl2mXynuvBAa5NyLBG8S2V3uRM5H/KyUmfOYcMhIGSRfaEIdVLH3BZ5aGN0XKGsj2A==
X-Received: by 2002:a05:6a20:3944:b0:1cf:37d4:c4f6 with SMTP id adf61e73a8af0-1cf37d4cc66mr1686938637.4.1725855296782;
        Sun, 08 Sep 2024 21:14:56 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e33930sm25755605ad.102.2024.09.08.21.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 21:14:56 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] staging: rtl8723bs: include: Fix spelling mistake in rtw_xmit.h
Date: Mon,  9 Sep 2024 09:58:52 +0545
Message-Id: <20240909041352.2392-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spelling mistake to increase code readability
and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
v2: Created patch series as suggested by Phillip
v1: https://lore.kernel.org/all/20240906141024.10021-1-topofeverest8848@gmail.com/

 drivers/staging/rtl8723bs/include/rtw_xmit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
index a3b4310caddf..544468f57692 100644
--- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
@@ -15,7 +15,7 @@
 
 #define XMITBUF_ALIGN_SZ 512
 
-/*  xmit extension buff defination */
+/*  xmit extension buff definition */
 #define MAX_XMIT_EXTBUF_SZ	(1536)
 #define NR_XMIT_EXTBUFF	(32)
 
-- 
2.34.1


